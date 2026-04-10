import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/manager/report_question_periodic/report_question_periodic_state.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/periodic_maintenance/presentation/widgets/questions_list_builder.dart';

class QuestionsContainer extends StatelessWidget {
  const QuestionsContainer({
    super.key,
    required this.textControllers,
    required this.yesNoAnswers,
    required this.onYesNoChanged,
  });

  final Map<int, TextEditingController> textControllers;
  final Map<int, bool?> yesNoAnswers;
  final Function(int questionId, bool? value) onYesNoChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.primaryDark),
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<
          ReportQuestionPeriodicCubit,
          ReportQuestionPeriodicState
        >(
          buildWhen: (previous, current) {
            return current is! ReportQuestionPeriodicSubmitInProgress &&
                current is! ReportQuestionPeriodicSubmitSuccess &&
                current is! ReportQuestionPeriodicSubmitFailure;
          },
          builder: (context, state) {
            if (state is ReportQuestionPeriodicLoaded) {
              return QuestionsListBuilder(
                questions: state.questions,
                textControllers: textControllers,
                yesNoAnswers: yesNoAnswers,
                onYesNoChanged: onYesNoChanged,
              );
            } else if (state is ReportQuestionPeriodicLoading) {
              return const CustomLoadingIndicator();
            } else if (state is ReportQuestionPeriodicError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(state.message, style: AppFont.font16W600Black),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
