import 'package:flutter_project/core/di/injection.dart';
import 'package:flutter_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(getIt<LoginUseCase>());
});

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginNotifier(this._loginUseCase) : super(LoginState());

  Future<void> login(String phoneNumber, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _loginUseCase(phoneNumber, password);
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (success) => state = state.copyWith(isLoading: false),
    );
  }
}

class LoginState {
  final bool isLoading;
  final String? error;

  LoginState({this.isLoading = false, this.error});

  LoginState copyWith({bool? isLoading, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
