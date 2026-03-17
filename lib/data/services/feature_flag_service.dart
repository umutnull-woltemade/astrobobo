// ════════════════════════════════════════════════════════════════════════════
// FEATURE FLAG SERVICE - Runtime Feature Toggles
// ════════════════════════════════════════════════════════════════════════════
// Provides local feature flags with optional remote override via Supabase.
// Enables gradual rollout, A/B testing, and kill switches without App Store
// updates. Flags are cached locally and refreshed from remote on app start.
// ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Available feature flags
enum FeatureFlag {
  /// Bond (partner sync) feature
  bondEnabled,

  /// AI-powered smart daily prompts
  smartPromptsEnabled,

  /// Dream interpretation engine
  dreamInterpretationEnabled,

  /// Share cards to Instagram Stories
  shareCardsEnabled,

  /// Voice journaling
  voiceJournalEnabled,

  /// Cycle sync tracking
  cycleSyncEnabled,

  /// Shadow work exercises
  shadowWorkEnabled,

  /// Year review / wrapped
  yearReviewEnabled,

  /// New onboarding flow (A/B test)
  newOnboardingFlow,

  /// Show ads to free users
  adsEnabled,
}

class FeatureFlagService {
  static const String _prefsPrefix = 'ff_';
  static const String _lastFetchKey = 'ff_last_fetch';
  static const Duration _cacheDuration = Duration(hours: 6);

  final SharedPreferences _prefs;

  FeatureFlagService._(this._prefs);

  /// Default flag values (all features enabled by default)
  static final Map<FeatureFlag, bool> _defaults = {
    FeatureFlag.bondEnabled: true,
    FeatureFlag.smartPromptsEnabled: true,
    FeatureFlag.dreamInterpretationEnabled: true,
    FeatureFlag.shareCardsEnabled: true,
    FeatureFlag.voiceJournalEnabled: true,
    FeatureFlag.cycleSyncEnabled: true,
    FeatureFlag.shadowWorkEnabled: true,
    FeatureFlag.yearReviewEnabled: true,
    FeatureFlag.newOnboardingFlow: false,
    FeatureFlag.adsEnabled: true,
  };

  static Future<FeatureFlagService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final service = FeatureFlagService._(prefs);
    // Fetch remote flags in background (non-blocking)
    service._fetchRemoteFlags();
    return service;
  }

  /// Check if a feature flag is enabled
  bool isEnabled(FeatureFlag flag) {
    final key = '$_prefsPrefix${flag.name}';
    return _prefs.getBool(key) ?? _defaults[flag] ?? true;
  }

  /// Override a flag locally (for testing/admin)
  Future<void> setFlag(FeatureFlag flag, bool value) async {
    await _prefs.setBool('$_prefsPrefix${flag.name}', value);
  }

  /// Reset a flag to its default value
  Future<void> resetFlag(FeatureFlag flag) async {
    await _prefs.remove('$_prefsPrefix${flag.name}');
  }

  /// Fetch remote flag overrides from Supabase
  Future<void> _fetchRemoteFlags() async {
    // Check cache freshness
    final lastFetch = _prefs.getInt(_lastFetchKey);
    if (lastFetch != null) {
      final elapsed = DateTime.now().difference(
        DateTime.fromMillisecondsSinceEpoch(lastFetch),
      );
      if (elapsed < _cacheDuration) return;
    }

    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('feature_flags')
          .select('flag_name, enabled')
          .timeout(const Duration(seconds: 5));

      for (final row in response) {
        final flagName = row['flag_name'] as String?;
        final enabled = row['enabled'] as bool?;
        if (flagName == null || enabled == null) continue;

        // Match to enum
        try {
          final flag = FeatureFlag.values.firstWhere(
            (f) => f.name == flagName,
          );
          await _prefs.setBool('$_prefsPrefix${flag.name}', enabled);
        } catch (_) {
          // Unknown flag name — skip
        }
      }

      await _prefs.setInt(
        _lastFetchKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FeatureFlagService: Remote fetch failed (using cached): $e');
      }
    }
  }

  /// Force refresh flags from remote
  Future<void> refresh() async {
    await _prefs.remove(_lastFetchKey);
    await _fetchRemoteFlags();
  }
}
