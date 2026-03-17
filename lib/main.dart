import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_typography.dart';
import 'shared/widgets/gradient_text.dart';
import 'shared/services/router_service.dart';
import 'shared/widgets/app_error_widget.dart';
import 'package:go_router/go_router.dart';
import 'core/constants/routes.dart';
import 'data/services/auth_service.dart';
import 'data/services/notification_service.dart' show navigatorKey;
import 'data/services/web_error_service.dart';
import 'data/services/sync_service.dart';
import 'data/services/error_reporting_service.dart';
import 'data/providers/app_providers.dart';
import 'data/services/premium_service.dart';
import 'data/models/user_profile.dart';
import 'core/app_initializer_service.dart';
import 'data/services/performance_monitor_service.dart';

// ═══════════════════════════════════════════════════════════════════════════
// SAFE STARTUP PATTERN - Prevents white screen on Flutter Web
// Key: runApp() is called IMMEDIATELY, async init happens INSIDE widget tree
// ═══════════════════════════════════════════════════════════════════════════

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Track startup performance
  PerformanceMonitorService.markAppStart();

  // Setup error handling FIRST
  _setupGlobalErrorHandling();

  // Run app IMMEDIATELY - NO async before this point
  // This ensures Flutter Web always renders something
  runApp(const BootstrapApp());
}

// ═══════════════════════════════════════════════════════════════════════════
// BOOTSTRAP APP - Crash-proof entry point
// ═══════════════════════════════════════════════════════════════════════════

class BootstrapApp extends StatelessWidget {
  const BootstrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Minimal wrapper — NO MaterialApp here.
    // InnerCyclesApp provides the single MaterialApp.router.
    return Theme(
      data: AppTheme.dark,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: AppInitializer(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// APP INITIALIZER - Handles all async init with FutureBuilder
// ═══════════════════════════════════════════════════════════════════════════

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer>
    with TickerProviderStateMixin {
  late Future<_InitResult> _initFuture;
  bool _initDone = false;
  bool _splashFadingOut = false;
  _InitResult? _cachedResult;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeApp();
  }

  void _onInitComplete(_InitResult result) {
    _cachedResult = result;
    // Keep splash visible 300ms more, then fade out over 500ms
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _splashFadingOut = true);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() => _initDone = true);
      });
    });
  }

  Future<_InitResult> _initializeApp() async {
    final result = await AppInitializerService.initialize();
    return _InitResult(
      language: result.language,
      themeMode: result.themeMode,
      fontSizeScale: result.fontSizeScale,
      onboardingComplete: result.onboardingComplete,
      profile: result.profile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_InitResult>(
      future: _initFuture,
      builder: (context, snapshot) {
        // ERROR STATE - Show error message (never white screen)
        if (snapshot.hasError) {
          return Container(
            color: AppColors.deepSpace,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.warning,
                      size: 64,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'InnerCycles',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                        color: AppColors.error,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Trigger crossfade once init completes
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            _cachedResult == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onInitComplete(snapshot.data!);
          });
        }

        // Show app if splash has fully faded out
        if (_initDone && _cachedResult != null) {
          final result = _cachedResult!;
          PerformanceMonitorService.markAppReady();
          PerformanceMonitorService.startFrameMonitoring();
          AppLanguage.setCurrent(result.language);
          return ProviderScope(
            overrides: [
              languageProvider.overrideWith((ref) => result.language),
              themeModeProvider.overrideWith((ref) => result.themeMode),
              fontSizeScaleProvider.overrideWith((ref) => result.fontSizeScale),
              onboardingCompleteProvider.overrideWith(
                (ref) => result.onboardingComplete,
              ),
              if (result.profile != null)
                userProfileProvider.overrideWith(
                  () => _InitializedUserProfileNotifier(result.profile!),
                ),
            ],
            child: const InnerCyclesApp(),
          );
        }

        // CINEMATIC SPLASH — shown during loading + crossfade out
        return AnimatedOpacity(
          opacity: _splashFadingOut ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: const _CinematicSplash(),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CINEMATIC SPLASH — Animated loading screen
// ═══════════════════════════════════════════════════════════════════════════

class _CinematicSplash extends StatefulWidget {
  const _CinematicSplash();

  @override
  State<_CinematicSplash> createState() => _CinematicSplashState();
}

class _CinematicSplashState extends State<_CinematicSplash>
    with TickerProviderStateMixin {
  late final AnimationController _bgController;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        PlatformDispatcher.instance.accessibilityFeatures.disableAnimations;

    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.3),
              radius: 1.2,
              colors: [
                Color.lerp(
                  AppColors.deepSpace,
                  const Color(0xFF2D241F),
                  _bgController.value,
                )!,
                AppColors.deepSpace,
              ],
            ),
          ),
          child: child,
        );
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo icon with ambient glow
            AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.auroraStart.withValues(
                          alpha: 0.08 + 0.04 * _glowController.value,
                        ),
                        blurRadius: 50 + 20 * _glowController.value,
                        spreadRadius: 8 + 8 * _glowController.value,
                      ),
                    ],
                  ),
                  child: child,
                );
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.amethyst, AppColors.starGold],
                  ),
                ),
                child: const Icon(
                  Icons.self_improvement,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
                .animate(target: reduceMotion ? 1 : 1)
                .fadeIn(
                  delay: reduceMotion ? Duration.zero : 200.ms,
                  duration: reduceMotion ? Duration.zero : 700.ms,
                )
                .scale(
                  begin: reduceMotion ? const Offset(1, 1) : const Offset(0.7, 0.7),
                  curve: Curves.elasticOut,
                  delay: reduceMotion ? Duration.zero : 200.ms,
                  duration: reduceMotion ? Duration.zero : 700.ms,
                ),

            const SizedBox(height: 24),

            // App name
            GradientText(
              'InnerCycles',
              style: AppTypography.displayFont.copyWith(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                letterSpacing: 3,
                height: 1.2,
                decoration: TextDecoration.none,
              ),
              variant: GradientTextVariant.gold,
              textAlign: TextAlign.center,
            )
                .animate(target: reduceMotion ? 1 : 1)
                .fadeIn(
                  delay: reduceMotion ? Duration.zero : 500.ms,
                  duration: reduceMotion ? Duration.zero : 600.ms,
                )
                .slideY(
                  begin: reduceMotion ? 0 : 0.12,
                  delay: reduceMotion ? Duration.zero : 500.ms,
                  duration: reduceMotion ? Duration.zero : 600.ms,
                ),

            const SizedBox(height: 10),

            // Tagline
            Text(
              'Your inner world, written.',
              style: AppTypography.decorativeScript(
                fontSize: 14,
                color: AppColors.textMuted,
              ).copyWith(decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            )
                .animate(target: reduceMotion ? 1 : 1)
                .fadeIn(
                  delay: reduceMotion ? Duration.zero : 800.ms,
                  duration: reduceMotion ? Duration.zero : 500.ms,
                ),

            const SizedBox(height: 48),

            // Loading indicator
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: AppColors.starGold,
                strokeWidth: 2,
              ),
            )
                .animate(target: reduceMotion ? 1 : 1)
                .fadeIn(
                  delay: reduceMotion ? Duration.zero : 1200.ms,
                  duration: reduceMotion ? Duration.zero : 400.ms,
                ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// INIT RESULT - Holds all initialization results
// ═══════════════════════════════════════════════════════════════════════════

class _InitResult {
  final AppLanguage language;
  final ThemeMode themeMode;
  final double fontSizeScale;
  final bool onboardingComplete;
  final UserProfile? profile;

  _InitResult({
    required this.language,
    required this.themeMode,
    required this.fontSizeScale,
    required this.onboardingComplete,
    this.profile,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// NOTIFIER FOR INITIAL PROFILE
// ═══════════════════════════════════════════════════════════════════════════

class _InitializedUserProfileNotifier extends UserProfileNotifier {
  final UserProfile _initialProfile;

  _InitializedUserProfileNotifier(this._initialProfile);

  @override
  UserProfile? build() => _initialProfile;
}

// ═══════════════════════════════════════════════════════════════════════════
// INNERCYCLES APP - Main app widget
// ═══════════════════════════════════════════════════════════════════════════

class InnerCyclesApp extends ConsumerStatefulWidget {
  const InnerCyclesApp({super.key});

  @override
  ConsumerState<InnerCyclesApp> createState() => _InnerCyclesAppState();
}

class _InnerCyclesAppState extends ConsumerState<InnerCyclesApp>
    with WidgetsBindingObserver {
  static const _quickActionChannel =
      MethodChannel('com.venusone.innercycles/quickactions');
  static const _deepLinkChannel =
      MethodChannel('com.venusone.innercycles/deeplink');
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Sync RevenueCat identity with Supabase auth state
    _setupRevenueCatAuthSync();

    // Set global error widget builder ONCE (not on every rebuild)
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return AppErrorWidget(details: details);
    };

    // Listen for iOS Home Screen quick actions (3D Touch / long press)
    _quickActionChannel.setMethodCallHandler((call) async {
      if (call.method == 'quickAction') {
        final action = call.arguments as String?;
        // Delay to ensure router is ready
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        _handleQuickAction(action);
      }
    });

    // Listen for universal link deep links (innercycles.app/invite/:code, /share/:cardId)
    _deepLinkChannel.setMethodCallHandler((call) async {
      if (call.method == 'handleDeepLink') {
        final urlString = call.arguments as String?;
        if (urlString == null) return;
        // Delay to ensure router is ready
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        _handleDeepLink(urlString);
      }
    });
  }

  void _handleQuickAction(String? action) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    switch (action) {
      case 'com.venusone.innercycles.newentry':
        GoRouter.of(ctx).go(Routes.journal);
        break;
      case 'com.venusone.innercycles.checkmood':
        GoRouter.of(ctx).go(Routes.today);
        break;
      case 'com.venusone.innercycles.viewstreak':
        GoRouter.of(ctx).push(Routes.streakStats);
        break;
    }
  }

  /// Handle universal links from innercycles.app
  void _handleDeepLink(String urlString) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;

    final uri = Uri.tryParse(urlString);
    if (uri == null) return;

    final path = uri.path;

    // innercycles.app/invite/ABC123 → /referral?code=ABC123
    if (path.startsWith('/invite/')) {
      final code = path.replaceFirst('/invite/', '');
      if (code.isNotEmpty) {
        GoRouter.of(ctx).push('${Routes.referralProgram}?code=$code');
        return;
      }
    }

    // innercycles.app/share/cardId → /share-cards?cardId=...
    if (path.startsWith('/share/')) {
      final cardId = path.replaceFirst('/share/', '');
      if (cardId.isNotEmpty) {
        GoRouter.of(ctx).push('${Routes.shareCardGallery}?cardId=$cardId');
        return;
      }
    }

    // Fallback: try to navigate to the path directly
    if (path.isNotEmpty && path != '/') {
      GoRouter.of(ctx).push(path);
    }
  }

  /// Sync RevenueCat user identity whenever Supabase auth state changes
  void _setupRevenueCatAuthSync() {
    try {
      if (!AuthService.isSupabaseInitialized) return;
      // If user is already logged in, identify to RevenueCat
      final currentUser = AuthService.currentUser;
      if (currentUser != null) {
        ref.read(premiumProvider.notifier).loginUser(currentUser.id);
      }
      // Listen for future auth changes
      _authSubscription = AuthService.authStateChanges.listen((authState) {
        final event = authState.event;
        if (event == AuthChangeEvent.signedIn && authState.session?.user != null) {
          ref.read(premiumProvider.notifier).loginUser(authState.session!.user.id);
        } else if (event == AuthChangeEvent.signedOut) {
          ref.read(premiumProvider.notifier).logoutUser();
        }
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('RevenueCat auth sync setup failed: $e');
      }
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-verify premium entitlement when returning from background
      ref.read(premiumProvider.notifier).onAppResumed();
      // Trigger full sync (push pending + pull remote changes)
      SyncService.onAppResumed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(languageProvider);
    AppLanguage.setCurrent(language);

    final fontScale = ref.watch(fontSizeScaleProvider);

    return MaterialApp.router(
      title: 'InnerCycles',
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
        // Apply RTL direction for Arabic + font size scaling
        return Directionality(
          textDirection: language.isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(fontScale),
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// GLOBAL ERROR HANDLING
// ═══════════════════════════════════════════════════════════════════════════

void _setupGlobalErrorHandling() {
  // Catch all synchronous Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint('═══════════════════════════════════════════════════════════');
      debugPrint('FLUTTER ERROR CAUGHT:');
      debugPrint('${details.exception}');
      debugPrint('═══════════════════════════════════════════════════════════');
    }

    // Report to ErrorReportingService (Supabase + Slack)
    ErrorReportingService.handleFlutterError(details);

    // Also log to web console if on web
    if (kIsWeb) {
      WebErrorService().logError(details.exception.toString());
    }

    FlutterError.presentError(details);
  };

  // Catch all asynchronous errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      debugPrint('═══════════════════════════════════════════════════════════');
      debugPrint('ASYNC ERROR CAUGHT:');
      debugPrint('$error');
      debugPrint('Stack: $stack');
      debugPrint('═══════════════════════════════════════════════════════════');
    }

    // Report to ErrorReportingService (Supabase + Slack)
    ErrorReportingService.handleAsyncError(error, stack);

    // Also log to web console if on web
    if (kIsWeb) {
      WebErrorService().logError(error.toString());
    }

    return true;
  };

  if (kDebugMode) {
    debugPrint('✓ Global error handling initialized');
  }
}
