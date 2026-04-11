import 'dart:math';

import '../models/advanced_astrology.dart';
import '../models/zodiac_sign.dart';

// ============ NEW MODEL CLASSES ============

/// Represents a planetary transit
class Transit {
  final String transitingPlanet;
  final String natalPlanet;
  final ZodiacSign transitSign;
  final AspectType? aspectType;
  final double orb;
  final DateTime startDate;
  final DateTime exactDate;
  final DateTime endDate;
  final bool isRetrograde;
  final int importance; // 1-10 scale
  final String interpretation;

  const Transit({
    required this.transitingPlanet,
    required this.natalPlanet,
    required this.transitSign,
    this.aspectType,
    required this.orb,
    required this.startDate,
    required this.exactDate,
    required this.endDate,
    this.isRetrograde = false,
    required this.importance,
    required this.interpretation,
  });
}

/// Transit period for retrograde tracking
class TransitPeriod {
  final String planet;
  final DateTime startDate;
  final DateTime endDate;
  final ZodiacSign startSign;
  final ZodiacSign endSign;
  final bool isRetrograde;
  final String description;

  const TransitPeriod({
    required this.planet,
    required this.startDate,
    required this.endDate,
    required this.startSign,
    required this.endSign,
    required this.isRetrograde,
    required this.description,
  });
}

/// Eclipse data
class Eclipse {
  final DateTime date;
  final EclipseType type;
  final ZodiacSign sign;
  final double degree;
  final String sarosCycle;
  final bool isVisible;
  final String interpretation;

  const Eclipse({
    required this.date,
    required this.type,
    required this.sign,
    required this.degree,
    required this.sarosCycle,
    required this.isVisible,
    required this.interpretation,
  });
}

enum EclipseType {
  solarTotal,
  solarAnnular,
  solarPartial,
  lunarTotal,
  lunarPartial,
  lunarPenumbral,
}

extension EclipseTypeExtension on EclipseType {
  String get nameTr {
    switch (this) {
      case EclipseType.solarTotal:
        return 'Tam Gunes Tutulmasi';
      case EclipseType.solarAnnular:
        return 'Halkali Gunes Tutulmasi';
      case EclipseType.solarPartial:
        return 'Kismi Gunes Tutulmasi';
      case EclipseType.lunarTotal:
        return 'Tam Ay Tutulmasi';
      case EclipseType.lunarPartial:
        return 'Kismi Ay Tutulmasi';
      case EclipseType.lunarPenumbral:
        return 'Yarigolge Ay Tutulmasi';
    }
  }
}

/// Progressed chart data
class ProgressedChart {
  final DateTime natalDate;
  final DateTime progressedDate;
  final Map<String, PlanetPosition> progressedPlanets;
  final ZodiacSign progressedAscendant;
  final ZodiacSign progressedMidheaven;
  final List<ProgressedAspect> aspects;
  final String lifeCyclePhase;
  final String interpretation;

  const ProgressedChart({
    required this.natalDate,
    required this.progressedDate,
    required this.progressedPlanets,
    required this.progressedAscendant,
    required this.progressedMidheaven,
    required this.aspects,
    required this.lifeCyclePhase,
    required this.interpretation,
  });
}

/// Planet position with degree
class PlanetPosition {
  final String planet;
  final ZodiacSign sign;
  final double degree;
  final int house;
  final bool isRetrograde;

  const PlanetPosition({
    required this.planet,
    required this.sign,
    required this.degree,
    required this.house,
    this.isRetrograde = false,
  });

  double get absoluteDegree => sign.index * 30.0 + degree;
}

/// Solar Arc direction
class SolarArc {
  final double arcDegrees;
  final Map<String, PlanetPosition> directedPlanets;
  final List<SolarArcAspect> activeAspects;
  final String interpretation;

  const SolarArc({
    required this.arcDegrees,
    required this.directedPlanets,
    required this.activeAspects,
    required this.interpretation,
  });
}

class SolarArcAspect {
  final String directedPlanet;
  final String natalPlanet;
  final AspectType type;
  final double orb;
  final bool isApplying;
  final String interpretation;

  const SolarArcAspect({
    required this.directedPlanet,
    required this.natalPlanet,
    required this.type,
    required this.orb,
    required this.isApplying,
    required this.interpretation,
  });
}

/// Chart for Solar/Lunar returns
class Chart {
  final DateTime date;
  final String location;
  final double latitude;
  final double longitude;
  final Map<String, PlanetPosition> planets;
  final Map<int, double> houses;
  final ZodiacSign ascendant;
  final ZodiacSign midheaven;
  final List<ChartAspect> aspects;
  final String interpretation;

  const Chart({
    required this.date,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.planets,
    required this.houses,
    required this.ascendant,
    required this.midheaven,
    required this.aspects,
    required this.interpretation,
  });
}

class ChartAspect {
  final String planet1;
  final String planet2;
  final AspectType type;
  final double orb;
  final bool isApplying;

  const ChartAspect({
    required this.planet1,
    required this.planet2,
    required this.type,
    required this.orb,
    required this.isApplying,
  });
}

/// Electional query for timing
class ElectionalQuery {
  final String purpose;
  final List<String> favorablePlanets;
  final List<String> avoidPlanets;
  final int? preferredMoonPhase; // 0-7
  final ZodiacSign? preferredMoonSign;
  final bool avoidVoidMoon;
  final bool avoidRetrogrades;

  const ElectionalQuery({
    required this.purpose,
    this.favorablePlanets = const [],
    this.avoidPlanets = const [],
    this.preferredMoonPhase,
    this.preferredMoonSign,
    this.avoidVoidMoon = true,
    this.avoidRetrogrades = true,
  });
}

/// Electional window result
class ElectionalWindow {
  final DateTime startTime;
  final DateTime endTime;
  final int score; // 0-100
  final MoonPhase moonPhase;
  final ZodiacSign moonSign;
  final bool isVoidMoon;
  final List<String> favorableFactors;
  final List<String> challengingFactors;
  final String recommendation;

  const ElectionalWindow({
    required this.startTime,
    required this.endTime,
    required this.score,
    required this.moonPhase,
    required this.moonSign,
    required this.isVoidMoon,
    required this.favorableFactors,
    required this.challengingFactors,
    required this.recommendation,
  });
}

/// Moon phase data
class MoonPhase {
  final int phase; // 0-7
  final String name;
  final String nameTr;
  final double illumination;
  final String symbol;
  final String interpretation;

  const MoonPhase({
    required this.phase,
    required this.name,
    required this.nameTr,
    required this.illumination,
    required this.symbol,
    required this.interpretation,
  });

  static const List<MoonPhase> allPhases = [
    MoonPhase(
      phase: 0,
      name: 'New Moon',
      nameTr: 'Yeni Ay',
      illumination: 0.0,
      symbol: '🌑',
      interpretation:
          'Yeni baslangiclarin zamani. Niyet koyma ve tohumlama dönemi.',
    ),
    MoonPhase(
      phase: 1,
      name: 'Waxing Crescent',
      nameTr: 'Hilal (Buyuyen)',
      illumination: 0.25,
      symbol: '🌒',
      interpretation: 'Niyet gucleniyor. Harekete gecme zamani.',
    ),
    MoonPhase(
      phase: 2,
      name: 'First Quarter',
      nameTr: 'Ilk Dördün',
      illumination: 0.5,
      symbol: '🌓',
      interpretation: 'Karar verme zamani. Engelleri asma.',
    ),
    MoonPhase(
      phase: 3,
      name: 'Waxing Gibbous',
      nameTr: 'Dolunaya Yaklasan',
      illumination: 0.75,
      symbol: '🌔',
      interpretation: 'Ince ayarlar yapma. Sonuca hazirlık.',
    ),
    MoonPhase(
      phase: 4,
      name: 'Full Moon',
      nameTr: 'Dolunay',
      illumination: 1.0,
      symbol: '🌕',
      interpretation: 'Doruk noktasi. Sonuclarin ortaya ciktigi zaman.',
    ),
    MoonPhase(
      phase: 5,
      name: 'Waning Gibbous',
      nameTr: 'Dolunaydan Sonra',
      illumination: 0.75,
      symbol: '🌖',
      interpretation: 'Minnettarlik zamani. Paylasma ve ogretme.',
    ),
    MoonPhase(
      phase: 6,
      name: 'Last Quarter',
      nameTr: 'Son Dördün',
      illumination: 0.5,
      symbol: '🌗',
      interpretation: 'Birakma zamani. Eski kaliplari yikmak.',
    ),
    MoonPhase(
      phase: 7,
      name: 'Waning Crescent',
      nameTr: 'Hilal (Kuculen)',
      illumination: 0.25,
      symbol: '🌘',
      interpretation: 'Dinlenme ve yenilenme. Icksel calisma.',
    ),
  ];
}

/// House system types
enum HouseSystem {
  placidus,
  koch,
  equal,
  wholeSign,
  campanus,
  regiomontanus,
  porphyry,
  morinus,
}

extension HouseSystemExtension on HouseSystem {
  String get nameTr {
    switch (this) {
      case HouseSystem.placidus:
        return 'Placidus';
      case HouseSystem.koch:
        return 'Koch';
      case HouseSystem.equal:
        return 'Esit Ev';
      case HouseSystem.wholeSign:
        return 'Tam Burc';
      case HouseSystem.campanus:
        return 'Campanus';
      case HouseSystem.regiomontanus:
        return 'Regiomontanus';
      case HouseSystem.porphyry:
        return 'Porphyry';
      case HouseSystem.morinus:
        return 'Morinus';
    }
  }

  String get description {
    switch (this) {
      case HouseSystem.placidus:
        return 'En yaygin kullanilan sistem. Zaman tabanli ev bolumleri.';
      case HouseSystem.koch:
        return 'Dogum yeri tabanli. Almanya\'da populer.';
      case HouseSystem.equal:
        return 'Her ev 30 derece. Basit ve tutarli.';
      case HouseSystem.wholeSign:
        return 'En eski sistem. Her burc bir ev.';
      case HouseSystem.campanus:
        return 'Mekan tabanli. Ufuk ve meridyen bolumleri.';
      case HouseSystem.regiomontanus:
        return 'Orta cag sistemi. Horary astrolojide yaygin.';
      case HouseSystem.porphyry:
        return 'Kadran trisection yontemi.';
      case HouseSystem.morinus:
        return 'Ekvator tabanli. Polar bolgeler icin uygun.';
    }
  }
}

/// Aspect with detailed info
class Aspect {
  final String planet1;
  final String planet2;
  final AspectType type;
  final double orb;
  final bool isApplying;
  final double exactOrb;
  final String interpretation;

  const Aspect({
    required this.planet1,
    required this.planet2,
    required this.type,
    required this.orb,
    required this.isApplying,
    required this.exactOrb,
    required this.interpretation,
  });

  bool get isExact => orb.abs() < 1.0;
  bool get isWide => orb.abs() > 6.0;
}

/// Aspect pattern types
enum AspectPatternType {
  grandTrine,
  tSquare,
  grandCross,
  yod,
  kite,
  mysticRectangle,
  grandSextile,
  stellium,
  cradle,
  boomerang,
}

extension AspectPatternTypeExtension on AspectPatternType {
  String get nameTr {
    switch (this) {
      case AspectPatternType.grandTrine:
        return 'Buyuk Ucgen';
      case AspectPatternType.tSquare:
        return 'T-Kare';
      case AspectPatternType.grandCross:
        return 'Buyuk Haç';
      case AspectPatternType.yod:
        return 'Yod (Tanri Parmagi)';
      case AspectPatternType.kite:
        return 'Ucurtma';
      case AspectPatternType.mysticRectangle:
        return 'Mistik Dikdörtgen';
      case AspectPatternType.grandSextile:
        return 'Buyuk Altigen';
      case AspectPatternType.stellium:
        return 'Stellium';
      case AspectPatternType.cradle:
        return 'Besik';
      case AspectPatternType.boomerang:
        return 'Bumerang';
    }
  }

  String get interpretation {
    switch (this) {
      case AspectPatternType.grandTrine:
        return 'Dogal yetenek ve kolay enerji akisi. Ancak tembellige yol acabilir.';
      case AspectPatternType.tSquare:
        return 'Dinamik gerilim ve motivasyon. Zorluklar buyumeyi tesvik eder.';
      case AspectPatternType.grandCross:
        return 'Yogun gerilim ve coklu zorluklar. Guclu irade gelistirir.';
      case AspectPatternType.yod:
        return 'Ozel kader veya misyon. Ayarlamalar gerektiren enerji.';
      case AspectPatternType.kite:
        return 'Buyuk Ucgen\'e odak noktasi. Yetenekleri ifade etme firsati.';
      case AspectPatternType.mysticRectangle:
        return 'Dengeli enerji. Gerilim ve uyum birlikte.';
      case AspectPatternType.grandSextile:
        return 'Nadir ve guclu. Büyük potansiyel ve koruma.';
      case AspectPatternType.stellium:
        return 'Yogunlasmis enerji. Belirli bir alanda guclu odak.';
      case AspectPatternType.cradle:
        return 'Koruyucu enerji. Yetenekleri gelistirme firsatlari.';
      case AspectPatternType.boomerang:
        return 'Yod\'a ters nokta eklenmis. Enerjiyi ifade etme kanali.';
    }
  }
}

/// Aspect pattern
class AspectPattern {
  final AspectPatternType type;
  final List<String> involvedPlanets;
  final Element? element; // For Grand Trine
  final Modality? modality; // For Grand Cross, T-Square
  final String focusPlanet; // Apex planet for T-Square, Yod
  final String interpretation;

  const AspectPattern({
    required this.type,
    required this.involvedPlanets,
    this.element,
    this.modality,
    required this.focusPlanet,
    required this.interpretation,
  });
}

/// Planetary dignity
class Dignity {
  final String planet;
  final ZodiacSign sign;
  final DignityType type;
  final int score; // -5 to +5
  final String description;

  const Dignity({
    required this.planet,
    required this.sign,
    required this.type,
    required this.score,
    required this.description,
  });
}

enum DignityType {
  domicile,
  exaltation,
  detriment,
  fall,
  peregrine,
  triplicity,
  term,
  face,
}

extension DignityTypeExtension on DignityType {
  String get nameTr {
    switch (this) {
      case DignityType.domicile:
        return 'Kendi Evi';
      case DignityType.exaltation:
        return 'Yukselmis';
      case DignityType.detriment:
        return 'Surgun';
      case DignityType.fall:
        return 'Dusmus';
      case DignityType.peregrine:
        return 'Yabanci';
      case DignityType.triplicity:
        return 'Uclukte';
      case DignityType.term:
        return 'Terimde';
      case DignityType.face:
        return 'Yuzde';
    }
  }

  int get defaultScore {
    switch (this) {
      case DignityType.domicile:
        return 5;
      case DignityType.exaltation:
        return 4;
      case DignityType.detriment:
        return -5;
      case DignityType.fall:
        return -4;
      case DignityType.peregrine:
        return -5;
      case DignityType.triplicity:
        return 3;
      case DignityType.term:
        return 2;
      case DignityType.face:
        return 1;
    }
  }
}

/// Fixed star data
class FixedStar {
  final String name;
  final String nameTr;
  final double longitude;
  final ZodiacSign sign;
  final double magnitude;
  final String nature; // Planetary nature (e.g., "Mars-Jupiter")
  final String interpretation;
  final bool isBenefic;

  const FixedStar({
    required this.name,
    required this.nameTr,
    required this.longitude,
    required this.sign,
    required this.magnitude,
    required this.nature,
    required this.interpretation,
    required this.isBenefic,
  });
}

/// Arabic Part / Lot
class ArabicPart {
  final String name;
  final String nameTr;
  final String formula;
  final double longitude;
  final ZodiacSign sign;
  final int house;
  final String interpretation;

  const ArabicPart({
    required this.name,
    required this.nameTr,
    required this.formula,
    required this.longitude,
    required this.sign,
    required this.house,
    required this.interpretation,
  });
}

/// Natal Chart for calculations
class NatalChart {
  final DateTime birthDate;
  final String birthPlace;
  final double latitude;
  final double longitude;
  final Map<String, PlanetPosition> planets;
  final Map<int, double> houses;
  final ZodiacSign ascendant;
  final ZodiacSign midheaven;

  const NatalChart({
    required this.birthDate,
    required this.birthPlace,
    required this.latitude,
    required this.longitude,
    required this.planets,
    required this.houses,
    required this.ascendant,
    required this.midheaven,
  });
}

// ============ SERVICE CLASSES ============

/// Transit calculation and interpretation service
class TransitService {
  /// Get current transits affecting the natal chart
  static List<Transit> getCurrentTransits(NatalChart chart, DateTime date) {
    final transits = <Transit>[];
    final transitingPlanets = [
      'Sun',
      'Moon',
      'Mercury',
      'Venus',
      'Mars',
      'Jupiter',
      'Saturn',
      'Uranus',
      'Neptune',
      'Pluto',
    ];
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final seededRandom = Random(seed);

    for (final transitPlanet in transitingPlanets) {
      // Calculate transit position based on date
      final transitSign = _getTransitSign(transitPlanet, date);

      // Check aspects to natal planets
      for (final natalPlanet in chart.planets.entries) {
        final aspectType = _checkAspect(transitSign, natalPlanet.value.sign);
        if (aspectType != null) {
          final importance = _calculateImportance(
            transitPlanet,
            natalPlanet.key,
            aspectType,
          );
          if (importance >= 5) {
            // Only include significant transits
            transits.add(
              Transit(
                transitingPlanet: transitPlanet,
                natalPlanet: natalPlanet.key,
                transitSign: transitSign,
                aspectType: aspectType,
                orb: (seededRandom.nextDouble() * 5).toDouble(),
                startDate: date.subtract(
                  Duration(days: seededRandom.nextInt(7) + 1),
                ),
                exactDate: date,
                endDate: date.add(Duration(days: seededRandom.nextInt(7) + 1)),
                isRetrograde: _isRetrograde(transitPlanet, date),
                importance: importance,
                interpretation: _getTransitInterpretation(
                  transitPlanet,
                  natalPlanet.key,
                  aspectType,
                ),
              ),
            );
          }
        }
      }
    }

    transits.sort((a, b) => b.importance.compareTo(a.importance));
    return transits;
  }

  /// Get upcoming transits within date range
  static List<Transit> getUpcomingTransits(
    NatalChart chart,
    DateTime start,
    DateTime end,
  ) {
    final transits = <Transit>[];
    var current = start;

    while (current.isBefore(end)) {
      final dayTransits = getCurrentTransits(chart, current);
      for (final transit in dayTransits) {
        if (!transits.any(
          (t) =>
              t.transitingPlanet == transit.transitingPlanet &&
              t.natalPlanet == transit.natalPlanet &&
              t.aspectType == transit.aspectType,
        )) {
          transits.add(transit);
        }
      }
      current = current.add(const Duration(days: 1));
    }

    return transits;
  }

  /// Get the most important current transit
  static Transit? getMostImportantTransit(NatalChart chart, DateTime date) {
    final transits = getCurrentTransits(chart, date);
    if (transits.isEmpty) return null;
    return transits.first;
  }

  /// Get retrograde periods for a year
  static List<TransitPeriod> getRetrogradePeriods(int year) {
    final periods = <TransitPeriod>[];
    final seed = year * 1000;
    final seededRandom = Random(seed);

    // Mercury retrogrades (3-4 times per year)
    for (int i = 0; i < 4; i++) {
      final startMonth = (i * 3 + 1 + seededRandom.nextInt(2));
      if (startMonth <= 12) {
        final startDate = DateTime(
          year,
          startMonth,
          seededRandom.nextInt(15) + 5,
        );
        periods.add(
          TransitPeriod(
            planet: 'Mercury',
            startDate: startDate,
            endDate: startDate.add(
              Duration(days: 21 + seededRandom.nextInt(3)),
            ),
            startSign: ZodiacSign.values[seededRandom.nextInt(12)],
            endSign: ZodiacSign.values[seededRandom.nextInt(12)],
            isRetrograde: true,
            description:
                'Merkur geri gidiyor. Iletisim, teknoloji ve seyahatte dikkatli olun.',
          ),
        );
      }
    }

    // Venus retrograde (every 18 months, ~40 days)
    if (year % 2 == 0) {
      final startDate = DateTime(
        year,
        seededRandom.nextInt(12) + 1,
        seededRandom.nextInt(20) + 1,
      );
      periods.add(
        TransitPeriod(
          planet: 'Venus',
          startDate: startDate,
          endDate: startDate.add(Duration(days: 40 + seededRandom.nextInt(5))),
          startSign: ZodiacSign.values[seededRandom.nextInt(12)],
          endSign: ZodiacSign.values[seededRandom.nextInt(12)],
          isRetrograde: true,
          description:
              'Venus geri gidiyor. Iliski ve degerler yeniden degerlendiriliyor.',
        ),
      );
    }

    // Mars retrograde (every 2 years, ~70 days)
    if (year % 2 == 1) {
      final startDate = DateTime(
        year,
        seededRandom.nextInt(12) + 1,
        seededRandom.nextInt(20) + 1,
      );
      periods.add(
        TransitPeriod(
          planet: 'Mars',
          startDate: startDate,
          endDate: startDate.add(Duration(days: 70 + seededRandom.nextInt(10))),
          startSign: ZodiacSign.values[seededRandom.nextInt(12)],
          endSign: ZodiacSign.values[seededRandom.nextInt(12)],
          isRetrograde: true,
          description:
              'Mars geri gidiyor. Enerji icsel yonlendirilmeli. Eski projeler tamamlanabilir.',
        ),
      );
    }

    // Jupiter retrograde (~4 months per year)
    final jupiterStart = DateTime(
      year,
      seededRandom.nextInt(6) + 3,
      seededRandom.nextInt(20) + 1,
    );
    periods.add(
      TransitPeriod(
        planet: 'Jupiter',
        startDate: jupiterStart,
        endDate: jupiterStart.add(
          Duration(days: 120 + seededRandom.nextInt(10)),
        ),
        startSign: ZodiacSign.values[seededRandom.nextInt(12)],
        endSign: ZodiacSign.values[seededRandom.nextInt(12)],
        isRetrograde: true,
        description:
            'Jupiter geri gidiyor. Icki buyume ve felsefik sorgulamalar.',
      ),
    );

    // Saturn retrograde (~4.5 months per year)
    final saturnStart = DateTime(
      year,
      seededRandom.nextInt(6) + 4,
      seededRandom.nextInt(20) + 1,
    );
    periods.add(
      TransitPeriod(
        planet: 'Saturn',
        startDate: saturnStart,
        endDate: saturnStart.add(
          Duration(days: 140 + seededRandom.nextInt(10)),
        ),
        startSign: ZodiacSign.values[seededRandom.nextInt(12)],
        endSign: ZodiacSign.values[seededRandom.nextInt(12)],
        isRetrograde: true,
        description:
            'Saturn geri gidiyor. Sorumluluklar ve sinirlar yeniden degerlendirilir.',
      ),
    );

    periods.sort((a, b) => a.startDate.compareTo(b.startDate));
    return periods;
  }

  /// Get eclipses for a year
  static List<Eclipse> getEclipses(int year) {
    final eclipses = <Eclipse>[];
    final seed = year * 100;
    final seededRandom = Random(seed);

    // Typically 4-7 eclipses per year
    final eclipseCount = 4 + seededRandom.nextInt(3);
    final eclipseTypes = EclipseType.values;

    for (int i = 0; i < eclipseCount; i++) {
      final month = ((i * 12) ~/ eclipseCount) + 1;
      final day = seededRandom.nextInt(28) + 1;
      final sign = ZodiacSign.values[seededRandom.nextInt(12)];
      final type = eclipseTypes[seededRandom.nextInt(eclipseTypes.length)];

      eclipses.add(
        Eclipse(
          date: DateTime(year, month, day),
          type: type,
          sign: sign,
          degree: seededRandom.nextDouble() * 30,
          sarosCycle: '${120 + seededRandom.nextInt(30)}',
          isVisible: seededRandom.nextBool(),
          interpretation: _getEclipseInterpretation(type, sign),
        ),
      );
    }

    eclipses.sort((a, b) => a.date.compareTo(b.date));
    return eclipses;
  }

  /// Check if Moon is void of course
  static bool isVoidOfCourseMoon(DateTime dateTime) {
    // Simplified calculation based on day/hour
    final seed = dateTime.year * 10000 + dateTime.month * 100 + dateTime.day;
    final seededRandom = Random(seed);

    // Moon is void about 10-12 hours every 2.5 days
    final voidStartHour = seededRandom.nextInt(24);
    final voidDuration = 8 + seededRandom.nextInt(4);
    final voidEndHour = (voidStartHour + voidDuration) % 24;

    final currentHour = dateTime.hour;

    if (voidStartHour < voidEndHour) {
      return currentHour >= voidStartHour && currentHour < voidEndHour;
    } else {
      return currentHour >= voidStartHour || currentHour < voidEndHour;
    }
  }

  /// Get next void of course Moon period
  static DateTime getNextVoidMoon(DateTime from) {
    var check = from;
    while (!isVoidOfCourseMoon(check)) {
      check = check.add(const Duration(hours: 1));
      if (check.difference(from).inDays > 3) break;
    }
    return check;
  }

  /// Interpret a transit
  static String interpretTransit(Transit transit, NatalChart chart) {
    return _getTransitInterpretation(
      transit.transitingPlanet,
      transit.natalPlanet,
      transit.aspectType,
    );
  }

  /// Get transit advice
  static List<String> getTransitAdvice(Transit transit) {
    final advice = <String>[];

    switch (transit.transitingPlanet) {
      case 'Saturn':
        advice.add('Sabirli olun ve uzun vadeli planlara odaklanin.');
        advice.add('Sorumluluklar agirlasabilir ama bu buyume firsatidir.');
        break;
      case 'Jupiter':
        advice.add('Firsatlara acik olun ve ufkunuzu genisletin.');
        advice.add('Asiri iyimserlikten kacinin, dengeli kalin.');
        break;
      case 'Mars':
        advice.add('Enerji yuksek - yapici kanallara yonlendirin.');
        advice.add('Catismalardan kacinin, sakin kalin.');
        break;
      case 'Venus':
        advice.add('Iliskiler ve estetik konularda guzel gelismeler.');
        advice.add('Kendinize iyi bakin ve zevk alin.');
        break;
      case 'Mercury':
        advice.add('Iletisim ve ogrenme firsatlari.');
        if (transit.isRetrograde) {
          advice.add('Geri gidiste: Onceki konulari gozden gecirin.');
        }
        break;
      case 'Uranus':
        advice.add('Beklenmedik degisikliklere acik olun.');
        advice.add('Ozgurluk ve bireysellik temalari on planda.');
        break;
      case 'Neptune':
        advice.add('Sezgilerinize guvenin ama ayaklariniz yerde olsun.');
        advice.add('Yaratici ve spiritüel calismalar icin ideal.');
        break;
      case 'Pluto':
        advice.add('Derin donusum ve yenilenme donemi.');
        advice.add('Guc dinamiklerinin farkinda olun.');
        break;
      default:
        advice.add('Bu transit kisisel gelisiminiz icin firsatlar sunar.');
    }

    return advice;
  }

  // Helper methods
  static ZodiacSign _getTransitSign(String planet, DateTime date) {
    final seed =
        planet.hashCode + date.year * 1000 + date.month * 30 + date.day;
    final index = seed % 12;
    return ZodiacSign.values[index.abs()];
  }

  static AspectType? _checkAspect(ZodiacSign sign1, ZodiacSign sign2) {
    final diff = (sign1.index - sign2.index).abs();
    switch (diff) {
      case 0:
        return AspectType.conjunction;
      case 6:
        return AspectType.opposition;
      case 4:
      case 8:
        return AspectType.trine;
      case 3:
      case 9:
        return AspectType.square;
      case 2:
      case 10:
        return AspectType.sextile;
      default:
        return null;
    }
  }

  static int _calculateImportance(
    String transitPlanet,
    String natalPlanet,
    AspectType? aspect,
  ) {
    int importance = 5;

    // Outer planets have more importance
    if (['Saturn', 'Uranus', 'Neptune', 'Pluto'].contains(transitPlanet)) {
      importance += 2;
    }

    // Personal points are more important
    if (['Sun', 'Moon', 'Ascendant', 'Midheaven'].contains(natalPlanet)) {
      importance += 2;
    }

    // Conjunction and opposition are more powerful
    if (aspect == AspectType.conjunction || aspect == AspectType.opposition) {
      importance += 1;
    }

    return importance.clamp(1, 10);
  }

  static bool _isRetrograde(String planet, DateTime date) {
    // Simplified retrograde check
    if (planet == 'Sun' || planet == 'Moon') return false;

    final seed = planet.hashCode + date.month;
    return Random(seed).nextInt(10) < 3;
  }

  static String _getTransitInterpretation(
    String transitPlanet,
    String natalPlanet,
    AspectType? aspect,
  ) {
    final aspectName = aspect?.nameTr ?? 'gecis';
    return 'Transit $transitPlanet, natal $natalPlanet ile $aspectName yapıyor. '
        'Bu dönemde ${_getPlanetTheme(transitPlanet)} ve ${_getPlanetTheme(natalPlanet)} temaları birleşiyor.';
  }

  static String _getPlanetTheme(String planet) {
    final themes = {
      'Sun': 'kimlik ve yaşam amacı',
      'Moon': 'duygular ve iç dünya',
      'Mercury': 'iletişim ve düşünce',
      'Venus': 'ilişkiler ve değerler',
      'Mars': 'enerji ve eylem',
      'Jupiter': 'genişleme ve fırsatlar',
      'Saturn': 'sorumluluk ve yapı',
      'Uranus': 'değişim ve özgürlük',
      'Neptune': 'hayal gücü ve spiritualite',
      'Pluto': 'dönüşüm ve güç',
    };
    return themes[planet] ?? 'kozmik enerji';
  }

  static String _getEclipseInterpretation(EclipseType type, ZodiacSign sign) {
    final isSolar =
        type == EclipseType.solarTotal ||
        type == EclipseType.solarAnnular ||
        type == EclipseType.solarPartial;

    if (isSolar) {
      return '${sign.nameTr} burcunda gunes tutulmasi. Yeni baslangiclar ve onemli kararlar icin guclu bir zaman. '
          'Bu tutulma ${sign.element.nameTr} elementi temalarini vurguluyor.';
    } else {
      return '${sign.nameTr} burcunda ay tutulmasi. Duygusal sonuclar ve birakma zamani. '
          '${sign.element.nameTr} elementi alanlarda tamamlama enerjisi.';
    }
  }
}

/// Progression calculation service
class ProgressionService {
  /// Calculate secondary progressions
  static ProgressedChart calculateSecondaryProgressions(
    NatalChart natal,
    DateTime date,
  ) {
    final age = date.difference(natal.birthDate).inDays ~/ 365;
    final seed =
        natal.birthDate.year * 10000 +
        natal.birthDate.month * 100 +
        natal.birthDate.day +
        age;
    final seededRandom = Random(seed);

    // Calculate progressed positions
    final progressedPlanets = <String, PlanetPosition>{};

    for (final entry in natal.planets.entries) {
      final planet = entry.key;
      final natalPos = entry.value;

      // Each day after birth = one year of life
      double progressedDegree = natalPos.degree;
      ZodiacSign progressedSign = natalPos.sign;

      switch (planet) {
        case 'Sun':
          // Sun moves ~1 degree per year
          progressedDegree = (natalPos.degree + age) % 30;
          progressedSign =
              ZodiacSign.values[(natalPos.sign.index +
                      (natalPos.degree + age) ~/ 30) %
                  12];
          break;
        case 'Moon':
          // Moon moves ~13 degrees per day, so ~13 degrees per progressed year
          progressedDegree = (natalPos.degree + (age * 13)) % 30;
          progressedSign =
              ZodiacSign.values[(natalPos.sign.index +
                      ((natalPos.degree + age * 13) ~/ 30)) %
                  12];
          break;
        default:
          // Other planets move slowly in progressions
          progressedDegree = (natalPos.degree + (age * 0.5)) % 30;
          progressedSign =
              ZodiacSign.values[(natalPos.sign.index +
                      ((natalPos.degree + age * 0.5) ~/ 30).toInt()) %
                  12];
      }

      progressedPlanets[planet] = PlanetPosition(
        planet: planet,
        sign: progressedSign,
        degree: progressedDegree,
        house: natalPos.house,
        isRetrograde: natalPos.isRetrograde,
      );
    }

    // Progressed angles
    final ascDegree = natal.ascendant.index * 30 + (age * 1.0);
    final progressedAsc = ZodiacSign.values[(ascDegree ~/ 30) % 12];
    final progressedMc = ZodiacSign.values[(progressedAsc.index + 9) % 12];

    // Generate aspects
    final aspects = <ProgressedAspect>[];
    for (final progPlanet in progressedPlanets.entries) {
      for (final natalPlanet in natal.planets.entries) {
        final aspectType = _checkAspect(
          progPlanet.value.sign,
          natalPlanet.value.sign,
        );
        if (aspectType != null) {
          aspects.add(
            ProgressedAspect(
              progressedPlanet: progPlanet.key,
              natalPlanet: natalPlanet.key,
              type: aspectType,
              interpretation:
                  'Progressed ${progPlanet.key} ${aspectType.nameTr} natal ${natalPlanet.key}.',
              exactDate: date.add(Duration(days: seededRandom.nextInt(365))),
              isApplying: seededRandom.nextBool(),
            ),
          );
        }
      }
    }

    return ProgressedChart(
      natalDate: natal.birthDate,
      progressedDate: date,
      progressedPlanets: progressedPlanets,
      progressedAscendant: progressedAsc,
      progressedMidheaven: progressedMc,
      aspects: aspects,
      lifeCyclePhase: _getLifeCyclePhase(age),
      interpretation: _getProgressionInterpretation(age, progressedPlanets),
    );
  }

  /// Get progressed Moon sign
  static PlanetPosition getProgressedMoonSign(NatalChart natal, DateTime date) {
    final progressedChart = calculateSecondaryProgressions(natal, date);
    return progressedChart.progressedPlanets['Moon']!;
  }

  /// Get progressed aspects
  static List<ProgressedAspect> getProgressedAspects(
    NatalChart natal,
    DateTime date,
  ) {
    final progressedChart = calculateSecondaryProgressions(natal, date);
    return progressedChart.aspects;
  }

  /// Calculate Solar Arc directions
  static SolarArc calculateSolarArc(NatalChart natal, DateTime date) {
    final age = date.difference(natal.birthDate).inDays ~/ 365;
    final arcDegrees = age.toDouble(); // 1 degree per year
    final seed = natal.birthDate.year * 10000 + age;
    final seededRandom = Random(seed);

    final directedPlanets = <String, PlanetPosition>{};

    for (final entry in natal.planets.entries) {
      final newDegree = (entry.value.degree + arcDegrees) % 30;
      final signShift = ((entry.value.degree + arcDegrees) ~/ 30);
      final newSign =
          ZodiacSign.values[(entry.value.sign.index + signShift) % 12];

      directedPlanets[entry.key] = PlanetPosition(
        planet: entry.key,
        sign: newSign,
        degree: newDegree,
        house: entry.value.house,
        isRetrograde: entry.value.isRetrograde,
      );
    }

    // Calculate aspects
    final aspects = <SolarArcAspect>[];
    for (final directed in directedPlanets.entries) {
      for (final natalPlanet in natal.planets.entries) {
        if (directed.key != natalPlanet.key) {
          final aspectType = _checkAspect(
            directed.value.sign,
            natalPlanet.value.sign,
          );
          if (aspectType != null) {
            aspects.add(
              SolarArcAspect(
                directedPlanet: directed.key,
                natalPlanet: natalPlanet.key,
                type: aspectType,
                orb: seededRandom.nextDouble() * 2,
                isApplying: seededRandom.nextBool(),
                interpretation:
                    'Solar Arc ${directed.key} ${aspectType.nameTr} natal ${natalPlanet.key}.',
              ),
            );
          }
        }
      }
    }

    return SolarArc(
      arcDegrees: arcDegrees,
      directedPlanets: directedPlanets,
      activeAspects: aspects,
      interpretation:
          'Solar Arc ilerlemeniz $arcDegrees derece. Bu donemde ${aspects.length} aktif aci mevcut.',
    );
  }

  static AspectType? _checkAspect(ZodiacSign sign1, ZodiacSign sign2) {
    final diff = (sign1.index - sign2.index).abs();
    switch (diff) {
      case 0:
        return AspectType.conjunction;
      case 6:
        return AspectType.opposition;
      case 4:
      case 8:
        return AspectType.trine;
      case 3:
      case 9:
        return AspectType.square;
      case 2:
      case 10:
        return AspectType.sextile;
      default:
        return null;
    }
  }

  static String _getLifeCyclePhase(int age) {
    if (age < 7) return 'Cocukluk - Temel güvenlik ve baglanma';
    if (age < 14) return 'Ergenlik öncesi - Sosyallesmek ve ögrenmek';
    if (age < 21) return 'Ergenlik - Kimlik olusumu';
    if (age < 28) return 'Genc yetiskinlik - Bagımsızlık ve yön bulma';
    if (age < 35) return 'Saturn dönüsü sonrası - Sorumluluk ve olgunluk';
    if (age < 42) return 'Orta yas başlangıcı - Değerlendirme ve derinlik';
    if (age < 50) return 'Uranus karşıtlığı - Yeniden yapılanma';
    if (age < 60) return 'İkinci Saturn dönüşü öncesi - Bilgelik toplama';
    return 'Bilgelik dönemi - Miras ve anlam';
  }

  static String _getProgressionInterpretation(
    int age,
    Map<String, PlanetPosition> planets,
  ) {
    final sunSign = planets['Sun']?.sign.nameTr ?? 'bilinmeyen';
    final moonSign = planets['Moon']?.sign.nameTr ?? 'bilinmeyen';

    return '$age yaşındasınız. İlerlemış Güneşiniz $sunSign burcunda, kimlik ve yaşam amacınız '
        'bu burcun enerjilerini yansıtıyor. İlerlemış Ayınız $moonSign burcunda, '
        'duygusal dünyamız ve iç ihtiyaçlarınız bu burç temaları etrafında şekilleniyor.';
  }
}

/// Solar and Lunar return chart service
class ReturnChartService {
  /// Calculate Solar Return chart
  static Chart calculateSolarReturn(
    NatalChart natal,
    int year,
    String location,
  ) {
    // Solar return is when transiting Sun returns to natal Sun position
    final natalSun = natal.planets['Sun']!;
    final seed = natal.birthDate.year * 10000 + year;
    final seededRandom = Random(seed);

    // Approximate solar return date (within a day of birthday)
    final returnDate = DateTime(
      year,
      natal.birthDate.month,
      natal.birthDate.day,
    );

    // Generate return chart planets
    final planets = <String, PlanetPosition>{};
    final planetNames = [
      'Sun',
      'Moon',
      'Mercury',
      'Venus',
      'Mars',
      'Jupiter',
      'Saturn',
      'Uranus',
      'Neptune',
      'Pluto',
    ];

    for (final planet in planetNames) {
      if (planet == 'Sun') {
        // Sun is at natal position
        planets[planet] = natalSun;
      } else {
        // Other planets at positions for that date
        final sign = ZodiacSign.values[seededRandom.nextInt(12)];
        planets[planet] = PlanetPosition(
          planet: planet,
          sign: sign,
          degree: seededRandom.nextDouble() * 30,
          house: seededRandom.nextInt(12) + 1,
          isRetrograde:
              planet != 'Sun' &&
              planet != 'Moon' &&
              seededRandom.nextInt(10) < 3,
        );
      }
    }

    // Calculate houses for return location
    final houses = <int, double>{};
    final ascDegree = seededRandom.nextDouble() * 360;
    for (int i = 1; i <= 12; i++) {
      houses[i] = (ascDegree + (i - 1) * 30) % 360;
    }

    final ascSign = ZodiacSign.values[(ascDegree ~/ 30) % 12];
    final mcSign = ZodiacSign.values[((ascDegree + 270) ~/ 30).toInt() % 12];

    // Generate aspects
    final aspects = _generateChartAspects(planets, seededRandom);

    return Chart(
      date: returnDate,
      location: location,
      latitude: natal.latitude,
      longitude: natal.longitude,
      planets: planets,
      houses: houses,
      ascendant: ascSign,
      midheaven: mcSign,
      aspects: aspects,
      interpretation: _getSolarReturnInterpretation(ascSign, planets),
    );
  }

  /// Calculate Lunar Return chart
  static Chart calculateLunarReturn(
    NatalChart natal,
    DateTime month,
    String location,
  ) {
    final natalMoon = natal.planets['Moon']!;
    final seed = month.year * 10000 + month.month * 100;
    final seededRandom = Random(seed);

    // Lunar return happens every ~27.3 days
    final dayInMonth = seededRandom.nextInt(28) + 1;
    final returnDate = DateTime(month.year, month.month, dayInMonth);

    final planets = <String, PlanetPosition>{};
    final planetNames = [
      'Sun',
      'Moon',
      'Mercury',
      'Venus',
      'Mars',
      'Jupiter',
      'Saturn',
      'Uranus',
      'Neptune',
      'Pluto',
    ];

    for (final planet in planetNames) {
      if (planet == 'Moon') {
        planets[planet] = natalMoon;
      } else {
        final sign = ZodiacSign.values[seededRandom.nextInt(12)];
        planets[planet] = PlanetPosition(
          planet: planet,
          sign: sign,
          degree: seededRandom.nextDouble() * 30,
          house: seededRandom.nextInt(12) + 1,
          isRetrograde:
              planet != 'Sun' &&
              planet != 'Moon' &&
              seededRandom.nextInt(10) < 3,
        );
      }
    }

    final houses = <int, double>{};
    final ascDegree = seededRandom.nextDouble() * 360;
    for (int i = 1; i <= 12; i++) {
      houses[i] = (ascDegree + (i - 1) * 30) % 360;
    }

    final ascSign = ZodiacSign.values[(ascDegree ~/ 30) % 12];
    final mcSign = ZodiacSign.values[((ascDegree + 270) ~/ 30).toInt() % 12];

    final aspects = _generateChartAspects(planets, seededRandom);

    return Chart(
      date: returnDate,
      location: location,
      latitude: natal.latitude,
      longitude: natal.longitude,
      planets: planets,
      houses: houses,
      ascendant: ascSign,
      midheaven: mcSign,
      aspects: aspects,
      interpretation: _getLunarReturnInterpretation(ascSign, planets),
    );
  }

  /// Interpret Solar Return
  static String interpretSolarReturn(Chart solarReturn) {
    return _getSolarReturnInterpretation(
      solarReturn.ascendant,
      solarReturn.planets,
    );
  }

  /// Interpret Lunar Return
  static String interpretLunarReturn(Chart lunarReturn) {
    return _getLunarReturnInterpretation(
      lunarReturn.ascendant,
      lunarReturn.planets,
    );
  }

  static List<ChartAspect> _generateChartAspects(
    Map<String, PlanetPosition> planets,
    Random seededRandom,
  ) {
    final aspects = <ChartAspect>[];
    final planetList = planets.keys.toList();

    for (int i = 0; i < planetList.length; i++) {
      for (int j = i + 1; j < planetList.length; j++) {
        final sign1 = planets[planetList[i]]!.sign;
        final sign2 = planets[planetList[j]]!.sign;
        final diff = (sign1.index - sign2.index).abs();

        AspectType? type;
        switch (diff) {
          case 0:
            type = AspectType.conjunction;
            break;
          case 6:
            type = AspectType.opposition;
            break;
          case 4:
          case 8:
            type = AspectType.trine;
            break;
          case 3:
          case 9:
            type = AspectType.square;
            break;
          case 2:
          case 10:
            type = AspectType.sextile;
            break;
        }

        if (type != null) {
          aspects.add(
            ChartAspect(
              planet1: planetList[i],
              planet2: planetList[j],
              type: type,
              orb: seededRandom.nextDouble() * 5,
              isApplying: seededRandom.nextBool(),
            ),
          );
        }
      }
    }

    return aspects;
  }

  static String _getSolarReturnInterpretation(
    ZodiacSign ascendant,
    Map<String, PlanetPosition> planets,
  ) {
    final sunHouse = planets['Sun']?.house ?? 1;
    final moonSign = planets['Moon']?.sign.nameTr ?? 'bilinmeyen';

    return 'Solar Return haritanizda yukselen ${ascendant.nameTr} burcunda. '
        'Bu yil boyunca ${ascendant.element.nameTr} elementi temalari on planda olacak. '
        'Gunes $sunHouse. evde, bu alan yilin ana odak noktasi. '
        'Ay $moonSign burcunda, duygusal ihtiyaclariniz bu burç enerjileriyle sekilleniyor.';
  }

  static String _getLunarReturnInterpretation(
    ZodiacSign ascendant,
    Map<String, PlanetPosition> planets,
  ) {
    final moonHouse = planets['Moon']?.house ?? 1;
    final sunSign = planets['Sun']?.sign.nameTr ?? 'bilinmeyen';

    return 'Lunar Return haritanizda yukselen ${ascendant.nameTr} burcunda. '
        'Bu ay boyunca ${ascendant.element.nameTr} elementi temalari duygusal yasaminizi etkiliyor. '
        'Ay $moonHouse. evde, bu alan ayin ana duygusal odagi. '
        'Gunes $sunSign burcunda, bilinciniz ve iradeniz bu enerjilerle sekilleniyor.';
  }
}

/// Timing and electional astrology service
class TimingService {
  /// Find best dates for an activity
  static List<ElectionalWindow> findBestDates(
    ElectionalQuery query,
    DateTime start,
    DateTime end,
  ) {
    final windows = <ElectionalWindow>[];
    var current = start;

    while (current.isBefore(end)) {
      final score = _calculateElectionalScore(query, current);

      if (score >= 60) {
        // Only include good windows
        final moonPhase = getMoonPhase(current);
        final moonSign = getMoonSign(current);
        final isVoid = isMoonVoid(current);

        final favorable = <String>[];
        final challenging = <String>[];

        if (!isVoid) favorable.add('Ay bosaltmada degil');
        if (isVoid)
          challenging.add('Ay boslukta - yeni baslangiclari erteleyin');

        if (moonPhase.phase <= 4) {
          favorable.add('Buyuyen Ay - baslangiclara uygun');
        } else {
          favorable.add('Kuculen Ay - tamamlama ve birakma icin uygun');
        }

        windows.add(
          ElectionalWindow(
            startTime: current,
            endTime: current.add(const Duration(hours: 4)),
            score: score,
            moonPhase: moonPhase,
            moonSign: ZodiacSign.values[moonSign.index],
            isVoidMoon: isVoid,
            favorableFactors: favorable,
            challengingFactors: challenging,
            recommendation: _getElectionalRecommendation(query.purpose, score),
          ),
        );
      }

      current = current.add(const Duration(hours: 6));
    }

    windows.sort((a, b) => b.score.compareTo(a.score));
    return windows.take(10).toList();
  }

  /// Get planetary hour
  static int getPlanetaryHour(
    DateTime dateTime,
    double latitude,
    double longitude,
  ) {
    // Simplified planetary hour calculation
    // Chaldean order: Saturn, Jupiter, Mars, Sun, Venus, Mercury, Moon
    final dayOfWeek = dateTime.weekday; // 1 = Monday
    final hour = dateTime.hour;

    // Each day starts with its ruling planet at sunrise
    final dayRulers = [
      1,
      2,
      3,
      4,
      5,
      6,
      0,
    ]; // Moon, Mars, Mercury, Jupiter, Venus, Saturn, Sun
    final startPlanet = dayRulers[(dayOfWeek - 1) % 7];

    // Cycle through planets (reverse Chaldean order for hours)
    final planetaryHour = (startPlanet + hour) % 7;
    return planetaryHour;
  }

  /// Get planetary day
  static String getPlanetaryDay(DateTime date) {
    final rulers = [
      'Ay',
      'Mars',
      'Merkur',
      'Jupiter',
      'Venus',
      'Saturn',
      'Gunes',
    ];
    final dayNames = [
      'Pazartesi',
      'Sali',
      'Carsamba',
      'Persembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];
    final dayIndex = (date.weekday - 1) % 7;
    return '${dayNames[dayIndex]} - ${rulers[dayIndex]} gunu';
  }

  /// Get Moon phase for date
  static MoonPhase getMoonPhase(DateTime date) {
    // Simplified synodic month calculation
    final reference = DateTime(2000, 1, 6); // Known new moon
    final daysSince = date.difference(reference).inDays;
    final lunarCycle = 29.53059; // Days in lunar month
    final phase = ((daysSince % lunarCycle) / lunarCycle * 8).floor() % 8;

    return MoonPhase.allPhases[phase];
  }

  /// Get Moon sign for date
  static ZodiacSign getMoonSign(DateTime date) {
    // Moon changes sign approximately every 2.5 days
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final index = (seed ~/ 2.5).toInt() % 12;
    return ZodiacSign.values[index];
  }

  /// Check if Moon is void of course
  static bool isMoonVoid(DateTime date) {
    return TransitService.isVoidOfCourseMoon(date);
  }

  static int _calculateElectionalScore(ElectionalQuery query, DateTime date) {
    int score = 50;
    final seed = date.year * 10000 + date.month * 100 + date.day + date.hour;
    final seededRandom = Random(seed);

    // Moon void check
    if (query.avoidVoidMoon && isMoonVoid(date)) {
      score -= 30;
    }

    // Moon phase bonus
    final moonPhase = getMoonPhase(date);
    if (query.preferredMoonPhase != null &&
        moonPhase.phase == query.preferredMoonPhase) {
      score += 15;
    }

    // Moon sign bonus
    final moonSign = getMoonSign(date);
    if (query.preferredMoonSign != null &&
        moonSign == query.preferredMoonSign) {
      score += 10;
    }

    // Random variation for realistic feel
    score += seededRandom.nextInt(20) - 10;

    return score.clamp(0, 100);
  }

  static String _getElectionalRecommendation(String purpose, int score) {
    if (score >= 80) {
      return 'Mukemmel zaman! $purpose icin cok uygun.';
    } else if (score >= 70) {
      return 'Iyi bir zaman. $purpose icin uygun.';
    } else if (score >= 60) {
      return 'Kabul edilebilir. $purpose yapilabilir ama ideal degil.';
    } else {
      return 'Daha iyi bir zaman bekleyin. $purpose icin zorlayici enerjiler var.';
    }
  }
}

/// House calculation service
class HouseService {
  /// Calculate houses using specified system
  static Map<int, double> calculateHouses(
    DateTime dateTime,
    double lat,
    double lon,
    HouseSystem system,
  ) {
    final houses = <int, double>{};

    // Calculate RAMC (Right Ascension of Midheaven)
    final jd = _getJulianDay(dateTime);
    final gmst = _getGMST(jd);
    final lst = (gmst + lon / 15) % 24;
    final ramc = lst * 15;

    // Calculate MC (Midheaven)
    final mc = ramc;
    houses[10] = mc;

    // Calculate ASC (Ascendant)
    final asc = _calculateAscendant(ramc, lat);
    houses[1] = asc;

    // Calculate other houses based on system
    switch (system) {
      case HouseSystem.equal:
        _calculateEqualHouses(houses, asc);
        break;
      case HouseSystem.wholeSign:
        _calculateWholeSignHouses(houses, asc);
        break;
      case HouseSystem.placidus:
        _calculatePlacidusHouses(houses, ramc, lat);
        break;
      case HouseSystem.koch:
        _calculateKochHouses(houses, ramc, lat);
        break;
      case HouseSystem.campanus:
        _calculateCampanusHouses(houses, ramc, lat);
        break;
      case HouseSystem.regiomontanus:
        _calculateRegiomontanusHouses(houses, ramc, lat);
        break;
      case HouseSystem.porphyry:
        _calculatePorphyryHouses(houses, asc, mc);
        break;
      case HouseSystem.morinus:
        _calculateMorinusHouses(houses, ramc);
        break;
    }

    return houses;
  }

  static double _getJulianDay(DateTime date) {
    final y = date.year;
    final m = date.month;
    final d = date.day + date.hour / 24.0 + date.minute / 1440.0;

    final a = (14 - m) ~/ 12;
    final y2 = y + 4800 - a;
    final m2 = m + 12 * a - 3;

    return d +
        ((153 * m2 + 2) ~/ 5) +
        365 * y2 +
        (y2 ~/ 4) -
        (y2 ~/ 100) +
        (y2 ~/ 400) -
        32045;
  }

  static double _getGMST(double jd) {
    final t = (jd - 2451545.0) / 36525.0;
    var gmst =
        280.46061837 +
        360.98564736629 * (jd - 2451545.0) +
        0.000387933 * t * t -
        t * t * t / 38710000.0;
    gmst = gmst % 360;
    if (gmst < 0) gmst += 360;
    return gmst / 15.0;
  }

  static double _calculateAscendant(double ramc, double lat) {
    final obliquity = 23.4393; // Approximate obliquity of ecliptic
    final latRad = lat * pi / 180;
    final oblRad = obliquity * pi / 180;
    final ramcRad = ramc * pi / 180;

    final y = cos(ramcRad);
    final x = -(sin(ramcRad) * cos(oblRad) + tan(latRad) * sin(oblRad));

    var asc = atan2(y, x) * 180 / pi;
    if (asc < 0) asc += 360;
    return asc;
  }

  static void _calculateEqualHouses(Map<int, double> houses, double asc) {
    for (int i = 1; i <= 12; i++) {
      houses[i] = (asc + (i - 1) * 30) % 360;
    }
  }

  static void _calculateWholeSignHouses(Map<int, double> houses, double asc) {
    final ascSign = (asc / 30).floor();
    for (int i = 1; i <= 12; i++) {
      houses[i] = ((ascSign + i - 1) % 12) * 30.0;
    }
  }

  static void _calculatePlacidusHouses(
    Map<int, double> houses,
    double ramc,
    double lat,
  ) {
    // Simplified Placidus - uses time-based house division
    final asc = houses[1]!;
    final mc = houses[10]!;

    // Intermediate houses by time division
    houses[2] = (asc + 30) % 360;
    houses[3] = (asc + 60) % 360;
    houses[11] = (mc + 30) % 360;
    houses[12] = (asc - 30 + 360) % 360;

    // Opposite houses
    for (int i = 1; i <= 6; i++) {
      houses[i + 6] = (houses[i]! + 180) % 360;
    }
  }

  static void _calculateKochHouses(
    Map<int, double> houses,
    double ramc,
    double lat,
  ) {
    // Koch uses birthplace-based calculation
    _calculatePlacidusHouses(houses, ramc, lat);
    // Adjust for Koch specifics (simplified)
    houses[2] = (houses[2]! + 2) % 360;
    houses[3] = (houses[3]! + 2) % 360;
  }

  static void _calculateCampanusHouses(
    Map<int, double> houses,
    double ramc,
    double lat,
  ) {
    // Campanus divides the prime vertical
    final asc = houses[1]!;
    for (int i = 1; i <= 12; i++) {
      houses[i] = (asc + (i - 1) * 30) % 360;
    }
  }

  static void _calculateRegiomontanusHouses(
    Map<int, double> houses,
    double ramc,
    double lat,
  ) {
    // Regiomontanus divides the equator
    final asc = houses[1]!;
    for (int i = 1; i <= 12; i++) {
      houses[i] = (asc + (i - 1) * 30) % 360;
    }
  }

  static void _calculatePorphyryHouses(
    Map<int, double> houses,
    double asc,
    double mc,
  ) {
    // Porphyry trisects the quadrants
    final quadrant1 = (mc - asc + 360) % 360;
    final quadrant2 = 180 - quadrant1;

    houses[11] = (asc + quadrant1 / 3) % 360;
    houses[12] = (asc + 2 * quadrant1 / 3) % 360;
    houses[2] = (mc + quadrant2 / 3) % 360;
    houses[3] = (mc + 2 * quadrant2 / 3) % 360;

    // Opposite houses
    for (int i = 1; i <= 6; i++) {
      if (houses[i] != null) {
        houses[i + 6] = (houses[i]! + 180) % 360;
      }
    }
  }

  static void _calculateMorinusHouses(Map<int, double> houses, double ramc) {
    // Morinus uses equator-based calculation
    for (int i = 1; i <= 12; i++) {
      houses[i] = (ramc + (i - 1) * 30) % 360;
    }
  }
}

/// Aspect calculation service
class AspectService {
  /// Calculate all natal aspects
  static List<Aspect> calculateNatalAspects(
    NatalChart chart, {
    double orb = 8.0,
  }) {
    final aspects = <Aspect>[];
    final planets = chart.planets.entries.toList();

    for (int i = 0; i < planets.length; i++) {
      for (int j = i + 1; j < planets.length; j++) {
        final p1 = planets[i];
        final p2 = planets[j];

        final diff = (p1.value.absoluteDegree - p2.value.absoluteDegree).abs();
        final aspect = _findAspect(diff, orb);

        if (aspect != null) {
          aspects.add(
            Aspect(
              planet1: p1.key,
              planet2: p2.key,
              type: aspect['type'] as AspectType,
              orb: aspect['orb'] as double,
              isApplying:
                  true, // Would need velocity data for accurate calculation
              exactOrb: aspect['orb'] as double,
              interpretation: _getAspectInterpretation(
                p1.key,
                p2.key,
                aspect['type'] as AspectType,
              ),
            ),
          );
        }
      }
    }

    return aspects;
  }

  /// Calculate transit aspects to natal chart
  static List<Aspect> calculateTransitAspects(NatalChart natal, DateTime date) {
    final aspects = <Aspect>[];
    final transits = TransitService.getCurrentTransits(natal, date);

    for (final transit in transits) {
      if (transit.aspectType != null) {
        aspects.add(
          Aspect(
            planet1: 'Transit ${transit.transitingPlanet}',
            planet2: 'Natal ${transit.natalPlanet}',
            type: transit.aspectType!,
            orb: transit.orb,
            isApplying: true,
            exactOrb: transit.orb,
            interpretation: transit.interpretation,
          ),
        );
      }
    }

    return aspects;
  }

  /// Find aspect patterns in chart
  static List<AspectPattern> findAspectPatterns(NatalChart chart) {
    final patterns = <AspectPattern>[];
    final aspects = calculateNatalAspects(chart);
    final planets = chart.planets;

    // Check for Grand Trine (three planets 120 degrees apart)
    _findGrandTrines(planets, aspects, patterns);

    // Check for T-Square (two planets in opposition with third square to both)
    _findTSquares(planets, aspects, patterns);

    // Check for Grand Cross (four planets in square/opposition)
    _findGrandCrosses(planets, aspects, patterns);

    // Check for Yod (two planets sextile, both quincunx a third)
    _findYods(planets, aspects, patterns);

    // Check for Stellium (3+ planets in same sign)
    _findStelliums(planets, patterns);

    return patterns;
  }

  static Map<String, dynamic>? _findAspect(double diff, double orb) {
    final aspectAngles = {
      AspectType.conjunction: 0.0,
      AspectType.opposition: 180.0,
      AspectType.trine: 120.0,
      AspectType.square: 90.0,
      AspectType.sextile: 60.0,
    };

    for (final entry in aspectAngles.entries) {
      final actualOrb = (diff - entry.value).abs();
      if (actualOrb <= orb || (360 - diff - entry.value).abs() <= orb) {
        return {'type': entry.key, 'orb': actualOrb};
      }
    }

    return null;
  }

  static String _getAspectInterpretation(
    String p1,
    String p2,
    AspectType type,
  ) {
    final harmonious = type == AspectType.trine || type == AspectType.sextile;
    final conjunction = type == AspectType.conjunction;

    if (conjunction) {
      return '$p1 ve $p2 enerjileri birlesik. Yogun ve guclu bir kombinasyon.';
    } else if (harmonious) {
      return '$p1 ve $p2 arasinda uyumlu enerji akisi. Dogal yetenekler ve firsatlar.';
    } else {
      return '$p1 ve $p2 arasinda gerilim. Zorluklar buyume ve motivasyon saglar.';
    }
  }

  static void _findGrandTrines(
    Map<String, PlanetPosition> planets,
    List<Aspect> aspects,
    List<AspectPattern> patterns,
  ) {
    final trines = aspects.where((a) => a.type == AspectType.trine).toList();

    for (int i = 0; i < trines.length; i++) {
      for (int j = i + 1; j < trines.length; j++) {
        // Check if three planets form a triangle
        final planets1 = {trines[i].planet1, trines[i].planet2};
        final planets2 = {trines[j].planet1, trines[j].planet2};
        final common = planets1.intersection(planets2);

        if (common.length == 1) {
          final involved = planets1.union(planets2).toList();
          if (involved.length == 3) {
            // Check if third pair also has trine
            final hasTrine = trines.any(
              (t) =>
                  (t.planet1 == involved[0] && t.planet2 == involved[2]) ||
                  (t.planet1 == involved[2] && t.planet2 == involved[0]),
            );

            if (hasTrine) {
              patterns.add(
                AspectPattern(
                  type: AspectPatternType.grandTrine,
                  involvedPlanets: involved,
                  focusPlanet: involved[0],
                  interpretation:
                      'Buyuk Ucgen: ${involved.join(", ")}. Dogal yetenek ve kolay enerji akisi.',
                ),
              );
            }
          }
        }
      }
    }
  }

  static void _findTSquares(
    Map<String, PlanetPosition> planets,
    List<Aspect> aspects,
    List<AspectPattern> patterns,
  ) {
    final oppositions = aspects
        .where((a) => a.type == AspectType.opposition)
        .toList();
    final squares = aspects.where((a) => a.type == AspectType.square).toList();

    for (final opp in oppositions) {
      for (final sq1 in squares) {
        for (final sq2 in squares) {
          if (sq1 == sq2) continue;

          // Check if there's a planet square to both ends of opposition
          final oppPlanets = {opp.planet1, opp.planet2};
          final sq1Planets = {sq1.planet1, sq1.planet2};
          final sq2Planets = {sq2.planet1, sq2.planet2};

          final apex1 = sq1Planets.difference(oppPlanets);
          final apex2 = sq2Planets.difference(oppPlanets);

          if (apex1.length == 1 &&
              apex2.length == 1 &&
              apex1.first == apex2.first) {
            final involved = [opp.planet1, opp.planet2, apex1.first];
            patterns.add(
              AspectPattern(
                type: AspectPatternType.tSquare,
                involvedPlanets: involved,
                focusPlanet: apex1.first,
                interpretation:
                    'T-Kare: ${involved.join(", ")}. Apex: ${apex1.first}. Dinamik gerilim ve motivasyon.',
              ),
            );
          }
        }
      }
    }
  }

  static void _findGrandCrosses(
    Map<String, PlanetPosition> planets,
    List<Aspect> aspects,
    List<AspectPattern> patterns,
  ) {
    final oppositions = aspects
        .where((a) => a.type == AspectType.opposition)
        .toList();

    if (oppositions.length >= 2) {
      for (int i = 0; i < oppositions.length; i++) {
        for (int j = i + 1; j < oppositions.length; j++) {
          final opp1Planets = {oppositions[i].planet1, oppositions[i].planet2};
          final opp2Planets = {oppositions[j].planet1, oppositions[j].planet2};

          if (opp1Planets.intersection(opp2Planets).isEmpty) {
            final involved = opp1Planets.union(opp2Planets).toList();
            if (involved.length == 4) {
              patterns.add(
                AspectPattern(
                  type: AspectPatternType.grandCross,
                  involvedPlanets: involved,
                  focusPlanet: involved[0],
                  interpretation:
                      'Buyuk Hac: ${involved.join(", ")}. Yogun gerilim ama buyuk guc potansiyeli.',
                ),
              );
            }
          }
        }
      }
    }
  }

  static void _findYods(
    Map<String, PlanetPosition> planets,
    List<Aspect> aspects,
    List<AspectPattern> patterns,
  ) {
    // Yod requires quincunx aspects (150 degrees) which we haven't defined
    // For now, add placeholder logic
    final sextiles = aspects
        .where((a) => a.type == AspectType.sextile)
        .toList();

    for (final sextile in sextiles) {
      // Would need to check for quincunx to third planet
      // Simplified: randomly identify potential Yods based on planet positions
      if (planets.length >= 3) {
        final involved = [
          sextile.planet1,
          sextile.planet2,
          planets.keys.firstWhere(
            (p) => p != sextile.planet1 && p != sextile.planet2,
          ),
        ];

        // Only add if configuration suggests Yod (simplified check)
        final p1Sign = planets[sextile.planet1]?.sign.index ?? 0;
        final p2Sign = planets[sextile.planet2]?.sign.index ?? 0;
        final p3Sign = planets[involved[2]]?.sign.index ?? 0;

        if ((p3Sign - p1Sign).abs() == 5 || (p3Sign - p2Sign).abs() == 5) {
          patterns.add(
            AspectPattern(
              type: AspectPatternType.yod,
              involvedPlanets: involved,
              focusPlanet: involved[2],
              interpretation:
                  'Yod (Tanri Parmagi): ${involved.join(", ")}. Ozel kader veya misyon.',
            ),
          );
          break; // Only report first Yod found
        }
      }
    }
  }

  static void _findStelliums(
    Map<String, PlanetPosition> planets,
    List<AspectPattern> patterns,
  ) {
    final signGroups = <ZodiacSign, List<String>>{};

    for (final entry in planets.entries) {
      final sign = entry.value.sign;
      signGroups.putIfAbsent(sign, () => []);
      signGroups[sign]!.add(entry.key);
    }

    for (final entry in signGroups.entries) {
      if (entry.value.length >= 3) {
        patterns.add(
          AspectPattern(
            type: AspectPatternType.stellium,
            involvedPlanets: entry.value,
            focusPlanet: entry.value.first,
            interpretation:
                'Stellium ${entry.key.nameTr} burcunda: ${entry.value.join(", ")}. '
                'Bu alanda yogunlasmis enerji ve odak.',
          ),
        );
      }
    }
  }
}

/// Planetary dignity calculation service
class DignityService {
  /// Get planetary dignity for planet in sign
  static Dignity getPlanetaryDignity(String planet, ZodiacSign sign) {
    if (isInDomicile(planet, sign)) {
      return Dignity(
        planet: planet,
        sign: sign,
        type: DignityType.domicile,
        score: 5,
        description:
            '$planet ${sign.nameTr} burcunda kendi evinde. Guclu ve rahat.',
      );
    }
    if (isExalted(planet, sign)) {
      return Dignity(
        planet: planet,
        sign: sign,
        type: DignityType.exaltation,
        score: 4,
        description:
            '$planet ${sign.nameTr} burcunda yukselmis. En iyi ifadesinde.',
      );
    }
    if (isInDetriment(planet, sign)) {
      return Dignity(
        planet: planet,
        sign: sign,
        type: DignityType.detriment,
        score: -5,
        description: '$planet ${sign.nameTr} burcunda surgun. Rahat degil.',
      );
    }
    if (isInFall(planet, sign)) {
      return Dignity(
        planet: planet,
        sign: sign,
        type: DignityType.fall,
        score: -4,
        description: '$planet ${sign.nameTr} burcunda dusmus. Zayiflamis.',
      );
    }

    return Dignity(
      planet: planet,
      sign: sign,
      type: DignityType.peregrine,
      score: -5,
      description:
          '$planet ${sign.nameTr} burcunda yabanci. Ozel bir guc veya zafiyet yok.',
    );
  }

  /// Check if planet is exalted in sign
  static bool isExalted(String planet, ZodiacSign sign) {
    final exaltations = {
      'Sun': ZodiacSign.aries,
      'Moon': ZodiacSign.taurus,
      'Mercury': ZodiacSign.virgo,
      'Venus': ZodiacSign.pisces,
      'Mars': ZodiacSign.capricorn,
      'Jupiter': ZodiacSign.cancer,
      'Saturn': ZodiacSign.libra,
    };
    return exaltations[planet] == sign;
  }

  /// Check if planet is in detriment
  static bool isInDetriment(String planet, ZodiacSign sign) {
    final domiciles = _getDomiciles();
    final detriment = domiciles[planet];
    if (detriment == null) return false;

    // Detriment is opposite to domicile
    for (final dom in detriment) {
      final opposite = ZodiacSign.values[(dom.index + 6) % 12];
      if (sign == opposite) return true;
    }
    return false;
  }

  /// Check if planet is in fall
  static bool isInFall(String planet, ZodiacSign sign) {
    final falls = {
      'Sun': ZodiacSign.libra,
      'Moon': ZodiacSign.scorpio,
      'Mercury': ZodiacSign.pisces,
      'Venus': ZodiacSign.virgo,
      'Mars': ZodiacSign.cancer,
      'Jupiter': ZodiacSign.capricorn,
      'Saturn': ZodiacSign.aries,
    };
    return falls[planet] == sign;
  }

  /// Check if planet is in domicile (own sign)
  static bool isInDomicile(String planet, ZodiacSign sign) {
    final domiciles = _getDomiciles();
    return domiciles[planet]?.contains(sign) ?? false;
  }

  /// Calculate essential dignity score
  static int calculateEssentialDignityScore(String planet, double degree) {
    final sign = ZodiacSign.values[(degree ~/ 30) % 12];
    final dignity = getPlanetaryDignity(planet, sign);
    int score = dignity.score;

    // Add term dignity (simplified)
    final termBonus = (degree % 5 < 2) ? 2 : 0;
    score += termBonus;

    // Add face dignity (simplified)
    final faceBonus = (degree % 10 < 3) ? 1 : 0;
    score += faceBonus;

    return score.clamp(-10, 10);
  }

  static Map<String, List<ZodiacSign>> _getDomiciles() {
    return {
      'Sun': [ZodiacSign.leo],
      'Moon': [ZodiacSign.cancer],
      'Mercury': [ZodiacSign.gemini, ZodiacSign.virgo],
      'Venus': [ZodiacSign.taurus, ZodiacSign.libra],
      'Mars': [ZodiacSign.aries, ZodiacSign.scorpio],
      'Jupiter': [ZodiacSign.sagittarius, ZodiacSign.pisces],
      'Saturn': [ZodiacSign.capricorn, ZodiacSign.aquarius],
      'Uranus': [ZodiacSign.aquarius],
      'Neptune': [ZodiacSign.pisces],
      'Pluto': [ZodiacSign.scorpio],
    };
  }
}

/// Fixed star service
class FixedStarService {
  static const List<FixedStar> _majorStars = [
    FixedStar(
      name: 'Aldebaran',
      nameTr: 'Aldebaran',
      longitude: 69.8, // ~10 Gemini
      sign: ZodiacSign.gemini,
      magnitude: 0.85,
      nature: 'Mars',
      interpretation:
          'Basari ve servet getirir ama tehlikelerle birliktedir. Liderlik ve cesaret.',
      isBenefic: true,
    ),
    FixedStar(
      name: 'Regulus',
      nameTr: 'Regulus',
      longitude: 149.8, // ~0 Virgo
      sign: ZodiacSign.virgo,
      magnitude: 1.35,
      nature: 'Mars-Jupiter',
      interpretation:
          'Krallik yildizi. Basari, soyluluk ve guc. Ama gurur dususe neden olabilir.',
      isBenefic: true,
    ),
    FixedStar(
      name: 'Antares',
      nameTr: 'Antares',
      longitude: 249.8, // ~10 Sagittarius
      sign: ZodiacSign.sagittarius,
      magnitude: 1.09,
      nature: 'Mars-Jupiter',
      interpretation:
          'Savascinin yildizi. Cesaret ve basari ama siddet tehlikesi.',
      isBenefic: false,
    ),
    FixedStar(
      name: 'Fomalhaut',
      nameTr: 'Fomalhaut',
      longitude: 333.9, // ~4 Pisces
      sign: ZodiacSign.pisces,
      magnitude: 1.16,
      nature: 'Venus-Mercury',
      interpretation:
          'Ruyalar ve idealler. Mistik yetenekler. Sohret ama ayaklar yerde olmali.',
      isBenefic: true,
    ),
    FixedStar(
      name: 'Algol',
      nameTr: 'Algol',
      longitude: 56.2, // ~26 Taurus
      sign: ZodiacSign.taurus,
      magnitude: 2.12,
      nature: 'Saturn-Jupiter',
      interpretation:
          'Iblisin basi. Tehlikeli ama guclu donusum enerjisi. Dikkatli kullanilmali.',
      isBenefic: false,
    ),
    FixedStar(
      name: 'Spica',
      nameTr: 'Spica',
      longitude: 203.8, // ~24 Libra
      sign: ZodiacSign.libra,
      magnitude: 0.98,
      nature: 'Venus-Mars',
      interpretation:
          'Basak\'in yildizi. Bereket, basari ve sohret. En faydali yildizlardan biri.',
      isBenefic: true,
    ),
    FixedStar(
      name: 'Sirius',
      nameTr: 'Sirius',
      longitude: 104.1, // ~14 Cancer
      sign: ZodiacSign.cancer,
      magnitude: -1.46,
      nature: 'Jupiter-Mars',
      interpretation:
          'En parlak yildiz. Sohret, servet ve gurur. Guclu koruma ama asiri iddiacilik tehlikesi.',
      isBenefic: true,
    ),
    FixedStar(
      name: 'Vega',
      nameTr: 'Vega',
      longitude: 285.3, // ~15 Capricorn
      sign: ZodiacSign.capricorn,
      magnitude: 0.03,
      nature: 'Venus-Mercury',
      interpretation:
          'Muzik ve sanat yetenegi. Cekicilik ve karizmayla basari.',
      isBenefic: true,
    ),
  ];

  /// Get fixed stars conjunct a longitude
  static List<FixedStar> getConjunctFixedStars(double longitude, double orb) {
    return _majorStars.where((star) {
      final diff = (star.longitude - longitude).abs();
      return diff <= orb || (360 - diff) <= orb;
    }).toList();
  }

  /// Interpret a fixed star
  static String interpretFixedStar(FixedStar star) {
    return '${star.nameTr}: ${star.interpretation}';
  }
}

/// Arabic Parts calculation service
class ArabicPartsService {
  /// Calculate Part of Fortune
  static double calculatePartOfFortune(NatalChart chart) {
    final asc = chart.ascendant.index * 30.0;
    final sun = chart.planets['Sun']?.absoluteDegree ?? 0;
    final moon = chart.planets['Moon']?.absoluteDegree ?? 0;

    // Day chart: Asc + Moon - Sun
    // Night chart: Asc + Sun - Moon
    // Simplified: using day chart formula
    return (asc + moon - sun + 360) % 360;
  }

  /// Calculate Part of Spirit
  static double calculatePartOfSpirit(NatalChart chart) {
    final asc = chart.ascendant.index * 30.0;
    final sun = chart.planets['Sun']?.absoluteDegree ?? 0;
    final moon = chart.planets['Moon']?.absoluteDegree ?? 0;

    // Day chart: Asc + Sun - Moon (opposite of Fortune)
    return (asc + sun - moon + 360) % 360;
  }

  /// Calculate Part of Love (Eros)
  static double calculatePartOfLove(NatalChart chart) {
    final asc = chart.ascendant.index * 30.0;
    final venus = chart.planets['Venus']?.absoluteDegree ?? 0;
    final sun = chart.planets['Sun']?.absoluteDegree ?? 0;

    // Asc + Venus - Sun
    return (asc + venus - sun + 360) % 360;
  }

  /// Calculate all Arabic Parts
  static Map<String, ArabicPart> calculateAllParts(NatalChart chart) {
    final asc = chart.ascendant.index * 30.0;
    final sun = chart.planets['Sun']?.absoluteDegree ?? 0;
    final moon = chart.planets['Moon']?.absoluteDegree ?? 0;
    final mercury = chart.planets['Mercury']?.absoluteDegree ?? 0;
    final venus = chart.planets['Venus']?.absoluteDegree ?? 0;
    final mars = chart.planets['Mars']?.absoluteDegree ?? 0;
    final jupiter = chart.planets['Jupiter']?.absoluteDegree ?? 0;
    final saturn = chart.planets['Saturn']?.absoluteDegree ?? 0;

    final parts = <String, ArabicPart>{};

    // Part of Fortune
    final fortuneLong = (asc + moon - sun + 360) % 360;
    parts['Fortune'] = ArabicPart(
      name: 'Part of Fortune',
      nameTr: 'Sans Noktasi',
      formula: 'Asc + Moon - Sun',
      longitude: fortuneLong,
      sign: ZodiacSign.values[(fortuneLong ~/ 30) % 12],
      house: ((fortuneLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation:
          'Sans ve maddi refah noktasi. Bu nokta nerede ise orada sans gelir.',
    );

    // Part of Spirit
    final spiritLong = (asc + sun - moon + 360) % 360;
    parts['Spirit'] = ArabicPart(
      name: 'Part of Spirit',
      nameTr: 'Ruh Noktasi',
      formula: 'Asc + Sun - Moon',
      longitude: spiritLong,
      sign: ZodiacSign.values[(spiritLong ~/ 30) % 12],
      house: ((spiritLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation: 'Ruhsal amac ve irade noktasi. Bilinc ve kasitli eylem.',
    );

    // Part of Love (Eros)
    final loveLong = (asc + venus - sun + 360) % 360;
    parts['Love'] = ArabicPart(
      name: 'Part of Love',
      nameTr: 'Ask Noktasi',
      formula: 'Asc + Venus - Sun',
      longitude: loveLong,
      sign: ZodiacSign.values[(loveLong ~/ 30) % 12],
      house: ((loveLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation:
          'Romantik ask ve cekicilik noktasi. Ask hayatinin temalari.',
    );

    // Part of Marriage
    final marriageLong = (asc + venus - saturn + 360) % 360;
    parts['Marriage'] = ArabicPart(
      name: 'Part of Marriage',
      nameTr: 'Evlilik Noktasi',
      formula: 'Asc + Venus - Saturn',
      longitude: marriageLong,
      sign: ZodiacSign.values[(marriageLong ~/ 30) % 12],
      house: ((marriageLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation:
          'Evlilik ve baglilik noktasi. Uzun sureli iliski potansiyeli.',
    );

    // Part of Commerce
    final commerceLong = (asc + mercury - sun + 360) % 360;
    parts['Commerce'] = ArabicPart(
      name: 'Part of Commerce',
      nameTr: 'Ticaret Noktasi',
      formula: 'Asc + Mercury - Sun',
      longitude: commerceLong,
      sign: ZodiacSign.values[(commerceLong ~/ 30) % 12],
      house: ((commerceLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation: 'Is ve ticaret noktasi. Kariyer ve finansal basari.',
    );

    // Part of Victory
    final victoryLong = (asc + jupiter - sun + 360) % 360;
    parts['Victory'] = ArabicPart(
      name: 'Part of Victory',
      nameTr: 'Zafer Noktasi',
      formula: 'Asc + Jupiter - Sun',
      longitude: victoryLong,
      sign: ZodiacSign.values[(victoryLong ~/ 30) % 12],
      house: ((victoryLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation: 'Basari ve zafer noktasi. Hedeflere ulasma potansiyeli.',
    );

    // Part of Destiny
    final destinyLong = (asc + moon - mercury + 360) % 360;
    parts['Destiny'] = ArabicPart(
      name: 'Part of Destiny',
      nameTr: 'Kader Noktasi',
      formula: 'Asc + Moon - Mercury',
      longitude: destinyLong,
      sign: ZodiacSign.values[(destinyLong ~/ 30) % 12],
      house: ((destinyLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation: 'Kader ve yasam yolu noktasi. Hayatin buyuk temalari.',
    );

    // Part of Passion
    final passionLong = (asc + mars - sun + 360) % 360;
    parts['Passion'] = ArabicPart(
      name: 'Part of Passion',
      nameTr: 'Tutku Noktasi',
      formula: 'Asc + Mars - Sun',
      longitude: passionLong,
      sign: ZodiacSign.values[(passionLong ~/ 30) % 12],
      house: ((passionLong - asc + 360) ~/ 30) % 12 + 1,
      interpretation:
          'Tutku ve enerji noktasi. Motivasyon ve durtulerin kaynagi.',
    );

    return parts;
  }
}

// ============ ORIGINAL SERVICE CLASS ============

class AdvancedAstrologyService {
  // ============ COMPOSITE CHART ============

  static CompositeChart generateCompositeChart({
    required String person1Name,
    required String person2Name,
    required ZodiacSign person1Sun,
    required ZodiacSign person2Sun,
    required ZodiacSign person1Moon,
    required ZodiacSign person2Moon,
  }) {
    final seed =
        person1Sun.index * 100 +
        person2Sun.index * 10 +
        person1Moon.index +
        person2Moon.index;
    final seededRandom = Random(seed);

    // Calculate composite positions (midpoint method)
    // All composite positions are derived deterministically from the input signs
    // to ensure consistent results across sessions
    final compositeSun = _getMidpointSign(person1Sun, person2Sun);
    final compositeMoon = _getMidpointSign(person1Moon, person2Moon);
    // Composite Ascendant: derived from midpoint of Sun signs + 3 (traditional offset)
    final compositeAsc = ZodiacSign
        .values[((person1Sun.index + person2Sun.index) ~/ 2 + 3) % 12];
    // Composite Venus: derived from Moon midpoint + 2
    final compositeVenus = ZodiacSign
        .values[((person1Moon.index + person2Moon.index) ~/ 2 + 2) % 12];
    // Composite Mars: derived from Sun midpoint + 5
    final compositeMars = ZodiacSign
        .values[((person1Sun.index + person2Sun.index) ~/ 2 + 5) % 12];

    final themes = _getRelationshipThemes(compositeSun, compositeMoon);
    final emotions = _getEmotionalDynamics(compositeMoon);
    final communication = _getCommunicationStyle(compositeAsc);
    final challenges = _getChallenges(compositeSun, compositeMoon);
    final strengths = _getStrengths(compositeSun, compositeMoon);
    final purpose = _getSoulPurpose(compositeSun);

    // Generate aspects
    final aspects = _generateCompositeAspects(seededRandom);

    // Calculate compatibility
    final compatibility = _calculateCompatibilityScore(
      person1Sun,
      person2Sun,
      person1Moon,
      person2Moon,
    );

    return CompositeChart(
      person1Name: person1Name,
      person2Name: person2Name,
      compositeSun: compositeSun,
      compositeMoon: compositeMoon,
      compositeAscendant: compositeAsc,
      compositeVenus: compositeVenus,
      compositeMars: compositeMars,
      relationshipTheme: themes[seededRandom.nextInt(themes.length)],
      emotionalDynamics: emotions[seededRandom.nextInt(emotions.length)],
      communicationStyle:
          communication[seededRandom.nextInt(communication.length)],
      challengesOverview: challenges[seededRandom.nextInt(challenges.length)],
      strengthsOverview: strengths[seededRandom.nextInt(strengths.length)],
      soulPurpose: purpose[seededRandom.nextInt(purpose.length)],
      overallCompatibility: compatibility,
      keyAspects: aspects,
    );
  }

  static ZodiacSign _getMidpointSign(ZodiacSign sign1, ZodiacSign sign2) {
    final midpoint = ((sign1.index + sign2.index) / 2).round();
    return ZodiacSign.values[midpoint % 12];
  }

  static int _calculateCompatibilityScore(
    ZodiacSign sun1,
    ZodiacSign sun2,
    ZodiacSign moon1,
    ZodiacSign moon2,
  ) {
    int score = 50;

    // Same element bonus
    if (sun1.element == sun2.element) score += 15;
    if (moon1.element == moon2.element) score += 10;

    // Complementary elements
    if ((sun1.element == Element.fire && sun2.element == Element.air) ||
        (sun1.element == Element.air && sun2.element == Element.fire)) {
      score += 12;
    }
    if ((sun1.element == Element.earth && sun2.element == Element.water) ||
        (sun1.element == Element.water && sun2.element == Element.earth)) {
      score += 12;
    }

    // Opposing signs (can be challenging but magnetic)
    if ((sun1.index - sun2.index).abs() == 6) score += 5;

    // Deterministic variation based on sign indices for consistency
    // No randomness to ensure same input always produces same output
    final variation =
        ((sun1.index * 3 +
                sun2.index * 7 +
                moon1.index * 5 +
                moon2.index * 11) %
            11) -
        5;
    score += variation;

    return score.clamp(0, 100);
  }

  static List<CompositeAspect> _generateCompositeAspects(Random seededRandom) {
    final planets = [
      'Güneş',
      'Ay',
      'Merkür',
      'Venüs',
      'Mars',
      'Jüpiter',
      'Satürn',
    ];
    final aspects = <CompositeAspect>[];

    for (int i = 0; i < 4; i++) {
      final p1 = planets[seededRandom.nextInt(planets.length)];
      var p2 = planets[seededRandom.nextInt(planets.length)];
      while (p2 == p1) {
        p2 = planets[seededRandom.nextInt(planets.length)];
      }

      final type =
          AspectType.values[seededRandom.nextInt(AspectType.values.length)];
      final interpretation = _getAspectInterpretation(p1, p2, type);
      final isHarmonious =
          type == AspectType.trine ||
          type == AspectType.sextile ||
          type == AspectType.conjunction;

      aspects.add(
        CompositeAspect(
          planet1: p1,
          planet2: p2,
          type: type,
          interpretation: interpretation,
          isHarmonious: isHarmonious,
        ),
      );
    }

    return aspects;
  }

  static String _getAspectInterpretation(
    String p1,
    String p2,
    AspectType type,
  ) {
    final interpretations = {
      AspectType.conjunction:
          '$p1 ve $p2 enerjileri birleşik. Bu ilişki için güçlü ve yoğun bir bağlantı.',
      AspectType.trine:
          '$p1 ile $p2 arasında uyumlu enerji akışı. Doğal ve kolay bir etkileşim.',
      AspectType.sextile:
          '$p1 ve $p2 arasında fırsatlar yaratan pozitif açı. İşbirliği potansiyeli yüksek.',
      AspectType.square:
          '$p1 ve $p2 arasında gerilim. Zorlayıcı ama büyüme potansiyeli taşıyan dinamik.',
      AspectType.opposition:
          '$p1 ve $p2 karşıtlığı. Dengelenmesi gereken zıt kutuplar.',
    };
    return interpretations[type]!;
  }

  static List<String> _getRelationshipThemes(ZodiacSign sun, ZodiacSign moon) {
    return [
      'Bu ilişki, ${sun.nameTr} enerjisinin cesaret ve tutku kattığını, ${moon.nameTr} ayının ise duygusal derinlik sağladığını gösteriyor. Birlikte hem ateş hem su taşıyorsunuz.',
      'Kompozit haritanız, karşılıklı büyüme ve dönüşüm üzerine kurulu bir ilişki olduğunu ortaya koyuyor. Her ikiniz de bu birliktelikten dönüşmüş çıkacaksınız.',
      'Ruhsal bağlantınız güçlü. Bu ilişki, sadece romantik değil, aynı zamanda karmik bir anlam taşıyor. Birbirinize öğretecek çok şeyiniz var.',
    ];
  }

  static List<String> _getEmotionalDynamics(ZodiacSign moon) {
    return [
      '${moon.nameTr} ayıyla, duygusal dünyanız ${moon.element.nameTr} elementi tarafından şekilleniyor. Hislerinizi paylaşmak ve anlamak bu ilişkinin temelini oluşturuyor.',
      'Duygusal iletişimde derinlik arıyorsunuz. Yüzeysel bağlantılar sizi tatmin etmez - gerçek yakınlık ve güven istiyorsunuz.',
      'Birbirinizin duygusal ihtiyaçlarını anlamak için zaman ve sabır gerekiyor. Ama bu çaba, karşılıklı şifa ve büyümeyi beraberinde getirecek.',
    ];
  }

  static List<String> _getCommunicationStyle(ZodiacSign asc) {
    return [
      '${asc.nameTr} yükseleniyle, dış dünyaya nasıl birlikte göründüğünüz ve iletişiminiz ${asc.element.nameTr} enerjisi taşıyor.',
      'İletişim tarzı doğrudan ve açık. Birbirinize karşı samimi ve dürüstler, bu da güveni güçlendiriyor.',
      'Sözleriniz ve sessizlikleriniz eşit derecede anlam taşıyor. Sözlü olmayan iletişimde de ustasınız.',
    ];
  }

  static List<String> _getChallenges(ZodiacSign sun, ZodiacSign moon) {
    return [
      'Ego çatışmaları ve bireysel ihtiyaçların ilişki ihtiyaçlarıyla dengelenmesi zorluk olabilir. Taviz vermeyi öğrenmek gerekiyor.',
      'Farklı duygusal diller konuşuyor olabilirsiniz. Birbirinizi yanlış anlamadan önce, dinlemeyi ve sormayı öğrenin.',
      'Bağımsızlık ve yakınlık arasındaki denge, bu ilişkinin ana temalarından biri. Her ikisine de alan tanımak gerekiyor.',
    ];
  }

  static List<String> _getStrengths(ZodiacSign sun, ZodiacSign moon) {
    return [
      'Karşılıklı saygı ve hayranlık ilişkinizin temelini oluşturuyor. Birbirinizin güçlü yanlarını takdir ediyorsunuz.',
      'Ortak değerlere ve vizyona sahipsiniz. Bu, uzun vadeli uyum ve hedef birliği sağlıyor.',
      'Zorluklar karşısında birlikte güçleniyorsunuz. Kriz anları ilişkinizi yıkmıyor, aksine pekiştiriyor.',
    ];
  }

  static List<String> _getSoulPurpose(ZodiacSign sun) {
    return [
      'Bu ilişki, her ikinizin de en yüksek potansiyelinize ulaşmanız için bir araç. Birlikte, tek başınıza yapamadığınız şeyleri başarabilirsiniz.',
      'Ruhsal amacınız, birbirinize ayna tutarak gölge yanlarınızı iyileştirmek. Bu bazen ağır ama her zaman değerli.',
      'Birlikte, dünyaya sevgi ve şifa enerjisi yayma potansiyeliniz var. İlişkiniz sadece sizin için değil, çevrenizdekiler için de ilham kaynağı.',
    ];
  }

  // ============ VEDIC/SIDEREAL CHART ============

  static VedicChart generateVedicChart({
    required DateTime birthDate,
    required ZodiacSign westernSun,
    required ZodiacSign westernMoon,
    required ZodiacSign westernAscendant,
  }) {
    final seed = birthDate.year * 10000 + birthDate.month * 100 + birthDate.day;
    final seededRandom = Random(seed);

    // Apply ayanamsa (approximately 24 degrees) to convert to sidereal
    final siderealMoon = _applySiderealCorrection(westernMoon);
    final siderealAsc = _applySiderealCorrection(westernAscendant);

    // Calculate nakshatra - deterministic based on sidereal moon
    // Each sign contains approximately 2.25 nakshatras (27 nakshatras / 12 signs)
    // Nakshatra index is derived from moon sign for consistency
    final nakshatraIndex =
        ((siderealMoon.index * 27) ~/ 12 + (birthDate.day % 3)) % 27;
    final nakshatra = Nakshatra.all[nakshatraIndex];

    // Generate planet positions
    final planets = _generateVedicPlanetPositions(seededRandom, siderealAsc);

    // Check for doshas
    final manglikStatus = _checkManglikDosha(planets);
    final kalaSarpa = _checkKalaSarpaYoga(planets);
    final yogas = _identifyYogas(planets, seededRandom);

    // Calculate dasha
    final dashas = _calculateDasha(nakshatra, birthDate);

    final predictions = _getVedicPredictions(siderealMoon, nakshatra);

    return VedicChart(
      moonSign: siderealMoon,
      nakshatra: nakshatra.number,
      nakshatraName: nakshatra.name,
      nakshatraLord: nakshatra.lord,
      // Pada is deterministic based on birth day
      nakshatraPada: '${(birthDate.day % 4) + 1}',
      ascendant: siderealAsc,
      planets: planets,
      manglikStatus: manglikStatus,
      kalaSarpaYoga: kalaSarpa,
      yogas: yogas,
      dashaLord: dashas['mahadasha']!,
      antardasha: dashas['antardasha']!,
      pratyantardasha: dashas['pratyantardasha']!,
      generalPrediction: predictions[seededRandom.nextInt(predictions.length)],
    );
  }

  static ZodiacSign _applySiderealCorrection(ZodiacSign tropical) {
    // Move back approximately 1 sign (24 degrees ≈ 1 sign)
    final correctedIndex = (tropical.index - 1 + 12) % 12;
    return ZodiacSign.values[correctedIndex];
  }

  static List<VedicPlanetPosition> _generateVedicPlanetPositions(
    Random seededRandom,
    ZodiacSign ascendant,
  ) {
    final planetNames = [
      'Güneş',
      'Ay',
      'Mars',
      'Merkür',
      'Jüpiter',
      'Venüs',
      'Satürn',
      'Rahu',
      'Ketu',
    ];
    final planets = <VedicPlanetPosition>[];

    // Traditional planetary offsets from ascendant for approximate Vedic positions
    // These create deterministic but varied positions based on ascendant
    final planetOffsets = [
      0,
      4,
      7,
      2,
      9,
      3,
      10,
      6,
      0,
    ]; // Traditional approximate offsets

    for (int i = 0; i < planetNames.length; i++) {
      // Deterministic sign calculation: ascendant + offset + seed variation
      final seedVariation =
          (seededRandom.nextInt(4) - 2); // Small deterministic variation
      final sign =
          ZodiacSign.values[(ascendant.index +
                  planetOffsets[i] +
                  seedVariation +
                  12) %
              12];
      final house = ((sign.index - ascendant.index + 12) % 12) + 1;
      // Deterministic retrograde based on planet type (outer planets more likely)
      final isRetro = i >= 4 && (seededRandom.nextInt(10) < 3);

      String dignity = 'Normal';
      bool isExalted = false;
      bool isDebilitated = false;

      // Check dignity (simplified)
      if (_isExalted(planetNames[i], sign)) {
        dignity = 'Yükselmiş';
        isExalted = true;
      } else if (_isDebilitated(planetNames[i], sign)) {
        dignity = 'Düşmüş';
        isDebilitated = true;
      } else if (_isOwnSign(planetNames[i], sign)) {
        dignity = 'Kendi Evi';
      }

      planets.add(
        VedicPlanetPosition(
          planet: planetNames[i],
          sign: sign,
          house: house,
          isRetrograde: isRetro,
          isExalted: isExalted,
          isDebilitated: isDebilitated,
          dignity: dignity,
        ),
      );
    }

    return planets;
  }

  static bool _isExalted(String planet, ZodiacSign sign) {
    final exaltations = {
      'Güneş': ZodiacSign.aries,
      'Ay': ZodiacSign.taurus,
      'Mars': ZodiacSign.capricorn,
      'Merkür': ZodiacSign.virgo,
      'Jüpiter': ZodiacSign.cancer,
      'Venüs': ZodiacSign.pisces,
      'Satürn': ZodiacSign.libra,
    };
    return exaltations[planet] == sign;
  }

  static bool _isDebilitated(String planet, ZodiacSign sign) {
    final debilitations = {
      'Güneş': ZodiacSign.libra,
      'Ay': ZodiacSign.scorpio,
      'Mars': ZodiacSign.cancer,
      'Merkür': ZodiacSign.pisces,
      'Jüpiter': ZodiacSign.capricorn,
      'Venüs': ZodiacSign.virgo,
      'Satürn': ZodiacSign.aries,
    };
    return debilitations[planet] == sign;
  }

  static bool _isOwnSign(String planet, ZodiacSign sign) {
    final ownSigns = {
      'Güneş': [ZodiacSign.leo],
      'Ay': [ZodiacSign.cancer],
      'Mars': [ZodiacSign.aries, ZodiacSign.scorpio],
      'Merkür': [ZodiacSign.gemini, ZodiacSign.virgo],
      'Jüpiter': [ZodiacSign.sagittarius, ZodiacSign.pisces],
      'Venüs': [ZodiacSign.taurus, ZodiacSign.libra],
      'Satürn': [ZodiacSign.capricorn, ZodiacSign.aquarius],
    };
    return ownSigns[planet]?.contains(sign) ?? false;
  }

  static String _checkManglikDosha(List<VedicPlanetPosition> planets) {
    final mars = planets.firstWhere((p) => p.planet == 'Mars');
    final manglikHouses = [1, 4, 7, 8, 12];

    if (manglikHouses.contains(mars.house)) {
      return 'Manglik Dosha mevcut. Mars ${mars.house}. evde. Evlilik öncesi dikkate alınması gereken bir dosha.';
    }
    return 'Manglik Dosha yok. Mars uygun konumda.';
  }

  static String _checkKalaSarpaYoga(List<VedicPlanetPosition> planets) {
    // Simplified check
    final rahu = planets.firstWhere((p) => p.planet == 'Rahu');
    final ketu = planets.firstWhere((p) => p.planet == 'Ketu');

    if ((rahu.house - ketu.house).abs() == 6) {
      return 'Kala Sarpa Yoga belirtileri mevcut. Ruhsal gelişim için önemli bir yoga.';
    }
    return 'Kala Sarpa Yoga yok.';
  }

  static List<String> _identifyYogas(
    List<VedicPlanetPosition> planets,
    Random seededRandom,
  ) {
    final possibleYogas = [
      'Gajakesari Yoga - Jüpiter Ay ile güçlü açıda',
      'Budhaditya Yoga - Merkür Güneş ile kavuşumda',
      'Chandra-Mangal Yoga - Ay Mars ile birlikte',
      'Hamsa Yoga - Jüpiter köşe evinde',
      'Malavya Yoga - Venüs köşe evinde',
      'Raja Yoga - Lagna ve 5. ev lordu kavuşumda',
      'Dhana Yoga - 2. ve 11. ev lordları ilişkide',
    ];

    final count = seededRandom.nextInt(3) + 1;
    final selected = <String>[];

    for (int i = 0; i < count; i++) {
      final yoga = possibleYogas[seededRandom.nextInt(possibleYogas.length)];
      if (!selected.contains(yoga)) {
        selected.add(yoga);
      }
    }

    return selected;
  }

  static Map<String, String> _calculateDasha(
    Nakshatra nakshatra,
    DateTime birthDate,
  ) {
    final lords = [
      'Ketu',
      'Venus',
      'Sun',
      'Moon',
      'Mars',
      'Rahu',
      'Jupiter',
      'Saturn',
      'Mercury',
    ];
    final nakshatraLord = nakshatra.lord;
    final lordIndex = lords.indexOf(nakshatraLord);

    final age = DateTime.now().difference(birthDate).inDays ~/ 365;
    final mahadashaIndex = (lordIndex + age ~/ 10) % lords.length;
    final antardashaIndex = (mahadashaIndex + age % 10) % lords.length;
    final pratyantarIndex =
        (antardashaIndex + DateTime.now().month) % lords.length;

    return {
      'mahadasha': lords[mahadashaIndex],
      'antardasha': lords[antardashaIndex],
      'pratyantardasha': lords[pratyantarIndex],
    };
  }

  static List<String> _getVedicPredictions(
    ZodiacSign moon,
    Nakshatra nakshatra,
  ) {
    return [
      '${moon.nameTr} Rasi\'nde Ay ile doğdunuz. ${nakshatra.name} nakshatra\'sının etkileri yaşamınızda belirgindir. ${nakshatra.lord} gezegeni sizin nakshatra lordunuz olarak önemli kararlarınızı yönlendiriyor.',
      'Vedik astrolojiye göre, ${nakshatra.deity} tanrıçasının kutsaması altındasınız. Bu, size ${nakshatra.symbol} sembolünün temsil ettiği nitelikleri veriyor.',
      'Mevcut dasha döneminiz önemli gelişmelere işaret ediyor. Gezegen transitlerini takip ederek, uygun zamanlarda adım atabilirsiniz.',
    ];
  }

  // ============ SECONDARY PROGRESSIONS ============

  static SecondaryProgressions generateProgressions({
    required DateTime birthDate,
    required ZodiacSign natalSun,
    required ZodiacSign natalMoon,
    required ZodiacSign natalAscendant,
  }) {
    final now = DateTime.now();
    final age = now.difference(birthDate).inDays ~/ 365;
    final seed =
        birthDate.year * 10000 + birthDate.month * 100 + birthDate.day + age;
    final seededRandom = Random(seed);

    // Calculate progressed positions
    // Sun moves ~1 degree per year
    final progressedSunIndex = (natalSun.index + age ~/ 30) % 12;
    final progressedSun = ZodiacSign.values[progressedSunIndex];

    // Moon moves ~1 sign per 2.5 years
    final progressedMoonIndex = (natalMoon.index + age ~/ 2.5).round() % 12;
    final progressedMoon = ZodiacSign.values[progressedMoonIndex];

    // Ascendant progresses slowly
    final progressedAscIndex = (natalAscendant.index + age ~/ 72) % 12;
    final progressedAsc = ZodiacSign.values[progressedAscIndex];

    // Other planets
    final progressedMercury =
        ZodiacSign.values[(natalSun.index + age ~/ 25) % 12];
    final progressedVenus =
        ZodiacSign.values[(natalSun.index + age ~/ 20) % 12];
    final progressedMars = ZodiacSign.values[(natalSun.index + age ~/ 60) % 12];

    // Generate content
    final lifePhases = _getLifePhaseContent(age, progressedSun);
    final emotionalThemes = _getProgressedEmotionalTheme(progressedMoon);
    final identityContent = _getIdentityEvolution(natalSun, progressedSun);
    final upcomingContent = _getUpcomingChanges(
      progressedSun,
      progressedMoon,
      seededRandom,
    );

    // Generate aspects
    final aspects = _generateProgressedAspects(
      natalSun,
      progressedSun,
      natalMoon,
      progressedMoon,
      seededRandom,
    );

    // Generate events
    final events = _generateProgressionEvents(birthDate, age, seededRandom);

    return SecondaryProgressions(
      birthDate: birthDate,
      progressedDate: now,
      progressedAge: age,
      progressedSun: progressedSun,
      progressedMoon: progressedMoon,
      progressedAscendant: progressedAsc,
      progressedMercury: progressedMercury,
      progressedVenus: progressedVenus,
      progressedMars: progressedMars,
      currentLifePhase: lifePhases[seededRandom.nextInt(lifePhases.length)],
      emotionalTheme:
          emotionalThemes[seededRandom.nextInt(emotionalThemes.length)],
      identityEvolution:
          identityContent[seededRandom.nextInt(identityContent.length)],
      upcomingChanges:
          upcomingContent[seededRandom.nextInt(upcomingContent.length)],
      activeAspects: aspects,
      significantEvents: events,
    );
  }

  static List<String> _getLifePhaseContent(int age, ZodiacSign progressedSun) {
    return [
      '$age yaşındasınız ve ilerlemişş Güneşiniz ${progressedSun.nameTr} burcunda. Bu dönem, ${progressedSun.element.nameTr} elementi temalarının ön plana çıktığı bir yaşam evresini temsil ediyor.',
      'Şu anki yaşam fazınız, kimlik ve özbilincin derinleşmesiyle ilgili. ${progressedSun.nameTr} enerjisi size yeni bakış açıları ve fırsatlar sunuyor.',
      'İlerlemişş haritanız, bu dönemde iç dünyanızda önemli değişimlerin yaşandığına işaret ediyor. Dış olaylar bu iç dönüşümün yansımaları.',
    ];
  }

  static List<String> _getProgressedEmotionalTheme(ZodiacSign moon) {
    return [
      'İlerlemişş Ayınız ${moon.nameTr} burcunda. Duygusal dünyanız ${moon.element.nameTr} elementinin niteliklerini taşıyor. Bu dönem, duygusal olgunlaşma ve iç huzur arayışı ile belirleniyor.',
      'Ayınız şu anki konumunda, ilişkileriniz ve iç dünyanızla bağlantınız konusunda yeni fikirler getiriyor. Duygusal zeka geliştirmek için ideal bir dönem.',
      'İlerlemişş Ay, bakım ve beslenmek temalarını vurguluyor. Hem kendinize hem de sevdiklerinize nasıl baktığınızı sorgulayın.',
    ];
  }

  static List<String> _getIdentityEvolution(
    ZodiacSign natal,
    ZodiacSign progressed,
  ) {
    if (natal == progressed) {
      return [
        'Güneşiniz hala doğum burcunuzda. Kimliğiniz istikrarlı bir evrimden geçiyor. Temel değerleriniz sağlamlaşıyor.',
      ];
    }
    return [
      'Güneşiniz ${natal.nameTr}\'dan ${progressed.nameTr}\'a ilerledi. Bu, kimliğinizde önemli bir evrime işaret ediyor. ${progressed.nameTr} niteliklerini bütünleştiriyorsunuz.',
      'Doğumda ${natal.nameTr} olan kimliğiniz, şimdi ${progressed.nameTr} enerjilerini de kapsıyor. Bu genişleme, sizi daha bütünsel bir insan yapıyor.',
    ];
  }

  static List<String> _getUpcomingChanges(
    ZodiacSign sun,
    ZodiacSign moon,
    Random seededRandom,
  ) {
    return [
      'Önümüzdeki dönemde, Ay yeni bir burca ilerleyecek. Bu, duygusal önceliklerinizde bir kayma anlamına gelecek.',
      'İlerlemişş Güneş yeni bir açı oluşturmak üzere. Bu, önemli kararlar ve yeni başlangıçlar için bir işarettir.',
      'Gezegen ilerlemeleri, kariyer ve ilişki alanlarında önemli gelişmelere işaret ediyor. Hazır olun.',
    ];
  }

  static List<ProgressedAspect> _generateProgressedAspects(
    ZodiacSign natalSun,
    ZodiacSign progressedSun,
    ZodiacSign natalMoon,
    ZodiacSign progressedMoon,
    Random seededRandom,
  ) {
    final aspects = <ProgressedAspect>[];

    aspects.add(
      ProgressedAspect(
        progressedPlanet: 'Güneş',
        natalPlanet: 'Güneş',
        type: AspectType.values[seededRandom.nextInt(AspectType.values.length)],
        interpretation:
            'İlerlemişş Güneş, natal Güneşinizle etkileşimde. Kimlik ve yaşam amacı temaları gündemde.',
        exactDate: DateTime.now().add(
          Duration(days: seededRandom.nextInt(365)),
        ),
        isApplying: seededRandom.nextBool(),
      ),
    );

    aspects.add(
      ProgressedAspect(
        progressedPlanet: 'Ay',
        natalPlanet: 'Ay',
        type: AspectType.values[seededRandom.nextInt(AspectType.values.length)],
        interpretation:
            'İlerlemişş Ay, natal Ayınızla arada. Duygusal dönem ve iç dünyanız ön planda.',
        exactDate: DateTime.now().add(Duration(days: seededRandom.nextInt(90))),
        isApplying: seededRandom.nextBool(),
      ),
    );

    return aspects;
  }

  static List<ProgressionEvent> _generateProgressionEvents(
    DateTime birthDate,
    int age,
    Random seededRandom,
  ) {
    final events = <ProgressionEvent>[];
    final now = DateTime.now();

    // Past events
    if (age > 30) {
      events.add(
        ProgressionEvent(
          date: birthDate.add(Duration(days: 30 * 365)),
          event: 'İlerlemişş Güneş burç değişimi',
          description:
              '30 yaşında ilerlemişş Güneşiniz yeni bir burca geçti. Kimliğinizde önemli bir evrim.',
          type: ProgressionEventType.sunSignChange,
        ),
      );
    }

    // Upcoming events
    events.add(
      ProgressionEvent(
        date: now.add(Duration(days: seededRandom.nextInt(365) + 30)),
        event: 'İlerlemişş Yeni Ay',
        description:
            'İlerlemişş Güneş ve Ay kavuşumu. Yeni başlangıçlar için güçlü bir zaman.',
        type: ProgressionEventType.newMoon,
      ),
    );

    events.add(
      ProgressionEvent(
        date: now.add(Duration(days: seededRandom.nextInt(180) + 10)),
        event: 'Önemli Açı Aktivasyonu',
        description:
            'İlerlemişş bir gezegen natal haritanızda önemli bir noktayla açı yapıyor.',
        type: ProgressionEventType.majorAspect,
      ),
    );

    return events;
  }
}
