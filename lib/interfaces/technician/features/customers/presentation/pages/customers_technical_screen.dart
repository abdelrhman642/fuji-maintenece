import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/widgets/customers_technician_screen_body.dart';
import 'package:get/get.dart';

class CustomersTechnicalScreen extends StatelessWidget {
  CustomersTechnicalScreen({super.key});
  final searchController = TextEditingController();
  void dispose() {
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          CustomAppBarWidget(title: AppStrings.customers.tr),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: CustomTextField(
              controller: searchController,
              hintText: AppStrings.search.tr,
              prefixIcon: Icons.search,
              onChanged: (value) {
                context.read<CustomersCubit>().searchClientsByName(value);
              },
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Expanded(child: CustomersTechnicianScreenBody()),
        ],
      ),
    );
  }
}
