import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/maintenance/presentation/screens/vacation_cost_view.dart';
import 'package:flutter_project/core/widgets/custom_ElevatedButton.dart';
import 'package:flutter_project/core/widgets/custom_notes.dart';
import 'package:flutter_project/features/reports/presentation/providers/crash_report_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CrashReportView extends ConsumerWidget {
  const CrashReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crashReportState = ref.watch(crashReportProvider);
    final notesController = TextEditingController();

    ref.listen<CrashReportState>(crashReportProvider, (previous, next) {
      if (next.isSent) {
        context.go('/vacation-cost');
      }
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return Scaffold(
      backgroundColor: AppColors.KWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.KPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 20),
        title: Text(
          'Crash report',
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
                    SizedBox(height: 80.h),
                    CustomNotes(
                      title: 'General notes',
                      controller: notesController,
                    ),
                    SizedBox(height: 100.h),
                    InkWell(
                      onTap: () {
                        ref.read(crashReportProvider.notifier).pickImage();
                      },
                      child: Container(
                        height: 160.h,
                        // width: 270.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            crashReportState.image != null
                                ? Image.file(
                                  crashReportState.image!,
                                  fit: BoxFit.cover,
                                )
                                : Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 90,
                                    color: Colors.grey,
                                  ),
                                ),
                      ),
                    ),
                    Spacer(),
                    CustomElevatedbutton(
                      title: 'Send Report',
                      onPress: () {
                        ref
                            .read(crashReportProvider.notifier)
                            .sendReport(notesController.text);
                      },
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
                  AppImages.profileDecline,
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
