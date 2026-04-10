import 'package:flutter_project/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheToken(String token) {
    return sharedPreferences.setString('token', token);
  }

  @override
  Future<String?> getToken() {
    return Future.value(sharedPreferences.getString('token'));
  }
}
