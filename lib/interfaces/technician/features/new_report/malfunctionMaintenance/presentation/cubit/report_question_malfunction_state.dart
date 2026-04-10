import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/model/report_question_malfunctio_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/submit_report_model.dart';

class ReportQuestionMalfunctionState extends Equatable {
  const ReportQuestionMalfunctionState();
  @override
  List<Object?> get props => [];
}

class ReportQuestionMalfunctionInitial extends ReportQuestionMalfunctionState {}

class ReportQuestionMalfunctionLoading extends ReportQuestionMalfunctionState {}

class ReportQuestionMalfunctionLoaded extends ReportQuestionMalfunctionState {
  final List<ReportQuestionMalfunctioModel> questions;

  const ReportQuestionMalfunctionLoaded(this.questions);

  @override
  List<Object?> get props => [questions];
}

class ReportQuestionMalfunctionError extends ReportQuestionMalfunctionState {
  final String message;

  const ReportQuestionMalfunctionError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReportQuestionMalfunctionSubmitInProgress
    extends ReportQuestionMalfunctionState {}

class ReportQuestionMalfunctionSubmitSuccess
    extends ReportQuestionMalfunctionState {
  final SubmitReportModel submitReportModel;

  const ReportQuestionMalfunctionSubmitSuccess(this.submitReportModel);

  @override
  List<Object?> get props => [submitReportModel];
}

class ReportQuestionMalfunctionSubmitFailure
    extends ReportQuestionMalfunctionState {
  final String error;

  const ReportQuestionMalfunctionSubmitFailure(this.error);

  @override
  List<Object?> get props => [error];
}
