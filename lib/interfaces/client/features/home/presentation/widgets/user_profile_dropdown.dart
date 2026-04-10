import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// A dropdown menu widget for user profile actions
class UserProfileDropdown extends StatelessWidget {
  const UserProfileDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz, color: AppColor.black, size: 24),
      color: AppColor.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (String value) {
        _handleMenuSelection(context, value);
      },
      itemBuilder:
          (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'profile',
              child: Row(
                children: [
                  Icon(Icons.settings, color: AppColor.primary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'settings'.tr,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'notifications',
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: AppColor.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'notifications'.tr,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }

  /// Handles menu item selection
  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'profile':
        // Navigate to settings screen
        context.push(Routes.profile);
        break;
      case 'notifications':
        // Navigate to notifications screen
        // context.push(Routes.notifications);
        _showComingSoon(context, 'Notifications');
        break;
    }
  }

  /// Shows a "coming soon" message for unimplemented features
  void _showComingSoon(BuildContext context, String feature) {
    context.showInfo('$feature feature coming soon!');
  }
}
