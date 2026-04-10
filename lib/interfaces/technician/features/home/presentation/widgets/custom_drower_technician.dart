import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/drawer_item_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/core/widgets/simple_language_switcher.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/controllers/auth_service.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CustomDrowerTechnician extends StatelessWidget {
  const CustomDrowerTechnician({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * .6,
      backgroundColor: AppColor.background,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  color: AppColor.primaryDark,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColor.gray_3,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(
                            child: Text(
                              (getIt<LocalDataManager>().getUserName() ?? 'UN')
                                  .trim()
                                  .split(' ')
                                  .where((e) => e.isNotEmpty)
                                  .map((e) => e[0])
                                  .take(2)
                                  .join()
                                  .toUpperCase(),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          getIt<LocalDataManager>().getUserName() ??
                              AppStrings.username.tr,
                          style: AppFont.font20W600White,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.english.tr,
                            style: AppFont.font16W600White,
                          ),
                          LanguageSwitcher(),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50),
                DrawerItem(
                  title: AppStrings.customers.tr,
                  iconPath: AppAssets.drawerCustomers,
                  onTap: () {
                    context.push(Routes.customers);
                  },
                ),
                DrawerItem(
                  title: AppStrings.reports.tr,
                  iconPath: AppAssets.drawerReport,
                  onTap: () {
                    context.push(
                      Routes.reportTechnicalScreen,
                      extra: int.tryParse(
                        getIt<LocalDataManager>().getUserId() ?? '',
                      ),
                    );
                  },
                ),
                // DrawerItem(
                //   title: AppStrings.add.tr,
                //   iconPath: AppAssets.drawerReport,
                //   onTap: () {
                //     context.push(Routes.maintenanceType, extra: 2);
                //   },
                // ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: DrawerItem(
              iconColor: AppColor.highPriority,
              title: AppStrings.logout.tr,
              iconPath: AppAssets.drawerLogout,
              textColor: AppColor.highPriority,
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(AppStrings.logout.tr),
                        content: Text(AppStrings.areYouSureYouWantToLogout.tr),
                        actions: [
                          TextButton(
                            child: Text(AppStrings.no.tr),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text(AppStrings.yes.tr),
                            onPressed: () async {
                              await _performLogout(context);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      ),
                );
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  // addClientIcon

  Future<void> _performLogout(BuildContext context) async {
    // Store the navigator context before any async operations
    final navigator = Navigator.of(context, rootNavigator: true);

    try {
      // Show loading indicator using root navigator
      showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) => const CustomLoadingIndicator(),
      );

      // Get auth service and perform logout
      final container = ProviderScope.containerOf(context);
      final authService = container.read(authServiceProvider);

      await authService.logout();

      // Close loading dialog using root navigator
      navigator.pop();

      // Logout successful, navigate to account type selection
      if (context.mounted) context.go(Routes.accountTypeSelection);
    } catch (e) {
      // Close loading dialog if still open
      try {
        navigator.pop();
      } catch (_) {
        // Dialog might already be closed
      }

      context.showError(AppStrings.logoutFailed.tr);
    }
  }
}
