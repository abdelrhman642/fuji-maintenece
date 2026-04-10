import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/data/model/report_question_malfunctio_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/cubit/report_question_malfunction_state.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/malfunctionMaintenance/presentation/widgets/malfunction_questions_list_builder.dart';
import 'package:get/get.dart';

class MalfunctionQuestionsContainer extends StatelessWidget {
  const MalfunctionQuestionsContainer({
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
      child: BlocBuilder<
        ReportQuestionMalfunctionCubit,
        ReportQuestionMalfunctionState
      >(
        buildWhen: (previous, current) {
          return current is! ReportQuestionMalfunctionSubmitInProgress &&
              current is! ReportQuestionMalfunctionSubmitSuccess &&
              current is! ReportQuestionMalfunctionSubmitFailure;
        },
        builder: (context, state) {
          if (state is ReportQuestionMalfunctionLoading) {
            return const CustomLoadingIndicator();
          }
          if (state is ReportQuestionMalfunctionLoaded) {
            return MalfunctionQuestionsListBuilder(
              questions: [
                ...state.questions,
                ReportQuestionMalfunctioModel(
                  id: -1,
                  question: 'هل تم تغيير قطع غيار ؟',
                  answerType: false,
                ),
              ],
              textControllers: textControllers,
              yesNoAnswers: yesNoAnswers,
              onYesNoChanged: onYesNoChanged,
            );
          } else if (state is ReportQuestionMalfunctionError) {
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
    );
  }
}
