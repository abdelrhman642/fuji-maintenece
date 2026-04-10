import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/domain/models/chart_data.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/single_bar_chart.dart';
import 'package:get/get.dart';

class HomeChartSection extends StatelessWidget {
  final List<ChartData> chartData;
  final ChartType selectedType;
  final ValueChanged<ChartType> onTypeChanged;
  final List<String>? chartLabels;

  const HomeChartSection({
    super.key,
    required this.chartData,
    required this.selectedType,
    required this.onTypeChanged,
    this.chartLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteOrGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [_buildChartToggleButtons(), _buildChart()]),
    );
  }

  Widget _buildChartToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              ChartType.values.map((type) {
                final isSelected = selectedType == type;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildToggleButton(type, isSelected),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildToggleButton(ChartType type, bool isSelected) {
    return GestureDetector(
      onTap: () => onTypeChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _getChartColor(type) : AppColor.whiteOrGrey,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          border: Border.all(
            color: isSelected ? _getChartColor(type) : AppColor.lightGrey,
            width: 1,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: _getChartColor(type).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          _getChartTitle(type),
          style: TextStyle(
            color: isSelected ? AppColor.white : AppColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    // Handle empty chartData gracefully
    if (chartData.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('لا توجد بيانات للرسم البياني')),
      );
    }

    // Find chart data for selected type, or use first available
    final selectedChart =
        chartData.any((chart) => chart.type == selectedType)
            ? chartData.firstWhere((chart) => chart.type == selectedType)
            : chartData.first;

    return SingleBarChart(
      data: selectedChart.data,
      color: _getChartColor(selectedType),
      maxY: _calculateMaxY(selectedChart.data),
      showLabels: true,
      labels: chartLabels,
    );
  }

  double _calculateMaxY(List<double> data) {
    if (data.isEmpty) return 10;
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    return (maxValue * 1.2).ceilToDouble();
  }

  String _getChartTitle(ChartType type) {
    switch (type) {
      case ChartType.customers:
        return AppStrings.customers.tr;
      case ChartType.technicians:
        return AppStrings.technicians.tr;
      case ChartType.reports:
        return AppStrings.reports.tr;
    }
  }

  Color _getChartColor(ChartType type) {
    switch (type) {
      case ChartType.customers:
        return AppColor.primary;
      case ChartType.technicians:
        return AppColor.primaryLighter;
      case ChartType.reports:
        return AppColor.neutral;
    }
  }
}
