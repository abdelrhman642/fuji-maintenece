import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/repositories/elevator_brand_repo.dart';

part 'elevator_brands_state.dart';

class ElevatorBrandsCubit extends Cubit<ElevatorBrandsState> {
  ElevatorBrandsCubit(this._repo) : super(ElevatorBrandsInitial());
  final ElevatorBrandRepo _repo;
  List<ElevatorTypeModel> elevatorTypes = [];

  Future<void> fetchAllElevatorBrands() async {
    emit(ElevatorBrandsLoading());
    final result = await _repo.fetchAllElevatorBrands();
    result.fold(
      (failure) => emit(ElevatorBrandsFailure(failure.message)),
      (brands) => emit(ElevatorBrandsLoaded(brands)),
    );
  }

  Future<void> addNewElevatorBrand(
    String nameAr,
    String nameEn,
    int elevatorTypeId,
  ) async {
    emit(ElevatorBrandActionLoading());
    final result = await _repo.addNewElevatorBrand(
      nameAr,
      nameEn,
      elevatorTypeId,
    );
    result.fold(
      (failure) => emit(ElevatorBrandActionFailure(failure.message)),
      (message) => emit(ElevatorBrandActionSuccess(message)),
    );
  }

  Future<void> activateBrandById(int id) async {
    emit(ElevatorBrandActionLoading());
    final result = await _repo.activateBrandById(id);
    result.fold(
      (failure) => emit(ElevatorBrandActionFailure(failure.message)),
      (message) => emit(ElevatorBrandActionSuccess(message)),
    );
  }

  Future<void> deactivateBrandById(int id) async {
    emit(ElevatorBrandActionLoading());
    final result = await _repo.deactivateBrandById(id);
    result.fold(
      (failure) => emit(ElevatorBrandActionFailure(failure.message)),
      (message) => emit(ElevatorBrandActionSuccess(message)),
    );
  }

  Future<void> updateBrandById(
    int id,
    String nameAr,
    String nameEn,
    int elevatorTypeId,
  ) async {
    emit(ElevatorBrandActionLoading());
    final result = await _repo.updateBrandById(
      id,
      nameAr,
      nameEn,
      elevatorTypeId,
    );
    result.fold(
      (failure) => emit(ElevatorBrandActionFailure(failure.message)),
      (message) => emit(ElevatorBrandActionSuccess(message)),
    );
  }

  Future<void> fetchAllActiveElevatorTypes() async {
    // emit(ElevatorTypesLoading());
    final result = await _repo.fetchAllActiveElevatorTypes();
    result.fold(
      (failure) {
        // emit(ElevatorTypesError(failure.message));
      },
      (types) {
        elevatorTypes = types;
        // emit(ElevatorTypesLoaded(types));
      },
    );
  }
}
