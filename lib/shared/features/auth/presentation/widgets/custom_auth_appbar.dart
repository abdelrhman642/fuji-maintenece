import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/simple_language_switcher.dart';
import 'package:get/get.dart';

class CustomAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAuthAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310.h,
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(95.r),
          bottomRight: Radius.circular(95.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.r),
                  bottomRight: Radius.circular(100.r),
                ),
              ),
            ),
          ),
          // Back button
          if (showBackButton)
            Positioned(
              top: 40.h,
              left:
                  Directionality.of(context) == TextDirection.ltr ? 16.w : null,
              right:
                  Directionality.of(context) == TextDirection.rtl ? 16.w : null,
              child: IconButton(
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.arrow_back
                      : Icons.arrow_back,
                  color: Colors.white,
                  size: 24.sp,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          // Logo and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(height: 238.h, width: 238.w, AppAssets.logoWhite),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.english.tr, style: AppFont.font16W600White),
                    const LanguageSwitcher(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(310);
}
