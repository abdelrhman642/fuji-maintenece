import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/select_maintenance_type.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/widgets/custom_auth_appbar.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';

class MaintenanceType extends StatelessWidget {
  const MaintenanceType({super.key, required this.contractId});
  final int contractId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAuthAppBar(),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomContainerMaintenanceType(
                    icon: Icons.build,
                    title: AppStrings.periodicMaintenance.tr,
                    onTap: () {
                      context.pushReplacement(
                        Routes.periodicMaintenanceReport,
                        extra: contractId,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomContainerMaintenanceType(
                    icon: Icons.settings,
                    borderColor: AppColor.unselectedNavBar,
                    title: AppStrings.malfunctionMaintenance.tr,
                    onTap: () {
                      context.pushReplacement(
                        Routes.malfunctionMaintenanceScreen,
                        extra: contractId,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
