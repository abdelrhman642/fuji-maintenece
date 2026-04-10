import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:fuji_maintenance_system/core/helper/responsive.dart';
export 'package:fuji_maintenance_system/core/helper/riverpod.dart';

abstract class AppColor {
  static Color get white => Get.isDarkMode ? Colors.black : Colors.white;

  static Color get nearlyWhite =>
      Get.isDarkMode ? const Color(0xFF021024) : const Color(0xFFC1E8FF);

  static Color get grey3 =>
      Get.isDarkMode ? const Color(0xFF5483B3) : Colors.white;

  static Color get grey_3 =>
      Get.isDarkMode ? const Color(0xFF7DA0CA) : const Color(0xFFC1E8FF);

  static Color get gray_3 =>
      Get.isDarkMode ? const Color(0xFF5483B3) : const Color(0xFFC1E8FF);

  static Color get whiteOrGrey =>
      Get.isDarkMode ? const Color(0xFF7DA0CA) : Colors.white;

  static Color get black => Get.isDarkMode ? Colors.white : Colors.black;

  /// Primary color for maintenance system - professional blue
  /// New color scheme: #052659 (dark blue)
  static const Color primary = Color(0xFF052659);

  /// Secondary color - medium blue
  static const Color secondary = Color(0xFF5483B3);

  /// Additional colors that match the new design
  /// Darkest blue: #021024
  static const Color primaryDark = Color(0xFF021024);

  /// Medium blue: #5483B3
  static const Color primaryLight = Color(0xFF5483B3);

  /// Light blue: #7DA0CA
  static const Color primaryLighter = Color(0xFF7DA0CA);

  /// Lightest blue: #C1E8FF
  static const Color primaryLightest = Color(0xFFC1E8FF);
  static Color get backGround =>
      Get.isDarkMode ? const Color(0xFF021024) : const Color(0xFFE6F1FF);
  static Color get disabled =>
      Get.isDarkMode ? const Color(0xff9EACAD) : const Color(0xffC0CDCE);

  static Color get grey2 =>
      Get.isDarkMode ? const Color(0xFF7DA0CA) : const Color(0xFF5483B3);

  static Color get grey1 =>
      Get.isDarkMode ? const Color(0xFF052659) : const Color(0xFFC1E8FF);

  static const unselectedNavBar = Color(0xFF7DA0CA);

  // Status colors for maintenance system
  static const Color success = Color(0xff4CAF50); // Green for completed
  static const Color warning = Color(0xffFF9800); // Orange for pending
  static const Color error = Color(0xffF44336); // Red for issues
  static const Color info = Color(0xFF5483B3); // Blue for information

  // Priority colors
  static const Color highPriority = Color(0xffD32F2F); // Red
  static const Color mediumPriority = Color(0xffFF9800); // Orange
  static const Color lowPriority = Color(0xff4CAF50); // Green

  // User role colors
  static const Color adminColor = Color(0xff9C27B0); // Purple for admin

  static const Color maintenanceColor = Color(
    0xFF5483B3,
  ); // Blue for maintenance

  static const Color userColor = Color(0xff4CAF50); // Green for regular user

  // Additional professional colors
  static const Color darkBlue = Color(0xFF021024);
  static const Color lightBlue = Color(0xFFC1E8FF);
  static const Color accent = Color(0xffFFC107); // Yellow accent
  static const Color neutral = Color(0xff9E9E9E);

  /// App background (extra light, slightly blue-tinted)
  static const Color background = Color(0xFFE6F1FF);
  static const Color blackColor = Color(0xFF021024);
  static const Color lightGrey = Color(0xFF7DA0CA);
  static const Color blue = Color(0xFF052659);
  static const Color green = Color(0xFF2EAC62);
  static const Color backroyndIcon = Color(0xFFC1E8FF);
  static const Color transparent = Colors.transparent;
}

/// Backwards/forwards compatible alias.
///
/// Use `AppColors` as the preferred naming across the app.
typedef AppColors = AppColor;
