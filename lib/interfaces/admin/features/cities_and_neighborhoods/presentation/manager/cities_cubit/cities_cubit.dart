import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_city_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/repositories/cities_repo.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final CitiesRepo _citiesRepo;
  CitiesCubit(this._citiesRepo) : super(CitiesInitial());

  Future<void> getCities() async {
    emit(CitiesLoading());
    final result = await _citiesRepo.getCities();
    result.fold(
      (failure) => emit(CitiesError(failure.message)),
      (cities) => emit(CitiesLoaded(cities)),
    );
  }

  Future<void> getActiveCities() async {
    emit(CitiesLoading());
    final result = await _citiesRepo.getActiveCities();
    result.fold(
      (failure) => emit(CitiesError(failure.message)),
      (cities) => emit(CitiesLoaded(cities)),
    );
  }

  Future<void> storeCity(StoreCityRequestModel request) async {
    emit(CityOperationLoading());
    final result = await _citiesRepo.storeCity(request);
    result.fold(
      (failure) => emit(CityOperationFailure(failure.message)),
      (message) => emit(CityOperationSuccess(message)),
    );
  }

  Future<void> updateCity(int id, StoreCityRequestModel request) async {
    emit(CityOperationLoading());
    final result = await _citiesRepo.updateCity(id, request);
    result.fold(
      (failure) => emit(CityOperationFailure(failure.message)),
      (message) => emit(CityOperationSuccess(message)),
    );
  }

  Future<void> toggleCity(int id) async {
    emit(CityOperationLoading());
    final result = await _citiesRepo.toggleCity(id);
    result.fold(
      (failure) => emit(CityOperationFailure(failure.message)),
      (message) => emit(CityOperationSuccess(message)),
    );
  }

  Future<void> deleteCity(int id) async {
    emit(CityOperationLoading());
    final result = await _citiesRepo.deleteCity(id);
    result.fold(
      (failure) => emit(CityOperationFailure(failure.message)),
      (message) => emit(CityOperationSuccess(message)),
    );
  }
}
