import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/data/models/contract_renew_model/contract_renew_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/cubit/contract_renew_requests_cubit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ContractRenewalCard extends StatelessWidget {
  const ContractRenewalCard({super.key, required this.model});

  final ContractRenewModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColor.blackColor.withOpacity(.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '${AppStrings.contractRenewalRequestForClient.tr}: ${model.client?.name ?? ''}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                StatusChip(
                  text: model.status ?? '',
                  color:
                      model.isApproved ?? false
                          ? Colors.green
                          : model.isRejected ?? false
                          ? Colors.red
                          : model.isPending ?? false
                          ? Colors.orange
                          : Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 8),

            IconLabel(
              imagePath: AppAssets.maintenanceIcon,
              text: model.contract?.contractSection?.nameAr ?? '',
            ),
            IconLabel(
              imagePath: AppAssets.reports,
              text:
                  "${AppStrings.contractDuration.tr}: ${model.contract?.contractDuration?.monthCount ?? ''} ${AppStrings.months.tr}",
            ),
            IconLabel(
              imagePath: AppAssets.dataStartIcon,
              text:
                  "${AppStrings.startAContract.tr}: ${formatDate(model.contract?.startDate)}",
            ),
            IconLabel(
              imagePath: AppAssets.dataStartIcon,
              text:
                  "${AppStrings.endAContract.tr}: ${formatDate(model.contract?.endDate)}",
            ),
            IconLabel(
              imagePath: AppAssets.reports2,
              text: "${AppStrings.notes.tr}: ${model.clientNote ?? ''}",
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final note = await showTextInputDialog(
                        context,
                        title: AppStrings.approveContractRenewalNote.tr,
                        hint: AppStrings.enterNote.tr,
                      );
                      if (context.mounted && note != null) {
                        context
                            .read<ContractRenewRequestsCubit>()
                            .approveRequest(model.id!, note);
                      }
                    },
                    style: TextButton.styleFrom(
                      iconColor: AppColor.background,
                      backgroundColor: AppColor.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppStrings.accept.tr,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final reason = await showTextInputDialog(
                        context,
                        title: AppStrings.rejectContractRenewalReason.tr,
                        hint: AppStrings.enterReason.tr,
                      );
                      if (context.mounted && reason != null) {
                        context
                            .read<ContractRenewRequestsCubit>()
                            .rejectRequest(model.id!, reason);
                      }
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(color: AppColor.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppStrings.reject.tr,
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class IconLabel extends StatelessWidget {
  const IconLabel({super.key, this.imagePath, required this.text});

  final String? imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;
    return Row(
      children: [
        Image.asset(imagePath!, width: 20, height: 20),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }
}

String formatDate(DateTime? date) {
  if (date == null) return '';
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();
  return '$day/$month/$year';
}

Future<String?> showTextInputDialog(
  BuildContext context, {
  required String title,
  String? hint,
  String emptyError = 'من فضلك ادخل قيمة صحيحة',
}) {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder:
        (ctx) => AlertDialog(
          title: Text(title),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(hintText: hint),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return emptyError;
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(null),
              child: Text(AppStrings.cancel.tr),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.of(ctx).pop(controller.text.trim());
                }
              },
              child: Text(AppStrings.submit.tr),
            ),
          ],
        ),
  );
}
