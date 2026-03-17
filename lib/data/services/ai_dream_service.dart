// ════════════════════════════════════════════════════════════════════════════
// AI DREAM SERVICE - Edge-function powered dream interpretation
// ════════════════════════════════════════════════════════════════════════════
// Calls the dream-analysis edge function for AI-powered 7D interpretation.
// Falls back gracefully to local engine on failure.
// Free: 1/week. Premium: unlimited.
// ════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/dream_interpretation_models.dart';
import '../content/dream_symbols_database.dart';
import '../providers/app_providers.dart';
import 'network_retry.dart';
import 'dream_interpretation_service.dart';
import 'moon_phase_service.dart' as lunar;

class AIDreamService {
  static const String _weeklyCountKey = 'ai_dream_weekly_count';
  static const String _weekKey = 'ai_dream_week';
  static const int freeWeeklyLimit = 1;

  final SharedPreferences _prefs;

  AIDreamService._(this._prefs);

  static Future<AIDreamService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return AIDreamService._(prefs);
  }

  int get weeklyUsage {
    _resetIfNewWeek();
    return _prefs.getInt(_weeklyCountKey) ?? 0;
  }

  bool canRequestFree() => weeklyUsage < freeWeeklyLimit;

  /// Call the dream-analysis edge function and parse the response into
  /// a FullDreamInterpretation via the existing parseAIResponse() method.
  /// Returns null on failure (caller should fall back to local engine).
  Future<FullDreamInterpretation?> analyzeWithAI({
    required String dreamText,
    required DreamInterpretationService interpretationService,
    required AppLanguage language,
    String? emotion,
    String? wakingFeeling,
    bool isRecurring = false,
    int? recurringCount,
  }) async {
    try {
      final client = Supabase.instance.client;

      // Detect symbols locally for context
      final detectedSymbols = DreamSymbolsDatabase.detectSymbolsInText(dreamText);
      final symbolNames = detectedSymbols.map((s) =>
        language == AppLanguage.en ? s.symbol : s.symbolTr
      ).toList();

      // Get current moon phase (maps service enum → models enum)
      final moonData = lunar.MoonPhaseService.calculate(DateTime.now());
      final modelPhase = _mapMoonPhase(moonData.phase);

      final response = await retryWithBackoff(
        () => client.functions.invoke(
          'dream-analysis',
          body: {
            'dreamText': dreamText,
            'emotion': emotion ?? '',
            'wakingFeeling': wakingFeeling ?? '',
            'isRecurring': isRecurring,
            'recurringCount': recurringCount,
            'moonPhase': '${modelPhase.label} ${modelPhase.emoji}',
            'detectedSymbols': symbolNames,
            'language': language == AppLanguage.en ? 'en' : 'tr',
          },
        ),
        maxAttempts: 2,
        timeout: const Duration(seconds: 20),
      );

      if (response.status != 200) {
        if (kDebugMode) {
          debugPrint('AIDream: edge function returned ${response.status}');
        }
        return null;
      }

      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      final interpretation = data['interpretation'] as Map<String, dynamic>?;
      if (interpretation == null) return null;

      // Use existing parseAIResponse to build FullDreamInterpretation
      final result = interpretationService.parseAIResponse(
        dreamText,
        interpretation,
        modelPhase,
      );

      _incrementUsage();
      return result;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AIDream: error: $e');
      }
      return null;
    }
  }

  void _incrementUsage() {
    _resetIfNewWeek();
    final current = _prefs.getInt(_weeklyCountKey) ?? 0;
    _prefs.setInt(_weeklyCountKey, current + 1);
  }

  void _resetIfNewWeek() {
    final now = DateTime.now();
    final currentWeek = '${now.year}-${_isoWeek(now)}';
    final storedWeek = _prefs.getString(_weekKey) ?? '';
    if (storedWeek != currentWeek) {
      _prefs.setString(_weekKey, currentWeek);
      _prefs.setInt(_weeklyCountKey, 0);
    }
  }

  int _isoWeek(DateTime date) {
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  /// Map the moon_phase_service.MoonPhase → dream_interpretation_models.MoonPhase
  MoonPhase _mapMoonPhase(lunar.MoonPhase serviceMoon) {
    switch (serviceMoon) {
      case lunar.MoonPhase.newMoon:
        return MoonPhase.yeniay;
      case lunar.MoonPhase.waxingCrescent:
        return MoonPhase.hilal;
      case lunar.MoonPhase.firstQuarter:
        return MoonPhase.ilkDordun;
      case lunar.MoonPhase.waxingGibbous:
        return MoonPhase.ilkDordun;
      case lunar.MoonPhase.fullMoon:
        return MoonPhase.dolunay;
      case lunar.MoonPhase.waningGibbous:
        return MoonPhase.sonDordun;
      case lunar.MoonPhase.lastQuarter:
        return MoonPhase.sonDordun;
      case lunar.MoonPhase.waningCrescent:
        return MoonPhase.karanlikAy;
    }
  }
}
