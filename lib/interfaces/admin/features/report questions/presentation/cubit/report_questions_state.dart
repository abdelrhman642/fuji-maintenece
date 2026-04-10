part of 'report_questions_cubit.dart';

abstract class ReportQuestionsState extends Equatable {
  final String? message;
  const ReportQuestionsState({this.message});

  @override
  List<Object> get props => [message ?? ''];
}

class ReportQuestionsInitial extends ReportQuestionsState {}

class ReportQuestionsLoading extends ReportQuestionsState {}

class ReportQuestionsLoaded extends ReportQuestionsState {
  final List<QuestionResponseModel> questions;
  const ReportQuestionsLoaded({required this.questions});
}

class ReportQuestionsError extends ReportQuestionsState {
  final String message;
  const ReportQuestionsError({required this.message});
}

class ReportQuestionsAddLoading extends ReportQuestionsState {}

class ReportQuestionsAddSuccess extends ReportQuestionsState {
  final String message;
  const ReportQuestionsAddSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportQuestionsAddFailure extends ReportQuestionsState {
  final String message;
  const ReportQuestionsAddFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportQuestionsDeleteLoading extends ReportQuestionsState {}

class ReportQuestionsDeleteSuccess extends ReportQuestionsState {
  final String message;
  const ReportQuestionsDeleteSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportQuestionsDeleteFailure extends ReportQuestionsState {
  final String message;
  const ReportQuestionsDeleteFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportQuestionsUpdateLoading extends ReportQuestionsState {}

class ReportQuestionsUpdateSuccess extends ReportQuestionsState {
  final String message;
  const ReportQuestionsUpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportQuestionsUpdateFailure extends ReportQuestionsState {
  final String message;
  const ReportQuestionsUpdateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
