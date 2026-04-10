import 'package:bloc/bloc.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/repositories/report_question_malfunction_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_state.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';

class ReportQuestionMalfunctionCubit
    extends Cubit<ReportQuestionMalfunctionState> {
  ReportQuestionMalfunctionCubit(this._repo)
    : super(ReportQuestionMalfunctionInitial());

  final ReportQuestionMalfunctionRepo _repo;

  Future<void> fetchReportQuestionsMalfunction() async {
    emit(ReportQuestionMalfunctionLoading());
    final response = await _repo.fetchReportQuestionsMalfunction();
    response.fold(
      (failure) => emit(ReportQuestionMalfunctionError(failure.message)),
      (questions) => emit(ReportQuestionMalfunctionLoaded(questions)),
    );
  }

  Future<void> submitReport(StoreReportRequestModel reportRequest) async {
    emit(ReportQuestionMalfunctionSubmitInProgress());

    final response = await _repo.submitReport(reportRequest.toJson());
    return response.fold(
      (failure) {
        emit(ReportQuestionMalfunctionSubmitFailure(failure.message));
      },
      (report) {
        emit(ReportQuestionMalfunctionSubmitSuccess(report));
      },
    );
  }
}
