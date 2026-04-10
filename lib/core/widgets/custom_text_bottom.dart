import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:get/get.dart';

class CustomTextBottom extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  const CustomTextBottom({
    super.key,
    required this.text,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.sizeOf(context).width * 0.5;
    return SizedBox(
      width: buttonWidth,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, color: textColor),
              Text(
                text.tr,
                style: AppFont.font16W500Black.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
