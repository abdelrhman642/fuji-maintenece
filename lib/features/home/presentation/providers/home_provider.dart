import 'package:flutter_project/core/di/injection.dart';
import 'package:flutter_project/features/home/domain/entities/client_entity.dart';
import 'package:flutter_project/features/home/domain/usecases/find_client_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(getIt<FindClientUseCase>());
});

class HomeNotifier extends StateNotifier<HomeState> {
  final FindClientUseCase _findClientUseCase;

  HomeNotifier(this._findClientUseCase) : super(HomeState());

  Future<void> findClient(String registrationNumber) async {
    state = state.copyWith(isLoading: true);
    final result = await _findClientUseCase(registrationNumber);
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (client) => state = state.copyWith(isLoading: false, client: client),
    );
  }
}

class HomeState {
  final bool isLoading;
  final ClientEntity? client;
  final String? error;

  HomeState({this.isLoading = false, this.client, this.error});

  HomeState copyWith({bool? isLoading, ClientEntity? client, String? error}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      client: client ?? this.client,
      error: error ?? this.error,
    );
  }
}
