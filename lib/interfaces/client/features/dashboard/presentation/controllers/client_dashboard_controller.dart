import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/models/maintenance_models.dart';

/// Data model for client dashboard
class ClientDashboardData {
  final List<MaintenanceRequest> recentRequests;
  final int totalRequests;
  final int pendingRequests;
  final int completedRequests;
  final List<MaintenanceRequest> urgentRequests;

  ClientDashboardData({
    required this.recentRequests,
    required this.totalRequests,
    required this.pendingRequests,
    required this.completedRequests,
    required this.urgentRequests,
  });
}

/// Client Dashboard Controller
class ClientDashboardController extends AsyncNotifier<ClientDashboardData> {
  @override
  Future<ClientDashboardData> build() async {
    return _loadDashboardData();
  }

  /// Load dashboard data
  Future<ClientDashboardData> _loadDashboardData() async {
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Mock data for demonstration
      final recentRequests = [
        MaintenanceRequest(
          id: '1',
          title: 'تسريب في السباكة',
          description: 'تسريب مياه في حمام الطابق الأول',
          location: 'المكتب الرئيسي - الطابق الأول',
          priority: 'high',
          status: 'in_progress',
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
          clientId: 'client1',
          technicianId: 'tech1',
          technicianName: 'أحمد محمد',
          images: ['image1.jpg', 'image2.jpg'],
        ),
        MaintenanceRequest(
          id: '2',
          title: 'صيانة أجهزة الكمبيوتر',
          description: 'فحص وصيانة أجهزة الكمبيوتر في قسم المحاسبة',
          location: 'قسم المحاسبة',
          priority: 'medium',
          status: 'pending',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          clientId: 'client1',
          images: [],
        ),
        MaintenanceRequest(
          id: '3',
          title: 'تنظيف المكاتب',
          description: 'تنظيف شامل للمكاتب والممرات',
          location: 'جميع الطوابق',
          priority: 'low',
          status: 'completed',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          completedAt: DateTime.now().subtract(const Duration(hours: 12)),
          clientId: 'client1',
          technicianId: 'tech2',
          technicianName: 'فاطمة أحمد',
          images: ['image3.jpg'],
        ),
      ];

      return ClientDashboardData(
        recentRequests: recentRequests,
        totalRequests: 15,
        pendingRequests: 2,
        completedRequests: 12,
        urgentRequests:
            recentRequests.where((r) => r.priority == 'high').toList(),
      );
    } catch (e) {
      throw Exception('فشل في تحميل بيانات لوحة التحكم: $e');
    }
  }

  /// Create new maintenance request
  Future<void> createRequest({
    required String title,
    required String description,
    required String location,
    required String priority,
    List<String> images = const [],
  }) async {
    try {
      // TODO: Implement API call to create request
      await Future.delayed(const Duration(seconds: 1));

      // Refresh data after creating request
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('فشل في إنشاء طلب الصيانة: $e');
    }
  }

  /// Cancel maintenance request
  Future<void> cancelRequest(String requestId) async {
    try {
      // TODO: Implement API call to cancel request
      await Future.delayed(const Duration(milliseconds: 500));

      // Refresh data after canceling request
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('فشل في إلغاء طلب الصيانة: $e');
    }
  }

  /// Rate completed request
  Future<void> rateRequest(
    String requestId,
    double rating,
    String? comment,
  ) async {
    try {
      // TODO: Implement API call to rate request
      await Future.delayed(const Duration(milliseconds: 500));

      // Refresh data after rating
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('فشل في تقييم الطلب: $e');
    }
  }

  /// Refresh dashboard data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadDashboardData());
  }
}

/// Provider for Client Dashboard Controller
final clientDashboardControllerProvider =
    AsyncNotifierProvider<ClientDashboardController, ClientDashboardData>(
      () => ClientDashboardController(),
    );
