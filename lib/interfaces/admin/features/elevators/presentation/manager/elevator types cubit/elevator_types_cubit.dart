import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/repositories/elevator_type_repo.dart';

part 'elevator_types_state.dart';

class ElevatorTypesCubit extends Cubit<ElevatorTypesState> {
  ElevatorTypesCubit(this._repo) : super(ElevatorTypesInitial());
  final ElevatorTypeRepo _repo;
  Future<void> fetchAllElevatorTypes() async {
    emit(ElevatorTypesLoading());
    final result = await _repo.fetchAllElevatorTypes();
    result.fold(
      (failure) => emit(ElevatorTypesError(failure.message)),
      (types) => emit(ElevatorTypesLoaded(types)),
    );
  }

  Future<void> activateTypeById(int id) async {
    emit(ElevatorTypeActionLoading());
    final result = await _repo.activateTypeById(id);
    result.fold(
      (failure) => emit(ElevatorTypeActionFailure(failure.message)),
      (message) => emit(ElevatorTypeActionSuccess(message)),
    );
  }

  Future<void> deactivateTypeById(int id) async {
    emit(ElevatorTypeActionLoading());
    final result = await _repo.deactivateTypeById(id);
    result.fold(
      (failure) => emit(ElevatorTypeActionFailure(failure.message)),
      (message) => emit(ElevatorTypeActionSuccess(message)),
    );
  }

  Future<void> addNewElevatorType(String nameAr, String nameEn) async {
    emit(ElevatorTypeActionLoading());
    final result = await _repo.addNewElevatorType(nameAr, nameEn);
    result.fold(
      (failure) => emit(ElevatorTypeActionFailure(failure.message)),
      (message) => emit(ElevatorTypeActionSuccess(message)),
    );
  }

  Future<void> updateTypeById(int id, String nameAr, String nameEn) async {
    emit(ElevatorTypeActionLoading());
    final result = await _repo.updateTypeById(id, nameAr, nameEn);
    result.fold(
      (failure) => emit(ElevatorTypeActionFailure(failure.message)),
      (message) => emit(ElevatorTypeActionSuccess(message)),
    );
  }
}
