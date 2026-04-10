import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/no_data_fount_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/data/models/elevator_type_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/manager/elevator%20types%20cubit/elevator_types_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/elevators/presentation/widgets/elevator_types_screen_body.dart';
import 'package:get/get.dart';

class ElevatorTypesScreen extends StatefulWidget {
  const ElevatorTypesScreen({super.key});

  @override
  State<ElevatorTypesScreen> createState() => _ElevatorTypesScreenState();
}

class _ElevatorTypesScreenState extends State<ElevatorTypesScreen> {
  List<ElevatorTypeModel> types = [];
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.elevatorTypes.tr),
      body: BlocConsumer<ElevatorTypesCubit, ElevatorTypesState>(
        listener: (context, state) {
          if (state is ElevatorTypesLoaded) {
            types = state.types;
          }
          if (state is ElevatorTypeActionFailure) {
            context.showError(state.message);
          }
          if (state is ElevatorTypeActionSuccess) {
            context.read<ElevatorTypesCubit>().fetchAllElevatorTypes();
          }
        },
        builder: (context, state) {
          if (state is ElevatorTypesError) {
            return Center(
              child: Text(state.message, style: AppFont.font16W600Gray2),
            );
          } else if (state is ElevatorTypesLoading && isFirst) {
            isFirst = false;
            return const CustomLoadingIndicator();
          } else {
            if (types.isEmpty) {
              return NoDataFoundWidget();
            }
            final cubit = context.read<ElevatorTypesCubit>();
            return ElevatorTypesScreenBody(types: types, cubit: cubit);
          }
        },
      ),
    );
  }
}
