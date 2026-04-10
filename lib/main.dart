import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/observers/simple_bloc_observer.dart';
import 'core/config/app_config.dart';
import 'fuji_maintenance_app.dart';

/// Application entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables (if .env file exists)
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // .env file might not exist or might not be accessible on web
    // Continue without it - environment variables might be set via other means
    debugPrint('Warning: Could not load .env file: $e');
  }
  // Initialize all app dependencies and services
  await AppConfig.initialize();
  Bloc.observer = SimpleBlocObserver();
  // Run the application
  runApp(
    UncontrolledProviderScope(
      container: AppConfig.providerContainer,
      child: const FujiMaintenanceApp(),
    ),
  );
}
