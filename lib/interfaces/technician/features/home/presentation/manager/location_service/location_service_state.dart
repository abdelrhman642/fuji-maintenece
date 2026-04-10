part of 'location_service_cubit.dart';

abstract class LocationServiceState extends Equatable {
  const LocationServiceState();

  @override
  List<Object?> get props => [];
}

class LocationServiceInitial extends LocationServiceState {}

class LocationServiceLoading extends LocationServiceState {}

class LocationServicePermissionDenied extends LocationServiceState {
  final bool permanentlyDenied;
  const LocationServicePermissionDenied({this.permanentlyDenied = false});

  @override
  List<Object?> get props => [permanentlyDenied];
}

class LocationServiceLocationDisabled extends LocationServiceState {}

class LocationServicePermissionGranted extends LocationServiceState {
  final Position position;
  const LocationServicePermissionGranted(this.position);

  @override
  List<Object?> get props => [position];
}

class LocationServiceLocationUpdated extends LocationServiceState {
  final Position position;
  const LocationServiceLocationUpdated(this.position);

  @override
  List<Object?> get props => [position];
}

class LocationServiceError extends LocationServiceState {
  final String message;
  const LocationServiceError(this.message);

  @override
  List<Object?> get props => [message];
}
