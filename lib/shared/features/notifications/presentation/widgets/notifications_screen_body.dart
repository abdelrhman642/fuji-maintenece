import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/data/models/notification_model/notification_model.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/presentation/widgets/notification_card.dart';

/// Body widget for notifications screen
class NotificationsScreenBody extends StatelessWidget {
  const NotificationsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return NotificationCard(
          notification: NotificationModel(
            id: index,
            isRead: index % 2 == 1,
            title: 'اسم الاشعار $index',
            message: 'هذه هي رسالة الاشعار رقم $index.',
            type: 'order',

            createdAt: DateTime.now().subtract(Duration(minutes: index * 5)),
          ),
        );
      },
    );
  }
}
