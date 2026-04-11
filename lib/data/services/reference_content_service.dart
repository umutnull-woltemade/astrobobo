import '../models/reference_content.dart';
import '../models/zodiac_sign.dart';
import '../content/glossary_content.dart';

class ReferenceContentService {
  static final ReferenceContentService _instance =
      ReferenceContentService._internal();
  factory ReferenceContentService() => _instance;
  ReferenceContentService._internal();

  /// Get all glossary entries (300+ terms)
  List<GlossaryEntry> getGlossaryEntries() {
    return GlossaryContent.getAllEntries();
  }

  /// Get glossary entries count
  int get glossaryCount => GlossaryContent.totalCount;

  /// Search planet in house interpretations
  List<GlossaryEntry> searchPlanetInHouse(String query) {
    return GlossaryContent.searchPlanetInHouse(query);
  }

  /// Get entries by category
  List<GlossaryEntry> getEntriesByCategory(GlossaryCategory category) {
    return GlossaryContent.getByCategory(category);
  }

  /// Search glossary with improved algorithm
  List<GlossaryEntry> searchGlossary(String query) {
    if (query.trim().isEmpty) return getGlossaryEntries();

    final normalizedQuery = query.toLowerCase().trim();
    final entries = getGlossaryEntries();

    // Priority search: exact match, starts with, contains, related terms
    final exactMatches = <GlossaryEntry>[];
    final startsWithMatches = <GlossaryEntry>[];
    final containsMatches = <GlossaryEntry>[];
    final relatedMatches = <GlossaryEntry>[];

    for (final entry in entries) {
      final termLower = entry.term.toLowerCase();
      final termTrLower = entry.termTr.toLowerCase();
      final definitionLower = entry.definition.toLowerCase();
      final planetInHouse = entry.planetInHouse?.toLowerCase() ?? '';

      // Exact match
      if (termLower == normalizedQuery || termTrLower == normalizedQuery) {
        exactMatches.add(entry);
        continue;
      }

      // Starts with
      if (termLower.startsWith(normalizedQuery) ||
          termTrLower.startsWith(normalizedQuery)) {
        startsWithMatches.add(entry);
        continue;
      }

      // Contains in term, termTr, planetInHouse
      if (termLower.contains(normalizedQuery) ||
          termTrLower.contains(normalizedQuery) ||
          planetInHouse.contains(normalizedQuery)) {
        containsMatches.add(entry);
        continue;
      }

      // Contains in definition or deep explanation
      if (definitionLower.contains(normalizedQuery) ||
          (entry.deepExplanation?.toLowerCase().contains(normalizedQuery) ??
              false)) {
        relatedMatches.add(entry);
        continue;
      }

      // Related terms match
      if (entry.relatedTerms.any(
        (term) => term.toLowerCase().contains(normalizedQuery),
      )) {
        relatedMatches.add(entry);
      }
    }

    // Combine results in priority order
    return [
      ...exactMatches,
      ...startsWithMatches,
      ...containsMatches,
      ...relatedMatches,
    ];
  }

  /// Get gardening moon calendar for a month
  List<GardeningMoonDay> getGardeningCalendar(int year, int month) {
    final days = <GardeningMoonDay>[];
    final daysInMonth = DateTime(year, month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      days.add(_generateGardeningDay(date));
    }

    return days;
  }

  GardeningMoonDay _generateGardeningDay(DateTime date) {
    // Calculate approximate moon phase
    final phase = _getMoonPhase(date);
    final moonSign = ZodiacSign.values[(date.day + date.month) % 12];

    // Determine activities based on moon phase and sign
    final bestActivity = _getBestActivity(phase, moonSign);
    final goodActivities = _getGoodActivities(phase, moonSign);
    final avoidActivities = _getAvoidActivities(phase, moonSign);

    return GardeningMoonDay(
      date: date,
      phase: phase,
      moonSign: moonSign,
      bestActivity: bestActivity,
      goodActivities: goodActivities,
      avoidActivities: avoidActivities,
      advice: _getGardeningAdvice(phase, moonSign),
      fertilityRating: _getFertilityRating(moonSign, phase),
    );
  }

  MoonPhase _getMoonPhase(DateTime date) {
    // Simplified moon phase calculation
    final dayOfMonth = date.day;
    if (dayOfMonth <= 3) return MoonPhase.newMoon;
    if (dayOfMonth <= 7) return MoonPhase.waxingCrescent;
    if (dayOfMonth <= 10) return MoonPhase.firstQuarter;
    if (dayOfMonth <= 14) return MoonPhase.waxingGibbous;
    if (dayOfMonth <= 17) return MoonPhase.fullMoon;
    if (dayOfMonth <= 21) return MoonPhase.waningGibbous;
    if (dayOfMonth <= 25) return MoonPhase.lastQuarter;
    return MoonPhase.waningCrescent;
  }

  GardeningActivity _getBestActivity(MoonPhase phase, ZodiacSign sign) {
    if (phase.isWaxing) {
      if (sign.element == Element.water || sign.element == Element.earth) {
        return GardeningActivity.planting;
      }
      return GardeningActivity.seedStarting;
    } else {
      if (sign.element == Element.fire || sign.element == Element.air) {
        return GardeningActivity.pruning;
      }
      return GardeningActivity.harvesting;
    }
  }

  List<GardeningActivity> _getGoodActivities(MoonPhase phase, ZodiacSign sign) {
    final activities = <GardeningActivity>[];

    if (phase.isWaxing) {
      activities.add(GardeningActivity.transplanting);
      activities.add(GardeningActivity.fertilizing);
      activities.add(GardeningActivity.watering);
    } else {
      activities.add(GardeningActivity.weeding);
      activities.add(GardeningActivity.composting);
    }

    if (sign.element == Element.water) {
      activities.add(GardeningActivity.watering);
    }
    if (sign.element == Element.earth) {
      activities.add(GardeningActivity.transplanting);
    }

    return activities.toSet().toList();
  }

  List<GardeningActivity> _getAvoidActivities(
    MoonPhase phase,
    ZodiacSign sign,
  ) {
    final activities = <GardeningActivity>[];

    if (phase == MoonPhase.newMoon || phase == MoonPhase.fullMoon) {
      activities.add(GardeningActivity.planting);
      activities.add(GardeningActivity.transplanting);
    }

    if (sign.element == Element.fire) {
      activities.add(GardeningActivity.watering);
    }

    if (!phase.isWaxing) {
      activities.add(GardeningActivity.seedStarting);
    }

    return activities;
  }

  String _getGardeningAdvice(MoonPhase phase, ZodiacSign sign) {
    if (phase == MoonPhase.newMoon) {
      return 'Yeni Ay dönemi. Bahçe planlaması ve tohum hazırlığı için ideal. '
          'Dikim için birkaç gün bekleyin.';
    }
    if (phase == MoonPhase.fullMoon) {
      return 'Dolunay dönemi. Hasat için mükemmel zaman. '
          'Dikim yapmaktan kaçının, bitkileri sulayın.';
    }
    if (phase.isWaxing) {
      return 'Büyüyen Ay. ${sign.element.nameTr} elementindeki Ay, '
          'toprak üstü büyüyen bitkiler için uygun. Dikim ve gübreleme yapılabilir.';
    }
    return 'Azalan Ay. ${sign.element.nameTr} elementindeki Ay, '
        'kök sebzeler ve budama için uygun. Ot temizliği yapılabilir.';
  }

  int _getFertilityRating(ZodiacSign sign, MoonPhase phase) {
    int rating = 3;

    // Water and Earth signs are most fertile
    if (sign.element == Element.water) rating += 2;
    if (sign.element == Element.earth) rating += 1;
    if (sign.element == Element.fire) rating -= 1;

    // Waxing moon is better for growth
    if (phase.isWaxing) rating += 1;

    return rating.clamp(1, 5);
  }

  /// Get celebrity charts
  List<CelebrityChart> getCelebrityCharts() {
    return [
      // Scientists
      CelebrityChart(
        name: 'Albert Einstein',
        profession: 'Fizikçi',
        birthDate: DateTime(1879, 3, 14),
        birthPlace: 'Ulm, Almanya',
        sunSign: ZodiacSign.pisces,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.cancer,
        imageUrl: '',
        chartAnalysis:
            'Einstein\'ın Balık Güneşi, sezgisel ve hayal gücü yüksek doğasını gösterir. '
            'Yay Ay\'ı felsefi düşünceye ve büyük resmi görmeye yatkınlık verir. '
            'Yengeç yükseleni, güvenli bir çevrede çalışma ihtiyacını ve duygusal zekayı vurgular. '
            'Uranüs\'ün güçlü konumu, devrimci fikirleri ve norm dışı düşünceyi gösterir.',
        notableAspects: [
          'Güneş-Merkür kavuşumu - Parlak zihin',
          'Uranüs 3. evde - Yenilikçi düşünce',
          'Jüpiter-Satürn üçgeni - Sabırlı genişleme',
        ],
        category: CelebrityCategory.scientists,
      ),
      CelebrityChart(
        name: 'Marie Curie',
        profession: 'Fizikçi, Kimyager',
        birthDate: DateTime(1867, 11, 7),
        birthPlace: 'Varşova, Polonya',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            'Curie\'nin Akrep Güneşi, araştırmacı ruhu ve derinlere inme tutkusunu gösterir. '
            'Balık Ay\'ı, sezgisel anlayış ve fedakarlık kapasitesini vurgular. '
            'Başak yükseleni, bilimsel titizlik ve analitik yaklaşımı işaret eder. '
            'Pluto\'nun güçlü konumu, radyoaktivite keşfi ile sembolik olarak bağlantılıdır.',
        notableAspects: [
          'Güneş-Pluto açısı - Dönüştürücü keşifler',
          'Merkür 8. evde - Gizli olanı araştırma',
          'Satürn 10. evde - Kalıcı başarı',
        ],
        category: CelebrityCategory.scientists,
      ),
      CelebrityChart(
        name: 'Nikola Tesla',
        profession: 'Mucit, Mühendis',
        birthDate: DateTime(1856, 7, 10),
        birthPlace: 'Smiljan, Hırvatistan',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.libra,
        ascendant: ZodiacSign.aquarius,
        imageUrl: '',
        chartAnalysis:
            'Tesla\'nın Yengeç Güneşi, derin sezgi ve koruyucu vizyonu gösterir. '
            'Terazi Ay\'ı, uyum arayışı ve estetik mühendisliği vurgular. '
            'Kova yükseleni, devrimci icatları ve geleceği görme yetisini işaret eder. '
            'Uranüs\'ün güçlü konumu, elektrik ve enerji alanındaki dahiliği sembolize eder.',
        notableAspects: [
          'Uranüs-Merkür üçgeni - Devrimci fikirler',
          'Neptün 11. evde - Gelecek vizyonu',
          'Satürn 1. evde - Disiplinli dahilik',
        ],
        category: CelebrityCategory.scientists,
      ),
      CelebrityChart(
        name: 'Stephen Hawking',
        profession: 'Teorik Fizikçi',
        birthDate: DateTime(1942, 1, 8),
        birthPlace: 'Oxford, İngiltere',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.aries,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            'Hawking\'in Oğlak Güneşi, azim ve kalıcı başarı isteğini gösterir. '
            'Koç Ay\'ı, cesaret ve mücadele ruhunu vurgular. '
            'Başak yükseleni, analitik zekayı ve detaycılığı işaret eder. '
            'Satürn\'ün 6. evdeki konumu, sağlık zorluklarına rağmen çalışma disiplinini gösterir.',
        notableAspects: [
          'Güneş-Satürn kavuşumu - Engellere rağmen başarı',
          'Mars 9. evde - Felsefi savaşçı',
          'Jüpiter 8. evde - Evrenin sırlarını araştırma',
        ],
        category: CelebrityCategory.scientists,
      ),

      // Historical Figures
      CelebrityChart(
        name: 'Atatürk',
        profession: 'Devlet Adamı',
        birthDate: DateTime(1881, 5, 19),
        birthPlace: 'Selanik',
        sunSign: ZodiacSign.taurus,
        moonSign: ZodiacSign.leo,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            'Atatürk\'ün Boğa Güneşi, kararlılık ve pratik liderliği gösterir. '
            'Aslan Ay\'ı, güçlü irade ve halkını koruma içgüdüsünü vurgular. '
            'Akrep yükseleni, dönüştürücü güç ve stratejik zekayı işaret eder. '
            'Mars-Pluto açısı, engellenemez azim ve reform kapasitesini gösterir.',
        notableAspects: [
          'Güneş 10. evde - Toplumsal liderlik',
          'Mars-Pluto kavuşumu - Dönüştürücü güç',
          'Jüpiter 9. evde - Vizyon ve idealizm',
        ],
        category: CelebrityCategory.historical,
      ),
      CelebrityChart(
        name: 'Fatih Sultan Mehmet',
        profession: 'Osmanlı Sultanı',
        birthDate: DateTime(1432, 3, 30),
        birthPlace: 'Edirne',
        sunSign: ZodiacSign.aries,
        moonSign: ZodiacSign.capricorn,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Fatih\'in Koç Güneşi, fetih ruhu ve öncü cesaretini gösterir. '
            'Oğlak Ay\'ı, stratejik planlama ve uzun vadeli hedefleri vurgular. '
            'Aslan yükseleni, imparatorluk vizyonu ve liderlik karizmasını işaret eder. '
            'Mars\'ın güçlü konumu, askeri dehayı ve cesur eylemleri sembolize eder.',
        notableAspects: [
          'Mars 10. evde - Askeri liderlik',
          'Jüpiter-Satürn üçgeni - İmparatorluk kurma',
          'Güneş-Mars kavuşumu - Savaşçı ruh',
        ],
        category: CelebrityCategory.historical,
      ),
      CelebrityChart(
        name: 'Mevlana Celaleddin Rumi',
        profession: 'Sufi Şair, Mutasavvıf',
        birthDate: DateTime(1207, 9, 30),
        birthPlace: 'Belh, Afganistan',
        sunSign: ZodiacSign.libra,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.cancer,
        imageUrl: '',
        chartAnalysis:
            'Mevlana\'nın Terazi Güneşi, uyum arayışı ve ilişkilerdeki derin anlayışı gösterir. '
            'Balık Ay\'ı, mistik sezgi ve evrensel aşkı vurgular. '
            'Yengeç yükseleni, derin duygusal bağ ve şefkati işaret eder. '
            'Neptün\'ün güçlü konumu, spiritüel uyanış ve ilahi aşkı sembolize eder.',
        notableAspects: [
          'Neptün 12. evde - Mistik deneyim',
          'Venüs-Ay üçgeni - Şiirsel aşk',
          'Jüpiter 9. evde - Manevi öğretmenlik',
        ],
        category: CelebrityCategory.historical,
      ),
      CelebrityChart(
        name: 'Kleopatra',
        profession: 'Mısır Kraliçesi',
        birthDate: DateTime(-69, 1, 15),
        birthPlace: 'İskenderiye, Mısır',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.scorpio,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Kleopatra\'nın Oğlak Güneşi, siyasi zeka ve hırsı gösterir. '
            'Akrep Ay\'ı, derin tutku ve manipülasyon yeteneğini vurgular. '
            'Aslan yükseleni, kraliyet karizması ve dramatik çekiciliği işaret eder. '
            'Venüs\'ün güçlü konumu, efsanevi güzellik ve çekiciliği sembolize eder.',
        notableAspects: [
          'Venüs 1. evde - Büyüleyici güzellik',
          'Pluto 7. evde - Güçlü ilişkiler',
          'Mars-Satürn üçgeni - Stratejik savaşçı',
        ],
        category: CelebrityCategory.historical,
      ),

      // Artists
      CelebrityChart(
        name: 'Leonardo da Vinci',
        profession: 'Sanatçı, Mucit',
        birthDate: DateTime(1452, 4, 15),
        birthPlace: 'Vinci, İtalya',
        sunSign: ZodiacSign.aries,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.sagittarius,
        imageUrl: '',
        chartAnalysis:
            'Da Vinci\'nin Koç Güneşi, öncü ve cesur doğasını gösterir. '
            'Balık Ay\'ı, derin sanatsal sezgi ve hayal gücünü temsil eder. '
            'Yay yükseleni, çok yönlülük ve sürekli öğrenme tutkusunu işaret eder. '
            'Merkür-Venüs kavuşumu, estetik zeka ve el becerisi birleşimini gösterir.',
        notableAspects: [
          'Merkür-Venüs kavuşumu - Sanatsal zeka',
          'Mars 5. evde - Yaratıcı enerji',
          'Neptün güçlü - Spiritüel ilham',
        ],
        category: CelebrityCategory.artists,
      ),
      CelebrityChart(
        name: 'Vincent van Gogh',
        profession: 'Ressam',
        birthDate: DateTime(1853, 3, 30),
        birthPlace: 'Zundert, Hollanda',
        sunSign: ZodiacSign.aries,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.cancer,
        imageUrl: '',
        chartAnalysis:
            'Van Gogh\'un Koç Güneşi, tutkulu ve cesur sanatsal ifadeyi gösterir. '
            'Yay Ay\'ı, idealizm ve anlam arayışını vurgular. '
            'Yengeç yükseleni, duygusal hassasiyet ve iç dünyasını işaret eder. '
            'Neptün\'ün güçlü konumu, vizyoner sanatı ve ruhsal çalkantıyı sembolize eder.',
        notableAspects: [
          'Güneş-Uranüs kavuşumu - Radikal yaratıcılık',
          'Ay-Neptün karesi - Duygusal yoğunluk',
          'Venüs 12. evde - Gizli güzellik algısı',
        ],
        category: CelebrityCategory.artists,
      ),
      CelebrityChart(
        name: 'Frida Kahlo',
        profession: 'Ressam',
        birthDate: DateTime(1907, 7, 6),
        birthPlace: 'Coyoacán, Meksika',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.taurus,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Frida\'nın Yengeç Güneşi, derin duygusallık ve kendini koruma içgüdüsünü gösterir. '
            'Boğa Ay\'ı, duyusal zevkler ve dayanıklılığı vurgular. '
            'Aslan yükseleni, dramatik kendini ifade ve cesur imajı işaret eder. '
            'Kiron\'un güçlü konumu, acı aracılığıyla sanatı sembolize eder.',
        notableAspects: [
          'Kiron 1. evde - Yaralı sanatçı',
          'Venüs-Pluto karesi - Tutkulu aşk',
          'Mars 8. evde - Ölümle dans',
        ],
        category: CelebrityCategory.artists,
      ),
      CelebrityChart(
        name: 'Pablo Picasso',
        profession: 'Ressam, Heykeltıraş',
        birthDate: DateTime(1881, 10, 25),
        birthPlace: 'Málaga, İspanya',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Picasso\'nun Akrep Güneşi, yoğun yaratıcılık ve dönüşümü gösterir. '
            'Yay Ay\'ı, özgür düşünce ve deneyselliği vurgular. '
            'Aslan yükseleni, sanatsal ego ve dikkat çekme isteğini işaret eder. '
            'Uranüs\'ün güçlü konumu, sanatı devrimleştirmeyi sembolize eder.',
        notableAspects: [
          'Güneş-Merkür kavuşumu - Keskin zeka',
          'Uranüs 3. evde - Yenilikçi ifade',
          'Venüs-Mars karesi - Tutkulu ilişkiler',
        ],
        category: CelebrityCategory.artists,
      ),

      // Musicians
      CelebrityChart(
        name: 'Freddie Mercury',
        profession: 'Müzisyen',
        birthDate: DateTime(1946, 9, 5),
        birthPlace: 'Zanzibar',
        sunSign: ZodiacSign.virgo,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Mercury\'nin Başak Güneşi, mükemmeliyetçiliği ve müzikal detaycılığını gösterir. '
            'Yay Ay\'ı, sahne performansındaki coşkuyu ve özgürlük tutkusunu vurgular. '
            'Aslan yükseleni, karizmatik sahne varlığını ve dramatik ifadeyi işaret eder. '
            'Venüs-Mars kavuşumu, tutkulu sanatsal ifadeyi temsil eder.',
        notableAspects: [
          'Aslan yükseleni - Sahne karizması',
          'Venüs-Mars kavuşumu - Tutkulu performans',
          'Neptün 5. evde - Müzikal ilham',
        ],
        category: CelebrityCategory.musicians,
      ),
      CelebrityChart(
        name: 'Barış Manço',
        profession: 'Müzisyen, Şarkıcı',
        birthDate: DateTime(1943, 1, 2),
        birthPlace: 'İstanbul',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.aries,
        ascendant: ZodiacSign.gemini,
        imageUrl: '',
        chartAnalysis:
            'Barış Manço\'nun Oğlak Güneşi, disiplinli müzikalite ve kalıcı miras isteğini gösterir. '
            'Koç Ay\'ı, cesur sahne performansı ve öncü ruhu vurgular. '
            'İkizler yükseleni, iletişim yeteneği ve çocuklarla bağı işaret eder. '
            'Jüpiter\'in güçlü konumu, kültürel elçiliği sembolize eder.',
        notableAspects: [
          'Merkür 3. evde - İletişim ustası',
          'Venüs-Neptün üçgeni - Müzikal sezgi',
          'Jüpiter 9. evde - Kültürel köprü',
        ],
        category: CelebrityCategory.musicians,
      ),
      CelebrityChart(
        name: 'Wolfgang Amadeus Mozart',
        profession: 'Besteci',
        birthDate: DateTime(1756, 1, 27),
        birthPlace: 'Salzburg, Avusturya',
        sunSign: ZodiacSign.aquarius,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            'Mozart\'ın Kova Güneşi, dahice özgünlük ve döneminin ötesinde olmayı gösterir. '
            'Yay Ay\'ı, neşeli yaratıcılık ve müzikal maceraperestliği vurgular. '
            'Başak yükseleni, mükemmeliyetçi teknik ve titizliği işaret eder. '
            'Uranüs\'ün güçlü konumu, erken yaşta ortaya çıkan dahiliği sembolize eder.',
        notableAspects: [
          'Merkür-Venüs kavuşumu - Melodik deha',
          'Güneş-Satürn üçgeni - Disiplinli yaratıcılık',
          'Neptün 5. evde - İlahi müzik',
        ],
        category: CelebrityCategory.musicians,
      ),
      CelebrityChart(
        name: 'Ludwig van Beethoven',
        profession: 'Besteci',
        birthDate: DateTime(1770, 12, 16),
        birthPlace: 'Bonn, Almanya',
        sunSign: ZodiacSign.sagittarius,
        moonSign: ZodiacSign.sagittarius,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            'Beethoven\'in Yay Güneşi, özgürlük aşkı ve idealizmi gösterir. '
            'Yay Ay\'ı, tutkulu ifade ve felsefik derinliği vurgular. '
            'Akrep yükseleni, yoğun duygusallık ve dönüşümü işaret eder. '
            'Satürn\'ün güçlü konumu, sağırlığa rağmen devam eden mücadeleyi sembolize eder.',
        notableAspects: [
          'Güneş-Ay kavuşumu - Güçlü irade',
          'Mars 1. evde - Savaşçı ruh',
          'Pluto 8. evde - Müzikte dönüşüm',
        ],
        category: CelebrityCategory.musicians,
      ),
      CelebrityChart(
        name: 'Tarkan',
        profession: 'Pop Şarkıcısı',
        birthDate: DateTime(1972, 10, 17),
        birthPlace: 'Alzey, Almanya',
        sunSign: ZodiacSign.libra,
        moonSign: ZodiacSign.taurus,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Tarkan\'ın Terazi Güneşi, estetik mükemmeliyetçiliği ve çekiciliği gösterir. '
            'Boğa Ay\'ı, duyusal müzikalite ve ses kalitesini vurgular. '
            'Aslan yükseleni, sahne hakimiyeti ve star karizmasını işaret eder. '
            'Venüs\'ün güçlü konumu, romantik şarkıları ve dans yetenğini sembolize eder.',
        notableAspects: [
          'Venüs 1. evde - Doğal çekicilik',
          'Mars-Neptün üçgeni - Hipnotik performans',
          'Jüpiter 5. evde - Yaratıcı başarı',
        ],
        category: CelebrityCategory.musicians,
      ),

      // Actors
      CelebrityChart(
        name: 'Marilyn Monroe',
        profession: 'Aktris',
        birthDate: DateTime(1926, 6, 1),
        birthPlace: 'Los Angeles, ABD',
        sunSign: ZodiacSign.gemini,
        moonSign: ZodiacSign.aquarius,
        ascendant: ZodiacSign.leo,
        imageUrl: '',
        chartAnalysis:
            'Monroe\'nun İkizler Güneşi, çok yönlülük ve ikili doğasını gösterir. '
            'Kova Ay\'ı, farklı olma isteği ve duygusal bağımsızlığı vurgular. '
            'Aslan yükseleni, ışıltılı çekicilik ve dramatik varlığı işaret eder. '
            'Neptün\'ün güçlü konumu, hayali imajı ve kaçış eğilimini sembolize eder.',
        notableAspects: [
          'Venüs-Neptün kavuşumu - Büyüleyici cazibe',
          'Ay 7. evde - İlişkilerde karmaşıklık',
          'Pluto 12. evde - Gizli derinlikler',
        ],
        category: CelebrityCategory.actors,
      ),
      CelebrityChart(
        name: 'Türkan Şoray',
        profession: 'Aktris',
        birthDate: DateTime(1945, 6, 28),
        birthPlace: 'İstanbul',
        sunSign: ZodiacSign.cancer,
        moonSign: ZodiacSign.scorpio,
        ascendant: ZodiacSign.libra,
        imageUrl: '',
        chartAnalysis:
            'Türkan Şoray\'ın Yengeç Güneşi, derin duygusallık ve anne figürünü gösterir. '
            'Akrep Ay\'ı, yoğun roller ve dönüştürücü performansları vurgular. '
            'Terazi yükseleni, zarif güzellik ve diplomatik kişiliği işaret eder. '
            'Venüs\'ün güçlü konumu, Yeşilçam\'ın sultanı ünvanını sembolize eder.',
        notableAspects: [
          'Güneş-Venüs kavuşumu - Doğal yıldız',
          'Ay-Pluto kavuşumu - Derin roller',
          'Jüpiter 10. evde - Kariyer başarısı',
        ],
        category: CelebrityCategory.actors,
      ),
      CelebrityChart(
        name: 'Leonardo DiCaprio',
        profession: 'Aktör',
        birthDate: DateTime(1974, 11, 11),
        birthPlace: 'Los Angeles, ABD',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.libra,
        ascendant: ZodiacSign.libra,
        imageUrl: '',
        chartAnalysis:
            'DiCaprio\'nun Akrep Güneşi, yoğun performanslar ve dönüşümü gösterir. '
            'Terazi Ay\'ı, estetik hassasiyet ve işbirliği yeteneğini vurgular. '
            'Terazi yükseleni, çekici görünüm ve diplomatik kişiliği işaret eder. '
            'Pluto\'nun güçlü konumu, ağır rolleri ve aktivizmi sembolize eder.',
        notableAspects: [
          'Güneş-Pluto üçgeni - Dönüştürücü yetenk',
          'Mars 11. evde - Sosyal aktivizm',
          'Neptün 5. evde - Sinematik ilham',
        ],
        category: CelebrityCategory.actors,
      ),
      CelebrityChart(
        name: 'Kemal Sunal',
        profession: 'Komedyen, Aktör',
        birthDate: DateTime(1944, 11, 11),
        birthPlace: 'İstanbul',
        sunSign: ZodiacSign.scorpio,
        moonSign: ZodiacSign.gemini,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            'Kemal Sunal\'ın Akrep Güneşi, karakterlerin derinine inmeyi gösterir. '
            'İkizler Ay\'ı, komedi zamanlaması ve sözel zekayı vurgular. '
            'Başak yükseleni, mütevazi kişiliği ve titiz çalışmayı işaret eder. '
            'Merkür\'ün güçlü konumu, halkın adamı imajını sembolize eder.',
        notableAspects: [
          'Merkür-Jüpiter üçgeni - Komik zeka',
          'Satürn 10. evde - Kalıcı miras',
          'Neptün 1. evde - Karaktere bürünme',
        ],
        category: CelebrityCategory.actors,
      ),

      // Athletes
      CelebrityChart(
        name: 'Cristiano Ronaldo',
        profession: 'Futbolcu',
        birthDate: DateTime(1985, 2, 5),
        birthPlace: 'Madeira, Portekiz',
        sunSign: ZodiacSign.aquarius,
        moonSign: ZodiacSign.leo,
        ascendant: ZodiacSign.virgo,
        imageUrl: '',
        chartAnalysis:
            'Ronaldo\'nun Kova Güneşi, bireysellik ve benzersiz yetenekleri gösterir. '
            'Aslan Ay\'ı, gurur ve tanınma ihtiyacını vurgular. '
            'Başak yükseleni, disiplinli çalışma ve mükemmeliyetçiliği işaret eder. '
            'Mars\'ın güçlü konumu, fiziksel üstünlüğü ve rekabetçiliği sembolize eder.',
        notableAspects: [
          'Mars-Jüpiter kavuşumu - Atletik şans',
          'Güneş-Satürn karesi - Engelleri aşma',
          'Venüs 5. evde - Şöhret ve zenginlik',
        ],
        category: CelebrityCategory.athletes,
      ),
      CelebrityChart(
        name: 'Naim Süleymanoğlu',
        profession: 'Halterci',
        birthDate: DateTime(1967, 1, 23),
        birthPlace: 'Ptiçar, Bulgaristan',
        sunSign: ZodiacSign.aquarius,
        moonSign: ZodiacSign.aries,
        ascendant: ZodiacSign.scorpio,
        imageUrl: '',
        chartAnalysis:
            'Naim\'in Kova Güneşi, benzersiz fiziksel güç ve özgürlük aşkını gösterir. '
            'Koç Ay\'ı, rekabetçi ruh ve cesur mücadeleyi vurgular. '
            'Akrep yükseleni, yoğun kararlılık ve dönüşümü işaret eder. '
            'Pluto\'nun güçlü konumu, "Cep Herkülü" lakabını sembolize eder.',
        notableAspects: [
          'Mars 1. evde - Fiziksel güç',
          'Satürn-Pluto kavuşumu - Engellenemez irade',
          'Jüpiter 10. evde - Dünya şampiyonluğu',
        ],
        category: CelebrityCategory.athletes,
      ),

      // Writers
      CelebrityChart(
        name: 'William Shakespeare',
        profession: 'Yazar, Şair',
        birthDate: DateTime(1564, 4, 23),
        birthPlace: 'Stratford-upon-Avon, İngiltere',
        sunSign: ZodiacSign.taurus,
        moonSign: ZodiacSign.virgo,
        ascendant: ZodiacSign.gemini,
        imageUrl: '',
        chartAnalysis:
            'Shakespeare\'in Boğa Güneşi, duyusal dil ve kalıcı sanatı gösterir. '
            'Başak Ay\'ı, titiz yazarlık ve psikolojik analizi vurgular. '
            'İkizler yükseleni, dil ustalığı ve çok yönlülüğü işaret eder. '
            'Merkür\'ün güçlü konumu, edebi dahiliği sembolize eder.',
        notableAspects: [
          'Merkür-Venüs kavuşumu - Şiirsel dil',
          'Neptün 3. evde - Edebi ilham',
          'Pluto 5. evde - Trajedilerde derinlik',
        ],
        category: CelebrityCategory.writers,
      ),
      CelebrityChart(
        name: 'Orhan Pamuk',
        profession: 'Yazar',
        birthDate: DateTime(1952, 6, 7),
        birthPlace: 'İstanbul',
        sunSign: ZodiacSign.gemini,
        moonSign: ZodiacSign.pisces,
        ascendant: ZodiacSign.libra,
        imageUrl: '',
        chartAnalysis:
            'Pamuk\'un İkizler Güneşi, anlatıcı yeteneği ve entelektüel merakı gösterir. '
            'Balık Ay\'ı, nostaljik duyarlılık ve hayal gücünü vurgular. '
            'Terazi yükseleni, estetik hassasiyet ve dengeli bakışı işaret eder. '
            'Neptün\'ün güçlü konumu, İstanbul romantiğini sembolize eder.',
        notableAspects: [
          'Merkür 3. evde - Yazarlık dehası',
          'Neptün-Ay kavuşumu - Rüya gibi anlatım',
          'Satürn 10. evde - Nobel ödülü',
        ],
        category: CelebrityCategory.writers,
      ),
      CelebrityChart(
        name: 'Nazım Hikmet',
        profession: 'Şair',
        birthDate: DateTime(1902, 1, 15),
        birthPlace: 'Selanik',
        sunSign: ZodiacSign.capricorn,
        moonSign: ZodiacSign.aquarius,
        ascendant: ZodiacSign.sagittarius,
        imageUrl: '',
        chartAnalysis:
            'Nazım\'ın Oğlak Güneşi, kararlılık ve toplumsal sorumluluk duygusunu gösterir. '
            'Kova Ay\'ı, insancıl idealleri ve özgürlük aşkını vurgular. '
            'Yay yükseleni, evrensel vizyon ve sürgün yaşamını işaret eder. '
            'Uranüs\'ün güçlü konumu, devrimci şiiri sembolize eder.',
        notableAspects: [
          'Güneş-Uranüs karesi - Asi ruh',
          'Ay 3. evde - Halkın şairi',
          'Mars 9. evde - Sürgünde mücadele',
        ],
        category: CelebrityCategory.writers,
      ),
    ];
  }

  /// Get articles
  List<AstrologyArticle> getArticles() {
    return [
      AstrologyArticle(
        id: '1',
        title: 'Astrolojiye Başlangıç: Temel Kavramlar',
        summary:
            'Astroloji dünyasına ilk adımınızı atın. Burçlar, gezegenler ve evler hakkında temel bilgiler.',
        content: '''
Astroloji, gökyüzündeki gök cisimlerinin konumlarının dünya üzerindeki olayları ve insan davranışlarını etkilediği inancına dayanan kadim bir bilim dalıdır.

## Burçlar

Zodyak kuşağı 12 eşit parçaya bölünmüştür ve her parça bir burcu temsil eder:

1. **Koç (21 Mart - 19 Nisan)**: Cesaret, enerji, liderlik
2. **Boğa (20 Nisan - 20 Mayıs)**: İstikrar, güvenlik, konfor
3. **İkizler (21 Mayıs - 20 Haziran)**: İletişim, merak, çok yönlülük
4. **Yengeç (21 Haziran - 22 Temmuz)**: Duygusallık, koruma, sezgi
5. **Aslan (23 Temmuz - 22 Ağustos)**: Yaratıcılık, liderlik, cömertlik
6. **Başak (23 Ağustos - 22 Eylül)**: Analiz, hizmet, mükemmeliyetçilik
7. **Terazi (23 Eylül - 22 Ekim)**: Denge, uyum, ilişkiler
8. **Akrep (23 Ekim - 21 Kasım)**: Yoğunluk, dönüşüm, tutku
9. **Yay (22 Kasım - 21 Aralık)**: Macera, felsefe, özgürlük
10. **Oğlak (22 Aralık - 19 Ocak)**: Hırs, disiplin, sorumluluk
11. **Kova (20 Ocak - 18 Şubat)**: Yenilik, insancıllık, bağımsızlık
12. **Balık (19 Şubat - 20 Mart)**: Sezgi, şefkat, spiritüellik

## Gezegenler

Her gezegen farklı bir yaşam alanını temsil eder:

- **Güneş**: Benlik, kimlik
- **Ay**: Duygular, içgüdüler
- **Merkür**: İletişim, düşünce
- **Venüs**: Aşk, güzellik
- **Mars**: Eylem, enerji
- **Jüpiter**: Büyüme, şans
- **Satürn**: Yapı, disiplin
- **Uranüs**: Değişim, özgünlük
- **Neptün**: Rüyalar, spiritüellik
- **Pluto**: Dönüşüm, güç

## Evler

Doğum haritası 12 eve bölünür ve her ev yaşamın farklı bir alanını temsil eder:

1. Ev - Benlik ve görünüm
2. Ev - Para ve değerler
3. Ev - İletişim ve yakın çevre
4. Ev - Ev ve aile
5. Ev - Yaratıcılık ve romantizm
6. Ev - Sağlık ve günlük rutinler
7. Ev - Ortaklıklar ve evlilik
8. Ev - Dönüşüm ve paylaşılan kaynaklar
9. Ev - Felsefe ve yabancı kültürler
10. Ev - Kariyer ve toplumsal konum
11. Ev - Arkadaşlık ve idealler
12. Ev - Bilinçaltı ve spiritüellik
        ''',
        category: ArticleCategory.beginners,
        publishedAt: DateTime.now().subtract(const Duration(days: 30)),
        author: 'Venus One Team',
        readTimeMinutes: 8,
        tags: ['başlangıç', 'burçlar', 'gezegenler', 'evler'],
      ),
      AstrologyArticle(
        id: '2',
        title: 'İlişkilerde Astroloji: Sinastri Rehberi',
        summary:
            'Sevgilinizle uyumunuzu astrolojik açıdan nasıl değerlendirebilirsiniz?',
        content: '''
Sinastri, iki kişinin doğum haritalarını karşılaştırarak ilişki dinamiklerini anlama sanatıdır.

## Önemli Açılar

İki harita arasındaki gezegen bağlantıları ilişkinin doğasını belirler:

### Kavuşumlar (0°)
İki gezegen yan yana geldiğinde güçlü bir bağ oluşur. Güneş-Ay kavuşumu derin duygusal bağı gösterir.

### Üçgenler (120°)
Doğal uyum ve akış. Venüs-Mars üçgeni romantik çekimi kolaylaştırır.

### Kareler (90°)
Zorluk ama büyüme potansiyeli. Güneş-Satürn karesi ilişkide olgunlaşmayı gerektirir.

## En Önemli Bağlantılar

1. **Güneş-Ay**: Temel uyum göstergesi
2. **Venüs-Mars**: Romantik ve cinsel çekim
3. **Merkür-Merkür**: İletişim uyumu
4. **Ay-Venüs**: Duygusal bağ ve şefkat
5. **Jüpiter bağlantıları**: Birlikte büyüme

## 7. Ev Analizi

Her iki kişinin de 7. evi ilişki beklentilerini gösterir. 7. ev yöneticisinin konumu ve açıları önemlidir.
        ''',
        category: ArticleCategory.relationships,
        publishedAt: DateTime.now().subtract(const Duration(days: 15)),
        author: 'Venus One Team',
        readTimeMinutes: 6,
        tags: ['sinastri', 'ilişkiler', 'uyum'],
      ),
      AstrologyArticle(
        id: '3',
        title: 'Merkür Retrosu: Korkulacak Bir Şey Yok',
        summary:
            'Merkür retrosunun gerçek anlamı ve bu dönemi nasıl verimli geçirebilirsiniz.',
        content: '''
Merkür retrosu, astrolojide en çok konuşulan ve korkulan dönemlerden biridir. Ancak doğru anlayışla bu dönem fırsata dönüşebilir.

## Merkür Retrosu Nedir?

Dünya'dan bakıldığında Merkür'ün geriye doğru hareket ediyor gibi görünmesidir. Yılda yaklaşık üç kez, her biri 3 hafta sürer.

## Ne Beklemeli?

- İletişim aksaklıkları
- Teknoloji sorunları
- Seyahat gecikmeleri
- Geçmişten gelen konular

## Ne Yapmalı?

### Yapılması Gerekenler:
- Yedek alın
- Detaylara dikkat edin
- Eski projeleri tamamlayın
- Eski arkadaşlarla bağlantı kurun
- Düşünün ve planlayın

### Kaçınılması Gerekenler:
- Büyük sözleşmeler imzalamak
- Yeni teknoloji satın almak
- Önemli kararlar vermek
- Yeni projelere başlamak

## Gölge Dönemleri

Retro öncesi ve sonrası 2 haftalık gölge dönemleri de dikkat gerektirir.
        ''',
        category: ArticleCategory.currentTransits,
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        author: 'Venus One Team',
        readTimeMinutes: 5,
        tags: ['merkür', 'retro', 'transit'],
      ),
    ];
  }
}
