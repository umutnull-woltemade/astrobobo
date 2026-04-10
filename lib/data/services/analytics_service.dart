import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/runtime_flags.dart';

/// Analytics service for tracking events and user behavior
/// Supports Firebase Analytics with graceful fallback
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  bool _isInitialized = false;

  /// Initialize analytics
  Future<void> initialize() async {
    if (isRunningTests) return;
    if (_isInitialized) return;

    try {
      // Firebase Analytics initialization is handled in main.dart
      // This service provides a wrapper for logging events
      _isInitialized = true;
      if (kDebugMode) {
        debugPrint('AnalyticsService: Initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AnalyticsService: Initialization failed - $e');
      }
    }
  }

  /// Log a custom event
  void logEvent(String name, [Map<String, String>? parameters]) {
    if (kDebugMode) {
      debugPrint('Analytics Event: $name ${parameters ?? {}}');
    }

    // In production, this would use Firebase Analytics
    // FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }

  /// Log screen view
  void logScreenView(String screenName, {String? screenClass}) {
    logEvent('screen_view', {
      'screen_name': screenName,
      if (screenClass != null) 'screen_class': screenClass,
    });
  }

  /// Log purchase event
  void logPurchase({
    required String productId,
    required String tier,
    required bool success,
    String? error,
  }) {
    logEvent('purchase_attempt', {
      'product_id': productId,
      'tier': tier,
      'success': success.toString(),
      if (error != null) 'error': error,
    });
  }

  /// Log ad event
  void logAdEvent(String adType, String action, {String? placement}) {
    logEvent('ad_$action', {
      'ad_type': adType,
      if (placement != null) 'placement': placement,
    });
  }

  /// Log feature usage
  void logFeatureUsage(String feature, {Map<String, String>? details}) {
    logEvent('feature_used', {'feature': feature, ...?details});
  }

  /// Log horoscope view
  void logHoroscopeView(String sign, String type) {
    logEvent('horoscope_view', {'sign': sign, 'type': type});
  }

  /// Log chart generation
  void logChartGeneration(String chartType) {
    logEvent('chart_generated', {'chart_type': chartType});
  }

  /// Log share action
  void logShare(String contentType, String method) {
    logEvent('share', {'content_type': contentType, 'method': method});
  }

  /// Log error
  void logError(String errorType, String message, {String? stackTrace}) {
    logEvent('app_error', {
      'error_type': errorType,
      'message': message,
      if (stackTrace != null) 'stack_trace': stackTrace.substring(0, 100),
    });
  }

  /// Set user properties
  void setUserProperty(String name, String value) {
    if (kDebugMode) {
      debugPrint('Analytics User Property: $name = $value');
    }
    // FirebaseAnalytics.instance.setUserProperty(name: name, value: value);
  }

  /// Set user ID (for premium users)
  void setUserId(String? userId) {
    if (kDebugMode) {
      debugPrint('Analytics User ID: $userId');
    }
    // FirebaseAnalytics.instance.setUserId(id: userId);
  }
}

/// Analytics service provider
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});
