part of 'maintenance_contract_sections_cubit.dart';

abstract class MaintenanceContractSectionsState extends Equatable {
  const MaintenanceContractSectionsState();

  @override
  List<Object> get props => [];
}

class MaintenanceContractSectionsInitial
    extends MaintenanceContractSectionsState {}

class MaintenanceContractSectionsLoading
    extends MaintenanceContractSectionsState {}

class MaintenanceContractSectionsLoaded
    extends MaintenanceContractSectionsState {
  final List<MaintenanceContractSectionModel> sections;

  const MaintenanceContractSectionsLoaded(this.sections);

  @override
  List<Object> get props => [sections];
}

class MaintenanceContractSectionsError
    extends MaintenanceContractSectionsState {
  final String message;

  const MaintenanceContractSectionsError(this.message);

  @override
  List<Object> get props => [message];
}

class MaintenanceContractSectionActionLoading
    extends MaintenanceContractSectionsState {}

class MaintenanceContractSectionActionSuccess
    extends MaintenanceContractSectionsState {
  final String message;

  const MaintenanceContractSectionActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MaintenanceContractSectionActionError
    extends MaintenanceContractSectionsState {
  final String message;

  const MaintenanceContractSectionActionError(this.message);

  @override
  List<Object> get props => [message];
}
