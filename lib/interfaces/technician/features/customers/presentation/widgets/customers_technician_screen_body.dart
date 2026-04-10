import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/models/client_model.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_client_card.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/cubit/customers_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/customers/presentation/widgets/show_and_update_client_location_dialog.dart';
import 'package:get/get.dart';

class CustomersTechnicianScreenBody extends StatefulWidget {
  const CustomersTechnicianScreenBody({super.key});

  @override
  State<CustomersTechnicianScreenBody> createState() =>
      _CustomersTechnicianScreenBodyState();
}

class _CustomersTechnicianScreenBodyState
    extends State<CustomersTechnicianScreenBody> {
  bool isFirstLoad = true;
  List<ClientModel> clients = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      buildWhen: (previous, current) {
        return current is! ClientLocationUpdating;
      },

      builder: (context, state) {
        if (state is CustomersLoading && isFirstLoad) {
          isFirstLoad = false;
          return const CustomLoadingIndicator();
        } else if (state is CustomersError) {
          return Center(child: Text(state.message));
        } else if (state is CustomersLoaded) {
          clients = state.clients;
          if (clients.isEmpty) {
            return const Center(child: EmptyDataWidget());
          }
        }
        return ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            final client = clients[index];
            return CustomClientCard(
              clientModel: client,
              actionText: AppStrings.editLocation.tr,
              onPressAction: () {
                showAndUpdateClientLocationDialog(
                  context,
                  client,
                  context.read<CustomersCubit>(),
                );
              },
            );
          },
        );
      },
    );
  }
}
