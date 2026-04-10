import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/chart_data.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/home_statistics.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/home_chart_section.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/home_statistics_grid.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/home_visits_reports_section.dart';

class HomeBody extends StatelessWidget {
  final HomeStatistics statistics;
  final List<ChartData> chartData;
  final ChartType selectedChartType;
  final ValueChanged<ChartType> onChartTypeChanged;
  final double visitsProgress;
  final double reportsProgress;
  final List<String>? chartLabels;

  const HomeBody({
    super.key,
    required this.statistics,
    required this.chartData,
    required this.selectedChartType,
    required this.onChartTypeChanged,
    required this.visitsProgress,
    required this.reportsProgress,
    this.chartLabels,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Statistics Grid
          HomeStatisticsGrid(statistics: statistics),

          const SizedBox(height: 20),

          // Chart Section
          HomeChartSection(
            chartData: chartData,
            selectedType: selectedChartType,
            onTypeChanged: onChartTypeChanged,
            chartLabels: chartLabels,
          ),

          const SizedBox(height: 20),

          // Visits and Reports Section
          HomeVisitsReportsSection(
            visitsProgress: visitsProgress,
            reportsProgress: reportsProgress,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
