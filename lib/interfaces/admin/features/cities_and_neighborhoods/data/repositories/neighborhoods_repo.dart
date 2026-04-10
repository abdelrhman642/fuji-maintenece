import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/neighborhood_response_model/neighborhood_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_neighborhood_request_model.dart';

class NeighborhoodsRepo {
  final ApiService _apiService;

  NeighborhoodsRepo(this._apiService);

  Future<Either<Failure, List<NeighborhoodModel>>> getNeighborhoodsByCity(
    int cityId,
  ) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getNeighborhoodsByCity(cityId),
      );
      return response.fold((failure) => Left(failure), (result) {
        final neighborhoods =
            (result as List)
                .map((neighborhood) => NeighborhoodModel.fromJson(neighborhood))
                .toList();
        return Right(neighborhoods);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<NeighborhoodModel>>> getNeighborhoods() async {
    try {
      final response = await _apiService.get(url: ApiPath.getNeighborhoods);
      return response.fold((failure) => Left(failure), (result) {
        final neighborhoods =
            (result as List)
                .map((neighborhood) => NeighborhoodModel.fromJson(neighborhood))
                .toList();
        return Right(neighborhoods);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<NeighborhoodModel>>>
  getActiveNeighborhoods() async {
    try {
      final response = await _apiService.get(
        url: ApiPath.getActiveNeighborhoods,
      );
      return response.fold((failure) => Left(failure), (result) {
        final neighborhoods =
            (result as List)
                .map((neighborhood) => NeighborhoodModel.fromJson(neighborhood))
                .toList();
        return Right(neighborhoods);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> storeNeighborhood(
    StoreNeighborhoodRequestModel request,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeNeighborhood,
        returnDataOnly: false,
        requestBody: request.toJson(),
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] as String);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> updateNeighborhood(
    int id,
    StoreNeighborhoodRequestModel request,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateNeighborhood(id),
        returnDataOnly: false,
        requestBody: request.copyWith(cityId: null).toJson(),
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] as String);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> toggleNeighborhood(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.toggleNeighborhood(id),
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] as String);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> deleteNeighborhood(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.deleteNeighborhood(id),
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
