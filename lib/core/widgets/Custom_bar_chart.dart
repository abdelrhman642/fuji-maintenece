import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    super.key,
    this.customersData,
    this.techniciansData,
    this.reportsData,
    this.maxY = 10,
    this.showLabels = true,
  });

  final List<double>? customersData;
  final List<double>? techniciansData;
  final List<double>? reportsData;
  final double maxY;
  final bool showLabels;

  static const _months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    // Default data for each category
    final customers =
        customersData ?? const [6, 7, 4, 3, 8, 7, 5, 6, 4, 9, 6, 8];
    final technicians =
        techniciansData ?? const [4, 5, 6, 2, 7, 5, 3, 4, 6, 7, 4, 6];
    final reports = reportsData ?? const [8, 6, 5, 7, 9, 8, 7, 8, 5, 10, 7, 9];

    const barWidth = 4.0;
    const groupSpace = 30.0;

    final totalWidth = (_months.length * (barWidth * 3 + groupSpace)) + 32;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteOrGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          // Legend
          if (showLabels)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildLegendItem('Customers', AppColor.primary),
                  const SizedBox(width: 20),
                  _buildLegendItem('Technicians', AppColor.green),
                  const SizedBox(width: 20),
                  _buildLegendItem('Reports', AppColor.primaryDark),
                ],
              ),
            ),
          // Chart
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: totalWidth,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: showLabels,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) {
                            final i = value.toInt();
                            if (i < 0 || i >= _months.length) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                _months[i],
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List.generate(
                      _months.length,
                      (i) => _makeGroup(
                        i,
                        customers[i],
                        technicians[i],
                        reports[i],
                        barWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  BarChartGroupData _makeGroup(
    int x,
    double customersHeight,
    double techniciansHeight,
    double reportsHeight,
    double width,
  ) {
    return BarChartGroupData(
      x: x,
      barsSpace: 2,
      barRods: [
        BarChartRodData(
          toY: customersHeight,
          width: width,
          color: AppColor.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: techniciansHeight,
          width: width,
          color: AppColor.green,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: reportsHeight,
          width: width,
          color: AppColor.primaryDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}
