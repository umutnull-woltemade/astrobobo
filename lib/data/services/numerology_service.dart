/// Numerology calculations service
class NumerologyService {
  /// Calculate Life Path Number from birth date
  static int calculateLifePathNumber(DateTime birthDate) {
    final day = _reduceToSingleDigit(birthDate.day);
    final month = _reduceToSingleDigit(birthDate.month);
    final year = _reduceToSingleDigit(birthDate.year);

    final sum = day + month + year;
    return _reduceToSingleDigitOrMaster(sum);
  }

  /// Calculate Destiny/Expression Number from full name
  static int calculateDestinyNumber(String fullName) {
    final name = fullName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    var sum = 0;

    for (final char in name.split('')) {
      sum += _letterToNumber(char);
    }

    return _reduceToSingleDigitOrMaster(sum);
  }

  /// Calculate Soul Urge/Heart's Desire Number (vowels only)
  static int calculateSoulUrgeNumber(String fullName) {
    final name = fullName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    const vowels = 'AEIOU';
    var sum = 0;

    for (final char in name.split('')) {
      if (vowels.contains(char)) {
        sum += _letterToNumber(char);
      }
    }

    return _reduceToSingleDigitOrMaster(sum);
  }

  /// Calculate Personality Number (consonants only)
  static int calculatePersonalityNumber(String fullName) {
    final name = fullName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    const vowels = 'AEIOU';
    var sum = 0;

    for (final char in name.split('')) {
      if (!vowels.contains(char)) {
        sum += _letterToNumber(char);
      }
    }

    return _reduceToSingleDigitOrMaster(sum);
  }

  /// Calculate Birthday Number (just the day)
  static int calculateBirthdayNumber(DateTime birthDate) {
    return _reduceToSingleDigitOrMaster(birthDate.day);
  }

  /// Calculate Personal Year Number
  static int calculatePersonalYearNumber(DateTime birthDate, int currentYear) {
    final day = _reduceToSingleDigit(birthDate.day);
    final month = _reduceToSingleDigit(birthDate.month);
    final year = _reduceToSingleDigit(currentYear);

    return _reduceToSingleDigitOrMaster(day + month + year);
  }

  /// Calculate Personal Month Number
  static int calculatePersonalMonthNumber(
    DateTime birthDate,
    int currentYear,
    int currentMonth,
  ) {
    final personalYear = calculatePersonalYearNumber(birthDate, currentYear);
    return _reduceToSingleDigitOrMaster(personalYear + currentMonth);
  }

  /// Calculate Karmic Debt Numbers (13, 14, 16, 19)
  static List<int> findKarmicDebtNumbers(DateTime birthDate) {
    final karmicNumbers = <int>[];

    // Check in life path calculation
    final day = birthDate.day;
    final year = birthDate.year;

    if (day == 13 || day == 14 || day == 16 || day == 19) {
      karmicNumbers.add(day);
    }

    final yearSum = _digitSum(year);
    if (yearSum == 13 || yearSum == 14 || yearSum == 16 || yearSum == 19) {
      karmicNumbers.add(yearSum);
    }

    return karmicNumbers;
  }

  /// Calculate Compatibility Score between two people
  static NumerologyCompatibility calculateCompatibility(
    DateTime date1,
    DateTime date2, {
    String? name1,
    String? name2,
  }) {
    final lifeP1 = calculateLifePathNumber(date1);
    final lifeP2 = calculateLifePathNumber(date2);

    // Life Path compatibility
    final lifePathScore = _getLifePathCompatibility(lifeP1, lifeP2);

    int? destinyScore;
    int? soulScore;

    if (name1 != null && name2 != null) {
      final destiny1 = calculateDestinyNumber(name1);
      final destiny2 = calculateDestinyNumber(name2);
      destinyScore = _getNumberCompatibility(destiny1, destiny2);

      final soul1 = calculateSoulUrgeNumber(name1);
      final soul2 = calculateSoulUrgeNumber(name2);
      soulScore = _getNumberCompatibility(soul1, soul2);
    }

    return NumerologyCompatibility(
      lifePathScore: lifePathScore,
      destinyScore: destinyScore,
      soulUrgeScore: soulScore,
      person1LifePath: lifeP1,
      person2LifePath: lifeP2,
    );
  }

  static int _reduceToSingleDigit(int number) {
    while (number > 9) {
      number = _digitSum(number);
    }
    return number;
  }

  static int _reduceToSingleDigitOrMaster(int number) {
    // Keep master numbers 11, 22, 33
    while (number > 9 && number != 11 && number != 22 && number != 33) {
      number = _digitSum(number);
    }
    return number;
  }

  static int _digitSum(int number) {
    var sum = 0;
    while (number > 0) {
      sum += number % 10;
      number ~/= 10;
    }
    return sum;
  }

  static int _letterToNumber(String letter) {
    const values = {
      'A': 1,
      'B': 2,
      'C': 3,
      'D': 4,
      'E': 5,
      'F': 6,
      'G': 7,
      'H': 8,
      'I': 9,
      'J': 1,
      'K': 2,
      'L': 3,
      'M': 4,
      'N': 5,
      'O': 6,
      'P': 7,
      'Q': 8,
      'R': 9,
      'S': 1,
      'T': 2,
      'U': 3,
      'V': 4,
      'W': 5,
      'X': 6,
      'Y': 7,
      'Z': 8,
    };
    return values[letter] ?? 0;
  }

  static int _getLifePathCompatibility(int lp1, int lp2) {
    // Compatibility matrix (simplified)
    final compatiblePairs = {
      1: [1, 3, 5, 7],
      2: [2, 4, 6, 8],
      3: [1, 3, 5, 9],
      4: [2, 4, 6, 8],
      5: [1, 3, 5, 7, 9],
      6: [2, 4, 6, 9],
      7: [1, 5, 7],
      8: [2, 4, 8],
      9: [3, 5, 6, 9],
      11: [2, 11, 22],
      22: [4, 11, 22, 33],
      33: [6, 22, 33],
    };

    if (lp1 == lp2) return 95;
    if (compatiblePairs[lp1]?.contains(lp2) ?? false) return 85;
    return 60;
  }

  static int _getNumberCompatibility(int n1, int n2) {
    if (n1 == n2) return 95;
    final diff = (n1 - n2).abs();
    if (diff <= 2) return 85;
    if (diff <= 4) return 70;
    return 55;
  }

  /// Get meaning of a number
  static NumerologyMeaning getNumberMeaning(int number) {
    return NumerologyMeaning.fromNumber(number);
  }
}

/// Numerology compatibility result
class NumerologyCompatibility {
  final int lifePathScore;
  final int? destinyScore;
  final int? soulUrgeScore;
  final int person1LifePath;
  final int person2LifePath;

  NumerologyCompatibility({
    required this.lifePathScore,
    this.destinyScore,
    this.soulUrgeScore,
    required this.person1LifePath,
    required this.person2LifePath,
  });

  int get overallScore {
    var total = lifePathScore;
    var count = 1;
    if (destinyScore != null) {
      total += destinyScore!;
      count++;
    }
    if (soulUrgeScore != null) {
      total += soulUrgeScore!;
      count++;
    }
    return (total / count).round();
  }
}

/// Meaning of numerology numbers
class NumerologyMeaning {
  final int number;
  final String title;
  final String keywords;
  final String meaning;
  final String strengths;
  final String challenges;
  final String loveStyle;
  final String detailedInterpretation;
  final String careerPath;
  final String spiritualLesson;
  final String shadowSide;
  final String compatibleNumbers;

  NumerologyMeaning({
    required this.number,
    required this.title,
    required this.keywords,
    required this.meaning,
    required this.strengths,
    required this.challenges,
    required this.loveStyle,
    this.detailedInterpretation = '',
    this.careerPath = '',
    this.spiritualLesson = '',
    this.shadowSide = '',
    this.compatibleNumbers = '',
  });

  factory NumerologyMeaning.fromNumber(int number) {
    switch (number) {
      case 1:
        return NumerologyMeaning(
          number: 1,
          title: 'Lider',
          keywords: 'Bağımsızlık • Öncülük • Yaratıcılık',
          meaning:
              'Doğal liderler, yenilikçiler ve öncülerdir. Bağımsızlık en büyük değerleridir.',
          strengths: 'Kararlılık, özgüven, yaratıcılık, girişimcilik',
          challenges: 'İnatçılık, bencillik, sabırsızlık',
          loveStyle: 'Bağımsız ama sadık, liderlik almak ister',
          detailedInterpretation: '''
1 sayısı kozmik enerjinin ilk tezahürüdür - saf potansiyel, başlangıç noktası, yaratıcı kıvılcım. Bu sayıyla doğanlar evrene "Ben varım" mesajıyla geldiler.

Ruhunuz öncü olmak için tasarlandı. Yeni yollar açmak, ilk adımı atmak, kimsenin gitmediği yerlere gitmek sizin doğanızda var. Liderlik sizin için bir tercih değil, varoluşsal bir zorunluluk.

1 enerjisi Güneş'le ilişkilidir - merkezdeki, ışık saçan, hayat veren güç. Tıpkı Güneş gibi, etrafınızdakileri aydınlatır ve ısıtırsınız ama bazen de yakabilirsiniz.

Bu sayının golge yönü izolasyon ve kibir. "Ben en iyisini bilirim" düşüncesi yalnızlığa götürebilir. Dengenizi bulmak için işbirliğini ve alçakgönüllülüğü öğrenmeniz gerekir.
''',
          careerPath:
              'Girişimcilik, yöneticilik, inovasyon, kendi işini kurma, spor, sanat yönetmenliği',
          spiritualLesson:
              'Ego ile ruh arasındaki dengeyi bulmak. Liderliğin hizmet olduğunu anlamak.',
          shadowSide: 'Bencillik, diktatörlük, eleştiriye kapalılık, yalnızlık',
          compatibleNumbers: '1, 3, 5, 7',
        );
      case 2:
        return NumerologyMeaning(
          number: 2,
          title: 'Diplomat',
          keywords: 'Denge • Ortaklık • Sezgi',
          meaning:
              'Barışçıl, işbirlikçi ve duyarlıdırlar. İlişkilerde uyum ararlar.',
          strengths: 'Diplomasi, empati, sabır, işbirliği',
          challenges: 'Kararsızlık, aşırı hassasiyet, bağımlılık',
          loveStyle: 'Romantik, destekleyici, uyumlu partner',
          detailedInterpretation: '''
2 sayısı dualiteyi, birleşimi ve dengeyi temsil eder - Yin ve Yang, gece ve gündüz, erkil ve dişil. Bu sayıyla doğanlar "Biz varız" mesajıyla dünyaya geldiler.

Ruhunuz birleştirmek, dengelemek ve uyum yaratmak için tasarlandı. İlişkiler sizin öğrenme alanınız - yalnız başına bir anlam ifade etmezsiniz, bir ayna gerekir.

2 enerjisi Ay'la ilişkilidir - yansıtan, döngüsel, duygusal. Tıpkı Ay gibi sezgiselsiniz, çevrenizdeki enerjileri hisseder ve yansıtırsınız.

Bu sayının gölge yönü aşırı bağımlılık ve kimlik kaybı. Başkalarını mutlu etme çabasında kendinizi kaybedebilirsiniz. Dengenizi bulmak için kendi sesinizi bulmanız gerekir.
''',
          careerPath:
              'Danışmanlık, terapi, insan kaynakları, diplomasi, müzakereci, arabuluculuk',
          spiritualLesson:
              'Kendi kimliğini koruyarak birleşmek. Sınır koymayı öğrenmek.',
          shadowSide:
              'Kararsızlık, çatışmadan kaçış, pasif-agresiflik, kimlik kaybı',
          compatibleNumbers: '2, 4, 6, 8',
        );
      case 3:
        return NumerologyMeaning(
          number: 3,
          title: 'Yaratıcı',
          keywords: 'İfade • Neşe • İletişim',
          meaning:
              'Sanatsal, sosyal ve enerjik bireylerdir. Kendilerini ifade etmeyi severler.',
          strengths: 'Yaratıcılık, sosyallik, iyimserlik, ifade gücü',
          challenges: 'Dağınıklık, yüzeysellik, kendini ifade edememe korkusu',
          loveStyle: 'Eğlenceli, romantik, spontan ilişkiler',
          detailedInterpretation: '''
3 sayısı kutsal üçlüyü temsil eder - yaratıcı, yaratım ve yaratılış. Baba, Ana, Çocuk. Başlangıç, orta, son. Bu sayıyla doğanlar "İfade ediyorum" mesajıyla dünyaya geldiler.

Ruhunuz yaratmak, iletmek ve neşe yaymak için tasarlandı. Kelimeler, renkler, sesler ve hareketler sizin araçlarınız. Sessiz kalmak sizin için ruhsal bir hapishane.

3 enerjisi Jüpiter'le ilişkilidir - genişleten, iyimser, bereketli. Tıpkı Jüpiter gibi hayatı büyütür, zenginleştirir ve renklendirirsiniz.

Bu sayının gölge yönü dağınıklık ve yüzeysellik. Her şeye dokunup hiçbirini derinleştirmemek tehlikesi. Dengenizi bulmak için odaklanmayı öğrenmeniz gerekir.
''',
          careerPath:
              'Sanat, yazarlık, oyunculuk, müzik, pazarlama, iletişim, eğlence sektörü',
          spiritualLesson:
              'Yaratıcılığı disiplinle birleştirmek. İfadenin sorumluluğunu taşımak.',
          shadowSide: 'Dağınıklık, yüzeysellik, dedikodu, enerjinin israfı',
          compatibleNumbers: '1, 3, 5, 9',
        );
      case 4:
        return NumerologyMeaning(
          number: 4,
          title: 'İnşacı',
          keywords: 'Düzen • Çalışkanlık • Güvenilirlik',
          meaning:
              'Pratik, disiplinli ve güvenilirdirler. Sağlam temeller kurarlar.',
          strengths: 'Organizasyon, sadakat, azim, pratiklik',
          challenges: 'Katılık, inatçılık, aşırı temkinlilik',
          loveStyle: 'Sadık, güvenilir, geleneksel değerler',
          detailedInterpretation: '''
4 sayısı maddi dünyanın temelini temsil eder - dört element, dört yön, dört mevsim. Bu sayıyla doğanlar "İnşa ediyorum" mesajıyla dünyaya geldiler.

Ruhunuz kalıcı yapılar kurmak için tasarlandı - fiziksel, duygusal veya zihinsel. Rüyaları gerçeğe dönüştürmek sizin özel yeteneğiniz.

4 enerjisi Satürn'le ilişkilidir - disiplinli, sınırlayıcı, öğretici. Tıpkı Satürn gibi kuralları, yapıları ve sorumluluğu temsil edersiniz.

Bu sayının gölge yönü katılık ve korkuya dayalı kontrol. Her şeyi planlamaya çalışmak spontanlığı öldürür. Dengenizi bulmak için esnekliği öğrenmeniz gerekir.
''',
          careerPath:
              'Mühendislik, mimarlık, muhasebe, proje yönetimi, bankacılık, emlak',
          spiritualLesson:
              'Güvenliğin içeriden geldiğini anlamak. Kontrolü bırakmayı öğrenmek.',
          shadowSide: 'Katılık, işkoliklik, kontrol takıntısı, değişim korkusu',
          compatibleNumbers: '2, 4, 6, 8',
        );
      case 5:
        return NumerologyMeaning(
          number: 5,
          title: 'Özgür Ruh',
          keywords: 'Değişim • Macera • Özgürlük',
          meaning:
              'Maceracı, çok yönlü ve değişim seven bireylerdir. Sınırları sevmezler.',
          strengths: 'Uyum, cesaret, merak, çok yönlülük',
          challenges: 'Huzursuzluk, aşırı risk alma, bağlılık korkusu',
          loveStyle: 'Heyecan arayan, özgürlüğüne düşkün, spontan',
          detailedInterpretation: '''
5 sayısı değişimi ve beş duyuyu temsil eder - hayatı deneyimlemek, tatmak, hissetmek. Bu sayıyla doğanlar "Özgürüm" mesajıyla dünyaya geldiler.

Ruhunuz keşfetmek, deneyimlemek ve dönüşmek için tasarlandı. Rutin sizin için ölüm, değişim ise yaşam demek. Dünya sizin oyun alanınız.

5 enerjisi Merkür'le ilişkilidir - hareketli, iletişimci, adaptif. Tıpkı Merkür gibi hızlı, çevik ve değişkensiniz.

Bu sayının gölge yönü dağınıklık ve bağımlılık yapan arayış. Her şeyi deneyip hiçbirinde kalmamak. Dengenizi bulmak için taahhüt etmeyi öğrenmeniz gerekir.
''',
          careerPath:
              'Seyahat, satış, medya, pazarlama, girişimcilik, danışmanlık, eğlence',
          spiritualLesson:
              'Özgürlüğün taahhütle birlikte var olabileceğini anlamak.',
          shadowSide:
              'Bağlanma korkusu, aşırı risk alma, bağımlılıklar, huzursuzluk',
          compatibleNumbers: '1, 3, 5, 7, 9',
        );
      case 6:
        return NumerologyMeaning(
          number: 6,
          title: 'Bakıcı',
          keywords: 'Sorumluluk • Aile • Uyum',
          meaning:
              'Besleyici, sorumlu ve aile odaklıdırlar. Başkalarına yardım etmeyi severler.',
          strengths: 'Şefkat, sorumluluk, estetik, iyileştirme',
          challenges: 'Aşırı koruyuculuk, mükemmeliyetçilik, fedakarlık',
          loveStyle: 'Bakım veren, sadık, uzun vadeli ilişkiler',
          detailedInterpretation: '''
6 sayısı uyumu, güzelliği ve sorumluluğu temsil eder - altı yönlü yıldız, mükemmel denge. Bu sayıyla doğanlar "Şifa veriyorum" mesajıyla dünyaya geldiler.

Ruhunuz bakım vermek, iyileştirmek ve güzellik yaratmak için tasarlandı. Aile - ister kan bağı olsun ister seçilmiş - sizin kutsal alanınız.

6 enerjisi Venüs'le ilişkilidir - sevgi, güzellik, uyum. Tıpkı Venüs gibi etrafınıza güzellik ve şifa yayarsınız.

Bu sayının gölge yönü müdahaleci koruyuculuk ve mükemmeliyetçilik. Herkesi kurtarmaya çalışmak kendinizi ihmal etmenize yol açar. Dengenizi bulmak için sınır koymayı öğrenmeniz gerekir.
''',
          careerPath:
              'Sağlık, terapi, eğitim, iç mimari, güzellik, aile danışmanlığı, sosyal hizmet',
          spiritualLesson:
              'Başkalarına bakmadan önce kendine bakmayı öğrenmek.',
          shadowSide:
              'Müdahalecilik, fedakarlık kompleksi, mükemmeliyetçilik, eleştiri',
          compatibleNumbers: '2, 4, 6, 9',
        );
      case 7:
        return NumerologyMeaning(
          number: 7,
          title: 'Arayışçı',
          keywords: 'Bilgelik • Analiz • Spiritüellik',
          meaning:
              'Düşünür, araştırmacı ve spiritüel arayış içinde olan bireylerdir.',
          strengths: 'Analitik zeka, sezgi, derinlik, bilgelik',
          challenges: 'İzolasyon, şüphecilik, duygusal mesafe',
          loveStyle: 'Derin bağ arayan, entelektüel uyum önemli',
          detailedInterpretation: '''
7 sayısı mistik sayıdır - yedi gezegen, yedi çakra, yedi gün. Bu sayıyla doğanlar "Anlıyorum" mesajıyla dünyaya geldiler.

Ruhunuz gerçeği aramak, derinliklere inmek ve bilgelik bulmak için tasarlandı. Yüzeysel cevaplar sizi tatmin etmez - her şeyin altında yatan anlamı ararsınız.

7 enerjisi Neptün'le ilişkilidir - mistik, sezgisel, spiritüel. Tıpkı Neptün gibi görünmeyeni görür, bilinmeyeni hissedersiniz.

Bu sayının gölge yönü izolasyon ve şüphecilik. Kafanızdaki dünyada kaybolup gerçek dünyadan kopmak. Dengenizi bulmak için topraklanmayı öğrenmeniz gerekir.
''',
          careerPath:
              'Araştırma, akademi, psikoloji, felsefe, yazarlık, spiritüel öğretmenlik, analiz',
          spiritualLesson:
              'İçsel bilgeliği dış dünyayla paylaşmak. Yalnızlık ile izolasyon farkı.',
          shadowSide: 'Aşırı analiz, paranoya, duygusal kapalılık, kibir',
          compatibleNumbers: '1, 5, 7',
        );
      case 8:
        return NumerologyMeaning(
          number: 8,
          title: 'Güç Sahibi',
          keywords: 'Başarı • Maddi Güç • Otorite',
          meaning:
              'Hırslı, güçlü ve başarı odaklıdırlar. Maddi dünyada ustadırlar.',
          strengths: 'Liderlik, iş zekası, kararlılık, güç',
          challenges: 'İşkoliklik, kontrol ihtiyacı, maddecilik',
          loveStyle: 'Güvenlik arayan, sadık, güçlü partner',
          detailedInterpretation: '''
8 sayısı sonsuzluk sembolü ve maddi güç sayısıdır - karma, denge, manifestasyon. Bu sayıyla doğanlar "Başarıyorum" mesajıyla dünyaya geldiler.

Ruhunuz maddi dünyada ustalaşmak için tasarlandı. Para, güç ve etki sizin araçlarınız - ama bunlar amaç değil, araç. Gerçek sınav: gücü nasıl kullanıyorsunuz?

8 enerjisi Satürn'le ilişkilidir - karma, sorumluluk, sonuçlar. Tıpkı Satürn gibi ne ekerseniz onu biçersiniz, kaçış yok.

Bu sayının gölge yönü açgözlülük ve güç sarhoşluğu. Başarı takıntısı, insani değerleri ezebilir. Dengenizi bulmak için gücün sorumluluğunu anlamanız gerekir.
''',
          careerPath:
              'Finans, yöneticilik, girişimcilik, bankacılık, hukuk, gayrimenkul',
          spiritualLesson:
              'Maddi ve manevi zenginliği dengelemek. Gücün hizmet için olduğunu anlamak.',
          shadowSide: 'Açgözlülük, güç sarhoşluğu, işkoliklik, duygusal körlük',
          compatibleNumbers: '2, 4, 8',
        );
      case 9:
        return NumerologyMeaning(
          number: 9,
          title: 'Hümanist',
          keywords: 'Şefkat • Evrensellik • Bilgelik',
          meaning: 'İdealist, şefkatli ve insanlık için çalışan bireylerdir.',
          strengths: 'Merhamet, evrensel sevgi, bilgelik, yaratıcılık',
          challenges: 'Hayal kırıklığı, bırakma zorluğu, dağılmışlık',
          loveStyle: 'Koşulsuz seven, fedakar, idealist',
          detailedInterpretation: '''
9 sayısı tamamlanma ve evrensel sevgidir - son tek basamak, tüm sayıları içeren, bütünlük. Bu sayıyla doğanlar "Hizmet ediyorum" mesajıyla dünyaya geldiler.

Ruhunuz insanlığa hizmet etmek için tasarlandı. Bireysel çıkarların ötesinde, kolektif iyilik sizin vizyonunuz. Dünyayı daha iyi bir yer bırakmak misyonunuz.

9 enerjisi Mars'la ilişkilidir - eylem, tutku, mücadele. Tıpkı Mars gibi inançlarınız için savaşırsınız ama silahınız şiddet değil, sevgi.

Bu sayının gölge yönü hayal kırıklığı ve tükenmişlik. Dünyayı değiştirmeye çalışırken kendinizi tüketmek. Dengenizi bulmak için sınırlarınızı bilmeniz gerekir.
''',
          careerPath:
              'Hayırseverlik, sanat, terapi, uluslararası çalışma, aktivizm, öğretmenlik',
          spiritualLesson:
              'Bırakma ve kabul etmeyi öğrenmek. Dünyayı değiştirmek için önce kendini değiştirmek.',
          shadowSide:
              'Fanatizm, hayal kırıklığı, fedakarlık kompleksi, bitirme zorluğu',
          compatibleNumbers: '3, 5, 6, 9',
        );
      case 11:
        return NumerologyMeaning(
          number: 11,
          title: 'Usta Sezgisel',
          keywords: 'İlham • Sezgi • Spiritüel Vizyon',
          meaning:
              'Master sayı. Yüksek sezgi, ilham ve spiritüel liderlik potansiyeli.',
          strengths: 'Güçlü sezgi, ilham verici, vizyoner, spiritüel',
          challenges: 'Sinir gerginliği, aşırı hassasiyet, pratik zorluklar',
          loveStyle: 'Ruh eşi arayan, derin spiritüel bağ',
          detailedInterpretation: '''
11 bir Master Sayıdır - yüksek titreşim, yüksek potansiyel, yüksek sorumluluk. 1'in gücünün iki katı, ama aynı zamanda 2'nin hassasiyeti. Bu sayıyla doğanlar "İlham veriyorum" mesajıyla dünyaya geldiler.

Ruhunuz spiritüel ve maddi dünyalar arasında köprü olmak için tasarlandı. Güçlü sezgi, vizyoner düşünce ve ilham verme kapasitesi sizin armağanlarınız.

11 enerjisi elektrik gibidir - yüksek voltaj, yüksek etki, ama kontrol edilmezse tehlikeli. Sinir sisteminiz hassas, aşırı uyarıya açık.

Bu sayının gölge yönü aşırı hassasiyet ve pratik dünyayla başa çıkamama. Vizyonlarınız büyük ama ayakları yere basmayı unutabilirsiniz. Dengenizi bulmak için topraklanmayı öğrenmeniz gerekir.
''',
          careerPath:
              'Spiritüel öğretmenlik, psikoloji, sanat, müzik, şifa, ilham verici konuşmacılık',
          spiritualLesson:
              'Vizyonu pratikle birleştirmek. Hassasiyeti güce dönüştürmek.',
          shadowSide:
              'Sinir gerginliği, gerçeklikten kopuş, aşırı idealizm, karar verememe',
          compatibleNumbers: '2, 11, 22',
        );
      case 22:
        return NumerologyMeaning(
          number: 22,
          title: 'Usta İnşacı',
          keywords: 'Büyük Vizyon • Manifestasyon • Güç',
          meaning:
              'Master sayı. Büyük projeleri hayata geçirebilen, vizyoner inşacılar.',
          strengths: 'Büyük vizyon, pratik güç, liderlik, başarı',
          challenges: 'Aşırı baskı, mükemmeliyetçilik, tükenmişlik',
          loveStyle: 'Güçlü ve destekleyici partner arayan',
          detailedInterpretation: '''
22 en güçlü Master Sayıdır - "Usta İnşacı". 11'in vizyoner gücü + 4'ün pratik kapasitesi. Bu sayıyla doğanlar "İnşa ediyorum - büyük ölçekte" mesajıyla dünyaya geldiler.

Ruhunuz dünyayı kalıcı şekilde değiştirmek için tasarlandı. Sadece rüya görmekle kalmaz, o rüyaları gerçeğe dönüştürme gücüne sahipsiniz. Emperya kuran, hareket başlatan insanlar.

22 enerjisi piramitler gibidir - devasa, kalıcı, ilham verici. Tıpkı piramitler gibi, nesiller boyu ayakta kalacak yapılar kurma potansiyeliniz var.

Bu sayının gölge yönü tükenmişlik ve aşırı baskı. Büyük hedefler büyük stres yaratır. Dengenizi bulmak için kendinize de şefkat göstermeniz gerekir.
''',
          careerPath:
              'Büyük ölçekli girişimcilik, mimari, uluslararası organizasyonlar, liderlik',
          spiritualLesson:
              'Büyük gücün büyük sorumluluk gerektirdiğini anlamak.',
          shadowSide:
              'Tükenmişlik, mükemmeliyetçilik, başkalarını ezmek, kendini tüketmek',
          compatibleNumbers: '4, 11, 22, 33',
        );
      case 33:
        return NumerologyMeaning(
          number: 33,
          title: 'Usta Öğretmen',
          keywords: 'Evrensel Sevgi • Şifa • İlham',
          meaning:
              'Master sayı. Koşulsuz sevgi ve şifa enerjisi taşıyan öğretmenler.',
          strengths: 'Koşulsuz sevgi, şifa, ilham, fedakarlık',
          challenges: 'Aşırı sorumluluk, kendi ihtiyaçlarını ihmal',
          loveStyle: 'Derin spiritüel bağ, koşulsuz sevgi',
          detailedInterpretation: '''
33 en nadir ve en yüksek Master Sayıdır - "Usta Öğretmen" veya "Kozmik Anne/Baba". 11'in sezgisi + 22'nin inşa gücü + 6'nın şefkati. Bu sayıyla doğanlar "Şifa ve öğretiyorum" mesajıyla dünyaya geldiler.

Ruhunuz insanlığı yükseltmek için tasarlandı. Koşulsuz sevgi, evrensel şifa ve spiritüel öğretmenlik sizin kutsal göreviniz. 33 yaşına kadar bu enerjinin farkına varmayabilirsiniz.

33 enerjisi Mesih bilinciyle ilişkilidir - fedakarlık, koşulsuz sevgi, şifa. Tıpkı büyük spiritüel öğretmenler gibi, başkalarının yükünü taşıma kapasitesine sahipsiniz.

Bu sayının gölge yönü aşırı fedakarlık ve martyrdom kompleksi. Herkesi kurtarmaya çalışırken kendinizi kurban edebilirsiniz. Dengenizi bulmak için kendinizi de sevmeniz gerekir.
''',
          careerPath:
              'Spiritüel öğretmenlik, terapi, şifa, hayırseverlik, sanat terapisi, danışmanlık',
          spiritualLesson:
              'Başkalarını şifa ederken kendini de şifa etmek. Sınırları koruyarak sevmek.',
          shadowSide:
              'Fedakarlık kompleksi, kurban ruhu, kendini tüketme, sınır koyamama',
          compatibleNumbers: '6, 22, 33',
        );
      default:
        return NumerologyMeaning(
          number: number,
          title: 'Bilinmiyor',
          keywords: '',
          meaning: '',
          strengths: '',
          challenges: '',
          loveStyle: '',
        );
    }
  }
}
