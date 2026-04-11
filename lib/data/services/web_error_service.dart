import 'package:flutter/foundation.dart';
import 'analytics_service.dart';

/// Service for monitoring and logging errors on web platform
/// Tracks error boundary activations and repeated failures
class WebErrorService {
  static final WebErrorService _instance = WebErrorService._internal();
  factory WebErrorService() => _instance;
  WebErrorService._internal();

  final AnalyticsService _analytics = AnalyticsService();

  // Error tracking
  int _errorBoundaryActivations = 0;
  int _reloadAttempts = 0;
  final List<_ErrorEntry> _recentErrors = [];
  static const int _maxRecentErrors = 10;
  static const int _spikeThreshold = 3; // 3 errors in 60 seconds = spike

  /// Log an error that triggered the error boundary
  void logError(String errorMessage) {
    _errorBoundaryActivations++;

    // Track recent errors for spike detection
    final entry = _ErrorEntry(message: errorMessage, timestamp: DateTime.now());
    _recentErrors.add(entry);

    // Keep only recent errors
    if (_recentErrors.length > _maxRecentErrors) {
      _recentErrors.removeAt(0);
    }

    // Log to analytics
    _analytics.logEvent('web_error_boundary', {
      'message': _truncate(errorMessage, 100),
      'count': _errorBoundaryActivations.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (kDebugMode) {
      debugPrint(
        'WebErrorService: Error logged (#$_errorBoundaryActivations): $errorMessage',
      );
    }

    // Check for error spike
    _checkForSpike();
  }

  /// Log a page reload attempt
  void logReload() {
    _reloadAttempts++;

    _analytics.logEvent('web_reload_attempt', {
      'count': _reloadAttempts.toString(),
      'error_count': _errorBoundaryActivations.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (kDebugMode) {
      debugPrint('WebErrorService: Reload logged (#$_reloadAttempts)');
    }

    // Alert if repeated reloads
    if (_reloadAttempts >= 3) {
      _analytics.logEvent('web_reload_spike', {
        'reload_count': _reloadAttempts.toString(),
        'error_count': _errorBoundaryActivations.toString(),
      });
    }
  }

  /// Log a render failure (e.g., from error boundary)
  void logRenderFailure(String component, String error) {
    _analytics.logEvent('web_render_failure', {
      'component': component,
      'error': _truncate(error, 100),
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (kDebugMode) {
      debugPrint('WebErrorService: Render failure in $component: $error');
    }
  }

  /// Check if there's a spike in errors (potential white screen loop)
  void _checkForSpike() {
    final now = DateTime.now();
    final recentCount = _recentErrors.where((e) {
      return now.difference(e.timestamp).inSeconds < 60;
    }).length;

    if (recentCount >= _spikeThreshold) {
      _analytics.logEvent('web_error_spike', {
        'count_last_minute': recentCount.toString(),
        'total_count': _errorBoundaryActivations.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      });

      if (kDebugMode) {
        debugPrint(
          'WebErrorService: ERROR SPIKE DETECTED! $recentCount errors in last 60 seconds',
        );
      }
    }
  }

  /// Get current error count (useful for monitoring)
  int get errorCount => _errorBoundaryActivations;

  /// Get reload count
  int get reloadCount => _reloadAttempts;

  /// Check if there's an active error spike
  bool get hasErrorSpike {
    final now = DateTime.now();
    final recentCount = _recentErrors.where((e) {
      return now.difference(e.timestamp).inSeconds < 60;
    }).length;
    return recentCount >= _spikeThreshold;
  }

  /// Reset counters (e.g., on successful navigation)
  void reset() {
    _errorBoundaryActivations = 0;
    _reloadAttempts = 0;
    _recentErrors.clear();

    if (kDebugMode) {
      debugPrint('WebErrorService: Counters reset');
    }
  }

  /// Truncate string to max length
  String _truncate(String s, int maxLength) {
    if (s.length <= maxLength) return s;
    return '${s.substring(0, maxLength)}...';
  }
}

/// Internal class to track error entries with timestamps
class _ErrorEntry {
  final String message;
  final DateTime timestamp;

  _ErrorEntry({required this.message, required this.timestamp});
}
