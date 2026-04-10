import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_details_model/contract_details_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/repositories/contracts_repo.dart';

part 'contract_details_state.dart';

class ContractDetailsCubit extends Cubit<ContractDetailsState> {
  ContractDetailsCubit(this._repo) : super(ContractDetailsInitial());
  final ContractsRepo _repo;

  Future<void> fetchContractDetails(int id) async {
    emit(ContractDetailsLoading());
    final response = await _repo.fetchContractDetails(id);
    response.fold(
      (failure) => emit(ContractDetailsError(failure.message)),
      (contractDetails) => emit(ContractDetailsLoaded(contractDetails)),
    );
  }
}
