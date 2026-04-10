import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    required this.onTap,
    this.iconPath,
    this.textColor,
    this.iconColor,
    this.iconData,
  });

  final String title;
  final VoidCallback onTap;
  final String? iconPath;
  final Color? textColor;
  final Color? iconColor;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: Row(
          children: [
            if (iconPath != null)
              SvgPicture.asset(
                iconPath!,
                width: 26,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  iconColor ?? AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
            if (iconData != null)
              Icon(iconData, size: 26, color: iconColor ?? AppColor.primary),
            SizedBox(width: 8),
            Text(
              title,
              style: AppFont.font16W700Black.copyWith(
                color: textColor ?? AppColor.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
