import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/models/maintenance_models.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/widgets/custom_dashboard_app_bar.dart';
import '../controllers/technician_dashboard_controller.dart';
import '../widgets/work_order_card.dart';

/// Technician Dashboard Screen - Main interface for technicians
class TechnicianDashboardScreen extends ConsumerWidget {
  const TechnicianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(technicianDashboardControllerProvider);

    return Scaffold(
      appBar: CustomDashboardAppBar(
        title: 'لوحة تحكم الفني',
        userType: UserType.technician,
        onLogout: () => context.go(Routes.accountTypeSelection),
      ),
      body: RefreshIndicator(
        onRefresh:
            () => ref.refresh(technicianDashboardControllerProvider.future),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(context),
              const SizedBox(height: 24),

              // Today's Tasks
              _buildSectionHeader(context, 'مهام اليوم'),
              const SizedBox(height: 16),
              dashboardState.when(
                data: (data) => _buildTodaysTasks(data.todaysTasks),
                loading: () => const CustomLoadingIndicator(),
                error:
                    (error, stack) =>
                        Center(child: Text('خطأ في تحميل البيانات: $error')),
              ),
              const SizedBox(height: 32),

              // Quick Actions
              _buildSectionHeader(context, 'الإجراءات السريعة'),
              const SizedBox(height: 16),
              _buildQuickActions(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.technicianWorkOrders),
        icon: const Icon(Icons.assignment),
        label: const Text('جميع أوامر العمل'),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.blue.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.build, size: 48, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً أيها الفني المتميز',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'لديك مهام جديدة في انتظارك',
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
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTodaysTasks(List<WorkOrderItem> tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.assignment_turned_in, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'لا توجد مهام لليوم',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return WorkOrderCard(workOrder: tasks[index]);
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildActionCard(
          'الجدولة',
          'عرض جدول العمل',
          Icons.schedule,
          () => context.push(Routes.technicianSchedule),
        ),
        _buildActionCard(
          'التقارير',
          'إرسال تقرير المهمة',
          Icons.report,
          () => context.push(Routes.technicianReports),
        ),
        _buildActionCard(
          'الملف الشخصي',
          'تحديث البيانات',
          Icons.person,
          () => context.push(Routes.technicianProfile),
        ),
        _buildActionCard(
          'أوامر العمل',
          'جميع أوامر العمل',
          Icons.assignment,
          () => context.push(Routes.technicianWorkOrders),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
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
              Icon(icon, size: 32, color: Colors.blue),
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
}
