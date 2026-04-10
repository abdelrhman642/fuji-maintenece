import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_response_model.dart';

abstract class QuestionsRepo {
  Future<Either<Failure, List<QuestionResponseModel>>> fetchQuestionsReport();
  Future<Either<Failure, String>> storeQuestionsReport(QuestionRequest request);
  Future<Either<Failure, String>> updateQuestionsReport(
    int id,
    QuestionRequest request,
  );
  Future<Either<Failure, String>> deleteQuestionsReport(int id);
}

class QuestionsRepoImpl implements QuestionsRepo {
  final ApiService _apiService;

  QuestionsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<QuestionResponseModel>>>
  fetchQuestionsReport() async {
    try {
      final response = await _apiService.get(url: ApiPath.getQuestions);
      return response.fold((failure) => Left(failure), (result) {
        final questions =
            (result as List)
                .map(
                  (questionData) => QuestionResponseModel.fromMap(questionData),
                )
                .toList();
        return Right(questions);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> storeQuestionsReport(
    QuestionRequest request,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeQuestion,
        requestBody: request.toJson(),
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateQuestionsReport(
    int id,
    QuestionRequest request,
  ) async {
    try {
      final response = await _apiService.put(
        url: ApiPath.updateQuestion(id),
        requestBody: request.toJson(),
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteQuestionsReport(int id) async {
    try {
      final response = await _apiService.delete(
        url: ApiPath.deleteQuestion(id),
        returnDataOnly: false,
      );
      return response.fold(
        (failure) => Left(failure),
        (result) => Right(result['message'] ?? 'Unknown server response'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
