// ════════════════════════════════════════════════════════════════════════════
// APP INITIALIZER SERVICE - Extracted async initialization logic
// ════════════════════════════════════════════════════════════════════════════
// Centralizes all async startup work (Supabase, Hive, notifications, etc.)
// into a testable, single-responsibility service. Called from main.dart's
// AppInitializer widget via FutureBuilder.
// ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/app_environment.dart';
import '../data/models/user_profile.dart';
import '../data/services/ad_service.dart';
import '../data/services/admin_analytics_service.dart';
import '../data/services/admin_auth_service.dart';
import '../data/services/analytics_service.dart';
import '../data/services/birthday_contact_service.dart';
import '../data/services/daily_hook_service.dart';
import '../data/services/data_migration_service.dart';
import '../data/services/demo_seed_service.dart';
import '../data/services/error_reporting_service.dart';
import '../data/services/feature_flag_service.dart';
import '../data/services/journal_service.dart';
import '../data/services/l10n_service.dart';
import '../data/services/notification_lifecycle_service.dart';
import '../data/services/notification_service.dart';
import '../data/services/paywall_experiment_service.dart';
import '../data/services/progressive_unlock_service.dart';
import '../data/services/storage_service.dart';
import '../data/services/sync_service.dart';
import '../data/services/telemetry_service.dart';
import '../data/providers/app_providers.dart';

/// Result of the initialization process
class InitResult {
  final AppLanguage language;
  final ThemeMode themeMode;
  final double fontSizeScale;
  final bool onboardingComplete;
  final UserProfile? profile;

  InitResult({
    required this.language,
    required this.themeMode,
    required this.fontSizeScale,
    required this.onboardingComplete,
    this.profile,
  });
}

/// Handles all async initialization logic for the app.
/// Extracted from main.dart for testability and separation of concerns.
class AppInitializerService {
  const AppInitializerService._();

  /// Run full initialization sequence. Returns [InitResult] on success.
  static Future<InitResult> initialize() async {
    final env = AppEnvironment.current;
    if (kDebugMode) {
      debugPrint('AppInitializerService: Starting initialization [${env.displayName}]...');
    }

    await _loadEnvironment();
    await _initSupabase();
    await _initAnalytics();
    await _initErrorReporting();
    await _initHive();
    await _initStorage();
    await _seedDemoData();
    await _initAdminServices();

    // Load saved settings
    var savedLanguage = StorageService.loadLanguage();
    final savedThemeMode = StorageService.loadThemeMode();
    final savedOnboardingComplete = StorageService.loadOnboardingComplete();
    final savedProfile = StorageService.loadUserProfile();

    // Auto-detect device language on first launch
    if (!StorageService.hasExplicitLanguage()) {
      final deviceLocale = PlatformDispatcher.instance.locale;
      final detected = L10nService.supportedLanguages.firstWhere(
        (lang) => lang.locale.languageCode == deviceLocale.languageCode,
        orElse: () => AppLanguage.en,
      );
      savedLanguage = detected;
      StorageService.saveLanguage(savedLanguage);
    }

    // Ensure language is supported
    if (!L10nService.supportedLanguages.contains(savedLanguage)) {
      savedLanguage = AppLanguage.en;
      StorageService.saveLanguage(savedLanguage);
    }

    await _initL10n(savedLanguage);
    savedLanguage = _ensureL10nFallback(savedLanguage);
    L10nService.preloadAll();

    await _initNotifications(savedLanguage);
    await _initAds();
    await _initSync();
    await _initPaywallExperiment();
    await _initTelemetry();
    await _initProgressiveUnlock();
    await _initFeatureFlags();

    if (kDebugMode) {
      debugPrint('AppInitializerService: Initialization complete!');
    }

    return InitResult(
      language: savedLanguage,
      themeMode: savedThemeMode,
      fontSizeScale: StorageService.loadFontSizeScale(),
      onboardingComplete: savedOnboardingComplete,
      profile: savedProfile,
    );
  }

  static Future<void> _loadEnvironment() async {
    try {
      await dotenv.load(fileName: 'assets/.env');
      if (kDebugMode) debugPrint('  Environment variables loaded');
    } catch (e) {
      if (kDebugMode) debugPrint('  Warning: Could not load .env file: $e');
    }
  }

  static Future<void> _initSupabase() async {
    try {
      final env = AppEnvironment.current;
      final supabaseUrl = env.supabaseUrlOverride ?? dotenv.env['SUPABASE_URL'] ?? '';
      final supabaseKey = env.supabaseAnonKeyOverride ?? dotenv.env['SUPABASE_ANON_KEY'] ?? '';
      if (supabaseUrl.isNotEmpty && !supabaseUrl.contains('placeholder')) {
        await Supabase.initialize(
          url: supabaseUrl,
          anonKey: supabaseKey,
          authOptions: const FlutterAuthClientOptions(
            authFlowType: AuthFlowType.pkce,
          ),
        ).timeout(const Duration(seconds: 15));
        if (kDebugMode) debugPrint('  Supabase initialized');
      } else if (kDebugMode) {
        debugPrint('  Supabase: No valid URL configured');
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  Supabase initialization failed: $e');
    }
  }

  static Future<void> _initAnalytics() async {
    try {
      await AnalyticsService().initialize();
    } catch (e) {
      if (kDebugMode) debugPrint('  AnalyticsService init failed: $e');
    }
  }

  static Future<void> _initErrorReporting() async {
    try {
      await ErrorReportingService.initialize();
      if (kDebugMode) debugPrint('  ErrorReportingService initialized');
    } catch (e) {
      if (kDebugMode) debugPrint('  ErrorReportingService init failed: $e');
    }
  }

  static Future<void> _initHive() async {
    if (!kIsWeb) {
      try {
        await Hive.initFlutter();
        if (kDebugMode) debugPrint('  Hive initialized');
      } catch (e) {
        if (kDebugMode) debugPrint('  Hive init failed: $e');
      }
    }
  }

  static Future<void> _initStorage() async {
    try {
      await StorageService.initialize().timeout(const Duration(seconds: 5));
      if (kDebugMode) debugPrint('  Storage initialized');
    } catch (e) {
      if (kDebugMode) debugPrint('  Storage initialization failed: $e');
    }
  }

  static Future<void> _seedDemoData() async {
    if (kDebugMode) {
      try {
        final seeded = await DemoSeedService.isSeeded();
        if (!seeded) {
          await DemoSeedService.seed();
          debugPrint('  Demo data seeded (Dalai Lama profile)');
        }
      } catch (e) {
        debugPrint('  Demo seed failed: $e');
      }
    }
  }

  static Future<void> _initAdminServices() async {
    if (kIsWeb) return;
    try {
      await AdminAuthService.initialize().timeout(const Duration(seconds: 5));
    } catch (e) {
      if (kDebugMode) debugPrint('  AdminAuthService init failed: $e');
    }
    try {
      await AdminAnalyticsService.initialize().timeout(const Duration(seconds: 5));
    } catch (e) {
      if (kDebugMode) debugPrint('  AdminAnalyticsService init failed: $e');
    }
  }

  static Future<void> _initL10n(AppLanguage language) async {
    try {
      await L10nService.init(language);
      if (kDebugMode) debugPrint('  L10nService initialized for ${language.name}');
    } catch (e) {
      if (kDebugMode) debugPrint('  L10nService failed for ${language.name}: $e');
      try {
        await L10nService.init(AppLanguage.en);
        if (kDebugMode) debugPrint('  L10nService fallback to English');
      } catch (e2) {
        if (kDebugMode) debugPrint('  L10nService English fallback also failed: $e2');
      }
    }
  }

  static AppLanguage _ensureL10nFallback(AppLanguage language) {
    // If L10n init failed and we fell back to English, return English
    return language;
  }

  static Future<void> _initNotifications(AppLanguage savedLanguage) async {
    if (kIsWeb) return;

    try {
      await NotificationService().initialize();
      final notifService = NotificationService();
      final isDailyEnabled = await notifService.isDailyReflectionEnabled();
      if (isDailyEnabled) {
        final dailyTime = await notifService.getDailyReflectionTime();
        if (dailyTime != null) {
          final hookService = await DailyHookService.init();
          final hookMessage = hookService.getMorningHook(language: savedLanguage);
          await notifService.scheduleDailyReflection(
            hour: dailyTime.hour,
            minute: dailyTime.minute,
            personalizedMessage: hookMessage,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  NotificationService init failed: $e');
    }

    // Reschedule birthday notifications
    try {
      final birthdayService = await BirthdayContactService.init();
      final allContacts = birthdayService.getAllContacts();
      if (allContacts.isNotEmpty) {
        await NotificationService().rescheduleAllBirthdayNotifications(allContacts);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  Birthday notification reschedule failed: $e');
    }

    // Streak, On This Day, Monthly recap notifications
    try {
      final journalSvc = await JournalService.init();
      final notif = NotificationService();

      if (!journalSvc.hasLoggedToday()) {
        final streak = journalSvc.getCurrentStreak();
        if (streak >= 2) {
          await notif.scheduleStreakAtRisk(currentStreak: streak);
        } else if (streak == 0 && journalSvc.entryCount >= 3) {
          await notif.scheduleStreakRecovery(
            lostStreak: journalSvc.entryCount > 30 ? 7 : 3,
          );
        }
      } else {
        await notif.cancelStreakAtRisk();
        await notif.cancelStreakRecovery();
      }

      // On This Day memory anniversary
      final allEntries = journalSvc.getAllEntries();
      final now = DateTime.now();
      int? yearsAgo;
      for (final entry in allEntries) {
        if (entry.date.month == now.month &&
            entry.date.day == now.day &&
            entry.date.year < now.year) {
          yearsAgo = now.year - entry.date.year;
          break;
        }
      }
      if (yearsAgo != null) {
        await notif.scheduleOnThisDayMemory(yearsAgo: yearsAgo);
      }

      // Monthly recap
      final lastMonthEntries = allEntries
          .where((e) => e.date.month == now.month && e.date.year == now.year)
          .length;
      await notif.scheduleMonthlyRecapNotification(
        lastMonthEntryCount: lastMonthEntries,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('  Streak/OnThisDay notification scheduling failed: $e');
    }

    // Notification lifecycle
    try {
      final lifecycleService = await NotificationLifecycleService.init();
      final journalService = await JournalService.init();
      await lifecycleService.recordActivity();
      await lifecycleService.evaluate(journalService);
      if (kDebugMode) debugPrint('  NotificationLifecycleService initialized');
    } catch (e) {
      if (kDebugMode) debugPrint('  NotificationLifecycleService init failed: $e');
    }
  }

  static Future<void> _initAds() async {
    if (kIsWeb) return;
    try {
      final adService = AdService();
      await adService.initialize();
    } catch (e) {
      if (kDebugMode) debugPrint('  AdService init failed: $e');
    }
  }

  static Future<void> _initSync() async {
    if (kIsWeb) return;
    try {
      await SyncService.initialize();
      SyncService.registerMergeHandler(
        'user_profiles',
        StorageService.mergeRemoteProfiles,
      );
      if (kDebugMode) debugPrint('  SyncService initialized');

      // One-time data migration
      try {
        final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
        final currentUser =
            (supabaseUrl.isNotEmpty && !supabaseUrl.contains('placeholder'))
                ? Supabase.instance.client.auth.currentUser
                : null;
        if (currentUser != null && await DataMigrationService.needsMigration()) {
          if (kDebugMode) debugPrint('  Starting data migration to Supabase...');
          final result = await DataMigrationService.migrateAllLocalData(
            userId: currentUser.id,
            onProgress: (current, total, table) {
              if (kDebugMode) debugPrint('    Migration ($current/$total): $table');
            },
          );
          if (kDebugMode) {
            debugPrint(
              '  Data migration complete: ${result.migrated} records'
              '${result.hasErrors ? ', ${result.errors.length} errors' : ''}',
            );
          }
        }
      } catch (e) {
        if (kDebugMode) debugPrint('  DataMigration failed: $e');
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  SyncService init failed: $e');
    }
  }

  static Future<void> _initPaywallExperiment() async {
    try {
      final experiment = await PaywallExperimentService.init();
      experiment.incrementSession();
      if (kDebugMode) {
        debugPrint(
          '  PaywallExperiment: pricing=${experiment.pricingVariant.name}, '
          'timing=${experiment.timingVariant.name}, '
          'session=${experiment.sessionCount}',
        );
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  PaywallExperimentService init failed: $e');
    }
  }

  static Future<void> _initTelemetry() async {
    try {
      final telemetry = await TelemetryService.init();
      await telemetry.appOpened(sessionCount: telemetry.sessionCount);
      if (kDebugMode) {
        debugPrint('  TelemetryService initialized (session #${telemetry.sessionCount})');
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  TelemetryService init failed: $e');
    }
  }

  static Future<void> _initProgressiveUnlock() async {
    try {
      final unlockService = await ProgressiveUnlockService.init();
      if (kDebugMode) {
        debugPrint(
          '  ProgressiveUnlockService: ${unlockService.entryCount} entries, '
          '${unlockService.nextUnlockMessage}',
        );
      }
    } catch (e) {
      if (kDebugMode) debugPrint('  ProgressiveUnlockService init failed: $e');
    }
  }

  static Future<void> _initFeatureFlags() async {
    try {
      await FeatureFlagService.init();
      if (kDebugMode) debugPrint('  FeatureFlagService initialized');
    } catch (e) {
      if (kDebugMode) debugPrint('  FeatureFlagService init failed: $e');
    }
  }
}
