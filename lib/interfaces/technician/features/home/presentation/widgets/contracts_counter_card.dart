import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get.dart';

class ContractsCounterCard extends StatelessWidget {
  const ContractsCounterCard({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.assignment, color: AppColor.primary, size: 24),
          SizedBox(width: 8),
          Text(
            '${AppStrings.numberOfContracts.tr} $count',
            style: AppFont.font16W700Black,
          ),
        ],
      ),
    );
  }
}
