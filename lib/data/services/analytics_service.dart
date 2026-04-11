import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Analytics service for tracking events and user behavior
/// Supports Firebase Analytics with graceful fallback
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  bool _isInitialized = false;

  /// Initialize analytics
  Future<void> initialize() async {
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
  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    if (kDebugMode) {
      debugPrint('Analytics Event: $name ${parameters ?? {}}');
    }

    // In production, this would use Firebase Analytics
    // Convert to Map<String, Object?> for Firebase
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

  // ─────────────────────────────────────────────────────────────────────────
  // Experiment & Monetization Events
  // ─────────────────────────────────────────────────────────────────────────

  /// Log experiment assignment
  void logExperimentAssignment({
    required String timingVariant,
    required String pricingVariant,
  }) {
    logEvent('experiment_assigned', {
      'timing_variant': timingVariant,
      'pricing_variant': pricingVariant,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log paywall timing trigger
  void logPaywallTimingTriggered({
    required String variant,
    required String triggerEvent,
    required int sessionNumber,
  }) {
    logEvent('paywall_timing_triggered', {
      'variant': variant,
      'trigger_event': triggerEvent,
      'session_number': sessionNumber.toString(),
    });
  }

  /// Log paywall view
  void logPaywallView({
    required String timingVariant,
    required String pricingVariant,
    required double price,
    required int sessionCount,
  }) {
    logEvent('paywall_view', {
      'timing_variant': timingVariant,
      'pricing_variant': pricingVariant,
      'price': price.toString(),
      'session_count': sessionCount.toString(),
    });
  }

  /// Log paywall conversion
  void logPaywallConversion({
    required String timingVariant,
    required String pricingVariant,
    required double price,
    required int hoursToConvert,
  }) {
    logEvent('paywall_conversion', {
      'timing_variant': timingVariant,
      'pricing_variant': pricingVariant,
      'price': price.toString(),
      'hours_to_convert': hoursToConvert.toString(),
      'revenue': (price * 0.70).toString(), // Net after store fees
    });
  }

  /// Log paywall dismissal
  void logPaywallDismissal({
    required String timingVariant,
    required String pricingVariant,
    required int sessionCount,
  }) {
    logEvent('paywall_dismissal', {
      'timing_variant': timingVariant,
      'pricing_variant': pricingVariant,
      'session_count': sessionCount.toString(),
    });
  }

  /// Log churn defense activation
  void logChurnDefenseActivated({
    required String level,
    required double churnRate,
    required List<String> actions,
  }) {
    logEvent('churn_defense_activated', {
      'level': level,
      'churn_rate': churnRate.toString(),
      'actions': actions.join(','),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log churn defense deactivation
  void logChurnDefenseDeactivated() {
    logEvent('churn_defense_deactivated', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log MRR metric
  void logMrrMetric(double mrr) {
    logEvent('mrr_metric', {
      'value': mrr.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log churn rate
  void logChurnRate(double rate) {
    logEvent('churn_rate', {
      'value': rate.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log refund rate
  void logRefundRate(double rate, {bool isSurge = false}) {
    logEvent('refund_rate', {
      'value': rate.toString(),
      'is_surge': isSurge.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log ad metrics for free users
  void logAdMetrics({
    required double impressions,
    required double revenue,
    required double ecpm,
    required double fillRate,
  }) {
    logEvent('ad_metrics', {
      'impressions': impressions.toString(),
      'revenue': revenue.toString(),
      'ecpm': ecpm.toString(),
      'fill_rate': fillRate.toString(),
    });
  }

  /// Log entitlement check
  void logEntitlementCheck({required bool isActive, required String source}) {
    logEvent('entitlement_check', {
      'is_active': isActive.toString(),
      'source': source,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Log subscription expiry
  void logSubscriptionExpiry({
    required String previousTier,
    String? expiryDate,
  }) {
    logEvent('subscription_expired', {
      'previous_tier': previousTier,
      if (expiryDate != null) 'expiry_date': expiryDate,
    });
  }
}

/// Analytics service provider
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});
