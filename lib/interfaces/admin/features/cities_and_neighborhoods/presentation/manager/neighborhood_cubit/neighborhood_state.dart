part of 'neighborhood_cubit.dart';

sealed class NeighborhoodState extends Equatable {
  const NeighborhoodState();

  @override
  List<Object> get props => [];
}

final class NeighborhoodInitial extends NeighborhoodState {}

final class NeighborhoodLoading extends NeighborhoodState {}

final class NeighborhoodLoaded extends NeighborhoodState {
  final List<NeighborhoodModel> neighborhoods;

  const NeighborhoodLoaded(this.neighborhoods);

  @override
  List<Object> get props => [neighborhoods];
}

final class NeighborhoodError extends NeighborhoodState {
  final String message;

  const NeighborhoodError(this.message);

  @override
  List<Object> get props => [message];
}

final class NeighborhoodOperationSuccess extends NeighborhoodState {
  final String message;

  const NeighborhoodOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class NeighborhoodOperationFailure extends NeighborhoodState {
  final String message;

  const NeighborhoodOperationFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class NeighborhoodOperationLoading extends NeighborhoodState {}
