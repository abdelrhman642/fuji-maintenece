import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/maintenance/presentation/screens/vacation_cost_view.dart';
import 'package:flutter_project/features/reports/presentation/screens/crash_report_view.dart';
import 'package:flutter_project/core/widgets/custom_confirm.dart';
import 'package:flutter_project/core/widgets/custom_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MalfunctionCrashreportPage extends ConsumerWidget {
  const MalfunctionCrashreportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.KWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.KPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 20),
        title: Text(
          'Crash Report',
          style: TextStyle(
            color: AppColors.KWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomNotes(title: 'Type of vacation'),
              SizedBox(height: 40.h),
              CustomNotes(title: 'Cause of malfunction'),
              SizedBox(height: 40.h),

              Row(
                children: [
                  Text(
                    'Is the fault fixed?',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.KPrimaryColor,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomConfirm(
                    onTap: () {},
                    title: 'YES',
                    textColor: AppColors.KBlackColor,

                    border: Border.all(color: AppColors.KBlackColor),
                  ),

                  CustomConfirm(
                    onTap: () {},
                    title: 'NO',
                    textColor: AppColors.KPrimaryColor,

                    border: Border.all(color: AppColors.KPrimaryColor),
                  ),
                ],
              ),
              SizedBox(height: 40.h),

              Row(
                children: [
                  Text(
                    '  Spare parts',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.KPrimaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomConfirm(
                    onTap: () {
                      context.go('/vacation-cost');
                    },
                    title: 'YES',
                    textColor: AppColors.KWhiteColor,

                    color: AppColors.KPrimaryColor,
                  ),

                  CustomConfirm(
                    onTap: () {
                      context.go('/crash-report');
                    },
                    title: 'NO',
                    textColor: AppColors.KWhiteColor,

                    color: AppColors.KPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
