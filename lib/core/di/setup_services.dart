// Core Services
import 'package:fuji_maintenance_system/core/service/config_service/config_service.dart';
import 'package:fuji_maintenance_system/core/service/hive_manager.dart';
import 'package:fuji_maintenance_system/core/service/image_service/image_picker_service.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager.dart';
import 'package:fuji_maintenance_system/core/service/localization_service/localization_service.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
// Admin - Clients
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/data/repositories/add_client_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/cubit/add_client_cubit.dart';
// Admin - Contracts
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/data/repositories/add_contract_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/cubit/add_contract_cubit.dart';
// Admin - Shared
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/repositories/cities_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/repositories/neighborhoods_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/data/repositories/clients_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/client%20details%20cubit/client_details_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/clients%20cubit/clients_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/data/repositories/contract_renew_requests_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/cubit/contract_renew_requests_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/repositories/admin_contracts_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/repositories/admin_reports_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/contracts%20cubit/admin_contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/reports%20cubit/reports_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/repositories/elevator_brand_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/repositories/elevator_type_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20brands%20cubit/elevator_brands_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20types%20cubit/elevator_types_cubit.dart';
// Admin - Orders & Requests
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/data/repositories/location_update_requests_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/cubit/location_update_requests_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/repositories/maintenance_contract_periodicity_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/cubit/maintenance_contract_periodicity_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/repositories/maintenance_contract_sections_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/cubit/maintenance_contract_sections_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/repositories/order_repositories.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/repositories/see_details_repositories.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/order/orders_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/see_details_order/see_details_order_cubit.dart';
// Admin - Reports & Technicians
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/repositories/questions_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/cubit/report_questions_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/repositories/technicians_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technician%20reports/technician_reports_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technicians%20cubit/technicians_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/data/repositories/visits_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/presentation/cubit/visits_cubit.dart';
// Client
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/repositories/client_home_repo.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/cubit/home_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/manager/export%20pdf/export_pdf_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/manager/renew%20contract%20cubit/renew_contract_cubit.dart';
// Technician - Common
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/data/repositories/technician_clients_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/repositories/contracts_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/contract_cubit/contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/contract_details_cubit/contract_details_cubit.dart';
// Technician - Reports
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/repositories/report_question_malfunction_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/data/repositories/report_question_periodic_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/data/repositories/technician_reports_repo.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/presentation/cubit/reports_cubit.dart';
// Auth
import 'package:fuji_maintenance_system/shared/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fuji_maintenance_system/shared/features/auth/domain/repositories/auth_repository.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/controllers/auth_service.dart';
import 'package:get_it/get_it.dart';

/// Global service locator instance
final GetIt getIt = GetIt.instance;

/// Top-level setup that composes smaller section initializers.
Future<void> setupLocator() async {
  // Core services (DB + Hive)
  await _setupLocalDataManager();
  await _setupHiveManager();

  // Network
  _setupApiService();

  // Localization
  _setupLocalization();

  // Config Service
  _setupConfigService();

  // Utilities
  _setupImagePicker();

  // Feature registrations
  _registerRepositories();
  _registerCubits();
}

/* --------------------
   CORE: local storage
   -------------------- */
Future<void> _setupLocalDataManager() async {
  final localDataManager = await GetStorageManagerImpl().init();
  getIt.registerSingleton<LocalDataManager>(localDataManager);
}

/* --------------------
   CORE: Hive manager
   -------------------- */
Future<void> _setupHiveManager() async {
  final hiveManager = HiveManager();
  await hiveManager.init();
  getIt.registerSingleton<HiveManager>(hiveManager);
}

/* --------------------
   NETWORK
   -------------------- */
void _setupApiService() {
  getIt.registerSingleton<ApiService>(ApiService());
  ApiService.init();
}

/* --------------------
   LOCALIZATION
   -------------------- */
void _setupLocalization() {
  getIt.registerSingleton<LocaleService>(
    LocaleService(getIt<LocalDataManager>()),
  );
}

/* --------------------
   CONFIG SERVICE
   -------------------- */
void _setupConfigService() {
  getIt.registerLazySingleton<ConfigService>(
    () => ConfigService(getIt<ApiService>()),
  );
}

/* --------------------
   UTILITIES
   -------------------- */
void _setupImagePicker() {
  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(),
  );
}

/* --------------------
   REPOSITORIES
   -------------------- */
void _registerRepositories() {
  getIt.registerLazySingleton<MaintenanceContractSectionsRepo>(
    () => MaintenanceContractSectionsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<MaintenanceContractPeriodicityRepo>(
    () => MaintenanceContractPeriodicityRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ElevatorTypeRepo>(
    () => ElevatorTypeRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ElevatorBrandRepo>(
    () => ElevatorBrandRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AddClientRepo>(
    () => AddClientRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ContractsRepo>(
    () => ContractsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ReportQuestionPeriodicRepo>(
    () => ReportQuestionPeriodicRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ReportQuestionMalfunctionRepo>(
    () => ReportQuestionMalfunctionRepoImple(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AddContractRepo>(
    () => AddContractRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<QuestionsRepo>(
    () => QuestionsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ClientsRepo>(
    () => ClientsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AdminContractsRepo>(
    () => AdminContractsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AdminReportsRepo>(
    () => AdminReportsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<TechniciansRepo>(
    () => TechniciansRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<TechnicianClientsRepo>(
    () => TechnicianClientsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ClientHomeRepo>(
    () => ClientHomeRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ContractRenewRequestsRepo>(
    () => ContractRenewRequestsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<LocationUpdateRequestsRepo>(
    () => LocationUpdateRequestsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SeeDetailsRepository>(
    () => SeeDetailsRepositoryImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      localDataManager: getIt<LocalDataManager>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<TechnicianReportsRepo>(
    () => TechnicianReportsRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<VisitsRepo>(() => VisitsRepoImpl());

  getIt.registerLazySingleton<CitiesRepo>(
    () => CitiesRepo(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<NeighborhoodsRepo>(
    () => NeighborhoodsRepo(getIt<ApiService>()),
  );
}

/* --------------------
   CUBITS / FACTORIES
   -------------------- */
void _registerCubits() {
  getIt.registerFactory(
    () => MaintenanceContractSectionsCubit(
      getIt<MaintenanceContractSectionsRepo>(),
    ),
  );

  getIt.registerFactory(
    () => MaintenanceContractPeriodicityCubit(
      getIt<MaintenanceContractPeriodicityRepo>(),
    ),
  );

  getIt.registerFactory(() => ElevatorTypesCubit(getIt<ElevatorTypeRepo>()));

  getIt.registerFactory(() => ElevatorBrandsCubit(getIt<ElevatorBrandRepo>()));

  getIt.registerFactory(() => AddClientCubit(getIt<AddClientRepo>()));

  getIt.registerFactory(() => ContractsCubit(getIt<ContractsRepo>()));

  getIt.registerFactory(() => ContractDetailsCubit(getIt<ContractsRepo>()));

  getIt.registerFactory(
    () => ReportQuestionPeriodicCubit(getIt<ReportQuestionPeriodicRepo>()),
  );

  getIt.registerFactory(
    () =>
        ReportQuestionMalfunctionCubit(getIt<ReportQuestionMalfunctionRepo>()),
  );

  getIt.registerFactory(
    () => AddContractCubit(
      getIt<AddContractRepo>(),
      getIt<ElevatorTypeRepo>(),
      getIt<ElevatorBrandRepo>(),
      getIt<MaintenanceContractSectionsRepo>(),
      getIt<MaintenanceContractPeriodicityRepo>(),
    ),
  );

  getIt.registerFactory(() => ReportQuestionsCubit(getIt<QuestionsRepo>()));

  getIt.registerFactory(
    () => ClientsCubit(
      getIt<ClientsRepo>(),
      getIt<CitiesRepo>(),
      getIt<NeighborhoodsRepo>(),
    ),
  );

  getIt.registerFactory(() => ClientDetailsCubit(getIt<ClientsRepo>()));

  getIt.registerFactory(() => AdminContractsCubit(getIt<AdminContractsRepo>()));

  getIt.registerFactory(() => ReportsCubit(getIt<AdminReportsRepo>()));

  getIt.registerFactory(() => TechniciansCubit(getIt<TechniciansRepo>()));

  getIt.registerFactory(() => TechnicianReportsCubit(getIt<TechniciansRepo>()));

  getIt.registerFactory(() => CustomersCubit(getIt<TechnicianClientsRepo>()));

  getIt.registerFactory(
    () => TechnicianAllReportsCubit(getIt<TechnicianReportsRepo>()),
  );

  getIt.registerFactory(() => HomeCubit(getIt<ClientHomeRepo>()));

  getIt.registerFactory(() => RenewContractCubit(getIt<ClientHomeRepo>()));

  getIt.registerFactory(
    () => ContractRenewRequestsCubit(getIt<ContractRenewRequestsRepo>()),
  );

  getIt.registerFactory(
    () => LocationUpdateRequestsCubit(getIt<LocationUpdateRequestsRepo>()),
  );

  getIt.registerFactory(() => OrdersCubit(getIt<OrderRepository>()));

  getIt.registerFactory(
    () => SeeDetailsOrderCubit(getIt<SeeDetailsRepository>()),
  );

  getIt.registerFactory(() => ExportPdfCubit(getIt<ClientHomeRepo>()));

  getIt.registerFactory(() => VisitsCubit(getIt<VisitsRepo>()));
}
