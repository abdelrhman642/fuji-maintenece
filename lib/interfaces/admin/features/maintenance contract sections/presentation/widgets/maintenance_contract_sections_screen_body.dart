import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/setting_option_card.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/models/maintenance_contract_section_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/cubit/maintenance_contract_sections_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/widgets/show_add_new_maintenance_contract_section.dart';
import 'package:get/get.dart';

class MaintenanceContractSectionsScreenBody extends StatelessWidget {
  const MaintenanceContractSectionsScreenBody({
    super.key,
    required this.sections,
    required this.cubit,
  });

  final List<MaintenanceContractSectionModel> sections;
  final MaintenanceContractSectionsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return SettingOptionCard(
                title: AppStrings.maintenanceContractSection.tr,
                description: section.nameAr ?? '',
                enabled: section.status == "active",
                onSwitchChanged: (value) {
                  if (value) {
                    cubit.activateSection(section.id!);
                  } else {
                    cubit.deactivateSection(section.id!);
                  }
                },
                onEdit: () {
                  showAddNewMaintenanceContractSection(
                    context,
                    cubit,
                    isEdit: true,
                    model: section,
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
            showAddNewMaintenanceContractSection(context, cubit);
          },
          child: Text(AppStrings.add.tr),
        ),
      ),
    );
  }
}
