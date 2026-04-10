import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/config_model.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager_key.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';

class ConfigService {
  final ApiService _apiService;
  final LocalDataManager _localDataManager = LocalDataManager.instance;

  ConfigService(this._apiService);

  /// Fetch config from API and save to local storage
  Future<Either<Failure, ConfigModel>> fetchAndSaveConfig() async {
    try {
      final result = await _apiService.get<Map<String, dynamic>>(
        url: ApiPath.config,
        returnDataOnly: false,
      );

      return result.fold((failure) => Left(failure), (data) async {
        // Extract only the numeric value from "15%" format
        final vatString = data['vat'].toString().replaceAll('%', '').trim();
        final vatValue = int.parse(vatString);

        _localDataManager.setInt(LocalDataManagerKey.vat, vatValue);
        final configModel = ConfigModel.fromMap(data);

        // Save config to local storage
        await _localDataManager.setString(
          LocalDataManagerKey.appConfig,
          configModel.toJson(),
        );

        return Right(configModel);
      });
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch config: $e'));
    }
  }

  /// Get config from local storage
  ConfigModel? getLocalConfig() {
    try {
      final configJson = _localDataManager.getString(
        LocalDataManagerKey.appConfig,
      );

      if (configJson == null || configJson.isEmpty) {
        return null;
      }

      return ConfigModel.fromJson(configJson);
    } catch (e) {
      return null;
    }
  }

  /// Clear config from local storage
  Future<void> clearConfig() async {
    await _localDataManager.remove(LocalDataManagerKey.appConfig);
  }
}
