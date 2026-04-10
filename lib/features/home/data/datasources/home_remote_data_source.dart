import 'package:flutter_project/features/home/domain/entities/client_entity.dart';

abstract class HomeRemoteDataSource {
  Future<ClientEntity> findClientByRegistrationNumber(
    String registrationNumber,
  );
}
