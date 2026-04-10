import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/order_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/order/orders_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/order/orders_state.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/widget/order_card.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class OrdersAdminScreen extends StatefulWidget {
  const OrdersAdminScreen({super.key});

  @override
  State<OrdersAdminScreen> createState() => _OrdersAdminScreenState();
}

class _OrdersAdminScreenState extends State<OrdersAdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Data> _allOrders = [];

  List<Data> get _filteredOrders {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _allOrders;
    return _allOrders.where((o) {
      final clientName = o.client?.name?.toLowerCase() ?? '';
      final orderId = o.id?.toString() ?? '';
      return clientName.contains(q) || orderId.contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.orders.tr),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersError) {
            context.showError(state.message);
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
                current is OrdersError ||
                current is OrdersLoaded ||
                current is OrdersLoading,
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const CustomLoadingIndicator();
          }

          if (state is OrdersLoaded) {
            _allOrders = state.orders.data ?? [];
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // Search field
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: AppStrings.search.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // List of orders
                Expanded(
                  child:
                      _filteredOrders.isEmpty
                          ? EmptyDataWidget()
                          : ListView.separated(
                            itemCount: _filteredOrders.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final order = _filteredOrders[index];
                              return OrderCard(order: order);
                            },
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
