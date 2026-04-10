/// Application route constants organized by feature and user type
class Routes {
  // ============================================================================
  // Authentication Routes
  // ============================================================================
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String accountTypeSelection = '/account-type';
  static const String accountNotActivatedScreen = '/account-not-activated';

  // ============================================================================
  // Common/Shared Routes
  // ============================================================================
  static const String home = '/home';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  // ============================================================================
  // Contract & Maintenance Setup Routes
  // ============================================================================
  static const String maintenanceContractPeriodicityScreen =
      '/maintenance-contract-periodicity';
  static const String maintenanceContractSectionsScreen =
      '/maintenance-contract-sections';
  static const String contractValidityScreen = '/contract-validity';
  static const String contractRenewalRequestsScreen =
      '/contract-renewal-requests';
  static const String maintenanceType = '/maintenance-type';

  // ============================================================================
  // Configuration/Selection Routes
  // ============================================================================
  static const String elevatorTypesScreen = '/elevator-types';
  static const String elevatorBrandsScreen = '/elevator-brands';
  static const String pickLocationScreen = '/pick-location';
  static const String citiesAndNeighborhoodsScreen =
      '/admin/cities-and-neighborhoods';

  // ============================================================================
  // Maintenance & Report Routes
  // ============================================================================
  static const String periodicMaintenanceReport =
      '/periodic-maintenance-report';
  static const String malfunctionMaintenanceScreen = '/malfunction-maintenance';
  static const String malfunctionReportScreen = '/malfunction-report';
  static const String reportQuestionsScreen = '/report-questions';
  static const String sendReport = '/send-report';

  // ============================================================================
  // Client-Related Routes
  // ============================================================================
  static const String customers = '/customers';
  static const String customerScreen = '/customer';
  static const String clientDetailsScreen = '/client-details';
  static const String addAClient = '/add-client';

  // ============================================================================
  // Technician Routes
  // ============================================================================
  static const String technicians = '/technicians';
  static const String technicianScreen = '/technician/screen';

  // ============================================================================
  // General Routes
  // ============================================================================
  static const String reports = '/reports';
  static const String visitsScreen = '/visits';
  static const String locationUpdateRequestsScreen =
      '/location-update-requests';

  // ============================================================================
  // Admin Dashboard Routes
  // ============================================================================
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminReports = '/admin/reports';
  static const String adminSettings = '/admin/settings';
  static const String adminWorkOrders = '/admin/work-orders';
  static const String adminTechnicians = '/admin/technicians';
  static const String adminTechnicianReports = '/admin/technician-reports';
  static const String clientsAdminScreen = '/admin/clients';
  static const String addContractScreen = '/admin/contracts';
  static const String ordersAdminScreen = '/admin/orders';
  static const String notificationsScreen = '/admin/notifications';

  // ============================================================================
  // Technician Dashboard Routes
  // ============================================================================
  static const String technicianDashboard = '/technician/dashboard';
  static const String technicianWorkOrders = '/technician/work-orders';
  static const String technicianProfile = '/technician/profile';
  static const String technicianSchedule = '/technician/schedule';
  static const String technicianReports = '/technician/reports';

  // ============================================================================
  // Client Dashboard Routes
  // ============================================================================
  static const String clientDashboard = '/client/dashboard';
  static const String clientRequests = '/client/requests';
  static const String clientHistory = '/client/history';
  static const String clientProfile = '/client/profile';
  static const String clientSupport = '/client/support';
  static const String reportTechnicalScreen = '/client/report-technical';

  // ============================================================================
  // Other Routes
  // ============================================================================
  static const String orderDetailsScreen = '/order-details';
}

/// User types enum for better type safety
enum UserType {
  admin('admin', 'مدير'),
  technician('technician', 'فني'),
  client('client', 'عميل');

  const UserType(this.key, this.displayName);

  final String key;
  final String displayName;
}
