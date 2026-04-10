import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class ExportButton extends StatelessWidget {
  const ExportButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed?.call();
        },
        icon: const Icon(Icons.file_download),
        label: Text(AppStrings.export.tr),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          backgroundColor: AppColor.primaryDark,
          foregroundColor: Colors.white,
          // textStyle: AppFont.bodyLarge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
