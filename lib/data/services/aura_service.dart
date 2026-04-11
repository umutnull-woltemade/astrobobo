import 'dart:ui';

/// Aura renk analizi servisi
class AuraService {
  /// Doğum tarihinden birincil aura rengini hesapla
  static AuraColor calculatePrimaryAura(DateTime birthDate) {
    final lifePathSum = _calculateLifePath(birthDate);
    return _auraFromLifePath(lifePathSum);
  }

  /// İsimden ikincil aura rengini hesapla
  static AuraColor calculateSecondaryAura(String name) {
    final sum = _calculateNameValue(name);
    final reduced = _reduceToSingleDigit(sum);
    return _auraFromNumber(reduced);
  }

  /// Tam aura profili oluştur
  static AuraProfile createAuraProfile({
    required DateTime birthDate,
    String? name,
    String? currentMood,
  }) {
    final primaryAura = calculatePrimaryAura(birthDate);
    AuraColor? secondaryAura;
    AuraColor? moodAura;

    if (name != null && name.isNotEmpty) {
      secondaryAura = calculateSecondaryAura(name);
    }

    if (currentMood != null) {
      moodAura = _getMoodAura(currentMood);
    }

    final chakraAlignment = _calculateChakraAlignment(birthDate);

    return AuraProfile(
      primaryColor: primaryAura,
      secondaryColor: secondaryAura,
      moodColor: moodAura,
      chakraAlignment: chakraAlignment,
      overallEnergy: _calculateOverallEnergy(primaryAura, secondaryAura),
      spiritualAdvice: _getSpiritualAdvice(primaryAura),
    );
  }

  /// Günlük aura enerjisi
  static DailyAuraEnergy getDailyAuraEnergy(
    DateTime birthDate,
    DateTime today,
  ) {
    final basePath = _calculateLifePath(birthDate);
    final todaySum =
        _digitSum(today.day) + _digitSum(today.month) + _digitSum(today.year);
    final combined = _reduceToSingleDigit(basePath + todaySum);

    final primaryAura = _auraFromLifePath(basePath);
    final todayAura = _auraFromNumber(combined);

    return DailyAuraEnergy(
      date: today,
      baseAura: primaryAura,
      todayAura: todayAura,
      energyLevel: _calculateEnergyLevel(basePath, combined),
      guidance: _getDailyGuidance(primaryAura, todayAura),
      affirmation: _getDailyAffirmation(todayAura),
    );
  }

  /// Aura temizleme önerileri
  static List<AuraCleansingTip> getCleansingTips(AuraColor aura) {
    final tips = <AuraCleansingTip>[];

    // Genel temizleme
    tips.add(
      AuraCleansingTip(
        title: 'Meditasyon',
        description:
            '${aura.nameTr} auranı güçlendirmek için günde 10-15 dakika ${aura.meditationFocus} üzerine meditasyon yap.',
        icon: 'meditation',
      ),
    );

    tips.add(
      AuraCleansingTip(
        title: 'Kristal Terapi',
        description:
            '${aura.recommendedCrystal} kristali auranı dengelemek için idealdir.',
        icon: 'crystal',
      ),
    );

    tips.add(
      AuraCleansingTip(
        title: 'Renk Terapisi',
        description:
            '${aura.nameTr} tonlarında kıyafetler giy veya bu renkte nesnelerle çevrili ol.',
        icon: 'color',
      ),
    );

    tips.add(
      AuraCleansingTip(
        title: 'Doğa Bağlantısı',
        description: aura.natureConnection,
        icon: 'nature',
      ),
    );

    tips.add(
      AuraCleansingTip(
        title: 'Ses Terapisi',
        description:
            '${aura.soundFrequency} Hz frekansında müzik dinle veya ${aura.chakra.mantras} mantrasını söyle.',
        icon: 'sound',
      ),
    );

    return tips;
  }

  static int _calculateLifePath(DateTime birthDate) {
    final day = _digitSum(birthDate.day);
    final month = _digitSum(birthDate.month);
    final year = _digitSum(birthDate.year);
    return _reduceToSingleDigitOrMaster(day + month + year);
  }

  static AuraColor _auraFromLifePath(int lifePath) {
    switch (lifePath) {
      case 1:
        return AuraColor.red;
      case 2:
        return AuraColor.blue;
      case 3:
        return AuraColor.yellow;
      case 4:
        return AuraColor.green;
      case 5:
        return AuraColor.orange;
      case 6:
        return AuraColor.pink;
      case 7:
        return AuraColor.indigo;
      case 8:
        return AuraColor.gold;
      case 9:
        return AuraColor.violet;
      case 11:
        return AuraColor.white;
      case 22:
        return AuraColor.gold;
      case 33:
        return AuraColor.violet;
      default:
        return AuraColor.white;
    }
  }

  static AuraColor _auraFromNumber(int number) {
    switch (number % 10) {
      case 1:
        return AuraColor.red;
      case 2:
        return AuraColor.blue;
      case 3:
        return AuraColor.yellow;
      case 4:
        return AuraColor.green;
      case 5:
        return AuraColor.orange;
      case 6:
        return AuraColor.pink;
      case 7:
        return AuraColor.indigo;
      case 8:
        return AuraColor.gold;
      case 9:
        return AuraColor.violet;
      case 0:
        return AuraColor.white;
      default:
        return AuraColor.white;
    }
  }

  static int _calculateNameValue(String name) {
    final cleanName = name.toUpperCase().replaceAll(
      RegExp(r'[^A-ZÇĞİÖŞÜ]'),
      '',
    );
    var sum = 0;
    for (final char in cleanName.split('')) {
      sum += _letterValue(char);
    }
    return sum;
  }

  static int _letterValue(String letter) {
    const values = {
      'A': 1,
      'B': 2,
      'C': 3,
      'Ç': 3,
      'D': 4,
      'E': 5,
      'F': 6,
      'G': 7,
      'Ğ': 7,
      'H': 8,
      'I': 9,
      'İ': 9,
      'J': 1,
      'K': 2,
      'L': 3,
      'M': 4,
      'N': 5,
      'O': 6,
      'Ö': 6,
      'P': 7,
      'Q': 8,
      'R': 9,
      'S': 1,
      'Ş': 1,
      'T': 2,
      'U': 3,
      'Ü': 3,
      'V': 4,
      'W': 5,
      'X': 6,
      'Y': 7,
      'Z': 8,
    };
    return values[letter] ?? 0;
  }

  static int _digitSum(int number) {
    var sum = 0;
    while (number > 0) {
      sum += number % 10;
      number ~/= 10;
    }
    return sum;
  }

  static int _reduceToSingleDigit(int number) {
    while (number > 9) {
      number = _digitSum(number);
    }
    return number;
  }

  static int _reduceToSingleDigitOrMaster(int number) {
    while (number > 9 && number != 11 && number != 22 && number != 33) {
      number = _digitSum(number);
    }
    return number > 9 ? _reduceToSingleDigit(number) : number;
  }

  static AuraColor _getMoodAura(String mood) {
    final moodLower = mood.toLowerCase();
    if (moodLower.contains('mutlu') || moodLower.contains('neşeli')) {
      return AuraColor.yellow;
    } else if (moodLower.contains('sakin') || moodLower.contains('huzurlu')) {
      return AuraColor.blue;
    } else if (moodLower.contains('tutkulu') || moodLower.contains('enerjik')) {
      return AuraColor.red;
    } else if (moodLower.contains('yaratıcı') ||
        moodLower.contains('ilhamlı')) {
      return AuraColor.orange;
    } else if (moodLower.contains('sevgi') || moodLower.contains('romantik')) {
      return AuraColor.pink;
    } else if (moodLower.contains('spiritüel') || moodLower.contains('derin')) {
      return AuraColor.violet;
    } else if (moodLower.contains('topraklanmış') ||
        moodLower.contains('güvende')) {
      return AuraColor.green;
    }
    return AuraColor.white;
  }

  static Map<Chakra, int> _calculateChakraAlignment(DateTime birthDate) {
    final day = birthDate.day;
    final month = birthDate.month;

    return {
      Chakra.root: ((day + month) % 10) * 10 + 50,
      Chakra.sacral: ((day + 1) % 10) * 10 + 50,
      Chakra.solarPlexus: ((day + 2) % 10) * 10 + 50,
      Chakra.heart: ((day + 3) % 10) * 10 + 50,
      Chakra.throat: ((day + 4) % 10) * 10 + 50,
      Chakra.thirdEye: ((day + 5) % 10) * 10 + 50,
      Chakra.crown: ((day + 6) % 10) * 10 + 50,
    };
  }

  static int _calculateOverallEnergy(AuraColor primary, AuraColor? secondary) {
    var base = primary.baseEnergy;
    if (secondary != null) {
      // Uyumlu renkler enerjiyi artırır
      if (_areHarmoniousColors(primary, secondary)) {
        base += 15;
      }
    }
    return base.clamp(0, 100);
  }

  static bool _areHarmoniousColors(AuraColor a, AuraColor b) {
    final harmonious = {
      AuraColor.red: [AuraColor.orange, AuraColor.yellow],
      AuraColor.orange: [AuraColor.red, AuraColor.yellow],
      AuraColor.yellow: [AuraColor.orange, AuraColor.green],
      AuraColor.green: [AuraColor.yellow, AuraColor.blue],
      AuraColor.blue: [AuraColor.green, AuraColor.indigo],
      AuraColor.indigo: [AuraColor.blue, AuraColor.violet],
      AuraColor.violet: [AuraColor.indigo, AuraColor.pink],
      AuraColor.pink: [AuraColor.violet, AuraColor.white],
      AuraColor.white: [AuraColor.pink, AuraColor.gold],
      AuraColor.gold: [AuraColor.white, AuraColor.yellow],
    };
    return harmonious[a]?.contains(b) ?? false;
  }

  static String _getSpiritualAdvice(AuraColor aura) {
    switch (aura) {
      case AuraColor.red:
        return 'Enerjini toprakla. Fiziksel aktivite ve doğa yürüyüşleri auranı dengeleyecektir.';
      case AuraColor.orange:
        return 'Yaratıcılığını ifade et. Sanat, dans veya müzik auranı güçlendirecektir.';
      case AuraColor.yellow:
        return 'Zihinsel berraklığını koru. Öğrenme ve öğretme auranı parlatacaktır.';
      case AuraColor.green:
        return 'Kalbini aç. Şifa çalışmaları ve başkalarına yardım auranı büyütecektir.';
      case AuraColor.blue:
        return 'Hakikatini konuş. Dürüst iletişim ve özgün ifade auranı güçlendirecektir.';
      case AuraColor.indigo:
        return 'Sezgine güven. Meditasyon ve rüya çalışması auranı derinleştirecektir.';
      case AuraColor.violet:
        return 'Kozmik bağlantını güçlendir. Spiritüel pratikler ve hizmet auranı yükseltecektir.';
      case AuraColor.pink:
        return 'Koşulsuz sevgiyi yay. Şefkat ve empati auranı genişletecektir.';
      case AuraColor.white:
        return 'Saflığını koru. Arınma ritüelleri ve meditasyon auranı koruyacaktır.';
      case AuraColor.gold:
        return 'İlahi bağlantını hatırla. Dua ve şükran auranı parlatacaktır.';
    }
  }

  static int _calculateEnergyLevel(int basePath, int todayNumber) {
    final diff = (basePath - todayNumber).abs();
    if (diff == 0) return 95;
    if (diff <= 2) return 85;
    if (diff <= 4) return 70;
    return 60;
  }

  static String _getDailyGuidance(AuraColor base, AuraColor today) {
    if (base == today) {
      return 'Bugün auran en güçlü halinde. Doğal yeteneklerini kullanmak için ideal bir gün.';
    } else if (_areHarmoniousColors(base, today)) {
      return 'Bugünün enerjisi auranla uyumlu. Akışta kal ve fırsatları değerlendir.';
    } else {
      return 'Bugün farklı bir enerji akışı var. Esneklik ve adaptasyon önemli. Dengeyi bul.';
    }
  }

  static String _getDailyAffirmation(AuraColor aura) {
    switch (aura) {
      case AuraColor.red:
        return 'Güçlü ve güvendeyim. Korkusuzca ilerlerim.';
      case AuraColor.orange:
        return 'Yaratıcılığım sınırsız. Neşeyle ifade ederim.';
      case AuraColor.yellow:
        return 'Zihnim berrak, iradem güçlü. Başarı benim.';
      case AuraColor.green:
        return 'Kalbim açık, sevgim sonsuz. Şifa taşıyorum.';
      case AuraColor.blue:
        return 'Hakikatimi konuşurum. Sesim güçlüdür.';
      case AuraColor.indigo:
        return 'Sezgilerime güvenirim. İç bilgeliğim rehberimdir.';
      case AuraColor.violet:
        return 'Evrenle birlikteyim. Yüksek amacıma hizmet ederim.';
      case AuraColor.pink:
        return 'Sevgi veririm, sevgi alırım. Şefkat doğamdır.';
      case AuraColor.white:
        return 'Saf ışıktayım. İlahi koruma benimledir.';
      case AuraColor.gold:
        return 'İlahi enerjiyim. Bolluk ve bereket benimle akar.';
    }
  }
}

/// Aura renkleri
enum AuraColor {
  red,
  orange,
  yellow,
  green,
  blue,
  indigo,
  violet,
  pink,
  white,
  gold,
}

extension AuraColorExtension on AuraColor {
  String get name {
    switch (this) {
      case AuraColor.red:
        return 'Red';
      case AuraColor.orange:
        return 'Orange';
      case AuraColor.yellow:
        return 'Yellow';
      case AuraColor.green:
        return 'Green';
      case AuraColor.blue:
        return 'Blue';
      case AuraColor.indigo:
        return 'Indigo';
      case AuraColor.violet:
        return 'Violet';
      case AuraColor.pink:
        return 'Pink';
      case AuraColor.white:
        return 'White';
      case AuraColor.gold:
        return 'Gold';
    }
  }

  String get nameTr {
    switch (this) {
      case AuraColor.red:
        return 'Kırmızı';
      case AuraColor.orange:
        return 'Turuncu';
      case AuraColor.yellow:
        return 'Sarı';
      case AuraColor.green:
        return 'Yeşil';
      case AuraColor.blue:
        return 'Mavi';
      case AuraColor.indigo:
        return 'Çivit';
      case AuraColor.violet:
        return 'Mor';
      case AuraColor.pink:
        return 'Pembe';
      case AuraColor.white:
        return 'Beyaz';
      case AuraColor.gold:
        return 'Altın';
    }
  }

  Color get color {
    switch (this) {
      case AuraColor.red:
        return const Color(0xFFE53935);
      case AuraColor.orange:
        return const Color(0xFFFF9800);
      case AuraColor.yellow:
        return const Color(0xFFFFEB3B);
      case AuraColor.green:
        return const Color(0xFF4CAF50);
      case AuraColor.blue:
        return const Color(0xFF2196F3);
      case AuraColor.indigo:
        return const Color(0xFF3F51B5);
      case AuraColor.violet:
        return const Color(0xFF9C27B0);
      case AuraColor.pink:
        return const Color(0xFFE91E63);
      case AuraColor.white:
        return const Color(0xFFF5F5F5);
      case AuraColor.gold:
        return const Color(0xFFFFD700);
    }
  }

  String get meaning {
    switch (this) {
      case AuraColor.red:
        return 'Güçlü yaşam enerjisi, tutku ve fiziksel güç. Topraklı ve hayatta kalmaya odaklı.';
      case AuraColor.orange:
        return 'Yaratıcılık, duygusal ifade ve sosyallik. Neşeli ve maceracı ruh.';
      case AuraColor.yellow:
        return 'Zihinsel güç, iyimserlik ve özgüven. Entelektüel ve analitik.';
      case AuraColor.green:
        return 'Şifa enerjisi, denge ve büyüme. Kalp merkezli ve besleyici.';
      case AuraColor.blue:
        return 'İletişim, hakikat ve sakinlik. Güvenilir ve barışçıl.';
      case AuraColor.indigo:
        return 'Derin sezgi, spiritüel farkındalık ve içgörü. Mistik ve vizyoner.';
      case AuraColor.violet:
        return 'Spiritüel bağlantı, dönüşüm ve bilgelik. Yüksek bilinç.';
      case AuraColor.pink:
        return 'Koşulsuz sevgi, şefkat ve romantizm. Hassas ve sevgi dolu.';
      case AuraColor.white:
        return 'Saflık, ilahi koruma ve yüksek spiritüel gelişim. Aydınlanmış.';
      case AuraColor.gold:
        return 'İlahi bilgelik, koruma ve bolluk. Spiritüel liderlik.';
    }
  }

  int get baseEnergy {
    switch (this) {
      case AuraColor.red:
        return 80;
      case AuraColor.orange:
        return 75;
      case AuraColor.yellow:
        return 70;
      case AuraColor.green:
        return 75;
      case AuraColor.blue:
        return 70;
      case AuraColor.indigo:
        return 65;
      case AuraColor.violet:
        return 60;
      case AuraColor.pink:
        return 70;
      case AuraColor.white:
        return 85;
      case AuraColor.gold:
        return 90;
    }
  }

  Chakra get chakra {
    switch (this) {
      case AuraColor.red:
        return Chakra.root;
      case AuraColor.orange:
        return Chakra.sacral;
      case AuraColor.yellow:
        return Chakra.solarPlexus;
      case AuraColor.green:
        return Chakra.heart;
      case AuraColor.blue:
        return Chakra.throat;
      case AuraColor.indigo:
        return Chakra.thirdEye;
      case AuraColor.violet:
        return Chakra.crown;
      case AuraColor.pink:
        return Chakra.heart;
      case AuraColor.white:
        return Chakra.crown;
      case AuraColor.gold:
        return Chakra.crown;
    }
  }

  String get meditationFocus {
    switch (this) {
      case AuraColor.red:
        return 'topraklanma ve güvenlik';
      case AuraColor.orange:
        return 'yaratıcılık ve duygusal akış';
      case AuraColor.yellow:
        return 'kişisel güç ve özgüven';
      case AuraColor.green:
        return 'kalp açılımı ve şifa';
      case AuraColor.blue:
        return 'iletişim ve özgün ifade';
      case AuraColor.indigo:
        return 'üçüncü göz ve sezgi';
      case AuraColor.violet:
        return 'taç chakra ve evrensel bağlantı';
      case AuraColor.pink:
        return 'koşulsuz sevgi ve şefkat';
      case AuraColor.white:
        return 'arınma ve koruma';
      case AuraColor.gold:
        return 'ilahi bağlantı ve bolluk';
    }
  }

  String get recommendedCrystal {
    switch (this) {
      case AuraColor.red:
        return 'Kırmızı Jasper veya Garnet';
      case AuraColor.orange:
        return 'Karneol veya Turuncu Kalsit';
      case AuraColor.yellow:
        return 'Sitrin veya Kaplan Gözü';
      case AuraColor.green:
        return 'Yeşil Aventurin veya Zümrüt';
      case AuraColor.blue:
        return 'Lapis Lazuli veya Akuamarin';
      case AuraColor.indigo:
        return 'Ametist veya Sodalit';
      case AuraColor.violet:
        return 'Mor Ametist veya Sugilit';
      case AuraColor.pink:
        return 'Pembe Kuvars veya Rodonit';
      case AuraColor.white:
        return 'Şeffaf Kuvars veya Selenit';
      case AuraColor.gold:
        return 'Altın Topaz veya Pirit';
    }
  }

  String get natureConnection {
    switch (this) {
      case AuraColor.red:
        return 'Yalın ayak toprakta yürü. Ağaçlara sarıl.';
      case AuraColor.orange:
        return 'Gün batımını izle. Su kenarında zaman geçir.';
      case AuraColor.yellow:
        return 'Güneş banyosu yap. Çiçekli bahçelerde ol.';
      case AuraColor.green:
        return 'Ormanda yürü. Bitkilerle ilgilen.';
      case AuraColor.blue:
        return 'Deniz veya göl kenarında ol. Gökyüzünü izle.';
      case AuraColor.indigo:
        return 'Gece gökyüzünü ve yıldızları izle.';
      case AuraColor.violet:
        return 'Dağlarda veya yüksek yerlerde ol.';
      case AuraColor.pink:
        return 'Çiçek bahçelerinde zaman geçir.';
      case AuraColor.white:
        return 'Kar veya bulutları izle. Temiz havada ol.';
      case AuraColor.gold:
        return 'Gün doğumunu izle. Güneş ışığında ol.';
    }
  }

  int get soundFrequency {
    switch (this) {
      case AuraColor.red:
        return 396;
      case AuraColor.orange:
        return 417;
      case AuraColor.yellow:
        return 528;
      case AuraColor.green:
        return 639;
      case AuraColor.blue:
        return 741;
      case AuraColor.indigo:
        return 852;
      case AuraColor.violet:
        return 963;
      case AuraColor.pink:
        return 639;
      case AuraColor.white:
        return 963;
      case AuraColor.gold:
        return 963;
    }
  }

  static AuraColor fromLifePath(int lifePath) {
    switch (lifePath) {
      case 1:
        return AuraColor.red;
      case 2:
        return AuraColor.blue;
      case 3:
        return AuraColor.yellow;
      case 4:
        return AuraColor.green;
      case 5:
        return AuraColor.orange;
      case 6:
        return AuraColor.pink;
      case 7:
        return AuraColor.indigo;
      case 8:
        return AuraColor.gold;
      case 9:
        return AuraColor.violet;
      case 11:
        return AuraColor.white;
      case 22:
        return AuraColor.gold;
      case 33:
        return AuraColor.violet;
      default:
        return AuraColor.white;
    }
  }

  static AuraColor fromNumber(int number) {
    switch (number % 10) {
      case 1:
        return AuraColor.red;
      case 2:
        return AuraColor.blue;
      case 3:
        return AuraColor.yellow;
      case 4:
        return AuraColor.green;
      case 5:
        return AuraColor.orange;
      case 6:
        return AuraColor.pink;
      case 7:
        return AuraColor.indigo;
      case 8:
        return AuraColor.gold;
      case 9:
        return AuraColor.violet;
      case 0:
        return AuraColor.white;
      default:
        return AuraColor.white;
    }
  }
}

/// Chakra enum
enum Chakra { root, sacral, solarPlexus, heart, throat, thirdEye, crown }

extension ChakraExtension on Chakra {
  String get name {
    switch (this) {
      case Chakra.root:
        return 'Root';
      case Chakra.sacral:
        return 'Sacral';
      case Chakra.solarPlexus:
        return 'Solar Plexus';
      case Chakra.heart:
        return 'Heart';
      case Chakra.throat:
        return 'Throat';
      case Chakra.thirdEye:
        return 'Third Eye';
      case Chakra.crown:
        return 'Crown';
    }
  }

  String get nameTr {
    switch (this) {
      case Chakra.root:
        return 'Kök Chakra';
      case Chakra.sacral:
        return 'Sakral Chakra';
      case Chakra.solarPlexus:
        return 'Solar Pleksus';
      case Chakra.heart:
        return 'Kalp Chakra';
      case Chakra.throat:
        return 'Boğaz Chakra';
      case Chakra.thirdEye:
        return 'Üçüncü Göz';
      case Chakra.crown:
        return 'Taç Chakra';
    }
  }

  String get mantras {
    switch (this) {
      case Chakra.root:
        return 'LAM';
      case Chakra.sacral:
        return 'VAM';
      case Chakra.solarPlexus:
        return 'RAM';
      case Chakra.heart:
        return 'YAM';
      case Chakra.throat:
        return 'HAM';
      case Chakra.thirdEye:
        return 'OM';
      case Chakra.crown:
        return 'OM / Sessizlik';
    }
  }

  Color get color {
    switch (this) {
      case Chakra.root:
        return const Color(0xFFE53935);
      case Chakra.sacral:
        return const Color(0xFFFF9800);
      case Chakra.solarPlexus:
        return const Color(0xFFFFEB3B);
      case Chakra.heart:
        return const Color(0xFF4CAF50);
      case Chakra.throat:
        return const Color(0xFF2196F3);
      case Chakra.thirdEye:
        return const Color(0xFF3F51B5);
      case Chakra.crown:
        return const Color(0xFF9C27B0);
    }
  }
}

/// Aura profili
class AuraProfile {
  final AuraColor primaryColor;
  final AuraColor? secondaryColor;
  final AuraColor? moodColor;
  final Map<Chakra, int> chakraAlignment;
  final int overallEnergy;
  final String spiritualAdvice;

  AuraProfile({
    required this.primaryColor,
    this.secondaryColor,
    this.moodColor,
    required this.chakraAlignment,
    required this.overallEnergy,
    required this.spiritualAdvice,
  });
}

/// Günlük aura enerjisi
class DailyAuraEnergy {
  final DateTime date;
  final AuraColor baseAura;
  final AuraColor todayAura;
  final int energyLevel;
  final String guidance;
  final String affirmation;

  DailyAuraEnergy({
    required this.date,
    required this.baseAura,
    required this.todayAura,
    required this.energyLevel,
    required this.guidance,
    required this.affirmation,
  });
}

/// Aura temizleme ipucu
class AuraCleansingTip {
  final String title;
  final String description;
  final String icon;

  AuraCleansingTip({
    required this.title,
    required this.description,
    required this.icon,
  });
}
