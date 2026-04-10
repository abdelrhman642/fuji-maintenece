import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/data/models/cities_response_model/city_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/cities_and_neighborhoods/presentation/widgets/status_chip.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CityTile extends StatelessWidget {
  const CityTile({
    super.key,
    required this.city,
    required this.isActive,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  final CityModel city;
  final bool isActive;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.primary.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.location_city, color: AppColor.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.nameAr ?? city.nameEn ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  city.nameEn ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusChip(isActive: isActive),
          const SizedBox(width: 6),
          PopupMenuButton<_CityAction>(
            icon: Icon(Icons.more_vert, color: AppColor.primaryDark),
            onSelected: (action) {
              switch (action) {
                case _CityAction.edit:
                  onEdit();
                  break;
                case _CityAction.toggle:
                  onToggle();
                  break;
                case _CityAction.delete:
                  onDelete();
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _CityAction.edit,
                  child: Text(AppStrings.edit.tr),
                ),
                PopupMenuItem(
                  value: _CityAction.toggle,
                  child: Text(
                    isActive
                        ? AppStrings.inactiveLabel.tr
                        : AppStrings.activeLabel.tr,
                  ),
                ),
                PopupMenuItem(
                  value: _CityAction.delete,
                  child: Text(
                    AppStrings.delete.tr,
                    style: TextStyle(
                      color: AppColor.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

enum _CityAction { edit, toggle, delete }
