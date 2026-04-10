import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_response_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/cubit/report_questions_cubit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

void showAddQuestionBottomSheet(
  ReportQuestionsCubit cubit,
  BuildContext context, {
  QuestionResponseModel? question,
}) {
  final isEdit = question != null;
  final questionController = TextEditingController(
    text: question?.question ?? '',
  );
  String selectedType = question?.type ?? 'periodic';
  bool selectedAnswerType = question?.answerType ?? false;
  bool selectedStatus = question?.status ?? false;
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (bottomSheetContext) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      isEdit
                          ? AppStrings.updateQuestion.tr
                          : AppStrings.reportQuestion.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Question Input
                  TextField(
                    controller: questionController,
                    decoration: InputDecoration(
                      labelText: AppStrings.question.tr,
                      hintText: AppStrings.enterYourQuestion.tr,
                      prefixIcon: const Icon(Icons.help_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                    maxLines: 2,
                    minLines: 1,
                  ),
                  const SizedBox(height: 20),

                  // Type Selection
                  Text(
                    AppStrings.type.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectionCard(
                          icon: Icons.schedule,
                          label: AppStrings.periodic.tr,
                          isSelected: selectedType == 'periodic',
                          color: Colors.blue,
                          onTap: () {
                            setModalState(() {
                              selectedType = 'periodic';
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSelectionCard(
                          icon: Icons.warning_amber_rounded,
                          label: AppStrings.faults.tr,
                          isSelected: selectedType == 'faults',
                          color: Colors.purple,
                          onTap: () {
                            setModalState(() {
                              selectedType = 'faults';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Answer Type Selection
                  Text(
                    AppStrings.answerType.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectionCard(
                          icon: Icons.text_fields,
                          label: AppStrings.text.tr,
                          isSelected: selectedAnswerType == true,
                          color: Colors.green,
                          onTap: () {
                            setModalState(() {
                              selectedAnswerType = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSelectionCard(
                          icon: Icons.check_box,
                          label: AppStrings.boolean.tr,
                          isSelected: selectedAnswerType == false,
                          color: Colors.orange,
                          onTap: () {
                            setModalState(() {
                              selectedAnswerType = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Status Selection
                  Text(
                    AppStrings.status.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelectionCard(
                          icon: Icons.toggle_on,
                          label: AppStrings.activeLabel.tr,
                          isSelected: selectedStatus == true,
                          color: Colors.teal,
                          onTap: () {
                            setModalState(() {
                              selectedStatus = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSelectionCard(
                          icon: Icons.toggle_off,
                          label: AppStrings.inactiveLabel.tr,
                          isSelected: selectedStatus == false,
                          color: Colors.grey,
                          onTap: () {
                            setModalState(() {
                              selectedStatus = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (questionController.text.trim().isEmpty) return;

                        final request = QuestionRequest(
                          question: questionController.text,
                          type: selectedType,
                          answerType: selectedAnswerType ? 1 : 0,
                          status: selectedStatus ? 1 : 0,
                        );

                        // Call the cubit to add or update question
                        if (isEdit && question.id != null) {
                          cubit.updateQuestion(question.id!, request);
                        } else {
                          cubit.addQuestion(request);
                        }

                        Navigator.pop(bottomSheetContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isEdit ? AppStrings.update.tr : AppStrings.submit.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildSelectionCard({
  required IconData icon,
  required String label,
  required bool isSelected,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.15) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? color : Colors.grey.shade400,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? color : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
  );
}
