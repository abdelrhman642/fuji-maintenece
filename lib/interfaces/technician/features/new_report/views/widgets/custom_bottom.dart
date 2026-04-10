import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({
    this.padding,
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.onPressed,
  });
  final String title;
  final Color backgroundColor;
  final Callback onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            shadowColor: Colors.black.withOpacity(0.35),
          ).merge(
            ButtonStyle(
              elevation: WidgetStateProperty.resolveWith<double>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return 12;
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return 6;
                }
                return 0;
              }),
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColor.white.withOpacity(0.08);
                }
                return null;
              }),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title.tr,
            style: TextStyle(
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
