import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/experiment_config.dart';
import 'analytics_service.dart';
import 'experiment_service.dart';
import 'premium_service.dart';

/// Churn thresholds
const double kChurnWarningThreshold = 0.07; // 7%
const double kChurnCriticalThreshold = 0.10; // 10%

/// MRR alert thresholds
const double kMrrDropWarningThreshold = 0.05; // 5% week-over-week
const double kRefundSurgeThreshold = 0.03; // 3% in 24h

/// Monetization service for managing revenue optimization
/// Handles churn defense, metrics, and A/B test coordination
class MonetizationService {
  final Ref _ref;

  MonetizationService(this._ref);

  AnalyticsService get _analytics => _ref.read(analyticsServiceProvider);
  ExperimentService get _experiments => _ref.read(experimentServiceProvider);
  bool get _isPremium => _ref.read(premiumProvider).isPremium;

  // ─────────────────────────────────────────────────────────────────────────
  // Initialization
  // ─────────────────────────────────────────────────────────────────────────

  /// Initialize monetization system
  Future<void> initialize() async {
    await _experiments.initialize();

    // Increment session count
    await _experiments.incrementSession();

    if (kDebugMode) {
      debugPrint('MonetizationService: Initialized');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Paywall Triggers
  // ─────────────────────────────────────────────────────────────────────────

  /// Check if paywall should be shown based on experiment and user state
  Future<bool> shouldTriggerPaywall() async {
    // Never show if already premium
    if (_isPremium) {
      return false;
    }

    return _experiments.shouldShowPaywall();
  }

  /// Mark that user has seen their first insight (triggers for variant B)
  Future<void> onFirstInsightViewed() async {
    await _experiments.markFirstInsightSeen();
  }

  /// Record paywall presentation
  Future<void> onPaywallPresented() async {
    await _experiments.recordPaywallShown();

    _analytics.logEvent('paywall_views', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Record paywall dismissal
  Future<void> onPaywallDismissed() async {
    await _experiments.recordPaywallDismissed();

    _analytics.logEvent('paywall_dismiss_rate', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Record successful purchase
  Future<void> onPurchaseSuccess({
    required double price,
    required String productId,
  }) async {
    await _experiments.recordConversion();

    final pricingVariant = await _experiments.getPricingVariant();
    final timingVariant = await _experiments.getTimingVariant();

    _analytics.logEvent('purchase_success', {
      'pricing_variant': pricingVariant.code,
      'timing_variant': timingVariant.code,
      'price': price,
      'product_id': productId,
      'revenue': price * 0.70, // Net after store fees
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Record failed purchase attempt
  Future<void> onPurchaseFailed({
    required String errorCode,
    required String productId,
  }) async {
    final pricingVariant = await _experiments.getPricingVariant();

    _analytics.logEvent('purchase_failed', {
      'pricing_variant': pricingVariant.code,
      'price': pricingVariant.price,
      'product_id': productId,
      'error_code': errorCode,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Churn Defense
  // ─────────────────────────────────────────────────────────────────────────

  /// Update churn rate (typically called from server/analytics)
  Future<void> updateChurnMetrics(double churnRate) async {
    await _experiments.updateChurnRate(churnRate);

    final level = ChurnLevel.fromRate(churnRate);

    if (level == ChurnLevel.warning) {
      await _executeWarningDefense();
    } else if (level == ChurnLevel.critical) {
      await _executeCriticalDefense();
    }
  }

  /// Execute warning level defense (7%+)
  Future<void> _executeWarningDefense() async {
    if (kDebugMode) {
      debugPrint('MonetizationService: Executing WARNING defense');
    }

    // 1. Freeze pricing experiments (handled in ExperimentService)
    // 2. Lock paywall copy (no dynamic changes)
    // 3. Log churn cohort for analysis

    _analytics.logEvent('churn_defense_actions', {
      'level': 'warning',
      'actions': [
        'freeze_pricing_experiments',
        'lock_paywall_copy',
        'increase_annual_visibility',
        'reduce_paywall_frequency',
        'log_churn_cohort',
      ],
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Execute critical level defense (10%+)
  Future<void> _executeCriticalDefense() async {
    if (kDebugMode) {
      debugPrint('MonetizationService: Executing CRITICAL defense');
    }

    // 1. Disable highest price variant
    // 2. Revert all users to safe price
    // 3. Set safest paywall timing
    // 4. Reduce ad pressure

    _analytics.logEvent('churn_defense_actions', {
      'level': 'critical',
      'actions': [
        'disable_highest_price_variant',
        'revert_to_safe_price',
        'set_safest_paywall_timing',
        'pause_ad_pressure',
        'trigger_retention_message',
      ],
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Get retention message data for critical churn
  Map<String, String> getRetentionMessage() {
    return {
      'title': "We'll be here",
      'body':
          "Take all the time you need. Your journey continues whenever you're ready.",
      'cta': 'Got it',
    };
  }

  /// Check if retention message should be shown
  bool shouldShowRetentionMessage() {
    return _experiments.shouldShowRetentionMessage();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Metrics Dashboard
  // ─────────────────────────────────────────────────────────────────────────

  /// Log MRR metric
  void logMrr(double mrr) {
    _analytics.logEvent('mrr', {'value': mrr});
  }

  /// Log ARR metric
  void logArr(double arr) {
    _analytics.logEvent('arr', {'value': arr});
  }

  /// Log ARPU metric
  void logArpu(double arpu) {
    _analytics.logEvent('arpu', {'value': arpu});
  }

  /// Log LTV metric
  void logLtv(double ltv) {
    _analytics.logEvent('ltv', {'value': ltv});
  }

  /// Log conversion rate
  void logConversionRate(double rate) {
    _analytics.logEvent('conversion_rate', {'value': rate});
  }

  /// Log renewal rate
  void logRenewalRate(double rate) {
    _analytics.logEvent('renewal_rate', {'value': rate});
  }

  /// Log refund rate and check for surge
  void logRefundRate(double rate) {
    _analytics.logEvent('refund_rate', {'value': rate});

    if (rate > kRefundSurgeThreshold) {
      _analytics.logEvent('refund_surge_alert', {
        'rate': rate,
        'threshold': kRefundSurgeThreshold,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  /// Log ad metrics for free users
  void logAdMetrics({
    required double impressions,
    required double revenue,
    required double ecpm,
    required double fillRate,
  }) {
    _analytics.logEvent('ad_metrics', {
      'impressions': impressions,
      'revenue': revenue,
      'ecpm': ecpm,
      'fill_rate': fillRate,
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Experiment Data Access
  // ─────────────────────────────────────────────────────────────────────────

  /// Get current pricing for display
  Future<String> getCurrentPriceDisplay() async {
    final variant = await _experiments.getPricingVariant();
    return variant.formattedPrice;
  }

  /// Get current price value
  Future<double> getCurrentPrice() async {
    final variant = await _experiments.getPricingVariant();
    return variant.price;
  }

  /// Get product ID for current price variant
  Future<String> getCurrentProductId() async {
    final variant = await _experiments.getPricingVariant();
    return variant.productId;
  }

  /// Check if experiments are frozen due to churn defense
  bool areExperimentsFrozen() {
    return _experiments.areExperimentsFrozen;
  }

  /// Get current churn defense level
  ChurnLevel getChurnLevel() {
    return _experiments.churnDefenseState.level;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Churn Analysis
  // ─────────────────────────────────────────────────────────────────────────

  /// Generate churn analysis report
  Future<ChurnAnalysis> generateChurnAnalysis() async {
    // Ensure assignment exists (for potential future use in analysis)
    await _experiments.getOrCreateAssignment();

    // In production, this would fetch data from analytics backend
    return ChurnAnalysis(
      priceVariantBreakdown: {
        'A': 0.04, // 4% churn for $7.99
        'B': 0.07, // 7% churn for $9.99
        'C': 0.12, // 12% churn for $11.99
      },
      timingVariantBreakdown: {
        'A': 0.08, // 8% churn for immediate
        'B': 0.05, // 5% churn for first insight
        'C': 0.06, // 6% churn for delayed
      },
      countryBreakdown: {},
      acquisitionSourceBreakdown: {},
      rootCause: _determineRootCause(),
      recommendedAction: _determineRecommendedAction(),
      analyzedAt: DateTime.now(),
    );
  }

  String _determineRootCause() {
    final level = _experiments.churnDefenseState.level;
    if (level == ChurnLevel.critical) {
      return 'Price sensitivity - highest price variant showing excessive churn';
    } else if (level == ChurnLevel.warning) {
      return 'Elevated churn detected - monitoring required';
    }
    return 'Normal churn levels';
  }

  String _determineRecommendedAction() {
    final level = _experiments.churnDefenseState.level;
    if (level == ChurnLevel.critical) {
      return 'Maintain safe pricing, investigate user feedback, consider value additions';
    } else if (level == ChurnLevel.warning) {
      return 'Continue monitoring, prepare rollback plan if churn increases';
    }
    return 'Continue A/B testing as planned';
  }
}

/// Provider for MonetizationService
final monetizationServiceProvider = Provider<MonetizationService>((ref) {
  return MonetizationService(ref);
});

/// Provider for current price display
final currentPriceDisplayProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(monetizationServiceProvider);
  return service.getCurrentPriceDisplay();
});

/// Provider for churn level
final churnLevelProvider = Provider<ChurnLevel>((ref) {
  final service = ref.watch(monetizationServiceProvider);
  return service.getChurnLevel();
});
