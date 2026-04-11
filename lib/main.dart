import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'shared/services/router_service.dart';
import 'shared/widgets/interpretive_text.dart';
import 'shared/widgets/app_error_widget.dart';
import 'data/services/ad_service.dart';
import 'data/services/storage_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/admin_auth_service.dart';
import 'data/services/admin_analytics_service.dart';
import 'data/services/web_error_service.dart';
import 'data/providers/app_providers.dart';
import 'data/models/user_profile.dart';

/// Print to browser console even in release mode
void _webLog(String msg) {
  // ignore: avoid_print
  if (kIsWeb) print('[VenusOne] $msg');
  if (kDebugMode) debugPrint(msg);
}

void main() {
  // ══════════════════════════════════════════════════════════════════
  // ZONE GUARD: Catches ALL uncaught async errors in the entire app.
  // Without this, async errors crash silently on web → white screen.
  // ══════════════════════════════════════════════════════════════════
  runZonedGuarded(
    () async {
      try {
        await _initializeAndRunApp();
      } catch (e, stack) {
        _webLog('FATAL INIT: $e');
        debugPrint('Stack: $stack');
        _runFallbackApp('Başlatma hatası: $e');
      }
    },
    (error, stack) {
      _webLog('UNCAUGHT ZONE ERROR: $error');
      debugPrint('ZONE ERROR: $error\n$stack');
    },
  );
}

Future<void> _initializeAndRunApp() async {
  _webLog('Starting initialization...');

  WidgetsFlutterBinding.ensureInitialized();

  // ══════════════════════════════════════════════════════════════════
  // ERROR HANDLING: Set up BEFORE anything else can fail.
  // ErrorWidget.builder makes build() errors visible in release mode.
  // Without this, release mode shows NOTHING on build error → white.
  // ══════════════════════════════════════════════════════════════════
  ErrorWidget.builder = (FlutterErrorDetails details) {
    _webLog('WIDGET BUILD ERROR: ${details.exception}');
    return Material(
      color: const Color(0xFF0D0D1A),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Color(0xFFFFD700),
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Venus One',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Bir bileşen yüklenemedi.\n${details.exception}',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  };

  FlutterError.onError = (FlutterErrorDetails details) {
    _webLog('FLUTTER ERROR: ${details.exception}');
    if (kDebugMode) FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    _webLog('PLATFORM ERROR: $error');
    return true;
  };

  // Load environment variables
  try {
    await dotenv.load(fileName: 'assets/.env');
    _webLog('ENV loaded');
  } catch (e) {
    _webLog('ENV skip: $e');
  }

  // Initialize Supabase (MOBILE ONLY — web skips entirely)
  if (!kIsWeb) {
    try {
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? 'https://placeholder.supabase.co',
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'placeholder-key',
      ).timeout(const Duration(seconds: 5));
    } catch (e) {
      debugPrint('⚠️ Supabase init failed: $e');
    }
  }

  // Glossary cache (MOBILE ONLY)
  if (!kIsWeb) {
    Future.microtask(() => GlossaryCache().initialize());
  }

  // Initialize local storage
  try {
    await StorageService.initialize().timeout(const Duration(seconds: 10));
    _webLog('Storage OK');
  } catch (e) {
    _webLog('Storage skip: $e');
  }

  // Admin services (MOBILE ONLY)
  if (!kIsWeb) {
    try {
      await AdminAuthService.initialize().timeout(const Duration(seconds: 5));
    } catch (_) {}
    try {
      await AdminAnalyticsService.initialize().timeout(
        const Duration(seconds: 5),
      );
    } catch (_) {}
  }

  // Load saved settings (returns safe defaults on web)
  final savedLanguage = StorageService.loadLanguage();
  final savedThemeMode = StorageService.loadThemeMode();
  final savedOnboardingComplete = StorageService.loadOnboardingComplete();
  final savedProfile = StorageService.loadUserProfile();

  _webLog(
    'Settings: lang=$savedLanguage theme=$savedThemeMode onboarding=$savedOnboardingComplete profile=${savedProfile != null}',
  );

  // Notifications & ads (MOBILE ONLY)
  if (!kIsWeb) {
    await NotificationService().initialize();
    final adService = AdService();
    await adService.initialize();
  }

  _webLog('Launching app...');

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

  _webLog('runApp() called — waiting for first frame...');
}

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
    _webLog('VenusOneApp.build() called');

    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(languageProvider);

    _webLog('Providers read OK: theme=$themeMode lang=${language.name}');

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
        return Directionality(
          textDirection: language.isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

void _runFallbackApp(String errorMessage) {
  _webLog('FALLBACK APP: $errorMessage');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0D0D1A),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.amber,
                    size: 64,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Venus One',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Uygulama yüklenirken bir hata oluştu.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
