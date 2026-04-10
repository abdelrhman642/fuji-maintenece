import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/guest_mode/guest_mode.dart';
import 'package:get/get_utils/get_utils.dart';

class ContractCard extends StatelessWidget {
  const ContractCard({super.key, required this.contractModel});
  final ContractModel contractModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // Check if guest mode is enabled before allowing interaction
        if (!GuestModeInterceptor.checkAndShowLoginDialog(context)) {
          return;
        }
        // Handle tap action for logged-in users
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          // ignore: deprecated_member_use
          side: BorderSide(color: AppColor.blackColor.withOpacity(.08)),
        ),

        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '${AppStrings.clientName.tr}: ${contractModel.client?.name}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _StatusChip(
                    text: contractModel.status ?? '',
                    isSuccess: contractModel.isCurrent ?? false,
                  ),
                ],
              ),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _IconLabel(
                    icon: Icons.confirmation_number,
                    text:
                        "${AppStrings.contractNumber.tr}: ${contractModel.contractNumber}",
                  ),
                  // _IconLabel(icon: Icons.offline_bolt_outlined, text: "${contractModel.id}"),
                  _IconLabel(
                    icon: Icons.build,
                    text: "ID: ${contractModel.contractSection?.nameAr}",
                  ),
                  _IconLabel(
                    icon: Icons.date_range,
                    text:
                        contractModel.startDate == null
                            ? ''
                            : '${AppStrings.startDate.tr}: ${contractModel.startDate!.day.toString().padLeft(2, '0')}/${contractModel.startDate!.month.toString().padLeft(2, '0')}/${contractModel.startDate!.year}',
                  ),
                  _IconLabel(
                    icon: Icons.date_range,
                    text:
                        contractModel.endDate == null
                            ? ''
                            : '${AppStrings.endDate.tr}: ${contractModel.endDate!.day.toString().padLeft(2, '0')}/${contractModel.endDate!.month.toString().padLeft(2, '0')}/${contractModel.endDate!.year}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text, required this.isSuccess});
  final String text;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.gray_3.withOpacity(.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSuccess ? AppColor.green : AppColor.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColor.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: AppFont.font16W600Black)),
      ],
    );
  }
}
