import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedbutton extends StatelessWidget {
  CustomElevatedbutton({
    super.key,
    required this.title,
    required this.onPress,
    required this.color,
  });

  final String title;
  final VoidCallback onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.KWhiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
