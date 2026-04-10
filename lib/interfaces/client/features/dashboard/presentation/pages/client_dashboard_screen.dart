import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/models/maintenance_models.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/widgets/custom_dashboard_app_bar.dart';
import '../controllers/client_dashboard_controller.dart';
import '../widgets/request_card.dart';

/// Client Dashboard Screen - Main interface for clients
class ClientDashboardScreen extends ConsumerWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(clientDashboardControllerProvider);

    return Scaffold(
      appBar: CustomDashboardAppBar(
        title: 'لوحة تحكم العميل',
        userType: UserType.client,
        onLogout: () => context.go(Routes.accountTypeSelection),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(clientDashboardControllerProvider.future),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(context),
              const SizedBox(height: 24),

              // Recent Requests
              _buildSectionHeader(context, 'طلبات الصيانة الأخيرة'),
              const SizedBox(height: 16),
              dashboardState.when(
                data: (data) => _buildRecentRequests(data.recentRequests),
                loading: () => const CustomLoadingIndicator(),
                error:
                    (error, stack) =>
                        Center(child: Text('خطأ في تحميل البيانات: $error')),
              ),
              const SizedBox(height: 32),

              // Quick Services
              _buildSectionHeader(context, 'الخدمات السريعة'),
              const SizedBox(height: 16),
              _buildQuickServices(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.clientRequests),
        icon: const Icon(Icons.add),
        label: const Text('طلب صيانة جديد'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.green.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 48, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أهلاً وسهلاً بك',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'نحن هنا لخدمتك في أي وقت',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => context.push(Routes.clientHistory),
          child: const Text('عرض الكل'),
        ),
      ],
    );
  }

  Widget _buildRecentRequests(List<MaintenanceRequest> requests) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.assignment_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'لا توجد طلبات صيانة حالياً',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            // ElevatedButton.icon(
            //   onPressed: () => context.push(Routes.clientRequests),
            //   icon: const Icon(Icons.add),
            //   label: const Text('إنشاء طلب جديد'),
            // ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return RequestCard(request: requests[index]);
      },
    );
  }

  Widget _buildQuickServices(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildServiceCard(
          'طلب صيانة عاجلة',
          'صيانة طارئة',
          Icons.emergency_outlined,
          Colors.red,
          () => _showEmergencyDialog(context),
        ),
        _buildServiceCard(
          'متابعة الطلبات',
          'حالة طلباتك',
          Icons.track_changes,
          Colors.blue,
          () => context.push(Routes.clientHistory),
        ),
        _buildServiceCard(
          'الدعم الفني',
          'تواصل معنا',
          Icons.support_agent,
          Colors.orange,
          () => context.push(Routes.clientSupport),
        ),
        _buildServiceCard(
          'الملف الشخصي',
          'إدارة الحساب',
          Icons.account_circle_outlined,
          Colors.purple,
          () => context.push(Routes.clientProfile),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('طلب صيانة عاجلة'),
            content: const Text(
              'هل تحتاج إلى خدمة صيانة عاجلة؟ سيتم إعطاء طلبك أولوية قصوى.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(
                    Routes.clientRequests,
                    extra: {'emergency': true},
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('تأكيد'),
              ),
            ],
          ),
    );
  }
}
