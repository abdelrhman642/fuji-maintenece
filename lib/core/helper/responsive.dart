import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void responsiveInit(BuildContext context) {
  ScreenUtil.init(context, designSize: const Size(375, 812));
}

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double getResponsiveWidth(
    BuildContext context,
    double mobileWidth, [
    double? tabletWidth,
    double? desktopWidth,
  ]) {
    if (isDesktop(context)) {
      return desktopWidth ?? tabletWidth ?? mobileWidth;
    } else if (isTablet(context)) {
      return tabletWidth ?? mobileWidth;
    } else {
      return mobileWidth;
    }
  }

  static double getResponsiveHeight(
    BuildContext context,
    double mobileHeight, [
    double? tabletHeight,
    double? desktopHeight,
  ]) {
    if (isDesktop(context)) {
      return desktopHeight ?? tabletHeight ?? mobileHeight;
    } else if (isTablet(context)) {
      return tabletHeight ?? mobileHeight;
    } else {
      return mobileHeight;
    }
  }
}
