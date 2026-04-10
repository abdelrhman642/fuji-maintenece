import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String fullName,
    required String phoneNumber,
    required String password,
    String? email,
    String? address,
  }) {
    return repository.register(
      fullName: fullName,
      phoneNumber: phoneNumber,
      password: password,
      email: email,
      address: address,
    );
  }
}
