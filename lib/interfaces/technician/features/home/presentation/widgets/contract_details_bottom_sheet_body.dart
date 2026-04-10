import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/data/models/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/manager/contract_details_cubit/contract_details_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/home/presentation/widgets/contract_details_sheet.dart';

class ContractDetailsBottomSheetBody extends StatelessWidget {
  const ContractDetailsBottomSheetBody({super.key, required this.contract});
  final ContractModel contract;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<ContractDetailsCubit>()..fetchContractDetails(contract.id!),
      child: BlocBuilder<ContractDetailsCubit, ContractDetailsState>(
        builder: (context, state) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child:
                      state is ContractDetailsLoaded
                          ? ContractDetailsSheet(
                            contractDetailsModel: state.contractDetails,
                          )
                          : state is ContractDetailsLoading
                          ? const CustomLoadingIndicator()
                          : state is ContractDetailsError
                          ? Center(child: Text(state.message))
                          : SizedBox.shrink(),
                ),
              ),
              Positioned(
                top: -30,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: _buildPersonContainer(),
              ),
            ],
          );
        },
      ),
    );
  }

  Container _buildPersonContainer() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: AppColor.primaryDark,
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.background, width: 3),
      ),
      child: Icon(Icons.person, color: AppColor.background, size: 40),
    );
  }
}
