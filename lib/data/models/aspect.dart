import 'package:flutter/material.dart';
import 'planet.dart';

/// Types of astrological aspects
enum AspectType {
  conjunction, // 0°
  opposition, // 180°
  trine, // 120°
  square, // 90°
  sextile, // 60°
  quincunx, // 150°
  semisextile, // 30°
  semisquare, // 45°
  sesquisquare, // 135°
}

extension AspectTypeExtension on AspectType {
  String get name {
    switch (this) {
      case AspectType.conjunction:
        return 'Conjunction';
      case AspectType.opposition:
        return 'Opposition';
      case AspectType.trine:
        return 'Trine';
      case AspectType.square:
        return 'Square';
      case AspectType.sextile:
        return 'Sextile';
      case AspectType.quincunx:
        return 'Quincunx';
      case AspectType.semisextile:
        return 'Semi-sextile';
      case AspectType.semisquare:
        return 'Semi-square';
      case AspectType.sesquisquare:
        return 'Sesquisquare';
    }
  }

  String get nameTr {
    switch (this) {
      case AspectType.conjunction:
        return 'Kavuşum';
      case AspectType.opposition:
        return 'Karşıt';
      case AspectType.trine:
        return 'Üçgen';
      case AspectType.square:
        return 'Kare';
      case AspectType.sextile:
        return 'Sekstil';
      case AspectType.quincunx:
        return 'Quincunx';
      case AspectType.semisextile:
        return 'Yarı Sekstil';
      case AspectType.semisquare:
        return 'Yarı Kare';
      case AspectType.sesquisquare:
        return 'Sesquikare';
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
      case AspectType.quincunx:
        return '⚻';
      case AspectType.semisextile:
        return '⚺';
      case AspectType.semisquare:
        return '∠';
      case AspectType.sesquisquare:
        return '⚼';
    }
  }

  double get angle {
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
      case AspectType.quincunx:
        return 150;
      case AspectType.semisextile:
        return 30;
      case AspectType.semisquare:
        return 45;
      case AspectType.sesquisquare:
        return 135;
    }
  }

  /// Orb (tolerance) in degrees for this aspect
  double get orb {
    switch (this) {
      case AspectType.conjunction:
        return 10;
      case AspectType.opposition:
        return 10;
      case AspectType.trine:
        return 8;
      case AspectType.square:
        return 8;
      case AspectType.sextile:
        return 6;
      case AspectType.quincunx:
        return 3;
      case AspectType.semisextile:
        return 3;
      case AspectType.semisquare:
        return 3;
      case AspectType.sesquisquare:
        return 3;
    }
  }

  Color get color {
    switch (this) {
      case AspectType.conjunction:
        return const Color(0xFFFFD700);
      case AspectType.opposition:
        return const Color(0xFFDC143C);
      case AspectType.trine:
        return const Color(0xFF32CD32);
      case AspectType.square:
        return const Color(0xFFFF4500);
      case AspectType.sextile:
        return const Color(0xFF4169E1);
      case AspectType.quincunx:
        return const Color(0xFF9370DB);
      case AspectType.semisextile:
        return const Color(0xFF87CEEB);
      case AspectType.semisquare:
        return const Color(0xFFFF6347);
      case AspectType.sesquisquare:
        return const Color(0xFFFF8C00);
    }
  }

  /// Is this a harmonious aspect?
  bool get isHarmonious {
    return this == AspectType.trine ||
        this == AspectType.sextile ||
        this == AspectType.conjunction;
  }

  /// Is this a challenging aspect?
  bool get isChallenging {
    return this == AspectType.square ||
        this == AspectType.opposition ||
        this == AspectType.semisquare ||
        this == AspectType.sesquisquare;
  }

  String get meaning {
    switch (this) {
      case AspectType.conjunction:
        return 'Güçlü birleşme, yoğunlaşma, iki enerjinin kaynaşması';
      case AspectType.opposition:
        return 'İç çatışma, denge arayışı, projeksiyon, bilinç-bilinçaltı';
      case AspectType.trine:
        return 'Doğal yetenek, kolay akış, şans, uyum';
      case AspectType.square:
        return 'Zorluk, gerilim, mücadele ile büyüme, motivasyon';
      case AspectType.sextile:
        return 'Fırsat, potansiyel, zihinsel uyum, öğrenme';
      case AspectType.quincunx:
        return 'Uyumsuzluk, ayarlama ihtiyacı, sağlık konuları';
      case AspectType.semisextile:
        return 'Hafif gerilim, farkındalık, küçük ayarlamalar';
      case AspectType.semisquare:
        return 'Sürtüşme, rahatsızlık, harekete geçirici';
      case AspectType.sesquisquare:
        return 'Agitasyon, düzeltme ihtiyacı, huzursuzluk';
    }
  }

  /// Is this a major aspect?
  bool get isMajor {
    return this == AspectType.conjunction ||
        this == AspectType.opposition ||
        this == AspectType.trine ||
        this == AspectType.square ||
        this == AspectType.sextile;
  }
}

/// An aspect between two planets
class Aspect {
  final Planet planet1;
  final Planet planet2;
  final AspectType type;
  final double orb; // actual orb in degrees
  final bool isApplying; // getting closer vs separating

  Aspect({
    required this.planet1,
    required this.planet2,
    required this.type,
    required this.orb,
    this.isApplying = true,
  });

  /// Strength of the aspect (0-100, closer orb = stronger)
  int get strength {
    final maxOrb = type.orb;
    final strength = ((maxOrb - orb.abs()) / maxOrb * 100).round();
    return strength.clamp(0, 100);
  }

  String get description {
    return '${planet1.symbol} ${type.symbol} ${planet2.symbol}';
  }

  String get fullDescription {
    final applying = isApplying ? 'Yaklaşan' : 'Ayrılan';
    return '${planet1.name} ${type.nameTr} ${planet2.name} (${orb.toStringAsFixed(1)}° - $applying)';
  }

  String get interpretation {
    // Generate interpretation based on planets and aspect type
    if (type.isHarmonious) {
      return '${planet1.nameTr} ve ${planet2.nameTr} arasında uyumlu bir enerji akışı var. '
          '${type.meaning}';
    } else if (type.isChallenging) {
      return '${planet1.nameTr} ve ${planet2.nameTr} arasında bir gerilim mevcut. '
          '${type.meaning}';
    }
    return '${planet1.nameTr} ve ${planet2.nameTr} birbirini etkiliyor. ${type.meaning}';
  }
}
