import 'zodiac_sign.dart';

/// Daily horoscope reading for a zodiac sign
class DailyHoroscope {
  final ZodiacSign sign;
  final DateTime date;
  final String generalReading;
  final String loveReading;
  final String careerReading;
  final String healthReading;
  final int luckyNumber;
  final String luckyColor;
  final double moodRating; // 1-5 stars
  final String focusOfTheDay;
  final List<String> affirmations;
  final String compatibility; // Best match for the day

  const DailyHoroscope({
    required this.sign,
    required this.date,
    required this.generalReading,
    required this.loveReading,
    required this.careerReading,
    required this.healthReading,
    required this.luckyNumber,
    required this.luckyColor,
    required this.moodRating,
    required this.focusOfTheDay,
    required this.affirmations,
    required this.compatibility,
  });

  Map<String, dynamic> toJson() => {
    'sign': sign.name,
    'date': date.toIso8601String(),
    'generalReading': generalReading,
    'loveReading': loveReading,
    'careerReading': careerReading,
    'healthReading': healthReading,
    'luckyNumber': luckyNumber,
    'luckyColor': luckyColor,
    'moodRating': moodRating,
    'focusOfTheDay': focusOfTheDay,
    'affirmations': affirmations,
    'compatibility': compatibility,
  };

  factory DailyHoroscope.fromJson(Map<String, dynamic> json) {
    return DailyHoroscope(
      sign: ZodiacSign.values.firstWhere((s) => s.name == json['sign']),
      date: DateTime.parse(json['date'] as String),
      generalReading: json['generalReading'] as String,
      loveReading: json['loveReading'] as String,
      careerReading: json['careerReading'] as String,
      healthReading: json['healthReading'] as String,
      luckyNumber: json['luckyNumber'] as int,
      luckyColor: json['luckyColor'] as String,
      moodRating: (json['moodRating'] as num).toDouble(),
      focusOfTheDay: json['focusOfTheDay'] as String,
      affirmations: List<String>.from(json['affirmations'] as List),
      compatibility: json['compatibility'] as String,
    );
  }

  /// Generate a placeholder horoscope for a sign and date
  factory DailyHoroscope.generate(ZodiacSign sign, DateTime date) {
    final seed = date.day + date.month * 31 + sign.index;
    final luckyNumbers = [3, 7, 9, 11, 13, 17, 21, 22, 27, 33, 42, 77];
    final colors = [
      'Gold',
      'Silver',
      'Purple',
      'Blue',
      'Green',
      'Red',
      'White',
      'Pink',
    ];

    return DailyHoroscope(
      sign: sign,
      date: date,
      generalReading: _getGeneralReading(sign, date),
      loveReading: _getLoveReading(sign, date),
      careerReading: _getCareerReading(sign, date),
      healthReading: _getHealthReading(sign, date),
      luckyNumber: luckyNumbers[seed % luckyNumbers.length],
      luckyColor: colors[seed % colors.length],
      moodRating: 3.0 + (seed % 20) / 10,
      focusOfTheDay: _getFocusOfTheDay(sign, date),
      affirmations: _getAffirmations(sign),
      compatibility: _getCompatibility(sign, date),
    );
  }

  static String _getGeneralReading(ZodiacSign sign, DateTime date) {
    final readings = {
      Element.fire: [
        'Your fiery energy is particularly strong today. Channel your passion into creative pursuits and watch magic unfold.',
        'The stars align to boost your confidence. Take bold action on projects you\'ve been contemplating.',
        'Your natural enthusiasm inspires those around you. Lead by example and others will follow.',
      ],
      Element.earth: [
        'Grounding energy surrounds you today. Focus on building solid foundations for your future.',
        'Practical matters take center stage. Your attention to detail will pay off in unexpected ways.',
        'Material abundance flows your way. Stay patient and trust in your methodical approach.',
      ],
      Element.air: [
        'Your mind is exceptionally sharp today. New ideas and connections flow effortlessly.',
        'Communication is your superpower right now. Express your thoughts with clarity and watch doors open.',
        'Social opportunities abound. Your wit and charm attract interesting people into your orbit.',
      ],
      Element.water: [
        'Trust your intuition today—it\'s your most reliable guide. Deep insights await those who listen within.',
        'Emotional connections deepen. Allow yourself to be vulnerable and watch relationships transform.',
        'Creative inspiration flows from your subconscious. Take time for artistic expression.',
      ],
    };

    final elementReadings = readings[sign.element]!;
    return elementReadings[date.day % elementReadings.length];
  }

  static String _getLoveReading(ZodiacSign sign, DateTime date) {
    final readings = [
      'Romance is in the air. Open your heart to unexpected connections.',
      'Existing relationships deepen through honest communication. Share your true feelings.',
      'Self-love is the foundation. Nurture yourself and watch love multiply.',
      'A surprise encounter could spark something beautiful. Stay open to possibilities.',
      'Passion intensifies in your closest bonds. Express appreciation for those you love.',
    ];
    return readings[(date.day + sign.index) % readings.length];
  }

  static String _getCareerReading(ZodiacSign sign, DateTime date) {
    final readings = [
      'Your professional reputation shines. Recognition for your efforts is on the horizon.',
      'Collaboration brings success today. Team efforts yield better results than solo ventures.',
      'A creative solution to a work challenge presents itself. Trust your innovative instincts.',
      'Financial opportunities emerge. Review your goals and take strategic action.',
      'Leadership qualities come to the forefront. Step up and guide others with confidence.',
    ];
    return readings[(date.day + sign.index + 3) % readings.length];
  }

  static String _getHealthReading(ZodiacSign sign, DateTime date) {
    final readings = [
      'Energy levels are high. Channel this vitality into physical activity for maximum benefit.',
      'Rest and recuperation are essential. Listen to your body\'s need for restoration.',
      'Mind-body connection is strong. Meditation or yoga brings profound benefits today.',
      'Nutrition deserves attention. Nourish yourself with foods that fuel your soul.',
      'Fresh air and nature call to you. Time outdoors recharges your spirit.',
    ];
    return readings[(date.day + sign.index + 7) % readings.length];
  }

  static String _getFocusOfTheDay(ZodiacSign sign, DateTime date) {
    final focuses = [
      'Self-Expression',
      'Inner Peace',
      'Connection',
      'Creativity',
      'Abundance',
      'Growth',
      'Clarity',
      'Love',
      'Purpose',
      'Transformation',
    ];
    return focuses[(date.day + sign.index) % focuses.length];
  }

  static List<String> _getAffirmations(ZodiacSign sign) {
    final affirmations = {
      Element.fire: [
        'I am bold and courageous in pursuing my dreams.',
        'My passion lights the way for others.',
        'I trust my instincts and take inspired action.',
      ],
      Element.earth: [
        'I am grounded, stable, and secure.',
        'Abundance flows to me naturally.',
        'I build my dreams with patience and determination.',
      ],
      Element.air: [
        'My thoughts create my reality.',
        'I communicate with clarity and purpose.',
        'I embrace new ideas and perspectives.',
      ],
      Element.water: [
        'I trust my intuition to guide me.',
        'I allow my emotions to flow freely.',
        'I am deeply connected to my inner wisdom.',
      ],
    };
    return affirmations[sign.element]!;
  }

  static String _getCompatibility(ZodiacSign sign, DateTime date) {
    // Get compatible signs based on element
    final compatibleSigns = _getCompatibleSigns(sign);
    return compatibleSigns[(date.day + date.month) % compatibleSigns.length]
        .name;
  }

  static List<ZodiacSign> _getCompatibleSigns(ZodiacSign sign) {
    final compatible = <ZodiacSign>[];
    for (final s in ZodiacSign.values) {
      if (s.element == sign.element ||
          _isComplementaryElement(sign.element, s.element)) {
        compatible.add(s);
      }
    }
    return compatible.isEmpty ? [sign] : compatible;
  }

  static bool _isComplementaryElement(Element e1, Element e2) {
    return (e1 == Element.fire && e2 == Element.air) ||
        (e1 == Element.air && e2 == Element.fire) ||
        (e1 == Element.earth && e2 == Element.water) ||
        (e1 == Element.water && e2 == Element.earth);
  }
}
