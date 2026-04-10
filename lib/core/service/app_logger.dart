import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Riverpod state change logger for debugging
class AppProviderObserver extends ProviderObserver {
  final Logger _logger = Logger();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      _logger.d('''
Provider Updated: ${provider.name ?? provider.runtimeType}
Previous: $previousValue
New: $newValue
''');
    }
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      _logger.i(
        'Provider Added: ${provider.name ?? provider.runtimeType} = $value',
      );
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      _logger.w('Provider Disposed: ${provider.name ?? provider.runtimeType}');
    }
  }
}
