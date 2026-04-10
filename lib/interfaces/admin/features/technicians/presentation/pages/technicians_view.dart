import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/core/widgets/tab_buttons_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technicians%20cubit/technicians_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/widgets/technicians_view_body.dart';
import 'package:get/get.dart';

class TechniciansView extends StatefulWidget {
  const TechniciansView({super.key});
  @override
  State<TechniciansView> createState() => _TechniciansViewState();
}

class _TechniciansViewState extends State<TechniciansView> {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.technicians.tr),
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            TabButtonsWidget(
              selectedIndex: selectedIndex,
              onTabSelected: (index) {
                setState(() {
                  selectedIndex = index;
                  if (index == 0) {
                    context.read<TechniciansCubit>().filterByActive(null);
                  }
                  if (index == 1) {
                    context.read<TechniciansCubit>().filterByActive(true);
                  }
                  if (index == 2) {
                    context.read<TechniciansCubit>().filterByActive(false);
                  }
                });
              },
              tabNames: [
                AppStrings.all.tr,
                AppStrings.activeLabel.tr,
                AppStrings.inactiveLabel.tr,
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: CustomTextField(
                onChanged: (query) {
                  context.read<TechniciansCubit>().searchTechniciansByName(
                    query,
                  );
                },
                controller: searchController,
                hintText: AppStrings.search.tr,
                prefixIcon: Icons.search,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
            Expanded(child: TechniciansViewBody()),
          ],
        ),
      ),
    );
  }
}
