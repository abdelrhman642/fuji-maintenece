import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomReportDetails extends StatelessWidget {
  CustomReportDetails({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 35,
            width: 220,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.KPrimaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70.w,

            decoration: BoxDecoration(
              border: Border.all(color: AppColors.KBlackColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                'Yas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 70.w,

            decoration: BoxDecoration(
              border: Border.all(color: AppColors.KPrimaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                'No',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
