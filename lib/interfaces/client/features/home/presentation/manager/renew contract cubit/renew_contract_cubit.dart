import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/models/renew_contract_request.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/repositories/client_home_repo.dart';

part 'renew_contract_state.dart';

class RenewContractCubit extends Cubit<RenewContractState> {
  RenewContractCubit(this._clientHomeRepo) : super(RenewContractInitial());
  final ClientHomeRepo _clientHomeRepo;

  Future<void> renewContract(RenewContractRequest requestModel) async {
    emit(RenewContractLoading());
    final result = await _clientHomeRepo.renewContract(requestModel);
    result.fold(
      (failure) => emit(RenewContractError(failure.message)),
      (message) => emit(RenewContractSuccess(message)),
    );
  }
}
