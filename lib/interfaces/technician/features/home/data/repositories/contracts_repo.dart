import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_details_model/contract_details_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_model.dart';

abstract class ContractsRepo {
  Future<Either<Failure, List<ContractModel>>> fetchContracts();

  Future<Either<Failure, ContractDetailsModel>> fetchContractDetails(int id);
}

class ContractsRepoImpl extends ContractsRepo {
  final ApiService _apiService;

  ContractsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ContractModel>>> fetchContracts() async {
    try {
      final response = await _apiService.get(url: ApiPath.getContracts);
      return response.fold((failure) => Left(failure), (result) {
        final List<ContractModel> contract =
            (result as List).map((e) => ContractModel.fromMap(e)).toList();
        return Right(contract);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContractDetailsModel>> fetchContractDetails(
    int id,
  ) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getContractDetails(id),
      );
      return response.fold((failure) => Left(failure), (result) {
        final ContractDetailsModel contractDetails =
            ContractDetailsModel.fromMap(result);
        return Right(contractDetails);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
