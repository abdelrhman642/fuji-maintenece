part of 'admin_contracts_cubit.dart';

sealed class ContractsState extends Equatable {
  const ContractsState();

  @override
  List<Object> get props => [];
}

final class ContractsInitial extends ContractsState {}

final class ContractsLoading extends ContractsState {}

final class ContractsLoaded extends ContractsState {
  final List<ContractModel> contracts;

  const ContractsLoaded(this.contracts);

  @override
  List<Object> get props => [contracts];
}

final class ContractsError extends ContractsState {
  final String message;

  const ContractsError(this.message);

  @override
  List<Object> get props => [message];
}
