part of 'elevator_types_cubit.dart';

sealed class ElevatorTypesState extends Equatable {
  const ElevatorTypesState();

  @override
  List<Object> get props => [];
}

final class ElevatorTypesInitial extends ElevatorTypesState {}

final class ElevatorTypesLoading extends ElevatorTypesState {}

final class ElevatorTypesLoaded extends ElevatorTypesState {
  final List<ElevatorTypeModel> types;
  const ElevatorTypesLoaded(this.types);
  @override
  List<Object> get props => [types];
}

final class ElevatorTypesError extends ElevatorTypesState {
  final String message;
  const ElevatorTypesError(this.message);
  @override
  List<Object> get props => [message];
}

final class ElevatorTypeActionSuccess extends ElevatorTypesState {
  final String message;
  const ElevatorTypeActionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class ElevatorTypeActionFailure extends ElevatorTypesState {
  final String message;
  const ElevatorTypeActionFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class ElevatorTypeActionLoading extends ElevatorTypesState {}
