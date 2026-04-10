import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNotes extends StatelessWidget {
  const CustomNotes({super.key, required this.title, this.controller});
  final String title;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.KPrimaryColor,
              ),
            ),
          ],
        ),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            filled: false,
            fillColor: AppColors.KWhiteColor,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 12.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.KPrimaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
