import 'dart:math';
import '../models/zodiac_sign.dart';

/// Horoscope content templates for algorithmic generation
/// Uses seeded random selection for deterministic, reproducible daily readings
class HoroscopeTemplates {
  // General daily opening statements (50+ variations)
  static const List<String> generalOpenings = [
    'Bugün enerjin yüksek ve motivasyonun güçlü.',
    'Evren sana yeni fırsatlar sunuyor.',
    'İç sesin bugün özellikle güçlü konuşuyor.',
    'Bugün değişim rüzgarları esiyor.',
    'Yıldızlar senin için olumlu bir hizalanma içinde.',
    'Bugün kendine odaklanman gereken bir gün.',
    'Sabırlı olmak bugün en büyük gücün olacak.',
    'Yaratıcılığın bugün zirve yapıyor.',
    'Bugün duygusal farkındalığın artıyor.',
    'Yeni başlangıçlar için ideal bir gün.',
    'Bugün geçmişle yüzleşme zamanı olabilir.',
    'Evren seni doğru yola yönlendiriyor.',
    'İç huzurun bugün ön planda olacak.',
    'Cesaret gerektiren adımlar için uygun bir gün.',
    'Bugün detaylara dikkat etmen gerekiyor.',
    'Sosyal bağlantıların bugün güçleniyor.',
    'Finansal konularda dikkatli olman gereken bir gün.',
    'Bugün sezgilerin seni yanıltmayacak.',
    'Beklenmedik haberler alabilirsin.',
    'Bugün öz güvenin artıyor.',
    'Evren sana bir mesaj gönderiyor.',
    'Ruhsal gelişimin için önemli bir gün.',
    'Bugün pratik düşünce ön planda.',
    'Romantik enerjiler güçleniyor.',
    'Kariyer odaklı düşünceler ön planda olacak.',
    'Bugün aile konuları gündeme gelebilir.',
    'İletişim becerilerin bugün parlıyor.',
    'Bugün eski dostlardan haber alabilirsin.',
    'Yeni projeler için ilham dolu bir gün.',
    'Bugün dinlenmeye öncelik ver.',
    'Evren sana cesaret veriyor.',
    'İçsel dönüşüm için güçlü bir gün.',
    'Bugün sınırlarını zorlamaktan korkma.',
    'Olumlu enerjiler etrafını sarıyor.',
    'Bugün mantık ve duygu dengesini kur.',
    'Yeni insanlarla tanışma fırsatı doğabilir.',
    'Bugün hedeflerine odaklan.',
    'Evren seni destekliyor.',
    'İç çatışmalar bugün çözüme kavuşabilir.',
    'Bugün liderlik özelliklerini göster.',
    'Sanatsal ilhamlar güçleniyor.',
    'Bugün rutinlerini gözden geçir.',
    'Beklenmedik fırsatlar kapını çalabilir.',
    'Bugün empati gücün artıyor.',
    'Evren sana sabır dersi veriyor.',
    'İç dünyana yolculuk için ideal bir gün.',
    'Bugün çevrene pozitif enerji yay.',
    'Kişisel gelişim için motive olduğun bir gün.',
    'Bugün risk almaktan korkma.',
    'Evren seninle işbirliği yapıyor.',
  ];

  // Love/Relationship advice (50+ variations)
  static const List<String> loveAdvice = [
    'Aşk hayatında güzel sürprizler olabilir.',
    'Partnerinle derin bir bağ kurabilirsin.',
    'Yalnızsan, yeni biri ile tanışma ihtimalin yüksek.',
    'Romantik jestler bugün karşılık bulacak.',
    'İlişkinde iletişimi güçlendirmeye odaklan.',
    'Duygularını ifade etmekten çekinme.',
    'Partnerinin ihtiyaçlarına kulak ver.',
    'Aşk hayatında netlik kazanacaksın.',
    'Eski bir aşk aklına gelebilir.',
    'Kalp kırıklıkları bugün iyileşmeye başlayabilir.',
    'Romantik bir davet alabilirsin.',
    'Partnerinle kaliteli zaman geçir.',
    'Flört enerjin bugün yüksek.',
    'İlişkinde güven konuları gündeme gelebilir.',
    'Sevdiklerinle bağlarını güçlendir.',
    'Aşkta sabırlı ol, her şey zamanla.',
    'Duygusal yakınlık kurma fırsatı doğuyor.',
    'Partnerinle ortak hedefler belirleyin.',
    'Aşk hayatında yeni bir sayfa açılıyor.',
    'Geçmiş ilişki kalıplarını gözden geçir.',
    'Romantizmi günlük hayata taşı.',
    'Partnerini olduğu gibi kabul et.',
    'Aşkta risk almak seni ödüllendirebilir.',
    'Duygusal bağlarını derinleştir.',
    'İlişkinde denge kurmaya çalış.',
    'Sevgi dolu anlar seni bekliyor.',
    'Aşk hayatında netleşme zamanı.',
    'Partnerinle açık iletişim kur.',
    'Romantik hayallerin gerçekleşebilir.',
    'Aşkta cesur adımlar atma zamanı.',
    'Duygusal iyileşme sürecinde ilerleme.',
    'Yeni aşk kapıları açılıyor.',
    'Partnerinle birlikte büyüyün.',
    'Aşk hayatında sürprizlere açık ol.',
    'Kalbinin sesini dinle.',
    'İlişkinde uyum artıyor.',
    'Romantik enerjiler zirvede.',
    'Aşkta tutku yeniden alevleniyor.',
    'Partnerinle güzel anılar biriktirin.',
    'Duygusal destek alacaksın.',
    'Aşk hayatında berraklık geliyor.',
    'Yeni tanışıklıklar önemli olabilir.',
    'Partnerinle empati kurmaya çalış.',
    'Aşkta olgunlaşma zamanı.',
    'Romantik atmosfer yaratmaya odaklan.',
    'Duygusal bağlılık güçleniyor.',
    'Aşk hayatında pozitif gelişmeler.',
    'Partnerinle geleceği konuşun.',
    'Kalbin açık ve hazır.',
    'Aşkta yeni başlangıçlar mümkün.',
  ];

  // Career/Work advice (50+ variations)
  static const List<String> careerAdvice = [
    'İş hayatında önemli fırsatlar doğabilir.',
    'Profesyonel becerilerini sergileme zamanı.',
    'Yeni projeler için uygun bir gün.',
    'Kariyer hedeflerini gözden geçir.',
    'İş yerinde liderlik özelliklerini göster.',
    'Finansal konularda dikkatli ol.',
    'İş arkadaşlarınla uyum içinde çalış.',
    'Yeni iş fırsatları kapını çalabilir.',
    'Profesyonel ağını genişlet.',
    'İş hayatında yaratıcı çözümler bul.',
    'Kariyer planlarını netleştir.',
    'Üstlerinle ilişkilerini güçlendir.',
    'İş hayatında sabır göster.',
    'Yeni beceriler öğrenmek için ideal bir gün.',
    'Profesyonel gelişimine yatırım yap.',
    'İş yerinde inisiyatif al.',
    'Finansal planlama için uygun bir gün.',
    'Kariyer değişikliği düşünebilirsin.',
    'İş hayatında denge kurmaya çalış.',
    'Profesyonel hedeflerine odaklan.',
    'Yeni müşteriler veya ortaklıklar mümkün.',
    'İş yerinde diplomatik ol.',
    'Kariyer fırsatlarına açık ol.',
    'Finansal istikrar için adımlar at.',
    'İş hayatında verimlilik artıyor.',
    'Profesyonel itibarını güçlendir.',
    'Yeni projeler ilham verici olabilir.',
    'İş arkadaşlarından destek alacaksın.',
    'Kariyer hedeflerine doğru ilerliyorsun.',
    'Finansal kararlar için uygun bir gün.',
    'İş hayatında değişimler olabilir.',
    'Profesyonel eğitimlere katıl.',
    'Yeni sorumluluklar alabilirsin.',
    'İş yerinde pozitif enerji yay.',
    'Kariyer planlarını gözden geçir.',
    'Finansal fırsatları değerlendir.',
    'İş hayatında başarı yaklaşıyor.',
    'Profesyonel ilişkilerini koru.',
    'Yeni fikirler sunma zamanı.',
    'İş yerinde problem çözme becerilerin parlıyor.',
    'Kariyer yolculuğunda önemli bir gün.',
    'Finansal hedeflere doğru ilerleme.',
    'İş hayatında motivasyon artıyor.',
    'Profesyonel gelişim fırsatları.',
    'Yeni ortaklıklar kurabilirsin.',
    'İş yerinde dikkatli iletişim kur.',
    'Kariyer atılımları için hazırlan.',
    'Finansal bilincin artıyor.',
    'İş hayatında yeni kapılar açılıyor.',
    'Profesyonel hedeflerine ulaşıyorsun.',
  ];

  // Health/Wellness advice (50+ variations)
  static const List<String> healthAdvice = [
    'Sağlığına ekstra dikkat göster.',
    'Fiziksel aktiviteye zaman ayır.',
    'Beslenme alışkanlıklarını gözden geçir.',
    'Stres yönetimine odaklan.',
    'Uyku düzenini korumaya çalış.',
    'Zihinsel sağlığına özen göster.',
    'Egzersiz yapmak için motivasyonun yüksek.',
    'Meditasyon veya yoga düşün.',
    'Su tüketimini artırmaya dikkat et.',
    'Enerji seviyen dengeli olacak.',
    'Doğada vakit geçirmek sana iyi gelecek.',
    'Sağlıklı sınırlar koymaya çalış.',
    'Fiziksel yorgunluk hissedebilirsin.',
    'Ruh sağlığına yatırım yap.',
    'Sağlık kontrollerini ihmal etme.',
    'Enerji seviyen bugün yüksek.',
    'Stresli durumlardan uzak dur.',
    'Sağlıklı rutinler oluştur.',
    'Nefes egzersizleri faydalı olabilir.',
    'Fiziksel aktivite moralini yükseltecek.',
    'Uyku kalitenize dikkat edin.',
    'Sağlık konusunda bilinçli kararlar al.',
    'Enerji dengesini koru.',
    'Stresin vücuduna etkisine dikkat et.',
    'Sağlıklı beslenmeye önem ver.',
    'Fiziksel ve zihinsel denge için çalış.',
    'Dinlenmeye zaman ayır.',
    'Sağlığınla ilgili profesyonel destek düşün.',
    'Enerji seviyen yükseliyor.',
    'Stres atma yöntemlerini dene.',
    'Sağlık rutinlerini gözden geçir.',
    'Fiziksel aktivite motive edici olacak.',
    'Zihinsel dinlenmeye ihtiyacın var.',
    'Sağlıklı alışkanlıklar için ideal gün.',
    'Enerji yönetimine dikkat et.',
    'Stresle başa çıkma stratejileri geliştir.',
    'Sağlık hedeflerine odaklan.',
    'Fiziksel dayanıklılığın artıyor.',
    'Zihinsel berraklık hissedeceksin.',
    'Sağlıklı yaşam tarzı için adımlar at.',
    'Enerji ve motivasyon yüksek.',
    'Stres kaynaklarını belirle.',
    'Sağlık açısından olumlu bir gün.',
    'Fiziksel ve duygusal denge kur.',
    'Zihinsel sağlık için kendinle zaman geçir.',
    'Sağlık konularında bilinçlen.',
    'Enerji seviyeni dengede tut.',
    'Stres azaltma teknikleri dene.',
    'Sağlıklı seçimler yap.',
    'Fiziksel aktiviteyle gününe başla.',
  ];

  // Planetary influence modifiers
  static const Map<String, List<String>> planetaryModifiers = {
    'mercury_retrograde': [
      'Merkür retrosu nedeniyle iletişimde dikkatli ol.',
      'Teknolojik aksaklıklar yaşanabilir.',
      'Eski konuları yeniden düşünme zamanı.',
      'Sözleşmeleri dikkatli incele.',
      'Geçmişten biri aklına gelebilir.',
    ],
    'venus_retrograde': [
      'Venüs retrosu aşk hayatını etkiliyor.',
      'Eski ilişkileri sorgulama zamanı.',
      'Finansal kararları ertele.',
      'Güzellik ve estetik konularında dikkatli ol.',
      'Değerlerini yeniden gözden geçir.',
    ],
    'mars_retrograde': [
      'Mars retrosu enerji düşüklüğüne neden olabilir.',
      'Öfke kontrolüne dikkat et.',
      'Büyük projeler başlatmaktan kaçın.',
      'Fiziksel aktivitelerde dikkatli ol.',
      'Motivasyon dalgalanmaları yaşanabilir.',
    ],
    'full_moon': [
      'Dolunay duygusal yoğunluk getiriyor.',
      'İç görüler güçleniyor.',
      'Tamamlanma ve sonuçlanma enerjisi.',
      'Duygusal arınma zamanı.',
      'Sezgilerine güven.',
    ],
    'new_moon': [
      'Yeni ay yeni başlangıçlar için ideal.',
      'Niyet belirleme zamanı.',
      'İçe dönük bir dönem.',
      'Yeni projeler planla.',
      'Tohumlar ekme zamanı.',
    ],
  };

  // Lucky colors by zodiac sign
  static const Map<ZodiacSign, List<String>> luckyColors = {
    ZodiacSign.aries: ['Kırmızı', 'Turuncu', 'Sarı', 'Beyaz'],
    ZodiacSign.taurus: ['Yeşil', 'Pembe', 'Mavi', 'Toprak Tonları'],
    ZodiacSign.gemini: ['Sarı', 'Açık Mavi', 'Yeşil', 'Beyaz'],
    ZodiacSign.cancer: ['Gümüş', 'Beyaz', 'Krem', 'Açık Mavi'],
    ZodiacSign.leo: ['Altın', 'Turuncu', 'Sarı', 'Mor'],
    ZodiacSign.virgo: ['Yeşil', 'Kahverengi', 'Bej', 'Lacivert'],
    ZodiacSign.libra: ['Pembe', 'Açık Mavi', 'Lavanta', 'Yeşil'],
    ZodiacSign.scorpio: ['Bordo', 'Siyah', 'Mor', 'Koyu Kırmızı'],
    ZodiacSign.sagittarius: ['Mor', 'Mavi', 'Turuncu', 'Turkuaz'],
    ZodiacSign.capricorn: ['Siyah', 'Koyu Yeşil', 'Kahverengi', 'Gri'],
    ZodiacSign.aquarius: ['Mavi', 'Turkuaz', 'Mor', 'Gümüş'],
    ZodiacSign.pisces: ['Deniz Mavisi', 'Yeşil', 'Mor', 'Lila'],
  };

  /// Generate a seeded random number
  static int _generateSeed(DateTime date, ZodiacSign sign) {
    return date.year * 10000 +
        date.month * 100 +
        date.day +
        sign.index * 1000000;
  }

  /// Get a random item from a list using seeded random
  static String _getSeededItem(List<String> items, int seed, int offset) {
    final random = Random(seed + offset);
    return items[random.nextInt(items.length)];
  }

  /// Generate daily horoscope reading
  static Map<String, dynamic> generateDailyReading(
    DateTime date,
    ZodiacSign sign,
  ) {
    final seed = _generateSeed(date, sign);
    final random = Random(seed);

    // Generate readings
    final general = _getSeededItem(generalOpenings, seed, 0);
    final love = _getSeededItem(loveAdvice, seed, 100);
    final career = _getSeededItem(careerAdvice, seed, 200);
    final health = _getSeededItem(healthAdvice, seed, 300);

    // Generate scores (based on seed for consistency)
    final moodScore = 0.5 + (random.nextDouble() * 0.5); // 0.5-1.0
    final loveScore = 0.4 + (random.nextDouble() * 0.6); // 0.4-1.0
    final careerScore = 0.4 + (random.nextDouble() * 0.6); // 0.4-1.0
    final healthScore = 0.5 + (random.nextDouble() * 0.5); // 0.5-1.0

    // Lucky number (1-99)
    final luckyNumber = 1 + random.nextInt(99);

    // Lucky color
    final colors = luckyColors[sign] ?? ['Beyaz'];
    final luckyColor = colors[random.nextInt(colors.length)];

    return {
      'general': general,
      'love': love,
      'career': career,
      'health': health,
      'moodScore': moodScore,
      'loveScore': loveScore,
      'careerScore': careerScore,
      'healthScore': healthScore,
      'luckyNumber': luckyNumber,
      'luckyColor': luckyColor,
      'date': date,
      'sign': sign,
    };
  }

  /// Apply planetary modifier if applicable
  static String applyModifier(String reading, String modifier) {
    final modifiers = planetaryModifiers[modifier];
    if (modifiers != null && modifiers.isNotEmpty) {
      final random = Random();
      return '$reading ${modifiers[random.nextInt(modifiers.length)]}';
    }
    return reading;
  }

  /// Generate compatibility summary
  static String generateCompatibilitySummary(
    ZodiacSign sign1,
    ZodiacSign sign2,
    int overallScore,
  ) {
    if (overallScore >= 80) {
      return '${sign1.nameTr} ve ${sign2.nameTr} arasında güçlü bir uyum var. '
          'Bu ilişki karşılıklı anlayış ve derin bağ potansiyeli taşıyor.';
    } else if (overallScore >= 60) {
      return '${sign1.nameTr} ve ${sign2.nameTr} iyi bir uyum sergiliyor. '
          'Bazı farklılıklar olsa da, birbirini tamamlama potansiyeli yüksek.';
    } else if (overallScore >= 40) {
      return '${sign1.nameTr} ve ${sign2.nameTr} arasında orta düzeyde uyum var. '
          'İlişkinin gelişmesi için karşılıklı çaba gerekebilir.';
    } else {
      return '${sign1.nameTr} ve ${sign2.nameTr} arasında zorlayıcı bir dinamik var. '
          'Bu ilişki büyüme fırsatları sunarken, sabır ve anlayış gerektiriyor.';
    }
  }
}
