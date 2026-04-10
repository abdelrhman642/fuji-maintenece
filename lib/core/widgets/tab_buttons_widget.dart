import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class TabButtonsWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<String> tabNames;

  const TabButtonsWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.tabNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabNames.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: buildTabButton(tabNames[index], index),
            );
          }),
        ),
      ),
    );
  }

  Widget buildTabButton(String label, int index) {
    return TextButton(
      onPressed: () => onTabSelected(index),
      style: TextButton.styleFrom(
        backgroundColor:
            selectedIndex == index ? AppColor.primaryDark : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColor.primaryDark),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedIndex == index ? AppColor.white : AppColor.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
