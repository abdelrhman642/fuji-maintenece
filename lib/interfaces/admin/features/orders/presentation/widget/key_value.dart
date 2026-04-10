import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;

  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: (labelStyle ?? theme.textTheme.bodyMedium)?.copyWith(
              color: AppColor.black.withOpacity(0.8),
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}
