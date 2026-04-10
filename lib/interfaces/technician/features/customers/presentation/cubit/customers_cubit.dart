import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/data/models/edit_client_location_request.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/data/repositories/technician_clients_repo.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._repo) : super(CustomersInitial());
  final TechnicianClientsRepo _repo;
  List<ClientModel> clients = [];

  Future<void> fetchClients() async {
    emit(CustomersLoading());
    final result = await _repo.fetchTechnicianClients();
    result.fold((failure) => emit(CustomersError(failure.message)), (clients) {
      this.clients = clients;
      emit(CustomersLoaded(clients));
    });
  }

  void searchClientsByName(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      emit(CustomersLoaded(clients));
      return;
    }

    final results =
        clients.where((client) {
          return client.name?.toLowerCase().contains(q) ?? false;
        }).toList();

    emit(CustomersLoaded(results));
  }

  Future<void> editClientLocation(EditClientLocationRequest request) async {
    emit(ClientLocationUpdating());
    final result = await _repo.editClientLocation(request);
    result.fold((failure) => emit(ClientLocationUpdateError(failure.message)), (
      message,
    ) {
      emit(ClientLocationUpdated(message));
      fetchClients();
    });
  }
}
