import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

export 'app_color.dart';

abstract class AppFont {
  static var h2;

  static TextStyle get _style => GoogleFonts.cairo();

  static TextStyle get hintTextField => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.secondary,
  );

  static TextStyle get labelTextField => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.primary,
  );

  static TextStyle get buttonText =>
      _style.copyWith(fontSize: 20.sp, color: Colors.white);

  static TextStyle get font20W600Black => _style.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  static TextStyle get font20W700Black => _style.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );

  static TextStyle get font20W700White => _style.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.white,
  );

  static TextStyle get font20W600White => _style.copyWith(
    fontSize: 20.sp,
    color: AppColor.white,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get font20W700Primary => _style.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.primary,
  );

  static TextStyle get textFiled => _style.copyWith(
    fontSize: 14.sp,
    color: AppColor.secondary,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get font12Regular => _style.copyWith(fontSize: 12.sp);

  static TextStyle get font13W600Grey1 => _style.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.grey1,
  );

  static TextStyle get font13W600Grey2 => _style.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.grey2,
  );

  static TextStyle get font13W600Primary => _style.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.primary,
  );

  static TextStyle get font16W600Gray2 => _style.copyWith(
    fontSize: 16.sp,
    color: AppColor.grey2,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get font16W500Black => _style.copyWith(
    fontSize: 16.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get font12w500Grey2 => _style.copyWith(
    fontSize: 12.sp,
    color: AppColor.grey2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get font16W700Black => _style.copyWith(
    fontSize: 16.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get font16W700Primary => _style.copyWith(
    fontSize: 16.sp,
    color: AppColor.primary,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get font16W600Black => _style.copyWith(
    fontSize: 16.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get font14W600Primary => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.primary,
  );

  static TextStyle get font14W600Black => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  static TextStyle get font14W700Black => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );

  static TextStyle get font14W500Grey2 => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.grey2,
  );

  static TextStyle get font14W500Black => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
  );
  static TextStyle get font16W600White => _style.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
  );

  static TextStyle get font16W600Primary => _style.copyWith(
    fontSize: 16.sp,
    color: AppColor.primary,
    fontWeight: FontWeight.w600,
  );

  // Maintenance system specific styles
  static TextStyle get statusCompleted => _style.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.success,
  );

  static TextStyle get statusPending => _style.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.warning,
  );

  static TextStyle get statusOverdue => _style.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.error,
  );

  static TextStyle get priorityHigh => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.highPriority,
  );

  static TextStyle get priorityMedium => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.mediumPriority,
  );

  static TextStyle get priorityLow => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.lowPriority,
  );

  static TextStyle get roleAdmin => _style.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.adminColor,
  );

  static TextStyle get roleMaintenance => _style.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.maintenanceColor,
  );

  static TextStyle get roleUser => _style.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.userColor,
  );

  static TextStyle get cardTitle => _style.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );

  static TextStyle get cardSubtitle => _style.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.grey2,
  );

  static TextStyle get appBarTitle => _style.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColor.white,
  );
}
