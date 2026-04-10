import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/data/models/add_client_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/data/repositories/add_client_repo.dart';

part 'add_client_state.dart';

class AddClientCubit extends Cubit<AddClientState> {
  AddClientCubit(this._addClientRepo) : super(AddClientInitial());
  final AddClientRepo _addClientRepo;

  Future<void> addClient(AddClientRequestModel requestModel) async {
    emit(AddClientLoading());
    final result = await _addClientRepo.addClient(requestModel);
    result.fold(
      (failure) => emit(AddClientFailure(failure.message)),
      (message) => emit(AddClientSuccess(message)),
    );
  }
}
