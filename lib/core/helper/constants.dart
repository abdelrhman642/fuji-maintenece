abstract class Constants {
  static const bool loggerResponse = true;
  static const bool loggerRiverPod = false;

  // Maintenance system specific constants
  static const bool autoAssignLowPriority = true;
  static const bool notifyOnWorkOrderUpdate = true;
  static const bool allowSelfAssignment = false;
  static const bool requirePhotoForCompletion = true;
  static const bool enableLocationTracking = true;

  // Time constants (in minutes)
  static const int sessionTimeout = 30;
  static const int workOrderReminderInterval = 60;
  static const int maintenanceScheduleBuffer = 15;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // File upload limits
  static const int maxImageSizeMB = 5;
  static const int maxDocumentSizeMB = 10;
  static const List<String> allowedImageTypes = [
    '.jpg',
    '.jpeg',
    '.png',
    '.webp',
  ];
  static const List<String> allowedDocumentTypes = [
    '.pdf',
    '.doc',
    '.docx',
    '.txt',
  ];

  // Maintenance priorities
  static const String priorityHigh = 'high';
  static const String priorityMedium = 'medium';
  static const String priorityLow = 'low';

  // Work order statuses
  static const String statusPending = 'pending';
  static const String statusInProgress = 'in_progress';
  static const String statusCompleted = 'completed';
  static const String statusOverdue = 'overdue';
  static const String statusCancelled = 'cancelled';

  // User roles
  static const String roleAdmin = 'admin';
  static const String roleMaintenance = 'maintenance';
  static const String roleUser = 'user';

  // Equipment statuses
  static const String equipmentOperational = 'operational';
  static const String equipmentMaintenance = 'maintenance';
  static const String equipmentOutOfOrder = 'out_of_order';
  static const String equipmentRetired = 'retired';
}
