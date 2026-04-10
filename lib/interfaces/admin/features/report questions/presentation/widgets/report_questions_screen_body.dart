import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_response_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/cubit/report_questions_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/widgets/show_add_question_bottom_sheet.dart';
import 'package:get/get_utils/get_utils.dart';

class ReportQuestionsScreenBody extends StatelessWidget {
  const ReportQuestionsScreenBody({super.key, required this.questions});

  final List<QuestionResponseModel> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return _buildQuestionCard(context, question, () {
          context.read<ReportQuestionsCubit>().deleteQuestion(question.id!);
        });
      },
    );
  }

  Widget _buildQuestionCard(
    BuildContext context,
    QuestionResponseModel question,
    VoidCallback? onDelete,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Title
            Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    question.question ?? AppStrings.noQuestion.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.edit, color: AppColor.darkBlue),
                  onPressed: () {
                    showAddQuestionBottomSheet(
                      context.read<ReportQuestionsCubit>(),
                      context,
                      question: question,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: AppColor.error,
                  ),
                  onPressed: () {
                    _showDeletionDialog(context, onDelete);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Type, Answer, and Status Row
            Row(
              children: [
                // Type Badge
                Expanded(
                  child: _buildInfoChip(
                    icon: Icons.category_outlined,
                    label: AppStrings.type.tr,
                    value: question.type?.tr ?? 'N/A',
                    color:
                        question.type == 'periodic'
                            ? Colors.blue
                            : Colors.purple,
                  ),
                ),
                const SizedBox(width: 8),

                // Answer Badge
                Expanded(
                  child: _buildInfoChip(
                    icon: Icons.question_answer_outlined,
                    label: AppStrings.answerType.tr,
                    value:
                        question.answerType == true
                            ? AppStrings.text.tr
                            : AppStrings.boolean.tr,
                    color:
                        question.answerType == true
                            ? Colors.green
                            : Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),

                // Status Badge
                Expanded(
                  child: _buildInfoChip(
                    icon: Icons.toggle_on_outlined,
                    label: AppStrings.status.tr,
                    value:
                        question.status == true
                            ? AppStrings.activeLabel.tr
                            : AppStrings.inactiveLabel.tr,
                    color: question.status == true ? Colors.teal : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showDeletionDialog(
    BuildContext context,
    VoidCallback? onDelete,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
            size: 40,
          ),
          title: Text(AppStrings.confirmDelete.tr),
          content: Text(AppStrings.deleteQuestionConfirmation.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.cancel.tr),
            ),
            TextButton(
              onPressed: () {
                onDelete?.call();
                Navigator.of(context).pop();
              },
              child: Text(
                AppStrings.delete.tr,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
