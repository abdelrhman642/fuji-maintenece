import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/neighborhood_response_model/neighborhood_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/repositories/cities_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/repositories/neighborhoods_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/models/clients_query_params.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/models/update_client_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/repositories/clients_repo.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this._repo, this._citiesRepo, this._neighborhoodsRepo)
    : super(ClientsInitial());
  final ClientsRepo _repo;
  final List<ClientModel> clients = [];

  final CitiesRepo _citiesRepo;
  List<CityModel> cities = [];

  final NeighborhoodsRepo _neighborhoodsRepo;
  List<NeighborhoodModel> neighborhoods = [];

  int? cityId;
  int? neighborhoodId;

  void setCityId(int? id) {
    cityId = id;
    emit(ClientsCityChanged(id));
  }

  void setNeighborhoodId(int? id) {
    neighborhoodId = id;
    emit(ClientsNeighborhoodChanged(id));
  }

  void clearFilters() {
    cityId = null;
    neighborhoodId = null;
    fetchClients();
  }

  ClientsQueryParams get _params =>
      ClientsQueryParams(cityId: cityId, neighborhoodId: neighborhoodId);

  Future<void> fetchClients() async {
    emit(ClientsLoading());
    final result = await _repo.fetchClients(_params);
    result.fold((failure) => emit(ClientsError(failure.message)), (
      fetchedClients,
    ) {
      clients.clear();
      clients.addAll(fetchedClients);
      emit(ClientsLoaded(clients));
    });
  }

  void searchClientsByName(String query) {
    if (clients.isEmpty) return;
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      emit(ClientsLoaded(List<ClientModel>.from(clients)));
      return;
    }

    final results =
        clients.where((c) {
          final name = (c.name ?? '').toLowerCase();
          return name.contains(q);
        }).toList();

    emit(ClientsLoaded(results));
  }

  Future<void> fetchCities() async {
    final result = await _citiesRepo.getCities();
    result.fold((failure) {}, (fetchedCities) {
      cities = (fetchedCities);
      emit(ClientCitiesLoaded(cities));
    });
  }

  Future<void> fetchNeighborhoods(int cityId) async {
    final result = await _neighborhoodsRepo.getNeighborhoodsByCity(cityId);
    result.fold((failure) {}, (fetchedNeighborhoods) {
      neighborhoods = (fetchedNeighborhoods);
      emit(ClientNeighborhoodsLoaded(neighborhoods));
    });
  }

  Future<void> updateClient(int id, UpdateClientRequest request) async {
    emit(ClientEditLoading());
    final result = await _repo.updateClient(id, request.toJson());
    result.fold((failure) => emit(ClientEditError(failure.message)), (
      updateModel,
    ) {
      emit(ClientEditSuccess('Client updated successfully'));
      fetchClients();
    });
  }
}
