import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/submit_report_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/data/model/report_question_periodic_model.dart';

abstract class ReportQuestionPeriodicRepo {
  Future<Either<Failure, List<ReportQuestionPeriodicModel>>>
  fetchReportQuestionsPeriodic();
  Future<Either<Failure, SubmitReportModel>> submitReport(
    StoreReportRequestModel reportData,
  );
}

class ReportQuestionPeriodicRepoImpl extends ReportQuestionPeriodicRepo {
  final ApiService _apiService;
  ReportQuestionPeriodicRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ReportQuestionPeriodicModel>>>
  fetchReportQuestionsPeriodic() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getReportQuestionsPeriodic,
      );
      return response.fold((failure) => Left(failure), (result) {
        final List<ReportQuestionPeriodicModel> questions =
            (result as List)
                .map((e) => ReportQuestionPeriodicModel.fromJson(e))
                .toList();
        return Right(questions);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubmitReportModel>> submitReport(
    StoreReportRequestModel reportData,
  ) async {
    try {
      final res = await _apiService.post(
        url: ApiPath.submitReportData,
        requestBody: reportData.toJson(),
      );
      return res.fold((failure) => Left(failure), (result) {
        return Right(SubmitReportModel.fromJson(result));
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
