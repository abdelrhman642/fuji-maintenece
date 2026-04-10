import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(AppStrings.confirmDelete.tr),
        content: Text(AppStrings.areYouSureToDelete.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(AppStrings.close.tr),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColor.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(AppStrings.delete.tr),
          ),
        ],
      );
    },
  );
}
