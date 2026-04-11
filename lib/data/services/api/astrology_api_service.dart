import 'api_client.dart';
import 'chart_api_service.dart';
import 'planets_api_service.dart';
import 'horoscope_api_service.dart';
import 'compatibility_api_service.dart';
import 'ephemeris_api_service.dart';

export 'api_client.dart';
export 'chart_api_service.dart';
export 'planets_api_service.dart';
export 'horoscope_api_service.dart';
export 'compatibility_api_service.dart';
export 'ephemeris_api_service.dart';

/// Main astrology API service that combines all domain-specific services
class AstrologyApiService {
  final ApiClient _client;

  late final ChartApiService charts;
  late final PlanetsApiService planets;
  late final HoroscopeApiService horoscopes;
  late final CompatibilityApiService compatibility;
  late final EphemerisApiService ephemeris;

  AstrologyApiService({String? baseUrl, ApiClient? client})
    : _client = client ?? ApiClient(baseUrl: baseUrl) {
    charts = ChartApiService(_client);
    planets = PlanetsApiService(_client);
    horoscopes = HoroscopeApiService(_client);
    compatibility = CompatibilityApiService(_client);
    ephemeris = EphemerisApiService(_client);
  }

  /// Set auth token for authenticated requests
  void setAuthToken(String? token) {
    _client.setAuthToken(token);
  }

  /// Dispose the HTTP client
  void dispose() {
    _client.dispose();
  }
}
