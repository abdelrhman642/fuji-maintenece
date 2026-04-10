import 'package:fpdart/fpdart.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_city_request_model.dart';

class CitiesRepo {
  final ApiService _apiService;

  CitiesRepo(this._apiService);

  Future<Either<Failure, List<CityModel>>> getCities() async {
    try {
      final response = await _apiService.get(url: ApiPath.getCities);
      return response.fold((failure) => Left(failure), (result) {
        final cities =
            (result as List).map((city) => CityModel.fromJson(city)).toList();
        return Right(cities);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<CityModel>>> getActiveCities() async {
    try {
      final response = await _apiService.get(url: ApiPath.getActiveCities);
      return response.fold((failure) => Left(failure), (result) {
        final cities =
            (result as List).map((city) => CityModel.fromJson(city)).toList();
        return Right(cities);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> storeCity(
    StoreCityRequestModel request,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.storeCity,
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

  Future<Either<Failure, String>> updateCity(
    int id,
    StoreCityRequestModel request,
  ) async {
    try {
      final response = await _apiService.post(
        url: ApiPath.updateCity(id),
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

  Future<Either<Failure, String>> toggleCity(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.toggleCity(id),
        returnDataOnly: false,
      );
      return response.fold((failure) => Left(failure), (result) {
        return Right(result['message'] as String);
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> deleteCity(int id) async {
    try {
      final response = await _apiService.get(
        url: ApiPath.deleteCity(id),
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
