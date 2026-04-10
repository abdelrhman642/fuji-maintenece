import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/models/maintenance_models.dart';

/// Data model for technician dashboard
class TechnicianDashboardData {
  final List<WorkOrderItem> todaysTasks;
  final int completedTasks;
  final int pendingTasks;
  final List<WorkOrderItem> upcomingTasks;

  TechnicianDashboardData({
    required this.todaysTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.upcomingTasks,
  });
}

/// Technician Dashboard Controller
class TechnicianDashboardController
    extends AsyncNotifier<TechnicianDashboardData> {
  @override
  Future<TechnicianDashboardData> build() async {
    return _loadDashboardData();
  }

  /// Load dashboard data
  Future<TechnicianDashboardData> _loadDashboardData() async {
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Mock data for demonstration
      final todaysTasks = [
        WorkOrderItem(
          id: '1',
          title: 'صيانة مكيف الهواء',
          description: 'فحص وتنظيف مكيف الهواء في الطابق الثاني',
          location: 'المبنى الرئيسي - الطابق الثاني',
          priority: 'high',
          status: 'pending',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          scheduledDate: DateTime.now(),
          clientId: 'client1',
          assignedTechnicianId: 'tech1',
        ),
        WorkOrderItem(
          id: '2',
          title: 'إصلاح مصعد',
          description: 'إصلاح عطل في المصعد الكهربائي',
          location: 'المبنى الفرعي - المدخل الرئيسي',
          priority: 'medium',
          status: 'in_progress',
          createdAt: DateTime.now().subtract(const Duration(hours: 4)),
          scheduledDate: DateTime.now().add(const Duration(hours: 2)),
          clientId: 'client2',
          assignedTechnicianId: 'tech1',
        ),
      ];

      return TechnicianDashboardData(
        todaysTasks: todaysTasks,
        completedTasks: 5,
        pendingTasks: 3,
        upcomingTasks: [],
      );
    } catch (e) {
      throw Exception('فشل في تحميل بيانات لوحة التحكم: $e');
    }
  }

  /// Mark task as completed
  Future<void> markTaskCompleted(String taskId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implement API call to mark task completed
      await Future.delayed(const Duration(milliseconds: 500));
      return _loadDashboardData();
    });
  }

  /// Start working on task
  Future<void> startTask(String taskId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implement API call to start task
      await Future.delayed(const Duration(milliseconds: 500));
      return _loadDashboardData();
    });
  }

  /// Refresh dashboard data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadDashboardData());
  }
}

/// Provider for Technician Dashboard Controller
final technicianDashboardControllerProvider = AsyncNotifierProvider<
  TechnicianDashboardController,
  TechnicianDashboardData
>(() => TechnicianDashboardController());
