import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/data/models/location_update_request_model/location_update_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/data/repositories/location_update_requests_repo.dart';

part 'location_update_requests_state.dart';

class LocationUpdateRequestsCubit extends Cubit<LocationUpdateRequestsState> {
  LocationUpdateRequestsCubit(this._repo)
    : super(LocationUpdateRequestsInitial());
  final LocationUpdateRequestsRepo _repo;

  Future<void> loadRequests() async {
    emit(LocationUpdateRequestsLoading());
    final result = await _repo.getRequests();
    result.fold(
      (failure) => emit(LocationUpdateRequestsError(failure.message)),
      (requests) => emit(LocationUpdateRequestsLoaded(requests: requests)),
    );
  }

  Future<void> approveRequest(int id, String notes) async {
    emit(LocationUpdateRequestActionLoading());
    final result = await _repo.approveRequest(id, notes);
    result.fold(
      (failure) => emit(LocationUpdateRequestActionError(failure.message)),
      (message) => emit(LocationUpdateRequestActionSuccess(message)),
    );
  }

  Future<void> rejectRequest(int id, String reason) async {
    emit(LocationUpdateRequestActionLoading());
    final result = await _repo.rejectRequest(id, reason);
    result.fold(
      (failure) => emit(LocationUpdateRequestActionError(failure.message)),
      (message) => emit(LocationUpdateRequestActionSuccess(message)),
    );
  }
}
