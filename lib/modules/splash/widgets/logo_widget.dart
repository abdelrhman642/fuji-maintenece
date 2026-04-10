import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fuji_maintenance_system/core/config/app_assets.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({this.colorText, this.colorImage, super.key});

  final Color? colorText;
  final Color? colorImage;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return SvgPicture.asset(
      AppAssets.logosplashsvg,
      color: AppColor.primary,
      width: 250.w,
      height: 250.h,
    );
  }
}
