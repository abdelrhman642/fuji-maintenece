import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/cubit/location_update_requests_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/location%20update%20requests/presentation/widgets/location_update_card.dart';

class LocationUpdateRequestsScreenBody extends StatefulWidget {
  const LocationUpdateRequestsScreenBody({super.key});

  @override
  State<LocationUpdateRequestsScreenBody> createState() =>
      _LocationUpdateRequestsScreenBodyState();
}

class _LocationUpdateRequestsScreenBodyState
    extends State<LocationUpdateRequestsScreenBody> {
  bool isLoadingFirst = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      LocationUpdateRequestsCubit,
      LocationUpdateRequestsState
    >(
      listener: (context, state) {
        if (state is LocationUpdateRequestActionSuccess) {
          context.read<LocationUpdateRequestsCubit>().loadRequests();
        } else if (state is LocationUpdateRequestActionError) {
          context.showError(state.message);
        } else if (state is LocationUpdateRequestActionLoading) {}
      },
      buildWhen: (previous, current) {
        if (current is! LocationUpdateRequestActionSuccess &&
            current is! LocationUpdateRequestActionError &&
            current is! LocationUpdateRequestActionLoading) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is LocationUpdateRequestsLoading && isLoadingFirst) {
          isLoadingFirst = false;
          return CustomLoadingIndicator();
        } else if (state is LocationUpdateRequestsError) {
          return Center(child: Text(state.message));
        } else if (state is LocationUpdateRequestsLoaded) {
          final requests = state.requests;
          if (requests.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              return LocationUpdateCard(model: requests[index]);
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
