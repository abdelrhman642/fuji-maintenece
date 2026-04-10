import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/widgets/contract_renewal_requests_screen_body.dart';
import 'package:get/get.dart';

class ContractRenewalRequestsScreen extends StatefulWidget {
  const ContractRenewalRequestsScreen({super.key});

  @override
  State<ContractRenewalRequestsScreen> createState() =>
      _ContractRenewalRequestsScreenState();
}

class _ContractRenewalRequestsScreenState
    extends State<ContractRenewalRequestsScreen> {
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
          Expanded(child: ContractRenewalRequestsScreenBody()),
        ],
      ),
    );
  }
}
