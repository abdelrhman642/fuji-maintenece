part of 'contract_renew_requests_cubit.dart';

abstract class ContractRenewRequestsState extends Equatable {
  const ContractRenewRequestsState();

  @override
  List<Object> get props => [];
}

class ContractRenewRequestsInitial extends ContractRenewRequestsState {}

class ContractRenewRequestsLoading extends ContractRenewRequestsState {}

class ContractRenewRequestsLoaded extends ContractRenewRequestsState {
  final List<ContractRenewModel> requests;
  const ContractRenewRequestsLoaded({required this.requests});
  @override
  List<Object> get props => [requests];
}

class ContractRenewRequestsError extends ContractRenewRequestsState {
  final String message;
  const ContractRenewRequestsError(this.message);
  @override
  List<Object> get props => [message];
}

class ContractRenewRequestActionSuccess extends ContractRenewRequestsState {
  final String message;
  const ContractRenewRequestActionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class ContractRenewRequestActionError extends ContractRenewRequestsState {
  final String message;
  const ContractRenewRequestActionError(this.message);
  @override
  List<Object> get props => [message];
}

class ContractRenewRequestActionLoading extends ContractRenewRequestsState {}
