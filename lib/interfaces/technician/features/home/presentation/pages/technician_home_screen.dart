import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/contract_cubit/contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/pages/map_view_with_contracts.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/widgets/custom_drower_technician.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TechnicianHomeScreen extends StatelessWidget {
  const TechnicianHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColor.black),
            onPressed: () => context.push(Routes.notificationsScreen),
            tooltip: AppStrings.notifications.tr,
          ),
        ],
        title: Text(AppStrings.home.tr, style: AppFont.font20W700Primary),
        centerTitle: true,
        backgroundColor: AppColor.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: AppColor.primary),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),

      drawer: CustomDrowerTechnician(),
      body: BlocBuilder<ContractsCubit, ContractsState>(
        builder: (context, state) {
          if (state is ContractsLoaded) {
            return MapViewWithContracts(contracts: state.contracts);
          } else if (state is ContractsLoading) {
            return const CustomLoadingIndicator();
          } else if (state is ContractsError) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
