import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';

abstract class AdminContractsRepo {
  Future<Either<Failure, List<ContractModel>>> fetchContracts();
}

class AdminContractsRepoImpl implements AdminContractsRepo {
  final ApiService _apiService;

  AdminContractsRepoImpl(this._apiService);

  @override
  Future<Either<Failure, List<ContractModel>>> fetchContracts() async {
    try {
      final response = await _apiService.get(url: ApiPath.getAllContracts);
      return response.fold((failure) => Left(failure), (result) {
        List<ContractModel> data = [];
        for (var item in result) {
          data.add(ContractModel.fromMap(item));
        }
        return Right(data);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
