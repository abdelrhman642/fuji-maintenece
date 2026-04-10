part of 'customers_cubit.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersLoaded extends CustomersState {
  final List<ClientModel> clients;

  const CustomersLoaded(this.clients);

  @override
  List<Object> get props => [clients];
}

class CustomersError extends CustomersState {
  final String message;

  const CustomersError(this.message);

  @override
  List<Object> get props => [message];
}

class ClientLocationUpdating extends CustomersState {}

class ClientLocationUpdated extends CustomersState {
  final String message;

  const ClientLocationUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class ClientLocationUpdateError extends CustomersState {
  final String message;

  const ClientLocationUpdateError(this.message);

  @override
  List<Object> get props => [message];
}
