import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/data/models/technical_report_model/technical_report_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/data/repositories/technician_reports_repo.dart';

part 'reports_state.dart';

class TechnicianAllReportsCubit extends Cubit<ReportsState> {
  TechnicianAllReportsCubit(this._repo) : super(ReportsInitial());
  final TechnicianReportsRepo _repo;

  Future<void> fetchReports() async {
    emit(ReportsLoading());
    final result = await _repo.fetchReports();
    result.fold(
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
