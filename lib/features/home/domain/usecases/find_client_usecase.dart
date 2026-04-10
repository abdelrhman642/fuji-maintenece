import 'package:dartz/dartz.dart';
import 'package:flutter_project/core/error/failures.dart';
import 'package:flutter_project/features/home/domain/entities/client_entity.dart';
import 'package:flutter_project/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FindClientUseCase {
  final HomeRepository repository;

  FindClientUseCase(this.repository);

  Future<Either<Failure, ClientEntity>> call(String registrationNumber) {
    return repository.findClientByRegistrationNumber(registrationNumber);
  }
}
