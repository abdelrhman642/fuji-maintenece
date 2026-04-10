import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/custom_visits_card.dart';
import 'package:get/get.dart';

class HomeVisitsReportsSection extends StatelessWidget {
  final double visitsProgress;
  final double reportsProgress;

  const HomeVisitsReportsSection({
    super.key,
    required this.visitsProgress,
    required this.reportsProgress,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: CustomVisitsCard(
              percent: visitsProgress,
              title: AppStrings.dailyVisits.tr,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: CustomVisitsCard(
              percent: reportsProgress,
              title: AppStrings.dailyReports.tr,
            ),
          ),
        ],
      ),
    );
  }
}
