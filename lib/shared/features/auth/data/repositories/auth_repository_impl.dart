import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../../core/config/api_path.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/service/webservice/api_service.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/profile_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';
import '../models/logout_response_model.dart';
import '../models/profile_response_model.dart';
import '../models/update_profile_request_model.dart';
import '../models/user_model.dart';

/// Implementation of AuthRepository using API
class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  final Logger _logger;
  AuthRepositoryImpl({required ApiService apiService, Logger? logger})
    : _apiService = apiService,
      _logger = logger ?? Logger();
  @override
  Future<Either<Failure, AuthResponseEntity>> login({
    required String phone,
    required String password,
    required String userType,
  }) async {
    try {
      final requestModel = LoginRequestModel(
        phone: phone,
        password: password,
        userType: userType,
      );
      _logger.d('Login request: ${requestModel.toJson()}');

      final response = await _apiService.post(
        url: ApiPath.login,
        requestBody: requestModel.toJson(),
        returnDataOnly:
            false, // Get the full response, not just the 'data' field
      );
      _logger.d('Login response: $response');
      return response.fold(
        (failure) {
          if (failure.message.contains('inactive')) {
            return Left(AccountNotActivatedFailure(failure.message));
          }
          return Left(failure);
        },
        (data) {
          try {
            // The API returns the auth data directly, not wrapped in a data field
            final authResponse = AuthResponseModel.fromJson(data);
            // Convert to entity
            final authEntity = AuthResponseEntity(
              message: authResponse.message,
              userType: authResponse.userType,
              user: _mapUserModelToEntity(authResponse.user),
              token: authResponse.token,
              refreshToken: '', // Backend doesn't provide refresh token yet
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            );
            return Right(authEntity);
          } catch (e) {
            _logger.e('Error parsing auth response: $e');
            return Left(
              ServerFailure('Failed to parse authentication response'),
            );
          }
        },
      );
    } on DioException catch (e) {
      _logger.e('Login DioException: ${e.message}', error: e);

      if (e.response?.statusCode == 401) {
        return Left(AuthFailure('Invalid email or password'));
      }

      return Left(NetworkFailure(e.message ?? 'Network error occurred'));
    } catch (e, stackTrace) {
      _logger.e('Login error: $e', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> register({
    required String email,
    required String password,
    required String name,
    required String userType,
    required String phone,
  }) async {
    try {
      // Only technicians can register via the app
      if (userType != 'technician') {
        return Left(
          ValidationFailure('Only technicians can register through the app'),
        );
      }

      final requestModel = RegisterTechnicianRequestModel(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: password,
        phone: phone,
        // specialty: null,
      );

      _logger.d('Register request: ${requestModel.toJson()}');

      final response = await _apiService.post(
        url: ApiPath.register,
        requestBody: requestModel.toJson(),
        returnDataOnly: false,
      );

      _logger.d('Register response: $response');

      return response.fold((failure) => Left(failure), (data) {
        final apiResponse = AuthResponseModel.fromJson(
          data as Map<String, dynamic>,
        );

        if (apiResponse.token.isEmpty) {
          if (apiResponse.user.status != 'active') {
            return Left(AccountNotActivatedFailure(apiResponse.message));
          }
          return Left(ServerFailure(apiResponse.message));
        }

        final authResponse = apiResponse;

        final authEntity = AuthResponseEntity(
          message: authResponse.message,
          userType: authResponse.userType,
          user: _mapUserModelToEntity(authResponse.user),
          token: authResponse.token,
          refreshToken: '',
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        );

        return Right(authEntity);
      });
    } on DioException catch (e) {
      _logger.e('Register DioException: ${e.message}', error: e);

      return Left(NetworkFailure(e.message ?? 'Network error occurred'));
    } catch (e, stackTrace) {
      _logger.e('Register error: $e', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      _logger.d('Logout request');

      final response = await _apiService.post(
        url: ApiPath.logout,
        returnDataOnly: false, // Get the full response to handle the message
      );
      _logger.d('Logout response: $response');
      return response.fold(
        (failure) {
          _logger.e('Logout failed: ${failure.message}');
          // Even if logout fails on server, we can still clear local data
          return const Right(null);
        },
        (data) {
          try {
            final logoutResponse = LogoutResponseModel.fromJson(data);
            _logger.d(
              'Logout successful - Server response: ${logoutResponse.message}',
            );
            // The API returns: {"message": "Logged out successfully"}
            // This confirms the token has been invalidated on the server
            return const Right(null);
          } catch (e) {
            _logger.e('Error parsing logout response: $e');
            // Still consider logout successful even if parsing fails
            return const Right(null);
          }
        },
      );
    } on DioException catch (e) {
      _logger.e('Logout DioException: ${e.message}', error: e);

      if (e.response?.statusCode == 401) {
        _logger.d('Logout: Token already expired or invalid');
        // Token was already expired, which is expected behavior
        return const Right(null);
      }
      // Even if logout fails on server, we can still clear local data
      return const Right(null);
    } catch (e, stackTrace) {
      _logger.e('Logout error: $e', error: e, stackTrace: stackTrace);
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> refreshToken() async {
    // TODO: Implement when backend provides refresh token endpoint
    return Left(UnknownFailure('Refresh token not implemented yet'));
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      _logger.d('Get current user request');

      final response = await _apiService.get(
        url: ApiPath.profile,
        returnDataOnly:
            false, // Get the full response, not wrapped in data field
      );
      _logger.d('Get current user response: $response');
      return response.fold((failure) => Left(failure), (data) {
        try {
          _logger.d('Raw get current user data received: $data');
          _logger.d('Data type: ${data.runtimeType}');

          // The API returns the profile data directly, not wrapped in a data field
          final profileResponse = ProfileResponseModel.fromJson(data);
          // Convert to UserEntity using the same mapping as getProfile
          final userEntity = _mapUserProfileModelToEntity(profileResponse.user);
          return Right(userEntity);
        } catch (e) {
          _logger.e('Error parsing get current user response: $e');
          return Left(
            ServerFailure('Failed to parse get current user response'),
          );
        }
      });
    } on DioException catch (e) {
      _logger.e('Get current user DioException: ${e.message}', error: e);

      if (e.response?.statusCode == 401) {
        return Left(AuthFailure('Session expired. Please login again.'));
      }
      return Left(NetworkFailure(e.message ?? 'Network error occurred'));
    } catch (e, stackTrace) {
      _logger.e('Get current user error: $e', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, ProfileResponseEntity>> getProfile() async {
    try {
      _logger.d('Get profile request');

      final response = await _apiService.get(
        url: ApiPath.profile,
        returnDataOnly:
            false, // Get the full response, not wrapped in data field
      );
      _logger.d('Get profile response: $response');
      return response.fold((failure) => Left(failure), (data) {
        try {
          _logger.d('Raw profile data received: $data');
          _logger.d('Data type: ${data.runtimeType}');

          // The API returns the profile data directly, not wrapped in a data field
          final profileResponse = ProfileResponseModel.fromJson(data);

          // Convert to entity
          final profileEntity = ProfileResponseEntity(
            userType: profileResponse.userType,
            user: _mapUserProfileModelToEntity(profileResponse.user),
          );
          return Right(profileEntity);
        } catch (e) {
          _logger.e('Error parsing profile response: $e');
          return Left(ServerFailure('Failed to parse profile response'));
        }
      });
    } on DioException catch (e) {
      _logger.e('Get profile DioException: ${e.message}', error: e);

      if (e.response?.statusCode == 401) {
        return Left(AuthFailure('Session expired. Please login again.'));
      }
      return Left(NetworkFailure(e.message ?? 'Network error occurred'));
    } catch (e, stackTrace) {
      _logger.e('Get profile error: $e', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, ProfileResponseEntity>> updateProfile({
    String? name,
    String? phone,
    String? email,
    String? location,
    double? longitude,
    double? latitude,
  }) async {
    try {
      _logger.d('Update profile request');

      final requestModel = UpdateProfileRequestModel(
        name: name,
        phone: phone,
        email: email,
        location: location,
        longitude: longitude,
        latitude: latitude,
      );
      _logger.d('Update profile request data: ${requestModel.toJson()}');

      final response = await _apiService.put(
        url: ApiPath.updateProfile,
        requestBody: requestModel.toJson(),
        returnDataOnly: false, // Get the full response
      );
      _logger.d('Update profile response: $response');
      return response.fold((failure) => Left(failure), (data) {
        try {
          _logger.d('Raw update profile data received: $data');
          _logger.d('Data type: ${data.runtimeType}');
          // The API returns the profile data directly, not wrapped in a data field
          final profileResponse = ProfileResponseModel.fromJson(data);
          // Convert to entity
          final profileEntity = ProfileResponseEntity(
            userType: profileResponse.userType,
            user: _mapUserProfileModelToEntity(profileResponse.user),
          );
          return Right(profileEntity);
        } catch (e) {
          _logger.e('Error parsing update profile response: $e');
          return Left(ServerFailure('Failed to parse update profile response'));
        }
      });
    } on DioException catch (e) {
      _logger.e('Update profile DioException: ${e.message}', error: e);
      if (e.response?.statusCode == 401) {
        return Left(AuthFailure('Session expired. Please login again.'));
      }
      return Left(NetworkFailure(e.message ?? 'Network error occurred'));
    } catch (e, stackTrace) {
      _logger.e('Update profile error: $e', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      _logger.d('Delete account request');
      final response = await _apiService.delete<void>(
        url: ApiPath.deleteAccount,
        returnDataOnly: false,
      );
      _logger.d('Delete account response: $response');
      return response.fold(
        (failure) => Left(failure),
        (data) => const Right(null),
      );
    } on DioException catch (e) {
      _logger.e('Delete account DioException: ${e.message}', error: e);

      if (e.response?.statusCode == 401) {
        return Left(AuthFailure('Session expired. Please login again.'));
      }
      return Left(NetworkFailure(e.message ?? 'Network error occurred'));
    } catch (e, stackTrace) {
      _logger.e('Delete account error: $e', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    // TODO: Implement when backend provides forgot password endpoint
    return Left(UnknownFailure('Forgot password not implemented yet'));
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // TODO: Implement when backend provides reset password endpoint
    return Left(UnknownFailure('Reset password not implemented yet'));
  }

  /// Helper method to convert UserModel to UserEntity
  UserEntity _mapUserModelToEntity(UserModel model) {
    return UserEntity(
      id: model.id.toString(),
      email: model.email,
      name: model.name,
      phone: model.phone,
      status: model.status,
      image: model.image,
      location: model.location,
      longitude: model.longitude,
      latitude: model.latitude,
      phoneVerifiedAt: model.phoneVerifiedAt,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  /// Helper method to convert UserProfileModel to UserEntity
  UserEntity _mapUserProfileModelToEntity(UserProfileModel model) {
    return UserEntity(
      id: model.id.toString(),
      email: model.email,
      name: model.name,
      phone: model.phone,
      status: model.status,
      image: model.image,
      location: model.location,
      longitude: model.longitude,
      latitude: model.latitude,
      phoneVerifiedAt: model.phoneVerifiedAt,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
