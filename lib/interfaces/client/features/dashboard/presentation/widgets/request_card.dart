import 'package:flutter/material.dart';

import '../../../../../../core/models/maintenance_models.dart';

/// Card widget for displaying maintenance request information
class RequestCard extends StatelessWidget {
  final MaintenanceRequest request;
  final VoidCallback? onTap;
  final bool showTechnician;

  const RequestCard({
    super.key,
    required this.request,
    this.onTap,
    this.showTechnician = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with title and priority
              Row(
                children: [
                  Expanded(
                    child: Text(
                      request.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildPriorityChip(),
                ],
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                request.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Location and status row
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      request.location,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(),
                ],
              ),
              const SizedBox(height: 8),

              // Date and technician info
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(request.createdAt),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  if (showTechnician && request.technicianName != null)
                    Row(
                      children: [
                        Icon(Icons.build, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          request.technicianName!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                ],
              ),

              // Images indicator
              if (request.images.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${request.images.length} صورة مرفقة',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityChip() {
    Color chipColor;
    String priorityText;

    switch (request.priority.toLowerCase()) {
      case 'high':
      case 'عالية':
        chipColor = Colors.red;
        priorityText = 'عالية';
        break;
      case 'medium':
      case 'متوسطة':
        chipColor = Colors.orange;
        priorityText = 'متوسطة';
        break;
      case 'low':
      case 'منخفضة':
        chipColor = Colors.green;
        priorityText = 'منخفضة';
        break;
      default:
        chipColor = Colors.grey;
        priorityText = request.priority;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        priorityText,
        style: TextStyle(
          color: chipColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    String statusText;
    IconData iconData;

    switch (request.status.toLowerCase()) {
      case 'pending':
      case 'معلق':
        chipColor = Colors.orange;
        statusText = 'معلق';
        iconData = Icons.pending;
        break;
      case 'in_progress':
      case 'قيد التنفيذ':
        chipColor = Colors.blue;
        statusText = 'قيد التنفيذ';
        iconData = Icons.engineering;
        break;
      case 'completed':
      case 'مكتمل':
        chipColor = Colors.green;
        statusText = 'مكتمل';
        iconData = Icons.check_circle;
        break;
      case 'cancelled':
      case 'ملغي':
        chipColor = Colors.red;
        statusText = 'ملغي';
        iconData = Icons.cancel;
        break;
      default:
        chipColor = Colors.grey;
        statusText = request.status;
        iconData = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 12, color: chipColor),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              color: chipColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'اليوم ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return 'أمس ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
