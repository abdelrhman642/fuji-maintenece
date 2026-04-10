import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';

abstract class ElevatorBrandRepo {
  Future<Either<Failure, List<ElevatorBrandModel>>> fetchAllElevatorBrands();
  Future<Either<Failure, List<ElevatorBrandModel>>>
  fetchAllActiveElevatorBrands();
  Future<Either<Failure, List<ElevatorTypeModel>>>
  fetchAllActiveElevatorTypes();

  Future<Either<Failure, String>> addNewElevatorBrand(
    String nameAr,
    String nameEn,
    int elevatorTypeId,
  );
  Future<Either<Failure, String>> activateBrandById(int id);
  Future<Either<Failure, String>> deactivateBrandById(int id);
  Future<Either<Failure, String>> updateBrandById(
    int id,
    String nameAr,
    String nameEn,
    int elevatorTypeId,
  );
}

class ElevatorBrandRepoImpl implements ElevatorBrandRepo {
  final ApiService _apiService;
  ElevatorBrandRepoImpl(this._apiService);

  @override
  Future<Either<Failure, String>> activateBrandById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveElevatorModel(id),
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
  Future<Either<Failure, String>> addNewElevatorBrand(
    String nameAr,
    String nameEn,
    int elevatorTypeId,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeElevatorModel,
        requestBody: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'elevator_type_id': elevatorTypeId,
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
  Future<Either<Failure, String>> deactivateBrandById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.deactivateElevatorModel(id),
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
  Future<Either<Failure, List<ElevatorBrandModel>>>
  fetchAllElevatorBrands() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getElevatorModels,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (result) {
        final List<ElevatorBrandModel> brands =
            (result as List).map((e) => ElevatorBrandModel.fromMap(e)).toList();
        return Right(brands);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateBrandById(
    int id,
    String nameAr,
    String nameEn,
    int elevatorTypeId,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateElevatorModel(id),
        requestBody: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'elevator_type_id': elevatorTypeId,
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
  Future<Either<Failure, List<ElevatorTypeModel>>>
  fetchAllActiveElevatorTypes() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveElevatorTypes,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (result) {
        final List<ElevatorTypeModel> types =
            (result as List).map((e) => ElevatorTypeModel.fromMap(e)).toList();
        return Right(types);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ElevatorBrandModel>>>
  fetchAllActiveElevatorBrands() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveElevatorModels,
        returnDataOnly: true,
      );
      return response.fold((failure) => Left(failure), (result) {
        final List<ElevatorBrandModel> brands =
            (result as List).map((e) => ElevatorBrandModel.fromMap(e)).toList();
        return Right(brands);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
