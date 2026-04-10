import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/model/store_report_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_state.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/widgets/image_picker_widget.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/widgets/notes_section.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/widgets/questions_container.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/custom_bottom.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PeriodicMaintenanceReport extends StatefulWidget {
  const PeriodicMaintenanceReport({super.key, required this.contractId});
  final int contractId;

  @override
  State<PeriodicMaintenanceReport> createState() =>
      _PeriodicMaintenanceReportState();
}

class _PeriodicMaintenanceReportState extends State<PeriodicMaintenanceReport> {
  File? _imageFile;
  final TextEditingController _notesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Map to store text field controllers for each question
  final Map<int, TextEditingController> _textControllers = {};
  // Map to store yes/no answers for each question
  final Map<int, bool?> _yesNoAnswers = {};
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _formKey.currentState?.reset();
    // Dispose all text controllers
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(
        title: AppStrings.periodicMaintenanceReport.tr,
      ),
      body: SafeArea(
        top: true,
        child: BlocConsumer<
          ReportQuestionPeriodicCubit,
          ReportQuestionPeriodicState
        >(
          listener: _handleStateChanges,
          buildWhen:
              (previous, current) =>
                  current is! ReportQuestionPeriodicSubmitInProgress &&
                  current is! ReportQuestionPeriodicSubmitSuccess &&
                  current is! ReportQuestionPeriodicSubmitFailure,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    QuestionsContainer(
                      textControllers: _textControllers,
                      yesNoAnswers: _yesNoAnswers,
                      onYesNoChanged: _handleYesNoAnswerChanged,
                    ),
                    NotesSection(controller: _notesController),
                    ImagePickerWidget(imageFile: _imageFile, onTap: _pickImage),
                    const SizedBox(height: 24),
                    CustomBottom(
                      title: AppStrings.sendReport.tr,
                      backgroundColor: AppColor.primaryDark,
                      onPressed: _submitReport,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
    ReportQuestionPeriodicState state,
  ) {
    if (state is ReportQuestionPeriodicSubmitFailure) {
      context.showError(state.error);
    }
    if (state is ReportQuestionPeriodicSubmitSuccess) {
      context.pushReplacement(
        Routes.sendReport,
        extra: state.submitReportModel,
      );
    }
    if (state is ReportQuestionPeriodicSubmitInProgress) {}
  }

  void _submitReport() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final state = context.read<ReportQuestionPeriodicCubit>().state;

    if (state is ReportQuestionPeriodicLoaded) {
      final questionsAnswers = _buildQuestionsAnswers(state.questions);

      context.read<ReportQuestionPeriodicCubit>().submitReportPeriodic(
        StoreReportRequestModel(
          contractId: widget.contractId,
          reportType: 'periodic',
          questionsAnswers: questionsAnswers,
        ),
      );
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

      // Find matching question; skip if not found
      final matching = questions.where((q) => q.id == questionId);
      if (matching.isEmpty) continue;
      final question = matching.first;

      questionsAnswers.add(
        QuestionsAnswersRequestModel(
          questionId: questionId,
          question: question.question,
          answerType: 0,
          answer: yesNoValue == null ? '' : (yesNoValue ? 'yes' : 'no'),
        ),
      );
    }

    return questionsAnswers;
  }
}
