import 'api_client.dart';

/// API service for ephemeris-related endpoints
class EphemerisApiService {
  final ApiClient _client;

  EphemerisApiService(this._client);

  /// Get ephemeris data for a date range
  Future<ApiResponse<EphemerisDataDto>> getEphemeris({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return _client.get<EphemerisDataDto>(
      '/ephemeris',
      queryParams: {
        'startDate': startDate.toIso8601String().split('T')[0],
        'endDate': endDate.toIso8601String().split('T')[0],
      },
      fromJson: (json) => EphemerisDataDto.fromJson(json),
    );
  }

  /// Get retrograde periods for a year
  Future<ApiResponse<List<RetrogradePeriodDto>>> getRetrogradePeriods(
    int year,
  ) async {
    return _client.get<List<RetrogradePeriodDto>>(
      '/ephemeris/retrogrades/$year',
      fromJson: (json) =>
          (json as List).map((r) => RetrogradePeriodDto.fromJson(r)).toList(),
    );
  }

  /// Get sign ingresses for a year
  Future<ApiResponse<List<SignIngressDto>>> getSignIngresses(int year) async {
    return _client.get<List<SignIngressDto>>(
      '/ephemeris/ingresses/$year',
      fromJson: (json) =>
          (json as List).map((i) => SignIngressDto.fromJson(i)).toList(),
    );
  }

  /// Get lunar phases for a month
  Future<ApiResponse<List<LunarPhaseDto>>> getLunarPhases({
    required int year,
    required int month,
  }) async {
    return _client.get<List<LunarPhaseDto>>(
      '/ephemeris/lunar-phases',
      queryParams: {'year': year.toString(), 'month': month.toString()},
      fromJson: (json) =>
          (json as List).map((l) => LunarPhaseDto.fromJson(l)).toList(),
    );
  }

  /// Get eclipses for a year
  Future<ApiResponse<List<EclipseDto>>> getEclipses(int year) async {
    return _client.get<List<EclipseDto>>(
      '/ephemeris/eclipses/$year',
      fromJson: (json) =>
          (json as List).map((e) => EclipseDto.fromJson(e)).toList(),
    );
  }

  /// Get aspect calendar for a month
  Future<ApiResponse<List<AspectEventDto>>> getAspectCalendar({
    required int year,
    required int month,
  }) async {
    return _client.get<List<AspectEventDto>>(
      '/ephemeris/aspects',
      queryParams: {'year': year.toString(), 'month': month.toString()},
      fromJson: (json) =>
          (json as List).map((a) => AspectEventDto.fromJson(a)).toList(),
    );
  }
}

class EphemerisDataDto {
  final DateTime startDate;
  final DateTime endDate;
  final List<DailyPositionsDto> dailyPositions;

  EphemerisDataDto({
    required this.startDate,
    required this.endDate,
    required this.dailyPositions,
  });

  factory EphemerisDataDto.fromJson(Map<String, dynamic> json) {
    return EphemerisDataDto(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dailyPositions: (json['dailyPositions'] as List)
          .map((d) => DailyPositionsDto.fromJson(d))
          .toList(),
    );
  }
}

class DailyPositionsDto {
  final DateTime date;
  final Map<String, PlanetEphemerisDto> planets;

  DailyPositionsDto({required this.date, required this.planets});

  factory DailyPositionsDto.fromJson(Map<String, dynamic> json) {
    return DailyPositionsDto(
      date: DateTime.parse(json['date'] as String),
      planets: (json['planets'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, PlanetEphemerisDto.fromJson(value)),
      ),
    );
  }
}

class PlanetEphemerisDto {
  final double longitude;
  final double latitude;
  final double speed;
  final bool isRetrograde;
  final String sign;
  final int degree;

  PlanetEphemerisDto({
    required this.longitude,
    required this.latitude,
    required this.speed,
    required this.isRetrograde,
    required this.sign,
    required this.degree,
  });

  factory PlanetEphemerisDto.fromJson(Map<String, dynamic> json) {
    return PlanetEphemerisDto(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0,
      isRetrograde: json['isRetrograde'] as bool? ?? false,
      sign: json['sign'] as String,
      degree: (json['degree'] as num).toInt(),
    );
  }
}

class RetrogradePeriodDto {
  final String planet;
  final DateTime startDate;
  final DateTime endDate;
  final String startSign;
  final String endSign;
  final double startDegree;
  final double endDegree;

  RetrogradePeriodDto({
    required this.planet,
    required this.startDate,
    required this.endDate,
    required this.startSign,
    required this.endSign,
    required this.startDegree,
    required this.endDegree,
  });

  factory RetrogradePeriodDto.fromJson(Map<String, dynamic> json) {
    return RetrogradePeriodDto(
      planet: json['planet'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      startSign: json['startSign'] as String,
      endSign: json['endSign'] as String,
      startDegree: (json['startDegree'] as num).toDouble(),
      endDegree: (json['endDegree'] as num).toDouble(),
    );
  }
}

class SignIngressDto {
  final String planet;
  final DateTime date;
  final String fromSign;
  final String toSign;

  SignIngressDto({
    required this.planet,
    required this.date,
    required this.fromSign,
    required this.toSign,
  });

  factory SignIngressDto.fromJson(Map<String, dynamic> json) {
    return SignIngressDto(
      planet: json['planet'] as String,
      date: DateTime.parse(json['date'] as String),
      fromSign: json['fromSign'] as String,
      toSign: json['toSign'] as String,
    );
  }
}

class LunarPhaseDto {
  final DateTime date;
  final String phase;
  final String sign;
  final double degree;

  LunarPhaseDto({
    required this.date,
    required this.phase,
    required this.sign,
    required this.degree,
  });

  factory LunarPhaseDto.fromJson(Map<String, dynamic> json) {
    return LunarPhaseDto(
      date: DateTime.parse(json['date'] as String),
      phase: json['phase'] as String,
      sign: json['sign'] as String,
      degree: (json['degree'] as num).toDouble(),
    );
  }
}

class EclipseDto {
  final DateTime date;
  final String type; // 'solar' | 'lunar'
  final String subType; // 'total' | 'partial' | 'annular' | 'penumbral'
  final String sign;
  final double degree;

  EclipseDto({
    required this.date,
    required this.type,
    required this.subType,
    required this.sign,
    required this.degree,
  });

  factory EclipseDto.fromJson(Map<String, dynamic> json) {
    return EclipseDto(
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      subType: json['subType'] as String,
      sign: json['sign'] as String,
      degree: (json['degree'] as num).toDouble(),
    );
  }
}

class AspectEventDto {
  final DateTime date;
  final String planet1;
  final String planet2;
  final String aspect;
  final bool isExact;
  final bool isApplying;

  AspectEventDto({
    required this.date,
    required this.planet1,
    required this.planet2,
    required this.aspect,
    required this.isExact,
    required this.isApplying,
  });

  factory AspectEventDto.fromJson(Map<String, dynamic> json) {
    return AspectEventDto(
      date: DateTime.parse(json['date'] as String),
      planet1: json['planet1'] as String,
      planet2: json['planet2'] as String,
      aspect: json['aspect'] as String,
      isExact: json['isExact'] as bool? ?? false,
      isApplying: json['isApplying'] as bool? ?? true,
    );
  }
}
