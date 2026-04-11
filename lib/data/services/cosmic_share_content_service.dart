import 'dart:math';
import '../models/zodiac_sign.dart';
import '../models/planet.dart';
import 'moon_service.dart';

/// Service for generating viral, shareable cosmic content
class CosmicShareContentService {
  static final _random = Random();

  /// Generate complete share screen content for a user
  static CosmicShareContent generateContent({
    required ZodiacSign sunSign,
    required DateTime birthDate,
    ZodiacSign? risingSign,
    ZodiacSign? moonSign,
  }) {
    final today = DateTime.now();
    final moonPhase = MoonService.getCurrentPhase(today);
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;

    return CosmicShareContent(
      heroBlock: _generateHeroBlock(sunSign, today, moonPhase),
      personalMessage: _generatePersonalMessage(sunSign, risingSign, moonSign),
      energyMeter: _generateEnergyMeter(sunSign, dayOfYear),
      planetaryInfluence: _generatePlanetaryInfluence(sunSign, today),
      shadowLight: _generateShadowLight(sunSign),
      cosmicAdvice: _generateCosmicAdvice(sunSign),
      symbolicMessage: _generateSymbolicMessage(sunSign, dayOfYear),
      viralHook: _generateViralHook(sunSign),
      sharePrompt: _generateSharePrompt(),
      collectiveMoment: _generateCollectiveMoment(sunSign, moonPhase),
      premiumCuriosity: _generatePremiumCuriosity(sunSign),
      microMessages: _generateMicroMessages(sunSign),
      // MASTER LEVEL additions
      dreamInsight: _generateDreamInsight(sunSign, moonPhase),
      numerologyInsight: _generateNumerologyInsight(today),
      tantraWisdom: _generateTantraWisdom(sunSign),
      chakraSnapshot: _generateChakraSnapshot(sunSign, dayOfYear),
      timingHint: _generateTimingHint(sunSign, today),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MASTER LEVEL: NEW GENERATORS
  // ═══════════════════════════════════════════════════════════════

  static DreamInsight _generateDreamInsight(
    ZodiacSign sign,
    MoonPhase moonPhase,
  ) {
    final symbols = {
      ZodiacSign.aries: ['🔥', 'Ateş — dönüşüm ve tutku'],
      ZodiacSign.taurus: ['🌳', 'Ağaç — kökler ve büyüme'],
      ZodiacSign.gemini: ['🪞', 'Ayna — iç yansıma'],
      ZodiacSign.cancer: ['🌊', 'Su — duygusal derinlik'],
      ZodiacSign.leo: ['👑', 'Taç — içsel güç'],
      ZodiacSign.virgo: ['🔮', 'Kristal — berraklık'],
      ZodiacSign.libra: ['⚖️', 'Terazi — denge arayışı'],
      ZodiacSign.scorpio: ['🦋', 'Kelebek — metamorfoz'],
      ZodiacSign.sagittarius: ['🏹', 'Ok — hedef ve yön'],
      ZodiacSign.capricorn: ['⛰️', 'Dağ — zirve yolculuğu'],
      ZodiacSign.aquarius: ['⚡', 'Şimşek — ani farkındalık'],
      ZodiacSign.pisces: ['🐚', 'Deniz kabuğu — içsel ses'],
    };

    final prompts = [
      'Bu gece rüyanda neyi görmek isterdin?',
      'Gözlerini kapattığında hangi renk beliriyor?',
      'Bilinçaltın sana ne fısıldıyor?',
      'Ay ışığında hangi kapı açılıyor?',
    ];

    final nightMessages = {
      MoonPhase.newMoon: 'Karanlıkta bile ışık var.',
      MoonPhase.waxingCrescent: 'Tohumlar sessizce büyüyor.',
      MoonPhase.firstQuarter: 'Yarısı aydınlık, yarısı gizem.',
      MoonPhase.waxingGibbous: 'Doluluk yaklaşıyor.',
      MoonPhase.fullMoon: 'Her şey aydınlanıyor.',
      MoonPhase.waningGibbous: 'Minnetle bırak.',
      MoonPhase.lastQuarter: 'Eski döngü kapanıyor.',
      MoonPhase.waningCrescent: 'Dinlenme zamanı.',
    };

    final symbolData = symbols[sign] ?? ['✨', 'Yıldız — sonsuz potansiyel'];

    return DreamInsight(
      symbol: symbolData[0],
      symbolMeaning: symbolData[1],
      dreamPrompt: prompts[_random.nextInt(prompts.length)],
      nightMessage: nightMessages[moonPhase] ?? 'Rüyaların rehberin olsun.',
    );
  }

  static NumerologyInsight _generateNumerologyInsight(DateTime today) {
    // Calculate day number (reduce to single digit)
    int daySum = today.day + today.month + today.year;
    while (daySum > 9 && daySum != 11 && daySum != 22 && daySum != 33) {
      daySum = daySum
          .toString()
          .split('')
          .map(int.parse)
          .reduce((a, b) => a + b);
    }

    final meanings = {
      1: 'Başlangıçların enerjisi',
      2: 'Ortaklık ve denge',
      3: 'Yaratıcılık akışta',
      4: 'Temel atma zamanı',
      5: 'Değişim rüzgârı',
      6: 'Sevgi ve sorumluluk',
      7: 'İçsel yolculuk',
      8: 'Bolluk kapısı',
      9: 'Tamamlanma enerjisi',
      11: 'Aydınlanma portali',
      22: 'Usta inşaatçı',
      33: 'Kozmik öğretmen',
    };

    final vibrations = {
      1: 'Cesur ve kararlı',
      2: 'Hassas ve sezgisel',
      3: 'Neşeli ve ifade dolu',
      4: 'Pratik ve disiplinli',
      5: 'Maceracı ve özgür',
      6: 'Şefkatli ve koruyucu',
      7: 'Mistik ve analitik',
      8: 'Güçlü ve hırslı',
      9: 'Bilge ve insancıl',
      11: 'Vizyoner ve ilham dolu',
      22: 'Yapıcı ve manifestör',
      33: 'Şifacı ve yüksek bilinç',
    };

    // Calculate lucky hour based on day number
    final luckyHours = [
      '06:00',
      '09:00',
      '11:11',
      '14:00',
      '17:00',
      '19:00',
      '21:00',
      '23:00',
    ];
    final luckyHour = luckyHours[(daySum - 1) % luckyHours.length];

    return NumerologyInsight(
      dayNumber: daySum,
      numberMeaning: meanings[daySum] ?? 'Evrensel enerji',
      vibration: vibrations[daySum] ?? 'Dengeli titreşim',
      luckyHour: luckyHour,
    );
  }

  static TantraWisdom _generateTantraWisdom(ZodiacSign sign) {
    final breathFocuses = [
      'Nefesini kalbinin merkezine yönlendir.',
      'Her nefeste evrenle bir ol.',
      'Nefes alırken ışık, verirken huzur.',
      'Sessizlikte nefesinin sesini dinle.',
    ];

    final awarenessPoints = {
      ZodiacSign.aries: 'Başının tepesi — taç çakra',
      ZodiacSign.taurus: 'Boğazın — ifade merkezi',
      ZodiacSign.gemini: 'Ellerinin içi — enerji portali',
      ZodiacSign.cancer: 'Kalbinin ortası — sevgi merkezi',
      ZodiacSign.leo: 'Göğüs kafesinin merkezi',
      ZodiacSign.virgo: 'Solar pleksus — güç merkezi',
      ZodiacSign.libra: 'Kalp ile zihin arasındaki köprü',
      ZodiacSign.scorpio: 'Sakral bölge — yaratım enerjisi',
      ZodiacSign.sagittarius: 'Kalçalar — hareket enerjisi',
      ZodiacSign.capricorn: 'Dizler — alçakgönüllülük noktası',
      ZodiacSign.aquarius: 'Üçüncü göz — sezgi kapısı',
      ZodiacSign.pisces: 'Ayak tabanları — topraklama',
    };

    final connections = [
      'Bedenin tapınağın, ruhun sakin.',
      'İçindeki sonsuzluğu hisset.',
      'Şu an mükemmel. Olduğun gibi.',
      'Evren seninle nefes alıyor.',
      'Her an yeni bir başlangıç.',
    ];

    return TantraWisdom(
      breathFocus: breathFocuses[_random.nextInt(breathFocuses.length)],
      awarenessPoint: awarenessPoints[sign] ?? 'Kalbinin derinliği',
      innerConnection: connections[_random.nextInt(connections.length)],
    );
  }

  static ChakraSnapshot _generateChakraSnapshot(
    ZodiacSign sign,
    int dayOfYear,
  ) {
    final chakras = {
      ZodiacSign.aries: ['Kök Çakra', '🔴', 'Güvenlik ve topraklama'],
      ZodiacSign.taurus: ['Sakral Çakra', '🟠', 'Yaratıcılık ve tutku'],
      ZodiacSign.gemini: ['Boğaz Çakra', '🔵', 'İletişim ve ifade'],
      ZodiacSign.cancer: ['Kalp Çakra', '💚', 'Sevgi ve şefkat'],
      ZodiacSign.leo: ['Solar Pleksus', '💛', 'Güç ve özgüven'],
      ZodiacSign.virgo: ['Solar Pleksus', '💛', 'Analiz ve düzen'],
      ZodiacSign.libra: ['Kalp Çakra', '💚', 'Denge ve uyum'],
      ZodiacSign.scorpio: ['Sakral Çakra', '🟠', 'Dönüşüm ve yeniden doğuş'],
      ZodiacSign.sagittarius: ['Üçüncü Göz', '💜', 'Vizyon ve bilgelik'],
      ZodiacSign.capricorn: ['Kök Çakra', '🔴', 'Yapı ve disiplin'],
      ZodiacSign.aquarius: ['Taç Çakra', '🤍', 'Evrensel bağlantı'],
      ZodiacSign.pisces: ['Üçüncü Göz', '💜', 'Sezgi ve rüyalar'],
    };

    final chakraData = chakras[sign] ?? ['Kalp Çakra', '💚', 'Sevgi merkezi'];
    final balance = 0.5 + (dayOfYear % 50) / 100.0; // 0.5 - 1.0 arası

    return ChakraSnapshot(
      activeChakra: chakraData[0],
      chakraSymbol: chakraData[1],
      chakraMessage: chakraData[2],
      balanceLevel: balance.clamp(0.0, 1.0),
    );
  }

  static CosmicTimingHint _generateTimingHint(ZodiacSign sign, DateTime today) {
    final goldenHours = {
      ZodiacSign.aries: '06:00 - 08:00',
      ZodiacSign.taurus: '10:00 - 12:00',
      ZodiacSign.gemini: '14:00 - 16:00',
      ZodiacSign.cancer: '20:00 - 22:00',
      ZodiacSign.leo: '12:00 - 14:00',
      ZodiacSign.virgo: '08:00 - 10:00',
      ZodiacSign.libra: '16:00 - 18:00',
      ZodiacSign.scorpio: '22:00 - 00:00',
      ZodiacSign.sagittarius: '14:00 - 16:00',
      ZodiacSign.capricorn: '06:00 - 08:00',
      ZodiacSign.aquarius: '18:00 - 20:00',
      ZodiacSign.pisces: '04:00 - 06:00',
    };

    final avoidHours = {
      ZodiacSign.aries: '14:00 - 15:00',
      ZodiacSign.taurus: '18:00 - 19:00',
      ZodiacSign.gemini: '10:00 - 11:00',
      ZodiacSign.cancer: '12:00 - 13:00',
      ZodiacSign.leo: '20:00 - 21:00',
      ZodiacSign.virgo: '16:00 - 17:00',
      ZodiacSign.libra: '08:00 - 09:00',
      ZodiacSign.scorpio: '14:00 - 15:00',
      ZodiacSign.sagittarius: '06:00 - 07:00',
      ZodiacSign.capricorn: '22:00 - 23:00',
      ZodiacSign.aquarius: '10:00 - 11:00',
      ZodiacSign.pisces: '14:00 - 15:00',
    };

    final rituals = [
      'Niyetini kağıda yaz, sonra yak.',
      '3 dakika sessizce nefes al.',
      'Bir bardak su içerken minnetle dol.',
      'Güneşe veya aya bak, teşekkür et.',
      'Bugün için tek bir kelime seç.',
      'Kalbine elini koy, dinle.',
    ];

    return CosmicTimingHint(
      goldenHour: goldenHours[sign] ?? '12:00 - 14:00',
      avoidHour: avoidHours[sign] ?? '15:00 - 16:00',
      ritualSuggestion: rituals[_random.nextInt(rituals.length)],
    );
  }

  static HeroBlock _generateHeroBlock(
    ZodiacSign sign,
    DateTime today,
    MoonPhase moonPhase,
  ) {
    final headlines = _heroHeadlines[sign] ?? _defaultHeroHeadlines;
    final headline = headlines[_random.nextInt(headlines.length)];

    final cosmicTitles = {
      ZodiacSign.aries: 'Ateşin Çocuğu',
      ZodiacSign.taurus: 'Toprağın Koruyucusu',
      ZodiacSign.gemini: 'Rüzgârın Elçisi',
      ZodiacSign.cancer: 'Ay\'ın Varisi',
      ZodiacSign.leo: 'Güneşin Tahtı',
      ZodiacSign.virgo: 'Yıldızların Şifacısı',
      ZodiacSign.libra: 'Dengenin Ustası',
      ZodiacSign.scorpio: 'Dönüşümün Simyacısı',
      ZodiacSign.sagittarius: 'Ufkun Kâşifi',
      ZodiacSign.capricorn: 'Zamanın Mimarı',
      ZodiacSign.aquarius: 'Geleceğin Vizyoneri',
      ZodiacSign.pisces: 'Sonsuzluğun Rüyacısı',
    };

    return HeroBlock(
      signTitle: cosmicTitles[sign] ?? sign.nameTr,
      signSymbol: sign.symbol,
      cosmicHeadline: headline,
      dateFormatted: _formatTurkishDate(today),
      moonPhaseText: _getMoonPhaseText(moonPhase),
      moonPhaseEmoji: _getMoonPhaseEmoji(moonPhase),
    );
  }

  static PersonalCosmicMessage _generatePersonalMessage(
    ZodiacSign sunSign,
    ZodiacSign? risingSign,
    ZodiacSign? moonSign,
  ) {
    final messages = _personalMessages[sunSign] ?? _defaultPersonalMessages;
    final message = messages[_random.nextInt(messages.length)];

    String enhancedMessage = message;
    if (risingSign != null) {
      enhancedMessage += ' ${_risingInfluence[risingSign] ?? ''}';
    }
    if (moonSign != null) {
      enhancedMessage += ' ${_moonInfluence[moonSign] ?? ''}';
    }

    return PersonalCosmicMessage(
      message: enhancedMessage.trim(),
      emotionalCore: _getEmotionalCore(sunSign),
    );
  }

  static CosmicEnergyMeter _generateEnergyMeter(
    ZodiacSign sign,
    int dayOfYear,
  ) {
    // Pseudo-randomized but consistent for the same day
    final seed = dayOfYear + sign.index;
    final energyLevel = 45 + (seed % 50);
    final intuitionLevel = 30 + ((seed * 7) % 65);

    final intensityOptions = ['Sakin', 'Yükselen', 'Yoğun', 'Fırtınalı'];
    final intensityIndex = (seed ~/ 10) % intensityOptions.length;

    final balanceRatio = (seed % 100) / 100.0;

    return CosmicEnergyMeter(
      energyLevel: energyLevel,
      energyDescription: _getEnergyDescription(energyLevel),
      emotionalIntensity: intensityOptions[intensityIndex],
      intensityDescription: _getIntensityDescription(
        intensityOptions[intensityIndex],
      ),
      intuitionStrength: intuitionLevel,
      intuitionDescription: _getIntuitionDescription(intuitionLevel),
      actionReflectionBalance: balanceRatio,
      balanceDescription: balanceRatio > 0.6
          ? 'Bugün hareket günü. Düşünmeyi bırak, yap.'
          : balanceRatio < 0.4
          ? 'İçe dön. Cevaplar sessizlikte gizli.'
          : 'Dengeli bir gün. Hem düşün hem hareket et.',
    );
  }

  static PlanetaryInfluence _generatePlanetaryInfluence(
    ZodiacSign sign,
    DateTime today,
  ) {
    final dominantPlanets = _getDominantPlanets(sign, today);
    final dominant = dominantPlanets.first;

    final planetData =
        _planetInfluenceData[dominant] ??
        PlanetInfluenceData(
          activates: 'İç gücünüzü',
          blocks: 'Şüphelerinizi',
          action: 'Kalbinizin sesini dinleyin.',
        );

    return PlanetaryInfluence(
      dominantPlanet: dominant,
      planetSymbol: _getPlanetSymbol(dominant),
      activates: planetData.activates,
      blocks: planetData.blocks,
      oneAction: planetData.action,
      exclusivityText:
          'Bu gezegen etkisi bugün sadece ${sign.nameTr} ve ${_getCompatibleSign(sign).nameTr} için bu kadar güçlü.',
    );
  }

  static ShadowLightDuality _generateShadowLight(ZodiacSign sign) {
    final shadowData = _shadowData[sign] ?? _defaultShadowData;
    final lightData = _lightData[sign] ?? _defaultLightData;

    return ShadowLightDuality(
      shadowChallenge: shadowData.challenge,
      shadowFear: shadowData.fear,
      shadowPattern: shadowData.pattern,
      lightStrength: lightData.strength,
      lightOpportunity: lightData.opportunity,
      lightMagnetic: lightData.magnetic,
    );
  }

  static List<String> _generateCosmicAdvice(ZodiacSign sign) {
    final allAdvice = _cosmicAdvice[sign] ?? _defaultCosmicAdvice;
    final shuffled = List<String>.from(allAdvice)..shuffle(_random);
    return shuffled.take(3).toList();
  }

  static SymbolicMessage _generateSymbolicMessage(
    ZodiacSign sign,
    int dayOfYear,
  ) {
    final archetypes = _archetypes[sign] ?? _defaultArchetypes;
    final index = dayOfYear % archetypes.length;
    return archetypes[index];
  }

  static String _generateViralHook(ZodiacSign sign) {
    final hooks = [
      'Bugün ${sign.nameTr} burçları bir şeylerin farkına varıyor.',
      'Bu enerji sadece birkaç burcu etkiliyor — sen de onlardan birisin.',
      '${sign.nameTr} burçları için kritik bir dönem başlıyor.',
      'Şu an ${sign.nameTr} burçlarının çoğu bunu hissediyor.',
      'Bu kozmik hizalanma nadir görülüyor.',
      'Evren bugün ${sign.nameTr} burçlarına mesaj gönderiyor.',
      'Rüyaların bugün sana bir şey söylüyor.',
      'Sayılar bugün seninle konuşuyor.',
      'Çakraların uyandığını hissedebiliyor musun?',
      '${sign.nameTr} enerjisi bugün farklı akıyor.',
      'Bu farkındalık tesadüf değil.',
      'Evrenin sana özel bir notu var.',
    ];
    return hooks[_random.nextInt(hooks.length)];
  }

  static String _generateSharePrompt() {
    final prompts = [
      'Bu sana dokunduysa, birinin de buna ihtiyacı var.',
      'Tanıdığın biri bugün bunu görmeli.',
      'Kalbine dokunan şeyleri paylaşmaktan korkma.',
      'Belki de bu mesaj senin için değil, senin aracılığınla birine ulaşacak.',
      'Evrenin mesajları paylaşıldıkça güçlenir.',
      'Kozmik enerji paylaşıldıkça çoğalır.',
      'Rüya İzini takip edenler için.',
      'Bugünün sayısı sana ne söylüyor?',
      'İçsel yolculuğunu paylaş.',
      'Farkındalık bulaşıcıdır.',
    ];
    return prompts[_random.nextInt(prompts.length)];
  }

  static CollectiveMoment _generateCollectiveMoment(
    ZodiacSign sign,
    MoonPhase moonPhase,
  ) {
    final mainTexts = [
      'Senin burcundan pek çok kişi bugün aynı şeyi hissediyor.',
      'Bu enerji şu an sadece birkaç burcu bu kadar derinden etkiliyor.',
      '${sign.nameTr} burçları için bu dönem özel bir anlam taşıyor.',
      'Bugün ${sign.nameTr} burçlarının çoğu benzer bir iç sese kulak veriyor.',
      'Bu kozmik dalga seninle aynı burçta olanları özellikle sarıyor.',
    ];

    final subTexts = [
      'Yalnız değilsin.',
      'Evren bu mesajı seçilmiş olanlara gönderiyor.',
      'Bazı şeyler tesadüf değil.',
      'Aynı gökyüzünün altında, aynı hislerle.',
      'Bu farkındalık nadir ve değerli.',
    ];

    return CollectiveMoment(
      mainText: mainTexts[_random.nextInt(mainTexts.length)],
      subText: subTexts[_random.nextInt(subTexts.length)],
    );
  }

  static SoftPremiumCuriosity _generatePremiumCuriosity(ZodiacSign sign) {
    final curiosityTexts = [
      'Bu, bugünün sadece bir katmanı.',
      'Bazı kalıplar yüzeyde görünmez.',
      'Her güne ait bir de gizli hikaye var.',
      'Derinlerde daha fazlası saklı.',
      'Bu mesaj bir kapı — gerisinde neler olduğunu merak ediyorsan...',
    ];

    final invitationTexts = [
      'Bazıları bu kalıbı daha derinden keşfetmeyi seçiyor.',
      'Merak edenler için her zaman bir sonraki katman var.',
      'Belki bir gün bu hikayenin tamamını görmek istersin.',
      'Evrenin sana söyleyecek daha çok şeyi var.',
      'İstersen, bu sadece başlangıç olabilir.',
    ];

    return SoftPremiumCuriosity(
      curiosityText: curiosityTexts[_random.nextInt(curiosityTexts.length)],
      invitationText: invitationTexts[_random.nextInt(invitationTexts.length)],
    );
  }

  static List<String> _generateMicroMessages(ZodiacSign sign) {
    final allMicroMessages =
        _microMessagesBySign[sign] ?? _defaultMicroMessages;
    final shuffled = List<String>.from(allMicroMessages)..shuffle(_random);
    return shuffled.take(3).toList();
  }

  static const Map<ZodiacSign, List<String>> _microMessagesBySign = {
    ZodiacSign.aries: [
      'Sessizliğin bugün kelimelerinden daha çok iş görüyor.',
      'Herkes enerjine erişmeyi hak etmiyor.',
      'Sabır bugün en keskin silahın.',
      'Yavaşlamak geri kalmak değil.',
      'Güç göstermeye gerek yok — sen zaten görünüyorsun.',
    ],
    ZodiacSign.taurus: [
      'Tutunduğun şey seni mi taşıyor, yoksa sen mi onu?',
      'Konfor alanın güzel ama hapishane olmasın.',
      'Bırakmak bazen en büyük sahiplenme.',
      'Değişim düşman değil — davet.',
      'Köklerin sağlam. Dalların da büyüsün.',
    ],
    ZodiacSign.gemini: [
      'Her düşünceni takip etmek zorunda değilsin.',
      'Sessizlik de bir cevap.',
      'İki yüzün var — ikisi de sensin.',
      'Derinlik genişlikten değerli bazen.',
      'Çelişkilerin seni zenginleştiriyor.',
    ],
    ZodiacSign.cancer: [
      'Kırılganlık zayıflık değil.',
      'Korumak sevmek değil, boğmak olabilir.',
      'Geçmiş öğretmen, ev değil.',
      'Duvarların seni koruyor mu, hapsediyor mu?',
      'Sevilmek için mükemmel olmana gerek yok.',
    ],
    ZodiacSign.leo: [
      'Alkış olmadan da değerlisin.',
      'Görünmez olduğunda kim oluyorsun?',
      'Işığın başkalarını söndürmesin.',
      'Krallık hizmetle kazanılır.',
      'Sen zaten ışıksın — güneş olmak zorunda değilsin.',
    ],
    ZodiacSign.virgo: [
      'Kusursuz değil, gerçek ol.',
      '"Yeterince iyi" bazen mükemmel.',
      'Yardım istemek zayıflık değil.',
      'Eleştiri önce kendine, sonra başkalarına.',
      'Detaylarda kaybolma — büyük resmi gör.',
    ],
    ZodiacSign.libra: [
      'Hayır demek de sevgi.',
      'Herkesin mutluluğu senin sorumluluğun değil.',
      'Dengeyi kendinde bul, dışarıda arama.',
      'Çatışma büyüme fırsatı.',
      'Kararsızlık da bir karar.',
    ],
    ZodiacSign.scorpio: [
      'Kontrol illüzyon.',
      'Her şeyi bilmek zorunda değilsin.',
      'Güvenmek risk değil, hediye.',
      'Derinlik güzel — ama yüzeyde de yaşam var.',
      'Affetmek seni özgürleştirir.',
    ],
    ZodiacSign.sagittarius: [
      'Kaçış çözüm değil.',
      'Cevap burada da olabilir.',
      'Bağlanmak hapsolmak değil.',
      'Macera içeride de var.',
      'Vaat etme, yap.',
    ],
    ZodiacSign.capricorn: [
      'Başarı mutluluk garantisi değil.',
      'Mola vermek vazgeçmek değil.',
      'Duyguların da saygıyı hak ediyor.',
      'Zirve değil, yolculuk önemli.',
      'Çalışmak kaçış olmasın.',
    ],
    ZodiacSign.aquarius: [
      'Farklı olmak için farklı olma.',
      'Herkes anlamak zorunda değil.',
      'Kalp de akıl kadar önemli.',
      'Devrim önce kendinde.',
      'Bağımsızlık yalnızlık değil.',
    ],
    ZodiacSign.pisces: [
      'Rüya güzel — gerçeklik de.',
      'Herkesin acısını taşımak zorunda değilsin.',
      'Sınırlar sevgisizlik değil.',
      'Hayal kurmak eylem değil.',
      'Kaçış değil, yüzleş.',
    ],
  };

  static const _defaultMicroMessages = [
    'Bugün kendine nazik ol.',
    'Sezgilerine güven.',
    'Cevap zaten içinde.',
  ];

  // Helper methods
  static String _formatTurkishDate(DateTime date) {
    final months = [
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
    final days = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year} · ${days[date.weekday - 1]}';
  }

  static String _getMoonPhaseText(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon:
        return 'Yeni Ay — Başlangıçların zamanı';
      case MoonPhase.waxingCrescent:
        return 'Hilal Ay — Niyetler filizleniyor';
      case MoonPhase.firstQuarter:
        return 'İlk Dördün — Karar zamanı';
      case MoonPhase.waxingGibbous:
        return 'Şişkin Ay — Momentum artıyor';
      case MoonPhase.fullMoon:
        return 'Dolunay — Aydınlanma ve tamamlanma';
      case MoonPhase.waningGibbous:
        return 'Küçülen Ay — Minnettarlık zamanı';
      case MoonPhase.lastQuarter:
        return 'Son Dördün — Bırakma zamanı';
      case MoonPhase.waningCrescent:
        return 'Balzamik Ay — Dinlenme ve hazırlık';
    }
  }

  static String _getMoonPhaseEmoji(MoonPhase phase) {
    switch (phase) {
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

  static String _getEmotionalCore(ZodiacSign sign) {
    final cores = {
      ZodiacSign.aries: 'Cesaretinin kaynağı',
      ZodiacSign.taurus: 'Huzurunun temeli',
      ZodiacSign.gemini: 'Merakının kıvılcımı',
      ZodiacSign.cancer: 'Duygularının derinliği',
      ZodiacSign.leo: 'Işığının merkezi',
      ZodiacSign.virgo: 'Mükemmellik arayışın',
      ZodiacSign.libra: 'Uyumun özü',
      ZodiacSign.scorpio: 'Dönüşüm gücün',
      ZodiacSign.sagittarius: 'Özgürlük tutkun',
      ZodiacSign.capricorn: 'Azmin kaynağı',
      ZodiacSign.aquarius: 'Farklılığının değeri',
      ZodiacSign.pisces: 'Sezgilerinin sesi',
    };
    return cores[sign] ?? 'Ruhunun özü';
  }

  static String _getEnergyDescription(int level) {
    if (level >= 80) return 'Kozmik enerjin dorukta. Her şey mümkün.';
    if (level >= 60) return 'Güçlü bir akış var. Fırsatları yakala.';
    if (level >= 40) return 'Dengeli enerji. Sabırlı ol.';
    if (level >= 20) return 'Dinlenme zamanı. Kendine nazik ol.';
    return 'İçe dönük enerji. Şarj ol.';
  }

  static String _getIntensityDescription(String intensity) {
    switch (intensity) {
      case 'Sakin':
        return 'Duygular kontrol altında. Net düşünme zamanı.';
      case 'Yükselen':
        return 'Duygular yüzeye çıkıyor. Farkındalık gerekli.';
      case 'Yoğun':
        return 'Güçlü hisler akıyor. Tepkilere dikkat.';
      case 'Fırtınalı':
        return 'Duygusal dalgalanma. Merkeze dön.';
      default:
        return 'Duygusal akış devam ediyor.';
    }
  }

  static String _getIntuitionDescription(int level) {
    if (level >= 80) return 'Üçüncü gözün açık. İlk hissine güven.';
    if (level >= 60) return 'Sezgilerin güçlü. İç sesin dinle.';
    if (level >= 40) return 'Sezgi ve mantık dengede.';
    if (level >= 20) return 'Bugün mantığa yaslan.';
    return 'Analitik düşünme zamanı.';
  }

  static List<Planet> _getDominantPlanets(ZodiacSign sign, DateTime today) {
    // Simplified - would normally use ephemeris
    final rulers = {
      ZodiacSign.aries: Planet.mars,
      ZodiacSign.taurus: Planet.venus,
      ZodiacSign.gemini: Planet.mercury,
      ZodiacSign.cancer: Planet.moon,
      ZodiacSign.leo: Planet.sun,
      ZodiacSign.virgo: Planet.mercury,
      ZodiacSign.libra: Planet.venus,
      ZodiacSign.scorpio: Planet.mars,
      ZodiacSign.sagittarius: Planet.jupiter,
      ZodiacSign.capricorn: Planet.saturn,
      ZodiacSign.aquarius: Planet.saturn,
      ZodiacSign.pisces: Planet.jupiter,
    };
    return [rulers[sign] ?? Planet.sun];
  }

  static String _getPlanetSymbol(Planet planet) {
    switch (planet) {
      case Planet.sun:
        return '☉';
      case Planet.moon:
        return '☽';
      case Planet.mercury:
        return '☿';
      case Planet.venus:
        return '♀';
      case Planet.mars:
        return '♂';
      case Planet.jupiter:
        return '♃';
      case Planet.saturn:
        return '♄';
      default:
        return '✧';
    }
  }

  static ZodiacSign _getCompatibleSign(ZodiacSign sign) {
    final compatible = {
      ZodiacSign.aries: ZodiacSign.leo,
      ZodiacSign.taurus: ZodiacSign.virgo,
      ZodiacSign.gemini: ZodiacSign.libra,
      ZodiacSign.cancer: ZodiacSign.scorpio,
      ZodiacSign.leo: ZodiacSign.sagittarius,
      ZodiacSign.virgo: ZodiacSign.capricorn,
      ZodiacSign.libra: ZodiacSign.aquarius,
      ZodiacSign.scorpio: ZodiacSign.pisces,
      ZodiacSign.sagittarius: ZodiacSign.aries,
      ZodiacSign.capricorn: ZodiacSign.taurus,
      ZodiacSign.aquarius: ZodiacSign.gemini,
      ZodiacSign.pisces: ZodiacSign.cancer,
    };
    return compatible[sign] ?? ZodiacSign.aries;
  }

  // Static data maps
  static const Map<ZodiacSign, List<String>> _heroHeadlines = {
    ZodiacSign.aries: [
      'Bugün cesaretin test ediliyor.',
      'Ateşin içinden geçme zamanı.',
      'Liderlik sende. Harekete geç.',
    ],
    ZodiacSign.taurus: [
      'Köklerin seni taşıyor.',
      'Sabır bugün en büyük gücün.',
      'Değerini bil, taviz verme.',
    ],
    ZodiacSign.gemini: [
      'İki dünya arasında dans ediyorsun.',
      'Kelimeler bugün silahın.',
      'Merakın kapıları açıyor.',
    ],
    ZodiacSign.cancer: [
      'Ay seninle konuşuyor.',
      'Duygularının derinliğinde cevap var.',
      'Koruyucu kabuğun altında güç saklı.',
    ],
    ZodiacSign.leo: [
      'Güneş senin için doğuyor.',
      'Işığın karanlığı yırtıyor.',
      'Kral/Kraliçe, tahtın hazır.',
    ],
    ZodiacSign.virgo: [
      'Detaylarda evren gizli.',
      'Mükemmellik değil, anlam ara.',
      'Şifa veren ellerin var.',
    ],
    ZodiacSign.libra: [
      'Denge noktasındasın.',
      'Güzellik ve adalet senin silahın.',
      'İlişkilerde dönüşüm zamanı.',
    ],
    ZodiacSign.scorpio: [
      'Karanlıktan korkmuyorsun.',
      'Dönüşüm kapıda. Hazır mısın?',
      'Derinliklerde hazine var.',
    ],
    ZodiacSign.sagittarius: [
      'Ufuk seni çağırıyor.',
      'Ok yaydan çıkmak üzere.',
      'Özgürlük senin doğum hakkın.',
    ],
    ZodiacSign.capricorn: [
      'Zirve görüş mesafesinde.',
      'Disiplin bugün süper gücün.',
      'Zamanın ustası sensin.',
    ],
    ZodiacSign.aquarius: [
      'Geleceği sen yazıyorsun.',
      'Farklılığın senin armağanın.',
      'Devrim içinden başlıyor.',
    ],
    ZodiacSign.pisces: [
      'Rüyalar gerçeğe dönüşüyor.',
      'Sezgilerin hiç bu kadar keskin olmamıştı.',
      'Okyanus derinliğinde yüzüyorsun.',
    ],
  };

  static const _defaultHeroHeadlines = [
    'Evren bugün seninle konuşuyor.',
    'Yıldızlar senin için hizalandı.',
  ];

  static const Map<ZodiacSign, List<String>> _personalMessages = {
    ZodiacSign.aries: [
      'İçindeki ateş bugün farklı yanıyor. Belki de savaşman gereken şey dışarıda değil, kendi içinde. O sabırsızlık, o hemen şimdi isteği — dur bir an. Gerçek cesaret bazen beklemektir. Bugün acele etme, ama hareketsiz de kalma. Ortada bir yol var ve sen onu bulacaksın.',
      'Herkes senin gücünü görüyor ama kimse yorgunluğunu bilmiyor. Bugün kendine şunu sor: Kimin için savaşıyorum? Cevap "kendim için" değilse, strateji değiştirme zamanı. Enerjin sınırsız değil, onu doğru yere yatır.',
    ],
    ZodiacSign.taurus: [
      'Konfor alanın güzel ama hapishaneye dönüşmesin. Bugün bir şeyi bırakman gerekebilir — bir alışkanlık, bir düşünce, belki de bir kişi. Köklerin sağlam, ama dalların da büyümesi gerek. Değişim düşman değil, davetiye.',
      'Sahip olduklarına sıkı sıkı tutunuyorsun ama soruyorum: Onlar seni mi tanımlıyor? Bugün "yeterince" kelimesini hatırla. Sen zaten bütünsün. Dış dünya bunu onaylamasa bile.',
    ],
    ZodiacSign.gemini: [
      'Zihnin bugün 100 farklı yöne koşuyor. Hepsi ilginç, hepsi parlak — ama hangisi gerçek? O gürültünün altında sessiz bir ses var. Bugün onu duy. Cevap dışarıda değil, tüm o düşüncelerin arasında saklı.',
      'İki yüzün var diyorlar ama ikisi de sensin. Bugün birini seçmek zorunda değilsin. Çelişkilerin seni zayıflatmıyor, zenginleştiriyor. O "ama"ları kucakla.',
    ],
    ZodiacSign.cancer: [
      'Duygularını korumak için ördüğün duvarlar seni koruyor ama aynı zamanda yalnızlaştırıyor. Bugün bir kapı aç — küçük olsun, ama aç. Kırılganlık zayıflık değil, en saf güç. Sevilmek için mükemmel olmana gerek yok.',
      'Geçmiş bugün kapını çalacak. Bir anı, bir koku, bir şarkı. Ona sarılabilirsin ama orada kalma. Ayların döngüsü gibi sen de değişiyorsun. Eskiyi onurlandır, ama bugünü yaşa.',
    ],
    ZodiacSign.leo: [
      'Herkes seni sahne ışıklarında görüyor ama kimse kulis arkasını bilmiyor. O alkışlar güzel, ama sen onlarsız da değerlisin. Bugün kendine sor: Parladığımda mı seviliyorum, yoksa sadece ben olduğumda mı? Cevap seni özgürleştirecek.',
      'Krallık yorucu. Taç ağır. Bugün onu indir, sadece sen ol. Güneş olmak zorunda değilsin — sen zaten ışıksın. Başkalarının gözlerinde kendini aramayı bırak.',
    ],
    ZodiacSign.virgo: [
      'Mükemmellik peşinde koşarken kaçırdıklarını gördün mü? Bugün kusurlarına bak — orada güzellik var. Detaylara takılma, büyük resmi gör. Bazen "yeterince iyi" aslında mükemmeldir.',
      'Herkese yardım ediyorsun ama sana kim yardım ediyor? Bugün almayı öğren. Vermek kolay, kabul etmek cesaret ister. Sen de bakılmayı hak ediyorsun.',
    ],
    ZodiacSign.libra: [
      'Dengeyi ararken kendi ağırlığını unuttun mu? Bugün tarafa geç — sadece bugünlük. Herkesi memnun etmek zorunda değilsin. Senin "hayır"ın da güzel bir kelime.',
      'Aynaya bak. Gördüğün kişi başkalarının istediği sen mi, yoksa gerçek sen mi? Bugün maskeleri indir. Çirkin görüneceğinden korkma — gerçeklik her zaman güzeldir.',
    ],
    ZodiacSign.scorpio: [
      'Derinlere dalıyorsun yine. Karanlık seni korkutmuyor, biliyorum. Ama bugün ışığa da izin ver. Her sır çözülmek zorunda değil. Bazı gizemler bırakıldığında anlam kazanır.',
      'Kontrol ihtiyacın seni tüketiyor. Bugün bir şeyi akışa bırak. Evren senin yerine çalışsın biraz. Güvenmek zayıflık değil, en büyük dönüşüm.',
    ],
    ZodiacSign.sagittarius: [
      'Ufuk güzel ama ayaklarının altındaki toprağı da gör. Bugün kaçmak yerine kal. Cevap uzaklarda değil, tam burada olabilir. Macera bazen bir adım geri atmaktır.',
      'Özgürlük adına ne feda ettin? Bağlar hapishane değil — doğru olanlar kanat olur. Bugün "bağlanmak"tan korkma. Sevgi de bir macera.',
    ],
    ZodiacSign.capricorn: [
      'Zirveye tırmanırken manzarayı gördün mü? Dur bir an. Başarı listeleri değil, anılar bırakır. Bugün hedefleri unut, anı yaşa. Disiplin ara verince çökmez, nefes alır.',
      'Güçlü olmak zorunda değilsin. Her zaman değil. Bugün zırhı indir, kırılganlığını göster. Saygı değil, sevgi kazanacaksın.',
    ],
    ZodiacSign.aquarius: [
      'Herkesten farklısın ve bu yorucu olabiliyor. Bugün anlaşılmak için değiştirme kendini. Evren seni böyle yarattı — orijinal. Kalabalıkta yalnız hissetmek, yanlış kalabalıkta olmak demek.',
      'Geleceği düşünürken bugünü kaçırma. Devrimler büyük patlamalarla değil, küçük kararlarla başlar. Bugün küçük bir şey değiştir — kendinde.',
    ],
    ZodiacSign.pisces: [
      'Rüyalar ve gerçeklik arasında yüzüyorsun. Bugün ayaklarını yere bas — sadece bir an için. Hayal kurmak güzel ama yaşamak da öyle. Sezgilerin seni doğru yere götürüyor, güven.',
      'Herkesin acısını hissediyorsun ama seninki nerede? Bugün empati sınırlarını çiz. Başkalarını kurtarmak için önce sen sağlam olmalısın. Kendi okyanusunda boğulma.',
    ],
  };

  static const _defaultPersonalMessages = [
    'Bugün evren sana özel bir mesaj gönderiyor. Dinle.',
  ];

  static const Map<ZodiacSign, String> _risingInfluence = {
    ZodiacSign.aries: 'Yükselen Koç etkisi seni daha cesur kılıyor.',
    ZodiacSign.taurus: 'Yükselen Boğa sana istikrar getiriyor.',
    ZodiacSign.gemini: 'Yükselen İkizler iletişimini güçlendiriyor.',
    ZodiacSign.cancer: 'Yükselen Yengeç sezgilerini keskinleştiriyor.',
    ZodiacSign.leo: 'Yükselen Aslan karizmana katkı sağlıyor.',
    ZodiacSign.virgo: 'Yükselen Başak detaylara dikkatini artırıyor.',
    ZodiacSign.libra: 'Yükselen Terazi dengeleme yeteneğini güçlendiriyor.',
    ZodiacSign.scorpio: 'Yükselen Akrep derinliğini artırıyor.',
    ZodiacSign.sagittarius: 'Yükselen Yay iyimserliğini besliyor.',
    ZodiacSign.capricorn: 'Yükselen Oğlak kararlılığını pekiştiriyor.',
    ZodiacSign.aquarius: 'Yükselen Kova özgünlüğünü öne çıkarıyor.',
    ZodiacSign.pisces: 'Yükselen Balık empati gücünü artırıyor.',
  };

  static const Map<ZodiacSign, String> _moonInfluence = {
    ZodiacSign.aries: 'Ay\'ın Koç\'ta olması duygularını ateşliyor.',
    ZodiacSign.taurus: 'Ay\'ın Boğa\'da olması seni topraklıyor.',
    ZodiacSign.gemini: 'Ay\'ın İkizler\'de olması zihnini hareketlendiriyor.',
    ZodiacSign.cancer: 'Ay\'ın Yengeç\'te olması duygusal derinlik katıyor.',
    ZodiacSign.leo: 'Ay\'ın Aslan\'da olması özgüvenini artırıyor.',
    ZodiacSign.virgo: 'Ay\'ın Başak\'ta olması pratikliğini güçlendiriyor.',
    ZodiacSign.libra:
        'Ay\'ın Terazi\'de olması ilişkilere odaklanmanı sağlıyor.',
    ZodiacSign.scorpio: 'Ay\'ın Akrep\'te olması yoğunluğunu artırıyor.',
    ZodiacSign.sagittarius:
        'Ay\'ın Yay\'da olması macera ruhunu canlandırıyor.',
    ZodiacSign.capricorn: 'Ay\'ın Oğlak\'ta olması disiplinini güçlendiriyor.',
    ZodiacSign.aquarius:
        'Ay\'ın Kova\'da olması yenilikçiliğini öne çıkarıyor.',
    ZodiacSign.pisces: 'Ay\'ın Balık\'ta olması sezgilerini zirveye taşıyor.',
  };

  static final Map<Planet, PlanetInfluenceData> _planetInfluenceData = {
    Planet.sun: PlanetInfluenceData(
      activates: 'Özgüvenini ve yaşam enerjini',
      blocks: 'Gölgede kalmayı ve küçümsenmeyi',
      action: 'Bugün görünür ol. Işığını saklamanın zamanı değil.',
    ),
    Planet.moon: PlanetInfluenceData(
      activates: 'Sezgilerini ve duygusal zekânı',
      blocks: 'Mantıksal aşırılığı ve duygusal kaçınmayı',
      action: 'Bir duyguyu bastırmak yerine, onu dinle.',
    ),
    Planet.mercury: PlanetInfluenceData(
      activates: 'İletişim gücünü ve zihinsel netliği',
      blocks: 'Sessizliği ve yanlış anlaşılmayı',
      action: 'Söylemen gereken bir şey var. Bugün söyle.',
    ),
    Planet.venus: PlanetInfluenceData(
      activates: 'Çekiciliğini ve ilişki enerjini',
      blocks: 'Yalnızlığı ve özdeğer eksikliğini',
      action: 'Kendine güzel bir şey yap. Hak ediyorsun.',
    ),
    Planet.mars: PlanetInfluenceData(
      activates: 'Savaşçı ruhunu ve harekete geçme gücünü',
      blocks: 'Pasifliği ve ertelemeyi',
      action: 'Bir konuda adım at. Düşünme, yap.',
    ),
    Planet.jupiter: PlanetInfluenceData(
      activates: 'Bolluğu ve genişleme enerjini',
      blocks: 'Kısıtlayıcı düşünceleri ve küçük oynamayı',
      action: 'Bugün büyük düşün. Evren seni destekliyor.',
    ),
    Planet.saturn: PlanetInfluenceData(
      activates: 'Disiplinini ve uzun vadeli vizyonunu',
      blocks: 'Kısa yolları ve sorumsuzluğu',
      action: 'Zor ama doğru olanı seç.',
    ),
  };

  static final Map<ZodiacSign, ShadowData> _shadowData = {
    ZodiacSign.aries: ShadowData(
      challenge: 'Sabırsızlık seni yanlış kararlara itiyor.',
      fear: 'Yetersiz görünme korkusu',
      pattern: 'Düşünmeden atılma, sonra pişmanlık.',
    ),
    ZodiacSign.taurus: ShadowData(
      challenge: 'İnatçılık fırsatları kaçırıyor.',
      fear: 'Kontrol kaybı ve güvensizlik',
      pattern: 'Değişime direnme, sonra zorla uyum.',
    ),
    ZodiacSign.gemini: ShadowData(
      challenge: 'Dağınıklık odaklanmayı engelliyor.',
      fear: 'Sıkışmak ve sıkılmak',
      pattern: 'Her şeye başla, hiçbirini bitirme.',
    ),
    ZodiacSign.cancer: ShadowData(
      challenge: 'Aşırı duygusallık kararları bulandırıyor.',
      fear: 'Reddedilme ve terk edilme',
      pattern: 'Savunmaya geçme, duvarları yükseltme.',
    ),
    ZodiacSign.leo: ShadowData(
      challenge: 'Ego başkalarını uzaklaştırıyor.',
      fear: 'Görünmez ve önemsiz hissetmek',
      pattern: 'Onay arayışı, sonra hayal kırıklığı.',
    ),
    ZodiacSign.virgo: ShadowData(
      challenge: 'Mükemmeliyetçilik felç ediyor.',
      fear: 'Eleştiri ve hata yapma',
      pattern: 'Aşırı analiz, sonra hareketsizlik.',
    ),
    ZodiacSign.libra: ShadowData(
      challenge: 'Kararsızlık zamanı çalıyor.',
      fear: 'Çatışma ve sevilmemek',
      pattern: 'Herkesi memnun etmeye çalış, kendini kaybet.',
    ),
    ZodiacSign.scorpio: ShadowData(
      challenge: 'Kontrol ihtiyacı ilişkileri zehirliyor.',
      fear: 'İhanet ve güç kaybı',
      pattern: 'Test etme, sonra kendini gerçekleştiren kehanet.',
    ),
    ZodiacSign.sagittarius: ShadowData(
      challenge: 'Kaçış eğilimi sorunları büyütüyor.',
      fear: 'Bağlanmak ve sınırlanmak',
      pattern: 'Zor olunca git, sonra pişmanlık.',
    ),
    ZodiacSign.capricorn: ShadowData(
      challenge: 'İş bağımlılığı ilişkileri ihmal ediyor.',
      fear: 'Başarısızlık ve statü kaybı',
      pattern: 'Hissetmekten kaç, işe gömül.',
    ),
    ZodiacSign.aquarius: ShadowData(
      challenge: 'Duygusal mesafe yalnızlaştırıyor.',
      fear: 'Sıradanlık ve uyum baskısı',
      pattern: 'Farklı olmak için farklı ol, özü kaybet.',
    ),
    ZodiacSign.pisces: ShadowData(
      challenge: 'Kaçış mekanizmaları gerçeklikten koparıyor.',
      fear: 'Acı ve hayal kırıklığı',
      pattern: 'Hayal kur, sonra gerçeklikle çarpış.',
    ),
  };

  static const _defaultShadowData = ShadowData(
    challenge: 'İç çatışmalar netliği engelliyor.',
    fear: 'Bilinmeyenden korku',
    pattern: 'Tekrarlayan döngüler.',
  );

  static final Map<ZodiacSign, LightData> _lightData = {
    ZodiacSign.aries: LightData(
      strength: 'Cesaret ve öncülük',
      opportunity: 'Yeni bir başlangıç için ideal gün',
      magnetic: 'Enerjin bulaşıcı, insanlar sana çekiliyor.',
    ),
    ZodiacSign.taurus: LightData(
      strength: 'Sadakat ve güvenilirlik',
      opportunity: 'Değerlerini netleştirme zamanı',
      magnetic: 'Sakinliğin güven veriyor, insanlar yanında huzur buluyor.',
    ),
    ZodiacSign.gemini: LightData(
      strength: 'Uyum sağlama ve iletişim',
      opportunity: 'Önemli bir konuşma için açıklık',
      magnetic: 'Zekan parıldıyor, fikirlerin ilgi çekiyor.',
    ),
    ZodiacSign.cancer: LightData(
      strength: 'Empati ve koruyuculuk',
      opportunity: 'Duygusal bağları derinleştirme',
      magnetic: 'Sıcaklığın eve benziyorsun, insanlar sana açılıyor.',
    ),
    ZodiacSign.leo: LightData(
      strength: 'Yaratıcılık ve cömertlik',
      opportunity: 'Kendini ifade etme cesareti',
      magnetic: 'Varlığın ışık saçıyor, gözler sende.',
    ),
    ZodiacSign.virgo: LightData(
      strength: 'Analiz gücü ve hizmet kalbi',
      opportunity: 'Bir sorunu çözme yeteneği dorukta',
      magnetic: 'Yetkinliğin güven veriyor, danışman gibisin.',
    ),
    ZodiacSign.libra: LightData(
      strength: 'Diplomasi ve estetik',
      opportunity: 'Çatışmaları çözme gücü',
      magnetic: 'Zarafetin büyülüyor, herkes seninle olmak istiyor.',
    ),
    ZodiacSign.scorpio: LightData(
      strength: 'Derinlik ve dönüşüm gücü',
      opportunity: 'Eski bir yaraya şifa getirme',
      magnetic: 'Gizem çekici, insanlar seni çözmek istiyor.',
    ),
    ZodiacSign.sagittarius: LightData(
      strength: 'İyimserlik ve vizyon',
      opportunity: 'Yeni ufuklar açılıyor',
      magnetic: 'Macera ruhun bulaşıcı, heyecan veriyorsun.',
    ),
    ZodiacSign.capricorn: LightData(
      strength: 'Disiplin ve dayanıklılık',
      opportunity: 'Uzun vadeli bir adım için netlik',
      magnetic: 'Otoriten saygı uyandırıyor, sözün dinleniyor.',
    ),
    ZodiacSign.aquarius: LightData(
      strength: 'Özgünlük ve insancıllık',
      opportunity: 'Farklı bir bakış açısı sunma',
      magnetic: 'Benzersizliğin çekiyor, ilham kaynağısın.',
    ),
    ZodiacSign.pisces: LightData(
      strength: 'Sezgi ve yaratıcı hayal gücü',
      opportunity: 'Sanatsal veya ruhsal bir açılım',
      magnetic: 'Gizemli auran büyülüyor, rüya gibisin.',
    ),
  };

  static const _defaultLightData = LightData(
    strength: 'İçsel güç ve potansiyel',
    opportunity: 'Yeni fırsatlar beliriyor',
    magnetic: 'Enerjin insanları çekiyor.',
  );

  static final Map<ZodiacSign, List<String>> _cosmicAdvice = {
    ZodiacSign.aries: [
      'Dur. Nefes al. Sonra hareket et.',
      'Öfken mesajcı, ama sen karar vericisin.',
      'Savaş kazanmak değil, barış kurmak için de cesaret gerek.',
      'İlk olmak değil, doğru olmak önemli.',
      'Güç gösterisine gerek yok, sen zaten güçlüsün.',
    ],
    ZodiacSign.taurus: [
      'Bırakmak kaybetmek değil.',
      'Konfor alanın güvenli ama büyüme orada yok.',
      'Sahip oldukların seni tanımlamıyor.',
      'Yavaş ol ama durma.',
      'Değer gördüğün yerde kal, görmediğin yerde kalma.',
    ],
    ZodiacSign.gemini: [
      'Her düşünceyi takip etmek zorunda değilsin.',
      'Sessizlik de bir cevap.',
      'Derinlik, genişlikten daha değerli bazen.',
      'İki yol arasında kalmak da bir yol.',
      'Dinlemek de iletişim.',
    ],
    ZodiacSign.cancer: [
      'Korumak sevmek değil, boğmak olabilir.',
      'Geçmiş öğretmen, ev değil.',
      'Duvarların seni koruyor mu, hapsediyor mu?',
      'Kırılganlık güçsüzlük değil.',
      'Bazen en iyi bakım, bırakmak.',
    ],
    ZodiacSign.leo: [
      'Işığın başkalarını söndürmesin.',
      'Alkış olmadan da değerlisin.',
      'Krallık hizmetle kazanılır.',
      'Gurur koruyucu değil, hapishane olabilir.',
      'Görünmez olduğunda kim oluyorsun?',
    ],
    ZodiacSign.virgo: [
      'Kusursuz değil, gerçek ol.',
      'Eleştiri önce kendine, sonra başkalarına.',
      '"Yeterince iyi" bazen mükemmel.',
      'Yardım istemek zayıflık değil.',
      'Analiz felç ederse, hisset.',
    ],
    ZodiacSign.libra: [
      'Hayır demek de sevgi.',
      'Dengeyi kendinde bul, dışarıda arama.',
      'Çatışma büyüme fırsatı.',
      'Herkesin mutluluğu senin sorumluluğun değil.',
      'Kararsızlık da bir karar.',
    ],
    ZodiacSign.scorpio: [
      'Kontrol illüzyon.',
      'Güvenmek risk değil, hediye.',
      'Her şeyi bilmek zorunda değilsin.',
      'İntikam seni zehirler, affetmek özgürleştirir.',
      'Derinlik güzel, ama yüzeyde de yaşam var.',
    ],
    ZodiacSign.sagittarius: [
      'Kaçış çözüm değil.',
      'Bağlanmak hapsolmak değil.',
      'Cevap burada da olabilir.',
      'Vaat etme, yap.',
      'Macera içeride de var.',
    ],
    ZodiacSign.capricorn: [
      'Başarı mutluluk garantisi değil.',
      'Çalışmak kaçış olmasın.',
      'Zirve değil, yolculuk önemli.',
      'Duyguların da saygıyı hak ediyor.',
      'Mola vermek vazgeçmek değil.',
    ],
    ZodiacSign.aquarius: [
      'Farklı olmak için farklı olma.',
      'Bağımsızlık yalnızlık değil.',
      'Kalp de akıl kadar önemli.',
      'Herkes anlamak zorunda değil.',
      'Devrim önce kendinde.',
    ],
    ZodiacSign.pisces: [
      'Rüya güzel, gerçeklik de.',
      'Herkesin acısını taşımak zorunda değilsin.',
      'Sınırlar sevgisizlik değil.',
      'Kaçış değil, yüzleş.',
      'Hayal kurmak eylem değil.',
    ],
  };

  static const _defaultCosmicAdvice = [
    'Kendine nazik ol.',
    'Bugün sabır gerekiyor.',
    'Sezgilerine güven.',
  ];

  static final Map<ZodiacSign, List<SymbolicMessage>> _archetypes = {
    ZodiacSign.aries: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Savaşçı',
        title: 'İçindeki Savaşçı',
        meaning:
            'Bugün savaşçı arketipi aktif. Ama gerçek savaşçı bilir: En büyük zafer kendini fethetmektir.',
        imageHint: 'aries_warrior',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'İmparator',
        title: 'IV - İmparator',
        meaning:
            'Yapı, otorite ve kontrol. Bugün liderlik enerjin güçlü. Ama dikkat: Güç sorumluluk getirir.',
        imageHint: 'emperor',
      ),
    ],
    ZodiacSign.taurus: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Bahçıvan',
        title: 'Sabırlı Bahçıvan',
        meaning:
            'Tohumlar zamanla meyve verir. Bugün sabırla ektiğin şeylerin yeşerdiğini göreceksin.',
        imageHint: 'taurus_gardener',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'İmparatoriçe',
        title: 'III - İmparatoriçe',
        meaning:
            'Bereket, duyusallık ve yaratıcılık. Hayatın güzelliklerini hissetme zamanı.',
        imageHint: 'empress',
      ),
    ],
    ZodiacSign.gemini: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Elçi',
        title: 'Tanrıların Elçisi',
        meaning:
            'Hermes gibi sen de dünyalar arasında köprü kuruyorsun. Sözlerin bugün güç taşıyor.',
        imageHint: 'gemini_messenger',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Aşıklar',
        title: 'VI - Aşıklar',
        meaning:
            'Seçimler ve bağlantılar. İki yol arasında değil, ikisini birleştirme zamanı.',
        imageHint: 'lovers',
      ),
    ],
    ZodiacSign.cancer: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Anne',
        title: 'Büyük Anne',
        meaning:
            'Besleyen, koruyan, sarmalayan. Bugün hem başkalarına hem kendine annelik et.',
        imageHint: 'cancer_mother',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Ay',
        title: 'XVIII - Ay',
        meaning:
            'Bilinçaltı, sezgiler ve gizli korkular. Karanlıkta da yol bulabilirsin.',
        imageHint: 'moon',
      ),
    ],
    ZodiacSign.leo: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Kral',
        title: 'Adil Kral',
        meaning:
            'Gerçek kral tahtı değil, kalpleri yönetir. Bugün cömertliğinle hükmet.',
        imageHint: 'leo_king',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Güç',
        title: 'VIII - Güç',
        meaning:
            'İç aslanını evcilleştirme. Güç kontrolde değil, yumuşaklıkta.',
        imageHint: 'strength',
      ),
    ],
    ZodiacSign.virgo: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Şifacı',
        title: 'Kutsal Şifacı',
        meaning:
            'Ellerin şifa taşıyor. Bugün dokunduğun her şeyi iyileştirme potansiyelin var.',
        imageHint: 'virgo_healer',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Ermiş',
        title: 'IX - Ermiş',
        meaning: 'İç arayış ve bilgelik. Cevaplar dışarıda değil, derinlerde.',
        imageHint: 'hermit',
      ),
    ],
    ZodiacSign.libra: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Diplomat',
        title: 'Barış Elçisi',
        meaning: 'Köprüler kuran, yaralar saran. Bugün uyumu sen getireceksin.',
        imageHint: 'libra_diplomat',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Adalet',
        title: 'XI - Adalet',
        meaning:
            'Denge, doğruluk ve kararlar. Terazi dengede — şimdi seçim zamanı.',
        imageHint: 'justice',
      ),
    ],
    ZodiacSign.scorpio: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Simyacı',
        title: 'Karanlık Simyacı',
        meaning:
            'Kurşunu altına çevirirsin. Acıyı bilgeliğe, kaybı kazanca dönüştürme gücün var.',
        imageHint: 'scorpio_alchemist',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Ölüm',
        title: 'XIII - Ölüm',
        meaning:
            'Dönüşüm ve yeniden doğuş. Bitişler, başlangıçların kapısıdır.',
        imageHint: 'death',
      ),
    ],
    ZodiacSign.sagittarius: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Kaşif',
        title: 'Ufuk Kaşifi',
        meaning:
            'Bilinmeyen seni çağırıyor. Bugün sınırları aşma cesareti içinde.',
        imageHint: 'sagittarius_explorer',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Ölçülülük',
        title: 'XIV - Ölçülülük',
        meaning: 'Denge ve sabır. Uçlar arasında orta yolu bul.',
        imageHint: 'temperance',
      ),
    ],
    ZodiacSign.capricorn: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Bilge',
        title: 'Dağın Bilgesi',
        meaning:
            'Zirveye çıkan, geri dönüp yol gösterir. Deneyimin başkalarına ışık tutuyor.',
        imageHint: 'capricorn_sage',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Şeytan',
        title: 'XV - Şeytan',
        meaning:
            'Zincirler mi, seçimler mi? Bağlandığın şeyler seni tanımlıyor mu?',
        imageHint: 'devil',
      ),
    ],
    ZodiacSign.aquarius: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Devrimci',
        title: 'Vizyoner Devrimci',
        meaning: 'Geleceği bugünden görürsün. Fikirlerin zamanının ötesinde.',
        imageHint: 'aquarius_revolutionary',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Yıldız',
        title: 'XVII - Yıldız',
        meaning:
            'Umut, ilham ve rehberlik. En karanlık gecede bile yıldızlar parlar.',
        imageHint: 'star',
      ),
    ],
    ZodiacSign.pisces: [
      SymbolicMessage(
        type: 'Arketip',
        symbol: 'Rüyacı',
        title: 'Mistik Rüyacı',
        meaning: 'Dünyalar arasında yüzersin. Rüyaların mesaj taşıyor, dinle.',
        imageHint: 'pisces_dreamer',
      ),
      SymbolicMessage(
        type: 'Tarot',
        symbol: 'Ay',
        title: 'XVIII - Ay',
        meaning: 'Sezgi, illüzyon ve bilinçaltı. Görünenin arkasına bak.',
        imageHint: 'moon',
      ),
    ],
  };

  static const _defaultArchetypes = [
    SymbolicMessage(
      type: 'Arketip',
      symbol: 'Yolcu',
      title: 'Kozmik Yolcu',
      meaning: 'Yolculuk devam ediyor. Her adım bir keşif.',
      imageHint: 'traveler',
    ),
  ];
}

// Data models
class CosmicShareContent {
  final HeroBlock heroBlock;
  final PersonalCosmicMessage personalMessage;
  final CosmicEnergyMeter energyMeter;
  final PlanetaryInfluence planetaryInfluence;
  final ShadowLightDuality shadowLight;
  final List<String> cosmicAdvice;
  final SymbolicMessage symbolicMessage;
  final String viralHook;
  final String sharePrompt;
  final CollectiveMoment collectiveMoment;
  final SoftPremiumCuriosity premiumCuriosity;
  final List<String> microMessages;
  // NEW: Master level additions
  final DreamInsight dreamInsight;
  final NumerologyInsight numerologyInsight;
  final TantraWisdom tantraWisdom;
  final ChakraSnapshot chakraSnapshot;
  final CosmicTimingHint timingHint;

  const CosmicShareContent({
    required this.heroBlock,
    required this.personalMessage,
    required this.energyMeter,
    required this.planetaryInfluence,
    required this.shadowLight,
    required this.cosmicAdvice,
    required this.symbolicMessage,
    required this.viralHook,
    required this.sharePrompt,
    required this.collectiveMoment,
    required this.premiumCuriosity,
    required this.microMessages,
    required this.dreamInsight,
    required this.numerologyInsight,
    required this.tantraWisdom,
    required this.chakraSnapshot,
    required this.timingHint,
  });
}

class HeroBlock {
  final String signTitle;
  final String signSymbol;
  final String cosmicHeadline;
  final String dateFormatted;
  final String moonPhaseText;
  final String moonPhaseEmoji;

  const HeroBlock({
    required this.signTitle,
    required this.signSymbol,
    required this.cosmicHeadline,
    required this.dateFormatted,
    required this.moonPhaseText,
    required this.moonPhaseEmoji,
  });
}

class PersonalCosmicMessage {
  final String message;
  final String emotionalCore;

  const PersonalCosmicMessage({
    required this.message,
    required this.emotionalCore,
  });
}

class CosmicEnergyMeter {
  final int energyLevel;
  final String energyDescription;
  final String emotionalIntensity;
  final String intensityDescription;
  final int intuitionStrength;
  final String intuitionDescription;
  final double actionReflectionBalance;
  final String balanceDescription;

  const CosmicEnergyMeter({
    required this.energyLevel,
    required this.energyDescription,
    required this.emotionalIntensity,
    required this.intensityDescription,
    required this.intuitionStrength,
    required this.intuitionDescription,
    required this.actionReflectionBalance,
    required this.balanceDescription,
  });
}

class PlanetaryInfluence {
  final Planet dominantPlanet;
  final String planetSymbol;
  final String activates;
  final String blocks;
  final String oneAction;
  final String exclusivityText;

  const PlanetaryInfluence({
    required this.dominantPlanet,
    required this.planetSymbol,
    required this.activates,
    required this.blocks,
    required this.oneAction,
    required this.exclusivityText,
  });
}

class ShadowLightDuality {
  final String shadowChallenge;
  final String shadowFear;
  final String shadowPattern;
  final String lightStrength;
  final String lightOpportunity;
  final String lightMagnetic;

  const ShadowLightDuality({
    required this.shadowChallenge,
    required this.shadowFear,
    required this.shadowPattern,
    required this.lightStrength,
    required this.lightOpportunity,
    required this.lightMagnetic,
  });
}

class SymbolicMessage {
  final String type;
  final String symbol;
  final String title;
  final String meaning;
  final String imageHint;

  const SymbolicMessage({
    required this.type,
    required this.symbol,
    required this.title,
    required this.meaning,
    required this.imageHint,
  });
}

class PlanetInfluenceData {
  final String activates;
  final String blocks;
  final String action;

  const PlanetInfluenceData({
    required this.activates,
    required this.blocks,
    required this.action,
  });
}

class ShadowData {
  final String challenge;
  final String fear;
  final String pattern;

  const ShadowData({
    required this.challenge,
    required this.fear,
    required this.pattern,
  });
}

class LightData {
  final String strength;
  final String opportunity;
  final String magnetic;

  const LightData({
    required this.strength,
    required this.opportunity,
    required this.magnetic,
  });
}

class CollectiveMoment {
  final String mainText;
  final String subText;

  const CollectiveMoment({required this.mainText, required this.subText});
}

class SoftPremiumCuriosity {
  final String curiosityText;
  final String invitationText;

  const SoftPremiumCuriosity({
    required this.curiosityText,
    required this.invitationText,
  });
}

// ═══════════════════════════════════════════════════════════════
// MASTER LEVEL: NEW DATA MODELS
// ═══════════════════════════════════════════════════════════════

/// Rüya İzi - Dream insight for the day
class DreamInsight {
  final String symbol;
  final String symbolMeaning;
  final String dreamPrompt;
  final String nightMessage;

  const DreamInsight({
    required this.symbol,
    required this.symbolMeaning,
    required this.dreamPrompt,
    required this.nightMessage,
  });
}

/// Numerology insight based on today's date
class NumerologyInsight {
  final int dayNumber;
  final String numberMeaning;
  final String vibration;
  final String luckyHour;

  const NumerologyInsight({
    required this.dayNumber,
    required this.numberMeaning,
    required this.vibration,
    required this.luckyHour,
  });
}

/// Tantra wisdom - non-physical spiritual micro-ritual
class TantraWisdom {
  final String breathFocus;
  final String awarenessPoint;
  final String innerConnection;

  const TantraWisdom({
    required this.breathFocus,
    required this.awarenessPoint,
    required this.innerConnection,
  });
}

/// Chakra energy snapshot
class ChakraSnapshot {
  final String activeChakra;
  final String chakraSymbol;
  final String chakraMessage;
  final double balanceLevel;

  const ChakraSnapshot({
    required this.activeChakra,
    required this.chakraSymbol,
    required this.chakraMessage,
    required this.balanceLevel,
  });
}

/// Cosmic timing hint
class CosmicTimingHint {
  final String goldenHour;
  final String avoidHour;
  final String ritualSuggestion;

  const CosmicTimingHint({
    required this.goldenHour,
    required this.avoidHour,
    required this.ritualSuggestion,
  });
}
