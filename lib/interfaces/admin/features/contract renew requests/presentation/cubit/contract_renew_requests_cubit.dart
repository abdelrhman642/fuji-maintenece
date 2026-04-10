import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/data/models/contract_renew_model/contract_renew_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/data/repositories/contract_renew_requests_repo.dart';

part 'contract_renew_requests_state.dart';

class ContractRenewRequestsCubit extends Cubit<ContractRenewRequestsState> {
  ContractRenewRequestsCubit(this._repo)
    : super(ContractRenewRequestsInitial());
  final ContractRenewRequestsRepo _repo;

  Future<void> fetchContractRenewRequests() async {
    emit(ContractRenewRequestsLoading());
    final result = await _repo.getContractRenewalRequests();
    result.fold(
      (failure) => emit(ContractRenewRequestsError(failure.message)),
      (requests) => emit(ContractRenewRequestsLoaded(requests: requests)),
    );
  }

  Future<void> approveRequest(int id, String note) async {
    emit(ContractRenewRequestActionLoading());
    final result = await _repo.approveContractRenewalRequest(id, note);
    result.fold(
      (failure) => emit(ContractRenewRequestActionError(failure.message)),
      (message) => emit(ContractRenewRequestActionSuccess(message)),
    );
  }

  Future<void> rejectRequest(int id, String reason) async {
    emit(ContractRenewRequestActionLoading());
    final result = await _repo.rejectContractRenewalRequest(id, reason);
    result.fold(
      (failure) => emit(ContractRenewRequestActionError(failure.message)),
      (message) => emit(ContractRenewRequestActionSuccess(message)),
    );
  }
}
