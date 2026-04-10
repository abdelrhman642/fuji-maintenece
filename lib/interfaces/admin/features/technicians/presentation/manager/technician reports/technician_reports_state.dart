part of 'technician_reports_cubit.dart';

sealed class TechnicianReportsState extends Equatable {
  const TechnicianReportsState();

  @override
  List<Object> get props => [];
}

final class TechnicianReportsInitial extends TechnicianReportsState {}

final class TechnicianReportsLoading extends TechnicianReportsState {}

final class TechnicianReportsLoaded extends TechnicianReportsState {
  final List<ReportModel> reports;

  const TechnicianReportsLoaded(this.reports);

  @override
  List<Object> get props => [reports];
}

final class TechnicianReportsError extends TechnicianReportsState {
  final String message;

  const TechnicianReportsError(this.message);

  @override
  List<Object> get props => [message];
}
