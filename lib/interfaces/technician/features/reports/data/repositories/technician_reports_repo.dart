import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/data/models/technical_report_model/technical_report_model.dart';

abstract class TechnicianReportsRepo {
  Future<Either<Failure, List<TechnicalReportModel>>> fetchReports();

  Future<Either<Failure, String>> exportReportAsPdf(int reportId);
}

class TechnicianReportsRepoImpl implements TechnicianReportsRepo {
  final ApiService _apiService;
  TechnicianReportsRepoImpl(this._apiService);
  @override
  Future<Either<Failure, List<TechnicalReportModel>>> fetchReports() async {
    try {
      final response = await _apiService.get(url: ApiPath.technicianReports);
      return response.fold((failure) => Left(failure), (result) {
        final reports =
            (result as List)
                .map((reportJson) => TechnicalReportModel.fromMap(reportJson))
                .toList();
        return Right(reports);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> exportReportAsPdf(int reportId) async {
    try {
      final response = await _apiService.download(
        url: ApiPath.downloadReport(reportId),
      );

      return response.fold(
        (failure) {
          return Left(failure);
        },
        (filePath) {
          log('Downloaded file path: $filePath');
          return Right(filePath);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
