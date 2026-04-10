import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/technician_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technicians%20cubit/technicians_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/widgets/custom_expanded_buttom.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/widgets/show_edit_technician_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CustomTechniciansCard extends StatelessWidget {
  const CustomTechniciansCard({required super.key, required this.model});
  final TechnicianModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Avatar with Online Indicator
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.image ?? '',
                    width: 40,
                    height: 40,
                    errorWidget:
                        (context, url, error) => CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColor.gray_3,
                          child: Icon(Icons.person, color: AppColor.white),
                        ),
                  ),
                  if (model.status == 'active')
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColor.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),

              //Name and Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.status ?? 'inactive',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              //Edit Button
              IconButton(
                icon: Icon(Icons.edit, color: AppColor.primaryDark),
                onPressed: () {
                  showEditTechnicianBottomSheet(
                    context,
                    context.read<TechniciansCubit>(),
                    model,
                  );
                },
              ),

              //Menu Button
              PopupMenuButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: theme.iconTheme.color?.withOpacity(0.6),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'active',
                      child: Text(AppStrings.active.tr),
                      onTap: () {
                        if (model.status != 'active') {
                          context
                              .read<TechniciansCubit>()
                              .updateTechnicianStatus(model.id!, true);
                        }
                      },
                    ),
                    PopupMenuItem(
                      value: 'inactive',
                      child: Text(AppStrings.inactiveLabel.tr),
                      onTap: () {
                        if (model.status != 'inactive') {
                          context
                              .read<TechniciansCubit>()
                              .updateTechnicianStatus(model.id!, false);
                        }
                      },
                    ),
                  ];
                },
              ),
            ],
          ),

          // History Button
          Row(
            children: [
              CustomExpandedButtom(
                backgroundColor: AppColor.transparent,
                text: AppStrings.reports.tr,
                onPressed: () {
                  context.push(Routes.adminTechnicianReports, extra: model.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
