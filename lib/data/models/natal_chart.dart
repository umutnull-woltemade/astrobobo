import 'planet.dart';
import 'house.dart';
import 'aspect.dart';
import 'zodiac_sign.dart';

/// Complete natal chart data
class NatalChart {
  final DateTime birthDate;
  final String? birthTime; // HH:mm format
  final double? latitude;
  final double? longitude;
  final String? birthPlace;

  final List<PlanetPosition> planets;
  final List<HouseCusp> houses;
  final List<Aspect> aspects;

  NatalChart({
    required this.birthDate,
    this.birthTime,
    this.latitude,
    this.longitude,
    this.birthPlace,
    required this.planets,
    required this.houses,
    required this.aspects,
  });

  bool get hasExactTime => birthTime != null && latitude != null;

  // Quick accessors
  PlanetPosition? get sun => _getPlanet(Planet.sun);
  PlanetPosition? get moon => _getPlanet(Planet.moon);
  PlanetPosition? get mercury => _getPlanet(Planet.mercury);
  PlanetPosition? get venus => _getPlanet(Planet.venus);
  PlanetPosition? get mars => _getPlanet(Planet.mars);
  PlanetPosition? get jupiter => _getPlanet(Planet.jupiter);
  PlanetPosition? get saturn => _getPlanet(Planet.saturn);
  PlanetPosition? get uranus => _getPlanet(Planet.uranus);
  PlanetPosition? get neptune => _getPlanet(Planet.neptune);
  PlanetPosition? get pluto => _getPlanet(Planet.pluto);
  PlanetPosition? get northNode => _getPlanet(Planet.northNode);
  PlanetPosition? get southNode => _getPlanet(Planet.southNode);
  PlanetPosition? get chiron => _getPlanet(Planet.chiron);
  PlanetPosition? get lilith => _getPlanet(Planet.lilith);
  PlanetPosition? get ascendant => _getPlanet(Planet.ascendant);
  PlanetPosition? get midheaven => _getPlanet(Planet.midheaven);

  PlanetPosition? _getPlanet(Planet planet) {
    try {
      return planets.firstWhere((p) => p.planet == planet);
    } catch (_) {
      return null;
    }
  }

  ZodiacSign get sunSign => sun?.sign ?? ZodiacSign.aries;
  ZodiacSign? get moonSign => moon?.sign;
  ZodiacSign? get risingSign => ascendant?.sign;

  /// Get all planets in a specific sign
  List<PlanetPosition> planetsInSign(ZodiacSign sign) {
    return planets.where((p) => p.sign == sign).toList();
  }

  /// Get all planets in a specific house
  List<PlanetPosition> planetsInHouse(House house) {
    return planets.where((p) => p.house == house.number).toList();
  }

  /// Get aspects for a specific planet
  List<Aspect> aspectsForPlanet(Planet planet) {
    return aspects
        .where((a) => a.planet1 == planet || a.planet2 == planet)
        .toList();
  }

  /// Get only major aspects
  List<Aspect> get majorAspects =>
      aspects.where((a) => a.type.isMajor).toList();

  /// Get challenging aspects
  List<Aspect> get challengingAspects =>
      aspects.where((a) => a.type.isChallenging).toList();

  /// Get harmonious aspects
  List<Aspect> get harmoniousAspects =>
      aspects.where((a) => a.type.isHarmonious).toList();

  /// Get retrograde planets
  List<PlanetPosition> get retrogradePlanets =>
      planets.where((p) => p.isRetrograde).toList();

  /// Dominant element in chart
  Element get dominantElement {
    final elementCounts = <Element, int>{};
    for (final planet in planets.where(
      (p) => p.planet.isPersonalPlanet || p.planet.isSocialPlanet,
    )) {
      final element = planet.sign.element;
      elementCounts[element] = (elementCounts[element] ?? 0) + 1;
    }
    return elementCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Dominant modality in chart
  Modality get dominantModality {
    final modalityCounts = <Modality, int>{};
    for (final planet in planets.where(
      (p) => p.planet.isPersonalPlanet || p.planet.isSocialPlanet,
    )) {
      final modality = planet.sign.modality;
      modalityCounts[modality] = (modalityCounts[modality] ?? 0) + 1;
    }
    return modalityCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}

/// Birth data input
class BirthData {
  final DateTime date;
  final String? time; // HH:mm
  final double? latitude;
  final double? longitude;
  final String? placeName;
  final double?
  timezoneOffset; // Hours offset from UTC (e.g., +3 for Istanbul, -5 for New York)

  BirthData({
    required this.date,
    this.time,
    this.latitude,
    this.longitude,
    this.placeName,
    this.timezoneOffset,
  });

  bool get hasExactTime => time != null;
  bool get hasLocation => latitude != null && longitude != null;

  /// Get timezone offset - use provided value or estimate from longitude
  double get effectiveTimezoneOffset {
    if (timezoneOffset != null) return timezoneOffset!;
    if (longitude != null) {
      // Approximate timezone from longitude (15° per hour)
      return (longitude! / 15).roundToDouble();
    }
    return 0; // Default to UTC
  }

  DateTime get dateTime {
    if (time == null) return date;
    final parts = time!.split(':');
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  /// Get dateTime in UTC for astronomical calculations
  DateTime get dateTimeUtc {
    final local = dateTime;
    // Subtract timezone offset to get UTC
    return local.subtract(
      Duration(
        hours: effectiveTimezoneOffset.truncate(),
        minutes: ((effectiveTimezoneOffset % 1) * 60).round(),
      ),
    );
  }
}
