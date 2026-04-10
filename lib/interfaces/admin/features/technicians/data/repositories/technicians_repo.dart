import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/technician_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/update_technician_model.dart';

abstract class TechniciansRepo {
  Future<Either<Failure, List<TechnicianModel>>> fetchTechnicians();
  Future<Either<Failure, String>> updateTechnicianStatus(int id, bool isActive);
  Future<Either<Failure, UpdateTechnicianModel>> updateTechnician(
    int id,
    Map<String, dynamic> request,
  );
  Future<Either<Failure, List<ReportModel>>> fetchTechnicianReports(int id);
}

class TechniciansRepoImpl implements TechniciansRepo {
  final ApiService _apiService;

  TechniciansRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<TechnicianModel>>> fetchTechnicians() async {
    try {
      final response = await _apiService.get(url: ApiPath.getTechnicians);

      return response.fold(
        (failure) {
          return Left(failure);
        },
        (result) {
          final technicians =
              (result as List).map((e) => TechnicianModel.fromMap(e)).toList();
          return Right(technicians);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateTechnicianStatus(
    int id,
    bool isActive,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateTechnicianStatus,
        requestBody: {
          "technician_id": id,
          "status": isActive ? "active" : "inactive",
        },
        returnDataOnly: false,
      );
      return response.fold(
        (failure) {
          return Left(failure);
        },
        (result) {
          return Right(result['message'] as String);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateTechnicianModel>> updateTechnician(
    int id,
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _apiService.put(
        url: ApiPath.updateTechnician(id),
        requestBody: request,
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        final updateModel = UpdateTechnicianModel.fromJson(result);
        return Right(updateModel);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReportModel>>> fetchTechnicianReports(
    int id,
  ) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getTechnicianReports(id),
      );

      return response.fold(
        (failure) {
          return Left(failure);
        },
        (result) {
          final reports =
              (result as List).map((e) => ReportModel.fromMap(e)).toList();
          return Right(reports);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
