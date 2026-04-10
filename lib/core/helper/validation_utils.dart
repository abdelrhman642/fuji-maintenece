import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ValidationUtils {
  ValidationUtils._();

  /// Validates name field (required)
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null ||
        value.isEmpty ||
        password == null ||
        password.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  /// Validates email field (required)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(value.trim())) {
      return AppStrings.invalidEmail.tr;
    }
    return null;
  }

  /// Validates email field (optional but must be valid if provided)
  static String? validateOptionalEmail(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (!RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(value.trim())) {
        return AppStrings.invalidEmail.tr;
      }
    }
    return null;
  }

  /// Validates phone number field (required)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired.tr;
    }
    if (!RegExp(r'^[0-9+]+$').hasMatch(value.trim())) {
      return AppStrings.invalidPhoneNumber.tr;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  static String? validateFiveDigitCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the 5-digit code';
    }
    if (!RegExp(r'^[0-9]{5}$').hasMatch(value)) {
      return 'Code must be exactly 5 digits';
    }
    return null;
  }

  static String? validateAtMostFiveDigits(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid number';
    }
    if (value.length > 5) {
      return 'Number must be at most 5 digits';
    }
    return null;
  }
}
