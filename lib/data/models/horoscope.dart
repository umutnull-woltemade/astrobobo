import 'zodiac_sign.dart';

class DailyHoroscope {
  final ZodiacSign sign;
  final DateTime date;
  final String summary;
  final String loveAdvice;
  final String careerAdvice;
  final String healthAdvice;
  final int luckRating; // 1-5
  final String luckyNumber;
  final String luckyColor;
  final String mood;

  // Kozmik Fısıltı - Geçmiş, Şimdi, Gelecek
  final String pastInsight; // Geçmişin Yankısı
  final String presentEnergy; // Şimdinin Enerjisi
  final String futureGuidance; // Geleceğin Fısıltısı
  final String cosmicMessage; // Evrenin Mesajı (kısa özet)

  // Element ve Modalite Analizi
  final String elementAnalysis; // Element derinlemesine analizi
  final String modalityAnalysis; // Modalite yorumu

  // Gezegensel Saatler ve Enerjiler
  final String planetaryHourInfo; // Günün gezegensel saatleri
  final String rulingPlanetMessage; // Yönetici gezegen mesajı

  // Ritüeller ve Pratikler
  final String dailyRitual; // Günlük ritüel önerisi
  final String meditationFocus; // Meditasyon odağı
  final String affirmation; // Günün olumlaması

  // Kristaller ve Taşlar
  final String crystalOfDay; // Günün kristali
  final String crystalMeaning; // Kristal anlamı ve kullanımı

  // Çakra ve Enerji Çalışması
  final String chakraFocus; // Odaklanılacak çakra
  final String chakraExercise; // Çakra egzersizi

  // Ruh Hayvanı ve Semboller
  final String spiritAnimal; // Günün ruh hayvanı
  final String spiritAnimalMessage; // Ruh hayvanı mesajı

  // Numeroloji
  final String numerologyInsight; // Numerolojik analiz

  // Tarot Kartı
  final String tarotCard; // Günün tarot kartı
  final String tarotMeaning; // Tarot kartı yorumu

  // Ay Fazı Etkisi
  final String moonPhaseEffect; // Ay fazının burca etkisi

  // Özel Uyarılar
  final String specialWarning; // Özel dikkat edilecek konu
  final String luckyTime; // Şanslı saat aralığı

  DailyHoroscope({
    required this.sign,
    required this.date,
    required this.summary,
    required this.loveAdvice,
    required this.careerAdvice,
    required this.healthAdvice,
    required this.luckRating,
    required this.luckyNumber,
    required this.luckyColor,
    required this.mood,
    required this.pastInsight,
    required this.presentEnergy,
    required this.futureGuidance,
    required this.cosmicMessage,
    this.elementAnalysis = '',
    this.modalityAnalysis = '',
    this.planetaryHourInfo = '',
    this.rulingPlanetMessage = '',
    this.dailyRitual = '',
    this.meditationFocus = '',
    this.affirmation = '',
    this.crystalOfDay = '',
    this.crystalMeaning = '',
    this.chakraFocus = '',
    this.chakraExercise = '',
    this.spiritAnimal = '',
    this.spiritAnimalMessage = '',
    this.numerologyInsight = '',
    this.tarotCard = '',
    this.tarotMeaning = '',
    this.moonPhaseEffect = '',
    this.specialWarning = '',
    this.luckyTime = '',
  });

  Map<String, dynamic> toJson() => {
    'sign': sign.index,
    'date': date.toIso8601String(),
    'summary': summary,
    'loveAdvice': loveAdvice,
    'careerAdvice': careerAdvice,
    'healthAdvice': healthAdvice,
    'luckRating': luckRating,
    'luckyNumber': luckyNumber,
    'luckyColor': luckyColor,
    'mood': mood,
    'pastInsight': pastInsight,
    'presentEnergy': presentEnergy,
    'futureGuidance': futureGuidance,
    'cosmicMessage': cosmicMessage,
  };

  factory DailyHoroscope.fromJson(Map<String, dynamic> json) => DailyHoroscope(
    sign: ZodiacSign.values[json['sign'] as int],
    date: DateTime.parse(json['date'] as String),
    summary: json['summary'] as String,
    loveAdvice: json['loveAdvice'] as String,
    careerAdvice: json['careerAdvice'] as String,
    healthAdvice: json['healthAdvice'] as String,
    luckRating: json['luckRating'] as int,
    luckyNumber: json['luckyNumber'] as String,
    luckyColor: json['luckyColor'] as String,
    mood: json['mood'] as String,
    pastInsight: json['pastInsight'] as String? ?? '',
    presentEnergy: json['presentEnergy'] as String? ?? '',
    futureGuidance: json['futureGuidance'] as String? ?? '',
    cosmicMessage: json['cosmicMessage'] as String? ?? '',
  );
}

class Compatibility {
  final ZodiacSign sign1;
  final ZodiacSign sign2;
  final int overallScore; // 0-100
  final int loveScore;
  final int friendshipScore;
  final int communicationScore;
  final String summary;
  final List<String> strengths;
  final List<String> challenges;

  Compatibility({
    required this.sign1,
    required this.sign2,
    required this.overallScore,
    required this.loveScore,
    required this.friendshipScore,
    required this.communicationScore,
    required this.summary,
    required this.strengths,
    required this.challenges,
  });
}
