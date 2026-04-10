import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/setting_option_card.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20types%20cubit/elevator_types_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/widgets/show_add_elevator_type.dart';
import 'package:get/get.dart';

class ElevatorTypesScreenBody extends StatelessWidget {
  const ElevatorTypesScreenBody({
    super.key,
    required this.types,
    required this.cubit,
  });
  final List<ElevatorTypeModel> types;
  final ElevatorTypesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: types.length,
            itemBuilder: (context, index) {
              final type = types[index];
              return SettingOptionCard(
                title: AppStrings.elevatorTypeSingle.tr,
                description: type.nameAr ?? '',
                enabled: type.status == "active",
                onSwitchChanged: (value) {
                  if (value) {
                    cubit.activateTypeById(type.id!);
                  } else {
                    cubit.deactivateTypeById(type.id!);
                  }
                },
                onEdit: () {
                  showAddElevatorType(
                    context,
                    cubit,
                    isEdit: true,
                    model: type,
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

  Padding _buildAddButton(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: ElevatedButton(
          onPressed: () {
            showAddElevatorType(context, cubit);
          },
          child: Text(AppStrings.add.tr),
        ),
      ),
    );
  }
}
