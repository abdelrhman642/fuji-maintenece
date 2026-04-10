import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/reports/presentation/screens/sent_report_view.dart';
import 'package:flutter_project/core/widgets/custom_ElevatedButton.dart';
import 'package:flutter_project/core/widgets/custom_notes.dart';
import 'package:flutter_project/core/widgets/custom_reportDetails.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportDetailsView extends ConsumerWidget {
  const ReportDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.KWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.KPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 20),
        title: Text(
          'Report Details',
          style: TextStyle(
            color: AppColors.KWhiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            CustomReportDetails(title: 'Well cleanliness'),
            CustomReportDetails(title: 'Cleanliness inside the cabin'),
            CustomReportDetails(title: 'Outside cabin cleaning'),
            CustomReportDetails(title: 'Engine cleanliness'),
            CustomReportDetails(title: 'Control cleanliness'),
            CustomReportDetails(title: 'Engine oil'),
            CustomReportDetails(title: 'The bidder'),
            CustomReportDetails(title: 'Railways'),
            CustomReportDetails(title: 'Parachute'),
            CustomReportDetails(title: 'The end of the journey'),
            CustomReportDetails(title: 'Door sensor'),
            CustomReportDetails(title: 'Contact the door'),
            CustomReportDetails(title: 'Brakes'),
            CustomReportDetails(title: 'Door sensor'),
            CustomReportDetails(title: 'Engine oil'),
            CustomReportDetails(title: 'Parachute'),
            CustomReportDetails(title: 'Contact the door'),
            CustomReportDetails(title: 'Door sensor'),
            CustomReportDetails(title: 'Parachute'),
            CustomReportDetails(title: 'Well cleanliness'),
            CustomReportDetails(title: 'Railways'),
            CustomReportDetails(title: 'Engine oil'),
            CustomReportDetails(title: 'The end of the journey'),
            CustomReportDetails(title: 'Door sensor'),

            CustomNotes(title: 'General notes'),
            SizedBox(height: 25.h),

            Container(
              height: 160.h,

              // width: 270.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.image, size: 90, color: Colors.grey),
              ),
            ),
            SizedBox(height: 25.h),
            CustomElevatedbutton(
              title: 'Send report',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SentReportView()),
                );
              },
              color: AppColors.KPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
