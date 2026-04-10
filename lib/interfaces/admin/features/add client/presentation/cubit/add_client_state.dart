part of 'add_client_cubit.dart';

abstract class AddClientState extends Equatable {
  const AddClientState();

  @override
  List<Object> get props => [];
}

class AddClientInitial extends AddClientState {}

class AddClientLoading extends AddClientState {}

class AddClientSuccess extends AddClientState {
  final String message;

  const AddClientSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddClientFailure extends AddClientState {
  final String error;

  const AddClientFailure(this.error);

  @override
  List<Object> get props => [error];
}
