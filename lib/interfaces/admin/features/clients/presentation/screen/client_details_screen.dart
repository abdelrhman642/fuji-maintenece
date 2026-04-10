import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/manager/client%20details%20cubit/client_details_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/clients/presentation/widgets/client_details_screen_body.dart';
import 'package:get/get_utils/get_utils.dart';

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({super.key, required this.clientId});
  final int clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.contracts.tr),
      body: BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
        builder: (context, state) {
          if (state is ClientDetailsLoading) {
            return const CustomLoadingIndicator();
          } else if (state is ClientDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is ClientDetailsLoaded) {
            final contracts = state.contracts;
            if (contracts.isEmpty) {
              return Center(child: EmptyDataWidget());
            }
            return ClientDetailsScreenBody(contracts: contracts);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
