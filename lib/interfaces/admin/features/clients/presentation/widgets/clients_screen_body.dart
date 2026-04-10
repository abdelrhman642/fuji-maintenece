import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_client_card.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/clients%20cubit/clients_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/widgets/show_edit_client_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

class ClientsScreenBody extends StatelessWidget {
  const ClientsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientsCubit, ClientsState>(
      buildWhen:
          (previous, current) =>
              current is ClientsLoaded ||
              current is ClientsError ||
              current is ClientsLoading,
      builder: (context, state) {
        if (state is ClientsLoading) {
          return const CustomLoadingIndicator();
        } else if (state is ClientsError) {
          return Center(child: Text(state.message));
        } else if (state is ClientsLoaded) {
          if (state.clients.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
          return BlocListener<ClientsCubit, ClientsState>(
            listener: (context, state) {
              if (state is ClientEditSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.success,
                  ),
                );
              } else if (state is ClientEditError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            child: ListView.builder(
              itemCount: state.clients.length,
              itemBuilder: (context, index) {
                final client = state.clients[index];
                final cubit = context.read<ClientsCubit>();
                return CustomClientCard(
                  clientModel: client,
                  onTap: () {
                    context.push(Routes.clientDetailsScreen, extra: client.id);
                  },
                  onEdit: () {
                    showEditClientBottomSheet(context, cubit, client);
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
