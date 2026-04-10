import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/shared/features/notifications/data/models/notification_model/notification_model.dart';
import 'package:intl/intl.dart';

/// Card widget for displaying a single notification
class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationCard({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead ?? false;
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDate =
        notification.createdAt != null
            ? dateFormat.format(notification.createdAt!)
            : '';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isRead ? 1 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color:
          isRead
              ? AppColor.whiteOrGrey
              : AppColor.primaryLightest.withValues(alpha: 0.09),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getNotificationColor(
                    notification.type,
                  ).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationColor(notification.type),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Notification content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      notification.title ?? '',
                      style: AppFont.font16W700Black.copyWith(
                        fontWeight: isRead ? FontWeight.w600 : FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Message
                    Text(
                      notification.message ?? '',
                      style: AppFont.font14W500Grey2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (formattedDate.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(formattedDate, style: AppFont.font12w500Grey2),
                    ],
                  ],
                ),
              ),
              // Read indicator
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'order':
      case 'request':
        return Icons.assignment;
      case 'report':
        return Icons.description;
      case 'contract':
        return Icons.description_outlined;
      case 'system':
        return Icons.settings;
      case 'alert':
      case 'warning':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'order':
      case 'request':
        return AppColor.primary;
      case 'report':
        return Colors.blue;
      case 'contract':
        return Colors.green;
      case 'system':
        return Colors.grey;
      case 'alert':
      case 'warning':
        return Colors.orange;
      default:
        return AppColor.primary;
    }
  }
}
