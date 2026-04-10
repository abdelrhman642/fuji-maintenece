import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/data/models/admin_home_statistics_model/admin_home_statistics_model.dart';

abstract class AdminHomeRepo {
  Future<Either<Failure, AdminHomeStatisticsModel>> getAdminHomeStatistics();
}

class AdminHomeRepoImpl implements AdminHomeRepo {
  final ApiService _apiService;

  AdminHomeRepoImpl(this._apiService);

  @override
  Future<Either<Failure, AdminHomeStatisticsModel>>
  getAdminHomeStatistics() async {
    try {
      final response = await _apiService.get(url: ApiPath.adminDashboard);
      return response.fold((failure) => Left(failure), (data) {
        final model = AdminHomeStatisticsModel.fromMap(data);
        return Right(model);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
