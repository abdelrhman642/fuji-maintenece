import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

Future<dynamic> showAddedClientSuccessfullyDialog(
  BuildContext context,
  void Function()? onPressedAddNew,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 64),
              SizedBox(height: 12),
              Text(
                AppStrings.clientAddedSuccessfully.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onPressedAddNew?.call();
              },
              child: Text(AppStrings.addNew.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(AppStrings.goToHome.tr),
            ),
          ],
        ),
  );
}
