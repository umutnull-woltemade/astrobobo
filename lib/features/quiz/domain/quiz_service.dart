import 'quiz_models.dart';

/// Quiz Service - Quiz içerikleri ve segment hesaplama
class QuizService {
  QuizService._();

  /// Quiz tipine göre quiz getir
  static Quiz getQuiz(String type) {
    switch (type) {
      case 'dream':
        return _dreamQuiz;
      case 'astrology':
        return _astrologyQuiz;
      case 'numerology':
        return _numerologyQuiz;
      default:
        return _generalQuiz;
    }
  }

  /// Cevaplara göre sonuç hesapla
  static QuizResult calculateResult(Quiz quiz, Map<int, int> answers) {
    int totalScore = 0;
    int maxPossibleScore = quiz.questions.length * 5;

    for (var entry in answers.entries) {
      final questionIndex = entry.key;
      final answerIndex = entry.value;

      if (questionIndex < quiz.questions.length) {
        final question = quiz.questions[questionIndex];
        if (answerIndex < question.answers.length) {
          totalScore += question.answers[answerIndex].weight;
        }
      }
    }

    // Segment hesapla
    final percentage = (totalScore / maxPossibleScore) * 100;
    QuizSegment segment;
    if (percentage >= 70) {
      segment = QuizSegment.high;
    } else if (percentage >= 40) {
      segment = QuizSegment.medium;
    } else {
      segment = QuizSegment.low;
    }

    // Quiz tipine göre sonuç döndür
    return _getResultForSegment(quiz.type, segment, totalScore);
  }

  static QuizResult _getResultForSegment(
    QuizType type,
    QuizSegment segment,
    int score,
  ) {
    switch (type) {
      case QuizType.dream:
        return _getDreamResult(segment, score);
      case QuizType.astrology:
        return _getAstrologyResult(segment, score);
      case QuizType.numerology:
        return _getNumerologyResult(segment, score);
      default:
        return _getGeneralResult(segment, score);
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // RÜYA QUIZ'İ
  // ═══════════════════════════════════════════════════════════════

  static final Quiz _dreamQuiz = Quiz(
    id: 'dream_insight',
    title: 'Rüya Farkındalık Testi',
    description: 'Rüyalarının sana ne söylediğini keşfet',
    type: QuizType.dream,
    questions: [
      const QuizQuestion(
        text: 'Rüyalarını ne sıklıkla hatırlıyorsun?',
        emoji: '💭',
        answers: [
          QuizAnswer(text: 'Her gece hatırlarım', emoji: '🌟', weight: 5),
          QuizAnswer(text: 'Haftada birkaç kez', emoji: '✨', weight: 4),
          QuizAnswer(text: 'Nadiren', emoji: '🌙', weight: 2),
          QuizAnswer(text: 'Neredeyse hiç', emoji: '😴', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Rüyalarında en çok ne hissediyorsun?',
        emoji: '🎭',
        answers: [
          QuizAnswer(text: 'Derin duygular yaşarım', emoji: '💫', weight: 5),
          QuizAnswer(text: 'Merak ve keşif', emoji: '🔍', weight: 4),
          QuizAnswer(text: 'Bazen korku, bazen huzur', emoji: '🌓', weight: 3),
          QuizAnswer(text: 'Pek duygusal değil', emoji: '😐', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Tekrarlayan rüyaların var mı?',
        emoji: '🔄',
        answers: [
          QuizAnswer(text: 'Evet, çok sık', emoji: '🔮', weight: 5),
          QuizAnswer(text: 'Bazen oluyor', emoji: '🌀', weight: 3),
          QuizAnswer(text: 'Bir-iki kez oldu', emoji: '💫', weight: 2),
          QuizAnswer(text: 'Hayır, hiç olmadı', emoji: '❌', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Rüyanın anlamını merak ediyor musun?',
        emoji: '🧩',
        answers: [
          QuizAnswer(text: 'Çok merak ediyorum', emoji: '🔥', weight: 5),
          QuizAnswer(text: 'Bazen araştırırım', emoji: '📚', weight: 4),
          QuizAnswer(text: 'Sadece ilginç olanlarda', emoji: '🤔', weight: 2),
          QuizAnswer(text: 'Pek umursamam', emoji: '🤷', weight: 1),
        ],
      ),
    ],
  );

  static QuizResult _getDreamResult(QuizSegment segment, int score) {
    switch (segment) {
      case QuizSegment.high:
        return QuizResult(
          title: 'Rüya Kâşifi',
          description:
              'Bilinçaltın çok aktif! Rüyaların sana önemli mesajlar veriyor. '
              'Kişiselleştirilmiş rüya analizi ile derinlere inmeye hazırsın.',
          emoji: '🔮',
          segment: segment,
          score: score,
          recommendedRoute: '/dream-interpretation',
        );
      case QuizSegment.medium:
        return QuizResult(
          title: 'Rüya Yolcusu',
          description:
              'Rüyalarınla bağlantın gelişiyor. Biraz daha farkındalıkla '
              'bilinçaltının mesajlarını daha net duyabilirsin.',
          emoji: '🌙',
          segment: segment,
          score: score,
        );
      case QuizSegment.low:
        return QuizResult(
          title: 'Rüya Uyuyanı',
          description:
              'Rüya dünyası seni bekliyor. Küçük adımlarla bilinçaltınla '
              'bağlantını güçlendirebilirsin.',
          emoji: '💤',
          segment: segment,
          score: score,
        );
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // ASTROLOJİ QUIZ'İ
  // ═══════════════════════════════════════════════════════════════

  static final Quiz _astrologyQuiz = Quiz(
    id: 'astro_insight',
    title: 'Kozmik Farkındalık Testi',
    description: 'Yıldızlarla bağlantını keşfet',
    type: QuizType.astrology,
    questions: [
      const QuizQuestion(
        text: 'Burç yorumlarını ne sıklıkla okursun?',
        emoji: '⭐',
        answers: [
          QuizAnswer(text: 'Her gün kontrol ederim', emoji: '🌟', weight: 5),
          QuizAnswer(text: 'Haftada birkaç kez', emoji: '✨', weight: 4),
          QuizAnswer(text: 'Ara sıra', emoji: '🌙', weight: 2),
          QuizAnswer(text: 'Nadiren', emoji: '💫', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Doğum haritanı biliyor musun?',
        emoji: '🗺️',
        answers: [
          QuizAnswer(text: 'Detaylı biliyorum', emoji: '📊', weight: 5),
          QuizAnswer(
            text: 'Güneş ve Ay burcumu biliyorum',
            emoji: '☀️',
            weight: 4,
          ),
          QuizAnswer(text: 'Sadece güneş burcumu', emoji: '♈', weight: 2),
          QuizAnswer(text: 'Hiç bakmadım', emoji: '🤷', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Retrograd dönemleri takip eder misin?',
        emoji: '🔄',
        answers: [
          QuizAnswer(text: 'Kesinlikle, önemli!', emoji: '⚠️', weight: 5),
          QuizAnswer(text: 'Bazen dikkat ederim', emoji: '👀', weight: 3),
          QuizAnswer(text: 'Duydum ama takip etmem', emoji: '🤔', weight: 2),
          QuizAnswer(text: 'Retrograd ne?', emoji: '❓', weight: 1),
        ],
      ),
    ],
  );

  static QuizResult _getAstrologyResult(QuizSegment segment, int score) {
    switch (segment) {
      case QuizSegment.high:
        return QuizResult(
          title: 'Kozmik Usta',
          description:
              'Yıldızlarla güçlü bir bağın var! Kişisel transit raporları ve '
              'detaylı harita analizi ile kozmik yolculuğunu derinleştir.',
          emoji: '🌟',
          segment: segment,
          score: score,
          recommendedRoute: '/birth-chart',
        );
      case QuizSegment.medium:
        return QuizResult(
          title: 'Yıldız Yolcusu',
          description:
              'Astroloji ile bağlantın gelişiyor. Doğum haritanı keşfederek '
              'kendini daha iyi tanıyabilirsin.',
          emoji: '⭐',
          segment: segment,
          score: score,
        );
      case QuizSegment.low:
        return QuizResult(
          title: 'Kozmik Kaşif',
          description:
              'Yıldızlar seni bekliyor! Basit burç yorumlarıyla başlayarak '
              'kozmik yolculuğuna adım at.',
          emoji: '✨',
          segment: segment,
          score: score,
        );
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // NUMEROLOJİ QUIZ'İ
  // ═══════════════════════════════════════════════════════════════

  static final Quiz _numerologyQuiz = Quiz(
    id: 'number_insight',
    title: 'Sayı Farkındalık Testi',
    description: 'Sayıların gizli mesajlarını keşfet',
    type: QuizType.numerology,
    questions: [
      const QuizQuestion(
        text: 'Belirli sayıları sürekli görür müsün?',
        emoji: '🔢',
        answers: [
          QuizAnswer(text: 'Evet, 11:11 gibi çok sık', emoji: '1️⃣', weight: 5),
          QuizAnswer(text: 'Bazen dikkatimi çeker', emoji: '👀', weight: 3),
          QuizAnswer(text: 'Nadiren fark ederim', emoji: '🤔', weight: 2),
          QuizAnswer(text: 'Hayır, dikkat etmem', emoji: '🤷', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Yaşam yolu sayını biliyor musun?',
        emoji: '🛤️',
        answers: [
          QuizAnswer(
            text: 'Evet ve anlamını biliyorum',
            emoji: '📖',
            weight: 5,
          ),
          QuizAnswer(
            text: 'Hesapladım ama anlamını bilmiyorum',
            emoji: '🔍',
            weight: 3,
          ),
          QuizAnswer(text: 'Duydum ama hesaplamadım', emoji: '💭', weight: 2),
          QuizAnswer(text: 'Hiç duymadım', emoji: '❓', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Önemli tarihlerde sayılara anlam yükler misin?',
        emoji: '📅',
        answers: [
          QuizAnswer(
            text: 'Kesinlikle, tarih seçerken dikkat ederim',
            emoji: '✅',
            weight: 5,
          ),
          QuizAnswer(text: 'Bazen düşünürüm', emoji: '🤔', weight: 3),
          QuizAnswer(text: 'Nadiren', emoji: '🌙', weight: 2),
          QuizAnswer(text: 'Hiç düşünmedim', emoji: '❌', weight: 1),
        ],
      ),
    ],
  );

  static QuizResult _getNumerologyResult(QuizSegment segment, int score) {
    switch (segment) {
      case QuizSegment.high:
        return QuizResult(
          title: 'Sayı Ustası',
          description:
              'Sayılarla güçlü bir bağın var! Kişisel numeroloji raporun ile '
              'yaşam yolundaki gizli mesajları keşfet.',
          emoji: '🔢',
          segment: segment,
          score: score,
          recommendedRoute: '/numerology',
        );
      case QuizSegment.medium:
        return QuizResult(
          title: 'Sayı Yolcusu',
          description:
              'Sayıların enerjisini hissediyorsun. Yaşam yolu sayınla '
              'hayatına yön verebilirsin.',
          emoji: '🔮',
          segment: segment,
          score: score,
        );
      case QuizSegment.low:
        return QuizResult(
          title: 'Sayı Kaşifi',
          description:
              'Sayıların dünyası seni bekliyor. Doğum tarihinden başlayarak '
              'numerolojinin kapılarını aralayabilirsin.',
          emoji: '✨',
          segment: segment,
          score: score,
        );
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // GENEL QUIZ
  // ═══════════════════════════════════════════════════════════════

  static final Quiz _generalQuiz = Quiz(
    id: 'cosmic_profile',
    title: 'Kozmik Profil Testi',
    description: 'Ruhsal yolculuğunu keşfet',
    type: QuizType.general,
    questions: [
      const QuizQuestion(
        text: 'Kendini en çok ne zaman huzurlu hissedersin?',
        emoji: '🧘',
        answers: [
          QuizAnswer(
            text: 'Meditasyon veya sessizlikte',
            emoji: '🕯️',
            weight: 5,
          ),
          QuizAnswer(text: 'Doğada yürürken', emoji: '🌿', weight: 4),
          QuizAnswer(
            text: 'Sevdiklerimle birlikteyken',
            emoji: '💕',
            weight: 3,
          ),
          QuizAnswer(text: 'Aktif bir şeyler yaparken', emoji: '🏃', weight: 2),
        ],
      ),
      const QuizQuestion(
        text: 'Sezgilerine ne kadar güvenirsin?',
        emoji: '🔮',
        answers: [
          QuizAnswer(text: 'Tamamen, hiç yanıltmadı', emoji: '💫', weight: 5),
          QuizAnswer(text: 'Çoğunlukla dinlerim', emoji: '👂', weight: 4),
          QuizAnswer(text: 'Bazen dikkate alırım', emoji: '🤔', weight: 2),
          QuizAnswer(text: 'Mantığıma güvenirim', emoji: '🧠', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Ruhsal gelişimle ilgili ne yaparsın?',
        emoji: '✨',
        answers: [
          QuizAnswer(text: 'Düzenli pratiklerim var', emoji: '📿', weight: 5),
          QuizAnswer(text: 'Kitap okurum, araştırırım', emoji: '📚', weight: 4),
          QuizAnswer(text: 'Ara sıra ilgilenirim', emoji: '🌙', weight: 2),
          QuizAnswer(text: 'Pek ilgilenmem', emoji: '🤷', weight: 1),
        ],
      ),
      const QuizQuestion(
        text: 'Hayatta en çok neyi ararsın?',
        emoji: '🎯',
        answers: [
          QuizAnswer(text: 'Anlam ve amaç', emoji: '🌟', weight: 5),
          QuizAnswer(text: 'İç huzur', emoji: '☮️', weight: 4),
          QuizAnswer(text: 'Sevgi ve bağlantı', emoji: '💗', weight: 3),
          QuizAnswer(text: 'Başarı ve tanınma', emoji: '🏆', weight: 2),
        ],
      ),
    ],
  );

  static QuizResult _getGeneralResult(QuizSegment segment, int score) {
    switch (segment) {
      case QuizSegment.high:
        return QuizResult(
          title: 'Ruhsal Rehber',
          description:
              'İçsel yolculuğun derin ve anlamlı. Kozmik araçlarımız ile '
              'farkındalığını bir üst seviyeye taşıyabilirsin.',
          emoji: '🌟',
          segment: segment,
          score: score,
          recommendedRoute: '/kozmoz',
        );
      case QuizSegment.medium:
        return QuizResult(
          title: 'Ruhsal Yolcu',
          description:
              'Kendini keşfetme yolculuğundasın. Farklı kozmik araçları '
              'deneyerek sana en uygun olanı bulabilirsin.',
          emoji: '🚀',
          segment: segment,
          score: score,
        );
      case QuizSegment.low:
        return QuizResult(
          title: 'Ruhsal Meraklı',
          description:
              'Yeni başlangıçlar heyecan verici! Küçük adımlarla kendi '
              'ruhsal yolculuğuna başlayabilirsin.',
          emoji: '🌱',
          segment: segment,
          score: score,
        );
    }
  }
}
