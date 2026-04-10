import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/reports/presentation/screens/malfunction_crash_report_view.dart';
import 'package:flutter_project/features/reports/presentation/screens/report_details_view.dart';
import 'package:flutter_project/core/widgets/custom_ElevatedButton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MaintenanceView extends ConsumerWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.KWhiteColor,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 429.h,
              width: 244.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.25),
                    offset: const Offset(3, 4),
                    blurRadius: 4,
                  ),
                ],
                color: AppColors.KPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(55),
                  bottomRight: Radius.circular(55),
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    'select maintenance of type ',
                    style: TextStyle(
                      color: AppColors.KWhiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 243.h,
                    width: 243.w,
                    decoration: BoxDecoration(
                      color: AppColors.KWhiteColor,
                      borderRadius: BorderRadius.circular(55),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(33.0),
                      child: Image.asset(AppImages.logo),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomElevatedbutton(
              title: 'Periodically',
              onPress: () {
                context.go('/report-details');
              },
              color: AppColors.KBlackColor,
            ),
            SizedBox(height: 17.h),
            CustomElevatedbutton(
              title: 'Malfunctions',
              onPress: () {
                context.go('/malfunction-crash-report');
              },
              color: AppColors.KPrimaryColor,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
