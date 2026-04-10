import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/service/config_service/config_service.dart';

import '../../../core/service/local_data_service/local_data_manager.dart';
import '../../../core/service/local_data_service/local_data_manager_key.dart';
import '../../../shared/features/auth/presentation/controllers/auth_service.dart';

enum SplashNavigate { home, accountTypeSelection, login }

final dataManager = LocalDataManager.instance;

final splashNavigateProvider = FutureProvider.autoDispose<SplashNavigate>((
  ref,
) async {
  final token = await dataManager.readString(LocalDataManagerKey.token);
  final userRole = await dataManager.readString(LocalDataManagerKey.userRole);
  final isLoggedIn = await dataManager.readBool(LocalDataManagerKey.isLoggedIn);

  // If we don't have basic session data, go to account type selection
  if (token == null ||
      token.isEmpty ||
      userRole == null ||
      userRole.isEmpty ||
      isLoggedIn != true) {
    return SplashNavigate.accountTypeSelection;
  }

  // We have session data, validate token with server
  try {
    final authService = ref.read(authServiceProvider);
    final result = await authService.getCurrentUser();

    return result.fold(
      (failure) {
        // Check if it's specifically an authentication failure (401)
        if (failure.message.contains('Session expired') ||
            failure.message.contains('Please login again') ||
            failure.message.contains('Unauthorized')) {
          // Token is confirmed expired, clear local data
          dataManager.remove(LocalDataManagerKey.token);
          dataManager.remove(LocalDataManagerKey.userRole);
          dataManager.setIsLoggedIn(false);
          return SplashNavigate.accountTypeSelection;
        } else {
          // Network or other error - keep local data and try to proceed to home
          return SplashNavigate.home;
        }
      },
      (user) {
        // Token is valid, user is authenticated
        return SplashNavigate.home;
      },
    );
  } catch (e) {
    // Network or parsing error - keep local data and try to proceed to home
    return SplashNavigate.home;
  }
});

final isUpdateAvailableProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final splashProvider = FutureProvider.autoDispose<SplashNavigate>((ref) async {
  // Fetch and save config from API
  try {
    final configService = getIt<ConfigService>();
    await configService.fetchAndSaveConfig();
  } catch (e) {
    // Config fetch failed, but continue - it's not critical
    print('Config fetch failed: $e');
  }

  // Show splash for 2 seconds minimum
  await Future.delayed(const Duration(seconds: 2));

  // Check if user is authenticated by validating token with server
  final token = await dataManager.readString(LocalDataManagerKey.token);
  final userRole = await dataManager.readString(LocalDataManagerKey.userRole);
  final isLoggedIn = await dataManager.readBool(LocalDataManagerKey.isLoggedIn);

  // If we don't have basic session data, go to account type selection
  if (token == null ||
      token.isEmpty ||
      userRole == null ||
      userRole.isEmpty ||
      isLoggedIn != true) {
    return SplashNavigate.accountTypeSelection;
  }

  // We have session data, but need to validate token with server
  try {
    final authService = ref.read(authServiceProvider);
    final result = await authService.getCurrentUser();

    return result.fold(
      (failure) {
        // Check if it's specifically an authentication failure (401)
        if (failure.message.contains('Session expired') ||
            failure.message.contains('Please login again') ||
            failure.message.contains('Unauthorized')) {
          // Token is confirmed expired, clear local data
          dataManager.remove(LocalDataManagerKey.token);
          dataManager.remove(LocalDataManagerKey.userRole);
          dataManager.setIsLoggedIn(false);
          return SplashNavigate.accountTypeSelection;
        } else {
          // Network or other error - keep local data and try to proceed to home
          // This prevents clearing valid tokens due to network issues
          return SplashNavigate.home;
        }
      },
      (user) {
        // Token is valid, user is authenticated
        return SplashNavigate.home;
      },
    );
  } catch (e) {
    // Network or parsing error - keep local data and try to proceed to home
    // This prevents clearing valid tokens due to network issues
    return SplashNavigate.home;
  }
});

final fetchUserProvider = FutureProvider<bool>((ref) async {
  try {
    final token = await dataManager.readString(LocalDataManagerKey.token);
    if (token == null || token.isEmpty) return false;

    final authService = ref.read(authServiceProvider);

    // Try to fetch current user from API to validate token
    final result = await authService.getCurrentUser();

    return result.fold((failure) {
      // Token is invalid, clear it
      dataManager.remove(LocalDataManagerKey.token);
      dataManager.remove(LocalDataManagerKey.userRole);
      return false;
    }, (user) => true);
  } catch (e) {
    return false;
  }
});

final hasInternetProvider2 = StateProvider<bool>((ref) => true);

final fuckInternetOk = Provider<bool>((ref) {
  final a1 = ref.watch(hasInternetProvider);
  final a2 = ref.watch(hasInternetProvider2);
  if (a1.isLoading) {
    return true;
  } else if (a1.hasValue) {
    if (a1.value!) {
      return a2;
    } else {
      return false;
    }
  } else {
    return a2;
  }
});
final connectivity = Connectivity();

final hasInternetProvider = StreamProvider<bool>((ref) async* {
  ref.listenSelf((previous, next) {
    if (previous?.value == false && next.value == true) {
      ref.invalidate(hasInternetProvider2);
    }
  });
  final connectivityResult = await connectivity.checkConnectivity();
  yield connectivityResult.isOnline;
  yield* connectivity.onConnectivityChanged.map((event) {
    return event.isOnline;
  });
});

extension on List<ConnectivityResult> {
  bool get isOffline {
    return contains(ConnectivityResult.none);
  }

  bool get isOnline {
    return !isOffline;
  }
}
