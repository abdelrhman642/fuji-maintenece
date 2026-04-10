import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/exceptions.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_project/features/home/domain/entities/client_entity.dart';
import 'package:flutter_project/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ClientEntity>> findClientByRegistrationNumber(
    String registrationNumber,
  ) async {
    try {
      final result = await remoteDataSource.findClientByRegistrationNumber(
        registrationNumber,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on NetworkException {
      return Left(NetworkFailure('Network Error'));
    }
  }
}
