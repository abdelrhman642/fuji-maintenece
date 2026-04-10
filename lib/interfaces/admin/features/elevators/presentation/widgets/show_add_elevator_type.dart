import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20types%20cubit/elevator_types_cubit.dart';
import 'package:get/get.dart';

Future<dynamic> showAddElevatorType(
  BuildContext context,
  ElevatorTypesCubit cubit, {
  bool isEdit = false,
  ElevatorTypeModel? model,
}) {
  final enableToEdit = isEdit && model != null;
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController elevatorTypeNameAr = TextEditingController(
    text: model?.nameAr,
  );
  final TextEditingController elevatorTypeNameEn = TextEditingController(
    text: model?.nameEn,
  );

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
                  isEdit ? AppStrings.edit.tr : AppStrings.addElevatorType.tr,
                  style: AppFont.font20W700Black,
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: elevatorTypeNameAr,
                labelText: AppStrings.elevatorTypeNameAr.tr,
                hintText: AppStrings.elevatorTypeNameAr.tr,
              ),
              CustomTextField(
                controller: elevatorTypeNameEn,
                labelText: AppStrings.elevatorTypeNameEn.tr,
                hintText: AppStrings.elevatorTypeNameEn.tr,
              ),

              SizedBox(height: 16.h),
              BlocConsumer<ElevatorTypesCubit, ElevatorTypesState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ElevatorTypeActionSuccess) {
                    Navigator.pop(context);
                  }
                  if (state is ElevatorTypeActionFailure) {
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
                            cubit.updateTypeById(
                              model.id!,
                              elevatorTypeNameAr.text,
                              elevatorTypeNameEn.text,
                              // elevatorBrand,
                            );
                          } else {
                            cubit.addNewElevatorType(
                              elevatorTypeNameAr.text,
                              elevatorTypeNameEn.text,
                            );
                          }
                        }
                      },
                      child: Text(
                        state is ElevatorTypesLoading
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
