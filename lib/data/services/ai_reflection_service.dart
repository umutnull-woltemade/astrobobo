// ════════════════════════════════════════════════════════════════════════════
// AI REFLECTION SERVICE - Personalized Post-Journal Reflections
// ════════════════════════════════════════════════════════════════════════════
// Calls the personalized-reflection Supabase edge function to generate
// AI-powered reflections after a user saves a journal entry.
// Free: 2 reflections/week. Premium: unlimited.
// ════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/journal_entry.dart';
import '../providers/app_providers.dart';
import 'journal_service.dart';
import 'network_retry.dart';

class AIReflectionService {
  static const String _weeklyCountKey = 'ai_reflection_weekly_count';
  static const String _weekKey = 'ai_reflection_week';
  static const int freeWeeklyLimit = 2;

  final SharedPreferences _prefs;

  AIReflectionService._(this._prefs);

  static Future<AIReflectionService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return AIReflectionService._(prefs);
  }

  /// How many AI reflections the user has used this week.
  int get weeklyUsage {
    _resetIfNewWeek();
    return _prefs.getInt(_weeklyCountKey) ?? 0;
  }

  /// Whether the user can request a free reflection this week.
  bool canRequestFree() => weeklyUsage < freeWeeklyLimit;

  /// Generate a personalized AI reflection for the given journal entry.
  /// Returns the reflection text, or null on failure.
  Future<String?> generateReflection({
    required JournalEntry entry,
    required JournalService journalService,
    required AppLanguage language,
    String? userName,
  }) async {
    try {
      final client = Supabase.instance.client;

      // Gather recent entries for context (last 7, excluding current)
      final recentEntries = journalService
          .getRecentEntries(8)
          .where((e) => e.id != entry.id)
          .take(7)
          .map((e) => {
                'focusArea': e.focusArea.name,
                'rating': e.overallRating,
                'note': e.note ?? '',
                'date': e.date.toIso8601String(),
              })
          .toList();

      final response = await retryWithBackoff(
        () => client.functions.invoke(
          'personalized-reflection',
          body: {
            'entry': {
              'focusArea': entry.focusArea.name,
              'rating': entry.overallRating,
              'note': entry.note ?? '',
            },
            'recentEntries': recentEntries,
            'language': language == AppLanguage.en ? 'en' : 'tr',
            'userName': userName,
          },
        ),
        maxAttempts: 2,
        timeout: const Duration(seconds: 15),
      );

      if (response.status != 200) {
        if (kDebugMode) {
          debugPrint('AIReflection: edge function returned ${response.status}');
        }
        return null;
      }

      final data = response.data is String
          ? json.decode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      final reflection = data['reflection'] as String?;
      if (reflection != null && reflection.isNotEmpty) {
        _incrementUsage();
        return reflection;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AIReflection: error: $e');
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
}
