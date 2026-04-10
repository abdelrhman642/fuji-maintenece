import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info, size: 100.sp, color: AppColor.gray_3),
          const SizedBox(height: 20),
          Text(
            AppStrings.noDataAvailablePlsAddNow.tr,
            style: AppFont.font16W600Gray2,
            textAlign: TextAlign.center,
          ),
        ],
      ).paddingAll(16),
    );
  }
}
