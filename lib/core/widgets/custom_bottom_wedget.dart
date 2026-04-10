import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';

class CustomBottomWedget extends StatelessWidget {
  final VoidCallback? onAddCustomerTap;
  final VoidCallback? onExportTap;
  final Icon? addCustomerIcon;
  final Widget? exportIcon;
  final String title;
  final String subtitle;

  const CustomBottomWedget({
    super.key,
    this.onAddCustomerTap,
    this.onExportTap,
    this.addCustomerIcon,
    this.exportIcon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColor.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: onAddCustomerTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addCustomerIcon ?? const SizedBox.shrink(),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onExportTap ?? () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColor.primaryDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    exportIcon ?? const SizedBox.shrink(),
                    const SizedBox(width: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
