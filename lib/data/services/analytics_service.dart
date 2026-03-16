import 'dart:async';
import 'dart:io' show Platform;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// Analytics service for tracking events and user behavior.
/// Buffers events locally and flushes to Supabase in batches.
/// Device ID creation is gated behind ATT authorization on iOS.
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  static const _deviceIdKey = 'analytics_device_id';
  static const _batchSize = 25;
  static const _flushInterval = Duration(seconds: 60);

  bool _isInitialized = false;
  String? _deviceId;
  String? _sessionId;
  final List<Map<String, dynamic>> _buffer = [];
  Timer? _flushTimer;
  bool _supabaseAvailable = false;
  int _consecutiveFailures = 0;

  /// Initialize analytics — device ID gated behind ATT on iOS
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final prefs = await SharedPreferences.getInstance();

      // On iOS, only create/use device ID if ATT authorized
      bool attAuthorized = true;
      if (!kIsWeb && Platform.isIOS) {
        final status =
            await AppTrackingTransparency.trackingAuthorizationStatus;
        attAuthorized =
            status == TrackingStatus.authorized;
      }

      if (attAuthorized) {
        _deviceId = prefs.getString(_deviceIdKey);
        if (_deviceId == null) {
          _deviceId = const Uuid().v4();
          await prefs.setString(_deviceIdKey, _deviceId!);
        }
      }
      _sessionId = const Uuid().v4();

      // Check if Supabase is configured
      try {
        Supabase.instance.client;
        _supabaseAvailable = true;
      } catch (_) {
        _supabaseAvailable = false;
      }

      _flushTimer = Timer.periodic(_flushInterval, (_) => flush());

      _isInitialized = true;
      if (kDebugMode) {
        debugPrint(
          'AnalyticsService: Initialized (device=$_deviceId, att=$attAuthorized, supabase=$_supabaseAvailable)',
        );
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

    _buffer.add({
      'device_id': _deviceId ?? 'unknown',
      'user_id': _supabaseAvailable
          ? Supabase.instance.client.auth.currentUser?.id
          : null,
      'event_name': name,
      'properties': parameters ?? {},
      'session_id': _sessionId,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    });

    if (_buffer.length >= _batchSize) {
      flush();
    }
  }

  /// Flush buffered events to Supabase
  Future<void> flush() async {
    if (_buffer.isEmpty || !_supabaseAvailable) return;

    final batch = List<Map<String, dynamic>>.from(_buffer);
    _buffer.clear();

    try {
      await Supabase.instance.client.from('analytics_events').insert(batch);
      _consecutiveFailures = 0;
      if (kDebugMode) {
        debugPrint('AnalyticsService: Flushed ${batch.length} events');
      }
    } catch (e) {
      _consecutiveFailures++;
      // Re-add failed events to buffer for retry (cap at 200 to avoid OOM)
      if (_consecutiveFailures <= 3 && _buffer.length + batch.length <= 200) {
        _buffer.insertAll(0, batch);
      } else if (_consecutiveFailures > 3) {
        // Stop retrying after 3 consecutive failures — drop events
        _buffer.clear();
      }
      if (kDebugMode && _consecutiveFailures <= 3) {
        debugPrint('AnalyticsService: Flush failed (attempt $_consecutiveFailures) - $e');
      }
    }
  }

  /// Dispose resources (call on app shutdown)
  void dispose() {
    _flushTimer?.cancel();
    _isInitialized = false;
    flush(); // Final flush attempt
  }

  /// Log screen view
  void logScreenView(String screenName, {String? screenClass}) {
    logEvent('screen_view', {
      'screen_name': screenName,
      'screen_class': ?screenClass,
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
      'error': ?error,
    });
  }

  /// Log ad event
  void logAdEvent(String adType, String action, {String? placement}) {
    logEvent('ad_$action', {'ad_type': adType, 'placement': ?placement});
  }

  /// Log feature usage
  void logFeatureUsage(String feature, {Map<String, String>? details}) {
    logEvent('feature_used', {'feature': feature, ...?details});
  }

  /// Log insight view
  void logInsightView(String category, String type) {
    logEvent('insight_view', {'category': category, 'type': type});
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
      if (stackTrace != null)
        'stack_trace': stackTrace.length > 100
            ? stackTrace.substring(0, 100)
            : stackTrace,
    });
  }

  /// Set user properties
  void setUserProperty(String name, String value) {
    if (kDebugMode) {
      debugPrint('Analytics User Property: $name = $value');
    }
  }

  /// Set user ID (for premium users)
  void setUserId(String? userId) {
    if (kDebugMode) {
      debugPrint('Analytics User ID: $userId');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // P1: Comprehensive Feature Tracking Events
  // Naming convention: {noun}_{verb}
  // ─────────────────────────────────────────────────────────────────────────

  /// Journal events
  void logJournalStarted({required String focusArea}) {
    logEvent('journal_started', {'focus_area': focusArea});
  }

  void logJournalCompleted({
    required String focusArea,
    required int rating,
    required bool hasNote,
    required bool hasGratitude,
  }) {
    logEvent('journal_completed', {
      'focus_area': focusArea,
      'rating': rating.toString(),
      'has_note': hasNote.toString(),
      'has_gratitude': hasGratitude.toString(),
    });
  }

  void logJournalAbandoned({required String focusArea}) {
    logEvent('journal_abandoned', {'focus_area': focusArea});
  }

  /// Streak events
  void logStreakUpdated({required int streakDays}) {
    logEvent('streak_updated', {'streak_days': streakDays.toString()});
  }

  void logStreakFreezeUsed({required bool isPremium}) {
    logEvent('streak_freeze_used', {'is_premium': isPremium.toString()});
  }

  void logStreakMilestoneReached({required int milestone}) {
    logEvent('streak_milestone_reached', {'milestone': milestone.toString()});
  }

  /// Gratitude events
  void logGratitudeSaved({required int itemCount}) {
    logEvent('gratitude_saved', {'item_count': itemCount.toString()});
  }

  /// Ritual events
  void logRitualCreated({required String time, required int itemCount}) {
    logEvent('ritual_created', {
      'time': time,
      'item_count': itemCount.toString(),
    });
  }

  void logRitualItemToggled({required bool completed}) {
    logEvent('ritual_item_toggled', {'completed': completed.toString()});
  }

  void logRitualStackCompleted({required String time}) {
    logEvent('ritual_stack_completed', {'time': time});
  }

  /// Sleep events
  void logSleepLogged({required int quality, required bool hasNote}) {
    logEvent('sleep_logged', {
      'quality': quality.toString(),
      'has_note': hasNote.toString(),
    });
  }

  /// Wellness score events
  void logWellnessScoreCalculated({required int score}) {
    logEvent('wellness_score_calculated', {'score': score.toString()});
  }

  void logWellnessTrendViewed({required String direction}) {
    logEvent('wellness_trend_viewed', {'direction': direction});
  }

  /// Dream events
  void logDreamSaved({required bool hasInterpretation}) {
    logEvent('dream_saved', {
      'has_interpretation': hasInterpretation.toString(),
    });
  }

  void logDreamGlossaryViewed() {
    logEvent('dream_glossary_viewed');
  }

  /// Pattern events
  void logPatternViewed({required String type}) {
    logEvent('pattern_viewed', {'type': type});
  }

  void logPatternCorrelationViewed({required String areas}) {
    logEvent('pattern_correlation_viewed', {'areas': areas});
  }

  /// Navigation events
  void logNavigationEvent({required String from, required String to}) {
    logEvent('navigation', {'from': from, 'to': to});
  }

  /// Onboarding events
  void logOnboardingStarted() {
    logEvent('onboarding_started');
  }

  void logOnboardingStepCompleted({required int step}) {
    logEvent('onboarding_step_completed', {'step': step.toString()});
  }

  void logOnboardingCompleted() {
    logEvent('onboarding_completed');
  }

  /// Premium trigger events
  void logPremiumFeatureBlocked({required String feature}) {
    logEvent('premium_feature_blocked', {'feature': feature});
  }

  void logPremiumUpsellShown({required String trigger}) {
    logEvent('premium_upsell_shown', {'trigger': trigger});
  }

  /// App lifecycle
  void logAppOpened() {
    logEvent('app_opened', {'timestamp': DateTime.now().toIso8601String()});
  }

  void logAppBackgrounded() {
    logEvent('app_backgrounded');
  }

  void logSessionDuration({required int seconds}) {
    logEvent('session_duration', {'seconds': seconds.toString()});
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
      'expiry_date': ?expiryDate,
    });
  }
}

/// Analytics service provider
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final service = AnalyticsService();
  ref.onDispose(() => service.dispose());
  return service;
});
