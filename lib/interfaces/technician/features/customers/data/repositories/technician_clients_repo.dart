import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/data/models/edit_client_location_request.dart';

abstract class TechnicianClientsRepo {
  Future<Either<Failure, List<ClientModel>>> fetchTechnicianClients();
  Future<Either<Failure, String>> editClientLocation(
    EditClientLocationRequest request,
  );
}

class TechnicianClientsRepoImpl implements TechnicianClientsRepo {
  final ApiService _apiService;
  TechnicianClientsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ClientModel>>> fetchTechnicianClients() async {
    try {
      final response = await _apiService.get(url: ApiPath.getTechnicianClients);
      return response.fold((failure) => Left(failure), (result) {
        final clients =
            (result as List)
                .map((clientJson) => ClientModel.fromMap(clientJson))
                .toList();
        return Right(clients);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editClientLocation(
    EditClientLocationRequest request,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateClientLocation,
        requestBody: request.toMap(),
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] as String);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
