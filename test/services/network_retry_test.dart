import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/network_retry.dart';

void main() {
  group('retryWithBackoff', () {
    test('returns result on first attempt if no error', () async {
      final result = await retryWithBackoff(() async => 42);
      expect(result, 42);
    });

    test('retries on failure and succeeds', () async {
      var attempts = 0;
      final result = await retryWithBackoff(
        () async {
          attempts++;
          if (attempts < 3) throw Exception('fail');
          return 'success';
        },
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 10),
      );
      expect(result, 'success');
      expect(attempts, 3);
    });

    test('throws after maxAttempts exhausted', () async {
      var attempts = 0;
      expect(
        () => retryWithBackoff(
          () async {
            attempts++;
            throw Exception('always fails');
          },
          maxAttempts: 3,
          initialDelay: const Duration(milliseconds: 10),
        ),
        throwsException,
      );
    });

    test('respects retryIf predicate', () async {
      var attempts = 0;
      try {
        await retryWithBackoff(
          () async {
            attempts++;
            throw ArgumentError('not retryable');
          },
          maxAttempts: 5,
          initialDelay: const Duration(milliseconds: 10),
          retryIf: (e) => e is! ArgumentError,
        );
      } catch (_) {}
      expect(attempts, 1); // Should not retry
    });

    test('calls onRetry callback on each retry', () async {
      final retryAttempts = <int>[];
      try {
        await retryWithBackoff(
          () async => throw Exception('fail'),
          maxAttempts: 3,
          initialDelay: const Duration(milliseconds: 10),
          onRetry: (attempt, _) => retryAttempts.add(attempt),
        );
      } catch (_) {}
      expect(retryAttempts, [1, 2]);
    });

    test('timeout causes failure', () async {
      expect(
        () => retryWithBackoff(
          () async {
            await Future.delayed(const Duration(seconds: 5));
            return 'late';
          },
          maxAttempts: 1,
          timeout: const Duration(milliseconds: 50),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('exponential backoff increases delay', () async {
      final timestamps = <DateTime>[];
      try {
        await retryWithBackoff(
          () async {
            timestamps.add(DateTime.now());
            throw Exception('fail');
          },
          maxAttempts: 3,
          initialDelay: const Duration(milliseconds: 50),
        );
      } catch (_) {}
      expect(timestamps.length, 3);
      // Second delay should be ~2x the first delay
      final delay1 = timestamps[1].difference(timestamps[0]).inMilliseconds;
      final delay2 = timestamps[2].difference(timestamps[1]).inMilliseconds;
      expect(delay2, greaterThan(delay1));
    });
  });
}
