import 'package:bloc/bloc.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/data/repositories/report_question_periodic_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_state.dart';

class ReportQuestionPeriodicCubit extends Cubit<ReportQuestionPeriodicState> {
  ReportQuestionPeriodicCubit(this._repo)
    : super(ReportQuestionPeriodicInitial());

  final ReportQuestionPeriodicRepo _repo;

  Future<void> fetchReportQuestionsPeriodic() async {
    emit(ReportQuestionPeriodicLoading());

    final response = await _repo.fetchReportQuestionsPeriodic();

    response.fold(
      (failure) => emit(ReportQuestionPeriodicError(failure.message)),

      (questions) => emit(ReportQuestionPeriodicLoaded(questions)),
    );
  }

  Future<void> submitReportPeriodic(StoreReportRequestModel reportData) async {
    emit(ReportQuestionPeriodicSubmitInProgress());

    final response = await _repo.submitReport(reportData);

    return response.fold(
      (failure) {
        emit(ReportQuestionPeriodicSubmitFailure(failure.message));
        return null;
      },
      (response) {
        emit(ReportQuestionPeriodicSubmitSuccess(response));
      },
    );
  }
}
