import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            AppStrings.notes.tr,
            style: TextStyle(
              color: AppColor.primaryDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.grey1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppStrings.enterYourNotesHere.tr,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
