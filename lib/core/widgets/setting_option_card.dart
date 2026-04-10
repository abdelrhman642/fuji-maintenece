import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class SettingOptionCard extends StatelessWidget {
  const SettingOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.enabled,
    required this.onSwitchChanged,
    // this.onDelete,
    this.onEdit,
  });

  final String title;
  final String description;
  final bool enabled;
  final Function(bool) onSwitchChanged;
  // final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          spacing: 16,
          children: [
            ListTile(
              title: Text(
                '$title: $description',
                style: AppFont.font16W700Black,
              ),
              trailing: Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: enabled,
                  activeColor: AppColor.green,
                  thumbColor:
                      enabled
                          ? WidgetStateProperty.all(AppColor.white)
                          : WidgetStateProperty.all(AppColor.primary),
                  onChanged: (value) => onSwitchChanged(value),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onEdit,
                    child: Text(AppStrings.edit.tr),
                  ),
                ),
                // SizedBox(width: 16),
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: onDelete,
                //     child: Text(AppStrings.delete.tr),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
