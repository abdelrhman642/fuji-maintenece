import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_section_container.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_drop_down.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:get/get.dart';

class ElevatorDetailsSection extends StatelessWidget {
  const ElevatorDetailsSection({
    super.key,
    required this.elevatorTypeController,
    required this.elevatorBrandController,
    required this.elevatorTypes,
    required this.elevatorBrands,
  });
  final TextEditingController elevatorTypeController;
  final TextEditingController elevatorBrandController;
  final List<ElevatorTypeModel> elevatorTypes;
  final List<ElevatorBrandModel> elevatorBrands;

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      child: Column(
        children: [
          CustomDropdown<ElevatorTypeModel>(
            title: AppStrings.elevatorType.tr,
            hintText: AppStrings.elevatorType.tr,
            validator: (val) {
              if (val == null) {
                return AppStrings.fieldRequired.tr;
              }
              return null;
            },
            items:
                elevatorTypes.map((value) {
                  return DropdownMenuItem<ElevatorTypeModel>(
                    value: value,
                    child: Text(
                      value.nameEn ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              elevatorTypeController.text = value?.id.toString() ?? '';
            },
          ),

          CustomDropdown<ElevatorBrandModel>(
            title: AppStrings.elevatorBrand.tr,
            hintText: AppStrings.elevatorBrand.tr,
            validator: (val) {
              if (val == null) {
                return AppStrings.fieldRequired.tr;
              }
              return null;
            },
            items:
                elevatorBrands.map((value) {
                  return DropdownMenuItem<ElevatorBrandModel>(
                    value: value,
                    child: Text(
                      value.nameEn ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              elevatorBrandController.text = value?.id.toString() ?? '';
            },
          ),
        ],
      ),
    );
  }
}
