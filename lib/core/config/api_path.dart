abstract class ApiPath {
  /// Base URLs
  static const String baseurl = 'https://maintenance.fujijapanelevators.com/';
  static const String imageurl =
      'https://maintenance.fujijapanelevators.com/storage/';

  // ============================================================================
  // AUTHENTICATION ENDPOINTS
  // ============================================================================

  static const String login = 'api/login';
  static const String register = 'api/register/technician';
  static const String logout = 'api/logout';
  static const String refreshToken = 'api/auth/refresh';
  static const String forgotPassword = 'api/auth/forgot-password';
  static const String resetPassword = 'api/auth/reset-password';
  static const String verifyEmail = 'api/auth/verify-email';
  static const String config = '/api/config';

  // ============================================================================
  // USER MANAGEMENT ENDPOINTS
  // ============================================================================

  static const String getCurrentUser = 'api/user';
  static const String profile = 'api/profile';
  static const String updateProfile = 'api/profile';
  static const String changePassword = 'api/user/change-password';
  static const String deleteAccount = 'api/user/delete-account';
  static const String users = 'api/admin/users';
  static const String deleteUser = 'api/admin/users/delete';
  static const String updateTechnicianStatus =
      'api/admin/update-technician-status';
  static const String createClient = 'api/admin/create-client';
  static const String getClients = 'api/admin/get-clients';
  static const String getTechnicians = 'api/admin/technicians/get-technicians';

  // ============================================================================
  // WORK ORDERS ENDPOINTS
  // ============================================================================

  static const String workOrders = 'api/work-orders';
  static const String createWorkOrder = 'api/work-orders/create';
  static const String updateWorkOrder = 'api/work-orders/update';
  static const String deleteWorkOrder = 'api/work-orders/delete';
  static const String assignWorkOrder = 'api/work-orders/assign';
  static const String completeWorkOrder = 'api/work-orders/complete';
  static const String workOrderHistory = 'api/work-orders/history';
  static const String myWorkOrders = 'api/work-orders/my-orders';

  // ============================================================================
  // EQUIPMENT MANAGEMENT ENDPOINTS
  // ============================================================================

  static const String equipment = 'api/equipment';
  static const String createEquipment = 'api/equipment/create';
  static const String updateEquipment = 'api/equipment/update';
  static const String deleteEquipment = 'api/equipment/delete';
  static const String equipmentHistory = 'api/equipment/history';
  static const String equipmentMaintenance =
      'api/equipment/maintenance-schedule';

  // ============================================================================
  // MAINTENANCE SCHEDULING ENDPOINTS
  // ============================================================================

  static const String maintenanceSchedule = 'api/maintenance/schedule';
  static const String createSchedule = 'api/maintenance/schedule/create';
  static const String updateSchedule = 'api/maintenance/schedule/update';
  static const String deleteSchedule = 'api/maintenance/schedule/delete';
  static const String upcomingMaintenance = 'api/maintenance/upcoming';
  static const String overdueMaintenance = 'api/maintenance/overdue';

  // ============================================================================
  // REPORTS & ANALYTICS ENDPOINTS
  // ============================================================================

  static const String reports = 'api/reports';
  static const String getReports = 'api/reports/get-reports';
  static const String workOrderReports = 'api/reports/work-orders';
  static const String equipmentReports = 'api/reports/equipment';
  static const String maintenanceReports = 'api/reports/maintenance';
  static const String performanceMetrics = 'api/reports/performance';
  static const String technicianReports = 'api/technician/reports';
  static const String submitReportData = 'api/technician/reports/store-report';

  // ============================================================================
  // NOTIFICATIONS ENDPOINTS
  // ============================================================================

  static const String notifications = 'api/notifications';
  static const String markAsRead = 'api/notifications/mark-read';
  static const String markAllAsRead = 'api/notifications/mark-all-read';
  static const String notificationSettings = 'api/notifications/settings';

  // ============================================================================
  // FILE UPLOAD ENDPOINTS
  // ============================================================================

  static const String uploadImage = 'api/upload/image';
  static const String uploadDocument = 'api/upload/document';
  static const String deleteFile = 'api/upload/delete';

  // ============================================================================
  // LOCATION MANAGEMENT ENDPOINTS
  // ============================================================================

  static const String locations = 'api/locations';
  static const String createLocation = 'api/locations/create';
  static const String updateLocation = 'api/locations/update';
  static const String deleteLocation = 'api/locations/delete';
  static const String updateClientLocation = 'api/update-client-location';

  // ============================================================================
  // INVENTORY ENDPOINTS
  // ============================================================================

  static const String inventory = 'api/inventory';
  static const String createInventoryItem = 'api/inventory/create';
  static const String updateInventoryItem = 'api/inventory/update';
  static const String deleteInventoryItem = 'api/inventory/delete';
  static const String inventoryHistory = 'api/inventory/history';

  // ============================================================================
  // CALENDAR & SCHEDULING ENDPOINTS
  // ============================================================================

  static const String calendar = 'api/calendar';
  static const String scheduleEvents = 'api/calendar/events';
  static const String availableSlots = 'api/calendar/available-slots';

  // ============================================================================
  // SEARCH & FILTERS ENDPOINTS
  // ============================================================================

  static const String search = 'api/search';
  static const String searchWorkOrders = 'api/search/work-orders';
  static const String searchEquipment = 'api/search/equipment';
  static const String searchUsers = 'api/search/users';

  // ============================================================================
  // DASHBOARD & ANALYTICS
  // ============================================================================

  static const String dashboard = 'api/dashboard/summary';
  static String adminDashboard = 'api/admin/statistics/dashboard';

  // ============================================================================
  // CONTRACT MANAGEMENT ENDPOINTS
  // ============================================================================

  static const String getAllContracts = 'api/contracts/get-all-contracts';
  static const String getContracts = 'api/contracts/get-all-contracts';
  static const String getMyContracts = 'api/client/contracts/my-contracts';
  static const String storeContract = 'api/admin/contracts/store-contract';

  // Contract renewal
  static const String contractRenewalRequests =
      'api/admin/contract-renewal-requests/get-requests';
  static const String getContractRenewalRequests =
      'api/admin/contract-renewal-requests/get-requests';
  static const String storeContractRenewal =
      'api/client/contract-renewal-requests/store-request';

  // ============================================================================
  // CONTRACT SECTIONS MANAGEMENT
  // ============================================================================

  static const String getContractSections =
      'api/admin/maintenance-contract-sections/get-sections';
  static const String getActiveContractSections =
      'api/admin/maintenance-contract-sections/get-active-sections';
  static const String storeContractSection =
      'api/admin/maintenance-contract-sections/store-section';

  // ============================================================================
  // CONTRACT DURATION MANAGEMENT
  // ============================================================================

  static const String getContractDurations =
      'api/admin/contract-duration/get-durations';
  static const String getActiveContractDurations =
      'api/admin/contract-duration/get-active-durations';
  static const String storeContractDuration =
      'api/admin/contract-duration/store-duration';

  // ============================================================================
  // ELEVATOR TYPES MANAGEMENT
  // ============================================================================

  static const String getElevatorTypes = 'api/admin/elevator-types/get-types';
  static const String getActiveElevatorTypes =
      'api/admin/elevator-types/get-active-types';
  static const String storeElevatorType = 'api/admin/elevator-types/store-type';

  // ============================================================================
  // ELEVATOR MODELS MANAGEMENT
  // ============================================================================

  static const String getElevatorModels =
      'api/admin/elevator-models/get-models';
  static const String getActiveElevatorModels =
      'api/admin/elevator-models/get-active-models';
  static const String storeElevatorModel =
      'api/admin/elevator-models/store-model';

  // ============================================================================
  // REPORT QUESTIONS MANAGEMENT
  // ============================================================================

  static const String getQuestions = 'api/admin/report-questions/get-questions';
  static const String storeQuestion =
      'api/admin/report-questions/store-question';

  // ============================================================================
  // TECHNICIAN ENDPOINTS
  // ============================================================================

  static const String getTechnicianClients = 'api/technician/get-clients';

  // ============================================================================
  // LOCATION UPDATE REQUESTS
  // ============================================================================

  static String getLocationUpdateRequests =
      'api/admin/location-update-requests/get-requests';

  // ============================================================================
  // DYNAMIC ENDPOINTS (Methods with parameters)
  // ============================================================================

  // Contract Sections
  static String updateContractSection(int id) =>
      'api/admin/maintenance-contract-sections/$id/update-section';
  static String getActiveContractSection(int id) =>
      'api/admin/maintenance-contract-sections/$id/active-section';
  static String deactivateContractSection(int id) =>
      'api/admin/maintenance-contract-sections/$id/deactivate-section';
  static String editContractSection(int id) =>
      'api/admin/maintenance-contract-sections/$id/edit-section';
  static String deleteContractSection(int id) =>
      'api/admin/maintenance-contract-sections/$id/delete';

  // Contract Duration
  static String updateContractDuration(int id) =>
      'api/admin/contract-duration/$id/update-duration';
  static String getActiveContractDuration(int id) =>
      'api/admin/contract-duration/$id/active-duration';
  static String deactivateContractDuration(int id) =>
      'api/admin/contract-duration/$id/deactivate-duration';
  static String editContractDuration(int id) =>
      'api/admin/contract-duration/$id/edit-duration';
  static String deleteContractDuration(int id) =>
      'api/admin/contract-duration/$id/delete';

  // Elevator Types
  static String updateElevatorType(int id) =>
      'api/admin/elevator-types/$id/update-type';
  static String getActiveElevatorType(int id) =>
      'api/admin/elevator-types/$id/active-type';
  static String deactivateElevatorType(int id) =>
      'api/admin/elevator-types/$id/deactivate-type';
  static String editElevatorType(int id) =>
      'api/admin/elevator-types/$id/edit-type';
  static String deleteElevatorType(int id) =>
      'api/admin/elevator-types/$id/delete';

  // Elevator Models
  static String updateElevatorModel(int id) =>
      'api/admin/elevator-models/$id/update-model';
  static String getActiveElevatorModel(int id) =>
      'api/admin/elevator-models/$id/active-model';
  static String deactivateElevatorModel(int id) =>
      'api/admin/elevator-models/$id/deactivate-model';
  static String editElevatorModel(int id) =>
      'api/admin/elevator-models/$id/edit-model';
  static String deleteElevatorModel(int id) =>
      'api/admin/elevator-models/$id/delete';

  // Contracts
  static String getContractDetails(int id) =>
      '/api/contracts/$id/show-contract';
  static String getClientContracts(int id) =>
      '/api/contracts/$id/get-contracts';

  // Contract Renewal Requests
  static String showContractRenewalRequest(int id) =>
      'api/admin/contract-renewal-requests/$id/show-request';
  static String approveContractRenewalRequest(int id) =>
      'api/admin/contract-renewal-requests/$id/approve';
  static String rejectContractRenewalRequest(int id) =>
      'api/admin/contract-renewal-requests/$id/reject';

  // Location Update Requests
  static String approveLocationUpdateRequest(int id) =>
      'api/admin/location-update-requests/$id/approve';
  static String rejectLocationUpdateRequest(int id) =>
      'api/admin/location-update-requests/$id/reject';

  // Reports
  static String downloadReport(int id) => 'api/reports/$id/download-pdf';
  static String downloadReportClient(int id) =>
      'api/client/reports/$id/download-pdf';
  static String downloadContractRenewalRequestPdf(int id) =>
      'api/contract-renewal-requests/$id/pdf';
  static String getTechnicianReports(int id) =>
      'api/admin/technicians/$id/reports-history';

  // Report Questions
  static String deleteQuestion(int id) =>
      'api/admin/report-questions/$id/delete-question';
  static String updateQuestion(int id) =>
      '/api/admin/report-questions/$id/update-question';

  // Client Reports
  static const String getMyReports = 'api/client/reports/my-reports';

  // Report Questions (Periodic & Malfunction)
  static String getReportQuestionsPeriodic =
      '/api/technician/report-questions/periodic/get-questions';
  static String getReportQuestionsMalfunction =
      '/api/technician/report-questions/faults/get-questions';

  //
  static String updateTechnician(int id) => '/api/admin/technicians/$id/update';
  static String updateClient(int id) => '/api/admin/clients/$id/update';

  // ============================================================================
  // CITIES MANAGEMENT ENDPOINTS
  // ============================================================================

  static const String getCities = 'api/admin/cities/get-cities';
  static const String getActiveCities = 'api/admin/cities/get-active-cities';
  static const String storeCity = 'api/admin/cities/store-city';

  static String updateCity(int id) => 'api/admin/cities/$id/update-city';
  static String toggleCity(int id) => 'api/admin/cities/$id/toggle-city';
  static String deleteCity(int id) => 'api/admin/cities/$id/delete-city';

  // ============================================================================
  // NEIGHBORHOODS MANAGEMENT ENDPOINTS
  // ============================================================================

  static const String getNeighborhoods =
      'api/admin/neighborhoods/get-neighborhoods';
  static const String getActiveNeighborhoods =
      'api/admin/neighborhoods/get-active-neighborhoods';
  static const String storeNeighborhood =
      'api/admin/neighborhoods/store-neighborhood';

  static String getNeighborhoodsByCity(int cityId) =>
      'api/admin/neighborhoods/get-neighborhoods-by-city/$cityId';
  static String updateNeighborhood(int id) =>
      'api/admin/neighborhoods/$id/update-neighborhood';
  static String toggleNeighborhood(int id) =>
      'api/admin/neighborhoods/$id/toggle-neighborhood';
  static String deleteNeighborhood(int id) =>
      'api/admin/cities/$id/delete-neighborhood';
}
