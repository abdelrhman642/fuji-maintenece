import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/config/api_path.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/contract%20renew%20requests/presentation/widgets/contract_renewal_card.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/see_details_order/see_details_order_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/see_details_order/see_details_order_state.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/widget/key_value.dart';
import 'package:fuji_maintenance_system/interfaces/technician/features/new_report/views/widgets/custom_bottom.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:open_filex/open_filex.dart';

class SeeDetailsOrders extends StatefulWidget {
  final int orderId;
  const SeeDetailsOrders({super.key, required this.orderId});

  @override
  State<SeeDetailsOrders> createState() => _SeeDetailsOrdersState();
}

class _SeeDetailsOrdersState extends State<SeeDetailsOrders> {
  @override
  void initState() {
    super.initState();
    context.read<SeeDetailsOrderCubit>().fetchOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.orders.tr),
      body: BlocConsumer<SeeDetailsOrderCubit, SeeDetailsOrderState>(
        listener: (context, state) {
          if (state is SeeDetailsOrderApproveInProgress ||
              state is SeeDetailsOrderRejectInProgress) {}
          if (state is SeeDetailsOrderApproveSuccess) {
            Future.delayed(const Duration(seconds: 5), () {
              if (context.mounted) Navigator.of(context).pop(true);
            });
          }
          if (state is SeeDetailsOrderApproveFailure) {
            context.showError(state.error);
          }
          if (state is SeeDetailsOrderRejectSuccess) {
            Future.delayed(const Duration(seconds: 5), () {
              if (context.mounted) Navigator.of(context).pop(true);
            });
          }
          if (state is SeeDetailsOrderRejectFailure) {
            context.showError(state.error);
          }
          if (state is ReportPdfError) {
            context.showError(state.message);
          }
          if (state is ReportPdfLoaded) {
            OpenFilex.open(state.filePath);
          }
          if (state is ReportPdfLoading) {}
        },
        buildWhen:
            (previous, current) =>
                current is SeeDetailsOrderLoaded ||
                current is SeeDetailsOrderError ||
                current is SeeDetailsOrderLoading,
        builder: (context, state) {
          if (state is SeeDetailsOrderLoading) {
            return const CustomLoadingIndicator();
          }

          if (state is SeeDetailsOrderError) {
            return Center(
              child: Text(
                state.message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor.black,
                ),
              ),
            );
          }

          if (state is SeeDetailsOrderLoaded) {
            final orderData = state.orderDetails.data;

            if (orderData == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No data available', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    Text(
                      'Success: ${state.orderDetails.success}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      'Message: ${state.orderDetails.message}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              // Card content
                              Container(
                                margin: EdgeInsets.only(
                                  top: 75,
                                  left: 16,
                                  right: 16,
                                  bottom: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.blackColor.withOpacity(
                                        0.5,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Header with avatar and info
                                      SizedBox(height: 80),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundColor:
                                                AppColor.backroyndIcon,
                                            child: Icon(
                                              Icons.person,
                                              color: AppColor.grey2,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  orderData.client?.name ??
                                                      'N/A',
                                                  style: theme
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColor.black,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  orderData.client?.location ??
                                                      'N/A',
                                                  style: theme
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: AppColor.black
                                                            .withOpacity(0.6),
                                                      ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  orderData.client?.phone ??
                                                      'N/A',
                                                  style: theme
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: AppColor.black
                                                            .withOpacity(0.8),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Section title
                                      Text(
                                        orderData
                                                .contract
                                                ?.contractSection
                                                ?.name ??
                                            AppStrings.regularMaintenance.tr,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              color: AppColor.primary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Contract details
                                      KeyValueRow(
                                        label: AppStrings.contract.tr,
                                        value:
                                            orderData
                                                .contract
                                                ?.contractNumber ??
                                            'N/A',
                                        labelStyle: theme.textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 8),
                                      KeyValueRow(
                                        label: AppStrings.contractStartDate.tr,
                                        value: formatDate(
                                          orderData.contract?.startDate ??
                                              'N/A',
                                        ),
                                        labelStyle: theme.textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 8),
                                      KeyValueRow(
                                        label: AppStrings.contractEndDate.tr,
                                        value: formatDate(
                                          orderData.contract?.endDate ?? 'N/A',
                                        ),
                                        labelStyle: theme.textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 20),
                                      // Image - Transfer Image
                                      if (orderData.transferImage != null &&
                                          orderData.transferImage!.isNotEmpty)
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppColor.backroyndIcon,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color: AppColor.grey_3,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            child: Image.network(
                                              orderData.transferImage!
                                                      .startsWith('http')
                                                  ? orderData.transferImage!
                                                  : '${ApiPath.baseurl}${orderData.transferImage!}',
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                // Debug: print the image URL
                                                final fullUrl =
                                                    orderData.transferImage!
                                                            .startsWith('http')
                                                        ? orderData
                                                            .transferImage!
                                                        : '${ApiPath.baseurl}${orderData.transferImage!}';

                                                return Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.broken_image,
                                                        size: 36,
                                                        color: AppColor.grey2,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        'Failed to load image',
                                                        style: theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                              color: AppColor
                                                                  .black
                                                                  .withOpacity(
                                                                    0.7,
                                                                  ),
                                                            ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 16.0,
                                                            ),
                                                        child: Text(
                                                          'URL: $fullUrl',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: theme
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                color: AppColor
                                                                    .black
                                                                    .withOpacity(
                                                                      0.5,
                                                                    ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              loadingBuilder: (
                                                context,
                                                child,
                                                progress,
                                              ) {
                                                if (progress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CustomLoadingIndicator(),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      else
                                        Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: AppColor.backroyndIcon,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color: AppColor.grey_3,
                                            ),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.image_outlined,
                                                  size: 36,
                                                  color: AppColor.grey2,
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'No image available',
                                                  style: theme
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: AppColor.black
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      const SizedBox(height: 50),
                                      // Export as PDF button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<SeeDetailsOrderCubit>()
                                                .exportReportAsPdf(
                                                  orderData.id ?? 0,
                                                );
                                          },
                                          icon: const Icon(
                                            Icons.picture_as_pdf,
                                          ),
                                          label: Text(
                                            AppStrings.exportAsPdf.tr,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Accept and Reject buttons side by side
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomBottom(
                                              title: AppStrings.accept.tr,
                                              backgroundColor:
                                                  AppColor.primaryDark,
                                              onPressed: () async {
                                                final note =
                                                    await showTextInputDialog(
                                                      context,
                                                      title:
                                                          AppStrings
                                                              .approveContractRenewalNote
                                                              .tr,
                                                      hint:
                                                          AppStrings
                                                              .enterNote
                                                              .tr,
                                                    );
                                                if (context.mounted &&
                                                    note != null) {
                                                  context
                                                      .read<
                                                        SeeDetailsOrderCubit
                                                      >()
                                                      .approveOrder(
                                                        orderData.id!,
                                                        note,
                                                      );
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: CustomBottom(
                                              title: AppStrings.reject.tr,
                                              backgroundColor: AppColor.black,
                                              onPressed: () async {
                                                final reason =
                                                    await showTextInputDialog(
                                                      context,
                                                      title:
                                                          AppStrings
                                                              .rejectContractRenewalReason
                                                              .tr,
                                                      hint:
                                                          AppStrings
                                                              .enterReason
                                                              .tr,
                                                    );
                                                if (context.mounted &&
                                                    reason != null) {
                                                  context
                                                      .read<
                                                        SeeDetailsOrderCubit
                                                      >()
                                                      .rejectOrder(
                                                        orderData.id!,
                                                        reason,
                                                      );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                              ),
                              // Circular logo overlapping card
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColor.primary,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.blackColor.withOpacity(
                                        0.54,
                                      ),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(AppAssets.splashLogo),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
}
