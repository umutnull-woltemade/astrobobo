import 'dart:math';
import '../models/specialized_tools.dart';
import '../models/zodiac_sign.dart';

class SpecializedToolsService {
  static final SpecializedToolsService _instance =
      SpecializedToolsService._internal();
  factory SpecializedToolsService() => _instance;
  SpecializedToolsService._internal();

  /// Generate Local Space Chart
  LocalSpaceChart generateLocalSpaceChart({
    required String userName,
    required DateTime birthDate,
    required double latitude,
    required double longitude,
  }) {
    final random = Random(birthDate.millisecondsSinceEpoch);
    final planets = [
      'Güneş',
      'Ay',
      'Merkür',
      'Venüs',
      'Mars',
      'Jüpiter',
      'Satürn',
    ];

    final planetLines = planets.map((planet) {
      final azimuth = random.nextDouble() * 360;
      final direction = _getDirectionFromAzimuth(azimuth);

      return LocalSpaceLine(
        planet: planet,
        azimuth: azimuth,
        direction: direction,
        meaning: _getPlanetDirectionMeaning(planet, direction),
        homeAdvice: _getPlanetHomeAdvice(planet, direction),
        travelAdvice: _getPlanetTravelAdvice(planet, direction),
      );
    }).toList();

    final directions = CardinalDirection.values.map((dir) {
      final planetsInDirection = planetLines
          .where((l) => l.direction == dir)
          .map((l) => l.planet)
          .toList();

      return DirectionalInfluence(
        direction: dir,
        activePlanets: planetsInDirection,
        theme: _getDirectionTheme(dir, planetsInDirection),
        advice: _getDirectionAdvice(dir, planetsInDirection),
        strengthRating: planetsInDirection.isEmpty ? 2 : 3 + random.nextInt(3),
      );
    }).toList();

    return LocalSpaceChart(
      userName: userName,
      birthDate: birthDate,
      latitude: latitude,
      longitude: longitude,
      planetLines: planetLines,
      directions: directions,
      homeAnalysis: _generateHomeAnalysis(planetLines),
      officeAnalysis: _generateOfficeAnalysis(planetLines),
    );
  }

  CardinalDirection _getDirectionFromAzimuth(double azimuth) {
    if (azimuth >= 337.5 || azimuth < 22.5) return CardinalDirection.north;
    if (azimuth >= 22.5 && azimuth < 67.5) return CardinalDirection.northeast;
    if (azimuth >= 67.5 && azimuth < 112.5) return CardinalDirection.east;
    if (azimuth >= 112.5 && azimuth < 157.5) return CardinalDirection.southeast;
    if (azimuth >= 157.5 && azimuth < 202.5) return CardinalDirection.south;
    if (azimuth >= 202.5 && azimuth < 247.5) return CardinalDirection.southwest;
    if (azimuth >= 247.5 && azimuth < 292.5) return CardinalDirection.west;
    return CardinalDirection.northwest;
  }

  String _getPlanetDirectionMeaning(String planet, CardinalDirection dir) {
    final meanings = {
      'Güneş':
          'Kimlik ve yaşam gücünüz ${dir.nameTr} yönünde aktif. Bu yön sizin için enerji ve canlılık kaynağı.',
      'Ay':
          'Duygusal ihtiyaçlarınız ${dir.nameTr}\'dan besleniyor. Bu yön huzur ve güvenlik hissi verir.',
      'Merkür':
          '${dir.nameTr} yönü iletişim ve düşünce aktivitenizi destekliyor. Öğrenme bu yönde kolay.',
      'Venüs':
          'Aşk ve güzellik enerjiniz ${dir.nameTr}\'dan geliyor. İlişkiler bu yönde gelişir.',
      'Mars':
          'Eylem ve motivasyon gücünüz ${dir.nameTr}\'da yoğunlaşıyor. Bu yön size enerji verir.',
      'Jüpiter':
          '${dir.nameTr} yönü şans ve büyüme potansiyeli taşıyor. Fırsatlar bu yönden gelir.',
      'Satürn':
          '${dir.nameTr} yönü yapı ve disiplin gerektiriyor. Burada sabırlı olmanız gerekir.',
    };
    return meanings[planet] ??
        '${dir.nameTr} yönü sizin için özel anlam taşıyor.';
  }

  String _getPlanetHomeAdvice(String planet, CardinalDirection dir) {
    final advice = {
      'Güneş':
          'Evinizin ${dir.nameTr} kısmını aydınlık tutun. Burada bitkiler ve doğal ışık enerjinizi artırır.',
      'Ay':
          '${dir.nameTr} köşesini dinlenme alanı olarak kullanın. Burada meditasyon veya yoga yapabilirsiniz.',
      'Merkür':
          'Çalışma masanızı veya kitaplığınızı ${dir.nameTr}\'ya yerleştirin. Konsantrasyon artar.',
      'Venüs':
          '${dir.nameTr} köşesini güzelleştirin. Çiçekler, sanat eserleri veya romantik öğeler ekleyin.',
      'Mars':
          '${dir.nameTr}\'da egzersiz alanı veya aktif yaşam köşesi oluşturun.',
      'Jüpiter':
          '${dir.nameTr}\'yı genişletme alanı olarak düşünün. Burada plan ve vizyon çalışması yapın.',
      'Satürn':
          '${dir.nameTr} köşesini düzenli ve organize tutun. Kaos bu yönde sorun yaratabilir.',
    };
    return advice[planet] ??
        '${dir.nameTr} yönünü bilinçli olarak değerlendirin.';
  }

  String _getPlanetTravelAdvice(String planet, CardinalDirection dir) {
    final advice = {
      'Güneş':
          '${dir.nameTr}\'ya yapacağınız seyahatler kendinizi bulmanıza yardımcı olur.',
      'Ay':
          '${dir.nameTr} yönündeki yerler duygusal şifa için idealdir. Aile ziyaretleri düşünün.',
      'Merkür':
          '${dir.nameTr}\'ya eğitim veya iş amaçlı seyahatler verimli olur.',
      'Venüs':
          '${dir.nameTr} yönü romantik tatiller için mükemmel. Çiftler için önerilir.',
      'Mars':
          '${dir.nameTr}\'ya macera dolu seyahatler planlayın. Spor aktiviteleri düşünün.',
      'Jüpiter':
          '${dir.nameTr} yönünde uzak seyahatler şans getirir. Yabancı kültürleri keşfedin.',
      'Satürn':
          '${dir.nameTr}\'ya planlı ve organize seyahatler yapın. Acele etmeyin.',
    };
    return advice[planet] ?? '${dir.nameTr} yönüne seyahat düşünebilirsiniz.';
  }

  String _getDirectionTheme(CardinalDirection dir, List<String> planets) {
    if (planets.isEmpty) {
      return '${dir.nameTr} yönü nötr enerjiye sahip.';
    }
    if (planets.contains('Güneş') || planets.contains('Jüpiter')) {
      return '${dir.nameTr} yönü güçlü pozitif enerji taşıyor.';
    }
    if (planets.contains('Satürn') || planets.contains('Mars')) {
      return '${dir.nameTr} yönü dikkat ve bilinç gerektiriyor.';
    }
    return '${dir.nameTr} yönü dengeli enerji akışına sahip.';
  }

  String _getDirectionAdvice(CardinalDirection dir, List<String> planets) {
    if (planets.isEmpty) {
      return '${dir.nameTr} yönü için özel bir öneri yok. Genel dengeyi koruyun.';
    }
    final planetStr = planets.join(', ');
    return '$planetStr enerjileri ${dir.nameTr}\'da aktif. Bu yönü bilinçli kullanın.';
  }

  String _generateHomeAnalysis(List<LocalSpaceLine> lines) {
    final buffer = StringBuffer();
    buffer.writeln('Evinizin Yerel Uzay Analizi');
    buffer.writeln();
    buffer.writeln(
      'Ev düzeninizi gezegen enerjilerine göre optimize etmek için:',
    );
    buffer.writeln();

    for (final line in lines.take(4)) {
      buffer.writeln('• ${line.planet}: ${line.homeAdvice}');
    }

    buffer.writeln();
    buffer.writeln(
      'Bu düzenlemeler, evinizin enerjisini doğum haritanızla uyumlu hale getirir.',
    );

    return buffer.toString();
  }

  String _generateOfficeAnalysis(List<LocalSpaceLine> lines) {
    final buffer = StringBuffer();
    buffer.writeln('İş Yerinizin Yerel Uzay Analizi');
    buffer.writeln();
    buffer.writeln('Kariyer başarısı için öneriler:');
    buffer.writeln();

    final sunLine = lines.firstWhere((l) => l.planet == 'Güneş');
    final mercuryLine = lines.firstWhere((l) => l.planet == 'Merkür');
    final jupiterLine = lines.firstWhere((l) => l.planet == 'Jüpiter');

    buffer.writeln(
      '• Masanızı ${sunLine.direction.nameTr} yönüne bakacak şekilde konumlandırın.',
    );
    buffer.writeln(
      '• İletişim cihazlarınızı ${mercuryLine.direction.nameTr}\'ya yerleştirin.',
    );
    buffer.writeln(
      '• Büyüme hedeflerinizi ${jupiterLine.direction.nameTr} duvarına asın.',
    );

    return buffer.toString();
  }

  /// Generate Child Horoscope
  ChildHoroscope generateChildHoroscope({
    required String childName,
    required DateTime birthDate,
    ZodiacSign? moonSign,
  }) {
    final random = Random(
      birthDate.millisecondsSinceEpoch + DateTime.now().day,
    );
    final sunSign = ZodiacSignExtension.fromDate(birthDate);

    return ChildHoroscope(
      childName: childName,
      birthDate: birthDate,
      sunSign: sunSign,
      moonSign: moonSign,
      personalityProfile: _getChildPersonality(sunSign),
      learningStyle: _getChildLearningStyle(sunSign),
      socialStyle: _getChildSocialStyle(sunSign),
      emotionalNeeds: _getChildEmotionalNeeds(sunSign, moonSign),
      talents: _getChildTalents(sunSign),
      challenges: _getChildChallenges(sunSign),
      parentingTips: _getParentingTips(sunSign),
      dailyHoroscope: _getChildDailyHoroscope(sunSign, random),
      moodRating: 2 + random.nextInt(4),
      energyRating: 2 + random.nextInt(4),
      focusRating: 2 + random.nextInt(4),
    );
  }

  String _getChildPersonality(ZodiacSign sign) {
    final profiles = {
      ZodiacSign.aries:
          'Koç çocuğunuz enerjik, cesur ve bağımsız bir ruha sahip. '
          'Liderlik özellikleri doğuştan gelir ve rekabeti sever. Heyecan arayışı içindedir '
          've yeni deneyimlere açıktır. Sabırsız olabilir ama coşkusu bulaşıcıdır.',
      ZodiacSign.taurus:
          'Boğa çocuğunuz sakin, kararlı ve güvenilir bir yapıya sahip. '
          'Rutin ve istikrarı sever, değişime dirençli olabilir. Dokunsal deneyimlere '
          've fiziksel konfora önem verir. Sanatsal yetenekleri yüksektir.',
      ZodiacSign.gemini:
          'İkizler çocuğunuz meraklı, sosyal ve çok yönlüdür. '
          'Sürekli soru sorar ve her şeyi öğrenmek ister. İletişim becerileri erken gelişir. '
          'Çabuk sıkılabilir, bu yüzden çeşitli aktivitelere ihtiyaç duyar.',
      ZodiacSign.cancer:
          'Yengeç çocuğunuz hassas, şefkatli ve sezgisel bir doğaya sahip. '
          'Aile bağları çok önemlidir. Güvenli bir ortam ihtiyacı yüksektir. '
          'Hayal gücü zengindir ve duygusal zekası gelişmiştir.',
      ZodiacSign.leo:
          'Aslan çocuğunuz yaratıcı, cömert ve dikkat çekici bir kişiliğe sahip. '
          'Sahne performansını ve takdir edilmeyi sever. Liderlik rolleri doğaldır. '
          'Güçlü bir öz güven gösterir ama içten içe onaylanma ihtiyacı vardır.',
      ZodiacSign.virgo:
          'Başak çocuğunuz analitik, düzenli ve yardımsever bir yapıya sahip. '
          'Detaylara dikkat eder ve mükemmeliyetçi eğilimler gösterebilir. '
          'Pratik zekası yüksektir ve başkalarına yardım etmekten mutluluk duyar.',
      ZodiacSign.libra:
          'Terazi çocuğunuz uyumlu, adil ve sosyal bir kişiliğe sahip. '
          'Çatışmalardan kaçınır ve barış yaratmaya çalışır. Estetik duygusu gelişmiştir. '
          'Karar vermekte zorlanabilir çünkü herkesi memnun etmek ister.',
      ZodiacSign.scorpio:
          'Akrep çocuğunuz yoğun, kararlı ve sezgisel bir doğaya sahip. '
          'Derin düşünceli ve gözlemcidir. Gizli kalmasını istediği şeyler olabilir. '
          'Sadakati yüksektir ve duygusal bağları çok ciddiye alır.',
      ZodiacSign.sagittarius:
          'Yay çocuğunuz iyimser, maceracı ve dürüst bir kişiliğe sahip. '
          'Özgürlüğüne düşkündür ve kısıtlamalardan hoşlanmaz. '
          'Felsefi sorular sorar ve sürekli keşfetmek ister. Enerjisi yüksektir.',
      ZodiacSign.capricorn:
          'Oğlak çocuğunuz ciddi, sorumluluk sahibi ve hırslı bir yapıya sahip. '
          'Yaşıtlarından olgun görünebilir. Hedeflerine ulaşmak için çalışkandır. '
          'Geleneklere saygı duyar ve kuralları takip eder.',
      ZodiacSign.aquarius:
          'Kova çocuğunuz özgün, bağımsız ve insancıl bir kişiliğe sahip. '
          'Farklı düşünür ve kalıplara uymaktan hoşlanmaz. Arkadaşlıklara değer verir. '
          'Teknolojiye ve yeniliklere ilgi duyar.',
      ZodiacSign.pisces:
          'Balık çocuğunuz hayalperest, şefkatli ve sanatsal bir doğaya sahip. '
          'Hayal gücü çok zengindir. Duygusal olarak hassastır ve empati kapasitesi yüksektir. '
          'Sınırları belirsiz olabilir, bu yüzden yapı ve yönlendirmeye ihtiyaç duyar.',
    };
    return profiles[sign] ?? 'Çocuğunuz benzersiz bir kişiliğe sahip.';
  }

  String _getChildLearningStyle(ZodiacSign sign) {
    final styles = {
      ZodiacSign.aries:
          'Hareket ederek ve yarışarak öğrenir. Kısa, hızlı aktiviteler tercih eder.',
      ZodiacSign.taurus:
          'Pratik uygulamalarla öğrenir. Dokunsal materyaller kullanın. Sabrınız olsun.',
      ZodiacSign.gemini:
          'Okuyarak, konuşarak ve çeşitlilikle öğrenir. Farklı yöntemler deneyin.',
      ZodiacSign.cancer:
          'Duygusal bağlantı kurarak öğrenir. Hikayeler ve anılar etkilidir.',
      ZodiacSign.leo:
          'Performans göstererek ve takdir alarak öğrenir. Yaratıcı projeler verin.',
      ZodiacSign.virgo:
          'Sistematik ve detaylı açıklamalarla öğrenir. Adım adım ilerleyin.',
      ZodiacSign.libra:
          'İşbirliği yaparak ve tartışarak öğrenir. Partner çalışmaları etkilidir.',
      ZodiacSign.scorpio:
          'Derinlemesine araştırarak öğrenir. Bağımsız projeler verin.',
      ZodiacSign.sagittarius:
          'Keşfederek ve deneyimleyerek öğrenir. Açık hava aktiviteleri etkilidir.',
      ZodiacSign.capricorn:
          'Yapılandırılmış ortamda ve hedeflerle öğrenir. İlerleme gösterin.',
      ZodiacSign.aquarius:
          'Teknoloji kullanarak ve grup projelerinde öğrenir. Yenilikçi yöntemler deneyin.',
      ZodiacSign.pisces:
          'Görsel ve müzikal materyallerle öğrenir. Hayal gücünü kullanmasına izin verin.',
    };
    return styles[sign] ?? 'Çocuğunuzun bireysel öğrenme stilini keşfedin.';
  }

  String _getChildSocialStyle(ZodiacSign sign) {
    final styles = {
      ZodiacSign.aries:
          'Lider rolünü üstlenir. Rekabetçi oyunları sever. Sabır öğretilmeli.',
      ZodiacSign.taurus:
          'Az ama yakın arkadaşlıklar kurar. Paylaşmayı öğrenmeye ihtiyacı var.',
      ZodiacSign.gemini:
          'Sosyal kelebek. Çok arkadaş edinir ama yüzeysel kalabilir.',
      ZodiacSign.cancer:
          'Seçici arkadaşlıklar. Güvene ihtiyacı var. Evde oynamayı sever.',
      ZodiacSign.leo:
          'Popüler ve karizmatik. Dikkat çekmek ister. Drama olabilir.',
      ZodiacSign.virgo:
          'Seçici ve yardımsever. Az arkadaşla derin bağlar kurar.',
      ZodiacSign.libra:
          'Uyumlu ve diplomatik. Çatışmalardan kaçınır. Adilce oynamayı öğretir.',
      ZodiacSign.scorpio:
          'Yoğun ve sadık arkadaşlıklar. Güven kazanmak zaman alır.',
      ZodiacSign.sagittarius:
          'Farklı gruplarla arkadaş olur. Maceracı ve eğlenceli.',
      ZodiacSign.capricorn:
          'Olgun arkadaşlıklar. Sorumlu rol üstlenir. Rahatlamasına yardımcı olun.',
      ZodiacSign.aquarius:
          'Alışılmadık arkadaşlıklar. Grup aktivitelerini sever. Bireyselliğe saygı.',
      ZodiacSign.pisces:
          'Empatik ve şefkatli. Sınırları öğretilmeli. Yalnız zamanına ihtiyacı var.',
    };
    return styles[sign] ?? 'Çocuğunuzun sosyal gelişimini destekleyin.';
  }

  String _getChildEmotionalNeeds(ZodiacSign sun, ZodiacSign? moon) {
    final moonSign = moon ?? sun;
    final needs = {
      ZodiacSign.aries:
          'Özgürlük ve bağımsızlık. Engellerle başa çıkmayı öğretmek.',
      ZodiacSign.taurus: 'Güvenlik ve istikrar. Fiziksel konfor ve rutin.',
      ZodiacSign.gemini:
          'Zihinsel uyarı ve iletişim. Dinlenildiğini hissetmek.',
      ZodiacSign.cancer: 'Duygusal güvenlik ve aile bağı. Kabul edilmek.',
      ZodiacSign.leo: 'Tanınma ve takdir. Özel hissetmek.',
      ZodiacSign.virgo:
          'Düzen ve yararlı olma hissi. Mükemmel olmak zorunda değil.',
      ZodiacSign.libra: 'Uyum ve adalet. Seçim yapabilme özgürlüğü.',
      ZodiacSign.scorpio: 'Güven ve duygusal dürüstlük. Gizlilik hakkı.',
      ZodiacSign.sagittarius: 'Özgürlük ve macera. İyimserliğin desteklenmesi.',
      ZodiacSign.capricorn: 'Başarı ve onay. Sorumluluk alanları.',
      ZodiacSign.aquarius: 'Kabul ve bireysellik. Farklı olma hakkı.',
      ZodiacSign.pisces: 'Koşulsuz sevgi ve anlayış. Hayal kurma özgürlüğü.',
    };
    return needs[moonSign] ?? 'Çocuğunuzun duygusal ihtiyaçlarını gözlemleyin.';
  }

  List<String> _getChildTalents(ZodiacSign sign) {
    final talents = {
      ZodiacSign.aries: ['Spor', 'Liderlik', 'Girişimcilik', 'Hızlı düşünme'],
      ZodiacSign.taurus: ['Müzik', 'Sanat', 'Bahçecilik', 'El işleri'],
      ZodiacSign.gemini: ['Yazma', 'Konuşma', 'Dil öğrenme', 'Çoklu görev'],
      ZodiacSign.cancer: ['Yemek yapma', 'Bakım verme', 'Tarih', 'Psikoloji'],
      ZodiacSign.leo: ['Tiyatro', 'Dans', 'Yaratıcı sanatlar', 'Organizasyon'],
      ZodiacSign.virgo: ['Analiz', 'El işleri', 'Sağlık', 'Düzenleme'],
      ZodiacSign.libra: ['Sanat', 'Diplomasi', 'Tasarım', 'Sosyal beceriler'],
      ZodiacSign.scorpio: ['Araştırma', 'Psikoloji', 'Strateji', 'Gözlem'],
      ZodiacSign.sagittarius: ['Spor', 'Felsefe', 'Seyahat', 'Öğretme'],
      ZodiacSign.capricorn: ['Organizasyon', 'Planlama', 'İş kurma', 'Müzik'],
      ZodiacSign.aquarius: ['Teknoloji', 'Bilim', 'Sosyal aktivizm', 'Yenilik'],
      ZodiacSign.pisces: ['Sanat', 'Müzik', 'Şiir', 'Şifa'],
    };
    return talents[sign] ?? ['Keşfedilecek yetenekler'];
  }

  List<String> _getChildChallenges(ZodiacSign sign) {
    final challenges = {
      ZodiacSign.aries: ['Sabırsızlık', 'Öfke kontrolü', 'Sıra bekleme'],
      ZodiacSign.taurus: ['Değişime direnç', 'İnatçılık', 'Paylaşma'],
      ZodiacSign.gemini: ['Konsantrasyon', 'Kararsızlık', 'Dinleme'],
      ZodiacSign.cancer: [
        'Aşırı hassasiyet',
        'Bağımlılık',
        'Ruh hali değişimleri',
      ],
      ZodiacSign.leo: ['Dikkat ihtiyacı', 'Kibir', 'Eleştiri alma'],
      ZodiacSign.virgo: ['Mükemmeliyetçilik', 'Endişe', 'Öz eleştiri'],
      ZodiacSign.libra: [
        'Karar verme',
        'Çatışmadan kaçınma',
        'İnsanları memnun etme',
      ],
      ZodiacSign.scorpio: ['Kıskançlık', 'Güven sorunları', 'Kontrol ihtiyacı'],
      ZodiacSign.sagittarius: ['Aşırı iyimserlik', 'Taahhüt', 'Dürtüsellik'],
      ZodiacSign.capricorn: [
        'Aşırı ciddiyet',
        'İş-oyun dengesi',
        'Duygusal ifade',
      ],
      ZodiacSign.aquarius: ['Duygusal mesafe', 'İsyankarlık', 'Uyum'],
      ZodiacSign.pisces: ['Sınırlar', 'Gerçekçilik', 'Kaçış eğilimi'],
    };
    return challenges[sign] ?? ['Bireysel zorluklar'];
  }

  String _getParentingTips(ZodiacSign sign) {
    final tips = {
      ZodiacSign.aries:
          'Fiziksel aktiviteye bolca alan tanıyın. Rekabetçi oyunlar oynayın ama '
          'kaybetmeyi de öğretin. Bağımsız kararlar almasına izin verin.',
      ZodiacSign.taurus:
          'Rutin oluşturun ve değişiklikleri yavaş yavaş tanıtın. '
          'Dokunsal deneyimler sunun. Sabrınızı koruyun, acele etmeyin.',
      ZodiacSign.gemini:
          'Çeşitli aktiviteler sunun ve merakını besleyin. '
          'Konuşmalarınızı ilgi çekici tutun. Odaklanma becerileri geliştirin.',
      ZodiacSign.cancer:
          'Güvenli ve sıcak bir ev ortamı yaratın. '
          'Duygularını ifade etmesine izin verin. Aile ritüelleri oluşturun.',
      ZodiacSign.leo:
          'Yaratıcılığını destekleyin ve başarılarını takdir edin. '
          'Sahne performansı fırsatları sunun. Alçakgönüllülük öğretin.',
      ZodiacSign.virgo:
          'Yapıcı geri bildirim verin, eleştirmekten kaçının. '
          'Düzen ihtiyacını anlayın. Mükemmel olmak zorunda olmadığını öğretin.',
      ZodiacSign.libra:
          'Karar verme pratiği yaptırın. Adil davranın ve tutarlı olun. '
          'Sosyal becerilerini destekleyin ama kendi sesini bulmasına yardımcı olun.',
      ZodiacSign.scorpio:
          'Güvenini kazanın ve gizliliğine saygı gösterin. '
          'Dürüst olun çünkü yalanı anlar. Duygusal güvenlik sağlayın.',
      ZodiacSign.sagittarius:
          'Özgürlük alanı tanıyın ve macera fırsatları sunun. '
          'Sorularını ciddiye alın. Sınırları nazikçe ama tutarlı bir şekilde koyun.',
      ZodiacSign.capricorn:
          'Sorumluluk verin ama aşırı yüklemeyin. Eğlenceyi teşvik edin. '
          'Başarılarını kutlayın ve çabasını takdir edin.',
      ZodiacSign.aquarius:
          'Farklılığını kutlayın ve bireyselliğine saygı gösterin. '
          'Mantıkla yaklaşın. Sosyal bilinç geliştirmesine yardımcı olun.',
      ZodiacSign.pisces:
          'Hayal gücünü destekleyin ama sınırlar da koyun. '
          'Duygusal ihtiyaçlarına duyarlı olun. Yapı ve yönlendirme sağlayın.',
    };
    return tips[sign] ?? 'Çocuğunuzu olduğu gibi kabul edin ve destekleyin.';
  }

  String _getChildDailyHoroscope(ZodiacSign sign, Random random) {
    final horoscopes = [
      'Bugün yeni şeyler öğrenmek için harika bir gün. Merak et ve sorular sor!',
      'Arkadaşlarınla güzel vakit geçirebilirsin. Paylaşmak seni mutlu edecek.',
      'Yaratıcılığın yüksek bugün. Resim yap, bir şeyler inşa et veya dans et!',
      'Bugün biraz sakin kalmak isteyebilirsin. Kitap okumak iyi gelebilir.',
      'Enerjin yüksek! Dışarıda oynamak veya spor yapmak için ideal bir gün.',
      'Ailenle güzel anılar biriktireceğin bir gün. Birlikte oyun oynayın.',
      'Yeni bir beceri öğrenmeye başlamak için güzel bir zamanlama.',
      'Duygularını ifade etmek bugün kolay olacak. Hissettiklerini paylaş.',
    ];

    return horoscopes[random.nextInt(horoscopes.length)];
  }

  /// Generate Family Horoscope
  FamilyHoroscope generateFamilyHoroscope(List<FamilyMember> members) {
    final random = Random(DateTime.now().millisecondsSinceEpoch);

    // Analyze family dynamics based on elements
    final elementCounts = <Element, int>{};
    for (final member in members) {
      final element = member.sunSign.element;
      elementCounts[element] = (elementCounts[element] ?? 0) + 1;
    }

    final dominantElement = elementCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return FamilyHoroscope(
      members: members,
      familyDynamics: _getFamilyDynamics(dominantElement, members),
      strengthsAsFamily: _getFamilyStrengths(dominantElement, members),
      challengesAsFamily: _getFamilyChallenges(elementCounts),
      communicationStyle: _getFamilyCommunicationStyle(members),
      familyAdvice: _getFamilyAdvice(dominantElement, random),
      date: DateTime.now(),
    );
  }

  String _getFamilyDynamics(Element dominant, List<FamilyMember> members) {
    final dynamics = {
      Element.fire:
          'Aileniz enerji, tutku ve heyecan dolu! Aktivite ve macera ailenizin '
          'bağ kurma yollarından biri. Rekabet olabilir ama coşkunuz bulaşıcı.',
      Element.earth:
          'Aileniz istikrar, güvenlik ve pratiklik üzerine kurulu. Gelenekler '
          'önemli ve maddi konfor aile mutluluğunun bir parçası.',
      Element.air:
          'Aileniz iletişim, fikir alışverişi ve sosyal aktiviteler üzerine odaklı. '
          'Konuşmalar ve tartışmalar aile bağınızı güçlendiriyor.',
      Element.water:
          'Aileniz derin duygusal bağlar ve sezgisel anlayışa sahip. '
          'Empati yüksek ve birbirinizin duygularını kolayca anlıyorsunuz.',
    };
    return dynamics[dominant] ?? 'Aileniz benzersiz bir dinamiğe sahip.';
  }

  List<String> _getFamilyStrengths(
    Element dominant,
    List<FamilyMember> members,
  ) {
    final strengths = {
      Element.fire: [
        'Enerji ve coşku',
        'Cesaret',
        'İlham vericilik',
        'Motivasyon',
      ],
      Element.earth: ['Güvenilirlik', 'Pratiklik', 'Sadakat', 'İstikrar'],
      Element.air: ['İletişim', 'Esneklik', 'Sosyallik', 'Yenilikçilik'],
      Element.water: ['Empati', 'Duygusal destek', 'Sezgi', 'Şefkat'],
    };
    return strengths[dominant] ?? ['Birlik', 'Sevgi'];
  }

  List<String> _getFamilyChallenges(Map<Element, int> elements) {
    final challenges = <String>[];

    if ((elements[Element.fire] ?? 0) > 2) {
      challenges.add('Öfke patlamaları ve sabırsızlık');
    }
    if ((elements[Element.earth] ?? 0) > 2) {
      challenges.add('Değişime direnç ve inatlaşma');
    }
    if ((elements[Element.air] ?? 0) > 2) {
      challenges.add('Duygusal yüzeysellik');
    }
    if ((elements[Element.water] ?? 0) > 2) {
      challenges.add('Aşırı duygusallık ve ruh hali değişimleri');
    }

    if (challenges.isEmpty) {
      challenges.add('Farklı ihtiyaçları dengelemek');
    }

    return challenges;
  }

  String _getFamilyCommunicationStyle(List<FamilyMember> members) {
    final airCount = members
        .where((m) => m.sunSign.element == Element.air)
        .length;
    final waterCount = members
        .where((m) => m.sunSign.element == Element.water)
        .length;

    if (airCount > members.length / 2) {
      return 'Aileniz sözlü iletişime önem veriyor. Konuşmalar ve tartışmalar doğal akıyor.';
    }
    if (waterCount > members.length / 2) {
      return 'Aileniz duygusal ve sezgisel iletişim kullanıyor. Sözlerden çok hislerle anlıyorsunuz.';
    }
    return 'Aileniz karma bir iletişim stili kullanıyor. Hem sözlü hem duygusal ifadeler önemli.';
  }

  String _getFamilyAdvice(Element dominant, Random random) {
    final advice = {
      Element.fire:
          'Bugün bir aile spor aktivitesi planlayın. Enerjinizi birlikte harcayın!',
      Element.earth:
          'Birlikte yemek yapmak veya bahçe işleri aile bağınızı güçlendirir.',
      Element.air:
          'Bir aile oyunu oynayın veya birlikte bir konu hakkında sohbet edin.',
      Element.water:
          'Duygusal paylaşım zamanı. Herkesin duygularını ifade etmesine izin verin.',
    };
    return advice[dominant] ?? 'Birlikte kaliteli zaman geçirin.';
  }
}
