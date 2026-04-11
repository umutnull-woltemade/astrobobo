import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api/astrology_api_service.dart';

/// Provider for the main astrology API service
final astrologyApiProvider = Provider<AstrologyApiService>((ref) {
  final service = AstrologyApiService(
    // Use environment-based URL in production
    // For development, defaults to localhost:3000/api
    baseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:3000/api',
    ),
  );

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

/// Provider for chart API service
final chartApiProvider = Provider<ChartApiService>((ref) {
  return ref.watch(astrologyApiProvider).charts;
});

/// Provider for planets API service
final planetsApiProvider = Provider<PlanetsApiService>((ref) {
  return ref.watch(astrologyApiProvider).planets;
});

/// Provider for horoscope API service
final horoscopeApiProvider = Provider<HoroscopeApiService>((ref) {
  return ref.watch(astrologyApiProvider).horoscopes;
});

/// Provider for compatibility API service
final compatibilityApiProvider = Provider<CompatibilityApiService>((ref) {
  return ref.watch(astrologyApiProvider).compatibility;
});

/// Provider for ephemeris API service
final ephemerisApiProvider = Provider<EphemerisApiService>((ref) {
  return ref.watch(astrologyApiProvider).ephemeris;
});

// ============================================================================
// Data Providers (for fetching and caching data)
// ============================================================================

/// Current planetary positions
final currentPlanetPositionsProvider = FutureProvider<List<PlanetPositionDto>>((
  ref,
) async {
  final api = ref.watch(planetsApiProvider);
  final response = await api.getCurrentPositions();
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch planet positions');
});

/// Current moon phase
final currentMoonPhaseProvider = FutureProvider<MoonPhaseDto>((ref) async {
  final api = ref.watch(planetsApiProvider);
  final response = await api.getMoonPhase();
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch moon phase');
});

/// Currently retrograde planets
final retrogradesPlanetProvider = FutureProvider<List<RetrogradeDto>>((
  ref,
) async {
  final api = ref.watch(planetsApiProvider);
  final response = await api.getRetrogrades();
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch retrogrades');
});

/// Daily horoscope for a specific sign
final dailyHoroscopeProvider = FutureProvider.family<HoroscopeDto, String>((
  ref,
  sign,
) async {
  final api = ref.watch(horoscopeApiProvider);
  // Get locale for language
  final language = 'en'; // TODO: Get from app locale
  final response = await api.getDailyHoroscope(sign, language: language);
  if (response.isSuccess && response.data != null) {
    return response.data!;
  }
  throw Exception(response.error ?? 'Failed to fetch horoscope');
});

/// Sign compatibility
final signCompatibilityProvider =
    FutureProvider.family<SignCompatibilityDto, ({String sign1, String sign2})>(
      (ref, params) async {
        final api = ref.watch(compatibilityApiProvider);
        final response = await api.calculateSignCompatibility(
          sign1: params.sign1,
          sign2: params.sign2,
        );
        if (response.isSuccess && response.data != null) {
          return response.data!;
        }
        throw Exception(response.error ?? 'Failed to calculate compatibility');
      },
    );
