import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_state.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/widgets/malfunction_questions_container.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/custom_bottom.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MalfunctionMaintenanceScreen extends StatefulWidget {
  const MalfunctionMaintenanceScreen({super.key, required this.contractId});
  final int contractId;
  @override
  State<MalfunctionMaintenanceScreen> createState() =>
      _MalfunctionMaintenanceScreenState();
}

class _MalfunctionMaintenanceScreenState
    extends State<MalfunctionMaintenanceScreen> {
  // Map to store text field controllers for each question
  final Map<int, TextEditingController> _textControllers = {};

  // Map to store yes/no answers for each question
  final Map<int, bool?> _yesNoAnswers = {};

  @override
  void dispose() {
    // Dispose all text controllers
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGround,
      appBar: CustomAppBarWidget(
        title: AppStrings.malfunctionMaintenance.tr,
        textColor: AppColor.white,
      ),
      body: BlocConsumer<
        ReportQuestionMalfunctionCubit,
        ReportQuestionMalfunctionState
      >(
        listener: _handleStateChanges,
        buildWhen:
            (previous, current) =>
                current is! ReportQuestionMalfunctionSubmitInProgress &&
                current is! ReportQuestionMalfunctionSubmitSuccess &&
                current is! ReportQuestionMalfunctionSubmitFailure,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                MalfunctionQuestionsContainer(
                  textControllers: _textControllers,
                  yesNoAnswers: _yesNoAnswers,
                  onYesNoChanged: _handleYesNoAnswerChanged,
                ),
                CustomBottom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 18,
                  ),
                  onPressed: _submitReport,
                  title: AppStrings.sent.tr,
                  backgroundColor: AppColor.blackColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleYesNoAnswerChanged(int questionId, bool? value) {
    setState(() {
      _yesNoAnswers[questionId] = value;
    });
  }

  void _handleStateChanges(
    BuildContext context,
    ReportQuestionMalfunctionState state,
  ) {
    if (state is ReportQuestionMalfunctionSubmitFailure) {
      context.showError(state.error);
    }
    if (state is ReportQuestionMalfunctionSubmitSuccess) {
      context.pushReplacement(
        Routes.sendReport,
        extra: state.submitReportModel,
      );
    }
    if (state is ReportQuestionMalfunctionSubmitInProgress) {}
  }

  void _submitReport() {
    final state = context.read<ReportQuestionMalfunctionCubit>().state;

    if (state is ReportQuestionMalfunctionLoaded) {
      StoreReportRequestModel submitReportModel = StoreReportRequestModel(
        contractId: widget.contractId,
        reportType: 'faults',
        questionsAnswers: _buildQuestionsAnswers(state.questions),
      );
      // Check if notes section (id -1) has a "yes" answer
      final notesSectionAnswer = _yesNoAnswers[-1];

      if (notesSectionAnswer == true) {
        // If yes, navigate to MalfunctionReportScreen with submitReportModel
        context.pushReplacement(
          Routes.malfunctionReportScreen,
          extra: submitReportModel,
        );
      } else {
        // Submit the report - navigation will be handled in _handleStateChanges
        context.read<ReportQuestionMalfunctionCubit>().submitReport(
          submitReportModel,
        );
      }
    }
  }

  List<QuestionsAnswersRequestModel> _buildQuestionsAnswers(List questions) {
    final List<QuestionsAnswersRequestModel> questionsAnswers = [];

    // Add text question answers
    for (var entry in _textControllers.entries) {
      final questionId = entry.key;
      final controller = entry.value;
      final answer = controller.text;

      final question = questions.firstWhere((q) => q.id == questionId);

      questionsAnswers.add(
        QuestionsAnswersRequestModel(
          questionId: questionId,
          question: question.question,
          answerType: 1,
          answer: answer,
        ),
      );
    }

    // Add yes/no question answers
    for (var entry in _yesNoAnswers.entries) {
      final questionId = entry.key;
      final yesNoValue = entry.value;

      // Skip the notes section (id -1) - it's not sent to the API
      if (questionId == -1) continue;

      final question = questions.firstWhereOrNull((q) => q.id == questionId);

      if (question != null) {
        questionsAnswers.add(
          QuestionsAnswersRequestModel(
            questionId: questionId,
            question: question.question,
            answerType: 0,
            answer: yesNoValue == null ? '' : (yesNoValue ? 'yes' : 'no'),
          ),
        );
      }
    }

    return questionsAnswers;
  }
}
