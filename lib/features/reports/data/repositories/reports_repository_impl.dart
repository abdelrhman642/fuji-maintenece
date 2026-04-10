import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/exceptions.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/reports/data/datasources/reports_remote_data_source.dart';
import 'package:flutter_project/features/reports/domain/repositories/reports_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReportsRepository)
class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsRemoteDataSource remoteDataSource;

  ReportsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> sendCrashReport({
    required String notes,
    required File image,
  }) async {
    try {
      final result = await remoteDataSource.sendCrashReport(
        notes: notes,
        image: image,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on NetworkException {
      return Left(NetworkFailure('Network Error'));
    }
  }
}
