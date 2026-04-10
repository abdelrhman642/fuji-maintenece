import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/data/models/order_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/orders/presentation/manger/order/orders_cubit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final Data order;

  const OrderCard({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppStrings.client.tr} : ${order.client?.name ?? 'N/A'}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Divider(height: .5, color: AppColor.neutral.withOpacity(0.5)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.orderid.tr,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '#${order.id ?? 'N/A'}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await context.push(
                        Routes.orderDetailsScreen,
                        extra: order.id,
                      );
                      if (result == true) {
                        if (context.mounted) {
                          context.read<OrdersCubit>().fetchOrders();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      AppStrings.seeDetails.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<OrdersCubit>().exportReportAsPdf(
                        order.id ?? 0,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: AppColor.primary),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      AppStrings.exportAsPdf.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
