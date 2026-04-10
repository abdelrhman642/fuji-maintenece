import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

extension ContextNotificationExtension on BuildContext {
  void _show({
    required String message,
    required Color color,
    required IconData icon,
  }) {
    ElegantNotification(
      description: Text(message, textAlign: TextAlign.start),
      icon: Icon(icon, color: color),
      progressIndicatorColor: color,
      background: Colors.white,
      position: Alignment.topCenter,
      animation: AnimationType.fromTop,
      toastDuration: const Duration(seconds: 5),
    ).show(this);
  }

  void showSuccess(String message) {
    _show(
      message: message,
      color: Colors.green,
      icon: Icons.check_circle_outline,
    );
  }

  void showError(String message) {
    _show(message: message, color: Colors.red, icon: Icons.error_outline);
  }

  void showInfo(String message) {
    _show(message: message, color: Colors.blue, icon: Icons.info_outline);
  }

  void showWarning(String message) {
    _show(
      message: message,
      color: Colors.orange,
      icon: Icons.warning_amber_rounded,
    );
  }
}
