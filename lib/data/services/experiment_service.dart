import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/experiment_config.dart';
import 'analytics_service.dart';

/// Keys for SharedPreferences storage
class ExperimentKeys {
  static const String assignment = 'experiment_assignment';
  static const String churnDefense = 'churn_defense_state';
}

/// Service for managing A/B test experiments
/// Handles timing and pricing variant assignment
class ExperimentService {
  final Ref _ref;
  final Random _random = Random();

  ExperimentAssignment? _cachedAssignment;
  ChurnDefenseState _churnDefenseState = const ChurnDefenseState();

  ExperimentService(this._ref);

  AnalyticsService get _analytics => _ref.read(analyticsServiceProvider);

  /// Initialize experiment service and load saved state
  Future<void> initialize() async {
    await _loadAssignment();
    await _loadChurnDefenseState();
  }

  /// Get or create experiment assignment for user
  Future<ExperimentAssignment> getOrCreateAssignment() async {
    if (_cachedAssignment != null) {
      return _cachedAssignment!;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(ExperimentKeys.assignment);

    if (savedData != null) {
      try {
        _cachedAssignment = ExperimentAssignment.fromJson(
          jsonDecode(savedData) as Map<String, dynamic>,
        );
        return _cachedAssignment!;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('ExperimentService: Error loading assignment: $e');
        }
      }
    }

    // Create new assignment
    _cachedAssignment = _createNewAssignment();
    await _saveAssignment();

    // Log assignment event
    _analytics.logEvent('experiment_assigned', {
      'timing_variant': _cachedAssignment!.timingVariant.code,
      'pricing_variant': _cachedAssignment!.pricingVariant.code,
      'timestamp': DateTime.now().toIso8601String(),
    });

    return _cachedAssignment!;
  }

  /// Create a new random assignment based on traffic distribution
  ExperimentAssignment _createNewAssignment() {
    // Timing: A=25%, B=50%, C=25%
    final timingRandom = _random.nextDouble();
    PaywallTimingVariant timingVariant;
    if (timingRandom < 0.25) {
      timingVariant = PaywallTimingVariant.immediate;
    } else if (timingRandom < 0.75) {
      timingVariant = PaywallTimingVariant.firstInsight;
    } else {
      timingVariant = PaywallTimingVariant.delayed;
    }

    // Pricing: A=50%, B=30%, C=20%
    final pricingRandom = _random.nextDouble();
    PricingVariant pricingVariant;
    if (pricingRandom < 0.50) {
      pricingVariant = PricingVariant.priceA;
    } else if (pricingRandom < 0.80) {
      pricingVariant = PricingVariant.priceB;
    } else {
      pricingVariant = PricingVariant.priceC;
    }

    // Check if churn defense is overriding variants
    if (_churnDefenseState.isHighPriceDisabled &&
        pricingVariant == PricingVariant.priceC) {
      pricingVariant = PricingVariant.priceA;
    }

    if (_churnDefenseState.level == ChurnLevel.critical) {
      timingVariant = PaywallTimingVariant.firstInsight;
      pricingVariant = PricingVariant.priceA;
    }

    return ExperimentAssignment(
      timingVariant: timingVariant,
      pricingVariant: pricingVariant,
      assignedAt: DateTime.now(),
    );
  }

  /// Load cached assignment from storage
  Future<void> _loadAssignment() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(ExperimentKeys.assignment);

    if (savedData != null) {
      try {
        _cachedAssignment = ExperimentAssignment.fromJson(
          jsonDecode(savedData) as Map<String, dynamic>,
        );
      } catch (e) {
        if (kDebugMode) {
          debugPrint('ExperimentService: Error loading assignment: $e');
        }
      }
    }
  }

  /// Save current assignment to storage
  Future<void> _saveAssignment() async {
    if (_cachedAssignment == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      ExperimentKeys.assignment,
      jsonEncode(_cachedAssignment!.toJson()),
    );
  }

  /// Update assignment with new session data
  Future<void> incrementSession() async {
    if (_cachedAssignment == null) {
      await getOrCreateAssignment();
    }

    _cachedAssignment = _cachedAssignment!.copyWith(
      sessionCount: _cachedAssignment!.sessionCount + 1,
    );
    await _saveAssignment();
  }

  /// Mark that user has seen their first insight
  Future<void> markFirstInsightSeen() async {
    if (_cachedAssignment == null) {
      await getOrCreateAssignment();
    }

    if (!_cachedAssignment!.hasSeenFirstInsight) {
      _cachedAssignment = _cachedAssignment!.copyWith(
        hasSeenFirstInsight: true,
      );
      await _saveAssignment();

      _analytics.logEvent('first_insight_seen', {
        'timing_variant': _cachedAssignment!.timingVariant.code,
        'session_count': _cachedAssignment!.sessionCount,
      });
    }
  }

  /// Record paywall shown
  Future<void> recordPaywallShown() async {
    if (_cachedAssignment == null) {
      await getOrCreateAssignment();
    }

    _cachedAssignment = _cachedAssignment!.copyWith(
      lastPaywallShown: DateTime.now(),
    );
    await _saveAssignment();

    _analytics.logEvent('paywall_shown', {
      'timing_variant': _cachedAssignment!.timingVariant.code,
      'pricing_variant': _cachedAssignment!.pricingVariant.code,
      'price': _cachedAssignment!.pricingVariant.price,
      'session_count': _cachedAssignment!.sessionCount,
    });
  }

  /// Record successful conversion
  Future<void> recordConversion() async {
    if (_cachedAssignment == null) {
      await getOrCreateAssignment();
    }

    final hoursToConvert = DateTime.now()
        .difference(_cachedAssignment!.assignedAt)
        .inHours;

    _cachedAssignment = _cachedAssignment!.copyWith(hasConverted: true);
    await _saveAssignment();

    _analytics.logEvent('paywall_converted', {
      'timing_variant': _cachedAssignment!.timingVariant.code,
      'pricing_variant': _cachedAssignment!.pricingVariant.code,
      'price': _cachedAssignment!.pricingVariant.price,
      'hours_to_convert': hoursToConvert,
      'session_count': _cachedAssignment!.sessionCount,
    });
  }

  /// Record paywall dismissed
  Future<void> recordPaywallDismissed() async {
    if (_cachedAssignment == null) return;

    _analytics.logEvent('paywall_dismissed', {
      'timing_variant': _cachedAssignment!.timingVariant.code,
      'pricing_variant': _cachedAssignment!.pricingVariant.code,
      'session_count': _cachedAssignment!.sessionCount,
    });
  }

  /// Check if paywall should be shown based on experiment timing
  Future<bool> shouldShowPaywall() async {
    final assignment = await getOrCreateAssignment();

    // Check churn defense cooldown
    if (_churnDefenseState.isDefenseActive) {
      if (!assignment.canShowPaywallWithCooldown()) {
        return false;
      }
    }

    return assignment.shouldShowPaywall();
  }

  /// Get current pricing variant
  Future<PricingVariant> getPricingVariant() async {
    final assignment = await getOrCreateAssignment();

    // Override to safe price during critical churn
    if (_churnDefenseState.level == ChurnLevel.critical) {
      return PricingVariant.priceA;
    }

    // Disable highest price during warning
    if (_churnDefenseState.isHighPriceDisabled &&
        assignment.pricingVariant == PricingVariant.priceC) {
      return PricingVariant.priceA;
    }

    return assignment.pricingVariant;
  }

  /// Get current timing variant
  Future<PaywallTimingVariant> getTimingVariant() async {
    final assignment = await getOrCreateAssignment();
    return assignment.timingVariant;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Churn Defense
  // ─────────────────────────────────────────────────────────────────────────

  /// Get current churn defense state
  ChurnDefenseState get churnDefenseState => _churnDefenseState;

  /// Load churn defense state from storage
  Future<void> _loadChurnDefenseState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(ExperimentKeys.churnDefense);

    if (savedData != null) {
      try {
        _churnDefenseState = ChurnDefenseState.fromJson(
          jsonDecode(savedData) as Map<String, dynamic>,
        );
      } catch (e) {
        if (kDebugMode) {
          debugPrint('ExperimentService: Error loading churn defense: $e');
        }
      }
    }
  }

  /// Save churn defense state to storage
  Future<void> _saveChurnDefenseState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      ExperimentKeys.churnDefense,
      jsonEncode(_churnDefenseState.toJson()),
    );
  }

  /// Update churn rate and activate defense if needed
  Future<void> updateChurnRate(double rate) async {
    final newLevel = ChurnLevel.fromRate(rate);
    final previousLevel = _churnDefenseState.level;

    _churnDefenseState = _churnDefenseState.copyWith(
      level: newLevel,
      currentChurnRate: rate,
      lastChurnCheck: DateTime.now(),
    );

    // Activate warning level defense
    if (newLevel == ChurnLevel.warning && previousLevel == ChurnLevel.normal) {
      await _activateWarningDefense();
    }

    // Activate critical level defense
    if (newLevel == ChurnLevel.critical &&
        previousLevel != ChurnLevel.critical) {
      await _activateCriticalDefense();
    }

    // Deactivate defense if churn normalized
    if (newLevel == ChurnLevel.normal && previousLevel != ChurnLevel.normal) {
      await _deactivateDefense();
    }

    await _saveChurnDefenseState();
  }

  /// Activate warning level (7%+) defense measures
  Future<void> _activateWarningDefense() async {
    _churnDefenseState = _churnDefenseState.copyWith(
      isPricingFrozen: true,
      isTimingFrozen: true,
      defenseActivatedAt: DateTime.now(),
    );

    _analytics.logEvent('churn_defense_warning_activated', {
      'churn_rate': _churnDefenseState.currentChurnRate,
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (kDebugMode) {
      debugPrint(
        'ExperimentService: Warning defense activated at ${_churnDefenseState.currentChurnRate * 100}% churn',
      );
    }
  }

  /// Activate critical level (10%+) defense measures
  Future<void> _activateCriticalDefense() async {
    _churnDefenseState = _churnDefenseState.copyWith(
      isPricingFrozen: true,
      isTimingFrozen: true,
      isHighPriceDisabled: true,
      defenseActivatedAt: DateTime.now(),
    );

    _analytics.logEvent('churn_defense_critical_activated', {
      'churn_rate': _churnDefenseState.currentChurnRate,
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (kDebugMode) {
      debugPrint(
        'ExperimentService: CRITICAL defense activated at ${_churnDefenseState.currentChurnRate * 100}% churn',
      );
    }
  }

  /// Deactivate defense when churn normalizes
  Future<void> _deactivateDefense() async {
    _churnDefenseState = const ChurnDefenseState();

    _analytics.logEvent('churn_defense_deactivated', {
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (kDebugMode) {
      debugPrint('ExperimentService: Defense deactivated, churn normalized');
    }
  }

  /// Check if retention message should be shown (critical only)
  bool shouldShowRetentionMessage() {
    return _churnDefenseState.level == ChurnLevel.critical;
  }

  /// Check if experiments are frozen
  bool get areExperimentsFrozen =>
      _churnDefenseState.isPricingFrozen || _churnDefenseState.isTimingFrozen;
}

/// Provider for ExperimentService
final experimentServiceProvider = Provider<ExperimentService>((ref) {
  return ExperimentService(ref);
});

/// Provider for current experiment assignment
final experimentAssignmentProvider = FutureProvider<ExperimentAssignment>((
  ref,
) async {
  final service = ref.watch(experimentServiceProvider);
  return service.getOrCreateAssignment();
});

/// Provider for current pricing variant
final pricingVariantProvider = FutureProvider<PricingVariant>((ref) async {
  final service = ref.watch(experimentServiceProvider);
  return service.getPricingVariant();
});

/// Provider for churn defense state
final churnDefenseProvider = Provider<ChurnDefenseState>((ref) {
  final service = ref.watch(experimentServiceProvider);
  return service.churnDefenseState;
});
