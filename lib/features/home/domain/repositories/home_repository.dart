import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/home/domain/entities/client_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, ClientEntity>> findClientByRegistrationNumber(
    String registrationNumber,
  );
}
