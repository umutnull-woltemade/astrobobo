import '../../../data/models/birth_chart.dart';
import '../../../data/models/planet.dart';
import '../../../data/models/zodiac_sign.dart';
import 'api_client.dart';

/// API service for chart-related endpoints
class ChartApiService {
  final ApiClient _client;

  ChartApiService(this._client);

  /// Create a birth profile
  Future<ApiResponse<BirthProfileResponse>> createBirthProfile({
    required String name,
    required DateTime birthDate,
    String? birthTime,
    required double latitude,
    required double longitude,
    required String timezone,
    String? locationName,
  }) async {
    return _client.post<BirthProfileResponse>(
      '/charts/profiles',
      body: {
        'name': name,
        'birthDate': birthDate.toIso8601String().split('T')[0],
        'birthTime': birthTime,
        'latitude': latitude,
        'longitude': longitude,
        'timezone': timezone,
        'locationName': locationName,
        'birthTimeUnknown': birthTime == null,
      },
      fromJson: (json) => BirthProfileResponse.fromJson(json),
    );
  }

  /// Get birth profile by ID
  Future<ApiResponse<BirthProfileResponse>> getBirthProfile(String id) async {
    return _client.get<BirthProfileResponse>(
      '/charts/profiles/$id',
      fromJson: (json) => BirthProfileResponse.fromJson(json),
    );
  }

  /// Calculate natal chart
  Future<ApiResponse<ChartResponse>> calculateNatalChart({
    required String birthProfileId,
    String houseSystem = 'placidus',
  }) async {
    return _client.post<ChartResponse>(
      '/charts/natal',
      body: {'birthProfileId': birthProfileId, 'houseSystem': houseSystem},
      fromJson: (json) => ChartResponse.fromJson(json),
    );
  }

  /// Calculate natal chart with inline birth data
  Future<ApiResponse<ChartResponse>> calculateNatalChartDirect({
    required DateTime birthDate,
    String? birthTime,
    required double latitude,
    required double longitude,
    required String timezone,
    String houseSystem = 'placidus',
  }) async {
    return _client.post<ChartResponse>(
      '/charts/natal',
      body: {
        'birthData': {
          'birthDate': birthDate.toIso8601String().split('T')[0],
          'birthTime': birthTime,
          'birthTimeKnown': birthTime != null,
          'latitude': latitude,
          'longitude': longitude,
          'timezone': timezone,
        },
        'houseSystem': houseSystem,
      },
      fromJson: (json) => ChartResponse.fromJson(json),
    );
  }

  /// Calculate transit chart
  Future<ApiResponse<ChartResponse>> calculateTransitChart({
    required String natalChartId,
    DateTime? transitDate,
  }) async {
    return _client.post<ChartResponse>(
      '/charts/transit',
      body: {
        'natalChartId': natalChartId,
        'transitDate':
            transitDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      },
      fromJson: (json) => ChartResponse.fromJson(json),
    );
  }

  /// Calculate synastry chart between two people
  Future<ApiResponse<ChartResponse>> calculateSynastryChart({
    required String person1ProfileId,
    required String person2ProfileId,
  }) async {
    return _client.post<ChartResponse>(
      '/charts/synastry',
      body: {
        'person1ProfileId': person1ProfileId,
        'person2ProfileId': person2ProfileId,
      },
      fromJson: (json) => ChartResponse.fromJson(json),
    );
  }

  /// Get chart by ID
  Future<ApiResponse<ChartResponse>> getChart(String id) async {
    return _client.get<ChartResponse>(
      '/charts/$id',
      fromJson: (json) => ChartResponse.fromJson(json),
    );
  }

  /// Delete a chart
  Future<ApiResponse<void>> deleteChart(String id) async {
    return _client.delete('/charts/$id');
  }
}

/// Birth profile response from API
class BirthProfileResponse {
  final String id;
  final String name;
  final String birthDate;
  final String? birthTime;
  final bool birthTimeUnknown;
  final double latitude;
  final double longitude;
  final String timezone;
  final String? locationName;

  BirthProfileResponse({
    required this.id,
    required this.name,
    required this.birthDate,
    this.birthTime,
    required this.birthTimeUnknown,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    this.locationName,
  });

  factory BirthProfileResponse.fromJson(Map<String, dynamic> json) {
    return BirthProfileResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      birthDate: json['birthDate'] as String,
      birthTime: json['birthTime'] as String?,
      birthTimeUnknown: json['birthTimeUnknown'] as bool? ?? true,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String,
      locationName: json['locationName'] as String?,
    );
  }
}

/// Chart response from API
class ChartResponse {
  final String id;
  final String chartType;
  final Map<String, dynamic> chartData;
  final DateTime calculatedAt;

  ChartResponse({
    required this.id,
    required this.chartType,
    required this.chartData,
    required this.calculatedAt,
  });

  factory ChartResponse.fromJson(Map<String, dynamic> json) {
    return ChartResponse(
      id: json['id'] as String,
      chartType: json['chartType'] as String,
      chartData: json['chartData'] as Map<String, dynamic>,
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );
  }

  /// Convert API response to Flutter BirthChart model
  BirthChart toBirthChart({
    required String name,
    required DateTime birthDateTime,
    required double latitude,
    required double longitude,
    required String locationName,
  }) {
    final planets = _parsePlanets(chartData['planets']);
    final houses = _parseHouses(chartData['houses']);
    final aspects = _parseAspects(chartData['aspects']);

    // Find sun, moon, and ascendant signs
    final sunPosition = planets.firstWhere(
      (p) => p.planet == Planet.sun,
      orElse: () => PlanetPosition(planet: Planet.sun, longitude: 0),
    );
    final moonPosition = planets.firstWhere(
      (p) => p.planet == Planet.moon,
      orElse: () => PlanetPosition(planet: Planet.moon, longitude: 0),
    );
    final ascendantHouse = houses.firstWhere(
      (h) => h.houseNumber == 1,
      orElse: () => HousePosition(houseNumber: 1, signIndex: 0, cuspDegree: 0),
    );

    return BirthChart(
      id: id,
      name: name,
      birthDateTime: birthDateTime,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
      sunSign: sunPosition.sign,
      moonSign: moonPosition.sign,
      ascendant: ZodiacSign.values[ascendantHouse.signIndex],
      planetPositions: planets,
      houses: houses,
      aspects: aspects,
      calculatedAt: calculatedAt,
    );
  }

  List<PlanetPosition> _parsePlanets(dynamic planetsData) {
    if (planetsData == null) return [];

    final planets = <PlanetPosition>[];
    if (planetsData is List) {
      for (final p in planetsData) {
        final planet = _stringToPlanet(p['name'] as String?);
        if (planet != null) {
          planets.add(
            PlanetPosition(
              planet: planet,
              longitude: (p['longitude'] as num?)?.toDouble() ?? 0,
              latitude: (p['latitude'] as num?)?.toDouble() ?? 0,
              isRetrograde: p['retrograde'] as bool? ?? false,
              house: p['house'] as int? ?? 1,
            ),
          );
        }
      }
    } else if (planetsData is Map) {
      planetsData.forEach((key, value) {
        final planet = _stringToPlanet(key as String);
        if (planet != null && value is Map) {
          planets.add(
            PlanetPosition(
              planet: planet,
              longitude: (value['longitude'] as num?)?.toDouble() ?? 0,
              latitude: (value['latitude'] as num?)?.toDouble() ?? 0,
              isRetrograde: value['retrograde'] as bool? ?? false,
              house: value['house'] as int? ?? 1,
            ),
          );
        }
      });
    }
    return planets;
  }

  List<HousePosition> _parseHouses(dynamic housesData) {
    if (housesData == null) return [];

    final houses = <HousePosition>[];
    if (housesData is Map && housesData['cusps'] is List) {
      final cusps = housesData['cusps'] as List;
      for (int i = 0; i < cusps.length && i < 12; i++) {
        final cusp = cusps[i];
        final degree = cusp is num
            ? cusp.toDouble()
            : (cusp['degree'] as num?)?.toDouble() ?? (i * 30.0);
        houses.add(
          HousePosition(
            houseNumber: i + 1,
            signIndex: (degree / 30).floor() % 12,
            cuspDegree: degree,
          ),
        );
      }
    } else if (housesData is List) {
      for (int i = 0; i < housesData.length && i < 12; i++) {
        final h = housesData[i];
        houses.add(
          HousePosition(
            houseNumber: i + 1,
            signIndex: (h['cusp'] as num?)?.toInt() ?? 0,
            cuspDegree: (h['degree'] as num?)?.toDouble() ?? (i * 30.0),
          ),
        );
      }
    }
    return houses;
  }

  List<Aspect> _parseAspects(dynamic aspectsData) {
    if (aspectsData == null) return [];

    final aspects = <Aspect>[];
    if (aspectsData is List) {
      for (final a in aspectsData) {
        final planet1 = _stringToPlanet(a['planet1'] as String?);
        final planet2 = _stringToPlanet(a['planet2'] as String?);
        final aspectType = _stringToAspectType(
          a['aspect'] as String? ?? a['aspectType'] as String?,
        );

        if (planet1 != null && planet2 != null && aspectType != null) {
          aspects.add(
            Aspect(
              planet1: planet1,
              planet2: planet2,
              type: aspectType,
              exactAngle:
                  (a['exactAngle'] as num?)?.toDouble() ??
                  aspectType.angle.toDouble(),
              orb: (a['orb'] as num?)?.toDouble() ?? 0,
            ),
          );
        }
      }
    }
    return aspects;
  }

  Planet? _stringToPlanet(String? name) {
    if (name == null) return null;
    final normalized = name.toLowerCase().replaceAll(' ', '');
    return switch (normalized) {
      'sun' => Planet.sun,
      'moon' => Planet.moon,
      'mercury' => Planet.mercury,
      'venus' => Planet.venus,
      'mars' => Planet.mars,
      'jupiter' => Planet.jupiter,
      'saturn' => Planet.saturn,
      'uranus' => Planet.uranus,
      'neptune' => Planet.neptune,
      'pluto' => Planet.pluto,
      'northnode' || 'truenode' => Planet.northNode,
      'southnode' => Planet.southNode,
      'chiron' => Planet.chiron,
      'lilith' || 'meanlilith' => Planet.lilith,
      'ascendant' || 'asc' => Planet.ascendant,
      'midheaven' || 'mc' => Planet.midheaven,
      'ic' => Planet.ic,
      'descendant' || 'dsc' => Planet.descendant,
      _ => null,
    };
  }

  AspectType? _stringToAspectType(String? name) {
    if (name == null) return null;
    return switch (name.toLowerCase()) {
      'conjunction' => AspectType.conjunction,
      'sextile' => AspectType.sextile,
      'square' => AspectType.square,
      'trine' => AspectType.trine,
      'opposition' => AspectType.opposition,
      _ => null,
    };
  }
}
