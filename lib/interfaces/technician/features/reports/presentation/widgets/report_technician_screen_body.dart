import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/reports/presentation/widgets/tech_report_card.dart';
import 'package:open_filex/open_filex.dart';

class ReportTechnicianScreenBody extends StatelessWidget {
  const ReportTechnicianScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianAllReportsCubit, ReportsState>(
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
          final reports = state.reports;
          if (reports.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final reportModel = reports[index];
              return TechReportCard(
                model: reportModel,
                showClientName: true,
                onExportPressed: () {
                  context.read<TechnicianAllReportsCubit>().exportReportAsPdf(
                    reportModel.id!,
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
