import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/shared/features/auth/domain/entities/profile_response_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/auth_response_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> login({
    required String phone,
    required String password,
    required String userType,
  });

  Future<Either<Failure, AuthResponseEntity>> register({
    required String email,
    required String password,
    required String name,
    required String userType,
    required String phone,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, AuthResponseEntity>> refreshToken();

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, ProfileResponseEntity>> getProfile();

  Future<Either<Failure, ProfileResponseEntity>> updateProfile({
    String? name,
    String? phone,
    String? email,
    String? location,
    double? longitude,
    double? latitude,
  });

  Future<Either<Failure, void>> deleteAccount();

  Future<Either<Failure, void>> forgotPassword(String email);

  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  });
}
