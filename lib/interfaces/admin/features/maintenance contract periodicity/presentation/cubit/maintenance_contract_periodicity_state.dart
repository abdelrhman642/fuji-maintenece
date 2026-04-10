part of 'maintenance_contract_periodicity_cubit.dart';

abstract class MaintenanceContractPeriodicityState extends Equatable {
  const MaintenanceContractPeriodicityState();

  @override
  List<Object> get props => [];
}

class MaintenanceContractPeriodicityInitial
    extends MaintenanceContractPeriodicityState {}

class MaintenanceContractPeriodicityLoading
    extends MaintenanceContractPeriodicityState {}

class MaintenanceContractPeriodicityLoaded
    extends MaintenanceContractPeriodicityState {
  final List<MaintenanceContractPeriodicityModel> periodicities;

  const MaintenanceContractPeriodicityLoaded(this.periodicities);

  @override
  List<Object> get props => [periodicities];
}

class MaintenanceContractPeriodicityError
    extends MaintenanceContractPeriodicityState {
  final String message;

  const MaintenanceContractPeriodicityError(this.message);

  @override
  List<Object> get props => [message];
}

class MaintenanceContractPeriodicityActionSuccess
    extends MaintenanceContractPeriodicityState {
  final String message;

  const MaintenanceContractPeriodicityActionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class MaintenanceContractPeriodicityActionError
    extends MaintenanceContractPeriodicityState {
  final String message;

  const MaintenanceContractPeriodicityActionError(this.message);
  @override
  List<Object> get props => [message];
}

class MaintenanceContractPeriodicityActionLoading
    extends MaintenanceContractPeriodicityState {}
