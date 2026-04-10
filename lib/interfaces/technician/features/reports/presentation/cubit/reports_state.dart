part of 'reports_cubit.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final List<TechnicalReportModel> reports;
  const ReportsLoaded(this.reports);

  @override
  List<Object> get props => [reports];
}

class ReportsError extends ReportsState {
  final String message;
  const ReportsError(this.message);

  @override
  List<Object> get props => [message];
}

class ReportPdfLoading extends ReportsState {}

class ReportPdfLoaded extends ReportsState {
  final String filePath;
  const ReportPdfLoaded(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class ReportPdfError extends ReportsState {
  final String message;
  const ReportPdfError(this.message);

  @override
  List<Object> get props => [message];
}
