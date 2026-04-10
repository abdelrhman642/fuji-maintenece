part of 'renew_contract_cubit.dart';

sealed class RenewContractState extends Equatable {
  const RenewContractState();

  @override
  List<Object> get props => [];
}

final class RenewContractInitial extends RenewContractState {}

final class RenewContractLoading extends RenewContractState {}

final class RenewContractSuccess extends RenewContractState {
  final String message;
  const RenewContractSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class RenewContractError extends RenewContractState {
  final String message;
  const RenewContractError(this.message);
  @override
  List<Object> get props => [message];
}
