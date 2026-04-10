import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, void>> call(String phoneNumber, String password) {
    return repository.login(phoneNumber, password);
  }
}
