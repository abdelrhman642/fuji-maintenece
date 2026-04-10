import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/widgets/custom_dashboard_app_bar.dart';
import '../controllers/admin_dashboard_controller.dart';
import '../widgets/dashboard_card.dart';

/// Admin Dashboard Screen - Main interface for administrators
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(adminDashboardControllerProvider);

    return Scaffold(
      appBar: CustomDashboardAppBar(
        title: 'لوحة تحكم المدير',
        userType: UserType.admin,
        onLogout: () => context.go(Routes.accountTypeSelection),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(adminDashboardControllerProvider.future),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(context),
              const SizedBox(height: 24),

              // Statistics Cards
              Text(
                'إحصائيات عامة',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              dashboardState.when(
                data: (data) => _buildStatsGrid(data),
                loading: () => const CustomLoadingIndicator(),
                error:
                    (error, stack) =>
                        Center(child: Text('خطأ في تحميل البيانات: $error')),
              ),
              const SizedBox(height: 32),

              // Quick Actions
              Text(
                'الإجراءات السريعة',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildQuickActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.admin_panel_settings, size: 48, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً بك في لوحة تحكم المدير',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'إدارة شاملة لنظام صيانة فوجي',
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

  Widget _buildStatsGrid(AdminDashboardData data) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        StatsCard(
          title: 'إجمالي المستخدمين',
          value: data.totalUsers.toString(),
          icon: Icons.people,
          color: Colors.blue,
        ),
        StatsCard(
          title: 'أوامر العمل النشطة',
          value: data.activeWorkOrders.toString(),
          icon: Icons.assignment,
          color: Colors.orange,
        ),
        StatsCard(
          title: 'الفنيين المتاحين',
          value: data.availableTechnicians.toString(),
          icon: Icons.build,
          color: Colors.green,
        ),
        StatsCard(
          title: 'المهام المكتملة اليوم',
          value: data.completedToday.toString(),
          icon: Icons.check_circle,
          color: Colors.purple,
        ),
      ],
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
        DashboardCard(
          title: 'إدارة المستخدمين',
          subtitle: 'إضافة وتعديل المستخدمين',
          icon: Icons.people_outline,
          onTap: () => context.push(Routes.adminUsers),
        ),
        DashboardCard(
          title: 'أوامر العمل',
          subtitle: 'متابعة أوامر الصيانة',
          icon: Icons.assignment_outlined,
          onTap: () => context.push(Routes.adminWorkOrders),
        ),
        DashboardCard(
          title: 'إدارة الفنيين',
          subtitle: 'تعيين وجدولة الفنيين',
          icon: Icons.engineering_outlined,
          onTap: () => context.push(Routes.adminTechnicians),
        ),
        DashboardCard(
          title: 'التقارير',
          subtitle: 'تقارير الأداء والإحصائيات',
          icon: Icons.analytics_outlined,
          onTap: () => context.push(Routes.adminReports),
        ),
      ],
    );
  }
}
