import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'shared/services/router_service.dart';
import 'shared/widgets/interpretive_text.dart';
import 'data/services/ad_service.dart';
import 'data/services/storage_service.dart';
import 'core/runtime_flags.dart';
import 'data/services/notification_service.dart';
import 'data/services/admin_auth_service.dart';
import 'data/services/admin_analytics_service.dart';
import 'data/providers/app_providers.dart';
import 'data/models/user_profile.dart';

void main() async {
  if (kDebugMode) {
    debugPrint('🚀 Venus One: Starting initialization...');
  }

  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    debugPrint('✓ WidgetsBinding initialized');
  }

  // Load environment variables with error handling for web
  try {
    await dotenv.load(fileName: 'assets/.env');
    if (kDebugMode) {
      debugPrint('✓ Environment variables loaded');
    }
  } catch (e) {
    // On web, .env may not exist or be empty - continue with defaults
    if (kDebugMode) {
      debugPrint('⚠️ Warning: Could not load .env file: $e');
    }
  }

  // Initialize Firebase with platform-specific options and error handling
  if (kDebugMode) {
    debugPrint('⏳ Initializing Firebase...');
  }
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(
      const Duration(seconds: 8),
      onTimeout: () {
        if (kDebugMode) {
          debugPrint('⚠️ Warning: Firebase initialization timed out');
        }
        throw TimeoutException('Firebase timeout');
      },
    );
    if (kDebugMode) {
      debugPrint('✓ Firebase initialized');
    }
  } catch (e) {
    // Firebase may fail on web without proper config - app can still function
    if (kDebugMode) {
      debugPrint('⚠️ Warning: Firebase initialization failed: $e');
    }
  }

  // Initialize Supabase with values from .env
  if (kDebugMode) {
    debugPrint('⏳ Initializing Supabase...');
  }

  try {
    if (!isRunningTests) {
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? 'https://placeholder.supabase.co',
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'placeholder-key',
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          if (kDebugMode) {
            debugPrint('⚠️ Warning: Supabase initialization timed out');
          }
          throw TimeoutException('Supabase timeout');
        },
      );
      if (kDebugMode) {
        debugPrint('✓ Supabase initialized');
      }
    } else {
      if (kDebugMode) {
        debugPrint('⚠️ Supabase initialization skipped in tests');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('⚠️ Warning: Supabase initialization failed: $e');
    }
  }

  // Initialize Crashlytics (mobile only)
  if (!kIsWeb) {
    try {
      // Pass all uncaught Flutter errors to Crashlytics
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      // Pass all uncaught async errors to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      // Disable collection in debug mode
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
        !kDebugMode,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Warning: Crashlytics initialization failed: $e');
      }
    }
  }

  // Initialize glossary cache asynchronously (don't block first paint)
  // This runs in the background while the app loads
  Future.microtask(() => GlossaryCache().initialize());

  // Initialize local storage with timeout for web
  if (kDebugMode) {
    debugPrint('⏳ Initializing Storage...');
  }
  try {
    await StorageService.initialize().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        if (kDebugMode) {
          debugPrint('⚠️ Warning: Storage initialization timed out');
        }
      },
    );
    if (kDebugMode) {
      debugPrint('✓ Storage initialized');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('⚠️ Warning: Storage initialization failed: $e');
    }
  }

  // Initialize admin services (non-blocking on web)
  if (!kIsWeb) {
    await AdminAuthService.initialize();
    await AdminAnalyticsService.initialize();
  } else {
    // Initialize admin services in background on web
    Future.microtask(() async {
      await AdminAuthService.initialize();
      await AdminAnalyticsService.initialize();
    });
  }

  // Load saved settings with defaults
  final savedLanguage = StorageService.loadLanguage();
  final savedThemeMode = StorageService.loadThemeMode();
  final savedOnboardingComplete = StorageService.loadOnboardingComplete();
  final savedProfile = StorageService.loadUserProfile();

  // Initialize notifications (only on mobile platforms)
  if (!kIsWeb) {
    await NotificationService().initialize();
  }

  // Initialize ads (only on mobile platforms)
  if (!kIsWeb) {
    final adService = AdService();
    await adService.initialize();
  }

  if (kDebugMode) {
    debugPrint('🎨 Starting Flutter app...');
  }

  runApp(
    ProviderScope(
      overrides: [
        languageProvider.overrideWith((ref) => savedLanguage),
        themeModeProvider.overrideWith((ref) => savedThemeMode),
        onboardingCompleteProvider.overrideWith(
          (ref) => savedOnboardingComplete,
        ),
        if (savedProfile != null)
          userProfileProvider.overrideWith(
            () => _InitializedUserProfileNotifier(savedProfile),
          ),
      ],
      child: const VenusOneApp(),
    ),
  );

  if (kDebugMode) {
    debugPrint('✅ Venus One: Initialization complete!');
  }
}

/// Notifier that starts with an initial profile
class _InitializedUserProfileNotifier extends UserProfileNotifier {
  final UserProfile _initialProfile;

  _InitializedUserProfileNotifier(this._initialProfile);

  @override
  UserProfile? build() => _initialProfile;
}

class VenusOneApp extends ConsumerWidget {
  const VenusOneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'Venus One',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      locale: language.locale,
      supportedLocales: AppLanguage.values.map((l) => l.locale).toList(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        // Apply RTL direction for Arabic
        return Directionality(
          textDirection: language.isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
