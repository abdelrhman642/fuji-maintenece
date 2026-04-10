import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/model/report_question_malfunctio_model.dart';
import 'package:get/get.dart';

class MalfunctionTextAnswerField extends StatelessWidget {
  const MalfunctionTextAnswerField({
    super.key,
    required this.question,
    required this.controller,
  });

  final ReportQuestionMalfunctioModel question;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: CustomTextField(
        onChanged: (value) {
          // Value is automatically stored in the controller
        },
        minLines: 1,
        labelText: question.question,
        controller: controller,
        hintText: AppStrings.enterMalfunctionDetails.tr,
        maxLines: 3,
        borderRadius: 8,
        borderColor: AppColor.gray_3,
        hintStyle: AppFont.appBarTitle.copyWith(
          color: AppColor.grey2,
          fontSize: 16,
        ),
        fillColor: AppColor.backroyndIcon,
      ),
    );
  }
}
