import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// Widget for showing year and month filter dialog
class VisitsFilterDialog extends StatelessWidget {
  const VisitsFilterDialog({super.key, this.initialYear, this.initialMonth});

  final int? initialYear;
  final int? initialMonth;

  /// Show filter dialog for year and month selection
  static Future<Map<String, int?>?> show(
    BuildContext context, {
    int? initialYear,
    int? initialMonth,
  }) async {
    return await showDialog<Map<String, int?>>(
      context: context,
      builder:
          (context) => VisitsFilterDialog(
            initialYear: initialYear,
            initialMonth: initialMonth,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? tempYear = initialYear ?? DateTime.now().year;
    int? tempMonth = initialMonth ?? DateTime.now().month;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(AppStrings.filter.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Year selection
              Row(
                children: [
                  Text('${AppStrings.year.tr}:'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<int>(
                      value: tempYear,
                      isExpanded: true,
                      items:
                          List.generate(10, (i) => DateTime.now().year - 5 + i)
                              .map(
                                (year) => DropdownMenuItem(
                                  value: year,
                                  child: Text(year.toString()),
                                ),
                              )
                              .toList(),
                      onChanged: (v) {
                        setState(() {
                          tempYear = v;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Month selection
              Row(
                children: [
                  Text('${AppStrings.months.tr}:'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<int>(
                      value: tempMonth,
                      isExpanded: true,
                      items:
                          List.generate(12, (i) => i + 1)
                              .map(
                                (month) => DropdownMenuItem(
                                  value: month,
                                  child: Text(_getMonthName(month)),
                                ),
                              )
                              .toList(),
                      onChanged: (v) {
                        setState(() {
                          tempMonth = v;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop({'year': null, 'month': null});
              },
              child: const Text('Clear Filter'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppStrings.cancel.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pop({'year': tempYear, 'month': tempMonth});
              },
              child: Text(AppStrings.confirm.tr),
            ),
          ],
        );
      },
    );
  }

  /// Get month name in Arabic/English based on locale
  String _getMonthName(int month) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
