import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/data/models/add_client_request_model.dart';

abstract class AddClientRepo {
  Future<Either<Failure, String>> addClient(AddClientRequestModel requestModel);
}

class AddClientRepoImpl implements AddClientRepo {
  final ApiService _apiService;

  AddClientRepoImpl(this._apiService);
  @override
  Future<Either<Failure, String>> addClient(
    AddClientRequestModel requestModel,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.createClient,
        requestBody: requestModel.toMap(),
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
