import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/manager/contracts%20cubit/admin_contracts_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/presentation/widgets/contract_card.dart';

class ContractValidityScreenBody extends StatelessWidget {
  const ContractValidityScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminContractsCubit, ContractsState>(
      builder: (context, state) {
        if (state is ContractsLoading) {
          return const CustomLoadingIndicator();
        } else if (state is ContractsError) {
          return Center(child: Text(state.message));
        } else if (state is ContractsLoaded) {
          if (state.contracts.isEmpty) {
            return Center(child: EmptyDataWidget());
          }
          return ListView.builder(
            itemCount: state.contracts.length,
            itemBuilder: (context, index) {
              return ContractCard(contractModel: state.contracts[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
