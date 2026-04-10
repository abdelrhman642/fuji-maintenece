import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/contract_details_cubit/contract_details_cubit.dart';
import 'package:get/get.dart';

class ContractDetailsDialog extends StatelessWidget {
  const ContractDetailsDialog({super.key, required this.contract});
  final ContractModel contract;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<ContractDetailsCubit>()..fetchContractDetails(contract.id!),
      child: BlocBuilder<ContractDetailsCubit, ContractDetailsState>(
        builder: (context, state) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.description, size: 48, color: AppColor.primary),
                  SizedBox(height: 12),
                  Text(
                    contract.contractNumber ??
                        '${AppStrings.contract.tr}${contract.id}',
                    style: AppFont.font16W700Black,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${AppStrings.contractNumber.tr} ${contract.id}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppStrings.close.tr),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
