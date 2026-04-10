import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bg =
        isActive
            ? AppColor.success.withOpacity(0.12)
            : AppColor.error.withOpacity(0.10);
    final fg = isActive ? AppColor.success : AppColor.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(0.35)),
      ),
      child: Text(
        isActive ? AppStrings.activeLabel.tr : AppStrings.inactiveLabel.tr,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
