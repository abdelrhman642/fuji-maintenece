// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/local/auth_local_data_source.dart'
    as _i835;
import '../../features/auth/data/datasources/local/auth_local_data_source_impl.dart'
    as _i497;
import '../../features/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i520;
import '../../features/auth/data/datasources/remote/auth_remote_data_source_impl.dart'
    as _i542;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/home/data/datasources/home_remote_data_source.dart'
    as _i362;
import '../../features/home/data/datasources/home_remote_data_source_impl.dart'
    as _i819;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/usecases/find_client_usecase.dart' as _i971;
import '../../features/reports/data/datasources/reports_remote_data_source.dart'
    as _i673;
import '../../features/reports/data/datasources/reports_remote_data_source_impl.dart'
    as _i35;
import '../../features/reports/data/repositories/reports_repository_impl.dart'
    as _i227;
import '../../features/reports/domain/repositories/reports_repository.dart'
    as _i808;
import '../../features/reports/domain/usecases/send_crash_report_usecase.dart'
    as _i349;
import 'app_module.dart' as _i460;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i361.Dio>(() => appModule.dio);
  gh.lazySingleton<_i520.AuthRemoteDataSource>(
    () => _i542.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i673.ReportsRemoteDataSource>(
    () => _i35.ReportsRemoteDataSourceImpl(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i362.HomeRemoteDataSource>(
    () => _i819.HomeRemoteDataSourceImpl(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i808.ReportsRepository>(
    () => _i227.ReportsRepositoryImpl(gh<_i673.ReportsRemoteDataSource>()),
  );
  gh.factory<_i349.SendCrashReportUseCase>(
    () => _i349.SendCrashReportUseCase(gh<_i808.ReportsRepository>()),
  );
  gh.lazySingleton<_i835.AuthLocalDataSource>(
    () => _i497.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i0.HomeRepository>(
    () => _i76.HomeRepositoryImpl(gh<_i362.HomeRemoteDataSource>()),
  );
  gh.factory<_i971.FindClientUseCase>(
    () => _i971.FindClientUseCase(gh<_i0.HomeRepository>()),
  );
  gh.lazySingleton<_i787.AuthRepository>(
    () => _i153.AuthRepositoryImpl(
      gh<_i520.AuthRemoteDataSource>(),
      gh<_i835.AuthLocalDataSource>(),
    ),
  );
  gh.factory<_i941.RegisterUseCase>(
    () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
  );
  return getIt;
}

class _$AppModule extends _i460.AppModule {}
