import 'zodiac_sign.dart';

/// Composite Chart - Combined chart for couples
class CompositeChart {
  final String person1Name;
  final String person2Name;
  final ZodiacSign compositeSun;
  final ZodiacSign compositeMoon;
  final ZodiacSign compositeAscendant;
  final ZodiacSign compositeVenus;
  final ZodiacSign compositeMars;
  final String relationshipTheme;
  final String emotionalDynamics;
  final String communicationStyle;
  final String challengesOverview;
  final String strengthsOverview;
  final String soulPurpose;
  final int overallCompatibility; // 0-100
  final List<CompositeAspect> keyAspects;

  CompositeChart({
    required this.person1Name,
    required this.person2Name,
    required this.compositeSun,
    required this.compositeMoon,
    required this.compositeAscendant,
    required this.compositeVenus,
    required this.compositeMars,
    required this.relationshipTheme,
    required this.emotionalDynamics,
    required this.communicationStyle,
    required this.challengesOverview,
    required this.strengthsOverview,
    required this.soulPurpose,
    required this.overallCompatibility,
    required this.keyAspects,
  });
}

class CompositeAspect {
  final String planet1;
  final String planet2;
  final AspectType type;
  final String interpretation;
  final bool isHarmonious;

  CompositeAspect({
    required this.planet1,
    required this.planet2,
    required this.type,
    required this.interpretation,
    required this.isHarmonious,
  });
}

enum AspectType { conjunction, opposition, trine, square, sextile }

extension AspectTypeExtension on AspectType {
  String get nameTr {
    switch (this) {
      case AspectType.conjunction:
        return 'Kavusma';
      case AspectType.opposition:
        return 'Karsitlik';
      case AspectType.trine:
        return 'Ucgen';
      case AspectType.square:
        return 'Kare';
      case AspectType.sextile:
        return 'Altigen';
    }
  }

  String get symbol {
    switch (this) {
      case AspectType.conjunction:
        return '☌';
      case AspectType.opposition:
        return '☍';
      case AspectType.trine:
        return '△';
      case AspectType.square:
        return '□';
      case AspectType.sextile:
        return '⚹';
    }
  }

  int get degrees {
    switch (this) {
      case AspectType.conjunction:
        return 0;
      case AspectType.opposition:
        return 180;
      case AspectType.trine:
        return 120;
      case AspectType.square:
        return 90;
      case AspectType.sextile:
        return 60;
    }
  }
}

/// Vedic/Sidereal Chart
class VedicChart {
  final ZodiacSign moonSign; // Rashi
  final int nakshatra; // 1-27
  final String nakshatraName;
  final String nakshatraLord;
  final String nakshatraPada; // 1-4
  final ZodiacSign ascendant; // Lagna
  final List<VedicPlanetPosition> planets;
  final String manglikStatus; // Mangal Dosha
  final String kalaSarpaYoga;
  final List<String> yogas;
  final String dashaLord; // Current Mahadasha
  final String antardasha;
  final String pratyantardasha;
  final String generalPrediction;

  VedicChart({
    required this.moonSign,
    required this.nakshatra,
    required this.nakshatraName,
    required this.nakshatraLord,
    required this.nakshatraPada,
    required this.ascendant,
    required this.planets,
    required this.manglikStatus,
    required this.kalaSarpaYoga,
    required this.yogas,
    required this.dashaLord,
    required this.antardasha,
    required this.pratyantardasha,
    required this.generalPrediction,
  });
}

class VedicPlanetPosition {
  final String planet;
  final ZodiacSign sign;
  final int house;
  final bool isRetrograde;
  final bool isExalted;
  final bool isDebilitated;
  final String dignity;

  VedicPlanetPosition({
    required this.planet,
    required this.sign,
    required this.house,
    required this.isRetrograde,
    required this.isExalted,
    required this.isDebilitated,
    required this.dignity,
  });
}

/// Secondary Progressions
class SecondaryProgressions {
  final DateTime birthDate;
  final DateTime progressedDate;
  final int progressedAge;
  final ZodiacSign progressedSun;
  final ZodiacSign progressedMoon;
  final ZodiacSign progressedAscendant;
  final ZodiacSign progressedMercury;
  final ZodiacSign progressedVenus;
  final ZodiacSign progressedMars;
  final String currentLifePhase;
  final String emotionalTheme;
  final String identityEvolution;
  final String upcomingChanges;
  final List<ProgressedAspect> activeAspects;
  final List<ProgressionEvent> significantEvents;

  SecondaryProgressions({
    required this.birthDate,
    required this.progressedDate,
    required this.progressedAge,
    required this.progressedSun,
    required this.progressedMoon,
    required this.progressedAscendant,
    required this.progressedMercury,
    required this.progressedVenus,
    required this.progressedMars,
    required this.currentLifePhase,
    required this.emotionalTheme,
    required this.identityEvolution,
    required this.upcomingChanges,
    required this.activeAspects,
    required this.significantEvents,
  });
}

class ProgressedAspect {
  final String progressedPlanet;
  final String natalPlanet;
  final AspectType type;
  final String interpretation;
  final DateTime exactDate;
  final bool isApplying; // approaching or separating

  ProgressedAspect({
    required this.progressedPlanet,
    required this.natalPlanet,
    required this.type,
    required this.interpretation,
    required this.exactDate,
    required this.isApplying,
  });
}

class ProgressionEvent {
  final DateTime date;
  final String event;
  final String description;
  final ProgressionEventType type;

  ProgressionEvent({
    required this.date,
    required this.event,
    required this.description,
    required this.type,
  });
}

enum ProgressionEventType {
  sunSignChange,
  moonSignChange,
  newMoon,
  fullMoon,
  planetSignChange,
  majorAspect,
}

extension ProgressionEventTypeExtension on ProgressionEventType {
  String get nameTr {
    switch (this) {
      case ProgressionEventType.sunSignChange:
        return 'Gunes Burc Degisimi';
      case ProgressionEventType.moonSignChange:
        return 'Ay Burc Degisimi';
      case ProgressionEventType.newMoon:
        return 'Yeni Ay';
      case ProgressionEventType.fullMoon:
        return 'Dolunay';
      case ProgressionEventType.planetSignChange:
        return 'Gezegen Burc Degisimi';
      case ProgressionEventType.majorAspect:
        return 'Onemli Aci';
    }
  }

  String get icon {
    switch (this) {
      case ProgressionEventType.sunSignChange:
        return '☀️';
      case ProgressionEventType.moonSignChange:
        return '🌙';
      case ProgressionEventType.newMoon:
        return '🌑';
      case ProgressionEventType.fullMoon:
        return '🌕';
      case ProgressionEventType.planetSignChange:
        return '🪐';
      case ProgressionEventType.majorAspect:
        return '✨';
    }
  }
}

/// Astrology System enum
enum AstrologySystem { western, vedic }

extension AstrologySystemExtension on AstrologySystem {
  String get nameTr {
    switch (this) {
      case AstrologySystem.western:
        return 'Bati Astrolojisi';
      case AstrologySystem.vedic:
        return 'Vedik Astroloji';
    }
  }

  String get description {
    switch (this) {
      case AstrologySystem.western:
        return 'Tropikal zodyak, mevsimsel baslangic noktasi';
      case AstrologySystem.vedic:
        return 'Sidereal zodyak, yildiz tabanli hesaplama';
    }
  }
}

/// Nakshatra data
class Nakshatra {
  final int number;
  final String name;
  final String nameTr;
  final String lord;
  final String symbol;
  final String deity;
  final ZodiacSign startSign;
  final double startDegree;
  final double endDegree;

  const Nakshatra({
    required this.number,
    required this.name,
    required this.nameTr,
    required this.lord,
    required this.symbol,
    required this.deity,
    required this.startSign,
    required this.startDegree,
    required this.endDegree,
  });

  static const List<Nakshatra> all = [
    Nakshatra(
      number: 1,
      name: 'Ashwini',
      nameTr: 'Asvini',
      lord: 'Ketu',
      symbol: 'At Basi',
      deity: 'Ashwini Kumaras',
      startSign: ZodiacSign.aries,
      startDegree: 0,
      endDegree: 13.2,
    ),
    Nakshatra(
      number: 2,
      name: 'Bharani',
      nameTr: 'Bharani',
      lord: 'Venus',
      symbol: 'Yoni',
      deity: 'Yama',
      startSign: ZodiacSign.aries,
      startDegree: 13.2,
      endDegree: 26.4,
    ),
    Nakshatra(
      number: 3,
      name: 'Krittika',
      nameTr: 'Krittika',
      lord: 'Sun',
      symbol: 'Bicak',
      deity: 'Agni',
      startSign: ZodiacSign.aries,
      startDegree: 26.4,
      endDegree: 40,
    ),
    Nakshatra(
      number: 4,
      name: 'Rohini',
      nameTr: 'Rohini',
      lord: 'Moon',
      symbol: 'Araba',
      deity: 'Brahma',
      startSign: ZodiacSign.taurus,
      startDegree: 10,
      endDegree: 23.2,
    ),
    Nakshatra(
      number: 5,
      name: 'Mrigashira',
      nameTr: 'Mrigasira',
      lord: 'Mars',
      symbol: 'Geyik Basi',
      deity: 'Soma',
      startSign: ZodiacSign.taurus,
      startDegree: 23.2,
      endDegree: 36.4,
    ),
    Nakshatra(
      number: 6,
      name: 'Ardra',
      nameTr: 'Ardra',
      lord: 'Rahu',
      symbol: 'Gozyas',
      deity: 'Rudra',
      startSign: ZodiacSign.gemini,
      startDegree: 6.4,
      endDegree: 20,
    ),
    Nakshatra(
      number: 7,
      name: 'Punarvasu',
      nameTr: 'Punarvasu',
      lord: 'Jupiter',
      symbol: 'Yay',
      deity: 'Aditi',
      startSign: ZodiacSign.gemini,
      startDegree: 20,
      endDegree: 33.2,
    ),
    Nakshatra(
      number: 8,
      name: 'Pushya',
      nameTr: 'Pusya',
      lord: 'Saturn',
      symbol: 'Inek Memesi',
      deity: 'Brihaspati',
      startSign: ZodiacSign.cancer,
      startDegree: 3.2,
      endDegree: 16.4,
    ),
    Nakshatra(
      number: 9,
      name: 'Ashlesha',
      nameTr: 'Aslesa',
      lord: 'Mercury',
      symbol: 'Yilan',
      deity: 'Sarpa',
      startSign: ZodiacSign.cancer,
      startDegree: 16.4,
      endDegree: 30,
    ),
    Nakshatra(
      number: 10,
      name: 'Magha',
      nameTr: 'Magha',
      lord: 'Ketu',
      symbol: 'Taht',
      deity: 'Pitris',
      startSign: ZodiacSign.leo,
      startDegree: 0,
      endDegree: 13.2,
    ),
    Nakshatra(
      number: 11,
      name: 'Purva Phalguni',
      nameTr: 'Purva Phalguni',
      lord: 'Venus',
      symbol: 'Hamak',
      deity: 'Bhaga',
      startSign: ZodiacSign.leo,
      startDegree: 13.2,
      endDegree: 26.4,
    ),
    Nakshatra(
      number: 12,
      name: 'Uttara Phalguni',
      nameTr: 'Uttara Phalguni',
      lord: 'Sun',
      symbol: 'Yatak',
      deity: 'Aryaman',
      startSign: ZodiacSign.leo,
      startDegree: 26.4,
      endDegree: 40,
    ),
    Nakshatra(
      number: 13,
      name: 'Hasta',
      nameTr: 'Hasta',
      lord: 'Moon',
      symbol: 'El',
      deity: 'Savitar',
      startSign: ZodiacSign.virgo,
      startDegree: 10,
      endDegree: 23.2,
    ),
    Nakshatra(
      number: 14,
      name: 'Chitra',
      nameTr: 'Chitra',
      lord: 'Mars',
      symbol: 'Inci',
      deity: 'Vishvakarma',
      startSign: ZodiacSign.virgo,
      startDegree: 23.2,
      endDegree: 36.4,
    ),
    Nakshatra(
      number: 15,
      name: 'Swati',
      nameTr: 'Svati',
      lord: 'Rahu',
      symbol: 'Mercan',
      deity: 'Vayu',
      startSign: ZodiacSign.libra,
      startDegree: 6.4,
      endDegree: 20,
    ),
    Nakshatra(
      number: 16,
      name: 'Vishakha',
      nameTr: 'Visakha',
      lord: 'Jupiter',
      symbol: 'Zafer Kemeri',
      deity: 'Indra-Agni',
      startSign: ZodiacSign.libra,
      startDegree: 20,
      endDegree: 33.2,
    ),
    Nakshatra(
      number: 17,
      name: 'Anuradha',
      nameTr: 'Anuradha',
      lord: 'Saturn',
      symbol: 'Lotus',
      deity: 'Mitra',
      startSign: ZodiacSign.scorpio,
      startDegree: 3.2,
      endDegree: 16.4,
    ),
    Nakshatra(
      number: 18,
      name: 'Jyeshtha',
      nameTr: 'Jyestha',
      lord: 'Mercury',
      symbol: 'Semsiye',
      deity: 'Indra',
      startSign: ZodiacSign.scorpio,
      startDegree: 16.4,
      endDegree: 30,
    ),
    Nakshatra(
      number: 19,
      name: 'Mula',
      nameTr: 'Mula',
      lord: 'Ketu',
      symbol: 'Kok',
      deity: 'Nirriti',
      startSign: ZodiacSign.sagittarius,
      startDegree: 0,
      endDegree: 13.2,
    ),
    Nakshatra(
      number: 20,
      name: 'Purva Ashadha',
      nameTr: 'Purva Asadha',
      lord: 'Venus',
      symbol: 'Fil Disi',
      deity: 'Apas',
      startSign: ZodiacSign.sagittarius,
      startDegree: 13.2,
      endDegree: 26.4,
    ),
    Nakshatra(
      number: 21,
      name: 'Uttara Ashadha',
      nameTr: 'Uttara Asadha',
      lord: 'Sun',
      symbol: 'Fil Disi',
      deity: 'Vishvadevas',
      startSign: ZodiacSign.sagittarius,
      startDegree: 26.4,
      endDegree: 40,
    ),
    Nakshatra(
      number: 22,
      name: 'Shravana',
      nameTr: 'Sravana',
      lord: 'Moon',
      symbol: 'Kulak',
      deity: 'Vishnu',
      startSign: ZodiacSign.capricorn,
      startDegree: 10,
      endDegree: 23.2,
    ),
    Nakshatra(
      number: 23,
      name: 'Dhanishta',
      nameTr: 'Dhanista',
      lord: 'Mars',
      symbol: 'Davul',
      deity: 'Vasus',
      startSign: ZodiacSign.capricorn,
      startDegree: 23.2,
      endDegree: 36.4,
    ),
    Nakshatra(
      number: 24,
      name: 'Shatabhisha',
      nameTr: 'Satabhisa',
      lord: 'Rahu',
      symbol: 'Daire',
      deity: 'Varuna',
      startSign: ZodiacSign.aquarius,
      startDegree: 6.4,
      endDegree: 20,
    ),
    Nakshatra(
      number: 25,
      name: 'Purva Bhadrapada',
      nameTr: 'Purva Bhadrapada',
      lord: 'Jupiter',
      symbol: 'Kama',
      deity: 'Aja Ekapad',
      startSign: ZodiacSign.aquarius,
      startDegree: 20,
      endDegree: 33.2,
    ),
    Nakshatra(
      number: 26,
      name: 'Uttara Bhadrapada',
      nameTr: 'Uttara Bhadrapada',
      lord: 'Saturn',
      symbol: 'Yilan',
      deity: 'Ahir Budhnya',
      startSign: ZodiacSign.pisces,
      startDegree: 3.2,
      endDegree: 16.4,
    ),
    Nakshatra(
      number: 27,
      name: 'Revati',
      nameTr: 'Revati',
      lord: 'Mercury',
      symbol: 'Balik',
      deity: 'Pushan',
      startSign: ZodiacSign.pisces,
      startDegree: 16.4,
      endDegree: 30,
    ),
  ];
}
