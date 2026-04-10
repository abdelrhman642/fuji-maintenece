import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/submit_report_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/data/model/report_question_periodic_model.dart';

abstract class ReportQuestionPeriodicState extends Equatable {
  const ReportQuestionPeriodicState();

  @override
  List<Object> get props => [];
}

class ReportQuestionPeriodicInitial extends ReportQuestionPeriodicState {}

class ReportQuestionPeriodicLoading extends ReportQuestionPeriodicState {}

class ReportQuestionPeriodicLoaded extends ReportQuestionPeriodicState {
  final List<ReportQuestionPeriodicModel> questions;

  const ReportQuestionPeriodicLoaded(this.questions);

  @override
  List<Object> get props => [questions];
}

class ReportQuestionPeriodicError extends ReportQuestionPeriodicState {
  final String message;

  const ReportQuestionPeriodicError(this.message);

  @override
  List<Object> get props => [message];
}

class ReportQuestionPeriodicSubmitInProgress
    extends ReportQuestionPeriodicState {}

class ReportQuestionPeriodicSubmitSuccess extends ReportQuestionPeriodicState {
  final SubmitReportModel submitReportModel;

  const ReportQuestionPeriodicSubmitSuccess(this.submitReportModel);

  @override
  List<Object> get props => [submitReportModel];
}

class ReportQuestionPeriodicSubmitFailure extends ReportQuestionPeriodicState {
  final String error;

  const ReportQuestionPeriodicSubmitFailure(this.error);

  @override
  List<Object> get props => [error];
}
