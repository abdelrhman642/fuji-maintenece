import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomVisitsCard extends StatefulWidget {
  final double percent;

  final String title;

  const CustomVisitsCard({
    super.key,
    required this.percent,

    required this.title,
  });

  @override
  State<CustomVisitsCard> createState() => _VisitsCardState();
}

class _VisitsCardState extends State<CustomVisitsCard> {
  @override
  Widget build(BuildContext context) {
    // String period = AppStrings.daily.tr;

    return Container(
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: AppColor.blackColor.withOpacity(0.1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const SizedBox(width: 8),
              // Container(
              //   constraints: const BoxConstraints(maxWidth: 80),
              //   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              //   decoration: BoxDecoration(
              //     color: AppColor.white,
              //     borderRadius: BorderRadius.circular(8),
              //     border: Border.all(color: AppColor.lightGrey, width: 1),
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       value: period,
              //       icon: const Icon(Icons.keyboard_arrow_down, size: 14),
              //       isDense: true,
              //       isExpanded: true,
              //       style: const TextStyle(fontSize: 10, color: Colors.black),
              //       items: [
              //         DropdownMenuItem(
              //           value: AppStrings.daily.tr,
              //           child: Text(
              //             AppStrings.daily.tr,
              //             style: const TextStyle(fontSize: 10),
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           value: AppStrings.weekly.tr,
              //           child: Text(
              //             AppStrings.weekly.tr,
              //             style: const TextStyle(fontSize: 10),
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           value: AppStrings.monthly.tr,
              //           child: Text(
              //             AppStrings.monthly.tr,
              //             style: const TextStyle(fontSize: 10),
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //       ],
              //       onChanged: (v) => setState(() => period = v!),
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: CircularPercentIndicator(
              radius: 70,
              lineWidth: 12,
              percent: widget.percent,
              animation: true,
              animateFromLastPercent: true,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: AppColor.lightGrey,
              progressColor:
                  widget.percent < 0.5 ? AppColor.primary : AppColor.green,
              center: Text(
                '${(widget.percent * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color:
                      widget.percent < 0.5 ? AppColor.primary : AppColor.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
