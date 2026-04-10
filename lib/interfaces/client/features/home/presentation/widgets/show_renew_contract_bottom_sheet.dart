import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/models/renew_contract_request.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/manager/renew%20contract%20cubit/renew_contract_cubit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

showRenewContractBottomSheet(
  BuildContext context,
  List<ContractModel> contracts,
) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => getIt<RenewContractCubit>(),
        child: RenewContractBottomSheetContent(contracts: contracts),
      );
    },
  );
}

class RenewContractBottomSheetContent extends StatefulWidget {
  final List<ContractModel> contracts;
  const RenewContractBottomSheetContent({super.key, required this.contracts});

  @override
  State<RenewContractBottomSheetContent> createState() =>
      _RenewContractBottomSheetContentState();
}

class _RenewContractBottomSheetContentState
    extends State<RenewContractBottomSheetContent> {
  int selectedContractId = -1;
  DateTime startDate = DateTime.now();
  late final TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.renewContract.tr,
            style: AppFont.font20W700Primary,
          ).paddingAll(16),
          SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: selectedContractId == -1 ? null : selectedContractId,
            decoration: InputDecoration(
              labelText: AppStrings.contractNumber.tr,
              border: OutlineInputBorder(),
            ),
            items:
                widget.contracts
                    .map(
                      (contract) => DropdownMenuItem<int>(
                        value: contract.id,
                        child: Text(contract.contractNumber ?? ''),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedContractId = value ?? -1;
              });
            },
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.calendar_today),
            title: Text(startDate.toLocal().toString().split(' ')[0]),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: startDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              );
              if (picked != null) {
                setState(() {
                  startDate = picked;
                });
              }
            },
          ),
          SizedBox(height: 16),
          CustomTextField(
            controller: noteController,
            labelText: AppStrings.notes.tr,
            hintText: AppStrings.notes.tr,
            maxLines: 3,
          ),
          SizedBox(height: 16),
          BlocListener<RenewContractCubit, RenewContractState>(
            listener: (context, state) {
              if (state is RenewContractLoading) {
                showLoadingDialog(context);
              }
              if (state is RenewContractSuccess) {
                context.pop(); // Close loading dialog
                context.pop();
              } else if (state is RenewContractError) {
                context.pop(); // Close loading dialog
                context.showError(state.message);
                context.pop();
              }
            },
            child: ElevatedButton(
              onPressed: () {
                log(selectedContractId.toString());
                if (selectedContractId != -1) {
                  context.read<RenewContractCubit>().renewContract(
                    RenewContractRequest(
                      contractId: selectedContractId,
                      requestedRenewalStartDate: startDate.toIso8601String(),
                      clientNote: noteController.text,
                    ),
                  );
                }
              },
              child: Text(AppStrings.submit.tr),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
