// ════════════════════════════════════════════════════════════════════════════
// SMART PROMPT SERVICE - AI-personalized daily journal prompts
// ════════════════════════════════════════════════════════════════════════════
// Calls the smart-prompt edge function to generate a personalized question.
// Caches the result for the day so only one API call per day.
// Falls back to JournalPromptService static pool if AI is unavailable.
// Free: 1 smart prompt/day. Premium: always available.
// ════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/app_providers.dart';
import 'journal_service.dart';
import 'network_retry.dart';
import 'pattern_engine_service.dart';

class SmartPromptService {
  static const String _cachedPromptKey = 'smart_prompt_cached';
  static const String _cachedDateKey = 'smart_prompt_date';

  final SharedPreferences _prefs;

  SmartPromptService._(this._prefs);

  static Future<SmartPromptService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return SmartPromptService._(prefs);
  }

  /// Returns today's cached AI prompt, or null if not yet generated.
  String? getCachedPrompt() {
    final storedDate = _prefs.getString(_cachedDateKey) ?? '';
    final today = _todayKey();
    if (storedDate != today) return null;
    return _prefs.getString(_cachedPromptKey);
  }

  /// Generate (or return cached) AI-powered daily prompt.
  Future<String?> getSmartPrompt({
    required JournalService journalService,
    required AppLanguage language,
    PatternEngineService? patternEngine,
    int currentStreak = 0,
  }) async {
    // Return cache if already generated today
    final cached = getCachedPrompt();
    if (cached != null) return cached;

    try {
      final client = Supabase.instance.client;

      // Gather recent entries for context
      final recentEntries = journalService
          .getRecentEntries(7)
          .map((e) => {
                'focusArea': e.focusArea.name,
                'rating': e.overallRating,
                'note': (e.note ?? '').length > 80
                    ? e.note!.substring(0, 80)
                    : (e.note ?? ''),
                'date': e.date.toIso8601String(),
              })
          .toList();

      // Determine weakest area from pattern engine
      String? weakestArea;
      if (patternEngine != null && patternEngine.hasEnoughData()) {
        final averages = patternEngine.getWeeklyAverages();
        if (averages.isNotEmpty) {
          final sorted = averages.entries.toList()
            ..sort((a, b) => a.value.compareTo(b.value));
          weakestArea = sorted.first.key.name;
        }
      }

      final response = await retryWithBackoff(
        () => client.functions.invoke(
          'smart-prompt',
          body: {
            'recentEntries': recentEntries,
            'weakestArea': weakestArea,
            'currentStreak': currentStreak,
            'language': language == AppLanguage.en ? 'en' : 'tr',
          },
        ),
        maxAttempts: 2,
        timeout: const Duration(seconds: 15),
      );

      if (response.status != 200) {
        if (kDebugMode) {
          debugPrint('SmartPrompt: edge function returned ${response.status}');
        }
        return null;
      }

      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      final prompt = data['prompt'] as String?;
      if (prompt != null && prompt.isNotEmpty) {
        // Cache for the day
        _prefs.setString(_cachedPromptKey, prompt);
        _prefs.setString(_cachedDateKey, _todayKey());
        return prompt;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SmartPrompt: error: $e');
      }
      return null;
    }
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }
}
