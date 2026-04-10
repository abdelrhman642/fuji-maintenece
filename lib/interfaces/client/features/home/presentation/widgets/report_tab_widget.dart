import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/models/report_model/report_model.dart';
import 'package:fuji_maintenance_system/core/widgets/report_card.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/manager/export%20pdf/export_pdf_cubit.dart';
import 'package:open_filex/open_filex.dart';

class ReportTab extends StatelessWidget {
  const ReportTab({super.key, required this.reports});
  final List<ReportModel> reports;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExportPdfCubit>(),
      child: Column(
        children: [
          BlocListener<ExportPdfCubit, ExportPdfState>(
            listener: (context, state) {
              if (state is ExportPdfSuccess) {
                OpenFilex.open(state.filePath);
              } else if (state is ExportPdfFailure) {
                context.showError(state.message);
              } else if (state is ExportPdfLoading) {}
            },
            child: Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return ReportCard(
                    model: report,
                    onExportPressed: () {
                      context.read<ExportPdfCubit>().exportReportAsPdf(
                        report.id!,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
