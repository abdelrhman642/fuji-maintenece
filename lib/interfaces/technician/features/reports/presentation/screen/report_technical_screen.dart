import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/presentation/widgets/report_technician_screen_body.dart';
import 'package:get/get.dart';

class ReportTechnicalScreen extends StatelessWidget {
  const ReportTechnicalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.reports.tr),
      backgroundColor: AppColor.background,
      body: Column(children: [Expanded(child: ReportTechnicianScreenBody())]),
    );
  }
}
