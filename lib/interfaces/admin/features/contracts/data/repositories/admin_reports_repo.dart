import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';

abstract class AdminReportsRepo {
  Future<Either<Failure, List<ReportModel>>> fetchReports(int contractId);
  Future<Either<Failure, String>> exportReportAsPdf(int reportId);
}

class AdminReportsRepoImpl implements AdminReportsRepo {
  final ApiService _apiService;

  AdminReportsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ReportModel>>> fetchReports(
    int contractId,
  ) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getReports,
        queryParameters: {'contract_id': contractId},
      );
      return response.fold((failure) => Left(failure), (result) {
        List<ReportModel> data = [];
        for (var item in result) {
          data.add(ReportModel.fromMap(item));
        }
        return Right(data);
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
          return Right(filePath);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
