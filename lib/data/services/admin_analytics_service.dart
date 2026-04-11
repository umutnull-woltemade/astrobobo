import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Admin analytics service for tracking growth events
/// Tracks page views, clicks, shares, and custom events
class AdminAnalyticsService {
  static const String _analyticsBoxName = 'admin_analytics_box';
  static const String _eventsKey = 'event_log';
  static const String _sessionsKey = 'session_data';

  static Box? _analyticsBox;

  /// Initialize analytics storage (skipped on web to prevent white screen)
  static Future<void> initialize() async {
    // Skip on web - Hive's IndexedDB can hang and cause white screen
    if (kIsWeb) {
      if (kDebugMode) {
        debugPrint('AdminAnalyticsService: Skipping on web');
      }
      return;
    }
    _analyticsBox = await Hive.openBox(_analyticsBoxName);
  }

  // ═══════════════════════════════════════════════════════════════════
  // EVENT TRACKING
  // ═══════════════════════════════════════════════════════════════════

  /// Log an event with optional payload
  static Future<void> logEvent(
    String eventName, {
    Map<String, dynamic>? payload,
  }) async {
    final box = _analyticsBox;
    if (box == null) return;

    final events = _getEvents();
    final now = DateTime.now();
    final dateKey = _dateKey(now);

    // Find or create event entry
    final existingIndex = events.indexWhere((e) => e['name'] == eventName);

    if (existingIndex >= 0) {
      // Update existing
      events[existingIndex]['count'] =
          (events[existingIndex]['count'] as int) + 1;
      events[existingIndex]['lastFired'] = now.toIso8601String();

      // Update daily count
      final dailyCounts = Map<String, int>.from(
        events[existingIndex]['dailyCounts'] as Map? ?? {},
      );
      dailyCounts[dateKey] = (dailyCounts[dateKey] ?? 0) + 1;
      events[existingIndex]['dailyCounts'] = dailyCounts;
    } else {
      // Create new
      events.add({
        'name': eventName,
        'count': 1,
        'firstFired': now.toIso8601String(),
        'lastFired': now.toIso8601String(),
        'dailyCounts': {dateKey: 1},
        'payload': payload,
      });
    }

    await box.put(_eventsKey, jsonEncode(events));
  }

  /// Get all events
  static List<Map<String, dynamic>> _getEvents() {
    final box = _analyticsBox;
    if (box == null) return [];

    final json = box.get(_eventsKey) as String?;
    if (json == null) return [];

    try {
      final list = jsonDecode(json) as List;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Get event count for a specific event
  static int getEventCount(String eventName) {
    final events = _getEvents();
    final event = events.where((e) => e['name'] == eventName).firstOrNull;
    return event?['count'] as int? ?? 0;
  }

  /// Get event count for today
  static int getTodayEventCount(String eventName) {
    final events = _getEvents();
    final event = events.where((e) => e['name'] == eventName).firstOrNull;
    if (event == null) return 0;

    final dailyCounts = event['dailyCounts'] as Map?;
    if (dailyCounts == null) return 0;

    final todayKey = _dateKey(DateTime.now());
    return dailyCounts[todayKey] as int? ?? 0;
  }

  /// Get all event logs
  static List<EventLog> getAllEvents() {
    return _getEvents().map((e) {
      return EventLog(
        name: e['name'] as String,
        count: e['count'] as int,
        lastFired: DateTime.parse(e['lastFired'] as String),
        firstFired: DateTime.parse(e['firstFired'] as String),
      );
    }).toList();
  }

  // ═══════════════════════════════════════════════════════════════════
  // PRE-DEFINED EVENTS
  // ═══════════════════════════════════════════════════════════════════

  /// Page view event
  static Future<void> trackPageView(String pageName) async {
    await logEvent('page_view', payload: {'page': pageName});
    await logEvent('page_view_$pageName');
  }

  /// Recommendation viewed
  static Future<void> trackRecommendationView(String recoType) async {
    await logEvent('recommendation_view', payload: {'type': recoType});
  }

  /// Recommendation clicked
  static Future<void> trackRecommendationClick(String recoType) async {
    await logEvent('recommendation_click', payload: {'type': recoType});
  }

  /// Ritual clicked
  static Future<void> trackRitualClick(String ritualName) async {
    await logEvent('ritual_click', payload: {'ritual': ritualName});
  }

  /// Share screen viewed
  static Future<void> trackShareView(String shareType) async {
    await logEvent('share_view', payload: {'type': shareType});
  }

  /// User returned from share
  static Future<void> trackShareReturn(String shareType) async {
    await logEvent('share_return', payload: {'type': shareType});
  }

  /// Admin login success
  static Future<void> trackAdminLoginSuccess() async {
    await logEvent('admin_login_success');
  }

  /// Admin login failed
  static Future<void> trackAdminLoginFail() async {
    await logEvent('admin_login_fail');
  }

  /// Dream interpreted
  static Future<void> trackDreamInterpreted() async {
    await logEvent('dream_interpreted');
  }

  /// Tarot spread
  static Future<void> trackTarotSpread(String spreadType) async {
    await logEvent('tarot_spread', payload: {'spread': spreadType});
  }

  /// Feature used
  static Future<void> trackFeatureUsed(String featureName) async {
    await logEvent('feature_used_$featureName');
  }

  /// Premium conversion
  static Future<void> trackPremiumView() async {
    await logEvent('premium_view');
  }

  static Future<void> trackPremiumPurchase(String tier) async {
    await logEvent('premium_purchase', payload: {'tier': tier});
  }

  // ═══════════════════════════════════════════════════════════════════
  // SESSION TRACKING
  // ═══════════════════════════════════════════════════════════════════

  static String? _currentSessionId;
  static DateTime? _sessionStart;
  static int _sessionDepth = 0;

  /// Start a new session
  static Future<void> startSession() async {
    final box = _analyticsBox;
    if (box == null) return;

    _currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    _sessionStart = DateTime.now();
    _sessionDepth = 0;

    await logEvent('session_start');
  }

  /// Increment session depth (page visits within session)
  static void incrementSessionDepth() {
    _sessionDepth++;
  }

  /// End current session
  static Future<void> endSession() async {
    if (_currentSessionId == null) return;

    final box = _analyticsBox;
    if (box == null) return;

    final sessions = _getSessions();
    final duration = _sessionStart != null
        ? DateTime.now().difference(_sessionStart!).inSeconds
        : 0;

    sessions.add({
      'id': _currentSessionId,
      'start': _sessionStart?.toIso8601String(),
      'end': DateTime.now().toIso8601String(),
      'duration': duration,
      'depth': _sessionDepth,
    });

    // Keep only last 100 sessions
    if (sessions.length > 100) {
      sessions.removeRange(0, sessions.length - 100);
    }

    await box.put(_sessionsKey, jsonEncode(sessions));
    await logEvent(
      'session_end',
      payload: {'duration': duration, 'depth': _sessionDepth},
    );

    _currentSessionId = null;
    _sessionStart = null;
    _sessionDepth = 0;
  }

  static List<Map<String, dynamic>> _getSessions() {
    final box = _analyticsBox;
    if (box == null) return [];

    final json = box.get(_sessionsKey) as String?;
    if (json == null) return [];

    try {
      final list = jsonDecode(json) as List;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Get average session depth
  static double getAverageSessionDepth() {
    final sessions = _getSessions();
    if (sessions.isEmpty) return 0.0;

    final totalDepth = sessions.fold<int>(
      0,
      (sum, s) => sum + (s['depth'] as int? ?? 0),
    );
    return totalDepth / sessions.length;
  }

  /// Get average session duration (seconds)
  static double getAverageSessionDuration() {
    final sessions = _getSessions();
    if (sessions.isEmpty) return 0.0;

    final totalDuration = sessions.fold<int>(
      0,
      (sum, s) => sum + (s['duration'] as int? ?? 0),
    );
    return totalDuration / sessions.length;
  }

  // ═══════════════════════════════════════════════════════════════════
  // METRICS CALCULATION
  // ═══════════════════════════════════════════════════════════════════

  /// Calculate D1 return rate (users who return within 1 day)
  static double calculateD1Return() {
    // In production, this would compare unique users
    // For now, return sample calculation
    final totalSessions = _getSessions().length;
    if (totalSessions == 0) return 0.0;

    // Simplified: sessions with depth > 3 considered "engaged"
    final engagedSessions = _getSessions()
        .where((s) => (s['depth'] as int? ?? 0) > 3)
        .length;

    return (engagedSessions / totalSessions) * 100;
  }

  /// Calculate recommendation CTR
  static double calculateRecoCtr() {
    final views = getEventCount('recommendation_view');
    final clicks = getEventCount('recommendation_click');
    if (views == 0) return 0.0;
    return (clicks / views) * 100;
  }

  /// Calculate share-to-return rate
  static double calculateShareReturnRate() {
    final views = getEventCount('share_view');
    final returns = getEventCount('share_return');
    if (views == 0) return 0.0;
    return (returns / views) * 100;
  }

  // ═══════════════════════════════════════════════════════════════════
  // UTILITY
  // ═══════════════════════════════════════════════════════════════════

  static String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Clear all analytics data
  static Future<void> clearAll() async {
    final box = _analyticsBox;
    if (box == null) return;
    await box.clear();
  }
}

/// Event log model
class EventLog {
  final String name;
  final int count;
  final DateTime lastFired;
  final DateTime firstFired;

  EventLog({
    required this.name,
    required this.count,
    required this.lastFired,
    required this.firstFired,
  });
}
