import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/widgets/reports_screen_body.dart';
import 'package:get/get.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key, required this.contractId});
  final int contractId;

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        actions: [
          // IconButton(
          //   icon: Icon(Icons.filter_list, color: AppColor.primary),
          //   onPressed: () {
          //     _showPopUpMenu(context);
          //   },
          // ),
        ],
        title: AppStrings.reports.tr,
      ),
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          // TabButtonsWidget(
          //   selectedIndex: selectedIndex,
          //   onTabSelected: (index) {
          //     setState(() {
          //       selectedIndex = index;
          //     });
          //   },
          //   tabNames: [
          //     AppStrings.all.tr,
          //     AppStrings.patrol.tr,
          //     AppStrings.malfunctions.tr,
          //     // AppStrings.quarterly.tr,
          //     // AppStrings.finished.tr,
          //   ],
          // ),
          Expanded(child: ReportsScreenBody()),
        ],
      ),
    );
  }

  // Future<dynamic> _showPopUpMenu(BuildContext context) {
  //   return showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(1000, 80, 16, 0),
  //     items: [
  //       PopupMenuItem(
  //         onTap: () {
  //           // context.pushReplacement(Routes.reports);
  //         },
  //         child: Text(AppStrings.maintenanceReports.tr),
  //       ),
  //       PopupMenuItem(
  //         onTap: () {
  //           context.pushReplacement(Routes.contractValidityScreen);
  //         },
  //         child: Text(AppStrings.contractValidity.tr),
  //       ),
  //     ],
  //   );
  // }
}
