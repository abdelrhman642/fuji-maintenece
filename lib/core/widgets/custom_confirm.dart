import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomConfirm extends StatelessWidget {
  CustomConfirm({
    super.key,
    required this.title,
    this.color,
    this.border,
    this.textColor,
    required this.onTap,
  });
  final String title;
  final Color? color;
  final Border? border;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 193.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
