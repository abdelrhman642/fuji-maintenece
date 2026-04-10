import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class SuccessContainer extends StatelessWidget {
  const SuccessContainer({
    super.key,
    required this.message,
    required this.bgColor,

    required this.accent,
    this.radius = 28,
  });

  final String message;
  final Color bgColor;
  final Color accent;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.22),
              blurRadius: 20,
              spreadRadius: -8,
            ),
            BoxShadow(
              color: AppColor.black.withOpacity(0.12),
              blurRadius: 32,
              spreadRadius: 0,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DoubleRingCheck(accent: accent),
            SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColor.black,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleRingCheck extends StatelessWidget {
  const DoubleRingCheck({super.key, required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    const double outerSize = 124;
    const double innerSize = 104;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: outerSize,
            height: outerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 3),
            ),
          ),

          Container(
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent,
              border: Border.all(color: AppColor.white, width: 8),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Icon(Icons.check, color: AppColor.white, size: 48),
        ],
      ),
    );
  }
}
