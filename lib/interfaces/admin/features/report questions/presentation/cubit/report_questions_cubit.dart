import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_response_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/repositories/questions_repo.dart';

part 'report_questions_state.dart';

class ReportQuestionsCubit extends Cubit<ReportQuestionsState> {
  ReportQuestionsCubit(this._repo) : super(ReportQuestionsInitial());
  final QuestionsRepo _repo;

  Future<void> fetchQuestions() async {
    emit(ReportQuestionsLoading());
    final result = await _repo.fetchQuestionsReport();
    result.fold(
      (failure) => emit(ReportQuestionsError(message: failure.message)),
      (questions) => emit(ReportQuestionsLoaded(questions: questions)),
    );
  }

  Future<void> addQuestion(QuestionRequest request) async {
    emit(ReportQuestionsAddLoading());
    final result = await _repo.storeQuestionsReport(request);
    result.fold(
      (failure) => emit(ReportQuestionsAddFailure(message: failure.message)),
      (message) => emit(ReportQuestionsAddSuccess(message: message)),
    );
  }

  Future<void> updateQuestion(int id, QuestionRequest request) async {
    emit(ReportQuestionsUpdateLoading());
    final result = await _repo.updateQuestionsReport(id, request);
    result.fold(
      (failure) => emit(ReportQuestionsUpdateFailure(message: failure.message)),
      (message) => emit(ReportQuestionsUpdateSuccess(message: message)),
    );
  }

  Future<void> deleteQuestion(int id) async {
    emit(ReportQuestionsDeleteLoading());
    final result = await _repo.deleteQuestionsReport(id);
    result.fold(
      (failure) => emit(ReportQuestionsDeleteFailure(message: failure.message)),
      (message) => emit(ReportQuestionsDeleteSuccess(message: message)),
    );
  }
}
