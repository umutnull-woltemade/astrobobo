import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/performance_monitor_service.dart';

void main() {
  group('PerformanceMonitorService startup tracking', () {
    test('markAppStart does not throw', () {
      expect(() => PerformanceMonitorService.markAppStart(), returnsNormally);
    });

    test('markAppStart followed by markAppReady records startup duration', () {
      PerformanceMonitorService.markAppStart();

      // Small delay is implicit in test execution
      PerformanceMonitorService.markAppReady();

      expect(PerformanceMonitorService.startupDurationMs, isNotNull);
      expect(PerformanceMonitorService.startupDurationMs, greaterThanOrEqualTo(0));
    });

    test('startupDurationMs is non-negative after measurement', () {
      // markAppReady was already called in previous test (static state)
      final duration = PerformanceMonitorService.startupDurationMs;
      if (duration != null) {
        expect(duration, greaterThanOrEqualTo(0));
      }
    });
  });

  group('PerformanceMonitorService timeService', () {
    test('timeService captures duration of a synchronous-like future', () async {
      final result = await PerformanceMonitorService.timeService(
        'test_service',
        () async {
          return 42;
        },
      );

      expect(result, 42);
      expect(
        PerformanceMonitorService.serviceTimings.containsKey('test_service'),
        true,
      );
      expect(
        PerformanceMonitorService.serviceTimings['test_service'],
        greaterThanOrEqualTo(0),
      );
    });

    test('timeService returns the result of the init function', () async {
      final result = await PerformanceMonitorService.timeService(
        'string_service',
        () async => 'hello',
      );

      expect(result, 'hello');
    });

    test('timeService records failed service with _FAILED suffix', () async {
      try {
        await PerformanceMonitorService.timeService(
          'failing_service',
          () async => throw Exception('Init failed'),
        );
      } catch (_) {
        // Expected
      }

      expect(
        PerformanceMonitorService.serviceTimings
            .containsKey('failing_service_FAILED'),
        true,
      );
    });

    test('timeService rethrows exceptions', () async {
      expect(
        () => PerformanceMonitorService.timeService(
          'error_service',
          () async => throw StateError('broken'),
        ),
        throwsStateError,
      );
    });

    test('multiple timeService calls accumulate in serviceTimings', () async {
      await PerformanceMonitorService.timeService(
        'service_a',
        () async => 1,
      );
      await PerformanceMonitorService.timeService(
        'service_b',
        () async => 2,
      );

      expect(
        PerformanceMonitorService.serviceTimings.containsKey('service_a'),
        true,
      );
      expect(
        PerformanceMonitorService.serviceTimings.containsKey('service_b'),
        true,
      );
    });
  });

  group('PerformanceMonitorService serviceTimings', () {
    test('serviceTimings returns an unmodifiable map', () {
      final timings = PerformanceMonitorService.serviceTimings;
      expect(
        () => timings['new_key'] = 999,
        throwsUnsupportedError,
      );
    });

    test('serviceTimings values are non-negative integers', () {
      for (final entry in PerformanceMonitorService.serviceTimings.entries) {
        expect(entry.value, isA<int>());
        expect(entry.value, greaterThanOrEqualTo(0));
      }
    });
  });
}
