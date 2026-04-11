import 'zodiac_sign.dart';

/// Weekly horoscope model
class WeeklyHoroscope {
  final ZodiacSign sign;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String overview;
  final String loveWeek;
  final String careerWeek;
  final String healthWeek;
  final String financialWeek;
  final int overallRating; // 1-5
  final String luckyDay;
  final String weeklyAffirmation;
  final List<String> keyDates;

  WeeklyHoroscope({
    required this.sign,
    required this.weekStart,
    required this.weekEnd,
    required this.overview,
    required this.loveWeek,
    required this.careerWeek,
    required this.healthWeek,
    required this.financialWeek,
    required this.overallRating,
    required this.luckyDay,
    required this.weeklyAffirmation,
    required this.keyDates,
  });

  Map<String, dynamic> toJson() => {
    'sign': sign.index,
    'weekStart': weekStart.toIso8601String(),
    'weekEnd': weekEnd.toIso8601String(),
    'overview': overview,
    'loveWeek': loveWeek,
    'careerWeek': careerWeek,
    'healthWeek': healthWeek,
    'financialWeek': financialWeek,
    'overallRating': overallRating,
    'luckyDay': luckyDay,
    'weeklyAffirmation': weeklyAffirmation,
    'keyDates': keyDates,
  };

  factory WeeklyHoroscope.fromJson(Map<String, dynamic> json) =>
      WeeklyHoroscope(
        sign: ZodiacSign.values[json['sign'] as int],
        weekStart: DateTime.parse(json['weekStart'] as String),
        weekEnd: DateTime.parse(json['weekEnd'] as String),
        overview: json['overview'] as String,
        loveWeek: json['loveWeek'] as String,
        careerWeek: json['careerWeek'] as String,
        healthWeek: json['healthWeek'] as String,
        financialWeek: json['financialWeek'] as String,
        overallRating: json['overallRating'] as int,
        luckyDay: json['luckyDay'] as String,
        weeklyAffirmation: json['weeklyAffirmation'] as String,
        keyDates: List<String>.from(json['keyDates'] as List),
      );
}

/// Monthly horoscope model
class MonthlyHoroscope {
  final ZodiacSign sign;
  final int month;
  final int year;
  final String overview;
  final String loveMonth;
  final String careerMonth;
  final String healthMonth;
  final String financialMonth;
  final String spiritualGuidance;
  final int overallRating; // 1-5
  final List<String> luckyDays;
  final String monthlyMantra;
  final String keyTransits;
  final Map<String, int> weeklyRatings; // week1, week2, etc.

  MonthlyHoroscope({
    required this.sign,
    required this.month,
    required this.year,
    required this.overview,
    required this.loveMonth,
    required this.careerMonth,
    required this.healthMonth,
    required this.financialMonth,
    required this.spiritualGuidance,
    required this.overallRating,
    required this.luckyDays,
    required this.monthlyMantra,
    required this.keyTransits,
    required this.weeklyRatings,
  });

  String get monthName {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return months[month - 1];
  }

  Map<String, dynamic> toJson() => {
    'sign': sign.index,
    'month': month,
    'year': year,
    'overview': overview,
    'loveMonth': loveMonth,
    'careerMonth': careerMonth,
    'healthMonth': healthMonth,
    'financialMonth': financialMonth,
    'spiritualGuidance': spiritualGuidance,
    'overallRating': overallRating,
    'luckyDays': luckyDays,
    'monthlyMantra': monthlyMantra,
    'keyTransits': keyTransits,
    'weeklyRatings': weeklyRatings,
  };

  factory MonthlyHoroscope.fromJson(Map<String, dynamic> json) =>
      MonthlyHoroscope(
        sign: ZodiacSign.values[json['sign'] as int],
        month: json['month'] as int,
        year: json['year'] as int,
        overview: json['overview'] as String,
        loveMonth: json['loveMonth'] as String,
        careerMonth: json['careerMonth'] as String,
        healthMonth: json['healthMonth'] as String,
        financialMonth: json['financialMonth'] as String,
        spiritualGuidance: json['spiritualGuidance'] as String,
        overallRating: json['overallRating'] as int,
        luckyDays: List<String>.from(json['luckyDays'] as List),
        monthlyMantra: json['monthlyMantra'] as String,
        keyTransits: json['keyTransits'] as String,
        weeklyRatings: Map<String, int>.from(json['weeklyRatings'] as Map),
      );
}

/// Love horoscope model
class LoveHoroscope {
  final ZodiacSign sign;
  final DateTime date;
  final String romanticOutlook;
  final String singleAdvice;
  final String couplesAdvice;
  final String soulConnection;
  final int passionRating; // 1-5
  final int romanceRating; // 1-5
  final int communicationRating; // 1-5
  final ZodiacSign bestMatch;
  final ZodiacSign challengingMatch;
  final String venusInfluence;
  final String intimacyAdvice;

  LoveHoroscope({
    required this.sign,
    required this.date,
    required this.romanticOutlook,
    required this.singleAdvice,
    required this.couplesAdvice,
    required this.soulConnection,
    required this.passionRating,
    required this.romanceRating,
    required this.communicationRating,
    required this.bestMatch,
    required this.challengingMatch,
    required this.venusInfluence,
    required this.intimacyAdvice,
  });

  double get overallLoveRating =>
      (passionRating + romanceRating + communicationRating) / 3;

  Map<String, dynamic> toJson() => {
    'sign': sign.index,
    'date': date.toIso8601String(),
    'romanticOutlook': romanticOutlook,
    'singleAdvice': singleAdvice,
    'couplesAdvice': couplesAdvice,
    'soulConnection': soulConnection,
    'passionRating': passionRating,
    'romanceRating': romanceRating,
    'communicationRating': communicationRating,
    'bestMatch': bestMatch.index,
    'challengingMatch': challengingMatch.index,
    'venusInfluence': venusInfluence,
    'intimacyAdvice': intimacyAdvice,
  };

  factory LoveHoroscope.fromJson(Map<String, dynamic> json) => LoveHoroscope(
    sign: ZodiacSign.values[json['sign'] as int],
    date: DateTime.parse(json['date'] as String),
    romanticOutlook: json['romanticOutlook'] as String,
    singleAdvice: json['singleAdvice'] as String,
    couplesAdvice: json['couplesAdvice'] as String,
    soulConnection: json['soulConnection'] as String,
    passionRating: json['passionRating'] as int,
    romanceRating: json['romanceRating'] as int,
    communicationRating: json['communicationRating'] as int,
    bestMatch: ZodiacSign.values[json['bestMatch'] as int],
    challengingMatch: ZodiacSign.values[json['challengingMatch'] as int],
    venusInfluence: json['venusInfluence'] as String,
    intimacyAdvice: json['intimacyAdvice'] as String,
  );
}

/// Yearly horoscope model
class YearlyHoroscope {
  final ZodiacSign sign;
  final int year;
  final String yearOverview;
  final String loveYear;
  final String careerYear;
  final String healthYear;
  final String financialYear;
  final String spiritualJourney;
  final int overallRating; // 1-5
  final Map<int, int> monthlyRatings; // 1-12 -> 1-5
  final List<String> majorTransits;
  final List<String> luckyMonths;
  final List<String> challengingMonths;
  final String yearlyAffirmation;
  final String keyTheme;

  YearlyHoroscope({
    required this.sign,
    required this.year,
    required this.yearOverview,
    required this.loveYear,
    required this.careerYear,
    required this.healthYear,
    required this.financialYear,
    required this.spiritualJourney,
    required this.overallRating,
    required this.monthlyRatings,
    required this.majorTransits,
    required this.luckyMonths,
    required this.challengingMonths,
    required this.yearlyAffirmation,
    required this.keyTheme,
  });

  Map<String, dynamic> toJson() => {
    'sign': sign.index,
    'year': year,
    'yearOverview': yearOverview,
    'loveYear': loveYear,
    'careerYear': careerYear,
    'healthYear': healthYear,
    'financialYear': financialYear,
    'spiritualJourney': spiritualJourney,
    'overallRating': overallRating,
    'monthlyRatings': monthlyRatings.map((k, v) => MapEntry(k.toString(), v)),
    'majorTransits': majorTransits,
    'luckyMonths': luckyMonths,
    'challengingMonths': challengingMonths,
    'yearlyAffirmation': yearlyAffirmation,
    'keyTheme': keyTheme,
  };

  factory YearlyHoroscope.fromJson(Map<String, dynamic> json) =>
      YearlyHoroscope(
        sign: ZodiacSign.values[json['sign'] as int],
        year: json['year'] as int,
        yearOverview: json['yearOverview'] as String,
        loveYear: json['loveYear'] as String,
        careerYear: json['careerYear'] as String,
        healthYear: json['healthYear'] as String,
        financialYear: json['financialYear'] as String,
        spiritualJourney: json['spiritualJourney'] as String,
        overallRating: json['overallRating'] as int,
        monthlyRatings: (json['monthlyRatings'] as Map).map(
          (k, v) => MapEntry(int.parse(k.toString()), v as int),
        ),
        majorTransits: List<String>.from(json['majorTransits'] as List),
        luckyMonths: List<String>.from(json['luckyMonths'] as List),
        challengingMonths: List<String>.from(json['challengingMonths'] as List),
        yearlyAffirmation: json['yearlyAffirmation'] as String,
        keyTheme: json['keyTheme'] as String,
      );
}

/// Eclipse event model
class EclipseEvent {
  final DateTime date;
  final EclipseType type;
  final ZodiacSign zodiacSign;
  final String title;
  final String description;
  final String spiritualMeaning;
  final String practicalAdvice;
  final List<ZodiacSign> mostAffectedSigns;
  final bool isVisible; // visible in user's region
  final String peakTime;
  final double magnitude;

  EclipseEvent({
    required this.date,
    required this.type,
    required this.zodiacSign,
    required this.title,
    required this.description,
    required this.spiritualMeaning,
    required this.practicalAdvice,
    required this.mostAffectedSigns,
    required this.isVisible,
    required this.peakTime,
    required this.magnitude,
  });

  bool get isPast => date.isBefore(DateTime.now());

  int get daysUntil => date.difference(DateTime.now()).inDays;

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'type': type.index,
    'zodiacSign': zodiacSign.index,
    'title': title,
    'description': description,
    'spiritualMeaning': spiritualMeaning,
    'practicalAdvice': practicalAdvice,
    'mostAffectedSigns': mostAffectedSigns.map((s) => s.index).toList(),
    'isVisible': isVisible,
    'peakTime': peakTime,
    'magnitude': magnitude,
  };

  factory EclipseEvent.fromJson(Map<String, dynamic> json) => EclipseEvent(
    date: DateTime.parse(json['date'] as String),
    type: EclipseType.values[json['type'] as int],
    zodiacSign: ZodiacSign.values[json['zodiacSign'] as int],
    title: json['title'] as String,
    description: json['description'] as String,
    spiritualMeaning: json['spiritualMeaning'] as String,
    practicalAdvice: json['practicalAdvice'] as String,
    mostAffectedSigns: (json['mostAffectedSigns'] as List)
        .map((i) => ZodiacSign.values[i as int])
        .toList(),
    isVisible: json['isVisible'] as bool,
    peakTime: json['peakTime'] as String,
    magnitude: (json['magnitude'] as num).toDouble(),
  );
}

enum EclipseType {
  solarTotal,
  solarPartial,
  solarAnnular,
  lunarTotal,
  lunarPartial,
  lunarPenumbral,
}

extension EclipseTypeExtension on EclipseType {
  String get nameTr {
    switch (this) {
      case EclipseType.solarTotal:
        return 'Tam Güneş Tutulması';
      case EclipseType.solarPartial:
        return 'Kısmi Güneş Tutulması';
      case EclipseType.solarAnnular:
        return 'Halkalı Güneş Tutulması';
      case EclipseType.lunarTotal:
        return 'Tam Ay Tutulması';
      case EclipseType.lunarPartial:
        return 'Kısmi Ay Tutulması';
      case EclipseType.lunarPenumbral:
        return 'Yarıgölge Ay Tutulması';
    }
  }

  String get icon {
    switch (this) {
      case EclipseType.solarTotal:
      case EclipseType.solarPartial:
      case EclipseType.solarAnnular:
        return '☀️';
      case EclipseType.lunarTotal:
      case EclipseType.lunarPartial:
      case EclipseType.lunarPenumbral:
        return '🌙';
    }
  }

  bool get isSolar {
    return this == EclipseType.solarTotal ||
        this == EclipseType.solarPartial ||
        this == EclipseType.solarAnnular;
  }
}
