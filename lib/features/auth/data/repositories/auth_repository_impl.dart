import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/exceptions.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:flutter_project/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:flutter_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, void>> login(
    String phoneNumber,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.login(phoneNumber, password);
      // await localDataSource.cacheToken(result.token); // Assuming login returns a token
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on NetworkException {
      return Left(NetworkFailure('Network Error'));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    String? email,
    String? address,
  }) async {
    try {
      final result = await remoteDataSource.register(
        fullName: fullName,
        phoneNumber: phoneNumber,
        password: password,
        email: email,
        address: address,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on NetworkException {
      return Left(NetworkFailure('Network Error'));
    }
  }
}
