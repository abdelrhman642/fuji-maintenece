import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/home_statistics.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/custom_container_home.dart';
import 'package:get/get.dart';

class HomeStatisticsGrid extends StatelessWidget {
  final HomeStatistics statistics;

  const HomeStatisticsGrid({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = kIsWeb && screenWidth > 800 ? 4 : 2;
    final childAspectRatio = kIsWeb && screenWidth > 800 ? 2 / 1.3 : 2 / 1.75;

    return GridView.count(
      childAspectRatio: childAspectRatio,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CustomContainerHome(
          title: AppStrings.technicians.tr,
          value: _formatNumber(statistics.technicians),
          percentage: '00.00%', // TODO: Calculate actual percentage
          backgroundColor: AppColor.lightGrey,
          textColor: AppColor.white,
          icon: Icons.engineering,
        ),
        CustomContainerHome(
          title: AppStrings.requests.tr,
          value: _formatNumber(statistics.requests),
          percentage: '00.00%', // TODO: Calculate actual percentage
          backgroundColor: AppColor.blackColor,
          textColor: AppColor.white,
          icon: Icons.shopping_cart,
        ),
        CustomContainerHome(
          title: AppStrings.reports.tr,
          value: _formatNumber(statistics.reports),
          percentage: '00.00%', // TODO: Calculate actual percentage
          backgroundColor: AppColor.blackColor,
          textColor: AppColor.white,
          icon: Icons.request_page,
        ),
        CustomContainerHome(
          title: AppStrings.customers.tr,
          value: _formatNumber(statistics.customers),
          percentage: '00.00%', // TODO: Calculate actual percentage
          backgroundColor: AppColor.lightGrey,
          textColor: AppColor.white,
          icon: Icons.people,
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      double result = number / 1000;
      if (result % 1 == 0) {
        return '${result.toInt()}k';
      } else {
        return '${result.toStringAsFixed(1)}k';
      }
    }
    return number.toString();
  }
}
