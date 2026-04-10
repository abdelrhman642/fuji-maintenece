import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';

abstract class MaintenanceContractPeriodicityRepo {
  Future<Either<Failure, List<MaintenanceContractPeriodicityModel>>>
  fetchAllDurations();
  Future<Either<Failure, List<MaintenanceContractPeriodicityModel>>>
  fetchActiveDurations();
  Future<Either<Failure, String>> addNewDuration(
    String nameAr,
    String nameEn,
    int monthCount,
  );
  Future<Either<Failure, String>> activateDurationById(int id);
  Future<Either<Failure, String>> deactivateDerationById(int id);
  Future<Either<Failure, String>> updateDurationById(
    int id,
    String nameAr,
    String nameEn,
    int monthCount,
  );
}

class MaintenanceContractPeriodicityRepoImpl
    implements MaintenanceContractPeriodicityRepo {
  final ApiService _apiService;

  MaintenanceContractPeriodicityRepoImpl(this._apiService);
  @override
  Future<Either<Failure, String>> activateDurationById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveContractDuration(id),
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addNewDuration(
    String nameAr,
    String nameEn,
    int monthCount,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeContractDuration,
        requestBody: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'month_count': monthCount,
        },
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deactivateDerationById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.deactivateContractDuration(id),
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MaintenanceContractPeriodicityModel>>>
  fetchAllDurations() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getContractDurations,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (data) {
        final List<MaintenanceContractPeriodicityModel> durations = [];
        for (var item in data) {
          durations.add(MaintenanceContractPeriodicityModel.fromMap(item));
        }
        return Right(durations);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateDurationById(
    int id,
    String nameAr,
    String nameEn,
    int monthCount,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateContractDuration(id),
        requestBody: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'month_count': monthCount,
        },
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MaintenanceContractPeriodicityModel>>>
  fetchActiveDurations() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveContractDurations,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (data) {
        final List<MaintenanceContractPeriodicityModel> durations = [];
        for (var item in data) {
          durations.add(MaintenanceContractPeriodicityModel.fromMap(item));
        }
        return Right(durations);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
