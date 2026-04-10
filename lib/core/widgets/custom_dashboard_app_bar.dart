import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../shared/features/auth/presentation/controllers/auth_service.dart';
import '../routing/routes.dart';

/// Custom AppBar widget for consistent header across all interfaces
class CustomDashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final UserType userType;
  final VoidCallback? onLogout;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomDashboardAppBar({
    super.key,
    required this.title,
    required this.userType,
    this.onLogout,
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: _getColorForUserType(userType),
      foregroundColor: Colors.white,
      elevation: 0,
      leading:
          showBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              )
              : null,
      actions: [
        if (actions != null) ...actions!,
        // Notification button
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => _showNotifications(context),
        ),
        // User menu
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle),
          onSelected: (value) => _handleMenuAction(context, value),
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(_getIconForUserType(userType)),
                      const SizedBox(width: 8),
                      const Text('الملف الشخصي'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('الإعدادات'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }

  Color _getColorForUserType(UserType userType) {
    switch (userType) {
      case UserType.admin:
        return Colors.purple;
      case UserType.technician:
        return Colors.blue;
      case UserType.client:
        return Colors.green;
    }
  }

  IconData _getIconForUserType(UserType userType) {
    switch (userType) {
      case UserType.admin:
        return Icons.admin_panel_settings;
      case UserType.technician:
        return Icons.build;
      case UserType.client:
        return Icons.person;
    }
  }

  String _getProfileRoute(UserType userType) {
    switch (userType) {
      case UserType.admin:
        return Routes.adminSettings;
      case UserType.technician:
        return Routes.technicianProfile;
      case UserType.client:
        return Routes.clientProfile;
    }
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'profile':
        Navigator.pushNamed(context, _getProfileRoute(userType));
        break;
      case 'settings':
        // TODO: Navigate to settings
        break;
      case 'logout':
        _showLogoutDialog(context);
        break;
    }
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'الإشعارات',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const ListTile(
                  leading: Icon(Icons.info, color: Colors.blue),
                  title: Text('مهمة جديدة تم تعيينها'),
                  subtitle: Text('منذ ساعتين'),
                ),
                const ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('تم إكمال طلب الصيانة'),
                  subtitle: Text('منذ 4 ساعات'),
                ),
                const ListTile(
                  leading: Icon(Icons.warning, color: Colors.orange),
                  title: Text('تذكير: موعد الصيانة غداً'),
                  subtitle: Text('منذ يوم واحد'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('عرض جميع الإشعارات'),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('تسجيل الخروج'),
            content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _performLogout(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('تسجيل الخروج'),
              ),
            ],
          ),
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    // Store the navigator context before any async operations
    final navigator = Navigator.of(context, rootNavigator: true);

    try {
      // Show loading indicator using root navigator
      showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) => const CustomLoadingIndicator(),
      );

      // Get auth service and perform logout
      final container = ProviderScope.containerOf(context);
      final authService = container.read(authServiceProvider);

      await authService.logout();

      // Close loading dialog using root navigator
      navigator.pop();

      // Logout successful, navigate to account type selection
      context.go(Routes.accountTypeSelection);
    } catch (e) {
      // Close loading dialog if still open
      try {
        navigator.pop();
      } catch (_) {
        // Dialog might already be closed
      }

      context.showError('حدث خطأ أثناء تسجيل الخروج');
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
