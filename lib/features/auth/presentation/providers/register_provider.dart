import 'package:flutter_project/core/di/injection.dart';
import 'package:flutter_project/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(getIt<RegisterUseCase>());
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterNotifier(this._registerUseCase) : super(RegisterState());

  Future<void> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    String? email,
    String? address,
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _registerUseCase(
      fullName: fullName,
      phoneNumber: phoneNumber,
      password: password,
      email: email,
      address: address,
    );
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (success) => state = state.copyWith(isLoading: false),
    );
  }
}

class RegisterState {
  final bool isLoading;
  final String? error;

  RegisterState({this.isLoading = false, this.error});

  RegisterState copyWith({bool? isLoading, String? error}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
