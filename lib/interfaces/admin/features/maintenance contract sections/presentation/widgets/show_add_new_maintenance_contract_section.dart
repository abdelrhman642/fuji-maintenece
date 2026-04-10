import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/models/maintenance_contract_section_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/presentation/cubit/maintenance_contract_sections_cubit.dart';
import 'package:get/get.dart';

Future<dynamic> showAddNewMaintenanceContractSection(
  BuildContext context,
  MaintenanceContractSectionsCubit cubit, {
  bool isEdit = false,
  MaintenanceContractSectionModel? model,
}) {
  final enableToEdit = isEdit && model != null;
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController maintenanceContractSectionNameAr =
      TextEditingController(text: model?.nameAr);
  final TextEditingController maintenanceContractSectionNameEn =
      TextEditingController(text: model?.nameEn);

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: 25 + MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: SingleChildScrollView(
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
                        : AppStrings.addNewMaintenanceContractSection.tr,
                    style: AppFont.font20W700Black,
                  ),
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: maintenanceContractSectionNameAr,
                  labelText: AppStrings.maintenanceContractSectionNameAr.tr,
                  hintText: AppStrings.maintenanceContractSectionNameAr.tr,
                ),
                CustomTextField(
                  controller: maintenanceContractSectionNameEn,
                  labelText: AppStrings.maintenanceContractSectionNameEn.tr,
                  hintText: AppStrings.maintenanceContractSectionNameEn.tr,
                ),
                SizedBox(height: 16.h),
                BlocConsumer<
                  MaintenanceContractSectionsCubit,
                  MaintenanceContractSectionsState
                >(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is MaintenanceContractSectionActionSuccess) {
                      Navigator.pop(context);
                    }
                    if (state is MaintenanceContractSectionActionError) {
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
                              cubit.editSection(
                                model.id!,
                                maintenanceContractSectionNameAr.text,
                                maintenanceContractSectionNameEn.text,
                              );
                            } else {
                              cubit.addNewSection(
                                maintenanceContractSectionNameAr.text,
                                maintenanceContractSectionNameEn.text,
                              );
                            }
                          }
                        },
                        child: Text(
                          state is MaintenanceContractSectionsLoading
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
        ),
      );
    },
  );
}
