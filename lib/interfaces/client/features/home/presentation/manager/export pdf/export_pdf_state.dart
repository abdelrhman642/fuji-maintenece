part of 'export_pdf_cubit.dart';

sealed class ExportPdfState extends Equatable {
  const ExportPdfState();

  @override
  List<Object> get props => [];
}

final class ExportPdfInitial extends ExportPdfState {}

final class ExportPdfLoading extends ExportPdfState {}

final class ExportPdfSuccess extends ExportPdfState {
  final String filePath;

  const ExportPdfSuccess(this.filePath);

  @override
  List<Object> get props => [filePath];
}

final class ExportPdfFailure extends ExportPdfState {
  final String message;

  const ExportPdfFailure(this.message);

  @override
  List<Object> get props => [message];
}
