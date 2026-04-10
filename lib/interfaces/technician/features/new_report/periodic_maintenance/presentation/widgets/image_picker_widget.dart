import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.imageFile,
    required this.onTap,
  });

  final File? imageFile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              imageFile == null
                  ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.addImage,
                          width: 72,
                          height: 72,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.pressToAddImage.tr,
                          style: TextStyle(
                            color: AppColor.black.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                  : SizedBox.expand(
                    child: Image.file(imageFile!, fit: BoxFit.cover),
                  ),
        ),
      ),
    );
  }
}
