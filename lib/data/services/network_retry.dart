// ════════════════════════════════════════════════════════════════════════════
// NETWORK RETRY - Exponential Backoff Utility
// ════════════════════════════════════════════════════════════════════════════
// Generic retry utility with exponential backoff for network operations.
// Used by SyncService, SmartPromptService, and edge function calls.
// ════════════════════════════════════════════════════════════════════════════

import 'dart:async';
import 'dart:math' show min;

import 'package:flutter/foundation.dart';

/// Retry a function with exponential backoff.
///
/// [fn] - The async function to retry.
/// [maxAttempts] - Maximum number of attempts (default: 3).
/// [initialDelay] - Initial delay before first retry (default: 1 second).
/// [maxDelay] - Maximum delay between retries (default: 30 seconds).
/// [retryIf] - Optional predicate to decide if error is retryable.
/// [onRetry] - Optional callback on each retry with attempt number and error.
///
/// Example:
/// ```dart
/// final result = await retryWithBackoff(
///   () => supabase.from('table').select(),
///   maxAttempts: 3,
///   retryIf: (e) => e is! AuthException,
/// );
/// ```
Future<T> retryWithBackoff<T>(
  Future<T> Function() fn, {
  int maxAttempts = 3,
  Duration initialDelay = const Duration(seconds: 1),
  Duration maxDelay = const Duration(seconds: 30),
  Duration? timeout,
  bool Function(Object error)? retryIf,
  void Function(int attempt, Object error)? onRetry,
}) async {
  var attempt = 0;
  while (true) {
    attempt++;
    try {
      final future = fn();
      if (timeout != null) {
        return await future.timeout(timeout);
      }
      return await future;
    } catch (e) {
      if (attempt >= maxAttempts) rethrow;
      if (retryIf != null && !retryIf(e)) rethrow;

      final delayMs = min(
        initialDelay.inMilliseconds * (1 << (attempt - 1)),
        maxDelay.inMilliseconds,
      );
      final delay = Duration(milliseconds: delayMs);

      if (kDebugMode) {
        debugPrint(
          'RetryWithBackoff: Attempt $attempt/$maxAttempts failed, '
          'retrying in ${delay.inMilliseconds}ms: $e',
        );
      }

      onRetry?.call(attempt, e);
      await Future.delayed(delay);
    }
  }
}
