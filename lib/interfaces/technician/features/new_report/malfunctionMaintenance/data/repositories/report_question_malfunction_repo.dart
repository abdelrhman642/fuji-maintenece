import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/model/report_question_malfunctio_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/submit_report_model.dart';

abstract class ReportQuestionMalfunctionRepo {
  Future<Either<Failure, List<ReportQuestionMalfunctioModel>>>
  fetchReportQuestionsMalfunction();
  Future<Either<Failure, SubmitReportModel>> submitReport(
    Map<String, dynamic> reportData,
  );
}

class ReportQuestionMalfunctionRepoImple extends ReportQuestionMalfunctionRepo {
  final ApiService _apiService;
  ReportQuestionMalfunctionRepoImple(this._apiService);
  @override
  Future<Either<Failure, List<ReportQuestionMalfunctioModel>>>
  fetchReportQuestionsMalfunction() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getReportQuestionsMalfunction,
      );
      return response.fold((failure) => Left(failure), (result) {
        final List<ReportQuestionMalfunctioModel> questions =
            (result as List)
                .map((e) => ReportQuestionMalfunctioModel.fromJson(e))
                .toList();
        return Right(questions);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubmitReportModel>> submitReport(
    Map<String, dynamic> reportData,
  ) async {
    try {
      final res = await _apiService.post(
        url: ApiPath.submitReportData,
        requestBody: reportData,
      );
      return res.fold((failure) => Left(failure), (result) {
        return Right(SubmitReportModel.fromJson(result));
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
