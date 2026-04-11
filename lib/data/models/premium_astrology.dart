import 'zodiac_sign.dart';

/// AstroCartography - Location-based astrology
class AstroCartographyData {
  final String userName;
  final DateTime birthDate;
  final double birthLatitude;
  final double birthLongitude;
  final List<PlanetaryLine> planetaryLines;
  final List<PowerPlace> powerPlaces;
  final String overallAnalysis;

  AstroCartographyData({
    required this.userName,
    required this.birthDate,
    required this.birthLatitude,
    required this.birthLongitude,
    required this.planetaryLines,
    required this.powerPlaces,
    required this.overallAnalysis,
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'birthDate': birthDate.toIso8601String(),
    'birthLatitude': birthLatitude,
    'birthLongitude': birthLongitude,
    'planetaryLines': planetaryLines.map((l) => l.toJson()).toList(),
    'powerPlaces': powerPlaces.map((p) => p.toJson()).toList(),
    'overallAnalysis': overallAnalysis,
  };

  factory AstroCartographyData.fromJson(Map<String, dynamic> json) =>
      AstroCartographyData(
        userName: json['userName'] as String,
        birthDate: DateTime.parse(json['birthDate'] as String),
        birthLatitude: (json['birthLatitude'] as num).toDouble(),
        birthLongitude: (json['birthLongitude'] as num).toDouble(),
        planetaryLines: (json['planetaryLines'] as List)
            .map((l) => PlanetaryLine.fromJson(l as Map<String, dynamic>))
            .toList(),
        powerPlaces: (json['powerPlaces'] as List)
            .map((p) => PowerPlace.fromJson(p as Map<String, dynamic>))
            .toList(),
        overallAnalysis: json['overallAnalysis'] as String,
      );
}

class PlanetaryLine {
  final String planet;
  final LineType lineType;
  final List<GeoPoint> coordinates;
  final String meaning;
  final String advice;
  final bool isPositive;

  PlanetaryLine({
    required this.planet,
    required this.lineType,
    required this.coordinates,
    required this.meaning,
    required this.advice,
    required this.isPositive,
  });

  Map<String, dynamic> toJson() => {
    'planet': planet,
    'lineType': lineType.index,
    'coordinates': coordinates.map((c) => c.toJson()).toList(),
    'meaning': meaning,
    'advice': advice,
    'isPositive': isPositive,
  };

  factory PlanetaryLine.fromJson(Map<String, dynamic> json) => PlanetaryLine(
    planet: json['planet'] as String,
    lineType: LineType.values[json['lineType'] as int],
    coordinates: (json['coordinates'] as List)
        .map((c) => GeoPoint.fromJson(c as Map<String, dynamic>))
        .toList(),
    meaning: json['meaning'] as String,
    advice: json['advice'] as String,
    isPositive: json['isPositive'] as bool,
  );
}

class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  factory GeoPoint.fromJson(Map<String, dynamic> json) => GeoPoint(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

enum LineType {
  ascendant, // AC
  descendant, // DC
  midheaven, // MC
  imumCoeli, // IC
}

extension LineTypeExtension on LineType {
  String get nameTr {
    switch (this) {
      case LineType.ascendant:
        return 'Yükselen (AC)';
      case LineType.descendant:
        return 'Alçalan (DC)';
      case LineType.midheaven:
        return 'Gökyüzü Ortası (MC)';
      case LineType.imumCoeli:
        return 'Göğün Dibi (IC)';
    }
  }

  String get symbol {
    switch (this) {
      case LineType.ascendant:
        return 'AC';
      case LineType.descendant:
        return 'DC';
      case LineType.midheaven:
        return 'MC';
      case LineType.imumCoeli:
        return 'IC';
    }
  }

  String get description {
    switch (this) {
      case LineType.ascendant:
        return 'Kişisel güç, kimlik ve yeni başlangıçlar';
      case LineType.descendant:
        return 'İlişkiler, ortaklıklar ve başkalarıyla etkileşim';
      case LineType.midheaven:
        return 'Kariyer, itibar ve toplumsal konum';
      case LineType.imumCoeli:
        return 'Ev, aile ve duygusal kökler';
    }
  }
}

class PowerPlace {
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final List<String> activePlanets;
  final String energyType;
  final String description;
  final int powerRating; // 1-5

  PowerPlace({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.activePlanets,
    required this.energyType,
    required this.description,
    required this.powerRating,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'latitude': latitude,
    'longitude': longitude,
    'activePlanets': activePlanets,
    'energyType': energyType,
    'description': description,
    'powerRating': powerRating,
  };

  factory PowerPlace.fromJson(Map<String, dynamic> json) => PowerPlace(
    name: json['name'] as String,
    country: json['country'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    activePlanets: List<String>.from(json['activePlanets'] as List),
    energyType: json['energyType'] as String,
    description: json['description'] as String,
    powerRating: json['powerRating'] as int,
  );
}

/// Electional Astrology - Finding auspicious times
class ElectionalChart {
  final String purpose;
  final DateTime selectedDate;
  final List<ElectionalWindow> favorableWindows;
  final List<ElectionalWindow> unfavorableWindows;
  final String moonPhaseAdvice;
  final String retrogradeWarning;
  final String overallRecommendation;
  final int optimalScore; // 1-100

  ElectionalChart({
    required this.purpose,
    required this.selectedDate,
    required this.favorableWindows,
    required this.unfavorableWindows,
    required this.moonPhaseAdvice,
    required this.retrogradeWarning,
    required this.overallRecommendation,
    required this.optimalScore,
  });

  Map<String, dynamic> toJson() => {
    'purpose': purpose,
    'selectedDate': selectedDate.toIso8601String(),
    'favorableWindows': favorableWindows.map((w) => w.toJson()).toList(),
    'unfavorableWindows': unfavorableWindows.map((w) => w.toJson()).toList(),
    'moonPhaseAdvice': moonPhaseAdvice,
    'retrogradeWarning': retrogradeWarning,
    'overallRecommendation': overallRecommendation,
    'optimalScore': optimalScore,
  };

  factory ElectionalChart.fromJson(Map<String, dynamic> json) =>
      ElectionalChart(
        purpose: json['purpose'] as String,
        selectedDate: DateTime.parse(json['selectedDate'] as String),
        favorableWindows: (json['favorableWindows'] as List)
            .map((w) => ElectionalWindow.fromJson(w as Map<String, dynamic>))
            .toList(),
        unfavorableWindows: (json['unfavorableWindows'] as List)
            .map((w) => ElectionalWindow.fromJson(w as Map<String, dynamic>))
            .toList(),
        moonPhaseAdvice: json['moonPhaseAdvice'] as String,
        retrogradeWarning: json['retrogradeWarning'] as String,
        overallRecommendation: json['overallRecommendation'] as String,
        optimalScore: json['optimalScore'] as int,
      );
}

class ElectionalWindow {
  final DateTime start;
  final DateTime end;
  final String description;
  final List<String> supportingAspects;
  final int score; // 1-100

  ElectionalWindow({
    required this.start,
    required this.end,
    required this.description,
    required this.supportingAspects,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
    'description': description,
    'supportingAspects': supportingAspects,
    'score': score,
  };

  factory ElectionalWindow.fromJson(Map<String, dynamic> json) =>
      ElectionalWindow(
        start: DateTime.parse(json['start'] as String),
        end: DateTime.parse(json['end'] as String),
        description: json['description'] as String,
        supportingAspects: List<String>.from(json['supportingAspects'] as List),
        score: json['score'] as int,
      );
}

enum ElectionalPurpose {
  wedding,
  businessStart,
  travel,
  surgery,
  contract,
  moveHome,
  investment,
  jobInterview,
  proposal,
  other,
}

extension ElectionalPurposeExtension on ElectionalPurpose {
  String get nameTr {
    switch (this) {
      case ElectionalPurpose.wedding:
        return 'Düğün / Evlilik';
      case ElectionalPurpose.businessStart:
        return 'İş Kurma';
      case ElectionalPurpose.travel:
        return 'Seyahat';
      case ElectionalPurpose.surgery:
        return 'Ameliyat';
      case ElectionalPurpose.contract:
        return 'Sözleşme İmzalama';
      case ElectionalPurpose.moveHome:
        return 'Ev Taşıma';
      case ElectionalPurpose.investment:
        return 'Yatırım';
      case ElectionalPurpose.jobInterview:
        return 'İş Görüşmesi';
      case ElectionalPurpose.proposal:
        return 'Evlilik Teklifi';
      case ElectionalPurpose.other:
        return 'Diğer';
    }
  }

  String get icon {
    switch (this) {
      case ElectionalPurpose.wedding:
        return '💒';
      case ElectionalPurpose.businessStart:
        return '🏢';
      case ElectionalPurpose.travel:
        return '✈️';
      case ElectionalPurpose.surgery:
        return '🏥';
      case ElectionalPurpose.contract:
        return '📝';
      case ElectionalPurpose.moveHome:
        return '🏠';
      case ElectionalPurpose.investment:
        return '💰';
      case ElectionalPurpose.jobInterview:
        return '💼';
      case ElectionalPurpose.proposal:
        return '💍';
      case ElectionalPurpose.other:
        return '📅';
    }
  }

  List<String> get relevantPlanets {
    switch (this) {
      case ElectionalPurpose.wedding:
        return ['Venus', 'Jupiter', 'Moon'];
      case ElectionalPurpose.businessStart:
        return ['Jupiter', 'Mercury', 'Sun'];
      case ElectionalPurpose.travel:
        return ['Mercury', 'Jupiter', 'Moon'];
      case ElectionalPurpose.surgery:
        return ['Mars', 'Saturn', 'Moon'];
      case ElectionalPurpose.contract:
        return ['Mercury', 'Saturn', 'Jupiter'];
      case ElectionalPurpose.moveHome:
        return ['Moon', 'Venus', 'Jupiter'];
      case ElectionalPurpose.investment:
        return ['Jupiter', 'Venus', 'Saturn'];
      case ElectionalPurpose.jobInterview:
        return ['Mercury', 'Jupiter', 'Sun'];
      case ElectionalPurpose.proposal:
        return ['Venus', 'Moon', 'Jupiter'];
      case ElectionalPurpose.other:
        return ['Moon', 'Sun', 'Mercury'];
    }
  }
}

/// Draconic Chart - Soul-level astrology
class DraconicChart {
  final DateTime birthDate;
  final ZodiacSign draconicSun;
  final ZodiacSign draconicMoon;
  final ZodiacSign draconicAscendant;
  final List<DraconicPlanet> planets;
  final String soulPurpose;
  final String karmicLessons;
  final String spiritualGifts;
  final String pastLifeIndicators;
  final String evolutionaryPath;

  DraconicChart({
    required this.birthDate,
    required this.draconicSun,
    required this.draconicMoon,
    required this.draconicAscendant,
    required this.planets,
    required this.soulPurpose,
    required this.karmicLessons,
    required this.spiritualGifts,
    required this.pastLifeIndicators,
    required this.evolutionaryPath,
  });

  Map<String, dynamic> toJson() => {
    'birthDate': birthDate.toIso8601String(),
    'draconicSun': draconicSun.index,
    'draconicMoon': draconicMoon.index,
    'draconicAscendant': draconicAscendant.index,
    'planets': planets.map((p) => p.toJson()).toList(),
    'soulPurpose': soulPurpose,
    'karmicLessons': karmicLessons,
    'spiritualGifts': spiritualGifts,
    'pastLifeIndicators': pastLifeIndicators,
    'evolutionaryPath': evolutionaryPath,
  };

  factory DraconicChart.fromJson(Map<String, dynamic> json) => DraconicChart(
    birthDate: DateTime.parse(json['birthDate'] as String),
    draconicSun: ZodiacSign.values[json['draconicSun'] as int],
    draconicMoon: ZodiacSign.values[json['draconicMoon'] as int],
    draconicAscendant: ZodiacSign.values[json['draconicAscendant'] as int],
    planets: (json['planets'] as List)
        .map((p) => DraconicPlanet.fromJson(p as Map<String, dynamic>))
        .toList(),
    soulPurpose: json['soulPurpose'] as String,
    karmicLessons: json['karmicLessons'] as String,
    spiritualGifts: json['spiritualGifts'] as String,
    pastLifeIndicators: json['pastLifeIndicators'] as String,
    evolutionaryPath: json['evolutionaryPath'] as String,
  );
}

class DraconicPlanet {
  final String planet;
  final ZodiacSign sign;
  final double degree;
  final int house;
  final String interpretation;

  DraconicPlanet({
    required this.planet,
    required this.sign,
    required this.degree,
    required this.house,
    required this.interpretation,
  });

  Map<String, dynamic> toJson() => {
    'planet': planet,
    'sign': sign.index,
    'degree': degree,
    'house': house,
    'interpretation': interpretation,
  };

  factory DraconicPlanet.fromJson(Map<String, dynamic> json) => DraconicPlanet(
    planet: json['planet'] as String,
    sign: ZodiacSign.values[json['sign'] as int],
    degree: (json['degree'] as num).toDouble(),
    house: json['house'] as int,
    interpretation: json['interpretation'] as String,
  );
}

/// Extended Asteroids
class AsteroidChart {
  final DateTime birthDate;
  final List<AsteroidPosition> asteroids;
  final String chiron; // Wounded healer
  final String ceres; // Nurturing
  final String pallas; // Wisdom
  final String juno; // Partnership
  final String vesta; // Dedication
  final String overallAnalysis;

  AsteroidChart({
    required this.birthDate,
    required this.asteroids,
    required this.chiron,
    required this.ceres,
    required this.pallas,
    required this.juno,
    required this.vesta,
    required this.overallAnalysis,
  });

  Map<String, dynamic> toJson() => {
    'birthDate': birthDate.toIso8601String(),
    'asteroids': asteroids.map((a) => a.toJson()).toList(),
    'chiron': chiron,
    'ceres': ceres,
    'pallas': pallas,
    'juno': juno,
    'vesta': vesta,
    'overallAnalysis': overallAnalysis,
  };

  factory AsteroidChart.fromJson(Map<String, dynamic> json) => AsteroidChart(
    birthDate: DateTime.parse(json['birthDate'] as String),
    asteroids: (json['asteroids'] as List)
        .map((a) => AsteroidPosition.fromJson(a as Map<String, dynamic>))
        .toList(),
    chiron: json['chiron'] as String,
    ceres: json['ceres'] as String,
    pallas: json['pallas'] as String,
    juno: json['juno'] as String,
    vesta: json['vesta'] as String,
    overallAnalysis: json['overallAnalysis'] as String,
  );
}

class AsteroidPosition {
  final Asteroid asteroid;
  final ZodiacSign sign;
  final double degree;
  final int house;
  final List<String> aspects;
  final String interpretation;

  AsteroidPosition({
    required this.asteroid,
    required this.sign,
    required this.degree,
    required this.house,
    required this.aspects,
    required this.interpretation,
  });

  Map<String, dynamic> toJson() => {
    'asteroid': asteroid.index,
    'sign': sign.index,
    'degree': degree,
    'house': house,
    'aspects': aspects,
    'interpretation': interpretation,
  };

  factory AsteroidPosition.fromJson(Map<String, dynamic> json) =>
      AsteroidPosition(
        asteroid: Asteroid.values[json['asteroid'] as int],
        sign: ZodiacSign.values[json['sign'] as int],
        degree: (json['degree'] as num).toDouble(),
        house: json['house'] as int,
        aspects: List<String>.from(json['aspects'] as List),
        interpretation: json['interpretation'] as String,
      );
}

enum Asteroid {
  chiron,
  ceres,
  pallas,
  juno,
  vesta,
  eros,
  psyche,
  lilith,
  nessus,
  pholus,
}

extension AsteroidExtension on Asteroid {
  String get name {
    switch (this) {
      case Asteroid.chiron:
        return 'Chiron';
      case Asteroid.ceres:
        return 'Ceres';
      case Asteroid.pallas:
        return 'Pallas';
      case Asteroid.juno:
        return 'Juno';
      case Asteroid.vesta:
        return 'Vesta';
      case Asteroid.eros:
        return 'Eros';
      case Asteroid.psyche:
        return 'Psyche';
      case Asteroid.lilith:
        return 'Lilith';
      case Asteroid.nessus:
        return 'Nessus';
      case Asteroid.pholus:
        return 'Pholus';
    }
  }

  String get nameTr {
    switch (this) {
      case Asteroid.chiron:
        return 'Kiron (Yaralı Şifacı)';
      case Asteroid.ceres:
        return 'Ceres (Besleme)';
      case Asteroid.pallas:
        return 'Pallas (Bilgelik)';
      case Asteroid.juno:
        return 'Juno (Evlilik)';
      case Asteroid.vesta:
        return 'Vesta (Adanmışlık)';
      case Asteroid.eros:
        return 'Eros (Tutku)';
      case Asteroid.psyche:
        return 'Psyche (Ruh)';
      case Asteroid.lilith:
        return 'Lilith (Gölge)';
      case Asteroid.nessus:
        return 'Nessus (Döngüler)';
      case Asteroid.pholus:
        return 'Pholus (Dönüşüm)';
    }
  }

  String get symbol {
    switch (this) {
      case Asteroid.chiron:
        return '⚷';
      case Asteroid.ceres:
        return '⚳';
      case Asteroid.pallas:
        return '⚴';
      case Asteroid.juno:
        return '⚵';
      case Asteroid.vesta:
        return '⚶';
      case Asteroid.eros:
        return '♡';
      case Asteroid.psyche:
        return 'Ψ';
      case Asteroid.lilith:
        return '⚸';
      case Asteroid.nessus:
        return '⯉';
      case Asteroid.pholus:
        return '⯌';
    }
  }

  String get theme {
    switch (this) {
      case Asteroid.chiron:
        return 'Yaralı şifacı - Derin yaraların şifaya dönüşümü';
      case Asteroid.ceres:
        return 'Annelik, besleme, büyüme döngüleri';
      case Asteroid.pallas:
        return 'Yaratıcı zeka, strateji, örüntü tanıma';
      case Asteroid.juno:
        return 'Bağlılık, evlilik, eş dinamikleri';
      case Asteroid.vesta:
        return 'Kutsal alev, odaklanma, adanmışlık';
      case Asteroid.eros:
        return 'Erotik tutku, yaşam gücü, yaratıcı enerji';
      case Asteroid.psyche:
        return 'Ruh, dönüşüm, spiritüel gelişim';
      case Asteroid.lilith:
        return 'Gölge benlik, bastırılmış güç, özgürleşme';
      case Asteroid.nessus:
        return 'Nesiller arası kalıplar, kırılması gereken döngüler';
      case Asteroid.pholus:
        return 'Ani değişimler, küçük tetikleyiciler büyük sonuçlar';
    }
  }
}
