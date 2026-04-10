import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/widgets/location_update_requests_screen_body.dart';
import 'package:get/get.dart';

class LocationUpdateRequestsScreen extends StatefulWidget {
  const LocationUpdateRequestsScreen({super.key});

  @override
  State<LocationUpdateRequestsScreen> createState() =>
      _LocationUpdateRequestsScreenState();
}

class _LocationUpdateRequestsScreenState
    extends State<LocationUpdateRequestsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.requests.tr),
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
          //     AppStrings.onhold.tr,
          //     AppStrings.accepted.tr,
          //     AppStrings.rejected.tr,
          //   ],
          // ),
          Expanded(child: LocationUpdateRequestsScreenBody()),
        ],
      ),
    );
  }
}
