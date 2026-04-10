import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/reports/presentation/screens/sent_report_view.dart';
import 'package:flutter_project/core/widgets/custom_ElevatedButton.dart';
import 'package:flutter_project/core/widgets/custom_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VacationCostView extends ConsumerWidget {
  const VacationCostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.KWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.KPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 20),
        title: Text(
          'Vacation Cost',
          style: TextStyle(
            color: AppColors.KWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 368.h,
            width: double.infinity,
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
                bottomLeft: Radius.circular(250),
                bottomRight: Radius.circular(250),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.25),
                    offset: const Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
                color: AppColors.KWhiteColor,
                borderRadius: BorderRadius.circular(22),
              ),
              height: 676.h,
              width: 345.w,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cost',
                          style: TextStyle(
                            color: AppColors.KPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'VAT',
                          style: TextStyle(
                            color: AppColors.KPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 34.h,
                          width: 232.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.KPrimaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Center(
                            child: Text(
                              '1500 SAR',
                              style: TextStyle(
                                color: AppColors.KBlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 34.h,
                          width: 68.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.KPrimaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '+15%',
                              style: TextStyle(
                                color: AppColors.KBlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    Container(
                      height: 34.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.KPrimaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total =',
                                style: TextStyle(
                                  color: AppColors.KPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '1500 SAR',
                                style: TextStyle(
                                  color: AppColors.KPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Divider(color: AppColors.KPrimaryColor, thickness: 2),
                    SizedBox(height: 30.h),

                    CustomNotes(title: 'General Notes'),
                    SizedBox(height: 30.h),
                    Container(
                      width: double.infinity,
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.KSpaceColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Icon(Icons.image, color: AppColors.KgreyColor),
                            Text(
                              'Upload photos',
                              style: TextStyle(color: AppColors.KgreyColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    CustomElevatedbutton(
                      onPress: () {
                        context.go('/sent-report');
                      },
                      title: 'Sent Report',
                      color: AppColors.KPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 160.w,
            top: 30.h,
            child: Container(
              height: 100.h,
              width: 125.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.25),
                    offset: const Offset(3, 4),
                    blurRadius: 4,
                  ),
                ],
                color: AppColors.KWhiteColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  color: Color(0xffAC2F2B),
                  AppImages.profileconfrom,
                ),
              ),
            ),
          ),

          Column(
            children: [
              Text(
                'cost',
                style: TextStyle(
                  color: AppColors.KPrimaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
