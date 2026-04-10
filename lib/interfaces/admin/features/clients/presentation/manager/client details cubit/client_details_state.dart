part of 'client_details_cubit.dart';

sealed class ClientDetailsState extends Equatable {
  const ClientDetailsState();

  @override
  List<Object> get props => [];
}

final class ClientDetailsInitial extends ClientDetailsState {}

final class ClientDetailsLoading extends ClientDetailsState {}

final class ClientDetailsLoaded extends ClientDetailsState {
  final List<ContractModel> contracts;
  const ClientDetailsLoaded(this.contracts);
}

final class ClientDetailsError extends ClientDetailsState {
  final String message;
  const ClientDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
