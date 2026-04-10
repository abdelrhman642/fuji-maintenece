import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/data/models/add_contract_request_model.dart';

abstract class AddContractRepo {
  Future<Either<Failure, String>> addContract(
    AddContractRequestModel requestModel,
  );
  Future<Either<Failure, List<ClientModel>>> fetchClients();
}

class AddContractRepoImpl implements AddContractRepo {
  final ApiService _apiService;

  AddContractRepoImpl(this._apiService);

  @override
  Future<Either<Failure, String>> addContract(
    AddContractRequestModel requestModel,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeContract,
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

  @override
  Future<Either<Failure, List<ClientModel>>> fetchClients() async {
    try {
      final response = await _apiService.get(url: ApiPath.getClients);
      return response.fold((failure) => Left(failure), (result) {
        final clients =
            (result as List)
                .map((clientData) => ClientModel.fromMap(clientData))
                .toList();
        return Right(clients);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
