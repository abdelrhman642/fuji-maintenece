import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/setting_option_card.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/cubit/maintenance_contract_periodicity_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/widgets/show_add_new_maintenance_contract_periodicity.dart';
import 'package:get/get.dart';

class MaintenanceContractPeriodicityScreenBody extends StatelessWidget {
  const MaintenanceContractPeriodicityScreenBody({
    super.key,
    required this.periodicities,
    required this.cubit,
  });
  final List<MaintenanceContractPeriodicityModel> periodicities;
  final MaintenanceContractPeriodicityCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: periodicities.length,
            itemBuilder: (context, index) {
              final periodicity = periodicities[index];
              return SettingOptionCard(
                title: AppStrings.maintenanceContractPeriod.tr,
                description: periodicity.nameAr ?? '',
                enabled: periodicity.status == "active",
                onSwitchChanged: (value) {
                  if (value) {
                    cubit.activatePeriodicity(periodicity.id!);
                  } else {
                    cubit.deactivatePeriodicity(periodicity.id!);
                  }
                },
                onEdit: () {
                  showAddNewMaintenanceContractPeriodicity(
                    context,
                    cubit,
                    isEdit: true,
                    model: periodicity,
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 16.h),

        _buildAddButton(context),
      ],
    );
  }

  Padding _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: ElevatedButton(
          onPressed: () {
            showAddNewMaintenanceContractPeriodicity(context, cubit);
          },
          child: Text(AppStrings.add.tr),
        ),
      ),
    );
  }
}
