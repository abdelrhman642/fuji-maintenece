import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Data model for admin dashboard
class AdminDashboardData {
  final int totalUsers;
  final int activeWorkOrders;
  final int availableTechnicians;
  final int completedToday;
  final List<RecentActivity> recentActivities;

  AdminDashboardData({
    required this.totalUsers,
    required this.activeWorkOrders,
    required this.availableTechnicians,
    required this.completedToday,
    required this.recentActivities,
  });
}

/// Recent activity model
class RecentActivity {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String type;

  RecentActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });
}

/// Admin Dashboard Controller
class AdminDashboardController extends AsyncNotifier<AdminDashboardData> {
  @override
  Future<AdminDashboardData> build() async {
    return _loadDashboardData();
  }

  /// Load dashboard data
  Future<AdminDashboardData> _loadDashboardData() async {
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      return AdminDashboardData(
        totalUsers: 145,
        activeWorkOrders: 23,
        availableTechnicians: 12,
        completedToday: 8,
        recentActivities: [
          RecentActivity(
            id: '1',
            title: 'مهمة جديدة تم إنشاؤها',
            description: 'صيانة مكيف الهواء - المبنى الرئيسي',
            timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
            type: 'work_order',
          ),
          RecentActivity(
            id: '2',
            title: 'فني جديد تم تسجيله',
            description: 'أحمد محمد - تخصص كهرباء',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            type: 'user',
          ),
        ],
      );
    } catch (e) {
      throw Exception('فشل في تحميل بيانات لوحة التحكم: $e');
    }
  }

  /// Refresh dashboard data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadDashboardData());
  }
}

/// Provider for Admin Dashboard Controller
final adminDashboardControllerProvider =
    AsyncNotifierProvider<AdminDashboardController, AdminDashboardData>(
      () => AdminDashboardController(),
    );
