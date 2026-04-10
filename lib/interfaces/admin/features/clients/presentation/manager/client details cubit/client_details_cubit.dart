import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/repositories/clients_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  ClientDetailsCubit(this._repo) : super(ClientDetailsInitial());
  final ClientsRepo _repo;

  Future<void> fetchClientDetails(int id) async {
    emit(ClientDetailsLoading());
    final result = await _repo.getClientDetails(id);
    result.fold(
      (failure) => emit(ClientDetailsError(failure.message)),
      (contracts) => emit(ClientDetailsLoaded(contracts)),
    );
  }
}
