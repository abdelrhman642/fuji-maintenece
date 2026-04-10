import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class SingleBarChart extends StatelessWidget {
  const SingleBarChart({
    super.key,
    required this.data,
    required this.color,
    this.maxY = 10,
    this.showLabels = true,
    this.labels,
  });

  final List<double> data;
  final List<String>? labels;
  final Color color;
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
    const barWidth = 12.0;
    const groupSpace = 25.0;

    final labelsList =
        (labels != null && labels!.isNotEmpty) ? labels! : _months;

    final totalWidth = (labelsList.length * (barWidth + groupSpace)) + 32;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteOrGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
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
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: showLabels,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= labelsList.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          labelsList[i],
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(
                labelsList.length,
                (i) => _makeGroup(i, i < data.length ? data[i] : 0.0, barWidth),
              ),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => color.withOpacity(0.8),
                  tooltipRoundedRadius: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final idx = group.x;
                    final label =
                        (idx >= 0 && idx < labelsList.length)
                            ? labelsList[idx]
                            : '';
                    return BarTooltipItem(
                      '$label\n${rod.toY.toStringAsFixed(0)}',
                      TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeGroup(int x, double height, double width) {
    return BarChartGroupData(
      x: x,
      barsSpace: 0,
      barRods: [
        BarChartRodData(
          toY: height,
          width: width,
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}
