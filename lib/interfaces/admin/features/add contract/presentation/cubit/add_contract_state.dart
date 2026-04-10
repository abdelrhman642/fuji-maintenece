part of 'add_contract_cubit.dart';

abstract class AddContractState extends Equatable {
  const AddContractState();

  @override
  List<Object> get props => [];
}

class AddContractInitial extends AddContractState {}

class AddContractLoading extends AddContractState {}

class AddContractSuccess extends AddContractState {
  final String message;

  const AddContractSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddContractError extends AddContractState {
  final String message;

  const AddContractError(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorState extends AddContractState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessState extends AddContractState {}
