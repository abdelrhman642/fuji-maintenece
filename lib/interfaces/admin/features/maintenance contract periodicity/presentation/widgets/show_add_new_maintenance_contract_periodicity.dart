import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/presentation/cubit/maintenance_contract_periodicity_cubit.dart';
import 'package:get/get.dart';

Future<dynamic> showAddNewMaintenanceContractPeriodicity(
  BuildContext context,
  MaintenanceContractPeriodicityCubit cubit, {
  bool isEdit = false,
  MaintenanceContractPeriodicityModel? model,
}) {
  final enableToEdit = isEdit && model != null;
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController maintenanceContractPeriodicityNameAr =
      TextEditingController(text: model?.nameAr);
  final TextEditingController maintenanceContractPeriodicityNameEn =
      TextEditingController(text: model?.nameEn);
  final TextEditingController maintenanceContractPeriodicityValue =
      TextEditingController(text: model?.monthCount?.toString());
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
                  isEdit
                      ? AppStrings.edit.tr
                      : AppStrings.addNewMaintenanceContractPeriodicity.tr,
                  style: AppFont.font20W700Black,
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: maintenanceContractPeriodicityNameAr,
                labelText: AppStrings.maintenanceContractPeriodicityNameAr.tr,
                hintText: AppStrings.maintenanceContractPeriodicityNameAr.tr,
              ),
              CustomTextField(
                controller: maintenanceContractPeriodicityNameEn,
                labelText: AppStrings.maintenanceContractPeriodicityNameEn.tr,
                hintText: AppStrings.maintenanceContractPeriodicityNameEn.tr,
              ),
              CustomTextField(
                controller: maintenanceContractPeriodicityValue,
                labelText: AppStrings.addNewMaintenanceContractPeriodicity.tr,
                hintText: AppStrings.addNewMaintenanceContractPeriodicity.tr,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              BlocConsumer<
                MaintenanceContractPeriodicityCubit,
                MaintenanceContractPeriodicityState
              >(
                bloc: cubit,
                listener: (context, state) {
                  if (state is MaintenanceContractPeriodicityActionSuccess) {
                    Navigator.pop(context);
                  }
                  if (state is MaintenanceContractPeriodicityActionError) {
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
                            cubit.editPeriodicity(
                              model.id!,
                              maintenanceContractPeriodicityNameAr.text,
                              maintenanceContractPeriodicityNameEn.text,
                              int.parse(
                                maintenanceContractPeriodicityValue.text,
                              ),
                            );
                          } else {
                            cubit.addNewPeriodicity(
                              maintenanceContractPeriodicityNameAr.text,
                              maintenanceContractPeriodicityNameEn.text,
                              int.parse(
                                maintenanceContractPeriodicityValue.text,
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        state is MaintenanceContractPeriodicityLoading
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
