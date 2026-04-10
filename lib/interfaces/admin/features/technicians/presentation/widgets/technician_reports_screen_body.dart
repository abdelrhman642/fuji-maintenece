import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/report_card.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technician%20reports/technician_reports_cubit.dart';

class TechnicianReportsScreenBody extends StatelessWidget {
  const TechnicianReportsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianReportsCubit, TechnicianReportsState>(
      builder: (context, state) {
        if (state is TechnicianReportsLoading) {
          return const CustomLoadingIndicator();
        } else if (state is TechnicianReportsError) {
          return Center(child: Text(state.message));
        } else if (state is TechnicianReportsLoaded) {
          if (state.reports.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
          return ListView.builder(
            itemCount: state.reports.length,
            itemBuilder: (context, index) {
              final report = state.reports[index];
              return ReportCard(model: report, showClientName: true);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
