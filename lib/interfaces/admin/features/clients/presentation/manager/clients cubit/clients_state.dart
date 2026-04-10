part of 'clients_cubit.dart';

abstract class ClientsState extends Equatable {
  const ClientsState();

  @override
  List<Object> get props => [];
}

class ClientsInitial extends ClientsState {}

class ClientsLoaded extends ClientsState {
  final List<ClientModel> clients;
  const ClientsLoaded(this.clients);
  @override
  List<Object> get props => [clients];
}

class ClientsError extends ClientsState {
  final String message;
  const ClientsError(this.message);
  @override
  List<Object> get props => [message];
}

class ClientsLoading extends ClientsState {}

class ClientsCityChanged extends ClientsState {
  final int? cityId;
  const ClientsCityChanged(this.cityId);
}

class ClientsNeighborhoodChanged extends ClientsState {
  final int? neighborhoodId;
  const ClientsNeighborhoodChanged(this.neighborhoodId);
}

class ClientCitiesLoaded extends ClientsState {
  final List<CityModel> cities;
  const ClientCitiesLoaded(this.cities);
  @override
  List<Object> get props => [cities];
}

class ClientNeighborhoodsLoaded extends ClientsState {
  final List<NeighborhoodModel> neighborhoods;
  const ClientNeighborhoodsLoaded(this.neighborhoods);
  @override
  List<Object> get props => [neighborhoods];
}

class ClientEditLoading extends ClientsState {
  const ClientEditLoading();
  @override
  List<Object> get props => [];
}

class ClientEditSuccess extends ClientsState {
  final String message;
  const ClientEditSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class ClientEditError extends ClientsState {
  final String message;
  const ClientEditError(this.message);
  @override
  List<Object> get props => [message];
}
