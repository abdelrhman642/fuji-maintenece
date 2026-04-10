import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/setting_option_card.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20brands%20cubit/elevator_brands_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/widgets/show_add_elevator_brand.dart';
import 'package:get/get.dart';

class ElevatorBrandsScreenBody extends StatelessWidget {
  const ElevatorBrandsScreenBody({
    super.key,
    required this.brands,
    required this.cubit,
  });
  final List<ElevatorBrandModel> brands;
  final ElevatorBrandsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return SettingOptionCard(
                title: AppStrings.elevatorBrandSingle.tr,
                description: brand.nameAr ?? '',
                enabled: brand.status == "active",
                onSwitchChanged: (value) {
                  if (value) {
                    cubit.activateBrandById(brand.id!);
                  } else {
                    cubit.deactivateBrandById(brand.id!);
                  }
                },
                onEdit: () {
                  showAddElevatorBrand(
                    context,
                    cubit,
                    isEdit: true,
                    model: brand,
                  );
                },
              );
            },
          ),
        ),

        SizedBox(height: 16.h),

        _buildAddButton(context),
      ],
    );
  }

  Padding _buildAddButton(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: ElevatedButton(
          onPressed: () {
            showAddElevatorBrand(context, cubit);
          },
          child: Text(AppStrings.add.tr),
        ),
      ),
    );
  }
}
