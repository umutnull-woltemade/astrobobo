import 'dart:math';

import '../models/premium_astrology.dart';
import '../models/zodiac_sign.dart';

class PremiumAstrologyService {
  static final PremiumAstrologyService _instance =
      PremiumAstrologyService._internal();
  factory PremiumAstrologyService() => _instance;
  PremiumAstrologyService._internal();

  /// Generate AstroCartography data for a birth chart
  AstroCartographyData generateAstroCartography({
    required String userName,
    required DateTime birthDate,
    required double birthLatitude,
    required double birthLongitude,
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

    final planetaryLines = <PlanetaryLine>[];
    for (final planet in planets) {
      for (final lineType in LineType.values) {
        // Generate line coordinates across the globe
        final coordinates = <GeoPoint>[];
        for (int i = 0; i < 20; i++) {
          coordinates.add(
            GeoPoint(
              latitude: -90 + (i * 9.0) + random.nextDouble() * 5,
              longitude: random.nextDouble() * 360 - 180,
            ),
          );
        }
        coordinates.sort((a, b) => a.latitude.compareTo(b.latitude));

        planetaryLines.add(
          PlanetaryLine(
            planet: planet,
            lineType: lineType,
            coordinates: coordinates,
            meaning: _getPlanetaryLineMeaning(planet, lineType),
            advice: _getPlanetaryLineAdvice(planet, lineType),
            isPositive: _isPlanetaryLinePositive(planet, lineType),
          ),
        );
      }
    }

    final powerPlaces = _generatePowerPlaces(birthDate, random);

    return AstroCartographyData(
      userName: userName,
      birthDate: birthDate,
      birthLatitude: birthLatitude,
      birthLongitude: birthLongitude,
      planetaryLines: planetaryLines,
      powerPlaces: powerPlaces,
      overallAnalysis: _generateCartographyAnalysis(userName, birthDate),
    );
  }

  String _getPlanetaryLineMeaning(String planet, LineType lineType) {
    final meanings = {
      'Güneş': {
        LineType.ascendant:
            'Kişisel güç ve kimlik burada en yoğun. Liderlik potansiyeliniz parlar.',
        LineType.descendant:
            'İlişkilerde güneş gibi parlarsınız. Ortaklıklar size enerji verir.',
        LineType.midheaven:
            'Kariyer ve toplumsal statü için güçlü bir konum. Tanınırlık potansiyeli.',
        LineType.imumCoeli:
            'Aileniz ve köklerinizle derin bağ. Ev ve yuva konularında bereket.',
      },
      'Ay': {
        LineType.ascendant:
            'Duygusal hassasiyet artar. Sezgisel yetenekleriniz güçlenir.',
        LineType.descendant:
            'İlişkilerde duygusal derinlik. Empatik bağlar kurulur.',
        LineType.midheaven:
            'Toplum tarafından duygusal olarak kabul görürsünüz. Şifa meslekleri için ideal.',
        LineType.imumCoeli:
            'Ev ortamında huzur bulursunuz. Aile bağları güçlüdür.',
      },
      'Merkür': {
        LineType.ascendant:
            'İletişim becerileri zirve yapar. Öğrenme ve öğretme için ideal.',
        LineType.descendant: 'İş ortaklıkları ve müzakereler için güçlü konum.',
        LineType.midheaven: 'Yazarlık, medya ve eğitim kariyeri için mükemmel.',
        LineType.imumCoeli:
            'Ev ofis çalışması için ideal. Ailede iletişim güçlü.',
      },
      'Venüs': {
        LineType.ascendant:
            'Çekicilik ve cazibe artar. Sanat ve güzellik alanında başarı.',
        LineType.descendant:
            'Romantik ilişkiler için muhteşem konum. Aşk burada çiçek açar.',
        LineType.midheaven:
            'Sanat, moda ve güzellik sektörlerinde kariyer fırsatları.',
        LineType.imumCoeli: 'Güzel ve huzurlu bir ev ortamı. Aile içi uyum.',
      },
      'Mars': {
        LineType.ascendant:
            'Fiziksel enerji ve motivasyon zirve yapar. Spor başarıları.',
        LineType.descendant:
            'İlişkilerde tutku ama dikkatli olun, çatışma potansiyeli.',
        LineType.midheaven:
            'Rekabetçi iş ortamlarında başarı. Liderlik rolleri.',
        LineType.imumCoeli:
            'Ev ortamında hareketlilik. Ev tadilatı veya inşaat işleri.',
      },
      'Jüpiter': {
        LineType.ascendant:
            'Şans ve bereket sizi takip eder. Büyüme fırsatları.',
        LineType.descendant:
            'İş ortaklıkları genişler. Yabancılarla bağlantılar.',
        LineType.midheaven: 'Kariyer zirve yapar. Uluslararası fırsatlar.',
        LineType.imumCoeli: 'Geniş aile. Miras ve mülk konularında bereket.',
      },
      'Satürn': {
        LineType.ascendant:
            'Disiplin ve olgunluk gerektirir. Zorluklar büyüme getirir.',
        LineType.descendant: 'İlişkilerde ciddiyet. Uzun vadeli bağlılıklar.',
        LineType.midheaven:
            'Kariyer zaman alır ama kalıcı başarı. Otorite pozisyonları.',
        LineType.imumCoeli: 'Aile sorumlulukları. Geleneklerle yüzleşme.',
      },
    };

    return meanings[planet]?[lineType] ??
        'Bu konum sizin için özel anlamlar taşır.';
  }

  String _getPlanetaryLineAdvice(String planet, LineType lineType) {
    final advice = {
      'Güneş': {
        LineType.ascendant:
            'Bu bölgede kendinizi ifade edin ve liderlik rollerini üstlenin.',
        LineType.descendant: 'İş ortaklıkları için bu bölgeleri değerlendirin.',
        LineType.midheaven:
            'Kariyer atılımları için bu bölgelerde fırsatları takip edin.',
        LineType.imumCoeli: 'Emeklilik veya aile yuvası kurmak için düşünün.',
      },
      'Ay': {
        LineType.ascendant: 'Duygusal şifa için bu bölgeleri ziyaret edin.',
        LineType.descendant: 'Ruh eşinizi bu bölgelerde bulabilirsiniz.',
        LineType.midheaven:
            'Terapi veya şifa meslekleri için bu bölgeler idealdir.',
        LineType.imumCoeli:
            'Aile kökleriyle bağlantı kurmak için bu yerleri ziyaret edin.',
      },
      'Venüs': {
        LineType.ascendant:
            'Kişisel stil ve güzellik işleri için bu bölgeler mükemmel.',
        LineType.descendant: 'Romantik tatiller ve balayı için ideal yerler.',
        LineType.midheaven: 'Sanat galerisi açmak veya moda işi için düşünün.',
        LineType.imumCoeli:
            'Güzel bir ev dekorasyonu bu bölgelerde ilham verir.',
      },
      'Jüpiter': {
        LineType.ascendant:
            'Yeni başlangıçlar için şanslı bölgeler. Risk alın!',
        LineType.descendant: 'Uluslararası iş ortaklıkları kurun.',
        LineType.midheaven: 'Global kariyer fırsatlarını değerlendirin.',
        LineType.imumCoeli: 'Mülk yatırımları için değerlendirin.',
      },
    };

    return advice[planet]?[lineType] ??
        'Bu enerjiyi bilinçli olarak kullanın ve fırsatları değerlendirin.';
  }

  bool _isPlanetaryLinePositive(String planet, LineType lineType) {
    final positives = ['Güneş', 'Venüs', 'Jüpiter'];
    final challenging = ['Satürn', 'Mars'];

    if (positives.contains(planet)) return true;
    if (challenging.contains(planet)) {
      return lineType == LineType.midheaven; // Career focus is positive
    }
    return true;
  }

  List<PowerPlace> _generatePowerPlaces(DateTime birthDate, Random random) {
    final cities = [
      {
        'name': 'İstanbul',
        'country': 'Türkiye',
        'lat': 41.0082,
        'lng': 28.9784,
      },
      {'name': 'Paris', 'country': 'Fransa', 'lat': 48.8566, 'lng': 2.3522},
      {
        'name': 'Londra',
        'country': 'İngiltere',
        'lat': 51.5074,
        'lng': -0.1278,
      },
      {'name': 'New York', 'country': 'ABD', 'lat': 40.7128, 'lng': -74.0060},
      {'name': 'Tokyo', 'country': 'Japonya', 'lat': 35.6762, 'lng': 139.6503},
      {'name': 'Dubai', 'country': 'BAE', 'lat': 25.2048, 'lng': 55.2708},
      {
        'name': 'Barselona',
        'country': 'İspanya',
        'lat': 41.3851,
        'lng': 2.1734,
      },
      {'name': 'Roma', 'country': 'İtalya', 'lat': 41.9028, 'lng': 12.4964},
      {
        'name': 'Amsterdam',
        'country': 'Hollanda',
        'lat': 52.3676,
        'lng': 4.9041,
      },
      {
        'name': 'Sidney',
        'country': 'Avustralya',
        'lat': -33.8688,
        'lng': 151.2093,
      },
    ];

    final energyTypes = [
      'Kariyer ve Başarı',
      'Aşk ve Romantizm',
      'Spiritüel Gelişim',
      'Finansal Bereket',
      'Yaratıcı İlham',
      'Sağlık ve Şifa',
    ];

    final planets = [
      'Güneş',
      'Ay',
      'Venüs',
      'Mars',
      'Jüpiter',
      'Satürn',
      'Merkür',
    ];

    return cities.map((city) {
      final activePlanets = <String>[];
      for (int i = 0; i < 2 + random.nextInt(3); i++) {
        final planet = planets[random.nextInt(planets.length)];
        if (!activePlanets.contains(planet)) {
          activePlanets.add(planet);
        }
      }

      final energyType = energyTypes[random.nextInt(energyTypes.length)];

      return PowerPlace(
        name: city['name'] as String,
        country: city['country'] as String,
        latitude: city['lat'] as double,
        longitude: city['lng'] as double,
        activePlanets: activePlanets,
        energyType: energyType,
        description: _getPowerPlaceDescription(
          city['name'] as String,
          energyType,
          activePlanets,
        ),
        powerRating: 3 + random.nextInt(3),
      );
    }).toList();
  }

  String _getPowerPlaceDescription(
    String city,
    String energyType,
    List<String> planets,
  ) {
    return '$city, sizin için $energyType enerjisi taşıyor. '
        '${planets.join(", ")} gezegenleri burada güçleniyor. '
        'Bu şehri ziyaret etmek veya burada zaman geçirmek, '
        'bu alanlarda büyük fırsatlar sunabilir.';
  }

  String _generateCartographyAnalysis(String userName, DateTime birthDate) {
    return '''$userName, AstroCartography haritanız dünya üzerindeki enerji noktalarınızı gösteriyor.

Her gezegen çizgisi, o gezegenin enerjisinin sizin için en güçlü olduğu yerleri işaret eder. Yükselen (AC) çizgileri kişisel güç ve kimlik, Alçalan (DC) çizgileri ilişkiler, Gökyüzü Ortası (MC) çizgileri kariyer ve Göğün Dibi (IC) çizgileri ev ve aile konularını etkiler.

Güç noktalarınız, birden fazla olumlu gezegen enerjisinin kesiştiği yerlerdir. Bu şehirler sizin için özel fırsatlar barındırır.

Tavsiye: Seyahat planlarınızı yaparken veya taşınma düşünürken bu haritayı referans alın. Bazı yerler kariyer için idealken, bazıları aşk veya spiritüel gelişim için daha uygun olabilir.''';
  }

  /// Generate Electional Chart for finding auspicious times
  ElectionalChart generateElectionalChart({
    required ElectionalPurpose purpose,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final random = Random(startDate.millisecondsSinceEpoch + purpose.index);
    final favorableWindows = <ElectionalWindow>[];
    final unfavorableWindows = <ElectionalWindow>[];

    // Generate windows throughout the date range
    var currentDate = startDate;
    while (currentDate.isBefore(endDate)) {
      final isFavorable = random.nextDouble() > 0.4;
      final duration = Duration(hours: 2 + random.nextInt(6));

      final window = ElectionalWindow(
        start: currentDate,
        end: currentDate.add(duration),
        description: isFavorable
            ? _getFavorableDescription(purpose, random)
            : _getUnfavorableDescription(purpose, random),
        supportingAspects: _getAspects(purpose, isFavorable, random),
        score: isFavorable ? 60 + random.nextInt(40) : 20 + random.nextInt(40),
      );

      if (isFavorable) {
        favorableWindows.add(window);
      } else {
        unfavorableWindows.add(window);
      }

      currentDate = currentDate.add(Duration(hours: 8 + random.nextInt(16)));
    }

    // Sort by score
    favorableWindows.sort((a, b) => b.score.compareTo(a.score));

    return ElectionalChart(
      purpose: purpose.nameTr,
      selectedDate: startDate,
      favorableWindows: favorableWindows.take(10).toList(),
      unfavorableWindows: unfavorableWindows.take(5).toList(),
      moonPhaseAdvice: _getMoonPhaseAdvice(purpose, startDate),
      retrogradeWarning: _getRetrogradeWarning(startDate),
      overallRecommendation: _getOverallRecommendation(
        purpose,
        favorableWindows,
      ),
      optimalScore: favorableWindows.isNotEmpty
          ? favorableWindows.first.score
          : 50,
    );
  }

  String _getFavorableDescription(ElectionalPurpose purpose, Random random) {
    final descriptions = {
      ElectionalPurpose.wedding: [
        'Venüs-Jüpiter üçgeni evlilik için muhteşem',
        'Ay yükselen burçta, duygusal uyum güçlü',
        'Güneş 7. evde, ortaklıklar destekleniyor',
      ],
      ElectionalPurpose.businessStart: [
        'Merkür güçlü konumda, iletişim ve sözleşmeler için ideal',
        'Jüpiter 10. evde, iş başarısı için mükemmel',
        'Mars enerji veriyor, girişimcilik destekleniyor',
      ],
      ElectionalPurpose.travel: [
        'Merkür-Jüpiter olumlu açıda, seyahat için güvenli',
        '9. ev aktif, uzak yolculuklar için ideal',
        'Ay sabit burçta, plan değişikliği olmaz',
      ],
      ElectionalPurpose.investment: [
        '2. ev ve 8. ev uyumlu, finansal kazançlar',
        'Jüpiter-Pluto güçlü açıda, büyük yatırımlar için',
        'Venüs 2. evde, maddi bereket potansiyeli',
      ],
    };

    final purposeDescs =
        descriptions[purpose] ??
        ['Genel olarak olumlu koşullar mevcut', 'Gezegen enerjileri uyumlu'];

    return purposeDescs[random.nextInt(purposeDescs.length)];
  }

  String _getUnfavorableDescription(ElectionalPurpose purpose, Random random) {
    final descriptions = [
      'Ay boşlukta - önemli kararlar ertelenmeli',
      'Merkür retrosu etkili - sözleşmeler için riskli',
      'Mars-Satürn karesi - engellerle karşılaşılabilir',
      'Ay azalan fazda - yeni başlangıçlar için uygun değil',
      'Venüs zayıf konumda - ilişki konuları için dikkatli olun',
    ];

    return descriptions[random.nextInt(descriptions.length)];
  }

  List<String> _getAspects(
    ElectionalPurpose purpose,
    bool isFavorable,
    Random random,
  ) {
    final favorable = [
      'Venüs üçgen Jüpiter',
      'Ay altıgen Güneş',
      'Merkür üçgen Uranüs',
      'Güneş kavuşum Jüpiter',
      'Venüs altıgen Mars',
    ];

    final unfavorable = [
      'Mars kare Satürn',
      'Ay karşıt Pluto',
      'Merkür kare Neptün',
      'Güneş karşıt Satürn',
    ];

    final source = isFavorable ? favorable : unfavorable;
    final count = 2 + random.nextInt(3);
    final result = <String>[];

    for (int i = 0; i < count; i++) {
      final aspect = source[random.nextInt(source.length)];
      if (!result.contains(aspect)) {
        result.add(aspect);
      }
    }

    return result;
  }

  String _getMoonPhaseAdvice(ElectionalPurpose purpose, DateTime date) {
    final dayOfMonth = date.day;

    if (dayOfMonth <= 7) {
      return 'Yeni Ay dönemi: Yeni başlangıçlar için mükemmel. '
          '${purpose.nameTr} için tohum ekme zamanı.';
    } else if (dayOfMonth <= 15) {
      return 'Büyüyen Ay: Projeler momentum kazanır. '
          '${purpose.nameTr} için aksiyona geçme zamanı.';
    } else if (dayOfMonth <= 22) {
      return 'Dolunay dönemi: Sonuçlar netleşir. '
          'Başlamış projeleri tamamlamak için ideal.';
    } else {
      return 'Azalan Ay: Planlama ve değerlendirme zamanı. '
          'Yeni ${purpose.nameTr} için bir sonraki yeni ayı bekleyin.';
    }
  }

  String _getRetrogradeWarning(DateTime date) {
    // Simplified retrograde check based on month
    final month = date.month;

    if (month == 1 || month == 5 || month == 9) {
      return '⚠️ Merkür retrosu dönemine dikkat! Sözleşmeleri iki kez kontrol edin, '
          'iletişim aksaklıklarına hazırlıklı olun.';
    } else if (month == 7 || month == 12) {
      return '⚠️ Venüs retrosu: İlişki kararları için dikkatli olun. '
          'Eski bağlantılar gündeme gelebilir.';
    }

    return '✓ Şu anda önemli bir retro dönemi yok. Planlanan aktiviteler için uygun.';
  }

  String _getOverallRecommendation(
    ElectionalPurpose purpose,
    List<ElectionalWindow> windows,
  ) {
    if (windows.isEmpty) {
      return 'Seçilen tarih aralığında uygun zaman penceresi bulunamadı. '
          'Farklı tarihler denemeyi düşünün.';
    }

    final best = windows.first;
    final dateStr = '${best.start.day}/${best.start.month}/${best.start.year}';
    final timeStr =
        '${best.start.hour.toString().padLeft(2, '0')}:${best.start.minute.toString().padLeft(2, '0')}';

    return '${purpose.nameTr} için en uygun zaman: $dateStr saat $timeStr. '
        'Bu zaman diliminde gezegen enerjileri sizin lehinize çalışıyor. '
        'Skor: ${best.score}/100. '
        '${best.description}';
  }

  /// Generate Draconic Chart for soul-level astrology
  DraconicChart generateDraconicChart({
    required DateTime birthDate,
    required ZodiacSign natalSun,
    required ZodiacSign natalMoon,
    required ZodiacSign natalAscendant,
  }) {
    final random = Random(birthDate.millisecondsSinceEpoch);

    // Draconic chart uses North Node at 0° Aries as reference
    // This shifts all positions by the natal North Node position
    final nodeOffset = random.nextInt(12);

    final draconicSun = ZodiacSign.values[(natalSun.index + nodeOffset) % 12];
    final draconicMoon = ZodiacSign.values[(natalMoon.index + nodeOffset) % 12];
    final draconicAscendant =
        ZodiacSign.values[(natalAscendant.index + nodeOffset) % 12];

    final planets = _generateDraconicPlanets(birthDate, nodeOffset, random);

    return DraconicChart(
      birthDate: birthDate,
      draconicSun: draconicSun,
      draconicMoon: draconicMoon,
      draconicAscendant: draconicAscendant,
      planets: planets,
      soulPurpose: _getSoulPurpose(draconicSun),
      karmicLessons: _getKarmicLessons(draconicMoon, draconicAscendant),
      spiritualGifts: _getSpiritualGifts(planets),
      pastLifeIndicators: _getPastLifeIndicators(draconicSun, draconicMoon),
      evolutionaryPath: _getEvolutionaryPath(draconicAscendant),
    );
  }

  List<DraconicPlanet> _generateDraconicPlanets(
    DateTime birthDate,
    int offset,
    Random random,
  ) {
    final planetNames = [
      'Güneş',
      'Ay',
      'Merkür',
      'Venüs',
      'Mars',
      'Jüpiter',
      'Satürn',
      'Uranüs',
      'Neptün',
      'Pluto',
    ];

    return planetNames.map((name) {
      final signIndex = (random.nextInt(12) + offset) % 12;
      final sign = ZodiacSign.values[signIndex];
      final house = 1 + random.nextInt(12);
      final degree = random.nextDouble() * 30;

      return DraconicPlanet(
        planet: name,
        sign: sign,
        degree: degree,
        house: house,
        interpretation: _getDraconicPlanetInterpretation(name, sign, house),
      );
    }).toList();
  }

  String _getDraconicPlanetInterpretation(
    String planet,
    ZodiacSign sign,
    int house,
  ) {
    final interpretations = {
      'Güneş':
          'Ruhunuzun özü ${sign.nameTr} enerjisi taşıyor. $house. ev konumu, '
          'yaşam amacınızın bu alanla derinden bağlantılı olduğunu gösterir.',
      'Ay':
          'Ruhsal duygusal doğanız ${sign.nameTr} kalitelerini yansıtıyor. '
          '$house. evde, geçmiş yaşam duygusal kalıplarınız bu alanda açığa çıkıyor.',
      'Venüs':
          'Ruhsal sevgi diliniz ${sign.nameTr} üzerinden ifade buluyor. '
          '$house. ev, karmik ilişki temalarınızı işaret ediyor.',
      'Mars':
          'Ruhsal irade gücünüz ${sign.nameTr} enerjisiyle besleniyor. '
          '$house. evde, geçmiş yaşam mücadelelerinizin izleri var.',
      'Jüpiter':
          'Ruhsal bilgeliğiniz ${sign.nameTr} felsefesini taşıyor. '
          '$house. ev, spiritüel büyüme alanınızı gösteriyor.',
    };

    return interpretations[planet] ??
        '${sign.nameTr} burcundaki $planet, ruhsal yolculuğunuzun önemli bir parçası. '
            '$house. ev konumu, bu enerjinin yaşamınızda nasıl aktif olduğunu gösterir.';
  }

  String _getSoulPurpose(ZodiacSign draconicSun) {
    final purposes = {
      ZodiacSign.aries:
          'Ruhunuz cesaret ve öncülük için buraya geldi. Yeni yollar açmak ve '
          'başkalarına ilham vermek sizin kutsal göreviniz.',
      ZodiacSign.taurus:
          'Ruhunuz değer ve istikrar yaratmak için enkarne oldu. '
          'Güzellik ve bolluk manifestasyonu sizin spiritüel hediyeniz.',
      ZodiacSign.gemini:
          'Ruhunuz iletişim köprüleri kurmak için burada. '
          'Bilgiyi yaymak ve bağlantılar oluşturmak kutsal amacınız.',
      ZodiacSign.cancer:
          'Ruhunuz şifa ve koruma için geldi. Başkalarını beslemek ve '
          'güvenli alanlar yaratmak sizin spiritüel misyonunuz.',
      ZodiacSign.leo:
          'Ruhunuz yaratıcı ifade ve liderlik için enkarne oldu. '
          'Işığınızla başkalarını aydınlatmak kutsal hediyeniz.',
      ZodiacSign.virgo:
          'Ruhunuz hizmet ve iyileştirme için burada. Mükemmelliği arayış ve '
          'başkalarına yardım etmek spiritüel amacınız.',
      ZodiacSign.libra:
          'Ruhunuz denge ve uyum yaratmak için geldi. İlişkilerde barış ve '
          'adalet getirmek kutsal göreviniz.',
      ZodiacSign.scorpio:
          'Ruhunuz dönüşüm ve şifa için enkarne oldu. Derin hakikatleri '
          'ortaya çıkarmak ve başkalarını dönüştürmek misyonunuz.',
      ZodiacSign.sagittarius:
          'Ruhunuz bilgelik arayışı ve öğretme için burada. '
          'Yüksek gerçekleri paylaşmak spiritüel hediyeniz.',
      ZodiacSign.capricorn:
          'Ruhunuz kalıcı yapılar kurmak için geldi. '
          'Topluma katkı sağlayan başarılar kutsal amacınız.',
      ZodiacSign.aquarius:
          'Ruhunuz insanlığa hizmet ve yenilik için enkarne oldu. '
          'Geleceği şekillendirmek spiritüel misyonunuz.',
      ZodiacSign.pisces:
          'Ruhunuz evrensel şefkat ve spiritüel birlik için burada. '
          'Sınırları aşan sevgi yaymak kutsal hediyeniz.',
    };

    return purposes[draconicSun] ??
        'Ruhunuz benzersiz bir amaçla bu dünyaya geldi.';
  }

  String _getKarmicLessons(ZodiacSign moon, ZodiacSign ascendant) {
    return '''Drakonik Ay'ınız ${moon.nameTr} burcunda, duygusal karmik kalıplarınızı gösteriyor.
Geçmiş yaşamlardan getirdiğiniz duygusal tepkiler ve bağlanma biçimleri bu burç üzerinden ifade buluyor.

Drakonik Yükseleniz ${ascendant.nameTr}, bu yaşamda geliştirmeniz gereken ruhsal nitelikleri işaret ediyor.
Bu enerjiyi benimsemek, ruhsal evrriminiz için kritik önem taşıyor.

Karmik dersleriniz:
1. ${moon.element.nameTr} elementinin duygusal dengesi
2. ${ascendant.modality.nameTr} modalitesinin yaşam yaklaşımı
3. ${moon.nameTr} ve ${ascendant.nameTr} enerjilerinin entegrasyonu''';
  }

  String _getSpiritualGifts(List<DraconicPlanet> planets) {
    final gifts = <String>[];

    for (final planet in planets.take(5)) {
      if (planet.house == 9 || planet.house == 12) {
        gifts.add('${planet.planet} ${planet.sign.nameTr} - Spiritüel sezgi');
      }
      if (planet.house == 5 || planet.house == 1) {
        gifts.add('${planet.planet} ${planet.sign.nameTr} - Yaratıcı güç');
      }
    }

    if (gifts.isEmpty) {
      gifts.add('Evrensel şifa enerjisi');
      gifts.add('Empati ve anlayış');
    }

    return 'Spiritüel hediyeleriniz:\n\n${gifts.map((g) => '• $g').join('\n')}\n\n'
        'Bu yetenekler geçmiş yaşamlardan taşıdığınız bilgeliği temsil eder.';
  }

  String _getPastLifeIndicators(ZodiacSign sun, ZodiacSign moon) {
    return '''Drakonik haritanız, ruhunuzun geçmiş yaşam deneyimlerine dair ipuçları taşıyor.

${sun.nameTr} Güneşi: Geçmiş yaşamlarda liderlik veya yaratıcı ifade rolleri üstlenmiş olabilirsiniz.
${sun.element.nameTr} elementi bu yaşamların genel tonunu gösteriyor.

${moon.nameTr} Ay'ı: Duygusal kalıplarınız ${moon.element.nameTr} elementi yaşamlarından geliyor.
Aile ve ilişki dinamikleriniz bu geçmişle şekillendi.

Güçlü göstergeler:
• ${sun.rulingPlanet} enerjisiyle bağlantılı yaşamlar
• ${moon.modality.nameTr} modalitesi dönemlerinde önemli gelişmeler
• Ruhsal evrim ${sun.nameTr}-${moon.nameTr} ekseni üzerinden sürmüş''';
  }

  String _getEvolutionaryPath(ZodiacSign ascendant) {
    return '''Drakonik Yükseleniz ${ascendant.nameTr}, bu yaşamdaki evrimsel yönünüzü gösteriyor.

Ruhunuz ${ascendant.element.nameTr} elementi üzerinden deneyim kazanmak istiyor.
${ascendant.modality.nameTr} modalitesi, bu yolculuktaki yaklaşımınızı belirliyor.

Evrimsel hedefler:
1. ${ascendant.traits.take(2).join(' ve ')} niteliklerini geliştirmek
2. ${ascendant.rulingPlanet} gezegeninin derslerini öğrenmek
3. ${ascendant.nameTr} arketipini bilinçli olarak yaşamak

Bu yol kolay olmayabilir, ama ruhunuzun büyümesi için gerekli.
Her zorluk, daha yüksek bir bilinç seviyesine adımdır.''';
  }

  /// Generate Extended Asteroid Chart
  AsteroidChart generateAsteroidChart({
    required DateTime birthDate,
    required ZodiacSign sunSign,
  }) {
    final random = Random(birthDate.millisecondsSinceEpoch);

    final asteroids = Asteroid.values.map((asteroid) {
      final signIndex = (sunSign.index + random.nextInt(6) - 3 + 12) % 12;
      final sign = ZodiacSign.values[signIndex];
      final house = 1 + random.nextInt(12);
      final degree = random.nextDouble() * 30;

      final aspects = <String>[];
      if (random.nextBool()) aspects.add('Güneş ile üçgen');
      if (random.nextBool()) aspects.add('Ay ile altıgen');
      if (random.nextBool()) aspects.add('Venüs ile kavuşum');

      return AsteroidPosition(
        asteroid: asteroid,
        sign: sign,
        degree: degree,
        house: house,
        aspects: aspects,
        interpretation: _getAsteroidInterpretation(asteroid, sign, house),
      );
    }).toList();

    final chironPos = asteroids.firstWhere(
      (a) => a.asteroid == Asteroid.chiron,
    );
    final ceresPos = asteroids.firstWhere((a) => a.asteroid == Asteroid.ceres);
    final pallasPos = asteroids.firstWhere(
      (a) => a.asteroid == Asteroid.pallas,
    );
    final junoPos = asteroids.firstWhere((a) => a.asteroid == Asteroid.juno);
    final vestaPos = asteroids.firstWhere((a) => a.asteroid == Asteroid.vesta);

    return AsteroidChart(
      birthDate: birthDate,
      asteroids: asteroids,
      chiron: _getChironAnalysis(chironPos),
      ceres: _getCeresAnalysis(ceresPos),
      pallas: _getPallasAnalysis(pallasPos),
      juno: _getJunoAnalysis(junoPos),
      vesta: _getVestaAnalysis(vestaPos),
      overallAnalysis: _getOverallAsteroidAnalysis(asteroids),
    );
  }

  String _getAsteroidInterpretation(
    Asteroid asteroid,
    ZodiacSign sign,
    int house,
  ) {
    return '${asteroid.nameTr} ${sign.nameTr} burcunda, $house. evde. '
        '${asteroid.theme} Bu konum, ${sign.element.nameTr} elementi üzerinden '
        'ifade buluyor ve $house. ev konularında özellikle aktif.';
  }

  String _getChironAnalysis(AsteroidPosition pos) {
    return '''Kiron - Yaralı Şifacı

${pos.sign.nameTr} burcunda, ${pos.house}. evde.

Kiron'unuz derin yaranızı ve şifa potansiyelinizi gösteriyor. ${pos.sign.nameTr} enerjisi, yaranın doğasını belirliyor - ${pos.sign.element.nameTr} elementi üzerinden deneyimlenen acılar.

${pos.house}. ev konumu, bu yaranın hayatınızın hangi alanında en çok hissedildiğini gösterir. Ancak aynı zamanda, başkalarına şifa getirme kapasitenizin de bu alanda yoğunlaştığı anlamına gelir.

Şifa yolculuğunuz, yaranızı kabullenmek ve bu deneyimi bilgeliğe dönüştürmekle başlar. Kiron'unuz ne kadar güçlüyse, şifacılık potansiyeliniz de o kadar büyüktür.''';
  }

  String _getCeresAnalysis(AsteroidPosition pos) {
    return '''Ceres - Besleme ve Bakım

${pos.sign.nameTr} burcunda, ${pos.house}. evde.

Ceres'iniz nasıl beslendiğinizi ve nasıl beslediğinizi gösterir. ${pos.sign.nameTr} enerjisi, bakım stilinizi belirler - ${pos.sign.modality.nameTr} bir yaklaşımla sevginizi ifade edersiniz.

${pos.house}. ev konumu, bakım ihtiyaçlarınızın ve verme kapasitenizin odaklandığı yaşam alanını gösterir. Annelik arketipi bu evde en güçlü şekilde hissedilir.

Ceres aynı zamanda kayıp ve geri dönüş döngülerini de temsil eder. Bu konumdaki deneyimleriniz, bırakma ve tekrar kabullenme derslerini içerir.''';
  }

  String _getPallasAnalysis(AsteroidPosition pos) {
    return '''Pallas Athena - Bilgelik ve Strateji

${pos.sign.nameTr} burcunda, ${pos.house}. evde.

Pallas'ınız yaratıcı zekanızı ve stratejik düşünme kapasitenizi gösterir. ${pos.sign.nameTr} enerjisi, problem çözme stilinizi belirler - ${pos.sign.element.nameTr} elementi üzerinden çözümler üretirsiniz.

${pos.house}. ev konumu, zeka ve bilgeliğinizin en çok parladığı alanı gösterir. Politik becerileriniz ve örüntü tanıma yeteneğiniz bu evde yoğunlaşır.

Pallas aynı zamanda baba-kız dinamiğini ve kadınsı bilgeliği temsil eder. Bu konum, otoriteyle ilişkiniz hakkında da ipuçları verir.''';
  }

  String _getJunoAnalysis(AsteroidPosition pos) {
    return '''Juno - Evlilik ve Bağlılık

${pos.sign.nameTr} burcunda, ${pos.house}. evde.

Juno'nuz ideal eş konseptinizi ve bağlılık biçiminizi gösterir. ${pos.sign.nameTr} enerjisi, evlilikte ne aradığınızı belirler - ${pos.sign.modality.nameTr} bir partner dinamiği tercih edersiniz.

${pos.house}. ev konumu, eş bulma ve evlilik konularının hayatınızın hangi alanıyla bağlantılı olduğunu gösterir. Sadakat ve güven temaları bu evde odaklanır.

Juno güçlü veya zorlu açılarda, ilişkilerde güç dengeleri ve eşitlik mücadeleleri gündeme gelebilir. Sağlıklı ortaklıklar için bu enerjinin bilinçli çalışılması önerilir.''';
  }

  String _getVestaAnalysis(AsteroidPosition pos) {
    return '''Vesta - Kutsal Alev ve Adanmışlık

${pos.sign.nameTr} burcunda, ${pos.house}. evde.

Vesta'nız neye adadığınızı ve kutsal ateşinizin nerede yandığını gösterir. ${pos.sign.nameTr} enerjisi, adanmışlık stilinizi belirler - ${pos.sign.element.nameTr} elementi üzerinden hizmet verirsiniz.

${pos.house}. ev konumu, en derin odaklanma ve kendini adama alanınızı gösterir. Burada cinsellik ve maneviyat iç içe geçebilir.

Vesta aynı zamanda yalnızlık ihtiyacını ve kendi içinize çekilme dönemlerini temsil eder. Bu konum, spiritüel pratikleriniz ve ritüelleriniz hakkında bilgi verir.''';
  }

  String _getOverallAsteroidAnalysis(List<AsteroidPosition> asteroids) {
    final elements = <Element, int>{};
    for (final pos in asteroids) {
      elements[pos.sign.element] = (elements[pos.sign.element] ?? 0) + 1;
    }

    final dominantElement = elements.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return '''Asteroid Haritası Genel Analizi

Asteroidleriniz, ana gezegenlerin ötesinde kişiliğinizin daha ince katmanlarını ortaya koyar. Bu küçük gök cisimleri, arketipsel temaları ve ruhsal dersleri temsil eder.

Baskın element: ${dominantElement.nameTr}
Bu, asteroidlerinizin genel olarak ${dominantElement.nameTr} enerjisi üzerinden ifade bulduğunu gösterir. ${dominantElement.symbol} elementi, şifa, bakım, bilgelik ve adanmışlık temalarınızda belirleyicidir.

Kiron-Ceres ilişkisi, yaralanma ve iyileşme döngünüzü gösterir.
Pallas-Vesta ilişkisi, bilgelik ve adanmışlık arasındaki dengenizi yansıtır.
Juno'nun konumu, ideal partner dinamiklerinizi ve bağlılık kalıplarınızı açıklar.

Bu asteroidlerle çalışmak, kendinizi daha derinden anlamanıza ve spiritüel gelişiminizi hızlandırmanıza yardımcı olur.''';
  }
}
