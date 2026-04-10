import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/repositories/client_home_repo.dart';

part 'export_pdf_state.dart';

class ExportPdfCubit extends Cubit<ExportPdfState> {
  ExportPdfCubit(this._repo) : super(ExportPdfInitial());
  final ClientHomeRepo _repo;

  Future<void> exportReportAsPdf(int reportId) async {
    emit(ExportPdfLoading());
    final result = await _repo.exportReportAsPdf(reportId);
    result.fold(
      (failure) => emit(ExportPdfFailure(failure.message)),
      (filePath) => emit(ExportPdfSuccess(filePath)),
    );
  }
}
