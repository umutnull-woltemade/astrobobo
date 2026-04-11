import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/zodiac_sign.dart';

/// Global navigator key for notification navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Notification service for daily horoscope reminders and transit alerts
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Notification IDs
  static const int dailyHoroscopeId = 1;
  static const int mercuryRetrogradeId = 2;
  static const int moonPhaseId = 3;
  static const int transitAlertId = 4;
  static const int saturnReturnId = 5;
  static const int voidOfCourseMoonId = 6;
  static const int newMoonId = 7;
  static const int fullMoonId = 8;

  // Preference keys
  static const String _keyDailyEnabled = 'notification_daily_enabled';
  static const String _keyDailyTime = 'notification_daily_time';
  static const String _keyMoonPhaseEnabled = 'notification_moon_enabled';
  static const String _keyTransitsEnabled = 'notification_transits_enabled';
  static const String _keyRetrogradeEnabled = 'notification_retrograde_enabled';

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_isInitialized) return;
    if (kIsWeb) return; // Notifications not supported on web

    // Initialize timezone
    tz_data.initializeTimeZones();

    // Android settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS settings
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Initialize
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
  }

  /// Request notification permissions
  Future<bool> requestPermissions() async {
    if (kIsWeb) return false;

    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return result ?? false;
    }

    return false;
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (kIsWeb) return false;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final result = await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled();
      return result ?? false;
    }

    // For iOS, we can't check directly, assume enabled if initialized
    return _isInitialized;
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    // Handle navigation based on notification payload
    final payload = response.payload;
    if (payload == null) return;

    // Navigate based on payload
    String? route;
    switch (payload) {
      case 'daily_horoscope':
        route = '/horoscope';
        break;
      case 'moon_phase':
      case 'new_moon':
      case 'full_moon':
        route = '/kesif/ay-enerjisi';
        break;
      case 'mercury_retrograde':
        route = '/transits';
        break;
      case 'transit':
        route = '/transit-calendar';
        break;
      case 'saturn_return':
        route = '/saturn-return';
        break;
      case 'void_of_course':
        route = '/timing';
        break;
      default:
        route = '/home';
    }

    // Use global navigator key if available
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(route);
    }
  }

  // ============== Daily Horoscope Notifications ==============

  /// Schedule daily horoscope notification
  Future<void> scheduleDailyHoroscope({
    required ZodiacSign sign,
    required int hour,
    required int minute,
  }) async {
    await _notifications.zonedSchedule(
      dailyHoroscopeId,
      'Günlük Burç Yorumun Hazır!',
      '${sign.nameTr} burcu için bugünün kozmik mesajları seni bekliyor.',
      _nextInstanceOfTime(hour, minute),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_horoscope',
          'Günlük Burç Yorumu',
          channelDescription: 'Günlük burç yorumu bildirimleri',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          color: const Color(0xFF7C3AED),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily_horoscope',
    );

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDailyEnabled, true);
    await prefs.setInt(_keyDailyTime, hour * 60 + minute);
  }

  /// Cancel daily horoscope notification
  Future<void> cancelDailyHoroscope() async {
    await _notifications.cancel(dailyHoroscopeId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDailyEnabled, false);
  }

  /// Check if daily horoscope notification is enabled
  Future<bool> isDailyHoroscopeEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDailyEnabled) ?? false;
  }

  /// Get scheduled daily horoscope time
  Future<TimeOfDay?> getDailyHoroscopeTime() async {
    final prefs = await SharedPreferences.getInstance();
    final minutes = prefs.getInt(_keyDailyTime);
    if (minutes == null) return null;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  // ============== Moon Phase Notifications ==============

  /// Schedule moon phase notifications (new moon, full moon)
  Future<void> scheduleMoonPhaseNotifications() async {
    // This would calculate actual moon phase dates
    // For now, schedule a weekly reminder
    await _notifications.zonedSchedule(
      moonPhaseId,
      'Ay Evresi Değişiyor',
      'Yeni ay veya dolunay yaklaştığında enerjilerini hazırla.',
      _nextInstanceOfTime(20, 0), // 8 PM
      NotificationDetails(
        android: AndroidNotificationDetails(
          'moon_phase',
          'Ay Evreleri',
          channelDescription: 'Ay evresi bildirimleri',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'moon_phase',
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyMoonPhaseEnabled, true);
  }

  /// Cancel moon phase notifications
  Future<void> cancelMoonPhaseNotifications() async {
    await _notifications.cancel(moonPhaseId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyMoonPhaseEnabled, false);
  }

  // ============== Retrograde Alerts ==============

  /// Show Mercury retrograde alert
  Future<void> showMercuryRetrogradeAlert({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final daysUntil = startDate.difference(DateTime.now()).inDays;
    if (daysUntil < 0 || daysUntil > 7) return;

    await _notifications.show(
      mercuryRetrogradeId,
      'Merkür Retrosu Yaklaşıyor!',
      '$daysUntil gün içinde Merkür retroya geçiyor. İletişim ve teknolojide dikkatli ol.',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'retrograde_alerts',
          'Retro Uyarıları',
          channelDescription: 'Gezegen retrograd bildirimleri',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          color: const Color(0xFFFF9800),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: 'mercury_retrograde',
    );
  }

  /// Schedule retrograde alerts
  Future<void> scheduleRetrogradeAlerts(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRetrogradeEnabled, enabled);

    if (!enabled) {
      await _notifications.cancel(mercuryRetrogradeId);
    }
  }

  // ============== Transit Alerts ==============

  /// Show transit alert
  Future<void> showTransitAlert({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notifications.show(
      transitAlertId,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'transit_alerts',
          'Transit Uyarıları',
          channelDescription: 'Gezegensel transit bildirimleri',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: payload ?? 'transit',
    );
  }

  /// Enable/disable transit alerts
  Future<void> setTransitAlertsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyTransitsEnabled, enabled);

    if (!enabled) {
      await _notifications.cancel(transitAlertId);
    }
  }

  // ============== Saturn Return Alert ==============

  /// Show Saturn Return notification
  Future<void> showSaturnReturnAlert({
    required int returnNumber,
    required int daysUntil,
  }) async {
    if (daysUntil > 30) return;

    await _notifications.show(
      saturnReturnId,
      '$returnNumber. Satürn Dönüşün Yaklaşıyor!',
      '$daysUntil gün içinde önemli bir yaşam dönüşümü başlıyor.',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'saturn_return',
          'Satürn Dönüşü',
          channelDescription: 'Satürn dönüşü bildirimleri',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          color: const Color(0xFF6B7280),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: 'saturn_return',
    );
  }

  // ============== Utility Methods ==============

  /// Get next instance of specified time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDailyEnabled, false);
    await prefs.setBool(_keyMoonPhaseEnabled, false);
    await prefs.setBool(_keyTransitsEnabled, false);
    await prefs.setBool(_keyRetrogradeEnabled, false);
  }

  /// Get notification settings
  Future<NotificationSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return NotificationSettings(
      dailyHoroscopeEnabled: prefs.getBool(_keyDailyEnabled) ?? false,
      dailyHoroscopeTimeMinutes: prefs.getInt(_keyDailyTime),
      moonPhaseEnabled: prefs.getBool(_keyMoonPhaseEnabled) ?? false,
      transitAlertsEnabled: prefs.getBool(_keyTransitsEnabled) ?? false,
      retrogradeAlertsEnabled: prefs.getBool(_keyRetrogradeEnabled) ?? false,
    );
  }
}

/// Notification settings model
class NotificationSettings {
  final bool dailyHoroscopeEnabled;
  final int? dailyHoroscopeTimeMinutes;
  final bool moonPhaseEnabled;
  final bool transitAlertsEnabled;
  final bool retrogradeAlertsEnabled;

  NotificationSettings({
    required this.dailyHoroscopeEnabled,
    this.dailyHoroscopeTimeMinutes,
    required this.moonPhaseEnabled,
    required this.transitAlertsEnabled,
    required this.retrogradeAlertsEnabled,
  });

  TimeOfDay? get dailyHoroscopeTime {
    if (dailyHoroscopeTimeMinutes == null) return null;
    return TimeOfDay(
      hour: dailyHoroscopeTimeMinutes! ~/ 60,
      minute: dailyHoroscopeTimeMinutes! % 60,
    );
  }
}
