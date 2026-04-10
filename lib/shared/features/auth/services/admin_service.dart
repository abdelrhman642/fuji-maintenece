/// Admin service for administrative operations
class AdminService {
  static final AdminService instance = AdminService._internal();
  AdminService._internal();

  /// Get total number of users
  Future<int> getTotalUsers() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return 145;
  }

  /// Get active work orders count
  Future<int> getActiveWorkOrders() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return 23;
  }

  /// Get available technicians count
  Future<int> getAvailableTechnicians() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return 12;
  }

  /// Get completed tasks for today
  Future<int> getCompletedToday() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return 8;
  }
}
