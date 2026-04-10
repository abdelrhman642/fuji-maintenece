import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.title, this.data});
  final String title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        alignment: Alignment.centerLeft,
        height: 29.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.KSpaceColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.KBlackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data ?? "",
              style: TextStyle(
                color: AppColors.KBlackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
