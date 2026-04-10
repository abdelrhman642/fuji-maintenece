import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData getLightTheme() {
  return ThemeData.light().copyWith(
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppColor.primaryDark,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    primaryColor: AppColor.primaryDark,
    scaffoldBackgroundColor: AppColor.backGround,
    highlightColor: Colors.transparent,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColor.primaryDark,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColor.primaryDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColor.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.grey2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.grey2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.error),
      ),
      filled: true,
      fillColor: AppColor.white,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColor.primaryDark,
      secondary: AppColor.secondary,
      surface: Colors.white,
      error: AppColor.error,
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData.dark().copyWith(
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: AppColor.primaryDark,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    primaryColor: AppColor.primaryDark,
    scaffoldBackgroundColor: AppColor.primaryDark,
    highlightColor: Colors.transparent,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColor.primaryDark,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColor.primaryDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColor.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primaryLighter),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primaryLighter),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.error),
      ),
      filled: true,
      fillColor: AppColor.primary,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColor.primaryDark,
      secondary: AppColor.secondary,
      surface: AppColor.primary,
      error: AppColor.error,
    ),
  );
}
