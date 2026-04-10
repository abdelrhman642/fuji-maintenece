part of 'elevator_brands_cubit.dart';

sealed class ElevatorBrandsState extends Equatable {
  const ElevatorBrandsState();

  @override
  List<Object> get props => [];
}

final class ElevatorBrandsInitial extends ElevatorBrandsState {}

final class ElevatorBrandsLoading extends ElevatorBrandsState {}

final class ElevatorBrandsLoaded extends ElevatorBrandsState {
  final List<ElevatorBrandModel> brands;
  const ElevatorBrandsLoaded(this.brands);
}

final class ElevatorBrandsFailure extends ElevatorBrandsState {
  final String message;
  const ElevatorBrandsFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ElevatorBrandActionSuccess extends ElevatorBrandsState {
  final String message;
  const ElevatorBrandActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class ElevatorBrandActionFailure extends ElevatorBrandsState {
  final String message;
  const ElevatorBrandActionFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class ElevatorBrandActionLoading extends ElevatorBrandsState {}

final class ElevatorTypesLoading extends ElevatorBrandsState {}

final class ElevatorTypesLoaded extends ElevatorBrandsState {
  final List<ElevatorTypeModel> types;
  const ElevatorTypesLoaded(this.types);
  @override
  List<Object> get props => [types];
}

final class ElevatorTypesError extends ElevatorBrandsState {
  final String message;
  const ElevatorTypesError(this.message);
  @override
  List<Object> get props => [message];
}
