import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:astrology_app/core/runtime_flags.dart' as runtime_flags;

import 'package:astrology_app/data/providers/app_providers.dart';
import 'package:astrology_app/data/models/user_profile.dart';

// ---------------------------------------------------------------------------
// Fake UserProfile for testing
// ---------------------------------------------------------------------------
UserProfile fakeUserProfile({
  String name = 'Test User',
  DateTime? birthDate,
  String? birthTime,
  String? birthPlace,
  bool isPrimary = true,
}) {
  return UserProfile(
    id: 'test-id-001',
    name: name,
    birthDate: birthDate ?? DateTime(1990, 6, 15),
    birthTime: birthTime ?? '14:30',
    birthPlace: birthPlace ?? 'Istanbul',
    birthLatitude: 41.0082,
    birthLongitude: 28.9784,
    isPrimary: isPrimary,
  );
}

// ---------------------------------------------------------------------------
// Test UserProfileNotifier with initial state
// ---------------------------------------------------------------------------
class TestUserProfileNotifier extends UserProfileNotifier {
  final UserProfile? _initial;
  TestUserProfileNotifier([this._initial]);

  @override
  UserProfile? build() => _initial;
}

// ---------------------------------------------------------------------------
// pumpApp — wraps any widget in the same shell the real app uses
// ---------------------------------------------------------------------------
extension PumpApp on WidgetTester {
  /// Pump a single widget inside a fully-configured MaterialApp with Riverpod.
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
    UserProfile? userProfile,
    bool onboardingComplete = true,
    ThemeMode themeMode = ThemeMode.dark,
    AppLanguage language = AppLanguage.tr,
  }) async {
    final profile = userProfile ?? fakeUserProfile();

    // Set test flags to avoid long-running animations and platform integrations
    runtime_flags.disableAnimations = true;
    runtime_flags.isRunningTests = true;

    await pumpWidget(
      ProviderScope(
        overrides: [
          onboardingCompleteProvider.overrideWith((ref) => onboardingComplete),
          themeModeProvider.overrideWith((ref) => themeMode),
          languageProvider.overrideWith((ref) => language),
          userProfileProvider.overrideWith(
            () => TestUserProfileNotifier(profile),
          ),
          savedProfilesProvider.overrideWith(
            () => _TestSavedProfilesNotifier([profile]),
          ),
          ...overrides,
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF7C4DFF),
              brightness: Brightness.dark,
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLanguage.values.map((l) => l.locale).toList(),
          locale: language.locale,
          home: widget,
        ),
      ),
    );
    await pump();
  }

  /// Pump the app with a GoRouter navigating to a specific route.
  Future<void> pumpRoute(
    String initialLocation, {
    required List<RouteBase> routes,
    List<Override> overrides = const [],
    UserProfile? userProfile,
    bool onboardingComplete = true,
  }) async {
    final profile = userProfile ?? fakeUserProfile();

    final router = GoRouter(initialLocation: initialLocation, routes: routes);

    await pumpWidget(
      ProviderScope(
        overrides: [
          onboardingCompleteProvider.overrideWith((ref) => onboardingComplete),
          languageProvider.overrideWith((ref) => AppLanguage.tr),
          themeModeProvider.overrideWith((ref) => ThemeMode.dark),
          userProfileProvider.overrideWith(
            () => TestUserProfileNotifier(profile),
          ),
          savedProfilesProvider.overrideWith(
            () => _TestSavedProfilesNotifier([profile]),
          ),
          ...overrides,
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF7C4DFF),
              brightness: Brightness.dark,
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLanguage.values.map((l) => l.locale).toList(),
          locale: const Locale('tr', 'TR'),
          routerConfig: router,
        ),
      ),
    );
    await pump();
  }
}

// ---------------------------------------------------------------------------
// Internal helpers
// ---------------------------------------------------------------------------
class _TestSavedProfilesNotifier extends SavedProfilesNotifier {
  final List<UserProfile> _initial;
  _TestSavedProfilesNotifier(this._initial);

  @override
  List<UserProfile> build() => _initial;
}

// ---------------------------------------------------------------------------
// Common finders
// ---------------------------------------------------------------------------
Finder findScaffold() => find.byType(Scaffold);
Finder findAppBar() => find.byType(AppBar);
Finder findBackButton() => find.byType(BackButton);
Finder findElevatedButton() => find.byType(ElevatedButton);
Finder findTextButton() => find.byType(TextButton);
Finder findIconButton() => find.byType(IconButton);
Finder findCircularProgress() => find.byType(CircularProgressIndicator);
Finder findListView() => find.byType(ListView);
Finder findSingleChildScrollView() => find.byType(SingleChildScrollView);
