import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:get/get.dart';

class CustomReportCard extends StatelessWidget {
  const CustomReportCard({
    required super.key,
    required this.name,
    required this.statusText,
    required this.avatarImage,
    required this.onMenuTap,

    required this.onReportsTap,
    required this.isOnline,
    required this.primaryRed,
  });

  final String? name;
  final String? statusText;
  final ImageProvider? avatarImage;
  final VoidCallback? onMenuTap;

  final VoidCallback? onReportsTap;
  final bool isOnline;
  final Color? primaryRed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,

        borderRadius: BorderRadius.circular(18),
      ),
      child: Card(
        elevation: 0,
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onMenuTap,
                    icon: const Icon(Icons.more_horiz),
                    splashRadius: 20,
                  ),

                  const Spacer(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        name!,
                        textAlign: TextAlign.right,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        statusText!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(
                            0.6,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 10),

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage:
                            avatarImage ??
                            const AssetImage(AppAssets.profileImage),
                      ),
                      if (isOnline)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColor.success,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReportsTap,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.primary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Reports'.tr,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: primaryRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
