import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/models/maintenance_contract_section_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/repositories/maintenance_contract_sections_repo.dart';

part 'maintenance_contract_sections_state.dart';

class MaintenanceContractSectionsCubit
    extends Cubit<MaintenanceContractSectionsState> {
  MaintenanceContractSectionsCubit(this._repo)
    : super(MaintenanceContractSectionsInitial());
  final MaintenanceContractSectionsRepo _repo;

  Future<void> fetchSections() async {
    emit(MaintenanceContractSectionsLoading());

    final sections = await _repo.fetchAllSections();
    sections.fold(
      (failure) => emit(MaintenanceContractSectionsError(failure.message)),
      (sections) => emit(MaintenanceContractSectionsLoaded(sections)),
    );
  }

  Future<void> addNewSection(String nameAr, String nameEn) async {
    emit(MaintenanceContractSectionActionLoading());

    final result = await _repo.addNewSection(nameAr, nameEn);
    result.fold(
      (failure) => emit(MaintenanceContractSectionActionError(failure.message)),
      (message) => emit(MaintenanceContractSectionActionSuccess(message)),
    );
  }

  Future<void> activateSection(int id) async {
    emit(MaintenanceContractSectionActionLoading());

    final result = await _repo.activateSectionById(id);
    result.fold(
      (failure) => emit(MaintenanceContractSectionActionError(failure.message)),
      (message) => emit(MaintenanceContractSectionActionSuccess(message)),
    );
  }

  Future<void> deactivateSection(int id) async {
    emit(MaintenanceContractSectionActionLoading());

    final result = await _repo.deactivateSectionById(id);
    result.fold(
      (failure) => emit(MaintenanceContractSectionActionError(failure.message)),
      (message) => emit(MaintenanceContractSectionActionSuccess(message)),
    );
  }

  Future<void> editSection(int id, String nameAr, String nameEn) async {
    emit(MaintenanceContractSectionActionLoading());

    final result = await _repo.updateSectionById(id, nameAr, nameEn);
    result.fold(
      (failure) => emit(MaintenanceContractSectionActionError(failure.message)),
      (message) => emit(MaintenanceContractSectionActionSuccess(message)),
    );
  }
}
