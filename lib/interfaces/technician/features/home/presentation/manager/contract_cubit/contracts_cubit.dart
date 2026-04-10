import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/repositories/contracts_repo.dart';

part 'contracts_state.dart';

class ContractsCubit extends Cubit<ContractsState> {
  ContractsCubit(this._repo) : super(ContractsInitial());
  final ContractsRepo _repo;

  Future<void> fetchContracts() async {
    emit(ContractsLoading());
    final response = await _repo.fetchContracts();
    response.fold(
      (failure) => emit(ContractsError(failure.message)),
      (contracts) => emit(ContractsLoaded(contracts)),
    );
  }
}
