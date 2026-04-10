import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/repositories/technicians_repo.dart';

part 'technician_reports_state.dart';

class TechnicianReportsCubit extends Cubit<TechnicianReportsState> {
  TechnicianReportsCubit(this._repo) : super(TechnicianReportsInitial());
  final TechniciansRepo _repo;

  Future<void> fetchTechnicianReports(int technicianId) async {
    emit(TechnicianReportsLoading());
    final result = await _repo.fetchTechnicianReports(technicianId);
    result.fold(
      (failure) {
        emit(TechnicianReportsError(failure.message));
      },
      (reports) {
        emit(TechnicianReportsLoaded(reports));
      },
    );
  }
}
