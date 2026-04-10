import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/cubit/contract_renew_requests_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/widgets/contract_renewal_card.dart';

class ContractRenewalRequestsScreenBody extends StatefulWidget {
  const ContractRenewalRequestsScreenBody({super.key});

  @override
  State<ContractRenewalRequestsScreenBody> createState() =>
      _ContractRenewalRequestsScreenBodyState();
}

class _ContractRenewalRequestsScreenBodyState
    extends State<ContractRenewalRequestsScreenBody> {
  bool isLoadingFirst = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContractRenewRequestsCubit, ContractRenewRequestsState>(
      listener: (context, state) {
        if (state is ContractRenewRequestActionSuccess) {
          context
              .read<ContractRenewRequestsCubit>()
              .fetchContractRenewRequests();
        }
        if (state is ContractRenewRequestActionError) {
          context.showError(state.message);
        }
        if (state is ContractRenewRequestActionLoading) {}
      },
      buildWhen: (previous, current) {
        if (current is! ContractRenewRequestActionSuccess &&
            current is! ContractRenewRequestActionError &&
            current is! ContractRenewRequestActionLoading) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is ContractRenewRequestsLoading && isLoadingFirst) {
          isLoadingFirst = false;
          return const CustomLoadingIndicator();
        } else if (state is ContractRenewRequestsLoaded) {
          final requests = state.requests;
          if (requests.isEmpty) {
            return const Center(child: EmptyDataWidget());
          }
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return ContractRenewalCard(model: request);
            },
          );
        } else if (state is ContractRenewRequestsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
