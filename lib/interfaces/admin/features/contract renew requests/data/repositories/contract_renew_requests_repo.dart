import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/data/models/contract_renew_model/contract_renew_model.dart';

abstract class ContractRenewRequestsRepo {
  Future<Either<Failure, List<ContractRenewModel>>>
  getContractRenewalRequests();
  Future<Either<Failure, String>> approveContractRenewalRequest(
    int id,
    String note,
  );
  Future<Either<Failure, String>> rejectContractRenewalRequest(
    int id,
    String reason,
  );
}

class ContractRenewRequestsRepoImpl implements ContractRenewRequestsRepo {
  final ApiService _apiService;
  ContractRenewRequestsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ContractRenewModel>>>
  getContractRenewalRequests() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getContractRenewalRequests,
      );
      return response.fold((failure) => Left(failure), (data) {
        final requests =
            (data as List).map((e) => ContractRenewModel.fromMap(e)).toList();
        return Right(requests);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> approveContractRenewalRequest(
    int id,
    String note,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.approveContractRenewalRequest(id),
        returnDataOnly: false,
        requestBody: {"admin_notes": note},
      );
      return response.fold((failure) => Left(failure), (data) {
        return Right(data['message']);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> rejectContractRenewalRequest(
    int id,
    String reason,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.rejectContractRenewalRequest(id),
        returnDataOnly: false,
        requestBody: {"admin_reason": reason},
      );
      return response.fold((failure) => Left(failure), (data) {
        return Right(data['message']);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
