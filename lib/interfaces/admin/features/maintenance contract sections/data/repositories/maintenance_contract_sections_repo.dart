import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/models/maintenance_contract_section_model.dart';

abstract class MaintenanceContractSectionsRepo {
  Future<Either<Failure, List<MaintenanceContractSectionModel>>>
  fetchAllSections();
  Future<Either<Failure, List<MaintenanceContractSectionModel>>>
  fetchActiveSections();

  Future<Either<Failure, String>> addNewSection(String nameAr, String nameEn);
  Future<Either<Failure, String>> activateSectionById(int id);
  Future<Either<Failure, String>> deactivateSectionById(int id);
  Future<Either<Failure, String>> updateSectionById(
    int id,
    String nameAr,
    String nameEn,
  );
}

class MaintenanceContractSectionsRepoImpl
    implements MaintenanceContractSectionsRepo {
  final ApiService _apiService;

  MaintenanceContractSectionsRepoImpl(this._apiService);
  @override
  Future<Either<Failure, List<MaintenanceContractSectionModel>>>
  fetchAllSections() async {
    try {
      final response = await _apiService.get(url: ApiPath.getContractSections);
      return response.fold((failure) => Left(failure), (result) {
        List<MaintenanceContractSectionModel> data = [];
        for (var item in result) {
          data.add(MaintenanceContractSectionModel.fromMap(item));
        }
        return Right(data);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> activateSectionById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveContractSection(id),
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
  Future<Either<Failure, String>> addNewSection(
    String nameAr,
    String nameEn,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeContractSection,
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
  Future<Either<Failure, String>> deactivateSectionById(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.deactivateContractSection(id),
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
  Future<Either<Failure, String>> updateSectionById(
    int id,
    String nameAr,
    String nameEn,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateContractSection(id),
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
  Future<Either<Failure, List<MaintenanceContractSectionModel>>>
  fetchActiveSections() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveContractSections,
      );
      return response.fold((failure) => Left(failure), (result) {
        List<MaintenanceContractSectionModel> data = [];
        for (var item in result) {
          data.add(MaintenanceContractSectionModel.fromMap(item));
        }
        return Right(data);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
