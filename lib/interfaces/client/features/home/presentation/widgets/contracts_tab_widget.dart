import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/widgets/contract_card.dart';

class ContractsTab extends StatelessWidget {
  const ContractsTab({super.key, required this.contracts});
  final List<ContractModel> contracts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];
              return ContractCard(contractModel: contract);
            },
          ),
        ),
        // CustomBottom(
        //   title: AppStrings.renewContract.tr,
        //   backgroundColor: AppColor.black,
        //   onPressed: () {
        //     showRenewContractBottomSheet(context, contracts);
        //   },
        // ),
        SizedBox(height: 20),
      ],
    );
  }
}
