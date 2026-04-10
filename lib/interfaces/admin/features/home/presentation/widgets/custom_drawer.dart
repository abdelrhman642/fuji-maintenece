import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.9,
      backgroundColor: AppColor.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: AppColor.primaryDark,
            child: Column(
              children: [
                SizedBox(height: 70),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColor.primaryLightest.withValues(
                    alpha: 0.25,
                  ),
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
                    SizedBox(width: 20),
                    Text(AppStrings.english.tr, style: AppFont.font16W600White),
                    LanguageSwitcher(),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    DrawerItem(
                      title: AppStrings.technicians.tr,
                      // iconPath: AppAssets.drawerTechnicians,
                      iconData: Icons.engineering,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.technicians);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.clients.tr,
                      // iconPath: AppAssets.drawerCustomers,
                      iconData: Icons.group,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.clientsAdminScreen);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.addAClient.tr,
                      // iconPath: AppAssets.drawerAddClient,
                      iconData: Icons.person_add,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.addAClient);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.locationChangeRequests.tr,
                      // iconPath: AppAssets.drawerAddCustomerRequests,
                      iconData: Icons.edit_location,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.locationUpdateRequestsScreen);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.contracts.tr,
                      // iconPath: AppAssets.drawerContractRenewalRequests,
                      iconData: Icons.date_range,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.contractValidityScreen);
                      },
                    ),

                    /////////Visits
                    DrawerItem(
                      title: AppStrings.visits.tr,
                      // iconPath: AppAssets.drawerAddAContract,
                      iconData: Icons.video_camera_back,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.visitsScreen);
                      },
                    ),

                    DrawerItem(
                      title: AppStrings.addReportQuestions.tr,
                      // iconPath: AppAssets.drawerAddAContract,
                      iconData: Icons.question_mark,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.reportQuestionsScreen);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.manageCitiesAndNeighborhood.tr,
                      iconData: Icons.location_city,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.citiesAndNeighborhoodsScreen);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.addContract.tr,
                      iconPath: AppAssets.drawerAddAContract,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.addContractScreen);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.contractRenewalRequests.tr,
                      iconPath: AppAssets.drawerContractRenewalRequests,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.contractRenewalRequestsScreen);
                      },
                    ),
                    DrawerItem(
                      title: AppStrings.orders.tr,
                      iconPath: AppAssets.drawerOrders,
                      iconColor: AppColor.primary,
                      onTap: () {
                        context.push(Routes.ordersAdminScreen);
                      },
                    ),
                    ExpansionTile(
                      leading: SvgPicture.asset(
                        height: 24,
                        color: AppColor.primary,
                        AppAssets.drawerElevatorBrand,
                      ),
                      title: Text(
                        AppStrings.contractSettings.tr,
                        style: AppFont.font16W600Black.copyWith(
                          color: AppColor.primaryDark,
                        ),
                      ),
                      iconColor: AppColor.primary,
                      collapsedIconColor: AppColor.primary,
                      collapsedTextColor: AppColor.primaryDark,
                      textColor: AppColor.primaryDark,
                      children: [
                        DrawerItem(
                          title: AppStrings.maintenanceContractSections.tr,
                          iconPath:
                              AppAssets.drawerMaintenanceContractDepartment,
                          iconColor: AppColor.primary,
                          onTap: () {
                            context.push(
                              Routes.maintenanceContractSectionsScreen,
                            );
                          },
                        ),
                        DrawerItem(
                          title: AppStrings.periodicMaintenanceContract.tr,
                          iconPath: AppAssets.drawerMaintenanceContractPeriod,
                          iconColor: AppColor.primary,
                          onTap: () {
                            context.push(
                              Routes.maintenanceContractPeriodicityScreen,
                            );
                          },
                        ),
                        DrawerItem(
                          title: AppStrings.elevatorBrand.tr,
                          iconPath: AppAssets.drawerElevatorBrand,
                          iconColor: AppColor.primary,
                          onTap: () {
                            context.push(Routes.elevatorBrandsScreen);
                          },
                        ),
                        DrawerItem(
                          title: AppStrings.elevatorType.tr,
                          iconPath: AppAssets.drawerElevatorBrand,
                          iconColor: AppColor.primary,
                          onTap: () {
                            context.push(Routes.elevatorTypesScreen);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          IntrinsicWidth(
            child: DrawerItem(
              title: AppStrings.logout.tr,
              iconPath: AppAssets.drawerLogout,
              textColor: AppColor.primary,
              iconColor: AppColor.primary,
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

      context.showError('حدث خطأ أثناء تسجيل الخروج');
    }
  }
}
