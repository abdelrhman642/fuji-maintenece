import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoadingIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading home data...',
            style: TextStyle(color: AppColor.lightGrey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
