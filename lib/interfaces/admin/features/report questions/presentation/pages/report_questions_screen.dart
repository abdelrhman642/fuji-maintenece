import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/data/models/question_response_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/cubit/report_questions_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/widgets/report_questions_screen_body.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/report%20questions/presentation/widgets/show_add_question_bottom_sheet.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ReportQuestionsScreen extends StatefulWidget {
  const ReportQuestionsScreen({super.key});

  @override
  State<ReportQuestionsScreen> createState() => _ReportQuestionsScreenState();
}

class _ReportQuestionsScreenState extends State<ReportQuestionsScreen> {
  List<QuestionResponseModel> questions = [];
  bool isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(
        title: AppStrings.reportQuestions.tr,
        actions: [
          IconButton(
            onPressed:
                () => showAddQuestionBottomSheet(
                  context.read<ReportQuestionsCubit>(),
                  context,
                ),
            icon: const Icon(Icons.add, size: 30),
            color: AppColor.white,
          ),
        ],
      ),
      body: BlocConsumer<ReportQuestionsCubit, ReportQuestionsState>(
        builder: (context, state) {
          if (state is ReportQuestionsLoading && isFirstLoad) {
            isFirstLoad = false;
            return const CustomLoadingIndicator();
          } else if (state is ReportQuestionsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is ReportQuestionsLoaded) {
            questions = (state.questions);
          }

          return ReportQuestionsScreenBody(questions: questions);
        },
        listener: (context, state) {
          if (state is ReportQuestionsAddSuccess) {
            context.read<ReportQuestionsCubit>().fetchQuestions();
            context.showSuccess(state.message);
          } else if (state is ReportQuestionsDeleteSuccess) {
            context.read<ReportQuestionsCubit>().fetchQuestions();
            context.showSuccess(state.message);
          } else if (state is ReportQuestionsUpdateSuccess) {
            context.read<ReportQuestionsCubit>().fetchQuestions();
            context.showSuccess(state.message);
          }
          if (state is ReportQuestionsAddFailure) {
            context.showError(state.message);
          } else if (state is ReportQuestionsDeleteFailure) {
            context.showError(state.message);
          } else if (state is ReportQuestionsUpdateFailure) {
            context.showError(state.message);
          }
          if (state is ReportQuestionsAddLoading ||
              state is ReportQuestionsDeleteLoading ||
              state is ReportQuestionsUpdateLoading) {}
        },
      ),
    );
  }
}
