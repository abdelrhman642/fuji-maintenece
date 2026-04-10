import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/widgets/technician_reports_screen_body.dart';
import 'package:get/get.dart';

class TechnicianReportsScreen extends StatelessWidget {
  const TechnicianReportsScreen({super.key, required this.technicianId});
  final int technicianId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.reports.tr),
      backgroundColor: AppColor.background,
      body: Column(children: [Expanded(child: TechnicianReportsScreenBody())]),
    );
  }
}
