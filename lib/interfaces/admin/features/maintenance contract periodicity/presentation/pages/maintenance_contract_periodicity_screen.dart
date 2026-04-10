import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/no_data_fount_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/cubit/maintenance_contract_periodicity_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/widgets/maintenance_contract_periodicity_screen_body.dart';
import 'package:get/get.dart';

class MaintenanceContractPeriodicityScreen extends StatefulWidget {
  const MaintenanceContractPeriodicityScreen({super.key});

  @override
  State<MaintenanceContractPeriodicityScreen> createState() =>
      _MaintenanceContractPeriodicityScreenState();
}

class _MaintenanceContractPeriodicityScreenState
    extends State<MaintenanceContractPeriodicityScreen> {
  List<MaintenanceContractPeriodicityModel> periodicities = [];
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(
        title: AppStrings.maintenanceContractPeriodicity.tr,
      ),
      body: BlocConsumer<
        MaintenanceContractPeriodicityCubit,
        MaintenanceContractPeriodicityState
      >(
        listener: (context, state) {
          if (state is MaintenanceContractPeriodicityLoaded) {
            periodicities = state.periodicities;
          }
          if (state is MaintenanceContractPeriodicityActionSuccess) {
            context
                .read<MaintenanceContractPeriodicityCubit>()
                .fetchPeriodicity();
          } else if (state is MaintenanceContractPeriodicityActionError) {
            context.showError(state.message);
          }
        },
        builder: (context, state) {
          if (state is MaintenanceContractPeriodicityError) {
            return Center(
              child: Text(state.message, style: AppFont.font16W600Gray2),
            );
          } else if (state is MaintenanceContractPeriodicityLoading &&
              isFirst) {
            isFirst = false;
            return const CustomLoadingIndicator();
          } else {
            if (periodicities.isEmpty) {
              return NoDataFoundWidget();
            }
            final cubit = context.read<MaintenanceContractPeriodicityCubit>();
            return MaintenanceContractPeriodicityScreenBody(
              periodicities: periodicities,
              cubit: cubit,
            );
          }
        },
      ),
    );
  }
}
