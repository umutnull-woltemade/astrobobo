import '../models/natal_chart.dart';
import '../models/planet.dart';
import '../models/aspect.dart';
import '../models/house.dart';
import '../models/zodiac_sign.dart';
import 'numerology_service.dart';

/// Complete psychological and relationship profile analysis
class ProfileAnalysisService {
  /// Generate complete profile analysis from natal chart
  static ProfileAnalysis analyzeProfile(NatalChart chart, {String? name}) {
    // Personality
    final personality = _analyzePersonality(chart);

    // Emotional profile
    final emotional = _analyzeEmotionalProfile(chart);

    // Love & relationships
    final love = _analyzeLoveProfile(chart);

    // Career & money
    final career = _analyzeCareerProfile(chart);

    // Psychological patterns
    final psychological = _analyzePsychologicalProfile(chart);

    // Karmic patterns
    final karmic = _analyzeKarmicProfile(chart);

    // Numerology
    NumerologyProfile? numerology;
    if (name != null) {
      numerology = _analyzeNumerology(chart.birthDate, name);
    }

    return ProfileAnalysis(
      personality: personality,
      emotional: emotional,
      love: love,
      career: career,
      psychological: psychological,
      karmic: karmic,
      numerology: numerology,
    );
  }

  static PersonalityProfile _analyzePersonality(NatalChart chart) {
    final sun = chart.sun;
    final moon = chart.moon;
    final asc = chart.ascendant;

    // Core traits from Sun sign
    final coreTraits = sun?.sign.traits ?? [];

    // Emotional style from Moon
    String emotionalStyle = '';
    if (moon != null) {
      switch (moon.sign.element) {
        case Element.fire:
          emotionalStyle = 'Tutkulu ve spontan duygusal ifade';
          break;
        case Element.earth:
          emotionalStyle = 'Güvenilir ve istikrarlı duygusal yaklaşım';
          break;
        case Element.air:
          emotionalStyle = 'Analitik ve iletişimsel duygusal işleyiş';
          break;
        case Element.water:
          emotionalStyle = 'Derin ve sezgisel duygusal dünya';
          break;
      }
    }

    // First impression from Ascendant
    String firstImpression = '';
    if (asc != null) {
      firstImpression =
          'Dış dünyaya ${asc.sign.name} enerjisi yansıtır: '
          '${asc.sign.traits.take(2).join(", ")}';
    }

    // Dominant element
    final dominantElement = chart.dominantElement;

    // Dominant modality
    final dominantModality = chart.dominantModality;

    return PersonalityProfile(
      sunSign: sun?.sign ?? ZodiacSign.aries,
      moonSign: moon?.sign,
      risingSign: asc?.sign,
      coreTraits: coreTraits,
      emotionalStyle: emotionalStyle,
      firstImpression: firstImpression,
      dominantElement: dominantElement,
      dominantModality: dominantModality,
      retrogradeCount: chart.retrogradePlanets.length,
    );
  }

  static EmotionalProfile _analyzeEmotionalProfile(NatalChart chart) {
    final moon = chart.moon;
    final mars = chart.mars;
    final aspects = chart.aspectsForPlanet(Planet.moon);

    // Attachment style based on Moon aspects
    String attachmentStyle = 'Güvenli bağlanma';
    bool hasChallengingMoonAspects = aspects.any((a) => a.type.isChallenging);
    if (hasChallengingMoonAspects) {
      final saturnAspect = aspects.any(
        (a) => a.planet2 == Planet.saturn && a.type.isChallenging,
      );
      final plutoAspect = aspects.any(
        (a) => a.planet2 == Planet.pluto && a.type.isChallenging,
      );

      if (saturnAspect) {
        attachmentStyle = 'Kaçıngan bağlanma eğilimi - duygusal mesafe';
      } else if (plutoAspect) {
        attachmentStyle = 'Kaygılı bağlanma eğilimi - yoğun duygusal ihtiyaç';
      }
    }

    // Security needs from Moon sign
    String securityNeeds = '';
    if (moon != null) {
      switch (moon.sign) {
        case ZodiacSign.aries:
        case ZodiacSign.sagittarius:
          securityNeeds = 'Özgürlük ve macera hissi';
          break;
        case ZodiacSign.taurus:
        case ZodiacSign.cancer:
          securityNeeds = 'Fiziksel konfor ve aile bağları';
          break;
        case ZodiacSign.gemini:
        case ZodiacSign.aquarius:
          securityNeeds = 'Zihinsel stimülasyon ve sosyal bağlantı';
          break;
        case ZodiacSign.leo:
          securityNeeds = 'Takdir ve tanınma';
          break;
        case ZodiacSign.virgo:
          securityNeeds = 'Düzen ve faydalı hissetmek';
          break;
        case ZodiacSign.libra:
          securityNeeds = 'Uyum ve ilişki';
          break;
        case ZodiacSign.scorpio:
          securityNeeds = 'Derin duygusal bağ ve güven';
          break;
        case ZodiacSign.capricorn:
          securityNeeds = 'Başarı ve toplumsal statü';
          break;
        case ZodiacSign.pisces:
          securityNeeds = 'Spiritüel bağlantı ve kabul edilme';
          break;
      }
    }

    // Emotional triggers
    final triggers = <String>[];
    final moonSquares = aspects
        .where((a) => a.type == AspectType.square)
        .toList();
    for (final aspect in moonSquares) {
      final otherPlanet = aspect.planet1 == Planet.moon
          ? aspect.planet2
          : aspect.planet1;
      triggers.add(
        '${otherPlanet.nameTr} konuları duygusal tetikleyici olabilir',
      );
    }

    // Stress response
    String stressResponse = '';
    if (mars != null) {
      switch (mars.sign.element) {
        case Element.fire:
          stressResponse = 'Aktif mücadele - öfke patlamaları olası';
          break;
        case Element.earth:
          stressResponse = 'Pratik çözümler arar - içe kapanabilir';
          break;
        case Element.air:
          stressResponse = 'Rasyonalize eder - duygulardan kaçınabilir';
          break;
        case Element.water:
          stressResponse = 'Duygusal tepki - geri çekilme veya pasif agresyon';
          break;
      }
    }

    return EmotionalProfile(
      attachmentStyle: attachmentStyle,
      securityNeeds: securityNeeds,
      emotionalTriggers: triggers,
      stressResponse: stressResponse,
      empathyLevel: _calculateEmpathyLevel(chart),
      emotionalResilience: _calculateResilienceLevel(chart),
    );
  }

  static LoveProfile _analyzeLoveProfile(NatalChart chart) {
    final venus = chart.venus;
    final mars = chart.mars;

    // Love language from Venus
    String loveLanguage = '';
    if (venus != null) {
      switch (venus.sign) {
        case ZodiacSign.aries:
        case ZodiacSign.leo:
          loveLanguage = 'Fiziksel dokunma ve eylemler';
          break;
        case ZodiacSign.taurus:
        case ZodiacSign.cancer:
          loveLanguage = 'Hediyeler ve kaliteli zaman';
          break;
        case ZodiacSign.gemini:
        case ZodiacSign.libra:
          loveLanguage = 'Onaylayıcı sözler ve iletişim';
          break;
        case ZodiacSign.virgo:
        case ZodiacSign.capricorn:
          loveLanguage = 'Hizmet etmek ve pratik destek';
          break;
        case ZodiacSign.scorpio:
        case ZodiacSign.pisces:
          loveLanguage = 'Kaliteli zaman ve derin bağlantı';
          break;
        case ZodiacSign.sagittarius:
        case ZodiacSign.aquarius:
          loveLanguage = 'Macera paylaşma ve özgürlük verme';
          break;
      }
    }

    // Attraction pattern from Venus/Mars
    String attractionPattern = '';
    if (venus != null && mars != null) {
      attractionPattern =
          '${venus.sign.name} çekiciliği ile ${mars.sign.name} arzusu birleşimi';
    }

    // Relationship style
    String relationshipStyle = '';
    final venusAspects = chart.aspectsForPlanet(Planet.venus);
    final hasSaturnVenus = venusAspects.any(
      (a) => (a.planet1 == Planet.saturn || a.planet2 == Planet.saturn),
    );

    if (hasSaturnVenus) {
      relationshipStyle = 'Ciddi ve uzun vadeli ilişkilere meyilli';
    } else if (venus?.sign.element == Element.fire) {
      relationshipStyle = 'Tutkulu ve spontan ilişkiler';
    } else if (venus?.sign.element == Element.earth) {
      relationshipStyle = 'Güvenilir ve istikrarlı ilişkiler';
    } else if (venus?.sign.element == Element.air) {
      relationshipStyle = 'Entelektüel ve sosyal ilişkiler';
    } else {
      relationshipStyle = 'Derin ve duygusal ilişkiler';
    }

    // Jealousy tendency
    int jealousyTendency = 50;
    if (venus?.sign == ZodiacSign.scorpio || mars?.sign == ZodiacSign.scorpio) {
      jealousyTendency = 80;
    } else if (venus?.sign == ZodiacSign.taurus) {
      jealousyTendency = 70;
    } else if (venus?.sign == ZodiacSign.sagittarius ||
        venus?.sign == ZodiacSign.aquarius) {
      jealousyTendency = 30;
    }

    // Partner profile (7th house)
    String idealPartnerProfile = '';
    if (chart.hasExactTime) {
      final planetsIn7th = chart.planetsInHouse(House.seventh);
      final descendant = chart.planets
          .where((p) => p.planet == Planet.descendant)
          .firstOrNull;
      if (descendant != null) {
        idealPartnerProfile =
            '${descendant.sign.name} özelliklerine sahip partnerlere çekilir';
        if (planetsIn7th.isNotEmpty) {
          idealPartnerProfile +=
              '. ${planetsIn7th.map((p) => p.planet.nameTr).join(", ")} enerjisi ilişkilerde önemli';
        }
      }
    }

    return LoveProfile(
      venusSign: venus?.sign,
      marsSign: mars?.sign,
      loveLanguage: loveLanguage,
      attractionPattern: attractionPattern,
      relationshipStyle: relationshipStyle,
      jealousyTendency: jealousyTendency,
      commitmentReadiness: _calculateCommitmentReadiness(chart),
      idealPartnerProfile: idealPartnerProfile,
    );
  }

  static CareerProfile _analyzeCareerProfile(NatalChart chart) {
    final sun = chart.sun;
    final saturn = chart.saturn;
    final jupiter = chart.jupiter;

    // Natural talents based on dominant element
    List<String> talents = [];
    switch (chart.dominantElement) {
      case Element.fire:
        talents = ['Liderlik', 'Girişimcilik', 'Motivasyon'];
        break;
      case Element.earth:
        talents = ['Planlama', 'Organizasyon', 'Finansal zeka'];
        break;
      case Element.air:
        talents = ['İletişim', 'Analiz', 'Networking'];
        break;
      case Element.water:
        talents = ['Empati', 'Yaratıcılık', 'Sezgi'];
        break;
    }

    // Career direction from MC
    String careerDirection = '';
    if (chart.midheaven != null) {
      careerDirection =
          '${chart.midheaven!.sign.name} enerjisiyle toplum önünde parlar';
    }

    // Leadership vs support role
    bool isLeaderType =
        sun?.sign.modality == Modality.cardinal ||
        chart.dominantModality == Modality.cardinal;

    // Risk tolerance
    int riskTolerance = 50;
    if (jupiter?.sign.element == Element.fire ||
        sun?.sign == ZodiacSign.sagittarius) {
      riskTolerance = 80;
    } else if (saturn?.isRetrograde == true ||
        sun?.sign == ZodiacSign.capricorn) {
      riskTolerance = 30;
    }

    // Entrepreneurship potential
    int entrepreneurPotential = 50;
    final hasFireSun = sun?.sign.element == Element.fire;
    final hasCapricornPlacements = chart.planets
        .where((p) => p.sign == ZodiacSign.capricorn)
        .length;
    if (hasFireSun && hasCapricornPlacements > 0) {
      entrepreneurPotential = 85;
    } else if (hasFireSun) {
      entrepreneurPotential = 70;
    }

    return CareerProfile(
      naturalTalents: talents,
      careerDirection: careerDirection,
      isLeaderType: isLeaderType,
      riskTolerance: riskTolerance,
      entrepreneurPotential: entrepreneurPotential,
      saturnSign: saturn?.sign,
      jupiterSign: jupiter?.sign,
    );
  }

  static PsychologicalProfile _analyzePsychologicalProfile(NatalChart chart) {
    // Defense mechanisms based on Moon/Saturn aspects
    List<String> defenseMechanisms = [];
    final moonSaturnAspect = chart.aspects.any(
      (a) =>
          (a.planet1 == Planet.moon && a.planet2 == Planet.saturn) ||
          (a.planet1 == Planet.saturn && a.planet2 == Planet.moon),
    );

    if (moonSaturnAspect) {
      defenseMechanisms.add('Duygusal baskılama');
      defenseMechanisms.add('Aşırı kontrol ihtiyacı');
    }

    // Pluto aspects indicate transformation patterns
    final plutoAspects = chart.aspectsForPlanet(Planet.pluto);
    if (plutoAspects.any((a) => a.type.isChallenging)) {
      defenseMechanisms.add('Yoğun kontrol eğilimi');
    }

    // Shadow self from Lilith
    String shadowSelf = '';
    final lilith = chart.lilith;
    if (lilith != null) {
      shadowSelf =
          'Bastırılmış ${lilith.sign.name} enerjisi - '
          '${_getLilithMeaning(lilith.sign)}';
    }

    // Relationship patterns
    List<String> relationshipPatterns = [];
    final venusAspects = chart.aspectsForPlanet(Planet.venus);
    for (final aspect in venusAspects.where((a) => a.type.isChallenging)) {
      relationshipPatterns.add(
        '${aspect.planet1.nameTr}-${aspect.planet2.nameTr} ${aspect.type.nameTr}: ${aspect.interpretation}',
      );
    }

    return PsychologicalProfile(
      defenseMechanisms: defenseMechanisms,
      shadowSelf: shadowSelf,
      controlNeed: _calculateControlNeed(chart),
      solitaryNeed: _calculateSolitaryNeed(chart),
      relationshipPatterns: relationshipPatterns,
    );
  }

  static KarmicProfile _analyzeKarmicProfile(NatalChart chart) {
    final northNode = chart.northNode;
    final southNode = chart.southNode;
    final chiron = chart.chiron;

    // Life lesson from North Node
    String lifeLesson = '';
    if (northNode != null) {
      lifeLesson =
          '${northNode.sign.name} özelliklerini bu hayatta geliştirmek gerekir: '
          '${_getNorthNodeLesson(northNode.sign)}';
    }

    // Past life patterns from South Node
    String pastLifePatterns = '';
    if (southNode != null) {
      pastLifePatterns =
          '${southNode.sign.name} enerjisinde uzman ama bırakmayı öğrenmeli: '
          '${_getSouthNodePattern(southNode.sign)}';
    }

    // Deepest wound from Chiron
    String deepestWound = '';
    if (chiron != null) {
      deepestWound =
          '${chiron.sign.name} alanında derin bir yara var: '
          '${_getChironWound(chiron.sign)}';
    }

    // Karmic debt numbers
    final karmicDebts = NumerologyService.findKarmicDebtNumbers(
      chart.birthDate,
    );

    return KarmicProfile(
      northNodeSign: northNode?.sign,
      southNodeSign: southNode?.sign,
      chironSign: chiron?.sign,
      lifeLesson: lifeLesson,
      pastLifePatterns: pastLifePatterns,
      deepestWound: deepestWound,
      karmicDebtNumbers: karmicDebts,
    );
  }

  static NumerologyProfile _analyzeNumerology(DateTime birthDate, String name) {
    final lifePath = NumerologyService.calculateLifePathNumber(birthDate);
    final destiny = NumerologyService.calculateDestinyNumber(name);
    final soulUrge = NumerologyService.calculateSoulUrgeNumber(name);
    final personality = NumerologyService.calculatePersonalityNumber(name);
    final birthday = NumerologyService.calculateBirthdayNumber(birthDate);
    final personalYear = NumerologyService.calculatePersonalYearNumber(
      birthDate,
      DateTime.now().year,
    );

    return NumerologyProfile(
      lifePathNumber: lifePath,
      destinyNumber: destiny,
      soulUrgeNumber: soulUrge,
      personalityNumber: personality,
      birthdayNumber: birthday,
      personalYearNumber: personalYear,
      lifePathMeaning: NumerologyService.getNumberMeaning(lifePath),
      destinyMeaning: NumerologyService.getNumberMeaning(destiny),
    );
  }

  // Helper methods
  static int _calculateEmpathyLevel(NatalChart chart) {
    int level = 50;
    final waterPlanets = chart.planets.where(
      (p) =>
          p.sign.element == Element.water &&
          (p.planet.isPersonalPlanet || p.planet == Planet.moon),
    );
    level += waterPlanets.length * 10;

    if (chart.moon?.sign == ZodiacSign.pisces ||
        chart.moon?.sign == ZodiacSign.cancer) {
      level += 15;
    }

    return level.clamp(0, 100);
  }

  static int _calculateResilienceLevel(NatalChart chart) {
    int level = 50;
    // Fixed signs add resilience
    final fixedPlanets = chart.planets.where(
      (p) => p.sign.modality == Modality.fixed && p.planet.isPersonalPlanet,
    );
    level += fixedPlanets.length * 8;

    // Saturn aspects to personal planets
    final saturnAspects = chart.aspectsForPlanet(Planet.saturn);
    if (saturnAspects.any((a) => a.type == AspectType.trine)) {
      level += 10;
    }

    return level.clamp(0, 100);
  }

  static int _calculateCommitmentReadiness(NatalChart chart) {
    int level = 50;

    // Saturn aspects to Venus
    final venusAspects = chart.aspectsForPlanet(Planet.venus);
    if (venusAspects.any(
      (a) =>
          (a.planet1 == Planet.saturn || a.planet2 == Planet.saturn) &&
          a.type.isHarmonious,
    )) {
      level += 20;
    }

    // Earth signs
    final earthPlanets = chart.planets.where(
      (p) =>
          p.sign.element == Element.earth &&
          (p.planet == Planet.venus || p.planet == Planet.moon),
    );
    level += earthPlanets.length * 10;

    return level.clamp(0, 100);
  }

  static int _calculateControlNeed(NatalChart chart) {
    int level = 50;

    // Scorpio/Pluto placements
    final scorpioPlanets = chart.planets.where(
      (p) => p.sign == ZodiacSign.scorpio,
    );
    level += scorpioPlanets.length * 8;

    // Pluto aspects
    final plutoAspects = chart.aspectsForPlanet(Planet.pluto);
    level += plutoAspects.where((a) => a.type.isChallenging).length * 5;

    return level.clamp(0, 100);
  }

  static int _calculateSolitaryNeed(NatalChart chart) {
    int level = 50;

    // 12th house planets
    final twelfthHousePlanets = chart.planetsInHouse(House.twelfth);
    level += twelfthHousePlanets.length * 10;

    // Scorpio/Capricorn Moon
    if (chart.moon?.sign == ZodiacSign.scorpio ||
        chart.moon?.sign == ZodiacSign.capricorn) {
      level += 15;
    }

    return level.clamp(0, 100);
  }

  static String _getLilithMeaning(ZodiacSign sign) {
    switch (sign) {
      case ZodiacSign.aries:
        return 'yabanıl öfkenin ve saf bağımsızlığın gizli ateşi. İçindeki ilkel savaşçı, toplumsal kuralların ötesinde var olmak istiyor. Bu karanlık ateş, kontrol edildiğinde devrimci bir güç, bastırıldığında yıkıcı bir volkan olur';
      case ZodiacSign.taurus:
        return 'toprak tanrıçasının yasak meyveleri - bedensel hazlar, sahiplenme tutkusu ve maddi dünyanın büyüsü. İçindeki bu enerji, kutsalı maddi olanda arayan kadim bir arayıştır. Onu onurlandırırsan, bolluk akışını açarsın';
      case ZodiacSign.gemini:
        return 'karanlık ikiz - söylenmemiş sözlerin, manipülatif zekanın ve ikili doğanın gölgesi. Bu enerji, hakikatin birden fazla yüzü olduğunu bilen hileci arketipidir. Dengelenmezse yalan, dengelenirse şifa verici hikayeler doğurur';
      case ZodiacSign.cancer:
        return 'ay tanrıçasının karanlık yüzü - boğucu sevgi, duygusal vampirizm ve annelik gölgesi. İçindeki bu enerji, sonsuz beslenme ihtiyacını ve onu verememe korkusunu taşır. Şifa, önce kendinizi beslemekten geçer';
      case ZodiacSign.leo:
        return 'tahtından düşmüş kralın gölgesi - karşı konulmaz dikkat açlığı, yaratıcı kıskançlık ve parlamanın yasak zevki. Bu enerji, içinizdeki tanrısal kıvılcımın kaotik tezahürüdür. Bilinçle kullanılırsa ilham, bilinçsizce kullanılırsa tiranlık olur';
      case ZodiacSign.virgo:
        return 'mükemmeliyetin karanlık yüzü - eleştiri silahı, bedenle savaş ve "asla yeterli olmama" laneti. İçinizdeki bu enerji, kutsal düzeni arayan ama kusurlarında boğulan arketipi taşır. Şifa, kusurun içindeki güzelliği bulmaktadır';
      case ZodiacSign.libra:
        return 'ilişki maskesi altında kaybolan benlik - insanlara bağımlılık, onay açlığı ve sahte harmoninin tuzağı. Bu enerji, aşkta kaybolma ve kendini bulma arasındaki kadim savaşı temsil eder. Denge, önce kendi içinizde kurulmalıdır';
      case ZodiacSign.scorpio:
        return 'derin suların en karanlık yerinde saklanan hazine - obsesif tutku, güç oyunları ve yok etme dürtüsü. Bu, ruhun en karanlık gecesinde bile yanan ateştir. Dönüştürülürse simyasal altın, bastırılırsa zehirli yılan olur';
      case ZodiacSign.sagittarius:
        return 'kaçışın ve fanatizmin gölgesi - hakikati silah olarak kullanma, ruhani bypass ve "daha iyi bir yerin" hayali. İçinizdeki bu enerji, sonsuz arayışın hem şifası hem hastalığıdır. Denge, "şimdi ve burada" kalabilmektir';
      case ZodiacSign.capricorn:
        return 'hırsın karanlık tahtı - başarı takıntısı, duygusal donukluk ve "tepedeki yalnızlık" laneti. Bu enerji, dünyevi başarının ruhani bedeli sorusunu sorar. Şifa, başarıyı aşkla birleştirmektir';
      case ZodiacSign.aquarius:
        return 'yabancılaşmanın gölgesi - soğuk mesafe, duygusal kopukluk ve "farklı olma" laneti. İçinizdeki bu enerji, kolektiften ayrılmanın hem özgürleştirici hem de yalnızlaştırıcı yüzünü taşır. Denge, bağlılık içinde özgürlüktür';
      case ZodiacSign.pisces:
        return 'okyanusun en karanlık derinlikleri - kurban arketipi, sınırsızlık kabusu ve kaçış bağımlılıkları. Bu enerji, tanrısal birlikle maddi ayrılık arasındaki ıstırabı taşır. Şifa, bedende ruhani olmayı öğrenmektir';
    }
  }

  static String _getNorthNodeLesson(ZodiacSign sign) {
    switch (sign) {
      case ZodiacSign.aries:
        return 'Kendi ayakları üzerinde durmak, cesaret';
      case ZodiacSign.taurus:
        return 'İç huzur, maddi güvenlik inşa etme';
      case ZodiacSign.gemini:
        return 'İletişim, merak, esneklik';
      case ZodiacSign.cancer:
        return 'Duygusal bağ, yuva kurma';
      case ZodiacSign.leo:
        return 'Yaratıcı ifade, liderlik';
      case ZodiacSign.virgo:
        return 'Pratik hizmet, detaylara dikkat';
      case ZodiacSign.libra:
        return 'Ortaklık, denge, diplomasi';
      case ZodiacSign.scorpio:
        return 'Dönüşüm, derinlik, paylaşım';
      case ZodiacSign.sagittarius:
        return 'Anlam arayışı, genişleme';
      case ZodiacSign.capricorn:
        return 'Sorumluluk, kariyer, otorite';
      case ZodiacSign.aquarius:
        return 'Topluluk, yenilik, bağımsızlık';
      case ZodiacSign.pisces:
        return 'Spiritüel bağlantı, teslimiyet';
    }
  }

  static String _getSouthNodePattern(ZodiacSign sign) {
    switch (sign) {
      case ZodiacSign.aries:
        return 'Aşırı bağımsızlık ve bencillik';
      case ZodiacSign.taurus:
        return 'Maddi bağımlılık ve direnç';
      case ZodiacSign.gemini:
        return 'Yüzeysellik ve dağınıklık';
      case ZodiacSign.cancer:
        return 'Aşırı duygusallık ve bağımlılık';
      case ZodiacSign.leo:
        return 'Ego ve dikkat bağımlılığı';
      case ZodiacSign.virgo:
        return 'Aşırı eleştirellik ve mükemmeliyetçilik';
      case ZodiacSign.libra:
        return 'Kararsızlık ve başkalarına bağımlılık';
      case ZodiacSign.scorpio:
        return 'Kontrol ihtiyacı ve intikamcılık';
      case ZodiacSign.sagittarius:
        return 'Kaçış ve aşırı idealizm';
      case ZodiacSign.capricorn:
        return 'İşkoliklik ve duygusal soğukluk';
      case ZodiacSign.aquarius:
        return 'Mesafe ve bağlanma korkusu';
      case ZodiacSign.pisces:
        return 'Kurban rolü ve sınır eksikliği';
    }
  }

  static String _getChironWound(ZodiacSign sign) {
    switch (sign) {
      case ZodiacSign.aries:
        return 'Kimlik ve özgüven yarası';
      case ZodiacSign.taurus:
        return 'Değersizlik ve maddi güvensizlik';
      case ZodiacSign.gemini:
        return 'İletişim ve kabul görme yarası';
      case ZodiacSign.cancer:
        return 'Aile ve duygusal güvenlik yarası';
      case ZodiacSign.leo:
        return 'Yaratıcılık ve tanınma yarası';
      case ZodiacSign.virgo:
        return 'Mükemmeliyetçilik ve yetersizlik';
      case ZodiacSign.libra:
        return 'İlişki ve denge yarası';
      case ZodiacSign.scorpio:
        return 'Güven ve ihanet yarası';
      case ZodiacSign.sagittarius:
        return 'Anlam ve inanç krizi';
      case ZodiacSign.capricorn:
        return 'Başarısızlık ve otorite yarası';
      case ZodiacSign.aquarius:
        return 'Farklılık ve yabancılaşma';
      case ZodiacSign.pisces:
        return 'Spiritüel kopuş ve kayıp';
    }
  }
}

// Result classes
class ProfileAnalysis {
  final PersonalityProfile personality;
  final EmotionalProfile emotional;
  final LoveProfile love;
  final CareerProfile career;
  final PsychologicalProfile psychological;
  final KarmicProfile karmic;
  final NumerologyProfile? numerology;

  ProfileAnalysis({
    required this.personality,
    required this.emotional,
    required this.love,
    required this.career,
    required this.psychological,
    required this.karmic,
    this.numerology,
  });
}

class PersonalityProfile {
  final ZodiacSign sunSign;
  final ZodiacSign? moonSign;
  final ZodiacSign? risingSign;
  final List<String> coreTraits;
  final String emotionalStyle;
  final String firstImpression;
  final Element dominantElement;
  final Modality dominantModality;
  final int retrogradeCount;

  PersonalityProfile({
    required this.sunSign,
    this.moonSign,
    this.risingSign,
    required this.coreTraits,
    required this.emotionalStyle,
    required this.firstImpression,
    required this.dominantElement,
    required this.dominantModality,
    required this.retrogradeCount,
  });
}

class EmotionalProfile {
  final String attachmentStyle;
  final String securityNeeds;
  final List<String> emotionalTriggers;
  final String stressResponse;
  final int empathyLevel;
  final int emotionalResilience;

  EmotionalProfile({
    required this.attachmentStyle,
    required this.securityNeeds,
    required this.emotionalTriggers,
    required this.stressResponse,
    required this.empathyLevel,
    required this.emotionalResilience,
  });
}

class LoveProfile {
  final ZodiacSign? venusSign;
  final ZodiacSign? marsSign;
  final String loveLanguage;
  final String attractionPattern;
  final String relationshipStyle;
  final int jealousyTendency;
  final int commitmentReadiness;
  final String idealPartnerProfile;

  LoveProfile({
    this.venusSign,
    this.marsSign,
    required this.loveLanguage,
    required this.attractionPattern,
    required this.relationshipStyle,
    required this.jealousyTendency,
    required this.commitmentReadiness,
    required this.idealPartnerProfile,
  });
}

class CareerProfile {
  final List<String> naturalTalents;
  final String careerDirection;
  final bool isLeaderType;
  final int riskTolerance;
  final int entrepreneurPotential;
  final ZodiacSign? saturnSign;
  final ZodiacSign? jupiterSign;

  CareerProfile({
    required this.naturalTalents,
    required this.careerDirection,
    required this.isLeaderType,
    required this.riskTolerance,
    required this.entrepreneurPotential,
    this.saturnSign,
    this.jupiterSign,
  });
}

class PsychologicalProfile {
  final List<String> defenseMechanisms;
  final String shadowSelf;
  final int controlNeed;
  final int solitaryNeed;
  final List<String> relationshipPatterns;

  PsychologicalProfile({
    required this.defenseMechanisms,
    required this.shadowSelf,
    required this.controlNeed,
    required this.solitaryNeed,
    required this.relationshipPatterns,
  });
}

class KarmicProfile {
  final ZodiacSign? northNodeSign;
  final ZodiacSign? southNodeSign;
  final ZodiacSign? chironSign;
  final String lifeLesson;
  final String pastLifePatterns;
  final String deepestWound;
  final List<int> karmicDebtNumbers;

  KarmicProfile({
    this.northNodeSign,
    this.southNodeSign,
    this.chironSign,
    required this.lifeLesson,
    required this.pastLifePatterns,
    required this.deepestWound,
    required this.karmicDebtNumbers,
  });
}

class NumerologyProfile {
  final int lifePathNumber;
  final int destinyNumber;
  final int soulUrgeNumber;
  final int personalityNumber;
  final int birthdayNumber;
  final int personalYearNumber;
  final NumerologyMeaning lifePathMeaning;
  final NumerologyMeaning destinyMeaning;

  NumerologyProfile({
    required this.lifePathNumber,
    required this.destinyNumber,
    required this.soulUrgeNumber,
    required this.personalityNumber,
    required this.birthdayNumber,
    required this.personalYearNumber,
    required this.lifePathMeaning,
    required this.destinyMeaning,
  });
}
