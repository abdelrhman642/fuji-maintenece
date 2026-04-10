import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/model/report_question_malfunctio_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/widgets/malfunction_text_answer_field.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/custom_question_yes_no_tile.dart';

class MalfunctionQuestionsListBuilder extends StatelessWidget {
  const MalfunctionQuestionsListBuilder({
    super.key,
    required this.questions,
    required this.textControllers,
    required this.yesNoAnswers,
    required this.onYesNoChanged,
  });

  final List<ReportQuestionMalfunctioModel> questions;
  final Map<int, TextEditingController> textControllers;
  final Map<int, bool?> yesNoAnswers;
  final Function(int questionId, bool? value) onYesNoChanged;

  @override
  Widget build(BuildContext context) {
    final textQuestions =
        questions.where((q) => q.answerType != false).toList();
    final yesNoQuestions =
        questions.where((q) => q.answerType == false).toList();

    return Column(
      children: [
        ...textQuestions.map((question) {
          // Create controller if not exists
          if (!textControllers.containsKey(question.id)) {
            textControllers[question.id!] = TextEditingController();
          }

          return MalfunctionTextAnswerField(
            question: question,
            controller: textControllers[question.id!]!,
          );
        }),
        ...yesNoQuestions.map((question) {
          return QuestionYesNoTile(
            question: question.question!,
            initialValue: yesNoAnswers[question.id],
            onChanged: (value) => onYesNoChanged(question.id!, value),
          );
        }),
      ],
    );
  }
}
