part of 'location_update_requests_cubit.dart';

abstract class LocationUpdateRequestsState extends Equatable {
  const LocationUpdateRequestsState();

  @override
  List<Object> get props => [];
}

class LocationUpdateRequestsInitial extends LocationUpdateRequestsState {}

class LocationUpdateRequestsLoading extends LocationUpdateRequestsState {}

class LocationUpdateRequestsLoaded extends LocationUpdateRequestsState {
  final List<LocationUpdateRequestModel> requests;

  const LocationUpdateRequestsLoaded({required this.requests});

  @override
  List<Object> get props => [requests];
}

class LocationUpdateRequestsError extends LocationUpdateRequestsState {
  final String message;

  const LocationUpdateRequestsError(this.message);

  @override
  List<Object> get props => [message];
}

class LocationUpdateRequestActionLoading extends LocationUpdateRequestsState {}

class LocationUpdateRequestActionSuccess extends LocationUpdateRequestsState {
  final String message;

  const LocationUpdateRequestActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LocationUpdateRequestActionError extends LocationUpdateRequestsState {
  final String message;

  const LocationUpdateRequestActionError(this.message);

  @override
  List<Object> get props => [message];
}
