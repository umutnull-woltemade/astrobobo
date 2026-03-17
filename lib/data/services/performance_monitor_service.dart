// ════════════════════════════════════════════════════════════════════════════
// PERFORMANCE MONITOR SERVICE - App Performance Tracking
// ════════════════════════════════════════════════════════════════════════════
// Tracks startup time, frame render performance, and service initialization
// durations. Logs metrics to analytics for production monitoring.
// ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'analytics_service.dart';

class PerformanceMonitorService {
  PerformanceMonitorService._();

  static final _stopwatch = Stopwatch();
  static final Map<String, int> _serviceTimings = {};
  static int? _startupDurationMs;
  static int _slowFrameCount = 0;
  static int _totalFrameCount = 0;
  static bool _isMonitoring = false;

  /// Call at the very start of main() to begin tracking startup time
  static void markAppStart() {
    _stopwatch.start();
  }

  /// Call when the app is fully initialized and rendering
  static void markAppReady() {
    _stopwatch.stop();
    _startupDurationMs = _stopwatch.elapsedMilliseconds;
    if (kDebugMode) {
      debugPrint(
        'PerformanceMonitor: App startup completed in ${_startupDurationMs}ms',
      );
      for (final entry in _serviceTimings.entries) {
        debugPrint('  ${entry.key}: ${entry.value}ms');
      }
    }

    // Log to analytics
    AnalyticsService().logEvent('app_startup_performance', {
      'total_ms': _startupDurationMs.toString(),
      ..._serviceTimings.map((k, v) => MapEntry('${k}_ms', v.toString())),
    });
  }

  /// Time a service initialization
  static Future<T> timeService<T>(
    String serviceName,
    Future<T> Function() init,
  ) async {
    final sw = Stopwatch()..start();
    try {
      final result = await init();
      sw.stop();
      _serviceTimings[serviceName] = sw.elapsedMilliseconds;
      return result;
    } catch (e) {
      sw.stop();
      _serviceTimings['${serviceName}_FAILED'] = sw.elapsedMilliseconds;
      rethrow;
    }
  }

  /// Start monitoring frame render performance
  static void startFrameMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;

    SchedulerBinding.instance.addTimingsCallback(_onFrameTimings);

    if (kDebugMode) {
      debugPrint('PerformanceMonitor: Frame monitoring started');
    }
  }

  /// Stop monitoring and report results
  static void stopFrameMonitoring() {
    if (!_isMonitoring) return;
    _isMonitoring = false;

    SchedulerBinding.instance.removeTimingsCallback(_onFrameTimings);

    if (_totalFrameCount > 0) {
      final slowPercentage = (_slowFrameCount / _totalFrameCount * 100);
      if (kDebugMode) {
        debugPrint(
          'PerformanceMonitor: Frame report — '
          '$_totalFrameCount total, $_slowFrameCount slow '
          '(${slowPercentage.toStringAsFixed(1)}%)',
        );
      }

      // Log if slow frame rate is concerning (>5%)
      if (slowPercentage > 5) {
        AnalyticsService().logEvent('frame_performance_warning', {
          'total_frames': _totalFrameCount.toString(),
          'slow_frames': _slowFrameCount.toString(),
          'slow_percentage': slowPercentage.toStringAsFixed(1),
        });
      }
    }

    _slowFrameCount = 0;
    _totalFrameCount = 0;
  }

  static void _onFrameTimings(List<FrameTiming> timings) {
    for (final timing in timings) {
      _totalFrameCount++;
      // A frame is "slow" if it takes more than 16.67ms (below 60fps)
      final buildDuration = timing.buildDuration.inMilliseconds;
      final rasterDuration = timing.rasterDuration.inMilliseconds;
      if (buildDuration + rasterDuration > 16) {
        _slowFrameCount++;
      }
    }
  }

  /// Get startup duration (null if not yet measured)
  static int? get startupDurationMs => _startupDurationMs;

  /// Get service timing map
  static Map<String, int> get serviceTimings =>
      Map.unmodifiable(_serviceTimings);
}
