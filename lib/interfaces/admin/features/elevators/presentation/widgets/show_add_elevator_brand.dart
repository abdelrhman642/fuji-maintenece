import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20brands%20cubit/elevator_brands_cubit.dart';
import 'package:get/get.dart';

Future<dynamic> showAddElevatorBrand(
  BuildContext context,
  ElevatorBrandsCubit cubit, {
  bool isEdit = false,
  ElevatorBrandModel? model,
}) {
  int? elevatorTypeId = model?.elevatorTypeId;
  final enableToEdit = isEdit && model != null;
  final TextEditingController elevatorBrandNameAr = TextEditingController(
    text: model?.nameAr,
  );
  final TextEditingController elevatorBrandNameEn = TextEditingController(
    text: model?.nameEn,
  );
  final GlobalKey<FormState> key = GlobalKey();

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Center(
                child: Text(
                  isEdit ? AppStrings.edit.tr : AppStrings.addElevatorBrand.tr,
                  style: AppFont.font20W700Black,
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: elevatorBrandNameAr,
                labelText: AppStrings.elevatorBrandNameAr.tr,
                hintText: AppStrings.elevatorBrandNameAr.tr,
              ),
              CustomTextField(
                controller: elevatorBrandNameEn,
                labelText: AppStrings.elevatorBrandNameEn.tr,
                hintText: AppStrings.elevatorBrandNameEn.tr,
              ),
              StatefulBuilder(
                builder: (context, setDropdownState) {
                  // Filter out duplicates based on id
                  final uniqueTypes = <int, dynamic>{};
                  for (var type in cubit.elevatorTypes) {
                    if (type.id != null && !uniqueTypes.containsKey(type.id)) {
                      uniqueTypes[type.id!] = type;
                    }
                  }
                  final typesList = uniqueTypes.values.toList();

                  // Validate that elevatorTypeId exists in the list
                  final validValue =
                      typesList.any((t) => t.id == elevatorTypeId)
                          ? elevatorTypeId
                          : null;

                  return DropdownButtonFormField<int>(
                    value: validValue,
                    decoration: InputDecoration(
                      labelText: AppStrings.elevatorType.tr,
                      border: OutlineInputBorder(),
                    ),
                    items:
                        typesList
                            .map(
                              (type) => DropdownMenuItem<int>(
                                value: type.id,
                                child: Text(type.nameAr ?? ''),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      elevatorTypeId = value ?? -1;
                      setDropdownState(() {});
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              BlocConsumer<ElevatorBrandsCubit, ElevatorBrandsState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ElevatorBrandActionSuccess) {
                    Navigator.pop(context);
                  }
                  if (state is ElevatorBrandActionFailure) {
                    context.showError(state.message);
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          if (enableToEdit) {
                            cubit.updateBrandById(
                              model.id!,
                              elevatorBrandNameAr.text,
                              elevatorBrandNameEn.text,
                              elevatorTypeId!,
                            );
                          } else {
                            cubit.addNewElevatorBrand(
                              elevatorBrandNameAr.text,
                              elevatorBrandNameEn.text,
                              elevatorTypeId!,
                            );
                          }
                        }
                      },
                      child: Text(
                        state is ElevatorBrandsLoading
                            ? AppStrings.loading.tr
                            : AppStrings.save.tr,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
