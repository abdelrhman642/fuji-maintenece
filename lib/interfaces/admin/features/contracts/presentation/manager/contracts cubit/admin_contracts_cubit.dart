import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/repositories/admin_contracts_repo.dart';

part 'contracts_state.dart';

class AdminContractsCubit extends Cubit<ContractsState> {
  AdminContractsCubit(this._repo) : super(ContractsInitial());
  List<ContractModel> contracts = [];
  final AdminContractsRepo _repo;

  Future<void> fetchContracts() async {
    emit(ContractsLoading());
    final response = await _repo.fetchContracts();
    response.fold((failure) => emit(ContractsError(failure.message)), (
      contracts,
    ) {
      this.contracts = contracts;
      emit(ContractsLoaded(this.contracts));
    });
  }

  void filterByCurrent(bool? isCurrent) {
    if (isCurrent == null) {
      emit(ContractsLoaded(contracts));
      return;
    }
    final filtered =
        contracts.where((contract) {
          return contract.isCurrent == isCurrent;
        }).toList();
    emit(ContractsLoaded(filtered));
  }
}
