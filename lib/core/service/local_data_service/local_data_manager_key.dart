abstract class LocalDataManagerKey {
  // Authentication keys
  static const String token = 'user_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userRole = 'user_role';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String isLoggedIn = 'is_logged_in';
  static const String rememberMe = 'remember_me';

  // User preferences
  static const String language = 'selected_language';
  static const String themeMode = 'theme_mode';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String soundEnabled = 'sound_enabled';
  static const String vibrationEnabled = 'vibration_enabled';

  // App settings
  static const String firstTimeUser = 'first_time_user';
  static const String firstLaunch = 'first_launch';
  static const String lastSyncTime = 'last_sync_time';
  static const String offlineMode = 'offline_mode';
  static const String autoSync = 'auto_sync';
  static const String syncInterval = 'sync_interval';
  static const String appConfig = 'app_config';

  // Maintenance system specific
  static const String defaultPriority = 'default_priority';
  static const String autoAssignWorkOrders = 'auto_assign_work_orders';
  static const String workOrderFilters = 'work_order_filters';
  static const String equipmentFilters = 'equipment_filters';
  static const String dashboardLayout = 'dashboard_layout';

  // Location and tracking
  static const String locationPermissionGranted = 'location_permission_granted';
  static const String trackLocation = 'track_location';
  static const String lastKnownLocation = 'last_known_location';

  // Cache keys
  static const String workOrdersCache = 'work_orders_cache';
  static const String equipmentCache = 'equipment_cache';
  static const String usersCache = 'users_cache';
  static const String dashboardCache = 'dashboard_cache';
  static const String notificationsCache = 'notifications_cache';
  static const String vat = 'vat';

  // Offline data
  static const String pendingWorkOrders = 'pending_work_orders';
  static const String offlineImages = 'offline_images';
  static const String offlineDocuments = 'offline_documents';

  // Recent activity
  static const String recentWorkOrders = 'recent_work_orders';
  static const String recentEquipment = 'recent_equipment';
  static const String recentSearches = 'recent_searches';

  // Security
  static const String sessionTimeout = 'session_timeout';
  static const String lastActivity = 'last_activity';
  static const String biometricEnabled = 'biometric_enabled';
  static const String pinEnabled = 'pin_enabled';
  static const String pin = 'user_pin';
}
