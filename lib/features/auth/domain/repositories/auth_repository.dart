import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String phoneNumber, String password);
  Future<Either<Failure, void>> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    String? email,
    String? address,
  });
}
