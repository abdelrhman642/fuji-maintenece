import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:logger/logger.dart';

import '../../../../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import 'auth_service.dart';

/// Login state
class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? user;
  final String? userType;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
    this.userType,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? user,
    String? userType,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
      userType: userType ?? this.userType,
    );
  }
}

/// Login controller
class LoginController extends StateNotifier<LoginState> {
  final AuthService _authService;
  final Logger _logger;

  LoginController({required AuthService authService, Logger? logger})
    : _authService = authService,
      _logger = logger ?? Logger(),
      super(const LoginState());

  /// Login with phone, password, and user type
  Future<bool?> login({
    required String phone,
    required String password,
    required String userType,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      _logger.d('LoginController: Attempting login for $phone as $userType');

      final result = await _authService.login(
        phone: phone,
        password: password,
        userType: userType,
      );

      return result.fold(
        (failure) {
          _logger.e('LoginController: Login failed - ${failure.message}');

          String errorMessage = failure.message;

          context.showError(errorMessage);

          if (failure is AccountNotActivatedFailure) {}

          // Check if controller is still mounted before updating state
          if (mounted) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: errorMessage,
            );
          }
          if (failure is AccountNotActivatedFailure) {
            return null;
          }
          return false;
        },
        (authResponse) {
          _logger.d('LoginController: Login successful');

          // Check if controller is still mounted before updating state
          if (mounted) {
            state = state.copyWith(
              isLoading: false,
              user: authResponse.user,
              userType: authResponse.userType,
              errorMessage: null,
            );
          }

          return true;
        },
      );
    } catch (e, stackTrace) {
      _logger.e('LoginController: Error', error: e, stackTrace: stackTrace);

      // Check if controller is still mounted before updating state
      if (mounted) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred. Please try again.',
        );
      }

      return false;
    }
  }

  /// Reset error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Get user-friendly error message from failure
  String _getErrorMessage(Failure failure) {
    if (failure is AuthFailure) {
      return 'Invalid email or password';
    } else if (failure is NetworkFailure) {
      return 'Network error. Please check your internet connection.';
    } else if (failure is ServerFailure) {
      return failure.message.isNotEmpty
          ? failure.message
          : 'Server error. Please try again later.';
    } else if (failure is ValidationFailure) {
      return failure.message;
    } else {
      return 'An error occurred. Please try again.';
    }
  }
}

/// Provider for LoginController
final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>((ref) {
      return LoginController(authService: ref.read(authServiceProvider));
    });
