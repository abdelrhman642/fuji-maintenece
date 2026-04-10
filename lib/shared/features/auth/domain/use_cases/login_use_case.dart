import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<AuthResponseEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(LoginParams params) async {
    return await repository.login(
      phone: params.phone,
      password: params.password,
      userType: params.userType,
    );
  }
}

class LoginParams {
  final String phone;
  final String password;
  final String userType;

  LoginParams({
    required this.phone,
    required this.password,
    required this.userType,
  });
}
