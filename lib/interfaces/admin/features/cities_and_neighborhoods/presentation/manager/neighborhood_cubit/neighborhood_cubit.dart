import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/neighborhood_response_model/neighborhood_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/store_neighborhood_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/repositories/neighborhoods_repo.dart';

part 'neighborhood_state.dart';

class NeighborhoodCubit extends Cubit<NeighborhoodState> {
  final NeighborhoodsRepo _neighborhoodsRepo;
  NeighborhoodCubit(this._neighborhoodsRepo) : super(NeighborhoodInitial());

  Future<void> getNeighborhoods() async {
    emit(NeighborhoodLoading());
    final result = await _neighborhoodsRepo.getNeighborhoods();
    result.fold(
      (failure) => emit(NeighborhoodError(failure.message)),
      (neighborhoods) => emit(NeighborhoodLoaded(neighborhoods)),
    );
  }

  Future<void> getNeighborhoodsByCity(int cityId) async {
    emit(NeighborhoodLoading());
    final result = await _neighborhoodsRepo.getNeighborhoodsByCity(cityId);
    result.fold(
      (failure) => emit(NeighborhoodError(failure.message)),
      (neighborhoods) => emit(NeighborhoodLoaded(neighborhoods)),
    );
  }

  Future<void> getActiveNeighborhoods() async {
    emit(NeighborhoodLoading());
    final result = await _neighborhoodsRepo.getActiveNeighborhoods();
    result.fold(
      (failure) => emit(NeighborhoodError(failure.message)),
      (neighborhoods) => emit(NeighborhoodLoaded(neighborhoods)),
    );
  }

  Future<void> storeNeighborhood(StoreNeighborhoodRequestModel request) async {
    emit(NeighborhoodOperationLoading());
    final result = await _neighborhoodsRepo.storeNeighborhood(request);
    result.fold(
      (failure) => emit(NeighborhoodOperationFailure(failure.message)),
      (message) => emit(NeighborhoodOperationSuccess(message)),
    );
  }

  Future<void> updateNeighborhood(
    int id,
    StoreNeighborhoodRequestModel request,
  ) async {
    emit(NeighborhoodOperationLoading());
    final result = await _neighborhoodsRepo.updateNeighborhood(id, request);
    result.fold(
      (failure) => emit(NeighborhoodOperationFailure(failure.message)),
      (message) => emit(NeighborhoodOperationSuccess(message)),
    );
  }

  Future<void> toggleNeighborhood(int id) async {
    emit(NeighborhoodOperationLoading());
    final result = await _neighborhoodsRepo.toggleNeighborhood(id);
    result.fold(
      (failure) => emit(NeighborhoodOperationFailure(failure.message)),
      (message) => emit(NeighborhoodOperationSuccess(message)),
    );
  }

  Future<void> deleteNeighborhood(int id) async {
    emit(NeighborhoodOperationLoading());
    final result = await _neighborhoodsRepo.deleteNeighborhood(id);
    result.fold(
      (failure) => emit(NeighborhoodOperationFailure(failure.message)),
      (message) => emit(NeighborhoodOperationSuccess(message)),
    );
  }
}
