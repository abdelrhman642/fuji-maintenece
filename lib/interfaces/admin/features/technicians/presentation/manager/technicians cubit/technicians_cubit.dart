import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/technician_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/update_technician_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/repositories/technicians_repo.dart';

part 'technicians_state.dart';

class TechniciansCubit extends Cubit<TechniciansState> {
  TechniciansCubit(this._repo) : super(TechniciansInitial());
  final TechniciansRepo _repo;
  List<TechnicianModel> technicians = [];

  Future<void> fetchTechnicians() async {
    emit(TechniciansLoading());
    final result = await _repo.fetchTechnicians();
    result.fold((failure) => emit(TechniciansError(failure.message)), (
      technicians,
    ) {
      this.technicians = technicians;
      emit(TechniciansLoaded(technicians));
    });
  }

  Future<void> searchTechniciansByName(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      emit(TechniciansLoaded(List<TechnicianModel>.from(technicians)));
      return;
    }

    final results =
        technicians.where((t) {
          final name = (t.name ?? '').toLowerCase();
          return name.contains(q);
        }).toList();

    emit(TechniciansLoaded(results));
  }

  Future<void> updateTechnicianStatus(int id, bool isActive) async {
    final result = await _repo.updateTechnicianStatus(id, isActive);
    result.fold((failure) => emit(TechniciansUpdateError(failure.message)), (
      message,
    ) {
      emit(TechniciansUpdateSuccess(message));
      fetchTechnicians();
    });
  }

  void filterByActive(bool? isActive) {
    if (isActive == null) {
      emit(TechniciansLoaded(technicians));
      return;
    }
    final filtered =
        technicians.where((technician) {
          if (isActive) {
            return technician.status == 'active';
          } else {
            return technician.status != 'active';
          }
        }).toList();
    emit(TechniciansLoaded(filtered));
  }

  Future<void> updateTechnician(int id, UpdateTechnicianRequest request) async {
    emit(TechniciansEditLoading());
    final result = await _repo.updateTechnician(id, request.toJson());
    result.fold((failure) => emit(TechniciansEditError(failure.message)), (
      updateModel,
    ) {
      emit(TechniciansEditSuccess('Technician updated successfully'));
      fetchTechnicians();
    });
  }
}
