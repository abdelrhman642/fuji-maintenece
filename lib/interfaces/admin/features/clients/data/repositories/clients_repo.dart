import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/models/clients_query_params.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/models/update_client_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';

abstract class ClientsRepo {
  Future<Either<Failure, List<ClientModel>>> fetchClients(
    ClientsQueryParams? params,
  );
  Future<Either<Failure, List<ContractModel>>> getClientDetails(int id);
  Future<Either<Failure, UpdateClientModel>> updateClient(
    int id,
    Map<String, dynamic> request,
  );
}

class ClientsRepoImpl implements ClientsRepo {
  final ApiService _apiService;

  ClientsRepoImpl(this._apiService);
  @override
  @override
  Future<Either<Failure, List<ClientModel>>> fetchClients(
    ClientsQueryParams? params,
  ) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getClients,
        queryParameters: params?.toJson(),
      );
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

  @override
  Future<Either<Failure, List<ContractModel>>> getClientDetails(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getClientContracts(id),
      );
      return response.fold((failure) => Left(failure), (result) {
        final contracts =
            (result as List)
                .map((contractData) => ContractModel.fromMap(contractData))
                .toList();
        return Right(contracts);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateClientModel>> updateClient(
    int id,
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _apiService.put(
        url: ApiPath.updateClient(id),
        requestBody: request,
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        final updateModel = UpdateClientModel.fromJson(result);
        return Right(updateModel);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
