import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/repositories/maintenance_contract_periodicity_repo.dart';

part 'maintenance_contract_periodicity_state.dart';

class MaintenanceContractPeriodicityCubit
    extends Cubit<MaintenanceContractPeriodicityState> {
  MaintenanceContractPeriodicityCubit(this.repo)
    : super(MaintenanceContractPeriodicityInitial());

  final MaintenanceContractPeriodicityRepo repo;

  Future<void> fetchPeriodicity() async {
    emit(MaintenanceContractPeriodicityLoading());
    final periodicity = await repo.fetchAllDurations();
    periodicity.fold(
      (failure) => emit(MaintenanceContractPeriodicityError(failure.message)),
      (periodicity) => emit(MaintenanceContractPeriodicityLoaded(periodicity)),
    );
  }

  Future<void> addNewPeriodicity(
    String nameAr,
    String nameEn,
    int monthCount,
  ) async {
    emit(MaintenanceContractPeriodicityActionLoading());

    final result = await repo.addNewDuration(nameAr, nameEn, monthCount);
    result.fold(
      (failure) =>
          emit(MaintenanceContractPeriodicityActionError(failure.message)),
      (message) => emit(MaintenanceContractPeriodicityActionSuccess(message)),
    );
  }

  Future<void> activatePeriodicity(int id) async {
    emit(MaintenanceContractPeriodicityActionLoading());

    final result = await repo.activateDurationById(id);
    result.fold(
      (failure) =>
          emit(MaintenanceContractPeriodicityActionError(failure.message)),
      (message) => emit(MaintenanceContractPeriodicityActionSuccess(message)),
    );
  }

  Future<void> deactivatePeriodicity(int id) async {
    emit(MaintenanceContractPeriodicityActionLoading());

    final result = await repo.deactivateDerationById(id);
    result.fold(
      (failure) =>
          emit(MaintenanceContractPeriodicityActionError(failure.message)),
      (message) => emit(MaintenanceContractPeriodicityActionSuccess(message)),
    );
  }

  Future<void> editPeriodicity(
    int id,
    String nameAr,
    String nameEn,
    int monthCount,
  ) async {
    emit(MaintenanceContractPeriodicityActionLoading());

    final result = await repo.updateDurationById(
      id,
      nameAr,
      nameEn,
      monthCount,
    );
    result.fold(
      (failure) =>
          emit(MaintenanceContractPeriodicityActionError(failure.message)),
      (message) => emit(MaintenanceContractPeriodicityActionSuccess(message)),
    );
  }
}
