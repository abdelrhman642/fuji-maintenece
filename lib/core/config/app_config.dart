import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../di/setup_services.dart';
import '../helper/constants.dart';
import '../service/app_logger.dart';

/// Application configuration and initialization
class AppConfig {
  AppConfig._();

  /// Riverpod container with optional logging
  static final ProviderContainer providerContainer = ProviderContainer(
    observers: [
      if (kDebugMode && Constants.loggerRiverPod) AppProviderObserver(),
    ],
  );

  /// Initialize the application
  static Future<void> initialize() async {
    // Setup dependency injection
    await setupLocator();

    // Configure GetX
    Get.testMode = false;
  }
}
