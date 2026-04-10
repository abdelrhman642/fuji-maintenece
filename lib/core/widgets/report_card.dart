import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/get_utils.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.model,
    this.showClientName = false,
    this.onExportPressed,
  });
  final ReportModel model;
  final VoidCallback? onExportPressed;
  final bool showClientName;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    showClientName
                        ? '${AppStrings.clientName.tr}: ${model.contract?.client?.name}'
                        : '${AppStrings.technicianName.tr}: ${model.technician?.name}',
                    style: AppFont.font16W700Black,
                  ),
                ),
                const SizedBox(width: 12),
                _StatusChip(
                  text: model.contract?.status ?? '',
                  isSuccess: model.contract?.isCurrent ?? false,
                ),
              ],
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _IconLabel(
                  icon: Icons.build,
                  text: "${AppStrings.reportType.tr} ${model.reportType}",
                ),
                _IconLabel(
                  icon: Icons.numbers,
                  text: '${AppStrings.numberOfReport.tr} ${model.id}',
                ),
                ...model.questionsAnswers?.map(
                      (q) =>
                          q.answerType == 0
                              ? _IconLabel(
                                icon:
                                    q.answer?.toLowerCase() == 'yes'
                                        ? Icons.check_circle
                                        : Icons.error,
                                iconColor:
                                    q.answer?.toLowerCase() == 'yes'
                                        ? AppColor.green
                                        : AppColor.error,
                                text: '${q.question} ${q.answer}',
                              )
                              : SizedBox.shrink(),
                    ) ??
                    [],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: onExportPressed,
                  icon: const Icon(Icons.picture_as_pdf_rounded),
                  label: Text(AppStrings.export.tr),
                ),
              ],
            ),
          ],
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
  const _IconLabel({required this.icon, required this.text, this.iconColor});

  final IconData icon;
  final String text;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor ?? AppColor.primary),
        const SizedBox(width: 8),
        Text(text, style: AppFont.font16W600Black),
      ],
    );
  }
}
