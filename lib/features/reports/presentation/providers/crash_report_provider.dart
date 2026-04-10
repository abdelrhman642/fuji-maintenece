import 'dart:io';

import 'package:flutter_project/core/di/injection.dart';
import 'package:flutter_project/features/reports/domain/usecases/send_crash_report_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final crashReportProvider =
    StateNotifierProvider<CrashReportNotifier, CrashReportState>((ref) {
      return CrashReportNotifier(getIt<SendCrashReportUseCase>());
    });

class CrashReportNotifier extends StateNotifier<CrashReportState> {
  final SendCrashReportUseCase _sendCrashReportUseCase;

  CrashReportNotifier(this._sendCrashReportUseCase) : super(CrashReportState());

  Future<void> sendReport(String notes) async {
    if (state.image == null) {
      state = state.copyWith(error: 'Please select an image');
      return;
    }
    state = state.copyWith(isLoading: true);
    final result = await _sendCrashReportUseCase(
      notes: notes,
      image: state.image!,
    );
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (success) => state = state.copyWith(isLoading: false, isSent: true),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(image: File(pickedFile.path));
    }
  }
}

class CrashReportState {
  final bool isLoading;
  final bool isSent;
  final File? image;
  final String? error;

  CrashReportState({
    this.isLoading = false,
    this.isSent = false,
    this.image,
    this.error,
  });

  CrashReportState copyWith({
    bool? isLoading,
    bool? isSent,
    File? image,
    String? error,
  }) {
    return CrashReportState(
      isLoading: isLoading ?? this.isLoading,
      isSent: isSent ?? this.isSent,
      image: image ?? this.image,
      error: error ?? this.error,
    );
  }
}
