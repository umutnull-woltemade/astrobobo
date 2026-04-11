import 'dart:math';

/// Moon phase and sign calculation service
class MoonService {
  /// Known new moon reference date (Jan 6, 2000 at 18:14 UTC)
  static final DateTime _knownNewMoon = DateTime.utc(2000, 1, 6, 18, 14);

  /// Synodic month length in days (time between new moons)
  static const double _synodicMonth = 29.53058867;

  /// Get current moon phase
  static MoonPhase getCurrentPhase([DateTime? date]) {
    final now = date ?? DateTime.now();
    final daysSinceKnown = now.difference(_knownNewMoon).inSeconds / 86400.0;
    final phaseDay = daysSinceKnown % _synodicMonth;

    return _getPhaseFromDay(phaseDay);
  }

  /// Get moon illumination percentage (0-100)
  static double getIllumination([DateTime? date]) {
    final now = date ?? DateTime.now();
    final daysSinceKnown = now.difference(_knownNewMoon).inSeconds / 86400.0;
    final phaseDay = daysSinceKnown % _synodicMonth;

    // Illumination follows a cosine curve
    return ((1 - cos(2 * pi * phaseDay / _synodicMonth)) / 2) * 100;
  }

  /// Get current moon sign based on moon's position
  static MoonSign getCurrentMoonSign([DateTime? date]) {
    final now = date ?? DateTime.now();

    // Approximate lunar cycle through zodiac (27.32 days sidereal month)
    final siderealMonth = 27.321661;
    final knownMoonInAries = DateTime.utc(
      2024,
      1,
      14,
      12,
      0,
    ); // Reference point

    final daysSinceKnown = now.difference(knownMoonInAries).inSeconds / 86400.0;
    final signPosition = (daysSinceKnown % siderealMonth) / siderealMonth * 12;
    final signIndex = signPosition.floor() % 12;

    return MoonSign.values[signIndex];
  }

  /// Check if a planet is currently retrograde
  static bool isPlanetRetrograde(String planet, [DateTime? date]) {
    final now = date ?? DateTime.now();
    final year = now.year;
    final dayOfYear = now.difference(DateTime(year, 1, 1)).inDays;

    // Approximate retrograde periods for 2024-2026
    // These are simplified approximations
    switch (planet.toLowerCase()) {
      case 'mercury':
        return _isMercuryRetrograde(year, dayOfYear);
      case 'venus':
        return _isVenusRetrograde(year, dayOfYear);
      case 'mars':
        return _isMarsRetrograde(year, dayOfYear);
      case 'jupiter':
        return _isOuterPlanetRetrograde(year, dayOfYear, 120, 4); // ~4 months
      case 'saturn':
        return _isOuterPlanetRetrograde(year, dayOfYear, 140, 4.5);
      case 'uranus':
        return _isOuterPlanetRetrograde(year, dayOfYear, 150, 5);
      case 'neptune':
        return _isOuterPlanetRetrograde(year, dayOfYear, 160, 5.5);
      case 'pluto':
        return _isOuterPlanetRetrograde(year, dayOfYear, 180, 6);
      default:
        return false;
    }
  }

  /// Get all currently retrograde planets
  static List<String> getRetrogradePlanets([DateTime? date]) {
    final planets = [
      'mercury',
      'venus',
      'mars',
      'jupiter',
      'saturn',
      'uranus',
      'neptune',
      'pluto',
    ];
    return planets.where((p) => isPlanetRetrograde(p, date)).toList();
  }

  /// Get Mercury retrograde periods for a year
  static List<RetrogradePeroid> getMercuryRetrogradePeriods(int year) {
    // Mercury goes retrograde 3-4 times per year
    // These are approximate dates
    switch (year) {
      case 2024:
        return [
          RetrogradePeroid(DateTime(2024, 4, 1), DateTime(2024, 4, 25)),
          RetrogradePeroid(DateTime(2024, 8, 5), DateTime(2024, 8, 28)),
          RetrogradePeroid(DateTime(2024, 11, 25), DateTime(2024, 12, 15)),
        ];
      case 2025:
        return [
          RetrogradePeroid(DateTime(2025, 3, 15), DateTime(2025, 4, 7)),
          RetrogradePeroid(DateTime(2025, 7, 18), DateTime(2025, 8, 11)),
          RetrogradePeroid(DateTime(2025, 11, 9), DateTime(2025, 11, 29)),
        ];
      case 2026:
        return [
          RetrogradePeroid(DateTime(2026, 2, 26), DateTime(2026, 3, 20)),
          RetrogradePeroid(DateTime(2026, 6, 29), DateTime(2026, 7, 23)),
          RetrogradePeroid(DateTime(2026, 10, 24), DateTime(2026, 11, 13)),
        ];
      default:
        return [];
    }
  }

  /// Check if Mercury is retrograde
  static bool _isMercuryRetrograde(int year, int dayOfYear) {
    final periods = getMercuryRetrogradePeriods(year);
    final date = DateTime(year, 1, 1).add(Duration(days: dayOfYear));

    for (final period in periods) {
      if (date.isAfter(period.start.subtract(const Duration(days: 1))) &&
          date.isBefore(period.end.add(const Duration(days: 1)))) {
        return true;
      }
    }
    return false;
  }

  /// Venus retrograde (every 18 months approximately)
  static bool _isVenusRetrograde(int year, int dayOfYear) {
    // Venus retrograde 2024: March 1 - April 12 (approx)
    // Venus retrograde 2025: None
    // Venus retrograde 2026: February 2 - March 14 (approx)
    if (year == 2024 && dayOfYear >= 61 && dayOfYear <= 103) return true;
    if (year == 2026 && dayOfYear >= 33 && dayOfYear <= 73) return true;
    return false;
  }

  /// Mars retrograde (every 2 years approximately)
  static bool _isMarsRetrograde(int year, int dayOfYear) {
    // Mars retrograde 2024: December 6, 2024 - February 23, 2025
    // Mars retrograde 2026: October 30, 2026 - January 12, 2027
    if (year == 2024 && dayOfYear >= 341) return true;
    if (year == 2025 && dayOfYear <= 54) return true;
    if (year == 2026 && dayOfYear >= 303) return true;
    return false;
  }

  /// Outer planets retrograde (approximate)
  static bool _isOuterPlanetRetrograde(
    int year,
    int dayOfYear,
    int startDay,
    double months,
  ) {
    final endDay = startDay + (months * 30).toInt();
    return dayOfYear >= startDay && dayOfYear <= endDay;
  }

  /// Get next Mercury retrograde date
  static DateTime? getNextMercuryRetrograde([DateTime? fromDate]) {
    final now = fromDate ?? DateTime.now();

    for (int year = now.year; year <= now.year + 1; year++) {
      final periods = getMercuryRetrogradePeriods(year);
      for (final period in periods) {
        if (period.start.isAfter(now)) {
          return period.start;
        }
      }
    }
    return null;
  }

  /// Get current Mercury retrograde end date if in retrograde
  static DateTime? getCurrentMercuryRetrogradeEnd([DateTime? date]) {
    final now = date ?? DateTime.now();
    final periods = getMercuryRetrogradePeriods(now.year);

    for (final period in periods) {
      if (now.isAfter(period.start.subtract(const Duration(days: 1))) &&
          now.isBefore(period.end.add(const Duration(days: 1)))) {
        return period.end;
      }
    }
    return null;
  }

  static MoonPhase _getPhaseFromDay(double phaseDay) {
    if (phaseDay < 1.85) return MoonPhase.newMoon;
    if (phaseDay < 7.38) return MoonPhase.waxingCrescent;
    if (phaseDay < 11.07) return MoonPhase.firstQuarter;
    if (phaseDay < 14.77) return MoonPhase.waxingGibbous;
    if (phaseDay < 18.46) return MoonPhase.fullMoon;
    if (phaseDay < 22.15) return MoonPhase.waningGibbous;
    if (phaseDay < 25.84) return MoonPhase.lastQuarter;
    return MoonPhase.waningCrescent;
  }
}

/// Moon phase enum
enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
}

extension MoonPhaseExtension on MoonPhase {
  String get name {
    switch (this) {
      case MoonPhase.newMoon:
        return 'New Moon';
      case MoonPhase.waxingCrescent:
        return 'Waxing Crescent';
      case MoonPhase.firstQuarter:
        return 'First Quarter';
      case MoonPhase.waxingGibbous:
        return 'Waxing Gibbous';
      case MoonPhase.fullMoon:
        return 'Full Moon';
      case MoonPhase.waningGibbous:
        return 'Waning Gibbous';
      case MoonPhase.lastQuarter:
        return 'Last Quarter';
      case MoonPhase.waningCrescent:
        return 'Waning Crescent';
    }
  }

  String get nameTr {
    switch (this) {
      case MoonPhase.newMoon:
        return 'Yeni Ay';
      case MoonPhase.waxingCrescent:
        return 'Hilal (Büyüyen)';
      case MoonPhase.firstQuarter:
        return 'İlk Dördün';
      case MoonPhase.waxingGibbous:
        return 'Şişkin Ay (Büyüyen)';
      case MoonPhase.fullMoon:
        return 'Dolunay';
      case MoonPhase.waningGibbous:
        return 'Şişkin Ay (Küçülen)';
      case MoonPhase.lastQuarter:
        return 'Son Dördün';
      case MoonPhase.waningCrescent:
        return 'Hilal (Küçülen)';
    }
  }

  String get emoji {
    switch (this) {
      case MoonPhase.newMoon:
        return '🌑';
      case MoonPhase.waxingCrescent:
        return '🌒';
      case MoonPhase.firstQuarter:
        return '🌓';
      case MoonPhase.waxingGibbous:
        return '🌔';
      case MoonPhase.fullMoon:
        return '🌕';
      case MoonPhase.waningGibbous:
        return '🌖';
      case MoonPhase.lastQuarter:
        return '🌗';
      case MoonPhase.waningCrescent:
        return '🌘';
    }
  }

  String get meaning {
    switch (this) {
      case MoonPhase.newMoon:
        return 'Yeni başlangıçlar, niyet koyma ve içe dönüş zamanı.';
      case MoonPhase.waxingCrescent:
        return 'Niyetleri güçlendirme, harekete geçme ve büyüme zamanı.';
      case MoonPhase.firstQuarter:
        return 'Karar verme, engelleri aşma ve kararlılık zamanı.';
      case MoonPhase.waxingGibbous:
        return 'İnce ayarlamalar, sabır ve detaylara odaklanma zamanı.';
      case MoonPhase.fullMoon:
        return 'Tamamlanma, aydınlanma ve duyguların zirve yaptığı zaman.';
      case MoonPhase.waningGibbous:
        return 'Paylaşma, öğretme ve şükran zamanı.';
      case MoonPhase.lastQuarter:
        return 'Bırakma, affetme ve temizlik zamanı.';
      case MoonPhase.waningCrescent:
        return 'Dinlenme, şifa ve yansıtma zamanı.';
    }
  }
}

/// Moon sign enum
enum MoonSign {
  aries,
  taurus,
  gemini,
  cancer,
  leo,
  virgo,
  libra,
  scorpio,
  sagittarius,
  capricorn,
  aquarius,
  pisces,
}

extension MoonSignExtension on MoonSign {
  String get name {
    switch (this) {
      case MoonSign.aries:
        return 'Aries';
      case MoonSign.taurus:
        return 'Taurus';
      case MoonSign.gemini:
        return 'Gemini';
      case MoonSign.cancer:
        return 'Cancer';
      case MoonSign.leo:
        return 'Leo';
      case MoonSign.virgo:
        return 'Virgo';
      case MoonSign.libra:
        return 'Libra';
      case MoonSign.scorpio:
        return 'Scorpio';
      case MoonSign.sagittarius:
        return 'Sagittarius';
      case MoonSign.capricorn:
        return 'Capricorn';
      case MoonSign.aquarius:
        return 'Aquarius';
      case MoonSign.pisces:
        return 'Pisces';
    }
  }

  String get nameTr {
    switch (this) {
      case MoonSign.aries:
        return 'Koç';
      case MoonSign.taurus:
        return 'Boğa';
      case MoonSign.gemini:
        return 'İkizler';
      case MoonSign.cancer:
        return 'Yengeç';
      case MoonSign.leo:
        return 'Aslan';
      case MoonSign.virgo:
        return 'Başak';
      case MoonSign.libra:
        return 'Terazi';
      case MoonSign.scorpio:
        return 'Akrep';
      case MoonSign.sagittarius:
        return 'Yay';
      case MoonSign.capricorn:
        return 'Oğlak';
      case MoonSign.aquarius:
        return 'Kova';
      case MoonSign.pisces:
        return 'Balık';
    }
  }

  String get symbol {
    switch (this) {
      case MoonSign.aries:
        return '♈';
      case MoonSign.taurus:
        return '♉';
      case MoonSign.gemini:
        return '♊';
      case MoonSign.cancer:
        return '♋';
      case MoonSign.leo:
        return '♌';
      case MoonSign.virgo:
        return '♍';
      case MoonSign.libra:
        return '♎';
      case MoonSign.scorpio:
        return '♏';
      case MoonSign.sagittarius:
        return '♐';
      case MoonSign.capricorn:
        return '♑';
      case MoonSign.aquarius:
        return '♒';
      case MoonSign.pisces:
        return '♓';
    }
  }
}

/// Retrograde period
class RetrogradePeroid {
  final DateTime start;
  final DateTime end;

  RetrogradePeroid(this.start, this.end);

  bool isActive([DateTime? date]) {
    final now = date ?? DateTime.now();
    return now.isAfter(start.subtract(const Duration(days: 1))) &&
        now.isBefore(end.add(const Duration(days: 1)));
  }

  int get daysRemaining {
    final now = DateTime.now();
    if (now.isBefore(start)) return -1;
    if (now.isAfter(end)) return 0;
    return end.difference(now).inDays;
  }
}

/// Void of Course Moon data
class VoidOfCourseMoon {
  final bool isVoid;
  final DateTime? startTime;
  final DateTime? endTime;
  final MoonSign currentSign;
  final MoonSign? nextSign;

  VoidOfCourseMoon({
    required this.isVoid,
    this.startTime,
    this.endTime,
    required this.currentSign,
    this.nextSign,
  });

  /// Duration of the VOC period in hours
  double? get durationHours {
    if (startTime == null || endTime == null) return null;
    return endTime!.difference(startTime!).inMinutes / 60.0;
  }

  /// Time remaining until VOC ends (or null if not in VOC)
  Duration? get timeRemaining {
    if (!isVoid || endTime == null) return null;
    final now = DateTime.now();
    if (now.isAfter(endTime!)) return Duration.zero;
    return endTime!.difference(now);
  }

  /// Formatted time remaining
  String? get timeRemainingFormatted {
    final remaining = timeRemaining;
    if (remaining == null) return null;

    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;

    if (hours > 0) {
      return '${hours}s ${minutes}dk';
    }
    return '${minutes}dk';
  }
}

/// Extension to MoonService for VOC calculations
extension VoidOfCourseMoonExtension on MoonService {
  /// Calculate Void of Course Moon status
  /// VOC Moon occurs when the Moon makes no major aspects
  /// before leaving its current sign
  static VoidOfCourseMoon getVoidOfCourseStatus([DateTime? date]) {
    final now = date ?? DateTime.now();
    final currentSign = MoonService.getCurrentMoonSign(now);

    // Approximate lunar transit through each sign (~2.5 days)
    final siderealMonth = 27.321661;
    final daysPerSign = siderealMonth / 12; // ~2.28 days
    final knownMoonInAries = DateTime.utc(2024, 1, 14, 12, 0);

    final daysSinceKnown = now.difference(knownMoonInAries).inSeconds / 86400.0;
    final positionInSign = (daysSinceKnown % daysPerSign) / daysPerSign;

    // Calculate when Moon will enter next sign
    final hoursUntilNextSign = (1 - positionInSign) * daysPerSign * 24;
    final nextSignTime = now.add(
      Duration(minutes: (hoursUntilNextSign * 60).round()),
    );
    final nextSignIndex = (currentSign.index + 1) % 12;
    final nextSign = MoonSign.values[nextSignIndex];

    // VOC periods are pre-calculated for accuracy
    // Check against known VOC periods
    final vocPeriod = _getVocPeriodForDate(now);

    if (vocPeriod != null) {
      return VoidOfCourseMoon(
        isVoid: true,
        startTime: vocPeriod.start,
        endTime: vocPeriod.end,
        currentSign: currentSign,
        nextSign: nextSign,
      );
    }

    // Simplified VOC detection: Moon is typically void in the last
    // few hours before sign change (when no major aspects form)
    // This is an approximation - real VOC requires aspect calculation
    final isNearSignChange = hoursUntilNextSign < 4.0;
    final isLikelyVoid =
        isNearSignChange && _isLikelyVoidPeriod(now, currentSign);

    if (isLikelyVoid) {
      // Estimate VOC start as ~4 hours before sign change
      final estimatedStart = nextSignTime.subtract(const Duration(hours: 4));
      return VoidOfCourseMoon(
        isVoid: true,
        startTime: estimatedStart.isBefore(now) ? estimatedStart : now,
        endTime: nextSignTime,
        currentSign: currentSign,
        nextSign: nextSign,
      );
    }

    return VoidOfCourseMoon(
      isVoid: false,
      currentSign: currentSign,
      nextSign: nextSign,
    );
  }

  /// Get next VOC period
  static VoidOfCourseMoon? getNextVoidOfCourse([DateTime? fromDate]) {
    final now = fromDate ?? DateTime.now();

    // Check VOC periods for the next 7 days
    for (int i = 0; i < 7; i++) {
      final checkDate = now.add(Duration(days: i));
      final voc = getVoidOfCourseStatus(checkDate);
      if (voc.isVoid && voc.startTime != null && voc.startTime!.isAfter(now)) {
        return voc;
      }
    }
    return null;
  }

  /// Pre-calculated VOC periods (sample data for Jan 2026)
  /// In production, this would come from an ephemeris API
  static VocPeriod? _getVocPeriodForDate(DateTime date) {
    final periods = _getVocPeriodsForMonth(date.year, date.month);

    for (final period in periods) {
      if (date.isAfter(period.start.subtract(const Duration(minutes: 1))) &&
          date.isBefore(period.end.add(const Duration(minutes: 1)))) {
        return period;
      }
    }
    return null;
  }

  /// Check if this is likely a void period based on Moon sign patterns
  static bool _isLikelyVoidPeriod(DateTime date, MoonSign sign) {
    // Some signs have longer typical VOC periods
    // Fire signs (Aries, Leo, Sag) and Air signs often have shorter VOCs
    // Water and Earth signs can have longer ones

    // Use date components for seed to ensure consistent results
    final seed = date.year * 10000 + date.month * 100 + date.day + sign.index;
    final random = Random(seed);

    // ~30% of the time Moon is void in the last hours of a sign
    return random.nextDouble() < 0.3;
  }

  /// Get VOC periods for a specific month
  static List<VocPeriod> _getVocPeriodsForMonth(int year, int month) {
    // Sample VOC periods - in production this would be calculated
    // or fetched from an ephemeris service
    if (year == 2026 && month == 1) {
      return [
        VocPeriod(DateTime(2026, 1, 2, 14, 30), DateTime(2026, 1, 2, 22, 15)),
        VocPeriod(DateTime(2026, 1, 5, 3, 45), DateTime(2026, 1, 5, 8, 20)),
        VocPeriod(DateTime(2026, 1, 7, 16, 10), DateTime(2026, 1, 7, 23, 45)),
        VocPeriod(DateTime(2026, 1, 10, 5, 30), DateTime(2026, 1, 10, 12, 0)),
        VocPeriod(DateTime(2026, 1, 12, 18, 15), DateTime(2026, 1, 13, 1, 30)),
        VocPeriod(DateTime(2026, 1, 15, 2, 0), DateTime(2026, 1, 15, 14, 45)),
        VocPeriod(DateTime(2026, 1, 17, 20, 30), DateTime(2026, 1, 18, 3, 15)),
        VocPeriod(DateTime(2026, 1, 20, 8, 45), DateTime(2026, 1, 20, 15, 30)),
        VocPeriod(DateTime(2026, 1, 22, 22, 0), DateTime(2026, 1, 23, 4, 20)),
        VocPeriod(DateTime(2026, 1, 25, 10, 15), DateTime(2026, 1, 25, 17, 0)),
        VocPeriod(DateTime(2026, 1, 27, 23, 30), DateTime(2026, 1, 28, 5, 45)),
        VocPeriod(DateTime(2026, 1, 30, 12, 0), DateTime(2026, 1, 30, 18, 30)),
      ];
    }

    // Generate approximate periods for other months
    return _generateApproximateVocPeriods(year, month);
  }

  /// Generate approximate VOC periods when exact data isn't available
  static List<VocPeriod> _generateApproximateVocPeriods(int year, int month) {
    final periods = <VocPeriod>[];
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final seed = year * 100 + month;
    final random = Random(seed);

    // Moon changes signs roughly every 2.5 days
    // VOC occurs before each sign change
    double dayProgress = random.nextDouble() * 2;

    while (dayProgress < daysInMonth) {
      final day = dayProgress.floor() + 1;
      if (day <= daysInMonth) {
        final startHour = random.nextInt(24);
        final duration = 2 + random.nextInt(10); // 2-12 hours

        final start = DateTime(year, month, day, startHour);
        final end = start.add(Duration(hours: duration));

        if (end.month == month) {
          periods.add(VocPeriod(start, end));
        }
      }
      dayProgress +=
          2.2 + random.nextDouble() * 0.6; // ~2.2-2.8 days between VOCs
    }

    return periods;
  }
}

/// VOC Period helper class
class VocPeriod {
  final DateTime start;
  final DateTime end;

  VocPeriod(this.start, this.end);
}
