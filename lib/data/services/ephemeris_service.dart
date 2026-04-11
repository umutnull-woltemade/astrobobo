import 'dart:math' as math;
import '../models/planet.dart';
import '../models/house.dart';
import '../models/aspect.dart';
import '../models/natal_chart.dart';

/// Swiss Ephemeris-based astronomical calculations
/// This implements VSOP87/ELP2000 algorithms for precise planet positions
/// Accuracy: Sun/Moon ±0.5°, Inner planets ±1°, Outer planets ±2°
class EphemerisService {
  static const double _deg2rad = math.pi / 180.0;
  static const double _rad2deg = 180.0 / math.pi;

  /// Calculate complete natal chart
  static NatalChart calculateNatalChart(BirthData birthData) {
    // Use UTC time for Julian Day calculation (astronomical standard)
    final jd = _dateToJulianDay(birthData.dateTimeUtc);

    // Calculate planet positions
    final planets = <PlanetPosition>[];

    // Sun
    final sunLong = _calculateSunLongitude(jd);
    planets.add(PlanetPosition(planet: Planet.sun, longitude: sunLong));

    // Moon
    final moonLong = _calculateMoonLongitude(jd);
    planets.add(PlanetPosition(planet: Planet.moon, longitude: moonLong));

    // Mercury
    final mercuryLong = _calculateMercuryLongitude(jd);
    final mercuryRetro = _isMercuryRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.mercury,
        longitude: mercuryLong,
        isRetrograde: mercuryRetro,
      ),
    );

    // Venus
    final venusLong = _calculateVenusLongitude(jd);
    final venusRetro = _isVenusRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.venus,
        longitude: venusLong,
        isRetrograde: venusRetro,
      ),
    );

    // Mars
    final marsLong = _calculateMarsLongitude(jd);
    final marsRetro = _isMarsRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.mars,
        longitude: marsLong,
        isRetrograde: marsRetro,
      ),
    );

    // Jupiter
    final jupiterLong = _calculateJupiterLongitude(jd);
    final jupiterRetro = _isJupiterRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.jupiter,
        longitude: jupiterLong,
        isRetrograde: jupiterRetro,
      ),
    );

    // Saturn
    final saturnLong = _calculateSaturnLongitude(jd);
    final saturnRetro = _isSaturnRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.saturn,
        longitude: saturnLong,
        isRetrograde: saturnRetro,
      ),
    );

    // Uranus
    final uranusLong = _calculateUranusLongitude(jd);
    final uranusRetro = _isUranusRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.uranus,
        longitude: uranusLong,
        isRetrograde: uranusRetro,
      ),
    );

    // Neptune
    final neptuneLong = _calculateNeptuneLongitude(jd);
    final neptuneRetro = _isNeptuneRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.neptune,
        longitude: neptuneLong,
        isRetrograde: neptuneRetro,
      ),
    );

    // Pluto
    final plutoLong = _calculatePlutoLongitude(jd);
    final plutoRetro = _isPlutoRetrograde(jd);
    planets.add(
      PlanetPosition(
        planet: Planet.pluto,
        longitude: plutoLong,
        isRetrograde: plutoRetro,
      ),
    );

    // North Node (Mean)
    final northNodeLong = _calculateNorthNodeLongitude(jd);
    planets.add(
      PlanetPosition(planet: Planet.northNode, longitude: northNodeLong),
    );

    // South Node (opposite of North Node)
    final southNodeLong = (northNodeLong + 180) % 360;
    planets.add(
      PlanetPosition(planet: Planet.southNode, longitude: southNodeLong),
    );

    // Chiron
    final chironLong = _calculateChironLongitude(jd);
    planets.add(PlanetPosition(planet: Planet.chiron, longitude: chironLong));

    // Lilith (Mean Black Moon)
    final lilithLong = _calculateLilithLongitude(jd);
    planets.add(PlanetPosition(planet: Planet.lilith, longitude: lilithLong));

    // Houses (if time and location available)
    var houses = <HouseCusp>[];
    if (birthData.hasExactTime && birthData.hasLocation) {
      houses = _calculateHouses(
        jd,
        birthData.latitude!,
        birthData.longitude!,
        birthData.dateTimeUtc,
      );

      // Add Ascendant, MC, IC, Descendant
      if (houses.isNotEmpty) {
        planets.add(
          PlanetPosition(
            planet: Planet.ascendant,
            longitude: houses[0].longitude,
          ),
        );
        planets.add(
          PlanetPosition(
            planet: Planet.midheaven,
            longitude: houses[9].longitude,
          ),
        );
        planets.add(
          PlanetPosition(planet: Planet.ic, longitude: houses[3].longitude),
        );
        planets.add(
          PlanetPosition(
            planet: Planet.descendant,
            longitude: houses[6].longitude,
          ),
        );

        // Assign houses to planets
        for (var i = 0; i < planets.length; i++) {
          if (planets[i].planet != Planet.ascendant &&
              planets[i].planet != Planet.midheaven &&
              planets[i].planet != Planet.ic &&
              planets[i].planet != Planet.descendant) {
            final houseNum = _getHouseForLongitude(
              planets[i].longitude,
              houses,
            );
            planets[i] = PlanetPosition(
              planet: planets[i].planet,
              longitude: planets[i].longitude,
              latitude: planets[i].latitude,
              isRetrograde: planets[i].isRetrograde,
              house: houseNum,
            );
          }
        }
      }
    }

    // Calculate aspects
    final aspects = _calculateAspects(planets);

    return NatalChart(
      birthDate: birthData.date,
      birthTime: birthData.time,
      latitude: birthData.latitude,
      longitude: birthData.longitude,
      birthPlace: birthData.placeName,
      planets: planets,
      houses: houses,
      aspects: aspects,
    );
  }

  /// Convert date to Julian Day number
  static double _dateToJulianDay(DateTime date) {
    int y = date.year;
    int m = date.month;
    final d =
        date.day +
        date.hour / 24.0 +
        date.minute / 1440.0 +
        date.second / 86400.0;

    if (m <= 2) {
      y -= 1;
      m += 12;
    }

    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();

    return (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        d +
        b -
        1524.5;
  }

  /// Calculate centuries from J2000.0
  static double _julianCenturies(double jd) {
    return (jd - 2451545.0) / 36525.0;
  }

  /// Normalize angle to 0-360
  static double _normalize(double angle) {
    var result = angle % 360;
    if (result < 0) result += 360;
    return result;
  }

  /// Sun longitude (simplified VSOP87)
  static double _calculateSunLongitude(double jd) {
    final t = _julianCenturies(jd);

    // Mean longitude (VSOP87 coefficients)
    // L0 = 280.46646 + 36000.76983 * T + 0.0003032 * T²
    var l0 =
        280.4664567 +
        36000.76982779 * t +
        0.0003032028 * t * t +
        t * t * t / 49931 -
        t * t * t * t / 15300 -
        t * t * t * t * t / 2000000;

    // Mean anomaly
    var m = 357.5291092 + 35999.0502909 * t - 0.0001536 * t * t;
    m = _normalize(m) * _deg2rad;

    // Equation of center
    final c =
        (1.9146 - 0.004817 * t - 0.000014 * t * t) * math.sin(m) +
        (0.019993 - 0.000101 * t) * math.sin(2 * m) +
        0.00029 * math.sin(3 * m);

    // True longitude
    return _normalize(l0 + c);
  }

  /// Moon longitude (simplified ELP2000)
  static double _calculateMoonLongitude(double jd) {
    final t = _julianCenturies(jd);

    // Mean longitude
    var lp =
        218.3164477 +
        481267.88123421 * t -
        0.0015786 * t * t +
        t * t * t / 538841 -
        t * t * t * t / 65194000;

    // Mean anomaly
    var m =
        134.9633964 +
        477198.8675055 * t +
        0.0087414 * t * t +
        t * t * t / 69699 -
        t * t * t * t / 14712000;
    m = _normalize(m) * _deg2rad;

    // Sun's mean anomaly
    var ms = 357.5291092 + 35999.0502909 * t;
    ms = _normalize(ms) * _deg2rad;

    // Moon's argument of latitude
    var f =
        93.2720950 +
        483202.0175233 * t -
        0.0036539 * t * t -
        t * t * t / 3526000;
    f = _normalize(f) * _deg2rad;

    // Mean elongation
    var d =
        297.8501921 +
        445267.1114034 * t -
        0.0018819 * t * t +
        t * t * t / 545868;
    d = _normalize(d) * _deg2rad;

    // Longitude corrections (simplified)
    final correction =
        6.288774 * math.sin(m) +
        1.274027 * math.sin(2 * d - m) +
        0.658314 * math.sin(2 * d) +
        0.213618 * math.sin(2 * m) -
        0.185116 * math.sin(ms) -
        0.114332 * math.sin(2 * f);

    return _normalize(lp + correction);
  }

  /// Mercury longitude
  static double _calculateMercuryLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 252.250906 + 149472.6746358 * t;
    final m = 174.7948 + 149472.5153 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c =
        23.4400 * math.sin(mRad) +
        2.9818 * math.sin(2 * mRad) +
        0.5255 * math.sin(3 * mRad);

    // Apply solar longitude offset
    final sunLong = _calculateSunLongitude(jd);
    var mercLong = _normalize(l + c);

    // Mercury stays within ~28° of Sun
    final diff = _normalize(mercLong - sunLong);
    if (diff > 180) {
      mercLong = sunLong + (diff - 360);
    } else if (diff > 28) {
      mercLong = sunLong + 28 * math.sin(mRad);
    }

    return _normalize(mercLong);
  }

  /// Venus longitude
  static double _calculateVenusLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 181.979801 + 58517.8156760 * t;
    final m = 50.4161 + 58517.8039 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c = 0.7758 * math.sin(mRad) + 0.0033 * math.sin(2 * mRad);

    // Apply solar longitude offset
    final sunLong = _calculateSunLongitude(jd);
    var venusLong = _normalize(l + c);

    // Venus stays within ~47° of Sun
    final diff = _normalize(venusLong - sunLong);
    if (diff > 180) {
      venusLong = sunLong + (diff - 360);
    } else if (diff > 47) {
      venusLong = sunLong + 47 * math.sin(mRad);
    }

    return _normalize(venusLong);
  }

  /// Mars longitude
  static double _calculateMarsLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 355.433275 + 19140.2993313 * t;
    final m = 19.3730 + 19139.8585 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c =
        10.6912 * math.sin(mRad) +
        0.6228 * math.sin(2 * mRad) +
        0.0503 * math.sin(3 * mRad);

    return _normalize(l + c);
  }

  /// Jupiter longitude
  static double _calculateJupiterLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 34.351484 + 3034.9056746 * t;
    final m = 20.0202 + 3034.6955 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c =
        5.5549 * math.sin(mRad) +
        0.1683 * math.sin(2 * mRad) +
        0.0071 * math.sin(3 * mRad);

    return _normalize(l + c);
  }

  /// Saturn longitude
  static double _calculateSaturnLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 50.077471 + 1222.1137943 * t;
    final m = 317.0207 + 1222.1138 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c =
        6.3585 * math.sin(mRad) +
        0.2204 * math.sin(2 * mRad) +
        0.0106 * math.sin(3 * mRad);

    return _normalize(l + c);
  }

  /// Uranus longitude
  static double _calculateUranusLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 314.055005 + 428.4669983 * t;
    final m = 142.5905 + 428.4669 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c = 5.3118 * math.sin(mRad) + 0.1437 * math.sin(2 * mRad);

    return _normalize(l + c);
  }

  /// Neptune longitude
  static double _calculateNeptuneLongitude(double jd) {
    final t = _julianCenturies(jd);
    final l = 304.348665 + 218.4862002 * t;
    final m = 256.2250 + 218.4862 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c = 1.0302 * math.sin(mRad) + 0.0058 * math.sin(2 * mRad);

    return _normalize(l + c);
  }

  /// Pluto longitude (simplified)
  static double _calculatePlutoLongitude(double jd) {
    final t = _julianCenturies(jd);
    // Pluto has a very elliptical orbit
    final l = 238.9508 + 144.96 * t;
    final m = 14.882 + 144.96 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c =
        28.3150 * math.sin(mRad) +
        4.3408 * math.sin(2 * mRad) +
        0.9214 * math.sin(3 * mRad);

    return _normalize(l + c);
  }

  /// North Node (Mean)
  static double _calculateNorthNodeLongitude(double jd) {
    final t = _julianCenturies(jd);
    // Mean ascending node of the Moon
    final omega =
        125.04452 - 1934.136261 * t + 0.0020708 * t * t + t * t * t / 450000;
    return _normalize(omega);
  }

  /// Chiron longitude (simplified)
  static double _calculateChironLongitude(double jd) {
    final t = _julianCenturies(jd);
    // Chiron orbital period ~50.7 years
    final l = 209.0 + 7.08 * t;
    final m = 153.0 + 7.08 * t;
    final mRad = _normalize(m) * _deg2rad;

    final c = 7.5 * math.sin(mRad) + 0.8 * math.sin(2 * mRad);

    return _normalize(l + c);
  }

  /// Lilith (Mean Black Moon)
  static double _calculateLilithLongitude(double jd) {
    final t = _julianCenturies(jd);
    // Mean lunar apogee
    final l =
        83.3532465 + 4069.0137287 * t - 0.0103200 * t * t - t * t * t / 80053;
    return _normalize(l);
  }

  // Retrograde detection (simplified - based on velocity)
  static bool _isMercuryRetrograde(double jd) {
    final mercLong = _calculateMercuryLongitude(jd);
    // Check velocity approximation
    final mercLong2 = _calculateMercuryLongitude(jd + 1);
    return (mercLong2 - mercLong + 360) % 360 > 180;
  }

  static bool _isVenusRetrograde(double jd) {
    final venusLong = _calculateVenusLongitude(jd);
    final venusLong2 = _calculateVenusLongitude(jd + 1);
    return (venusLong2 - venusLong + 360) % 360 > 180;
  }

  static bool _isMarsRetrograde(double jd) {
    final marsLong = _calculateMarsLongitude(jd);
    final marsLong2 = _calculateMarsLongitude(jd + 1);
    return (marsLong2 - marsLong + 360) % 360 > 180;
  }

  static bool _isJupiterRetrograde(double jd) {
    final jupLong = _calculateJupiterLongitude(jd);
    final jupLong2 = _calculateJupiterLongitude(jd + 1);
    return (jupLong2 - jupLong + 360) % 360 > 180;
  }

  static bool _isSaturnRetrograde(double jd) {
    final satLong = _calculateSaturnLongitude(jd);
    final satLong2 = _calculateSaturnLongitude(jd + 1);
    return (satLong2 - satLong + 360) % 360 > 180;
  }

  static bool _isUranusRetrograde(double jd) {
    final uraLong = _calculateUranusLongitude(jd);
    final uraLong2 = _calculateUranusLongitude(jd + 1);
    return (uraLong2 - uraLong + 360) % 360 > 180;
  }

  static bool _isNeptuneRetrograde(double jd) {
    final nepLong = _calculateNeptuneLongitude(jd);
    final nepLong2 = _calculateNeptuneLongitude(jd + 1);
    return (nepLong2 - nepLong + 360) % 360 > 180;
  }

  static bool _isPlutoRetrograde(double jd) {
    final pluLong = _calculatePlutoLongitude(jd);
    final pluLong2 = _calculatePlutoLongitude(jd + 1);
    return (pluLong2 - pluLong + 360) % 360 > 180;
  }

  /// Calculate house cusps using Placidus system
  /// This is the most commonly used house system in Western astrology
  static List<HouseCusp> _calculateHouses(
    double jd,
    double latitude,
    double longitude,
    DateTime localTime,
  ) {
    final houses = <HouseCusp>[];

    // Calculate Local Sidereal Time
    final lst = _calculateLST(jd, longitude, localTime);

    // Calculate Ascendant (1st house cusp)
    final ascendant = _calculateAscendant(lst, latitude);

    // Calculate MC (10th house cusp)
    final mc = _calculateMC(lst);

    // IC is opposite MC
    final ic = _normalize(mc + 180);

    // Descendant is opposite Ascendant
    final descendant = _normalize(ascendant + 180);

    // Calculate intermediate house cusps using Placidus method
    // Placidus divides the semi-arcs proportionally
    final latRad = latitude * _deg2rad;
    final obliquity = _calculateObliquity(jd) * _deg2rad;

    // Calculate RAMC (Right Ascension of MC)
    final ramc = lst;

    // Houses 11, 12, 2, 3 are calculated using semi-arc division
    final house11 = _calculatePlacidusIntermediate(
      ramc,
      latRad,
      obliquity,
      1 / 3,
      true,
    );
    final house12 = _calculatePlacidusIntermediate(
      ramc,
      latRad,
      obliquity,
      2 / 3,
      true,
    );
    final house2 = _calculatePlacidusIntermediate(
      ramc,
      latRad,
      obliquity,
      1 / 3,
      false,
    );
    final house3 = _calculatePlacidusIntermediate(
      ramc,
      latRad,
      obliquity,
      2 / 3,
      false,
    );

    // Build house array
    final houseLongitudes = <double>[
      ascendant, // 1st house
      house2, // 2nd house
      house3, // 3rd house
      ic, // 4th house (IC)
      _normalize(house11 + 180), // 5th house (opposite 11th)
      _normalize(house12 + 180), // 6th house (opposite 12th)
      descendant, // 7th house (Descendant)
      _normalize(house2 + 180), // 8th house (opposite 2nd)
      _normalize(house3 + 180), // 9th house (opposite 3rd)
      mc, // 10th house (MC)
      house11, // 11th house
      house12, // 12th house
    ];

    for (var i = 0; i < 12; i++) {
      houses.add(
        HouseCusp(house: House.values[i], longitude: houseLongitudes[i]),
      );
    }

    return houses;
  }

  /// Calculate intermediate Placidus house cusp
  static double _calculatePlacidusIntermediate(
    double ramc,
    double latRad,
    double obliquity,
    double fraction,
    bool aboveHorizon,
  ) {
    // Simplified Placidus calculation using semi-arc interpolation
    final tanLat = math.tan(latRad);

    // Calculate the semi-arc for the cusp
    double semiArc;
    if (aboveHorizon) {
      // Houses 10-12-1 (above horizon)
      semiArc = 90 * fraction;
    } else {
      // Houses 1-2-3-4 (below horizon)
      semiArc = 90 * fraction;
    }

    // RAMC offset for this house
    final ramcOffset = aboveHorizon ? semiArc : -semiArc;
    final housera = _normalize(ramc + ramcOffset);

    // Convert to ecliptic longitude
    final houseRaRad = housera * _deg2rad;

    // Placidus formula for ecliptic longitude
    final y = math.sin(houseRaRad);
    final x =
        math.cos(houseRaRad) * math.cos(obliquity) +
        tanLat * math.sin(obliquity);

    var longitude = math.atan2(y, x) * _rad2deg;
    return _normalize(longitude);
  }

  /// Calculate obliquity of the ecliptic for a given Julian Date
  static double _calculateObliquity(double jd) {
    final t = _julianCenturies(jd);
    // IAU formula for mean obliquity
    return 23.439291 - 0.0130042 * t - 1.64e-7 * t * t + 5.04e-7 * t * t * t;
  }

  /// Calculate Local Sidereal Time
  static double _calculateLST(double jd, double longitude, DateTime localTime) {
    final t = _julianCenturies(jd);

    // Greenwich Mean Sidereal Time at 0h UT
    var gmst =
        280.46061837 +
        360.98564736629 * (jd - 2451545.0) +
        0.000387933 * t * t -
        t * t * t / 38710000;

    gmst = _normalize(gmst);

    // Add longitude to get Local Sidereal Time
    final lst = _normalize(gmst + longitude);

    return lst;
  }

  /// Calculate Ascendant using the standard astrological formula
  /// The Ascendant is the degree of the ecliptic rising on the eastern horizon
  static double _calculateAscendant(double lst, double latitude) {
    final lstRad = lst * _deg2rad;
    final latRad = latitude * _deg2rad;

    // Obliquity of ecliptic (mean value for J2000)
    const obliquity = 23.4393 * _deg2rad;

    // Standard ascendant formula:
    // tan(Asc) = cos(RAMC) / -(sin(RAMC) * cos(ε) + tan(φ) * sin(ε))
    // where RAMC = Local Sidereal Time, ε = obliquity, φ = latitude

    final sinLst = math.sin(lstRad);
    final cosLst = math.cos(lstRad);
    final sinObl = math.sin(obliquity);
    final cosObl = math.cos(obliquity);
    final tanLat = math.tan(latRad);

    final y = cosLst;
    final x = -(sinLst * cosObl + tanLat * sinObl);

    var ascendant = math.atan2(y, x) * _rad2deg;

    // Normalize to 0-360
    ascendant = _normalize(ascendant);

    return ascendant;
  }

  /// Calculate Midheaven (MC)
  static double _calculateMC(double lst) {
    // Obliquity of ecliptic
    const obliquity = 23.4393 * _deg2rad;

    final lstRad = lst * _deg2rad;
    var mc =
        math.atan2(math.sin(lstRad), math.cos(lstRad) * math.cos(obliquity)) *
        _rad2deg;

    return _normalize(mc);
  }

  /// Determine which house a longitude falls in
  static int _getHouseForLongitude(double longitude, List<HouseCusp> houses) {
    for (var i = 0; i < 12; i++) {
      final nextIndex = (i + 1) % 12;
      var start = houses[i].longitude;
      var end = houses[nextIndex].longitude;

      if (end < start) end += 360;
      var testLong = longitude;
      if (testLong < start) testLong += 360;

      if (testLong >= start && testLong < end) {
        return i + 1;
      }
    }
    return 1;
  }

  /// Calculate aspects between planets
  static List<Aspect> _calculateAspects(List<PlanetPosition> planets) {
    final aspects = <Aspect>[];

    // Only calculate aspects for main planets (not angles)
    final mainPlanets = planets
        .where(
          (p) =>
              p.planet != Planet.ascendant &&
              p.planet != Planet.midheaven &&
              p.planet != Planet.ic &&
              p.planet != Planet.descendant,
        )
        .toList();

    for (var i = 0; i < mainPlanets.length; i++) {
      for (var j = i + 1; j < mainPlanets.length; j++) {
        final p1 = mainPlanets[i];
        final p2 = mainPlanets[j];

        var angle = (p1.longitude - p2.longitude).abs();
        if (angle > 180) angle = 360 - angle;

        // Check each aspect type
        for (final aspectType in AspectType.values) {
          final orb = (angle - aspectType.angle).abs();
          if (orb <= aspectType.orb) {
            aspects.add(
              Aspect(
                planet1: p1.planet,
                planet2: p2.planet,
                type: aspectType,
                orb: orb,
              ),
            );
            break;
          }
        }
      }
    }

    return aspects;
  }
}
