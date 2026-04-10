import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/presentation/widgets/notifications_screen_body.dart';
import 'package:get/get.dart';

/// Screen displaying all notifications for the admin
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          AppStrings.notifications.tr,
          style: AppFont.font16W700Black,
        ),
        centerTitle: true,
        backgroundColor: AppColor.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const NotificationsScreenBody(),
    );
  }
}
