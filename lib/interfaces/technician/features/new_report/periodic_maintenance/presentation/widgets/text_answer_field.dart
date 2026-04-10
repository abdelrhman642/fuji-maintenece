import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/data/model/report_question_periodic_model.dart';

class TextAnswerField extends StatelessWidget {
  const TextAnswerField({
    super.key,
    required this.question,
    required this.controller,
  });

  final ReportQuestionPeriodicModel question;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomTextField(
        contentPadding: const EdgeInsets.all(12),
        controller: controller,
        maxLines: 3,
        minLines: 1,
        labelText: question.question,
        keyboardType: TextInputType.multiline,
        fillColor: AppColor.backroyndIcon,
        borderColor: AppColor.gray_3,
        borderRadius: 8,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
