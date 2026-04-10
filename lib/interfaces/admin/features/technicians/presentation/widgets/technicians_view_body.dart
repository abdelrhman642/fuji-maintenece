import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/technician_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technicians%20cubit/technicians_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/widgets/custom_technicians_card.dart';

class TechniciansViewBody extends StatefulWidget {
  const TechniciansViewBody({super.key});

  @override
  State<TechniciansViewBody> createState() => _TechniciansViewBodyState();
}

class _TechniciansViewBodyState extends State<TechniciansViewBody> {
  bool isFirstBuild = true;
  List<TechnicianModel> technicians = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechniciansCubit, TechniciansState>(
      listener: (context, state) {
        if (state is TechniciansUpdateError) {
          context.showError(state.message);
        }
        if (state is TechniciansUpdateSuccess) {
          context.showSuccess(state.message);
        }
        if (state is TechniciansEditError) {
          context.showError(state.message);
        }
        if (state is TechniciansEditSuccess) {
          context.showSuccess(state.message);
        }
        if (state is TechniciansLoaded) {
          isFirstBuild = false;
          technicians = state.technicians;
        }
      },
      builder: (context, state) {
        if (state is TechniciansLoading && isFirstBuild) {
          return const CustomLoadingIndicator();
        } else if (state is TechniciansError) {
          return Center(child: Text(state.message));
        } else if (state is TechniciansLoaded) {
          if (state.technicians.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
        }
        return ListView.builder(
          itemCount: technicians.length,
          itemBuilder: (context, index) {
            final technician = technicians[index];
            return CustomTechniciansCard(
              key: ValueKey(technician.id ?? index),
              model: technician,
            );
          },
        );
      },
    );
  }
}
