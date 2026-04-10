import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager.dart';
import 'package:fuji_maintenance_system/core/service/local_data_service/local_data_manager_key.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_text_field.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contracts/data/models/contract_model/contract_model.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/guest_mode/guest_mode.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/data/models/renew_contract_request.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/cubit/home_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/manager/renew%20contract%20cubit/renew_contract_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/pages/renewal_success_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

/// Renewal Screen - for renewing contracts
class RenewalScreen extends StatefulWidget {
  const RenewalScreen({super.key});

  @override
  State<RenewalScreen> createState() => _RenewalScreenState();
}

class _RenewalScreenState extends State<RenewalScreen> {
  int selectedContractId = -1;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 365));
  late final TextEditingController noteController;
  File? _transactionFile;

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
    // Check if guest mode is enabled
    final isGuestMode = GuestModeProvider.isGuestMode;

    if (isGuestMode) {
      // Show guest mode message
      return Scaffold(
        backgroundColor: AppColor.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 80, color: AppColor.grey2),
                SizedBox(height: 24),
                Text(
                  'ميزة التجديد غير متاحة في وضع الضيف',
                  style: AppFont.font20W700Black.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'للوصول لميزة تجديد العقود، يرجى تسجيل الدخول أولاً',
                  style: AppFont.font14W500Grey2.copyWith(
                    fontSize: 16,
                    color: AppColor.grey2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    GuestModeProvider.showLoginRequiredDialog(context);
                  },
                  icon: Icon(Icons.login),
                  label: Text('تسجيل الدخول'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => getIt<RenewContractCubit>(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const CustomLoadingIndicator();
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: AppColor.error),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(color: AppColor.error),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (state is HomeLoaded) {
              final contracts = state.contracts;

              // Filter only expired contracts (contracts that can be renewed)
              final expiredContracts =
                  contracts.where((contract) {
                    if (contract.endDate == null) return false;
                    // Check if contract end date is before today
                    return contract.endDate!.isBefore(DateTime.now());
                  }).toList();

              if (expiredContracts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 80,
                        color: AppColor.blackColor.withOpacity(0.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.noContractsAvailable.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColor.blackColor.withOpacity(0.4),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // رقم العقد
                    Text(
                      AppStrings.contractNumber.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value:
                          selectedContractId == -1 ? null : selectedContractId,
                      decoration: InputDecoration(
                        hintText: AppStrings.chooseContractNumber.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppColor.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      items:
                          expiredContracts
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
                    const SizedBox(height: 20),

                    // تاريخ بداية العقد
                    Text(
                      AppStrings.contractStartDate.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 365 * 5),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 5),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            startDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.grey3.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              startDate.toLocal().toString().split(' ')[0],
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.black,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: AppColor.primary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Price summary section
                    _PriceSummarySection(
                      basePrice: _getSelectedContractPrice(
                        expiredContracts,
                        selectedContractId,
                      ),
                      vatPercentage:
                          LocalDataManager.instance
                              .getInt(LocalDataManagerKey.vat)
                              .toDouble(),
                    ),
                    const SizedBox(height: 20),

                    // Payment methods
                    Text(
                      AppStrings.paymentMethods.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _BankTransferSection(
                      onFilePicked: (file) {
                        setState(() => _transactionFile = file);
                      },
                    ),
                    const SizedBox(height: 20),

                    // الملاحظات

                    // const SizedBox(height: 8),
                    CustomTextField(
                      controller: noteController,
                      labelText: AppStrings.notes.tr,
                      hintText: AppStrings.enterYourNotesHere.tr,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    BlocListener<RenewContractCubit, RenewContractState>(
                      listener: (context, state) {
                        if (state is RenewContractLoading) {
                          showLoadingDialog(context);
                        }
                        if (state is RenewContractSuccess) {
                          context.pop(); // Close loading dialog
                          // Reset form after navigate
                          setState(() {
                            selectedContractId = -1;
                            startDate = DateTime.now();
                            noteController.clear();
                            _transactionFile = null;
                          });
                          // Navigate to success screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RenewalSuccessScreen(),
                            ),
                          );
                        } else if (state is RenewContractError) {
                          context.pop(); // Close loading dialog
                          context.showError(state.message);
                        }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Check if guest mode is enabled
                            if (!GuestModeInterceptor.checkAndShowLoginDialog(
                              context,
                            )) {
                              return;
                            }

                            // Require transaction document before submit
                            if (_transactionFile == null) {
                              context.showWarning(
                                AppStrings.uploadTransactionDocument.tr,
                              );
                              return;
                            }

                            // Validate allowed file types before submit
                            final name = _transactionFile!.path.toLowerCase();
                            final ext =
                                name.split('.').isNotEmpty
                                    ? name.split('.').last
                                    : '';
                            const allowed = ['jpg', 'jpeg', 'png', 'webp'];
                            if (!allowed.contains(ext)) {
                              context.showWarning(
                                AppStrings.theFileTypeMustBeJpgJpegPngWebp.tr,
                              );
                              return;
                            }

                            log(selectedContractId.toString());
                            if (selectedContractId != -1) {
                              context.read<RenewContractCubit>().renewContract(
                                RenewContractRequest(
                                  contractId: selectedContractId,
                                  requestedRenewalStartDate:
                                      startDate.toIso8601String(),
                                  clientNote: noteController.text,
                                  transferImage: _transactionFile,
                                ),
                              );
                            } else {
                              context.showWarning(
                                AppStrings.chooseContractNumber.tr,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            foregroundColor: AppColor.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppStrings.submit.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

/// Helper to safely read selected contract price
double _getSelectedContractPrice(
  List<ContractModel> contracts,
  int selectedId,
) {
  if (selectedId == -1) return 0;
  try {
    final selected = contracts.firstWhere(
      (c) => (c.id == selectedId),
      orElse: () => ContractModel(),
    );
    if (selected.contractPrice == null) return 0;
    return double.tryParse(selected.contractPrice!) ?? 0;
  } catch (_) {}
  return 0;
}

/// Price summary widget (contract price, VAT, total)
class _PriceSummarySection extends StatelessWidget {
  final double basePrice;
  final double vatPercentage;

  const _PriceSummarySection({
    required this.basePrice,
    required this.vatPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final vatValue = basePrice * (vatPercentage / 100);
    final total = basePrice + vatValue;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.contractPrice.tr,
                style: AppFont.font20W700Black.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              _PriceRowValue(text: _formatCurrency(basePrice)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.taxValue.tr,
                style: AppFont.font14W500Grey2.copyWith(
                  fontSize: 16,
                  color: AppColor.blackColor.withOpacity(0.7),
                ),
                textAlign: TextAlign.right,
              ),
              _PriceRowValue(
                text: '%${vatPercentage.toStringAsFixed(0)}',
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.totalPrice.tr,
                style: AppFont.font20W700Black.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              _PriceRowValue(text: _formatCurrency(total)),
            ],
          ),
          const SizedBox(width: 12),

          // Labels column (right in RTL)
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    final v = value.toStringAsFixed(0);
    // Using SAR symbol-like mark as per design screenshot
    return '﷼ $v';
  }
}

class _PriceRowValue extends StatelessWidget {
  final String text;
  final Color? color;

  const _PriceRowValue({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppFont.font20W700Black.copyWith(
        fontSize: 16,
        color: color ?? AppColor.black,
      ),
    );
  }
}

/// Bank transfer section with static data and upload area
class _BankTransferSection extends StatefulWidget {
  final void Function(File file) onFilePicked;

  const _BankTransferSection({required this.onFilePicked});

  @override
  State<_BankTransferSection> createState() => _BankTransferSectionState();
}

class _BankTransferSectionState extends State<_BankTransferSection> {
  String? _uploadedFileName;

  static const List<String> _allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

  Future<void> _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    context.showError(AppStrings.copied.tr);
  }

  Future<void> _pickFile() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final name = pickedFile.name.toLowerCase();
      final ext = name.split('.').length > 1 ? name.split('.').last : '';
      if (!_allowedExtensions.contains(ext)) {
        context.showWarning(AppStrings.theFileTypeMustBeJpgJpegPngWebp.tr);
        return;
      }
      final file = File(pickedFile.path);
      widget.onFilePicked(file);
      setState(() {
        _uploadedFileName = pickedFile.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Static bank data as per design
    const bankName = 'Emirates NBD';
    const accountNumber = '1025872452902';
    const accountName = 'FUJI LINE LIFTS TRADING LLC';
    const iban = 'AE4302600001025872452902';
    const swift = 'EBILAEAD';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.bankTransferInformation.tr,
                style: AppFont.font20W700Black.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              _BankFieldRow(
                label: AppStrings.bankName.tr,
                value: bankName,
                onCopy: () => _copy(bankName),
              ),
              const SizedBox(height: 8),
              _BankFieldRow(
                label: AppStrings.accountNumber.tr,
                value: accountNumber,
                onCopy: () => _copy(accountNumber),
              ),
              const SizedBox(height: 8),
              _BankFieldRow(
                label: AppStrings.accountName.tr,
                value: accountName,
                onCopy: () => _copy(accountName),
              ),
              const SizedBox(height: 8),
              _BankFieldRow(
                label: AppStrings.iban.tr,
                value: iban,
                onCopy: () => _copy(iban),
              ),
              const SizedBox(height: 8),
              _BankFieldRow(
                label: AppStrings.swiftCode.tr,
                value: swift,
                onCopy: () => _copy(swift),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.transactionDocument.tr,
                style: AppFont.font20W700Black.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.grey3.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColor.grey2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _uploadedFileName == null
                              ? AppStrings.uploadTransactionDocument.tr
                              : 'Selected: ${_uploadedFileName!}',
                          style: AppFont.font14W500Grey2.copyWith(
                            fontSize: 14,
                            color: AppColor.grey2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.tapToSelectImage.tr,
                          style: AppFont.font14W500Grey2.copyWith(
                            fontSize: 12,
                            color: AppColor.grey2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BankFieldRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onCopy;

  const _BankFieldRow({
    required this.label,
    required this.value,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppFont.font14W500Grey2.copyWith(
              fontSize: 14,
              color: AppColor.blackColor.withOpacity(0.7),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: AppFont.font20W700Black.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onCopy,
                  icon: Icon(Icons.copy, color: AppColor.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
