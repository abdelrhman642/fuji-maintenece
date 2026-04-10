import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';

abstract class ElevatorTypeRepo {
  Future<Either<Failure, List<ElevatorTypeModel>>> fetchAllElevatorTypes();
  Future<Either<Failure, List<ElevatorTypeModel>>>
  fetchAllActiveElevatorTypes();
  Future<Either<Failure, String>> addNewElevatorType(
    String nameAr,
    String nameEn,
  );
  Future<Either<Failure, String>> activateTypeById(int id);
  Future<Either<Failure, String>> deactivateTypeById(int id);
  Future<Either<Failure, String>> updateTypeById(
    int id,
    String nameAr,
    String nameEn,
  );
}

class ElevatorTypeRepoImpl implements ElevatorTypeRepo {
  final ApiService _apiService;
  ElevatorTypeRepoImpl(this._apiService);

  @override
  Future<Either<Failure, String>> activateTypeById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveElevatorType(id),
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
  Future<Either<Failure, String>> addNewElevatorType(
    String nameAr,
    String nameEn,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeElevatorType,
        requestBody: {'name_ar': nameAr, 'name_en': nameEn},
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
  Future<Either<Failure, String>> deactivateTypeById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.deactivateElevatorType(id),
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
  Future<Either<Failure, List<ElevatorTypeModel>>>
  fetchAllElevatorTypes() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getElevatorTypes,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (result) {
        final types =
            (result as List).map((e) => ElevatorTypeModel.fromMap(e)).toList();
        return Right(types);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateTypeById(
    int id,
    String nameAr,
    String nameEn,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateElevatorType(id),
        requestBody: {'name_ar': nameAr, 'name_en': nameEn},
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
  Future<Either<Failure, List<ElevatorTypeModel>>>
  fetchAllActiveElevatorTypes() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveElevatorTypes,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (result) {
        final types =
            (result as List).map((e) => ElevatorTypeModel.fromMap(e)).toList();
        return Right(types);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
