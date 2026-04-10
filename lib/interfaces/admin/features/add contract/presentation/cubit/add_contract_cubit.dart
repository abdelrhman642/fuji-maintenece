import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/data/models/add_contract_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/data/repositories/add_contract_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/repositories/elevator_brand_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/repositories/elevator_type_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/repositories/maintenance_contract_periodicity_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/models/maintenance_contract_section_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/repositories/maintenance_contract_sections_repo.dart';

part 'add_contract_state.dart';

class AddContractCubit extends Cubit<AddContractState> {
  AddContractCubit(
    this._addContractRepo,
    this._elevatorTypeRepo,
    this._elevatorBrandRepo,
    this._maintenanceContractSectionsRepo,
    this._maintenanceContractPeriodicityRepo,
  ) : super(AddContractInitial());
  final AddContractRepo _addContractRepo;
  final ElevatorTypeRepo _elevatorTypeRepo;
  final ElevatorBrandRepo _elevatorBrandRepo;
  final MaintenanceContractSectionsRepo _maintenanceContractSectionsRepo;
  final MaintenanceContractPeriodicityRepo _maintenanceContractPeriodicityRepo;

  final List<ElevatorTypeModel> elevatorTypes = [];
  final List<ElevatorBrandModel> elevatorBrands = [];
  final List<MaintenanceContractSectionModel> maintenanceContractSections = [];
  final List<MaintenanceContractPeriodicityModel>
  maintenanceContractPeriodicity = [];
  final List<ClientModel> clients = [];

  Future<void> addContract(AddContractRequestModel requestModel) async {
    emit(AddContractLoading());
    final result = await _addContractRepo.addContract(requestModel);
    result.fold(
      (failure) => emit(AddContractError(failure.message)),
      (message) => emit(AddContractSuccess(message)),
    );
  }

  Future<void> fetchInitialData() async {
    final typesResult = await _elevatorTypeRepo.fetchAllActiveElevatorTypes();
    typesResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (types) => elevatorTypes.addAll(types),
    );

    final brandsResult =
        await _elevatorBrandRepo.fetchAllActiveElevatorBrands();
    brandsResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (brands) => elevatorBrands.addAll(brands),
    );

    final sectionsResult =
        await _maintenanceContractSectionsRepo.fetchActiveSections();
    sectionsResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (sections) => maintenanceContractSections.addAll(sections),
    );

    final periodicityResult =
        await _maintenanceContractPeriodicityRepo.fetchActiveDurations();
    periodicityResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (periodicity) => maintenanceContractPeriodicity.addAll(periodicity),
    );

    final clientsResult = await _addContractRepo.fetchClients();
    clientsResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (clients) => this.clients.addAll(clients),
    );

    emit(SuccessState());
  }
}
