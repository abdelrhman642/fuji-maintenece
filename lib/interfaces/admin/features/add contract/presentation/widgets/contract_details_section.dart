import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/helper/validation_utils.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_section_container.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_drop_down.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_text_filed_beta.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20periodicity/data/models/maintenance_contract_periodicity_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/maintenance%20contract%20sections/data/models/maintenance_contract_section_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContractDetailsSection extends StatelessWidget {
  const ContractDetailsSection({
    super.key,
    required this.clientIdController,
    required this.contractNumberController,
    required this.contractSectionController,
    required this.startDateController,
    required this.endDateController,
    required this.contractPeriodController,
    required this.contractPriceController,
    required this.maintenanceContractSections,
    required this.maintenanceContractPeriodicity,
    required this.clients,
  });
  final TextEditingController clientIdController;
  final TextEditingController contractNumberController;
  final TextEditingController contractSectionController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController contractPeriodController;
  final TextEditingController contractPriceController;

  final List<ClientModel> clients;
  final List<MaintenanceContractSectionModel> maintenanceContractSections;
  final List<MaintenanceContractPeriodicityModel>
  maintenanceContractPeriodicity;
  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      child: Column(
        children: [
          CustomDropdown<ClientModel>(
            title: AppStrings.clientName.tr,
            hintText: AppStrings.clientName.tr,
            validator: (val) {
              if (val == null) {
                return AppStrings.fieldRequired.tr;
              }
              return null;
            },
            items:
                clients.map((value) {
                  return DropdownMenuItem<ClientModel>(
                    value: value,
                    child: Text(
                      "#${value.id}: ${value.name}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              clientIdController.text = value?.id.toString() ?? '';
            },
          ),
          CustomTextFieldBeta(
            title: AppStrings.contractNumber.tr,
            textEditingController: contractNumberController,
            hintText: AppStrings.contractNumber.tr,
            icon: Icons.confirmation_number_rounded,
            keyboardType: TextInputType.number,
            validator:
                (value) => ValidationUtils.validateAtMostFiveDigits(value),
          ),
          CustomDropdown<MaintenanceContractSectionModel>(
            title: AppStrings.maintenanceContractSection.tr,
            hintText: AppStrings.maintenanceContractSection.tr,
            validator: (val) {
              if (val == null) {
                return AppStrings.fieldRequired.tr;
              }
              return null;
            },
            items:
                maintenanceContractSections.map((value) {
                  return DropdownMenuItem<MaintenanceContractSectionModel>(
                    value: value,
                    child: Text(
                      value.nameEn ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              contractSectionController.text = value?.id.toString() ?? '';
            },
          ),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate:
                    startDateController.text.isNotEmpty
                        ? DateTime.parse(startDateController.text)
                        : DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                startDateController.text = DateFormat(
                  'yyyy-MM-dd',
                ).format(date);
              }
            },
            child: IgnorePointer(
              ignoring: true,
              child: CustomTextFieldBeta(
                title: AppStrings.startDate.tr,
                hintText: AppStrings.startDate.tr,
                icon: Icons.calendar_month,
                textEditingController: startDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.fieldRequired.tr;
                  }
                  return null;
                },
              ),
            ),
          ),
          // End Date is now calculated automatically based on years and months selection
          InkWell(
            onTap: () async {
              int years = 0;
              int months = 0;
              // Show dialog to select years and months
              final result = await showDialog<Map<String, int>>(
                context: context,
                builder: (context) {
                  int tempYears = 1;
                  int tempMonths = 0;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Text(AppStrings.endDate.tr),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text('${AppStrings.years.tr}:'),
                                SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButton<int>(
                                    value: tempYears,
                                    items:
                                        List.generate(10, (i) => i + 1)
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e.toString()),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (v) {
                                      if (v != null) {
                                        setState(() {
                                          tempYears = v;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${AppStrings.months.tr}:'),
                                SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButton<int>(
                                    value: tempMonths,
                                    items:
                                        List.generate(12, (i) => i)
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e.toString()),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (v) {
                                      if (v != null) {
                                        setState(() {
                                          tempMonths = v;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(AppStrings.cancel.tr),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop({
                                AppStrings.years: tempYears,
                                AppStrings.months: tempMonths,
                              });
                            },
                            child: Text(AppStrings.confirm.tr),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
              if (result != null) {
                years = result[AppStrings.years] ?? 0;
                months = result[AppStrings.months] ?? 0;
                if (startDateController.text.isEmpty) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppStrings.pleaseSelectStartDateFirst.tr),
                    ),
                  );
                  return;
                }
                final startDate = DateTime.parse(startDateController.text);
                // Calculate end date: add years and months, then subtract one day
                final calculatedEndDate = DateTime(
                  startDate.year + years,
                  startDate.month + months,
                  startDate.day,
                ).subtract(Duration(days: 1));
                final duration =
                    calculatedEndDate.difference(startDate).inDays + 1;
                // Show confirmation dialog
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(AppStrings.confirmContractDuration.tr),
                        content: Text(
                          '${AppStrings.totalContractDuration.tr}: $years ${AppStrings.years.tr} ${AppStrings.and.tr} $months ${AppStrings.months.tr}\n'
                          '${AppStrings.startDate.tr}: ${DateFormat('yyyy-MM-dd').format(startDate)}\n'
                          '${AppStrings.endDate.tr}: ${DateFormat('yyyy-MM-dd').format(calculatedEndDate)}\n'
                          '${AppStrings.totalDays.tr}: $duration\n',
                          // '${AppStrings.endDateNote.tr}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(AppStrings.cancel.tr),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(AppStrings.confirm.tr),
                          ),
                        ],
                      ),
                );
                if (confirmed == true) {
                  endDateController.text = DateFormat(
                    'yyyy-MM-dd',
                  ).format(calculatedEndDate);
                }
              }
            },
            child: IgnorePointer(
              ignoring: true,
              child: CustomTextFieldBeta(
                title: AppStrings.endDate.tr,
                textEditingController: endDateController,
                hintText: AppStrings.endDate.tr,
                icon: Icons.calendar_month,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.fieldRequired.tr;
                  }
                  return null;
                },
              ),
            ),
          ),
          CustomDropdown<MaintenanceContractPeriodicityModel>(
            title: AppStrings.visitingDates.tr,
            validator: (val) {
              if (val == null) {
                return AppStrings.fieldRequired.tr;
              }
              return null;
            },
            hintText: AppStrings.visitingDates.tr,
            items:
                maintenanceContractPeriodicity.map((value) {
                  return DropdownMenuItem<MaintenanceContractPeriodicityModel>(
                    value: value,
                    child: Text(
                      value.nameEn ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              contractPeriodController.text = value?.id.toString() ?? '';
            },
          ),
          CustomTextFieldBeta(
            title: AppStrings.contractPrice.tr,
            hintText: AppStrings.contractPrice.tr,
            textEditingController: contractPriceController,
            keyboardType: TextInputType.number,
            icon: Icons.price_change,
            validator:
                (value) => ValidationUtils.validateAtMostFiveDigits(value),
          ),
        ],
      ),
    );
  }
}
