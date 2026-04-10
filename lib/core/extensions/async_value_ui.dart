/// Extension on [AsyncValue] to provide a utility method for handling
/// different states (data, error, loading) in a [ConsumerWidget].
///
/// The [customWhen] method allows you to specify widget builders for each state,
/// making it easier to manage UI updates based on asynchronous data.
///
/// - [data]: Called when the value is available.
/// - [error]: Called when an error occurs.
/// - [loading]: Called while loading.
/// - [refreshable]: Callback to trigger a refresh (currently unused).
/// - [ref]: The [WidgetRef] for accessing providers.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  /// Utility to be used in [ConsumerWidget.build] to handle AsyncValue states.
  Widget customWhen({
    required Widget Function(dynamic data) data,
    required Widget Function(Object error, StackTrace stackTrace) error,
    required Widget Function() loading,
    required VoidCallback Function() refreshable,
    required WidgetRef ref,
  }) {
    return when(data: data, error: error, loading: loading);
  }
}
