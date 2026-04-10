import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/repositories/admin_reports_repo.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this._repo) : super(ReportsInitial());
  final AdminReportsRepo _repo;

  Future<void> fetchReports(int contractId) async {
    emit(ReportsLoading());
    final response = await _repo.fetchReports(contractId);
    response.fold(
      (failure) => emit(ReportsError(failure.message)),
      (reports) => emit(ReportsLoaded(reports)),
    );
  }

  Future<void> exportReportAsPdf(int reportId) async {
    emit(ReportPdfLoading());
    final response = await _repo.exportReportAsPdf(reportId);
    response.fold(
      (failure) => emit(ReportPdfError(failure.message)),
      (filePath) => emit(ReportPdfLoaded(filePath)),
    );
  }
}
