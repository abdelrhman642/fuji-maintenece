import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/tab_buttons_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/contracts%20cubit/admin_contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/widgets/contract_validity_screen_body.dart';
import 'package:get/get.dart';

class ContractValidityScreen extends StatefulWidget {
  const ContractValidityScreen({super.key});

  @override
  State<ContractValidityScreen> createState() => _ContractValidityScreenState();
}

class _ContractValidityScreenState extends State<ContractValidityScreen> {
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
        title: AppStrings.contracts.tr,
      ),
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          TabButtonsWidget(
            selectedIndex: selectedIndex,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 0) {
                  context.read<AdminContractsCubit>().filterByCurrent(null);
                }
                if (index == 1) {
                  context.read<AdminContractsCubit>().filterByCurrent(false);
                }
                if (index == 2) {
                  context.read<AdminContractsCubit>().filterByCurrent(true);
                }
              });
            },
            tabNames: [
              AppStrings.all.tr,
              AppStrings.expired.tr,
              AppStrings.valid.tr,
            ],
          ),

          Expanded(child: ContractValidityScreenBody()),
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
  //           context.pushReplacement(Routes.reports);
  //         },
  //         child: Text(AppStrings.maintenanceReports.tr),
  //       ),
  //       PopupMenuItem(
  //         onTap: () {
  //           // context.pushReplacement(Routes.contractValidityScreen);
  //         },
  //         child: Text(AppStrings.contractValidity.tr),
  //       ),
  //     ],
  //   );
  // }
}
