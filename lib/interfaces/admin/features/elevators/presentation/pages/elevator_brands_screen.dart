import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/no_data_fount_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_brand_model/elevator_brand_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20brands%20cubit/elevator_brands_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/widgets/elevator_brands_screen_body.dart';
import 'package:get/get.dart';

class ElevatorBrandsScreen extends StatefulWidget {
  const ElevatorBrandsScreen({super.key});

  @override
  State<ElevatorBrandsScreen> createState() => _ElevatorBrandsScreenState();
}

class _ElevatorBrandsScreenState extends State<ElevatorBrandsScreen> {
  List<ElevatorBrandModel> brands = [];
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.elevatorBrands.tr),
      body: BlocConsumer<ElevatorBrandsCubit, ElevatorBrandsState>(
        listener: (context, state) {
          if (state is ElevatorBrandsLoaded) {
            brands = state.brands;
          }
          if (state is ElevatorBrandActionSuccess) {
            context.read<ElevatorBrandsCubit>().fetchAllElevatorBrands();
          }
          if (state is ElevatorBrandActionFailure) {
            context.showError(state.message);
          }
        },
        builder: (context, state) {
          if (state is ElevatorBrandsFailure) {
            return Center(
              child: Text(state.message, style: AppFont.font16W600Gray2),
            );
          }
          if (state is ElevatorBrandsLoading && isFirst) {
            isFirst = false;
            return const CustomLoadingIndicator();
          } else {
            if (brands.isEmpty) {
              return NoDataFoundWidget();
            }
            final cubit = context.read<ElevatorBrandsCubit>();
            return ElevatorBrandsScreenBody(brands: brands, cubit: cubit);
          }
        },
      ),
    );
  }
}
