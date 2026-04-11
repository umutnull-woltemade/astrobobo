import 'zodiac_sign.dart';
import 'birth_chart.dart';

/// Result of compatibility analysis between two signs or charts
class CompatibilityResult {
  final ZodiacSign sign1;
  final ZodiacSign sign2;

  // Optional - for full chart comparison
  final BirthChart? chart1;
  final BirthChart? chart2;

  final double overallScore; // 0-100
  final double loveScore;
  final double friendshipScore;
  final double communicationScore;
  final double emotionalScore;

  final String summary;
  final List<String> strengths;
  final List<String> challenges;
  final List<String> tips;

  final DateTime analyzedAt;

  const CompatibilityResult({
    required this.sign1,
    required this.sign2,
    this.chart1,
    this.chart2,
    required this.overallScore,
    required this.loveScore,
    required this.friendshipScore,
    required this.communicationScore,
    required this.emotionalScore,
    required this.summary,
    required this.strengths,
    required this.challenges,
    required this.tips,
    required this.analyzedAt,
  });

  /// Generate compatibility analysis between two signs
  factory CompatibilityResult.analyze(ZodiacSign sign1, ZodiacSign sign2) {
    final scores = _calculateScores(sign1, sign2);

    return CompatibilityResult(
      sign1: sign1,
      sign2: sign2,
      overallScore: scores['overall']!,
      loveScore: scores['love']!,
      friendshipScore: scores['friendship']!,
      communicationScore: scores['communication']!,
      emotionalScore: scores['emotional']!,
      summary: _generateSummary(sign1, sign2, scores['overall']!),
      strengths: _getStrengths(sign1, sign2),
      challenges: _getChallenges(sign1, sign2),
      tips: _getTips(sign1, sign2),
      analyzedAt: DateTime.now(),
    );
  }

  static Map<String, double> _calculateScores(
    ZodiacSign sign1,
    ZodiacSign sign2,
  ) {
    double baseScore = 50.0;

    // Same element = high compatibility
    if (sign1.element == sign2.element) {
      baseScore += 25;
    }
    // Complementary elements
    else if (_areComplementary(sign1.element, sign2.element)) {
      baseScore += 20;
    }
    // Challenging elements
    else if (_areChallenging(sign1.element, sign2.element)) {
      baseScore -= 10;
    }

    // Same modality can be challenging
    if (sign1.modality == sign2.modality) {
      baseScore -= 5;
    }

    // Opposite signs have strong attraction
    if ((sign1.index - sign2.index).abs() == 6) {
      baseScore += 15;
    }

    // Trine signs (same element, 120° apart)
    if ((sign1.index - sign2.index).abs() == 4 ||
        (sign1.index - sign2.index).abs() == 8) {
      baseScore += 10;
    }

    // Clamp between 30-95
    baseScore = baseScore.clamp(30.0, 95.0);

    // Add some variation for different categories
    return {
      'overall': baseScore,
      'love':
          (baseScore +
                  (sign1.element == Element.fire ||
                          sign1.element == Element.water
                      ? 5
                      : -3))
              .clamp(30.0, 95.0),
      'friendship': (baseScore + (sign1.element == Element.air ? 8 : 0)).clamp(
        30.0,
        95.0,
      ),
      'communication':
          (baseScore +
                  (sign1.element == Element.air || sign2.element == Element.air
                      ? 10
                      : -5))
              .clamp(30.0, 95.0),
      'emotional':
          (baseScore +
                  (sign1.element == Element.water ||
                          sign2.element == Element.water
                      ? 10
                      : -5))
              .clamp(30.0, 95.0),
    };
  }

  static bool _areComplementary(Element e1, Element e2) {
    return (e1 == Element.fire && e2 == Element.air) ||
        (e1 == Element.air && e2 == Element.fire) ||
        (e1 == Element.earth && e2 == Element.water) ||
        (e1 == Element.water && e2 == Element.earth);
  }

  static bool _areChallenging(Element e1, Element e2) {
    return (e1 == Element.fire && e2 == Element.water) ||
        (e1 == Element.water && e2 == Element.fire) ||
        (e1 == Element.earth && e2 == Element.air) ||
        (e1 == Element.air && e2 == Element.earth);
  }

  static String _generateSummary(
    ZodiacSign sign1,
    ZodiacSign sign2,
    double score,
  ) {
    if (score >= 80) {
      return 'A celestial match! ${sign1.name} and ${sign2.name} share a profound cosmic connection that creates harmony and understanding.';
    } else if (score >= 65) {
      return '${sign1.name} and ${sign2.name} have strong potential together. With mutual respect, this pairing can flourish beautifully.';
    } else if (score >= 50) {
      return 'An interesting dynamic exists between ${sign1.name} and ${sign2.name}. Differences can become strengths with open communication.';
    } else {
      return '${sign1.name} and ${sign2.name} face some cosmic challenges, but growth often comes from working through differences.';
    }
  }

  static List<String> _getStrengths(ZodiacSign sign1, ZodiacSign sign2) {
    final strengths = <String>[];

    if (sign1.element == sign2.element) {
      strengths.add(
        'Natural understanding through shared ${sign1.element.name} energy',
      );
    }
    if (_areComplementary(sign1.element, sign2.element)) {
      strengths.add('Complementary energies that balance each other');
    }
    if (sign1.modality != sign2.modality) {
      strengths.add('Different approaches that create dynamic energy');
    }

    // Element-specific strengths
    if (sign1.element == Element.fire || sign2.element == Element.fire) {
      strengths.add('Passionate and exciting connection');
    }
    if (sign1.element == Element.earth || sign2.element == Element.earth) {
      strengths.add('Stable foundation for building together');
    }
    if (sign1.element == Element.air || sign2.element == Element.air) {
      strengths.add('Stimulating intellectual connection');
    }
    if (sign1.element == Element.water || sign2.element == Element.water) {
      strengths.add('Deep emotional understanding');
    }

    return strengths.take(4).toList();
  }

  static List<String> _getChallenges(ZodiacSign sign1, ZodiacSign sign2) {
    final challenges = <String>[];

    if (_areChallenging(sign1.element, sign2.element)) {
      challenges.add('Different elemental energies require understanding');
    }
    if (sign1.modality == sign2.modality) {
      challenges.add('Similar approaches may lead to power struggles');
    }

    // Modality-specific challenges
    if (sign1.modality == Modality.cardinal &&
        sign2.modality == Modality.cardinal) {
      challenges.add('Both want to lead—taking turns is key');
    }
    if (sign1.modality == Modality.fixed && sign2.modality == Modality.fixed) {
      challenges.add('Stubbornness can create standoffs');
    }
    if (sign1.modality == Modality.mutable &&
        sign2.modality == Modality.mutable) {
      challenges.add('Direction may feel unclear at times');
    }

    if (challenges.isEmpty) {
      challenges.add('Minor friction is natural in any relationship');
    }

    return challenges.take(3).toList();
  }

  static List<String> _getTips(ZodiacSign sign1, ZodiacSign sign2) {
    final tips = <String>[];

    tips.add('Celebrate your differences as much as your similarities');

    if (sign1.element != sign2.element) {
      tips.add('Learn to appreciate the unique gifts each element brings');
    }

    if (sign1.modality == Modality.cardinal ||
        sign2.modality == Modality.cardinal) {
      tips.add('Take initiative but also allow space for the other to lead');
    }
    if (sign1.modality == Modality.fixed || sign2.modality == Modality.fixed) {
      tips.add('Practice flexibility and openness to change');
    }
    if (sign1.modality == Modality.mutable ||
        sign2.modality == Modality.mutable) {
      tips.add('Create shared goals to maintain focus together');
    }

    tips.add('Communication is your greatest tool for harmony');

    return tips.take(4).toList();
  }

  Map<String, dynamic> toJson() => {
    'sign1': sign1.name,
    'sign2': sign2.name,
    'chart1': chart1?.toJson(),
    'chart2': chart2?.toJson(),
    'overallScore': overallScore,
    'loveScore': loveScore,
    'friendshipScore': friendshipScore,
    'communicationScore': communicationScore,
    'emotionalScore': emotionalScore,
    'summary': summary,
    'strengths': strengths,
    'challenges': challenges,
    'tips': tips,
    'analyzedAt': analyzedAt.toIso8601String(),
  };

  factory CompatibilityResult.fromJson(Map<String, dynamic> json) {
    return CompatibilityResult(
      sign1: ZodiacSign.values.firstWhere((s) => s.name == json['sign1']),
      sign2: ZodiacSign.values.firstWhere((s) => s.name == json['sign2']),
      chart1: json['chart1'] != null
          ? BirthChart.fromJson(json['chart1'] as Map<String, dynamic>)
          : null,
      chart2: json['chart2'] != null
          ? BirthChart.fromJson(json['chart2'] as Map<String, dynamic>)
          : null,
      overallScore: (json['overallScore'] as num).toDouble(),
      loveScore: (json['loveScore'] as num).toDouble(),
      friendshipScore: (json['friendshipScore'] as num).toDouble(),
      communicationScore: (json['communicationScore'] as num).toDouble(),
      emotionalScore: (json['emotionalScore'] as num).toDouble(),
      summary: json['summary'] as String,
      strengths: List<String>.from(json['strengths'] as List),
      challenges: List<String>.from(json['challenges'] as List),
      tips: List<String>.from(json['tips'] as List),
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
    );
  }
}
