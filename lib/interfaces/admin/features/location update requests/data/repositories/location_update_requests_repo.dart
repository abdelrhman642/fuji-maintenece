import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/data/models/location_update_request_model/location_update_request_model.dart';

abstract class LocationUpdateRequestsRepo {
  Future<Either<Failure, List<LocationUpdateRequestModel>>> getRequests();
  Future<Either<Failure, String>> approveRequest(int id, String notes);
  Future<Either<Failure, String>> rejectRequest(int id, String reason);
}

class LocationUpdateRequestsRepoImpl extends LocationUpdateRequestsRepo {
  final ApiService apiService;

  LocationUpdateRequestsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<LocationUpdateRequestModel>>>
  getRequests() async {
    try {
      final response = await apiService.get(
        url: ApiPath.getLocationUpdateRequests,
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        List<LocationUpdateRequestModel> data = [];
        for (var item in result['data']['data']) {
          data.add(LocationUpdateRequestModel.fromMap(item));
        }
        return Right(data);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> approveRequest(int id, String notes) async {
    try {
      final response = await apiService.post(
        url: ApiPath.approveLocationUpdateRequest(id),
        requestBody: {'reason': notes},
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] ?? 'Request approved successfully');
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> rejectRequest(int id, String reason) async {
    try {
      final response = await apiService.post(
        url: ApiPath.rejectLocationUpdateRequest(id),
        requestBody: {'reason': reason},
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] ?? 'Request rejected successfully');
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
