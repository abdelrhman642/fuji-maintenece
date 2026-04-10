import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:get/get.dart';

class CustomExpandedButtom extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color borderColor;
  final Color? textColor;
  final double borderRadius;
  final double verticalPadding;
  final Color backgroundColor;

  const CustomExpandedButtom({
    super.key,
    required this.text,
    this.onPressed,
    this.borderColor = AppColor.primary,
    this.textColor,
    this.borderRadius = 14,
    this.verticalPadding = 14,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
        ),
        child: Text(
          text.tr,
          style: theme.textTheme.labelLarge?.copyWith(
            color: textColor ?? borderColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
