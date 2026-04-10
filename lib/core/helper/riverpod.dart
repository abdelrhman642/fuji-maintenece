import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final hasInternetProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((result) {
    return result != ConnectivityResult.none;
  });
});

final hasInternetProvider2 = FutureProvider<bool>((ref) async {
  final result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
});

final fuckInternetOk = Provider<bool>((ref) {
  final asyncValue = ref.watch(hasInternetProvider);
  return asyncValue.when(
    data: (data) => data,
    loading: () => true, // Assume connected while checking
    error: (_, __) => false,
  );
});

// Generic loading state provider
final loadingProvider = StateProvider<bool>((ref) => false);

// Generic error state provider
final errorProvider = StateProvider<String?>((ref) => null);

// Theme mode provider
final themeModeProvider = StateProvider<bool>(
  (ref) => false,
); // false = light, true = dark

// User role provider
final userRoleProvider = StateProvider<String?>((ref) => null);

// Current user provider
final currentUserProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

// Language provider
final languageProvider = StateProvider<String>((ref) => 'en');

// Notification count provider
final notificationCountProvider = StateProvider<int>((ref) => 0);

// Search query provider for work orders
final workOrderSearchProvider = StateProvider<String>((ref) => '');

// Filter providers for different screens
final workOrderFilterProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
);
final equipmentFilterProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
);

// Selected date range provider
final dateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

// Selected location provider
final selectedLocationProvider = StateProvider<Map<String, dynamic>?>(
  (ref) => null,
);

// Dashboard refresh provider
final dashboardRefreshProvider = StateProvider<int>((ref) => 0);

// Current page provider for bottom navigation
final currentPageProvider = StateProvider<int>((ref) => 0);

// Work order status filter
final workOrderStatusFilterProvider = StateProvider<String?>((ref) => null);

// Equipment status filter
final equipmentStatusFilterProvider = StateProvider<String?>((ref) => null);

// Priority filter
final priorityFilterProvider = StateProvider<String?>((ref) => null);
