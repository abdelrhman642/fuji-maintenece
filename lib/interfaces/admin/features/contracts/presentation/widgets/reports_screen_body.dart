import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/report_card.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/reports%20cubit/reports_cubit.dart';
import 'package:open_filex/open_filex.dart';

class ReportsScreenBody extends StatelessWidget {
  const ReportsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is ReportPdfError) {
          context.showError(state.message);
        }
        if (state is ReportPdfLoaded) {
          OpenFilex.open(state.filePath);
        }
        if (state is ReportPdfLoading) {}
      },
      buildWhen: (previous, current) {
        if (current is! ReportPdfError &&
            current is! ReportPdfLoading &&
            current is! ReportPdfLoaded) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is ReportsLoading) {
          return const CustomLoadingIndicator();
        } else if (state is ReportsError) {
          return Center(child: Text(state.message));
        } else if (state is ReportsLoaded) {
          if (state.reports.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
          return ListView.builder(
            itemCount: state.reports.length,
            itemBuilder: (context, index) {
              return ReportCard(
                model: state.reports[index],
                onExportPressed: () async {
                  context.read<ReportsCubit>().exportReportAsPdf(
                    state.reports[index].id!,
                  );
                },
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
