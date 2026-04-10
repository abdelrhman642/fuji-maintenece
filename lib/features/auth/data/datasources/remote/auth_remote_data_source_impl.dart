import 'package:dio/dio.dart';
import 'package:flutter_project/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<void> login(String phoneNumber, String password) async {
    await dio.post(
      '/api/login',
      data: {'phoneNumber': phoneNumber, 'password': password},
    );
  }

  @override
  Future<void> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    String? email,
    String? address,
  }) async {
    await dio.post(
      '/api/register',
      data: {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'password': password,
        'email': email,
        'address': address,
      },
    );
  }
}
