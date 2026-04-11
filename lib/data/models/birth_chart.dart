import 'planet.dart';
import 'zodiac_sign.dart';

/// Astrological aspects between planets
enum AspectType {
  conjunction(
    name: 'Conjunction',
    symbol: '☌',
    angle: 0,
    orb: 8,
    isHarmonious: true,
  ),
  sextile(name: 'Sextile', symbol: '⚹', angle: 60, orb: 6, isHarmonious: true),
  square(name: 'Square', symbol: '□', angle: 90, orb: 8, isHarmonious: false),
  trine(name: 'Trine', symbol: '△', angle: 120, orb: 8, isHarmonious: true),
  opposition(
    name: 'Opposition',
    symbol: '☍',
    angle: 180,
    orb: 8,
    isHarmonious: false,
  );

  final String name;
  final String symbol;
  final int angle;
  final int orb; // Allowed deviation in degrees
  final bool isHarmonious;

  const AspectType({
    required this.name,
    required this.symbol,
    required this.angle,
    required this.orb,
    required this.isHarmonious,
  });
}

/// Represents an aspect between two planets
class Aspect {
  final Planet planet1;
  final Planet planet2;
  final AspectType type;
  final double exactAngle;
  final double orb; // Actual deviation from exact aspect

  const Aspect({
    required this.planet1,
    required this.planet2,
    required this.type,
    required this.exactAngle,
    required this.orb,
  });

  String get description {
    final harmony = type.isHarmonious ? 'harmonious' : 'challenging';
    return '${planet1.name} ${type.symbol} ${planet2.name}: A $harmony ${type.name.toLowerCase()} aspect';
  }

  Map<String, dynamic> toJson() => {
    'planet1': planet1.name,
    'planet2': planet2.name,
    'type': type.name,
    'exactAngle': exactAngle,
    'orb': orb,
  };

  factory Aspect.fromJson(Map<String, dynamic> json) {
    return Aspect(
      planet1: Planet.values.firstWhere((p) => p.name == json['planet1']),
      planet2: Planet.values.firstWhere((p) => p.name == json['planet2']),
      type: AspectType.values.firstWhere((t) => t.name == json['type']),
      exactAngle: (json['exactAngle'] as num).toDouble(),
      orb: (json['orb'] as num).toDouble(),
    );
  }
}

/// Astrological house with its cusp sign
class HousePosition {
  final int houseNumber; // 1-12
  final int signIndex; // 0-11
  final double cuspDegree;

  const HousePosition({
    required this.houseNumber,
    required this.signIndex,
    required this.cuspDegree,
  });

  String get signName {
    const signs = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces',
    ];
    return signs[signIndex];
  }

  String get houseMeaning {
    const meanings = [
      'Self & Identity',
      'Values & Possessions',
      'Communication & Learning',
      'Home & Family',
      'Creativity & Romance',
      'Health & Service',
      'Partnerships',
      'Transformation',
      'Philosophy & Travel',
      'Career & Status',
      'Community & Dreams',
      'Spirituality & Endings',
    ];
    return meanings[houseNumber - 1];
  }

  Map<String, dynamic> toJson() => {
    'houseNumber': houseNumber,
    'signIndex': signIndex,
    'cuspDegree': cuspDegree,
  };

  factory HousePosition.fromJson(Map<String, dynamic> json) {
    return HousePosition(
      houseNumber: json['houseNumber'] as int,
      signIndex: json['signIndex'] as int,
      cuspDegree: (json['cuspDegree'] as num).toDouble(),
    );
  }
}

/// Complete natal (birth) chart
class BirthChart {
  final String id;
  final String name;
  final DateTime birthDateTime;
  final double latitude;
  final double longitude;
  final String locationName;

  final ZodiacSign sunSign;
  final ZodiacSign moonSign;
  final ZodiacSign ascendant;

  final List<PlanetPosition> planetPositions;
  final List<HousePosition> houses;
  final List<Aspect> aspects;

  final DateTime calculatedAt;

  const BirthChart({
    required this.id,
    required this.name,
    required this.birthDateTime,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    required this.sunSign,
    required this.moonSign,
    required this.ascendant,
    required this.planetPositions,
    required this.houses,
    required this.aspects,
    required this.calculatedAt,
  });

  /// Get planet position by planet
  PlanetPosition? getPosition(Planet planet) {
    try {
      return planetPositions.firstWhere((p) => p.planet == planet);
    } catch (_) {
      return null;
    }
  }

  /// Get house position by number
  HousePosition? getHouse(int number) {
    try {
      return houses.firstWhere((h) => h.houseNumber == number);
    } catch (_) {
      return null;
    }
  }

  /// Get aspects involving a specific planet
  List<Aspect> getAspectsFor(Planet planet) {
    return aspects
        .where((a) => a.planet1 == planet || a.planet2 == planet)
        .toList();
  }

  /// Summary of the "Big Three" (Sun, Moon, Ascendant)
  String get bigThreeSummary {
    return '☉ ${sunSign.name} | ☽ ${moonSign.name} | ↑ ${ascendant.name}';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'birthDateTime': birthDateTime.toIso8601String(),
    'latitude': latitude,
    'longitude': longitude,
    'locationName': locationName,
    'sunSign': sunSign.name,
    'moonSign': moonSign.name,
    'ascendant': ascendant.name,
    'planetPositions': planetPositions.map((p) => p.toJson()).toList(),
    'houses': houses.map((h) => h.toJson()).toList(),
    'aspects': aspects.map((a) => a.toJson()).toList(),
    'calculatedAt': calculatedAt.toIso8601String(),
  };

  factory BirthChart.fromJson(Map<String, dynamic> json) {
    return BirthChart(
      id: json['id'] as String,
      name: json['name'] as String,
      birthDateTime: DateTime.parse(json['birthDateTime'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      locationName: json['locationName'] as String,
      sunSign: ZodiacSign.values.firstWhere((s) => s.name == json['sunSign']),
      moonSign: ZodiacSign.values.firstWhere((s) => s.name == json['moonSign']),
      ascendant: ZodiacSign.values.firstWhere(
        (s) => s.name == json['ascendant'],
      ),
      planetPositions: (json['planetPositions'] as List)
          .map((p) => PlanetPosition.fromJson(p as Map<String, dynamic>))
          .toList(),
      houses: (json['houses'] as List)
          .map((h) => HousePosition.fromJson(h as Map<String, dynamic>))
          .toList(),
      aspects: (json['aspects'] as List)
          .map((a) => Aspect.fromJson(a as Map<String, dynamic>))
          .toList(),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );
  }
}

/// User's profile with birth data
class UserProfile {
  final String id;
  final String name;
  final DateTime birthDate;
  final DateTime? birthTime;
  final String? birthPlace;
  final double? latitude;
  final double? longitude;
  final ZodiacSign sunSign;
  final BirthChart? birthChart;

  const UserProfile({
    required this.id,
    required this.name,
    required this.birthDate,
    this.birthTime,
    this.birthPlace,
    this.latitude,
    this.longitude,
    required this.sunSign,
    this.birthChart,
  });

  bool get hasFullBirthData => birthTime != null && birthPlace != null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'birthDate': birthDate.toIso8601String(),
    'birthTime': birthTime?.toIso8601String(),
    'birthPlace': birthPlace,
    'latitude': latitude,
    'longitude': longitude,
    'sunSign': sunSign.name,
    'birthChart': birthChart?.toJson(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      birthTime: json['birthTime'] != null
          ? DateTime.parse(json['birthTime'] as String)
          : null,
      birthPlace: json['birthPlace'] as String?,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      sunSign: ZodiacSign.values.firstWhere((s) => s.name == json['sunSign']),
      birthChart: json['birthChart'] != null
          ? BirthChart.fromJson(json['birthChart'] as Map<String, dynamic>)
          : null,
    );
  }

  UserProfile copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    DateTime? birthTime,
    String? birthPlace,
    double? latitude,
    double? longitude,
    ZodiacSign? sunSign,
    BirthChart? birthChart,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      birthPlace: birthPlace ?? this.birthPlace,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      sunSign: sunSign ?? this.sunSign,
      birthChart: birthChart ?? this.birthChart,
    );
  }
}
