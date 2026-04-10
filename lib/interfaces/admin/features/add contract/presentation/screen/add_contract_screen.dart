import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/data/models/add_contract_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/cubit/add_contract_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/widgets/contract_details_section.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/widgets/elevator_details_section.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/widgets/location_details_section.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20contract/presentation/widgets/show_add_contract_successfully_dialog.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AddContractScreen extends StatefulWidget {
  const AddContractScreen({super.key});
  @override
  State<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState extends State<AddContractScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController contractNumberController =
      TextEditingController();
  final TextEditingController contractSectionController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController contractPeriodController =
      TextEditingController();
  final TextEditingController contractPriceController = TextEditingController();
  final TextEditingController elevatorTypeController = TextEditingController();
  final TextEditingController elevatorBrandController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    contractNumberController.dispose();
    contractSectionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    contractPeriodController.dispose();
    contractPriceController.dispose();
    elevatorTypeController.dispose();
    elevatorBrandController.dispose();
    addressController.dispose();
    locationController.dispose();
    latController.dispose();
    lngController.dispose();
  }

  void _clearControllers() {
    formKey.currentState?.reset();
    clientIdController.clear();
    contractNumberController.clear();
    contractSectionController.clear();
    startDateController.clear();
    endDateController.clear();
    contractPeriodController.clear();
    contractPriceController.clear();
    elevatorTypeController.clear();
    elevatorBrandController.clear();
    addressController.clear();
    locationController.clear();
    latController.clear();
    lngController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: CustomAppBarWidget(title: AppStrings.addContract.tr),
        body: BlocListener<AddContractCubit, AddContractState>(
          listener: (context, state) {
            if (state is AddContractLoading) {
              showLoadingDialog(context);
            }
            if (state is AddContractSuccess) {
              Navigator.of(context).pop(); // Close the loading dialog
              showContractAddedSuccessfullyDialog(context, () {
                _clearControllers();
              });
            } else if (state is AddContractError) {
              Navigator.of(context).pop(); // Close the loading dialog
              context.showError(state.message);
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      LocationDetailsSection(
                        addressController: addressController,
                        locationController: locationController,
                        latController: latController,
                        lngController: lngController,
                      ),
                      ContractDetailsSection(
                        clientIdController: clientIdController,
                        contractNumberController: contractNumberController,
                        contractSectionController: contractSectionController,
                        startDateController: startDateController,
                        endDateController: endDateController,
                        contractPeriodController: contractPeriodController,
                        contractPriceController: contractPriceController,
                        maintenanceContractSections:
                            context
                                .watch<AddContractCubit>()
                                .maintenanceContractSections,
                        maintenanceContractPeriodicity:
                            context
                                .watch<AddContractCubit>()
                                .maintenanceContractPeriodicity,
                        clients: context.watch<AddContractCubit>().clients,
                      ),

                      ElevatorDetailsSection(
                        elevatorTypeController: elevatorTypeController,
                        elevatorBrandController: elevatorBrandController,
                        elevatorTypes:
                            context.watch<AddContractCubit>().elevatorTypes,
                        elevatorBrands:
                            context.watch<AddContractCubit>().elevatorBrands,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 32,
                right: 32,
                bottom: 24,
                child: _buildAddContractButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildAddContractButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context.read<AddContractCubit>().addContract(
              AddContractRequestModel(
                clientId: int.tryParse(clientIdController.text),
                contractNumber: contractNumberController.text,
                contractSectionId: int.tryParse(contractSectionController.text),
                startDate: startDateController.text,
                endDate: endDateController.text,
                contractDurationId: int.tryParse(contractPeriodController.text),
                contractPrice: int.tryParse(contractPriceController.text),
                elevatorTypeId: int.tryParse(elevatorTypeController.text),
                elevatorModelId: int.tryParse(elevatorBrandController.text),
                location: addressController.text,
                latitude: double.tryParse(latController.text),
                longitude: double.tryParse(lngController.text),
              ),
            );
          }
        },
        child: Text(AppStrings.addContract.tr),
      ),
    );
  }
}
