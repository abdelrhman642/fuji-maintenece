import 'package:dio/dio.dart';
import 'package:flutter_project/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_project/features/home/data/models/client_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<ClientModel> findClientByRegistrationNumber(
    String registrationNumber,
  ) async {
    final response = await dio.get('/api/clients/$registrationNumber');
    return ClientModel.fromJson(response.data);
  }
}
