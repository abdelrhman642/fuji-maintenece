import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/tab_buttons_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/presentation/cubit/visits_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/visits/presentation/widgets/visits_filter_dialog.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// Visits screen for admin interface
class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
  int selectedIndex = 0;
  int? selectedYear;
  int? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(
        title: AppStrings.visits.tr,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: AppColor.white),
            onPressed: () async {
              final result = await VisitsFilterDialog.show(
                context,
                initialYear: selectedYear,
                initialMonth: selectedMonth,
              );
              if (result != null) {
                setState(() {
                  selectedYear = result['year'];
                  selectedMonth = result['month'];
                  // TODO: Apply filter to cubit when data is available
                  // context.read<VisitsCubit>().filterByYearAndMonth(selectedYear, selectedMonth);
                });
              }
            },
            tooltip: 'Filter',
          ),
        ],
      ),
      body: Column(
        children: [
          TabButtonsWidget(
            selectedIndex: selectedIndex,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
                // TODO: Add filtering logic when needed
              });
            },
            tabNames: [
              AppStrings.all.tr,
              AppStrings.visited.tr,
              AppStrings.notVisited.tr,
            ],
          ),
          Expanded(
            child: BlocBuilder<VisitsCubit, VisitsState>(
              builder: (context, state) {
                // Empty screen for now
                return const Center(
                  child: Text('No visits data available yet.'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
