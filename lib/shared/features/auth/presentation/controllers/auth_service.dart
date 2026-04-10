import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/service/local_data_service/local_data_manager.dart';
import '../../../../../core/service/webservice/api_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthService {
  final LocalDataManager _localDataManager;
  final AuthRepository _authRepository;
  final Logger _logger;

  UserEntity? _currentUser;

  AuthService({
    required LocalDataManager localDataManager,
    required AuthRepository authRepository,
    Logger? logger,
  }) : _localDataManager = localDataManager,
       _authRepository = authRepository,
       _logger = logger ?? Logger();

  bool get isAuthenticated {
    final token = _localDataManager.getToken();
    return token != null && token.isNotEmpty;
  }

  String? get currentUserRole {
    return _localDataManager.getUserRole();
  }

  String? get currentToken {
    return _localDataManager.getToken();
  }

  UserEntity? get currentUser => _currentUser;

  /// Login with phone, password, and user type
  Future<Either<Failure, AuthResponseEntity>> login({
    required String phone,
    required String password,
    required String userType,
  }) async {
    try {
      _logger.d('AuthService: Attempting login for $phone as $userType');

      final result = await _authRepository.login(
        phone: phone,
        password: password,
        userType: userType,
      );

      return result.fold(
        (failure) {
          _logger.e('AuthService: Login failed - ${failure.message}');
          return Left(failure);
        },
        (authResponse) {
          _logger.d('AuthService: Login successful');

          // Save user data
          _localDataManager.setToken(authResponse.token);
          _localDataManager.setUserRole(authResponse.userType);
          _localDataManager.setIsLoggedIn(true);
          _localDataManager.setUserId(authResponse.user.id);
          _localDataManager.setUserName(authResponse.user.name);
          _localDataManager.setUserEmail(authResponse.user.email);
          _currentUser = authResponse.user;

          return Right(authResponse);
        },
      );
    } catch (e, stackTrace) {
      _logger.e('AuthService: Login error', error: e, stackTrace: stackTrace);
      return Left(UnknownFailure('Login failed: $e'));
    }
  }

  /// Logout current user
  Future<Either<Failure, void>> logout() async {
    try {
      _logger.d('AuthService: Logging out');

      // Call logout API to invalidate token on server
      final logoutResult = await _authRepository.logout();

      logoutResult.fold(
        (failure) {
          _logger.w(
            'AuthService: Logout API call failed: ${failure.message}, but continuing with local logout',
          );
        },
        (success) {
          _logger.d(
            'AuthService: Logout API call successful - Token invalidated on server',
          );
        },
      );

      // Always clear local data regardless of API call result
      await _clearLocalAuthData();

      _logger.d('AuthService: Logout completed successfully');
      return const Right(null);
    } catch (e, stackTrace) {
      _logger.e('AuthService: Logout error', error: e, stackTrace: stackTrace);

      // Still clear local data even if there's an error
      await _clearLocalAuthData();
      return const Right(null);
    }
  }

  /// Clear all local authentication data
  Future<void> _clearLocalAuthData() async {
    try {
      await _localDataManager.clearToken();
      await _localDataManager.clearUserRole();
      await _localDataManager.setIsLoggedIn(false);
      _currentUser = null;

      _logger.d('AuthService: Local authentication data cleared');
    } catch (clearError) {
      _logger.e('AuthService: Error clearing local data: $clearError');
    }
  }

  /// Get current user from API
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      _logger.d('AuthService: Fetching current user');

      final result = await _authRepository.getCurrentUser();

      return result.fold(
        (failure) {
          _logger.e(
            'AuthService: Get current user failed - ${failure.message}',
          );
          return Left(failure);
        },
        (user) {
          _logger.d('AuthService: Current user fetched successfully');
          _currentUser = user;
          return Right(user);
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        'AuthService: Get current user error',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(UnknownFailure('Failed to get current user: $e'));
    }
  }

  /// Register new technician
  Future<Either<Failure, UserEntity>> registerTechnician({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      _logger.d('AuthService: Registering technician $email');

      final result = await _authRepository.register(
        email: email,
        password: password,
        name: name,
        userType: 'technician',
        phone: phone,
      );

      return result.fold(
        (failure) {
          _logger.e('AuthService: Registration failed - ${failure.message}');
          return Left(failure);
        },
        (authResponse) {
          _logger.d('AuthService: Registration successful');

          // Save user data
          _localDataManager.setToken(authResponse.token);
          _localDataManager.setUserRole(authResponse.userType);
          _localDataManager.setIsLoggedIn(true);
          _currentUser = authResponse.user;

          return Right(authResponse.user);
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        'AuthService: Registration error',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(UnknownFailure('Registration failed: $e'));
    }
  }

  Future<bool> refreshToken() async {
    try {
      // TODO: Implement token refresh
      return true;
    } catch (e) {
      return false;
    }
  }
}

// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(apiService: getIt<ApiService>());
});

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    localDataManager: getIt<LocalDataManager>(),
    authRepository: ref.read(authRepositoryProvider),
  );
});
