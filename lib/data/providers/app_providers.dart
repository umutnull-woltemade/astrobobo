import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../models/zodiac_sign.dart' as zodiac;
import '../models/horoscope.dart';
import '../models/house.dart';
import '../services/horoscope_service.dart';
import '../services/api/astrology_api_service.dart';
import '../services/storage_service.dart';

// User profile state using Notifier (Riverpod 2.x+)
final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfile?>(
  () {
    return UserProfileNotifier();
  },
);

class UserProfileNotifier extends Notifier<UserProfile?> {
  @override
  UserProfile? build() => null;

  void setProfile(UserProfile profile) {
    state = profile;
    _syncToStorage(profile);
  }

  void clearProfile() {
    state = null;
  }

  void updateBirthDate(DateTime date) {
    if (state != null) {
      final updated = state!.copyWith(
        birthDate: date,
        sunSign: zodiac.ZodiacSignExtension.fromDate(date),
      );
      state = updated;
      _syncToStorage(updated);
    }
  }

  void _syncToStorage(UserProfile profile) {
    StorageService.saveUserProfile(profile);
    ref.read(savedProfilesProvider.notifier).updateProfile(profile);
  }
}

// Multiple profiles provider
final savedProfilesProvider =
    NotifierProvider<SavedProfilesNotifier, List<UserProfile>>(() {
      return SavedProfilesNotifier();
    });

class SavedProfilesNotifier extends Notifier<List<UserProfile>> {
  @override
  List<UserProfile> build() {
    return StorageService.loadAllProfiles();
  }

  Future<void> addProfile(UserProfile profile) async {
    await StorageService.saveProfile(profile);
    state = StorageService.loadAllProfiles();
  }

  Future<void> updateProfile(UserProfile profile) async {
    await StorageService.saveProfile(profile);
    state = StorageService.loadAllProfiles();
  }

  Future<void> removeProfile(String id) async {
    await StorageService.deleteProfile(id);
    state = StorageService.loadAllProfiles();
  }

  Future<void> setPrimary(String id) async {
    await StorageService.setPrimaryProfileId(id);
    final profiles = state.map((p) {
      return p.copyWith(isPrimary: p.id == id);
    }).toList();
    state = profiles;
  }

  void refresh() {
    state = StorageService.loadAllProfiles();
  }
}

final primaryProfileProvider = Provider<UserProfile?>((ref) {
  final profiles = ref.watch(savedProfilesProvider);
  final primaryId = StorageService.getPrimaryProfileId();

  if (primaryId != null) {
    final primary = profiles.where((p) => p.id == primaryId).firstOrNull;
    if (primary != null) return primary;
  }

  return profiles.isNotEmpty ? profiles.first : null;
});

// Comparison profiles selection
final comparisonProfile1Provider = StateProvider<UserProfile?>((ref) => null);
final comparisonProfile2Provider = StateProvider<UserProfile?>((ref) => null);

// Selected zodiac sign for viewing
final selectedZodiacProvider = StateProvider<zodiac.ZodiacSign?>((ref) => null);

// Daily horoscope for a sign
final dailyHoroscopeProvider =
    Provider.family<DailyHoroscope, zodiac.ZodiacSign>((ref, sign) {
      return HoroscopeService.generateDailyHoroscope(sign, DateTime.now());
    });

// Compatibility between two signs
final compatibilityProvider =
    Provider.family<Compatibility, (zodiac.ZodiacSign, zodiac.ZodiacSign)>((
      ref,
      signs,
    ) {
      return HoroscopeService.calculateCompatibility(signs.$1, signs.$2);
    });

// Selected signs for compatibility checker
final compatibilitySign1Provider = StateProvider<zodiac.ZodiacSign?>(
  (ref) => null,
);
final compatibilitySign2Provider = StateProvider<zodiac.ZodiacSign?>(
  (ref) => null,
);

// Onboarding completed flag
final onboardingCompleteProvider = StateProvider<bool>((ref) => false);

// Bottom navigation index
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Language provider - supports multiple languages
enum AppLanguage {
  en, // English
  tr, // Türkçe
  el, // Ελληνικά (Greek)
  bg, // Български (Bulgarian)
  ru, // Русский (Russian)
  zh, // 中文 (Chinese)
  fr, // Français (French)
  de, // Deutsch (German)
  es, // Español (Spanish)
  ar, // العربية (Arabic - RTL)
}

extension AppLanguageExtension on AppLanguage {
  String get displayName {
    switch (this) {
      case AppLanguage.en:
        return 'English';
      case AppLanguage.tr:
        return 'Türkçe';
      case AppLanguage.el:
        return 'Ελληνικά';
      case AppLanguage.bg:
        return 'Български';
      case AppLanguage.ru:
        return 'Русский';
      case AppLanguage.zh:
        return '中文';
      case AppLanguage.fr:
        return 'Français';
      case AppLanguage.de:
        return 'Deutsch';
      case AppLanguage.es:
        return 'Español';
      case AppLanguage.ar:
        return 'العربية';
    }
  }

  String get flag {
    switch (this) {
      case AppLanguage.en:
        return '🇬🇧';
      case AppLanguage.tr:
        return '🇹🇷';
      case AppLanguage.el:
        return '🇬🇷';
      case AppLanguage.bg:
        return '🇧🇬';
      case AppLanguage.ru:
        return '🇷🇺';
      case AppLanguage.zh:
        return '🇨🇳';
      case AppLanguage.fr:
        return '🇫🇷';
      case AppLanguage.de:
        return '🇩🇪';
      case AppLanguage.es:
        return '🇪🇸';
      case AppLanguage.ar:
        return '🇸🇦';
    }
  }

  bool get isRTL => this == AppLanguage.ar;

  Locale get locale {
    switch (this) {
      case AppLanguage.en:
        return const Locale('en', 'US');
      case AppLanguage.tr:
        return const Locale('tr', 'TR');
      case AppLanguage.el:
        return const Locale('el', 'GR');
      case AppLanguage.bg:
        return const Locale('bg', 'BG');
      case AppLanguage.ru:
        return const Locale('ru', 'RU');
      case AppLanguage.zh:
        return const Locale('zh', 'CN');
      case AppLanguage.fr:
        return const Locale('fr', 'FR');
      case AppLanguage.de:
        return const Locale('de', 'DE');
      case AppLanguage.es:
        return const Locale('es', 'ES');
      case AppLanguage.ar:
        return const Locale('ar', 'SA');
    }
  }
}

final languageProvider = StateProvider<AppLanguage>((ref) => AppLanguage.tr);

// Theme mode provider - default is dark
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

// House system provider - persisted to storage, default is Placidus
final houseSystemProvider = StateProvider<HouseSystem>((ref) {
  final index = StorageService.loadHouseSystemIndex();
  if (index >= 0 && index < HouseSystem.values.length) {
    return HouseSystem.values[index];
  }
  return HouseSystem.placidus;
});

// =============================================================================
// API Integration Providers
// =============================================================================

/// Main API service provider
final astrologyApiProvider = Provider<AstrologyApiService>((ref) {
  final service = AstrologyApiService(
    baseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:3000/api',
    ),
  );
  ref.onDispose(() => service.dispose());
  return service;
});

/// Current planet positions from API
final currentPlanetsProvider = FutureProvider<List<PlanetPositionDto>>((
  ref,
) async {
  final api = ref.watch(astrologyApiProvider);
  final response = await api.planets.getCurrentPositions();
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch planets');
});

/// Current moon phase from API
final moonPhaseProvider = FutureProvider<MoonPhaseDto>((ref) async {
  final api = ref.watch(astrologyApiProvider);
  final response = await api.planets.getMoonPhase();
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch moon phase');
});

/// Retrograde planets from API
final retrogradesProvider = FutureProvider<List<RetrogradeDto>>((ref) async {
  final api = ref.watch(astrologyApiProvider);
  final response = await api.planets.getRetrogrades();
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch retrogrades');
});

/// Sign compatibility from API
final apiCompatibilityProvider =
    FutureProvider.family<SignCompatibilityDto, ({String sign1, String sign2})>(
      (ref, params) async {
        final api = ref.watch(astrologyApiProvider);
        final response = await api.compatibility.calculateSignCompatibility(
          sign1: params.sign1,
          sign2: params.sign2,
        );
        if (response.isSuccess && response.data != null) {
          return response.data!;
        }
        throw Exception(response.error ?? 'Failed to calculate compatibility');
      },
    );
