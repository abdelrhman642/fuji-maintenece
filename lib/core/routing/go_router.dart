import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/cubit/add_client_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/pages/add_client_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/pages/pick_location_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/cubit/add_contract_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/manager/cities_cubit/cities_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/manager/neighborhood_cubit/neighborhood_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/pages/cities_and_neighborhoods_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/client%20details%20cubit/client_details_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/clients%20cubit/clients_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/screen/client_details_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/screen/clients_admin_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/cubit/contract_renew_requests_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/contracts%20cubit/admin_contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/reports%20cubit/reports_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/pages/contract_validity_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20brands%20cubit/elevator_brands_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20types%20cubit/elevator_types_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/pages/elevator_brands_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/pages/elevator_types_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/cubit/location_update_requests_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/pages/location_update_requests_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/cubit/maintenance_contract_periodicity_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/pages/maintenance_contract_periodicity_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/cubit/maintenance_contract_sections_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/pages/maintenance_contract_sections_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/order/orders_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/see_details_order/see_details_order_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/pages/orders_admin_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/pages/see_details_orders.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/cubit/report_questions_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/pages/report_questions_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technician%20reports/technician_reports_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technicians%20cubit/technicians_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/pages/technician_reports_screen.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/presentation/cubit/visits_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/presentation/pages/visits_screen.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/contract_cubit/contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/submit_report_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/presentation/screen/report_technical_screen.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/screens/account_not_activated_screen.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../interfaces/admin/features/add contract/presentation/screen/add_contract_screen.dart';
import '../../interfaces/admin/features/contract renew requests/presentation/pages/contract_renewal_requests_screen.dart';
import '../../interfaces/admin/features/contracts/presentation/pages/reports_screen.dart';
import '../../interfaces/admin/features/dashboard/presentation/pages/admin_dashboard_screen.dart';
import '../../interfaces/admin/features/home/presentation/pages/home_view.dart';
import '../../interfaces/admin/features/technicians/presentation/pages/technicians_view.dart';
import '../../interfaces/client/features/dashboard/presentation/pages/client_dashboard_screen.dart';
import '../../interfaces/client/features/home/presentation/pages/customer_screen.dart';
import '../../interfaces/technician/features/customers/presentation/pages/customers_technical_screen.dart';
import '../../interfaces/technician/features/dashboard/presentation/pages/technician_dashboard_screen.dart';
import '../../interfaces/technician/features/home/presentation/pages/technician_home_screen.dart';
import '../../interfaces/technician/features/new_report/malfunctionMaintenance/presentation/screens/malfunction_maintenance_screen.dart';
import '../../interfaces/technician/features/new_report/malfunctionMaintenance/presentation/screens/malfunction_report_screen.dart';
import '../../interfaces/technician/features/new_report/periodic_maintenance/presentation/screens/periodic_maintenance_report.dart';
import '../../interfaces/technician/features/new_report/views/screens/maintenance_type_screen.dart';
import '../../interfaces/technician/features/new_report/views/screens/send_report_screen.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../shared/features/auth/presentation/screens/account_type_selection_view.dart';
import '../../shared/features/auth/presentation/screens/login_view.dart';
import '../../shared/features/auth/presentation/screens/register_view.dart';
import '../../shared/features/auth/presentation/screens/settings_screen.dart';
import 'routes.dart';

/// Simple router configuration without guards
final GoRouter simpleRouter = GoRouter(
  initialLocation: Routes.splash,
  debugLogDiagnostics: true,
  routes: [
    ..._splashRoutes(),
    ..._authRoutes(),
    ..._adminRoutes(),
    ..._technicianRoutes(),
    ..._clientRoutes(),
    ..._dashboardRoutes(),
  ],
  errorBuilder: _errorBuilder,
);

/// Splash route
List<GoRoute> _splashRoutes() => [
  GoRoute(
    path: Routes.splash,
    name: 'splash',
    builder: (context, state) => const SplashView(),
  ),
];

/// Authentication routes
List<GoRoute> _authRoutes() => [
  GoRoute(
    path: Routes.accountTypeSelection,
    name: 'account-type-selection',
    builder: (context, state) => const AccountTypeSelectionView(),
  ),
  GoRoute(
    path: Routes.login,
    name: 'login',
    builder: (context, state) {
      final userType = state.uri.queryParameters['userType'];
      return LoginView(userType: userType);
    },
  ),
  GoRoute(
    path: Routes.register,
    name: 'register',
    builder: (context, state) {
      final userType = state.uri.queryParameters['userType'];
      return RegisterView(userType: userType);
    },
  ),
  GoRoute(
    path: Routes.accountNotActivatedScreen,
    name: 'account-not-activated',
    builder: (context, state) => AccountNotActivatedScreen(),
  ),
];

/// Admin routes
List<GoRoute> _adminRoutes() => [
  GoRoute(
    path: Routes.home,
    name: 'home',
    builder: (context, state) => const HomeView(),
  ),
  GoRoute(
    path: Routes.notificationsScreen,
    name: 'notifications',
    builder: (context, state) => const NotificationsScreen(),
  ),
  GoRoute(
    path: Routes.addContractScreen,
    name: 'add-contract',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<AddContractCubit>()..fetchInitialData(),
          child: AddContractScreen(),
        ),
  ),
  GoRoute(
    path: Routes.addAClient,
    name: 'add-client',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<AddClientCubit>(),
          child: AddClientScreen(),
        ),
  ),
  GoRoute(
    path: Routes.pickLocationScreen,
    name: 'pick-location',
    builder: (context, state) {
      final initialLocation = state.extra as LatLng?;
      return PickLocationScreen(initialLocation: initialLocation);
    },
  ),
  GoRoute(
    path: Routes.clientsAdminScreen,
    name: 'clientsAdminScreen',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ClientsCubit>()..fetchClients(),
          child: ClientsAdminScreen(),
        ),
  ),
  GoRoute(
    path: Routes.clientDetailsScreen,
    name: 'client-details',
    builder: (context, state) {
      final id = state.extra as int;
      return BlocProvider(
        create:
            (context) => getIt<ClientDetailsCubit>()..fetchClientDetails(id),
        child: ClientDetailsScreen(clientId: id),
      );
    },
  ),
  GoRoute(
    path: Routes.ordersAdminScreen,
    name: 'orders-admin',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<OrdersCubit>()..fetchOrders(),
          child: const OrdersAdminScreen(),
        ),
  ),
  GoRoute(
    path: Routes.orderDetailsScreen,
    name: 'order-details',
    builder: (context, state) {
      final orderId = state.extra as int;
      return BlocProvider(
        create:
            (context) =>
                getIt<SeeDetailsOrderCubit>()..fetchOrderDetails(orderId),
        child: SeeDetailsOrders(orderId: orderId),
      );
    },
  ),
  GoRoute(
    path: Routes.contractValidityScreen,
    name: 'contract-validity',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) => getIt.get<AdminContractsCubit>()..fetchContracts(),
          child: const ContractValidityScreen(),
        ),
  ),
  GoRoute(
    path: Routes.contractRenewalRequestsScreen,
    name: 'contractRenewalRequestsScreen',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) =>
                  getIt<ContractRenewRequestsCubit>()
                    ..fetchContractRenewRequests(),
          child: const ContractRenewalRequestsScreen(),
        ),
  ),
  GoRoute(
    path: Routes.reports,
    name: 'reports',
    builder: (context, state) {
      final contractId = state.extra as int;
      return BlocProvider(
        create: (context) => getIt<ReportsCubit>()..fetchReports(contractId),
        child: ReportsScreen(contractId: contractId),
      );
    },
  ),
  GoRoute(
    path: Routes.reportQuestionsScreen,
    name: 'report-questions',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ReportQuestionsCubit>()..fetchQuestions(),
          child: const ReportQuestionsScreen(),
        ),
  ),
  GoRoute(
    path: Routes.visitsScreen,
    name: 'visits',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<VisitsCubit>(),
          child: const VisitsScreen(),
        ),
  ),
  GoRoute(
    path: Routes.maintenanceContractPeriodicityScreen,
    name: 'maintenance-contract-periodicity',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) =>
                  getIt<MaintenanceContractPeriodicityCubit>()
                    ..fetchPeriodicity(),
          child: const MaintenanceContractPeriodicityScreen(),
        ),
  ),
  GoRoute(
    path: Routes.maintenanceContractSectionsScreen,
    name: 'maintenance-contract-sections',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) =>
                  getIt<MaintenanceContractSectionsCubit>()..fetchSections(),
          child: MaintenanceContractSectionsScreen(),
        ),
  ),
  GoRoute(
    path: Routes.elevatorTypesScreen,
    name: 'elevator-types',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) => getIt<ElevatorTypesCubit>()..fetchAllElevatorTypes(),
          child: const ElevatorTypesScreen(),
        ),
  ),
  GoRoute(
    path: Routes.elevatorBrandsScreen,
    name: 'elevator-brands',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) =>
                  getIt<ElevatorBrandsCubit>()
                    ..fetchAllElevatorBrands()
                    ..fetchAllActiveElevatorTypes(),
          child: const ElevatorBrandsScreen(),
        ),
  ),
  GoRoute(
    path: Routes.technicians,
    name: 'technicians',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<TechniciansCubit>()..fetchTechnicians(),
          child: const TechniciansView(),
        ),
  ),
  GoRoute(
    path: Routes.adminTechnicianReports,
    name: 'admin-technician-reports',
    builder: (context, state) {
      final technicianId = state.extra as int;
      return BlocProvider(
        create:
            (context) =>
                getIt<TechnicianReportsCubit>()
                  ..fetchTechnicianReports(technicianId),
        child: TechnicianReportsScreen(technicianId: technicianId),
      );
    },
  ),
  GoRoute(
    path: Routes.adminUsers,
    name: 'admin-users',
    builder: (context, state) => CustomersTechnicalScreen(),
  ),
  GoRoute(
    path: Routes.adminWorkOrders,
    name: 'admin-work-orders',
    builder: (context, state) => ContractRenewalRequestsScreen(),
  ),
  GoRoute(
    path: Routes.adminTechnicians,
    name: 'admin-technicians',
    builder: (context, state) => const TechniciansView(),
  ),
  GoRoute(
    path: Routes.adminReports,
    name: 'admin-reports',
    builder:
        (context, state) => MaintenanceType(contractId: state.extra as int),
  ),
  GoRoute(
    path: Routes.adminSettings,
    name: 'admin-settings',
    builder:
        (context, state) => const _PlaceholderScreen(
          title: 'إعدادات المدير',
          subtitle: 'قريباً...',
        ),
  ),
  GoRoute(
    path: Routes.citiesAndNeighborhoodsScreen,
    name: 'cities-and-neighborhoods-screen',
    builder:
        (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CitiesCubit(getIt())),
            BlocProvider(create: (context) => NeighborhoodCubit(getIt())),
          ],
          child: CitiesAndNeighborhoodsScreen(),
        ),
  ),
];

/// Technician routes
List<GoRoute> _technicianRoutes() => [
  GoRoute(
    path: Routes.technicianScreen,
    name: 'technicianScreen',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ContractsCubit>()..fetchContracts(),
          child: const TechnicianHomeScreen(),
        ),
  ),
  GoRoute(
    path: Routes.maintenanceType,
    name: 'maintenanceScreen',
    builder:
        (context, state) => MaintenanceType(contractId: state.extra as int),
  ),
  GoRoute(
    path: Routes.periodicMaintenanceReport,
    name: 'periodicMaintenanceReport',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) =>
                  getIt<ReportQuestionPeriodicCubit>()
                    ..fetchReportQuestionsPeriodic(),
          child: PeriodicMaintenanceReport(contractId: state.extra as int),
        ),
  ),
  GoRoute(
    path: Routes.sendReport,
    name: 'sendReport',
    builder:
        (context, state) =>
            SendReportScreen(reportModel: state.extra as SubmitReportModel),
  ),
  GoRoute(
    path: Routes.malfunctionMaintenanceScreen,
    name: 'malfunctionMaintenanceScreen',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) =>
                  getIt<ReportQuestionMalfunctionCubit>()
                    ..fetchReportQuestionsMalfunction(),
          child: MalfunctionMaintenanceScreen(contractId: state.extra as int),
        ),
  ),
  GoRoute(
    path: Routes.malfunctionReportScreen,
    name: 'malfunctionReportScreen',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ReportQuestionMalfunctionCubit>(),
          child: MalfunctionReportScreen(
            storeReportRequestModel: state.extra as StoreReportRequestModel,
          ),
        ),
  ),
  GoRoute(
    path: Routes.customers,
    name: 'customersTechnical',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<CustomersCubit>()..fetchClients(),
          child: CustomersTechnicalScreen(),
        ),
  ),
  GoRoute(
    path: Routes.reportTechnicalScreen,
    name: 'report-technical',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) => getIt<TechnicianAllReportsCubit>()..fetchReports(),
          child: const ReportTechnicalScreen(),
        ),
  ),
  GoRoute(
    path: Routes.technicianWorkOrders,
    name: 'technician-work-orders',
    builder: (context, state) => const ContractRenewalRequestsScreen(),
  ),
  GoRoute(
    path: Routes.technicianSchedule,
    name: 'technician-schedule',
    builder: (context, state) => const TechnicianHomeScreen(),
  ),
  GoRoute(
    path: Routes.technicianReports,
    name: 'technician-reports',
    builder:
        (context, state) => MaintenanceType(contractId: state.extra as int),
  ),
  GoRoute(
    path: Routes.technicianProfile,
    name: 'technician-profile',
    builder:
        (context, state) => const _PlaceholderScreen(
          title: 'الملف الشخصي',
          subtitle: 'قريباً...',
        ),
  ),
];

/// Client routes
List<GoRoute> _clientRoutes() => [
  GoRoute(
    path: Routes.customerScreen,
    name: 'customerScreen',
    builder: (context, state) => const CustomerScreen(),
  ),
  GoRoute(
    path: Routes.profile,
    name: 'profile',
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(
    path: Routes.editProfile,
    name: 'edit-profile',
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(
    path: Routes.locationUpdateRequestsScreen,
    name: 'location-update-requests',
    builder:
        (context, state) => BlocProvider(
          create:
              (context) => getIt<LocationUpdateRequestsCubit>()..loadRequests(),
          child: const LocationUpdateRequestsScreen(),
        ),
  ),
  GoRoute(
    path: Routes.clientRequests,
    name: 'client-requests',
    builder: (context, state) => const ContractRenewalRequestsScreen(),
  ),
  GoRoute(
    path: Routes.clientHistory,
    name: 'client-history',
    builder: (context, state) => const CustomerScreen(),
  ),
  GoRoute(
    path: Routes.clientProfile,
    name: 'client-profile',
    builder:
        (context, state) => const _PlaceholderScreen(
          title: 'الملف الشخصي',
          subtitle: 'قريباً...',
        ),
  ),
  GoRoute(
    path: Routes.clientSupport,
    name: 'client-support',
    builder:
        (context, state) => const _PlaceholderScreen(
          title: 'الدعم الفني',
          subtitle: 'قريباً...',
        ),
  ),
];

/// Dashboard routes
List<GoRoute> _dashboardRoutes() => [
  GoRoute(
    path: Routes.adminDashboard,
    name: 'admin-dashboard',
    builder: (context, state) => const AdminDashboardScreen(),
  ),
  GoRoute(
    path: Routes.technicianDashboard,
    name: 'technician-dashboard',
    builder: (context, state) => const TechnicianDashboardScreen(),
  ),
  GoRoute(
    path: Routes.clientDashboard,
    name: 'client-dashboard',
    builder: (context, state) => const ClientDashboardScreen(),
  ),
];

/// Error builder widget
Widget _errorBuilder(BuildContext context, GoRouterState state) => Scaffold(
  appBar: AppBar(
    title: const Text('خطأ'),
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
  ),
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        Text('خطأ في التنقل', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'الصفحة المطلوبة غير موجودة: ${state.matchedLocation}',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.go(Routes.splash),
          child: const Text('العودة للصفحة الرئيسية'),
        ),
      ],
    ),
  ),
);

/// Placeholder screen for routes under development
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PlaceholderScreen({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 100, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('رجوع'),
            ),
          ],
        ),
      ),
    );
  }
}
