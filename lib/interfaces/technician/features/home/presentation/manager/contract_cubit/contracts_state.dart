part of 'contracts_cubit.dart';

abstract class ContractsState extends Equatable {
  const ContractsState();

  @override
  List<Object> get props => [];
}

class ContractsInitial extends ContractsState {}

class ContractsLoading extends ContractsState {}

class ContractsLoaded extends ContractsState {
  final List<ContractModel> contracts;

  const ContractsLoaded(this.contracts);

  @override
  List<Object> get props => [contracts];
}

class ContractsError extends ContractsState {
  final String message;

  const ContractsError(this.message);

  @override
  List<Object> get props => [message];
}
