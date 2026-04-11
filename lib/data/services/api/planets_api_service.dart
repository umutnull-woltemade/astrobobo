import 'api_client.dart';

/// API service for planet-related endpoints
class PlanetsApiService {
  final ApiClient _client;

  PlanetsApiService(this._client);

  /// Get current planetary positions
  Future<ApiResponse<List<PlanetPositionDto>>> getCurrentPositions() async {
    return _client.get<List<PlanetPositionDto>>(
      '/planets/current',
      fromJson: (json) =>
          (json as List).map((p) => PlanetPositionDto.fromJson(p)).toList(),
    );
  }

  /// Get planetary positions for a specific date
  Future<ApiResponse<PlanetPositionsResponse>> getPositions({
    DateTime? date,
  }) async {
    return _client.get<PlanetPositionsResponse>(
      '/planets/positions',
      queryParams: date != null ? {'date': date.toIso8601String()} : null,
      fromJson: (json) => PlanetPositionsResponse.fromJson(json),
    );
  }

  /// Get current moon phase
  Future<ApiResponse<MoonPhaseDto>> getMoonPhase({DateTime? date}) async {
    return _client.get<MoonPhaseDto>(
      '/planets/moon-phase',
      queryParams: date != null ? {'date': date.toIso8601String()} : null,
      fromJson: (json) => MoonPhaseDto.fromJson(json),
    );
  }

  /// Get currently retrograde planets
  Future<ApiResponse<List<RetrogradeDto>>> getRetrogrades() async {
    return _client.get<List<RetrogradeDto>>(
      '/planets/retrogrades',
      fromJson: (json) =>
          (json as List).map((p) => RetrogradeDto.fromJson(p)).toList(),
    );
  }

  /// Get planet information
  Future<ApiResponse<List<PlanetInfoDto>>> getPlanetInfo() async {
    return _client.get<List<PlanetInfoDto>>(
      '/planets/info',
      fromJson: (json) =>
          (json as List).map((p) => PlanetInfoDto.fromJson(p)).toList(),
    );
  }

  /// Get zodiac sign information
  Future<ApiResponse<List<SignInfoDto>>> getSignInfo() async {
    return _client.get<List<SignInfoDto>>(
      '/planets/signs',
      fromJson: (json) =>
          (json as List).map((s) => SignInfoDto.fromJson(s)).toList(),
    );
  }
}

class PlanetPositionDto {
  final String name;
  final double longitude;
  final double latitude;
  final double distance;
  final double speed;
  final bool isRetrograde;
  final String sign;
  final int degree;
  final int minute;

  PlanetPositionDto({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.distance,
    required this.speed,
    required this.isRetrograde,
    required this.sign,
    required this.degree,
    required this.minute,
  });

  factory PlanetPositionDto.fromJson(Map<String, dynamic> json) {
    return PlanetPositionDto(
      name: json['name'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      distance: (json['distance'] as num?)?.toDouble() ?? 0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0,
      isRetrograde: json['isRetrograde'] as bool? ?? false,
      sign: json['sign'] as String,
      degree: (json['degree'] as num).toInt(),
      minute: (json['minute'] as num?)?.toInt() ?? 0,
    );
  }
}

class PlanetPositionsResponse {
  final String date;
  final double julianDay;
  final List<PlanetPositionDto> planets;

  PlanetPositionsResponse({
    required this.date,
    required this.julianDay,
    required this.planets,
  });

  factory PlanetPositionsResponse.fromJson(Map<String, dynamic> json) {
    return PlanetPositionsResponse(
      date: json['date'] as String,
      julianDay: (json['julianDay'] as num).toDouble(),
      planets: (json['planets'] as List)
          .map((p) => PlanetPositionDto.fromJson(p))
          .toList(),
    );
  }
}

class MoonPhaseDto {
  final String date;
  final double phase;
  final double illumination;
  final double age;
  final String phaseName;

  MoonPhaseDto({
    required this.date,
    required this.phase,
    required this.illumination,
    required this.age,
    required this.phaseName,
  });

  factory MoonPhaseDto.fromJson(Map<String, dynamic> json) {
    return MoonPhaseDto(
      date: json['date'] as String,
      phase: (json['phase'] as num).toDouble(),
      illumination: (json['illumination'] as num?)?.toDouble() ?? 0,
      age: (json['age'] as num?)?.toDouble() ?? 0,
      phaseName: json['phaseName'] as String,
    );
  }
}

class RetrogradeDto {
  final String name;
  final String sign;
  final int degree;

  RetrogradeDto({required this.name, required this.sign, required this.degree});

  factory RetrogradeDto.fromJson(Map<String, dynamic> json) {
    return RetrogradeDto(
      name: json['name'] as String,
      sign: json['sign'] as String,
      degree: (json['degree'] as num).toInt(),
    );
  }
}

class PlanetInfoDto {
  final String name;
  final String symbol;
  final String element;
  final List<String> keywords;

  PlanetInfoDto({
    required this.name,
    required this.symbol,
    required this.element,
    required this.keywords,
  });

  factory PlanetInfoDto.fromJson(Map<String, dynamic> json) {
    return PlanetInfoDto(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      element: json['element'] as String,
      keywords: List<String>.from(json['keywords'] as List),
    );
  }
}

class SignInfoDto {
  final String name;
  final String element;
  final int startDegree;
  final int endDegree;

  SignInfoDto({
    required this.name,
    required this.element,
    required this.startDegree,
    required this.endDegree,
  });

  factory SignInfoDto.fromJson(Map<String, dynamic> json) {
    return SignInfoDto(
      name: json['name'] as String,
      element: json['element'] as String,
      startDegree: (json['startDegree'] as num).toInt(),
      endDegree: (json['endDegree'] as num).toInt(),
    );
  }
}
