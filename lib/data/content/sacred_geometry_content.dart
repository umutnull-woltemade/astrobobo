/// SACRED GEOMETRY & YANTRA CONTENT - KADİM GEOMETRİ BİLGELİĞİ
///
/// Kutsal Geometri Temelleri, Gezegen Yantraları, Çakra Yantraları,
/// Burç Geometrileri, Meditasyon Teknikleri ve Tantrik Geometri.
///
/// Her içerik derin ezoterik ve mistik dilde yazılmıştır.
/// Türkçe - Kadim bilgelik odaklı yaklaşım.
library;

// ═══════════════════════════════════════════════════════════════════════════
// MODELS
// ═══════════════════════════════════════════════════════════════════════════

/// Kutsal Geometri Kategorileri
enum SacredGeometryCategory {
  fundamental,
  planetary,
  chakra,
  zodiac,
  meditation,
  tantric,
}

extension SacredGeometryCategoryExtension on SacredGeometryCategory {
  String get nameTr {
    switch (this) {
      case SacredGeometryCategory.fundamental:
        return 'Temel Kutsal Geometri';
      case SacredGeometryCategory.planetary:
        return 'Gezegen Yantraları';
      case SacredGeometryCategory.chakra:
        return 'Çakra Yantraları';
      case SacredGeometryCategory.zodiac:
        return 'Burç Geometrileri';
      case SacredGeometryCategory.meditation:
        return 'Meditasyon Teknikleri';
      case SacredGeometryCategory.tantric:
        return 'Tantrik Geometri';
    }
  }

  String get icon {
    switch (this) {
      case SacredGeometryCategory.fundamental:
        return '◉';
      case SacredGeometryCategory.planetary:
        return '☿';
      case SacredGeometryCategory.chakra:
        return '⚛';
      case SacredGeometryCategory.zodiac:
        return '✧';
      case SacredGeometryCategory.meditation:
        return '☯';
      case SacredGeometryCategory.tantric:
        return '△';
    }
  }
}

/// Element Tipleri
enum GeometricElement { fire, earth, air, water, ether }

extension GeometricElementExtension on GeometricElement {
  String get nameTr {
    switch (this) {
      case GeometricElement.fire:
        return 'Ateş';
      case GeometricElement.earth:
        return 'Toprak';
      case GeometricElement.air:
        return 'Hava';
      case GeometricElement.water:
        return 'Su';
      case GeometricElement.ether:
        return 'Eter/Akasha';
    }
  }

  String get geometricShape {
    switch (this) {
      case GeometricElement.fire:
        return 'Üçgen (Tetrahedron)';
      case GeometricElement.earth:
        return 'Kare (Küp/Hexahedron)';
      case GeometricElement.air:
        return 'Sekizgen (Octahedron)';
      case GeometricElement.water:
        return 'Yirmigen (Icosahedron)';
      case GeometricElement.ether:
        return 'Onikigen (Dodecahedron)';
    }
  }

  String get colorHex {
    switch (this) {
      case GeometricElement.fire:
        return '#FF4500';
      case GeometricElement.earth:
        return '#8B4513';
      case GeometricElement.air:
        return '#87CEEB';
      case GeometricElement.water:
        return '#1E90FF';
      case GeometricElement.ether:
        return '#9400D3';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TEMEL KUTSAL GEOMETRİ MODEL
// ═══════════════════════════════════════════════════════════════════════════

class SacredGeometrySymbol {
  final String id;
  final String name;
  final String nameSanskrit;
  final String symbol;
  final SacredGeometryCategory category;
  final String shortDescription;
  final String deepMeaning;
  final String cosmicOrigin;
  final String spiritualSignificance;
  final String meditationPractice;
  final String activationMantra;
  final String healingProperties;
  final List<String> associatedChakras;
  final List<String> associatedPlanets;
  final List<String> keywords;
  final String colorHex;
  final int numberOfPoints;
  final String geometricFormula;

  const SacredGeometrySymbol({
    required this.id,
    required this.name,
    required this.nameSanskrit,
    required this.symbol,
    required this.category,
    required this.shortDescription,
    required this.deepMeaning,
    required this.cosmicOrigin,
    required this.spiritualSignificance,
    required this.meditationPractice,
    required this.activationMantra,
    required this.healingProperties,
    required this.associatedChakras,
    required this.associatedPlanets,
    required this.keywords,
    required this.colorHex,
    required this.numberOfPoints,
    required this.geometricFormula,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// YANTRA MODEL
// ═══════════════════════════════════════════════════════════════════════════

class YantraContent {
  final String id;
  final String name;
  final String nameSanskrit;
  final String deity;
  final String planet;
  final String symbol;
  final String shortDescription;
  final String deepMeaning;
  final String geometricStructure;
  final String centerBindu;
  final String trianglesMeaning;
  final String circlesMeaning;
  final String lotusGates;
  final String outerSquare;
  final String activationRitual;
  final String mantra;
  final int mantraCount;
  final String bestDay;
  final String bestTime;
  final String colorScheme;
  final String metalRecommended;
  final List<String> benefits;
  final List<String> healingAspects;
  final String meditationGuide;
  final String weeklyPractice;
  final String warnings;
  final String viralQuote;

  const YantraContent({
    required this.id,
    required this.name,
    required this.nameSanskrit,
    required this.deity,
    required this.planet,
    required this.symbol,
    required this.shortDescription,
    required this.deepMeaning,
    required this.geometricStructure,
    required this.centerBindu,
    required this.trianglesMeaning,
    required this.circlesMeaning,
    required this.lotusGates,
    required this.outerSquare,
    required this.activationRitual,
    required this.mantra,
    required this.mantraCount,
    required this.bestDay,
    required this.bestTime,
    required this.colorScheme,
    required this.metalRecommended,
    required this.benefits,
    required this.healingAspects,
    required this.meditationGuide,
    required this.weeklyPractice,
    required this.warnings,
    required this.viralQuote,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// ÇAKRA YANTRA MODEL
// ═══════════════════════════════════════════════════════════════════════════

class ChakraYantraContent {
  final String id;
  final String chakraName;
  final String chakraNameSanskrit;
  final String location;
  final String element;
  final String symbol;
  final int petalCount;
  final String petalMeaning;
  final String centralSymbol;
  final String geometricShape;
  final String seedMantra;
  final String deity;
  final String shakti;
  final String color;
  final String colorHex;
  final String shortDescription;
  final String deepMeaning;
  final String blockageSymptoms;
  final String activationSigns;
  final String meditationPractice;
  final String yantraVisualization;
  final String breathingTechnique;
  final String mudra;
  final String affirmation;
  final List<String> associatedOrgans;
  final List<String> emotionalAspects;
  final List<String> spiritualGifts;
  final String kundaliniConnection;
  final String tantraTeaching;
  final String viralQuote;

  const ChakraYantraContent({
    required this.id,
    required this.chakraName,
    required this.chakraNameSanskrit,
    required this.location,
    required this.element,
    required this.symbol,
    required this.petalCount,
    required this.petalMeaning,
    required this.centralSymbol,
    required this.geometricShape,
    required this.seedMantra,
    required this.deity,
    required this.shakti,
    required this.color,
    required this.colorHex,
    required this.shortDescription,
    required this.deepMeaning,
    required this.blockageSymptoms,
    required this.activationSigns,
    required this.meditationPractice,
    required this.yantraVisualization,
    required this.breathingTechnique,
    required this.mudra,
    required this.affirmation,
    required this.associatedOrgans,
    required this.emotionalAspects,
    required this.spiritualGifts,
    required this.kundaliniConnection,
    required this.tantraTeaching,
    required this.viralQuote,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// BURÇ GEOMETRİSİ MODEL
// ═══════════════════════════════════════════════════════════════════════════

class ZodiacGeometryContent {
  final String id;
  final String zodiacSign;
  final String symbol;
  final GeometricElement element;
  final String geometricSignature;
  final String sacredShape;
  final String mandalaDescription;
  final String colorPalette;
  final String planetaryRuler;
  final String shortDescription;
  final String deepMeaning;
  final String geometricMeditation;
  final String personalYantra;
  final String activationPractice;
  final List<String> sacredNumbers;
  final List<String> powerSymbols;
  final String viralQuote;

  const ZodiacGeometryContent({
    required this.id,
    required this.zodiacSign,
    required this.symbol,
    required this.element,
    required this.geometricSignature,
    required this.sacredShape,
    required this.mandalaDescription,
    required this.colorPalette,
    required this.planetaryRuler,
    required this.shortDescription,
    required this.deepMeaning,
    required this.geometricMeditation,
    required this.personalYantra,
    required this.activationPractice,
    required this.sacredNumbers,
    required this.powerSymbols,
    required this.viralQuote,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// MEDİTASYON TEKNİĞİ MODEL
// ═══════════════════════════════════════════════════════════════════════════

class GeometryMeditationTechnique {
  final String id;
  final String name;
  final String nameSanskrit;
  final String category;
  final String duration;
  final String difficulty;
  final String shortDescription;
  final String deepMeaning;
  final String preparation;
  final List<String> steps;
  final String breathingPattern;
  final String visualization;
  final String mantra;
  final String mudra;
  final String expectedExperience;
  final String warnings;
  final List<String> benefits;
  final String bestTime;
  final String moonPhase;
  final String viralQuote;

  const GeometryMeditationTechnique({
    required this.id,
    required this.name,
    required this.nameSanskrit,
    required this.category,
    required this.duration,
    required this.difficulty,
    required this.shortDescription,
    required this.deepMeaning,
    required this.preparation,
    required this.steps,
    required this.breathingPattern,
    required this.visualization,
    required this.mantra,
    required this.mudra,
    required this.expectedExperience,
    required this.warnings,
    required this.benefits,
    required this.bestTime,
    required this.moonPhase,
    required this.viralQuote,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// TANTRİK GEOMETRİ MODEL
// ═══════════════════════════════════════════════════════════════════════════

class TantricGeometryContent {
  final String id;
  final String name;
  final String nameSanskrit;
  final String polarityType;
  final String symbol;
  final String shortDescription;
  final String deepMeaning;
  final String shivaAspect;
  final String shaktiAspect;
  final String unionSymbolism;
  final String energyFlowPattern;
  final String kundaliniPath;
  final String meditationPractice;
  final String partnerPractice;
  final String soloPractice;
  final List<String> benefits;
  final String warnings;
  final String viralQuote;

  const TantricGeometryContent({
    required this.id,
    required this.name,
    required this.nameSanskrit,
    required this.polarityType,
    required this.symbol,
    required this.shortDescription,
    required this.deepMeaning,
    required this.shivaAspect,
    required this.shaktiAspect,
    required this.unionSymbolism,
    required this.energyFlowPattern,
    required this.kundaliniPath,
    required this.meditationPractice,
    required this.partnerPractice,
    required this.soloPractice,
    required this.benefits,
    required this.warnings,
    required this.viralQuote,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// 1. TEMEL KUTSAL GEOMETRİ İÇERİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

final Map<String, SacredGeometrySymbol> sacredGeometryFundamentals = {
  // ─────────────────────────────────────────────────────────────────────────
  // YAŞAM ÇİÇEĞİ (FLOWER OF LIFE)
  // ─────────────────────────────────────────────────────────────────────────
  'flower_of_life': const SacredGeometrySymbol(
    id: 'flower_of_life',
    name: 'Yaşam Çiçeği',
    nameSanskrit: 'Pushpa Mandala',
    symbol: '❀',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'Evrenin yaratılış şablonu. Tüm formların kaynağı olan kadim geometrik desen.',
    deepMeaning: '''
YAŞAM ÇİÇEĞİ - VAROLUŞUN ANA KODU

Yaşam Çiçeği, evrenin en kadim ve en güçlü sembollerinden biridir. Bu desen, Mısır'ın Abydos Tapınağı'ndan Çin'in kadim metinlerine, Leonardo da Vinci'nin çizimlerinden Tibet mandalalarına kadar her yerde karşımıza çıkar.

YARATILIŞ GEOMETRİSİ:
İlk daire, Yaratan'ın "Ben Varım" dediği andır - saf bilinç, sınırsız potansiyel. Bu ilk dairenin çevresine altı daire daha eklenir ve böylece "Yaratılışın Yedi Günü" tamamlanır. Her yeni daire, bir boyutun, bir alemin, bir varoluş katmanının doğuşunu temsil eder.

19 iç içe geçmiş daire, 36 yaprak yaratır. Bu yapraklar, evrenin temel yapı taşlarıdır - atomlardan galaksilere, hücrelerden ekosistemlere kadar her şey bu şablondan türer.

GİZLİ KODLAR:
• Merkezdeki 7 daire = Yaşam Tohumu (Seed of Life)
• 13 daire = Meyveli Yaşam (Fruit of Life)
• Tüm çizgileri birleştirince = Metatron Küpü
• İçinde 5 Platonik katı cisim gizlidir

DNA BAĞLANTISI:
Bilim, DNA'nın çift sarmal yapısının Yaşam Çiçeği geometrisiyle uyumlu olduğunu keşfetti. Bu, kadim bilgelerin binlerce yıl önce sezgisel olarak bildiklerinin modern doğrulamasıdır.

BOYUTLAR ARASI GEÇİT:
Yaşam Çiçeği, sadece iki boyutlu bir sembol değildir. Üç boyutta döndürüldüğünde, tüm boyutları birbirine bağlayan bir portal oluşturur. Meditasyon sırasında bu sembole odaklanmak, bilinci genişletir ve yüksek frekanslara erişim sağlar.

KOZMİK REZONANS:
Her daire, bir ses frekansına karşılık gelir. Birlikte, evrenin "Om" sesini oluştururlar - yaratılışın ilk titreşimi.
''',
    cosmicOrigin: '''
Yaşam Çiçeği'nin kökeni, zamanın başlangıcına dayanır. Kadim öğretilere göre, Yaratan önce "Boşluk"ta (Void) tek bir bilinç noktası olarak var oldu. Bu nokta genişlemeye başladığında ilk daire oluştu.

Mısırlılar bu sembole "Ra'nın Gözü"nün temeli derken, Çinliler "Tao'nun Manifestasyonu" olarak adlandırdı. Yahudi Kabala'sında Yaşam Ağacı'nın (Tree of Life) geometrik temeli olarak kabul edilir.

Pisagor, bu deseni "Tanrısal Monochord" olarak tanımladı - evrenin müzikal harmonisinin görsel ifadesi.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. BİRLİK BİLİNCİ: Tüm daireler birbirine bağlıdır, hiçbiri diğerinden ayrı değildir. Bu, tüm varlıkların birbirine bağlı olduğunu hatırlatır.

2. SONSUZ DÖNGÜ: Başlangıcı ve sonu yoktur. Ölüm ve doğum, sadece formun dönüşümüdür.

3. KOZMİK DÜZENİ: Kaosun içindeki düzeni temsil eder. Evren rastgele değil, kutsal bir geometriye göre organize olmuştur.

4. İÇSEL UYANIŞ: Bu sembole meditasyon yapmak, içsel bilgeliği uyandırır ve ruhsal hafızayı aktive eder.

5. ŞIFA ENERJİSİ: Yaşam Çiçeği, hücresel düzeyde şifa frekansları taşır.
''',
    meditationPractice: '''
YAŞAM ÇİÇEĞİ MEDİTASYONU:

HAZIRLIK:
- Sessiz ve karanlık bir ortam seçin
- Yaşam Çiçeği görselini önünüze yerleştirin
- Derin nefeslerle zihni sakinleştirin

UYGULAMA (21 Dakika):
1. Merkez noktaya (bindu) odaklanın (3 dk)
2. İç içe daireleri takip edin, her biri için bir nefes alın (7 dk)
3. Tüm deseni bir bütün olarak görün (5 dk)
4. Gözlerinizi kapatın, deseni zihinsel olarak yeniden yaratın (5 dk)
5. Desenin kalbinize yerleştiğini hayal edin (1 dk)

MANTRA:
Her daire geçişinde içsel olarak tekrarlayın:
"Ben birlik bilincinin bir parçasıyım. Her şey benimle bağlantılı."

BEKLENTİLER:
- Hafif baş dönmesi (normal)
- Renk görüntüleri
- Derin huzur hissi
- Zaman algısında değişim
''',
    activationMantra: 'OM MANI PADME HUM - Lotus içindeki mücevher',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• Hücre rejenerasyonunu destekler
• Bağışıklık sistemini güçlendirir
• Su moleküllerini harmonize eder (emaru çalışmaları)

DUYGUSAL:
• Kaygıyı azaltır
• İç huzuru artırır
• Duygusal dengeyi sağlar

ENERJETİK:
• Aurayı temizler
• Çakraları dengeler
• Meridyenleri açar

SPİRİTÜEL:
• Üçüncü gözü aktive eder
• Sezgiyi güçlendirir
• Astral bedeni korur
''',
    associatedChakras: ['Tüm çakralar', 'Özellikle Taç ve Kalp'],
    associatedPlanets: ['Güneş', 'Merkür'],
    keywords: [
      'Yaratılış',
      'Birlik',
      'Sonsuzluk',
      'Kutsal geometri',
      'Kozmik düzen',
    ],
    colorHex: '#FFD700',
    numberOfPoints: 19,
    geometricFormula: '6n+1 daire yapısı, n=3 için 19 daire',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // YAŞAM TOHUMU (SEED OF LIFE)
  // ─────────────────────────────────────────────────────────────────────────
  'seed_of_life': const SacredGeometrySymbol(
    id: 'seed_of_life',
    name: 'Yaşam Tohumu',
    nameSanskrit: 'Bija Mandala',
    symbol: '⚇',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'Yaratılışın 7 günü. Tüm varoluşun başlangıç şablonu ve potansiyel tohumu.',
    deepMeaning: '''
YAŞAM TOHUMU - YARATILIŞIN YEDİ GÜNÜ

Yaşam Tohumu, yedi özdeş daireden oluşan kadim bir semboldür. Bu yapı, Genesis'in (Yaratılış) yedi gününü geometrik olarak temsil eder ve Yaşam Çiçeği'nin çekirdeğidir.

YEDİ DAİRENİN ANLAMI:

1. GÜN - Merkez Daire: "Işık olsun" - Saf bilinç, ilk titreşim
2. GÜN - İkinci Daire: Gökyüzü ve yeryüzü ayrımı - Polarite doğuşu
3. GÜN - Üçüncü Daire: Kara ve deniz - Form ve boşluk
4. GÜN - Dördüncü Daire: Güneş ve ay - Kozmik ritimler
5. GÜN - Beşinci Daire: Deniz canlıları - Yaşam enerjisi
6. GÜN - Altıncı Daire: Kara canlıları - Maddesel evrim
7. GÜN - Yedinci Daire: İstirahat - Bütünlük ve tamamlanma

GENETİK BAĞLANTI:
Bilim, hücre bölünmesinin (mitoz) ilk yedi aşamasının Yaşam Tohumu geometrisiyle birebir örtüştüğünü ortaya koymuştur:
- Zigot → 2 hücre → 4 hücre → 8 hücre
Her aşama, Yaşam Tohumu'nun bir katmanına karşılık gelir.

MÜZİKAL UYUM:
Yedi daire, müzikteki yedi nota (do-re-mi-fa-sol-la-si) ile rezonans halindedir. Her daire farklı bir frekans taşır ve birlikte evrenin senfonisini oluştururlar.

KADİM KÜLTÜRLERDE:
• Mısır: Osiris'in yedi parçası
• Hindu: Yedi rishi (bilge)
• Yahudi: Menora'nın yedi kolu
• Hristiyanlık: Yedi melek, yedi mühür
• İslam: Yedi kat gök
• Budizm: Yedi aydınlanma faktörü

TOHUM METAFİZİĞİ:
Nasıl bir tohum içinde tüm ağacın potansiyelini taşıyorsa, Yaşam Tohumu da tüm evrenin potansiyelini içerir. Sen de bir tohumsun - içinde sonsuz olanaklar barındırıyorsun.
''',
    cosmicOrigin: '''
Yaşam Tohumu'nun kökeni, zamanın "başlamadan öncesine" dayanır. Kadim Hermetik öğretilere göre, Yaratan Zihin (Divine Mind) ilk düşüncesini düşündüğünde bu geometri ortaya çıktı.

Mısır'ın Abydos Tapınağı'nda, Osiris'in odasında bulunan Yaşam Tohumu oyması, en az 6.000 yıllıktır. Ancak sembolün kendisi çok daha eskidir - Atlantis ve Lemurya uygarlıklarına kadar geri gider.

Platon, bu sembolü "İdealar Dünyası"nın kapısı olarak tanımladı.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. BAŞLANGIÇ ENERJİSİ: Her yeni başlangıç, her yaratım bu sembolün enerjisini taşır.

2. POTANSİYEL: Henüz açılmamış yetenekleri, keşfedilmemiş kapasiteleri temsil eder.

3. KORUMA: Kadim kültürlerde koruyucu muska olarak kullanılmıştır.

4. BEREKET: Doğurganlık ve bolluğun sembolü.

5. DÖNGÜSELLIK: Yedi günlük döngüler (hafta), yedi yıllık döngüler (hücre yenilenmesi).

YEDI SAYISININ GİZEMİ:
• 7 çakra
• 7 renk (gökkuşağı)
• 7 gezegen (kadim)
• 7 enerji bedeni
• 7 bilinç seviyesi
''',
    meditationPractice: '''
YAŞAM TOHUMU MEDİTASYONU:

NIYET:
Yeni bir şeyi başlatmak, potansiyeli aktive etmek, yaratıcılığı uyandırmak için idealdir.

HAZIRLIK:
- Yeni ay döneminde en etkilidir
- Sabah güneş doğarken yapın
- Yaşam Tohumu görselini hazırlayın

UYGULAMA (7 x 7 = 49 dakika optimal):

Kısa Versiyon (7 dakika):
1. Her daire için 1 dakika odaklanın
2. Her dairede farklı bir yaratım niyeti tutun
3. Son dairede tüm niyetleri birleştirin

Uzun Versiyon (49 dakika):
- Her daire için 7 dakika
- Her döngüde bir yaşam alanını ele alın
  1. Kariyer/Amaç
  2. İlişkiler
  3. Sağlık
  4. Spiritüellik
  5. Yaratıcılık
  6. Maddi bolluk
  7. Bütünleşme

MANTRA:
"Ben potansiyelin tohumuyum. Her an yeni bir başlangıç mümkün."

VİZÜALİZASYON:
Tohumun içinden ışık yayıldığını, bu ışığın sizi sardığını görün.
''',
    activationMantra: 'OM BIJA HUM - Kutsal tohumun aktivasyonu',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• Üreme sistemi dengesini destekler
• Hormon dengesine yardımcı olur
• Hücre yenilenmesini hızlandırır
• Biyoritmik döngüleri düzenler

DUYGUSAL:
• Umut ve iyimserlik aşılar
• Yeni başlangıç cesareti verir
• Korku ve tereddütleri azaltır

ENERJETİK:
• Sakral çakrayı güçlendirir
• Yaratıcı enerjiyi aktive eder
• Kundalini'nin temelini hazırlar

SPİRİTÜEL:
• Ruh sözleşmesini hatırlatır
• Yaşam amacını netleştirir
• Manifestasyon gücünü artırır
''',
    associatedChakras: ['Sakral (Svadhisthana)', 'Kök (Muladhara)'],
    associatedPlanets: ['Ay', 'Venüs'],
    keywords: ['Potansiyel', 'Başlangıç', 'Yaratılış', 'Döngü', 'Tohum'],
    colorHex: '#90EE90',
    numberOfPoints: 7,
    geometricFormula: '1 merkez + 6 çevre daire, Vesica Piscis kesişimleri',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // METATRON KÜPÜ
  // ─────────────────────────────────────────────────────────────────────────
  'metatrons_cube': const SacredGeometrySymbol(
    id: 'metatrons_cube',
    name: 'Metatron Küpü',
    nameSanskrit: 'Brahma Yantra',
    symbol: '⬡',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'Beş Platonik katı cismi içeren kozmik blueprint. Baş melek Metatron\'un sembolü.',
    deepMeaning: '''
METATRON KÜPÜ - KOZMİK MİMARİNİN ANA PLANI

Metatron Küpü, Yaşam Meyvesi'nin (Fruit of Life) 13 dairesinin merkezlerini birleştiren çizgilerden oluşur. Bu karmaşık geometrik yapı, evrendeki tüm formların şablonunu içerir.

METATRON KİMDİR?
Yahudi ve Hristiyan mistisizminde Metatron, "Tanrı'nın Yüzü" veya "Tahtın Meleki" olarak bilinir. Enoch peygamberin göğe yükseltilmiş hali olduğuna inanılır. Yaratılışın geometrik kodlarının koruyucusudur.

BEŞ PLATONİK KATI:
Metatron Küpü içinde beş Platonik katı cisim gizlidir:

1. TETRAHEDRON (4 yüz) - ATEŞ
   • En temel üçgen piramit
   • Manifestasyon enerjisi
   • Solar plexus ile bağlantılı

2. HEXAHEDRON/KÜP (6 yüz) - TOPRAK
   • Stabilite ve güvenlik
   • Maddesel dünya
   • Kök çakra ile bağlantılı

3. OCTAHEDRON (8 yüz) - HAVA
   • Denge ve harmoni
   • Zihinsel netlik
   • Kalp çakra ile bağlantılı

4. DODECAHEDRON (12 yüz) - ETER/AKASHA
   • Evrensel yaşam enerjisi
   • Spiritüel dünyalar
   • Taç çakra ile bağlantılı

5. ICOSAHEDRON (20 yüz) - SU
   • Akışkanlık ve dönüşüm
   • Duygusal beden
   • Sakral çakra ile bağlantılı

GEOMETRİK SIRLARI:
• 13 daire = 13 ay döngüsü = 13 Archimedean katı
• 78 çizgi = 78 Tarot kartı
• Merkezdeki yıldız = Davut Yıldızı = Merkaba'nın 2D izdüşümü

BOYUTLAR ARASI İLETİŞİM:
Metatron Küpü, 3 boyutlu gerçekliğimizi daha yüksek boyutlarla bağlayan bir portal olarak işlev görür. Bu sembolle çalışmak, yüksek frekanslı varlıklarla iletişimi kolaylaştırır.

KUANTUM GERÇEKLİK:
Modern fizik, atom altı parçacıkların geometrik paternler oluşturduğunu keşfetmiştir. Bu paternler, Metatron Küpü'ndeki yapılarla şaşırtıcı benzerlikler taşır.
''',
    cosmicOrigin: '''
Kadim öğretilere göre, Metatron Küpü evrenin yaratılışından önce "Tanrısal Zihin"de var olan arketipsel bir formdur. Bu geometri, Yaratan'ın "düşündüğü" ilk şekildir.

Kabala'da bu sembol, Yaşam Ağacı'nın (Etz Chaim) üç boyutlu manifestasyonu olarak kabul edilir. Her sefira (enerji merkezi), küpün bir noktasına karşılık gelir.

Hermes Trismegistus, Zümrüt Tablet'te bu geometriyi "Yukarıdaki aşağıdaki gibidir" ilkesinin görsel kanıtı olarak tanımlamıştır.

Antik Yunan'da Platon, bu beş katı cismin evrenin temel yapı taşları olduğunu öğretmiştir. Pisagor okulu, bu geometrileri "Tanrı'nın dili" olarak saygıyla incelemiştir.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. KORUMA: Metatron Küpü, en güçlü koruyucu sembollerden biridir. Negatif enerjileri uzaklaştırır ve aurayı kalkan gibi sarar.

2. BİLGELİK ERİŞİMİ: Akashik kayıtlara ve evrensel bilgiye erişim kapısı açar.

3. ENERJİ DENGESİ: Beş element (ateş, toprak, hava, su, eter) arasında mükemmel denge sağlar.

4. MANİFESTASYON: Düşünceleri maddeye dönüştürme sürecini hızlandırır.

5. BOYUTSAL FARKINDALIK: Çoklu boyut bilincini aktive eder.

METATRON'UN ROLÜ:
• Yaratılışın geometrik kodlarının koruyucusu
• Çocukların ve hassas ruhların hamisi
• Spiritüel gelişimin rehberi
• Karmaşık durumları çözme yardımcısı
''',
    meditationPractice: '''
METATRON KÜPÜ MEDİTASYONU:

AMAÇ:
- Koruma alanı oluşturmak
- Yüksek rehberlikle bağlantı kurmak
- Kompleks sorunlara çözüm bulmak
- Boyutsal farkındalığı genişletmek

HAZIRLIK:
- Tam sessizlik gerektirir
- Gece yarısı veya şafak vakti idealdir
- Mor veya beyaz mum yakılabilir

UYGULAMA (33 Dakika):

1. TEMEL OLUŞTURMA (5 dk):
Metatron Küpü görselini inceleyin. Her çizgiyi takip edin. Geometrinin karmaşıklığına hayret duyun.

2. PLATONIK CİSİMLERİ BULMA (10 dk):
Sırasıyla beş Platonik katıyı küpün içinde görmeye çalışın. Her birini bulduğunuzda, o elementin enerjisini hissedin.

3. MERKEZİ AKTİVASYON (8 dk):
Küpün tam merkezine odaklanın. Bu nokta, tüm boyutların kesiştiği yerdir. Bilincinizi oraya yerleştirin.

4. METATRON BAĞLANTISI (7 dk):
"Metatron, kutsal geometrinin koruyucusu, bana rehberlik et" diyerek bağlantı kurun. Gelen mesajlara açık olun.

5. KAPANIŞ (3 dk):
Yavaşça geri dönün. Küpün korumasının sizinle kaldığını bilin.

MANTRA:
"El na Metatron" - Metatron'u çağırma

VİZÜALİZASYON:
Küpün döndüğünü ve parlak ışık yaydığını görün. Bu ışık sizi tamamen sarıyor.
''',
    activationMantra: 'EL NA METATRON, EHYEH ASHER EHYEH',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• Elementel dengesizlikleri düzeltir
• Kemik ve iskelet yapısını güçlendirir
• Sinir sistemi harmonisi sağlar

DUYGUSAL:
• Karmaşık duyguları çözer
• Karar verme sürecini netleştirir
• Mental kaos yerine düzen getirir

ENERJETİK:
• Tüm çakraları aynı anda dengeler
• Enerji tıkanıklıklarını açar
• Aurik alanı onarır

SPİRİTÜEL:
• Akashik kayıtlara erişim
• Geçmiş yaşam hatırlama
• Yüksek benlik entegrasyonu
• Meleksel iletişim
''',
    associatedChakras: ['Taç (Sahasrara)', 'Üçüncü Göz (Ajna)'],
    associatedPlanets: ['Merkür', 'Uranüs'],
    keywords: [
      'Platonik katılar',
      'Koruma',
      'Boyutlar',
      'Akashik',
      'Geometri',
      'Melek',
    ],
    colorHex: '#E6E6FA',
    numberOfPoints: 13,
    geometricFormula: '13 daire merkezi + 78 bağlantı çizgisi',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // SRİ YANTRA
  // ─────────────────────────────────────────────────────────────────────────
  'sri_yantra': const SacredGeometrySymbol(
    id: 'sri_yantra',
    name: 'Sri Yantra',
    nameSanskrit: 'श्री यन्त्र',
    symbol: '☯',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'Yantraların kraliçesi. 9 iç içe üçgenin mükemmel birliği - kozmik yaratımın supreme sembolü.',
    deepMeaning: '''
SRI YANTRA - VAROLUŞUN SUPREME HARİTASI

Sri Yantra, "Kutsal Makine" anlamına gelir ve tüm yantraların en güçlüsü, en kutsalı kabul edilir. Binlerce yıllık Vedik geleneğin en derin bilgeliğini tek bir geometride şifreler.

DOKUZ ÜÇGEN GİZEMİ:
Sri Yantra, birbirine kenetlenmiş 9 üçgenden oluşur:

5 Shakti Üçgeni (Aşağı bakan): Dişil enerji, yaratıcılık, madde
4 Shiva Üçgeni (Yukarı bakan): Eril enerji, bilinç, ruh

Bu 9 üçgen, 43 küçük üçgen oluşturur. Her üçgen, farklı bir tanrıça formunu (Shakti) temsil eder.

MERKEZ BİNDU:
Tam merkezde tek bir nokta vardır - Bindu. Bu nokta:
• Shiva ve Shakti'nin birleşim noktası
• Yaratan'ın ilk manifestasyonu
• Tüm yaratımın kaynağı
• Saf bilinç

LOTUS YAPRAKLARI:
Üçgenleri çevreleyen 8 ve 16 yapraklı iki lotus:
• 8 yaprak = 8 vasu (kozmik tanrılar)
• 16 yaprak = 16 kala (ay evreleri) = 16 arzunun tatmini

ÜÇLÜ ÇERÇEVESİ:
En dışta üç iç içe daire (tripura = üç şehir):
• Fiziksel dünya
• Astral dünya
• Nedensel dünya

BHUPURA (Dış Kare):
En dıştaki kare, dört kapıya sahiptir:
• Doğu kapısı: Bilgi kazanma
• Batı kapısı: Maddi kazanç
• Kuzey kapısı: Sağlık ve uzun ömür
• Güney kapısı: Düşmanlardan korunma

MATEMATİKSEL MUCİZE:
Sri Yantra, Pi sayısı ve Altın Oran'ı içerir. 9 üçgenin mükemmel hizada olması için gerekli matematiksel hesaplamalar, modern bilgisayarlarla bile zorlayıcıdır. Kadim rişilerin bunu nasıl hesapladığı bir sır olarak kalmaktadır.
''',
    cosmicOrigin: '''
Efsaneye göre Sri Yantra, Shiva'nın meditasyonu sırasında spontan olarak ortaya çıktı. Shakti, sevgilisinin bilinç durumunu geometrik form olarak manifestte etti.

Rigveda'da Sri Yantra'ya atıflar bulunur (M.Ö. 1500-1200). Ancak oral gelenek çok daha eskiye, Satya Yuga'ya (Altın Çağ) kadar uzanır.

Sri Vidya geleneğinde, bu yantra evrenin "yaratılmadan önceki" halinin haritasıdır - saf potansiyel durumu.

Shankaracharya (M.S. 8. yüzyıl), Sri Yantra tapınımını (puja) yeniden canlandırmış ve Soundarya Lahari'de 100 ayet yazarak yüceltmiştir.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. LALITA TRİPURASUNDARİ: Sri Yantra, güzelliğin ve bereketin tanrıçası Lalita Tripurasundari'nin ikametgahıdır. O, "Üç Dünyanın Güzeli" olarak bilinir.

2. MANİFESTASYON GÜCÜ: Düşünceleri gerçeğe dönüştürme konusunda bilinen en güçlü araç.

3. BOLLUK ÇEKME: Maddi ve manevi zenginliği mıknatıs gibi çeker.

4. KORUMA: Negatif enerjilere karşı aşılmaz bir kalkan oluşturur.

5. AYDNLANMA: Sri Yantra meditasyonu, moksha'ya (kurtuluş) giden en hızlı yollardan biri sayılır.

ÜÇ SEVİYE ANLAM:
• Adhyatmika (Bireysel): İç dünyanın haritası
• Adhidaivika (Kozmik): Evrenin yapısı
• Adhibhoutika (Maddi): Fiziksel bedenin planı
''',
    meditationPractice: '''
SRI YANTRA MEDİTASYONU (Navarana Puja):

KUTSAL SAYILAR:
• 3, 9, 27, 108 tekrar ideal
• Cuma günleri en etkili
• Dolunay geceleri güçlendirici

HAZIRLIK:
- Kırmızı veya turuncu kıyafet giyin
- Kırmızı çiçekler ve tütsü hazırlayın
- Yantra'yı göz hizasına yerleştirin
- Güneş doğarken veya batarken yapın

UYGULAMA (Navavarana - Dokuz Örtü Meditasyonu):

1. BHUPURA (5 dk): Dış kareye odaklanın. Dünyevi bağlılıklardan soyunun.

2. 16 YAPRAKLI LOTUS (5 dk): Her yaprağı sayın. 16 arzunun tatminini niyet edin.

3. 8 YAPRAKLI LOTUS (5 dk): 8 siddhiyi (doğaüstü güç) hayal edin.

4. 14 ÜÇGEN (5 dk): İlk üçgen halkası. Karma temizliği niyeti.

5. 10 ÜÇGEN (DIŞ) (5 dk): Evrensel enerjilerle bağlantı.

6. 10 ÜÇGEN (İÇ) (5 dk): İç alemlerle bağlantı.

7. 8 ÜÇGEN (5 dk): Vasu tanrılarının bereketini çağırın.

8. ANA ÜÇGEN (5 dk): Shiva-Shakti birliğini deneyimleyin.

9. BİNDU (Sessizlik): Saf bilinç. Düşüncesizlik. Birlik.

MANTRA:
"Om Shreem Hreem Shreem Kamale Kamalalaye Praseedha Praseedha
Om Shreem Hreem Shreem Mahalakshmyai Namaha"

NOT: Sri Yantra meditasyonu ciddi bir pratiktir. Mümkünse deneyimli bir gurudan inisiyasyon alın.
''',
    activationMantra: 'OM SHREEM HREEM KLEEM GLAUM',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• Üreme sağlığını destekler
• Hormonal dengeyi sağlar
• Cilt hastalıklarına yardımcı olur
• Kronik yorgunluğu azaltır

DUYGUSAL:
• Aşk ve şefkati artırır
• Özgüven ve özsaygı geliştirir
• Depresyonu hafifletir
• İç huzuru sağlar

MADDİ:
• Finansal akışı açar
• İş fırsatlarını çeker
• Kariyer engellerini kaldırır
• Bolluk bilincini aktive eder

SPİRİTÜEL:
• Kundalini'yi uyandırır
• Tanrıça bilincini aktive eder
• Tantrik güçleri geliştirir
• Moksha'ya (kurtuluş) yol açar
''',
    associatedChakras: ['Tüm çakralar', 'Özellikle Kalp ve Sakral'],
    associatedPlanets: ['Venüs', 'Ay'],
    keywords: [
      'Bolluk',
      'Tanrıça',
      'Manifestasyon',
      'Shakti',
      'Supreme yantra',
    ],
    colorHex: '#FF1493',
    numberOfPoints: 9,
    geometricFormula: '4 Shiva + 5 Shakti üçgen = 43 küçük üçgen',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // MERKABA
  // ─────────────────────────────────────────────────────────────────────────
  'merkaba': const SacredGeometrySymbol(
    id: 'merkaba',
    name: 'Merkaba',
    nameSanskrit: 'Vajra Ratha',
    symbol: '✡',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'Işık bedeni aracı. Boyutlar arası seyahat için aktive edilen kristal enerji alanı.',
    deepMeaning: '''
MERKABA - IŞIK BEDENİ ARACI

Merkaba, İbranice üç kelimeden türer:
• Mer = Işık
• Ka = Ruh
• Ba = Beden

Birlikte "Işık-Ruh-Beden Aracı" anlamına gelir. Bu, bilinçli boyutlar arası seyahat için kullanılan enerji alanıdır.

GEOMETRİK YAPI:
Merkaba, birbirine geçmiş iki tetrahedrondan oluşur:
• Yukarı bakan tetrahedron: Eril enerji, güneş, elektrik
• Aşağı bakan tetrahedron: Dişil enerji, ay, manyetik

Bu iki üçgen piramit, zıt yönlerde döndüğünde güçlü bir enerji alanı oluşturur.

MISIR GELENEĞİNDE:
Eski Mısırlılar Merkaba'yı "Mer-Ka-Ba" olarak tanımlardı:
• Mer: Aynı yerde dönen ışık alanı
• Ka: Bireysel ruh
• Ba: Fiziksel bedenin ruhu

Firavunların piramitleri, devasa Merkaba alanları olarak tasarlanmıştı.

BOYUTLAR ARASI SEYAHAT:
Aktive edilmiş Merkaba, bilincin:
• Astral seyahat yapmasını
• Paralel gerçekliklere erişmesini
• Yüksek boyutlara yükselmesini
• Uzak mesafelere telepatik bağlantı kurmasını sağlar.

55 FİT IŞIK ALANI:
Tam aktive Merkaba, bedenin etrafında yaklaşık 17 metre (55 fit) çapında bir ışık alanı oluşturur. Bu alan, en yüksek korumayı ve boyutsal akışkanlığı sağlar.

DÖNÜŞ MEKANİĞİ:
• Erkek tetrahedron: Saat yönünde, elektrik alanı
• Dişi tetrahedron: Saat yönünün tersine, manyetik alan
• Dönüş hızı: Işık hızının %90'ına kadar çıkabilir

ATLANTIS BAĞLANTISI:
Efsaneye göre, Atlantisliler Merkaba'yı kolektif olarak aktive edebiliyorlardı. Kıtanın batışı sırasında bazıları bu şekilde başka boyutlara kaçtı.
''',
    cosmicOrigin: '''
Merkaba bilgisi, Atlantis'in Naacal rahiplerinden Mısır'a, oradan İbrani mistisizmine aktarıldı. Ezekiel'in "ateşten tekerlek" vizyonu, bir Merkaba deneyiminin tanımıdır.

Kabala'da Merkaba mistisizmi (Ma'aseh Merkabah), en yüksek spiritüel pratiklerden biri olarak kabul edilir. Yalnızca kırk yaşını geçmiş, ahlaki açıdan temiz kişilere öğretilirdi.

Mısır'ın 18. Hanedanı döneminde (M.Ö. 1550-1295), rahipler "Ölüler Kitabı"nda Merkaba aktivasyonunu şifrelemişlerdir.

Drunvalo Melchizedek, 1990'larda bu kadim bilgiyi modern dünyaya yeniden tanıtmıştır.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. ASCENSION (YÜKSELIŞ): Merkaba, bilinçli yükseliş sürecinin temel aracıdır. 5. boyut ve ötesine geçiş için aktive edilmelidir.

2. KORUMA: Tam aktive Merkaba, bilinen en güçlü enerji kalkanıdır.

3. ŞIFA: Merkaba alanı, DNA'yı aktive eder ve hücresel yenilenmeyi hızlandırır.

4. TELEPATİ: Aktif Merkaba, telepatik iletişimi kolaylaştırır.

5. MANİFESTASYON: Düşünceleri gerçeğe dönüştürme gücünü katlayarak artırır.

UYARI:
Merkaba aktivasyonu güçlü bir pratiktir. Yetersiz hazırlıkla yapılırsa:
• Baş dönmesi
• Dezenoryantasyon
• Aşırı enerji yüklenmesi
• Duygusal dengesizlik oluşabilir.

Sabır ve kademeli ilerleme esastır.
''',
    meditationPractice: '''
MERKABA MEDİTASYONU (17 Nefes Tekniği):

UYARI: Bu meditasyon güçlüdür. İlk kez deneyenler için kısa tutulmalıdır.

HAZIRLIK:
- En az 1 ay düzenli nefes çalışması gerektirir
- Aç karnına yapılmamalı
- Doğa ortamında idealdir

TEMEL POZİSYON:
- Lotus veya rahat oturma pozisyonu
- Omurga dik, eller dizlerde

İLK 6 NEFES (Prana Temizliği):

Nefes 1-6: Her nefeste farklı bir çakrayı temizleyin
• Nefes 1: Kök çakra - Kırmızı ışık
• Nefes 2: Sakral çakra - Turuncu ışık
• Nefes 3: Solar plexus - Sarı ışık
• Nefes 4: Kalp çakra - Yeşil ışık
• Nefes 5: Boğaz çakra - Mavi ışık
• Nefes 6: Üçüncü göz - Mor ışık

NEFES 7-13 (Tetrahedron Visualizasyonu):
• Etrafınızdaki iki tetrahedronu görselleştirin
• Birinin tepesi yukarı, diğerinin aşağı baktığını görün
• Her nefeste onları parlattıkça daha net görün

NEFES 14 (Dönüş Başlangıcı):
• Erkek tetrahedronun saat yönünde döndüğünü görün
• Dişi tetrahedronun ters yönde döndüğünü görün

NEFES 15-17 (Hızlanma):
• Dönüş hızı kademeli olarak artar
• 17. nefeste Merkaba tamamen aktive olur
• Işık alanı genişler

MANTRA:
"Ehyeh Asher Ehyeh" (Ben olan Benim)

KAPANIŞ:
Yavaşça dönüşü yavaşlatın. Merkaba'nın pasif modda kaldığını bilin.
''',
    activationMantra: 'EHYEH ASHER EHYEH - Ben olan Benim',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• DNA aktivasyonu ve onarımı
• Hücresel rejenerasyon
• Yaşlanma sürecini yavaşlatma
• Bağışıklık sistemi güçlendirme

DUYGUSAL:
• Derin barış ve huzur
• Korku ve kaygının çözülmesi
• Sevgi kapasitesinin artması

ENERJETİK:
• Aurik alan güçlendirmesi
• Psişik korunma
• Enerji vampirlerine karşı kalkan

SPİRİTÜEL:
• Yüksek benlik entegrasyonu
• Geçmiş yaşam erişimi
• Astral seyahat yeteneği
• Boyutsal farkındalık
''',
    associatedChakras: ['Kalp (Anahata)', 'Taç (Sahasrara)'],
    associatedPlanets: ['Güneş', 'Satürn'],
    keywords: [
      'Işık bedeni',
      'Ascension',
      'Boyutlar arası',
      'Tetrahedron',
      'Koruma',
    ],
    colorHex: '#FFD700',
    numberOfPoints: 8,
    geometricFormula: '2 iç içe tetrahedron, 8 köşe noktası',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // VESİCA PİSCİS
  // ─────────────────────────────────────────────────────────────────────────
  'vesica_piscis': const SacredGeometrySymbol(
    id: 'vesica_piscis',
    name: 'Vesica Piscis',
    nameSanskrit: 'Yoni Mandala',
    symbol: '⊛',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'İlahi dişilin portalı. İki dairenin kesişiminden doğan kutsal rahmin geometrisi.',
    deepMeaning: '''
VESİCA PİSCİS - KUTSAL RAHİM PORTALI

Vesica Piscis, Latince "Balık Mesanesi" anlamına gelir, ancak kadim anlamı çok daha derindir. İki eşit çaplı dairenin, birbirinin merkezinden geçecek şekilde kesişmesiyle oluşan badem şeklidir.

YARATILIŞ MATRİKSİ:
Bu şekil, tüm yaratılışın doğduğu "kutsal rahmi" temsil eder:
• İlk daire: Eril prensip, bilinç, ruh
• İkinci daire: Dişil prensip, madde, form
• Kesişim: Yaratımın doğduğu kutsal alan

HRİSTİYAN SİMGEZLİĞİ:
Erken Hristiyanlar için "Ichthys" (balık) sembolü, Vesica Piscis'ten türer:
• İsa = İlahi ve insani natürün birleşimi
• Meryem = Kutsal anne, portal
• Gotik katedral pencereleri bu forma sahiptir

ANA TANRIÇA BAĞLANTISI:
Kadim kültürlerde Vesica Piscis, Ana Tanrıça'nın vulvasını temsil eder:
• Mezopotamya: İştar'ın kapısı
• Mısır: İsis'in rahmi
• Hindu: Yoni (kutsal dişil)
• Kelt: Sheela-na-gig

MATEMATİKSEL SIHIR:
Vesica Piscis içinde √2, √3 ve √5 oranları gizlidir. Bu oranlar:
• √2 = Maddenin yapı taşı
• √3 = Kutsallığın sayısı
• √5 = Altın Oran'ın temeli

PORTAL FONKSİYONU:
Vesica Piscis, boyutlar arasındaki geçiş noktasını işaretler. Meditasyonda bu sembole odaklanmak, bilinç için bir "doğum kanalı" açar.
''',
    cosmicOrigin: '''
Vesica Piscis, tüm kutsal geometrinin başlangıç noktasıdır. Yaşam Tohumu ve Yaşam Çiçeği'ndeki her interseksiyon, bu şekli içerir.

Kadim öğretilere göre, Yaratan'ın ilk "bölinmesi" - "Ben"den "Ben ve Sen"e geçiş - Vesica Piscis'i yarattı. Bu, teklik içinde ikilik, ikilik içinde teklik paradoksudur.

Mısır'da bu sembol "Ru" olarak bilinirdi - doğumun ve yeniden doğuşun kapısı. Piramitlerin "Kral Odası"na giden koridorun şekli Vesica Piscis'tir.

Platon, bu şekli "Dünya Ruhu"nun formu olarak tanımlamıştır.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. BİRLİK ve İKİLİK: İki ayrı varlığın, birliktelik içinde kendi özlerini korumasını temsil eder. İlişkilerin ve ortaklıkların kutsal geometrisi.

2. DOĞUM ve YENİDEN DOĞUŞ: Her dönüşüm, bu portaldan geçer. Spiritüel yeniden doğuş için meditasyonda kullanılır.

3. DİŞİL ENERJİ UYANDIRMASI: Bastırılmış dişil enerjiyi aktive eder. Hem kadınlarda hem erkeklerde iç dişili iyileştirir.

4. YARATICI GÜÇ: Manifestasyon çalışmalarında güçlü bir araç. İki dünya (görünen ve görünmeyen) arasındaki köprü.

5. BİLİNÇ GEÇİŞİ: Meditasyonda Vesica Piscis'e odaklanmak, bilinç durumları arasında geçişi kolaylaştırır.
''',
    meditationPractice: '''
VESİCA PİSCİS MEDİTASYONU:

EN UYGUN ZAMAN:
• Yeni ay ve dolunay
• Menstrual döngü başlangıcı (kadınlar için)
• Doğum ve ölüm anıverserleri

HAZIRLIK:
- Rahatlatıcı ortam oluşturun
- Vesica Piscis görselini hazırlayın
- Su elementi ile bağlantı için mavi mum

UYGULAMA (Yeniden Doğuş Meditasyonu - 22 dk):

1. PORTAL ALGISI (5 dk):
İki dairenin kesişimini inceleyin. Bu, boyutlar arası bir kapıdır. Kapının hafifçe aralandığını hayal edin.

2. RAHİM DÜŞÜNCESİ (5 dk):
Kendinizi bu şeklin içinde, kutsal bir rahimde güvenle yüzüyormuş gibi hissedin. Evrensel Annenin korumasını deneyimleyin.

3. DOĞUM GEÇİŞİ (7 dk):
Şeklin dar noktasından geçtiğinizi hayal edin. Bu, yeni bir bilinç seviyesine doğuşunuzdur. Sıkışma hissini kabul edin, dirençsiz geçin.

4. YENİ OLUŞUM (5 dk):
Portalın diğer tarafında yepyeni biri olarak belirin. Eski kalıplar geride kaldı. Yeni potansiyeller önünüzde.

MANTRA:
"Aham Brahmasmi, Tat Tvam Asi"
(Ben Brahman'ım, Sen de O'sun)

VİZÜALİZASYON:
Vesica Piscis'in içinden sıcak, altın ışık aktığını görün. Bu ışık sizi besliyor ve dönüştürüyor.
''',
    activationMantra: 'OM TARE TUTTARE TURE SVAHA - Dişil portal açılışı',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• Üreme sistemi şifası
• Hormonal denge
• Doğum hazırlığı
• Menstrual düzen

DUYGUSAL:
• Anne-çocuk ilişkisi iyileştirme
• Doğum travması çözümü
• Bağlanma sorunları
• Reddedilme yaralarının şifası

ENERJETİK:
• Dişil enerji kanallarını açar
• Yaratıcı blokajları çözer
• Kabul edicilik kapasitesini artırır

SPİRİTÜEL:
• Ana Tanrıça bağlantısı
• Geçmiş yaşam doğum deneyimleri
• Boyutsal portal erişimi
• Dişil bilgelik aktarımı
''',
    associatedChakras: ['Sakral (Svadhisthana)', 'Kök (Muladhara)'],
    associatedPlanets: ['Ay', 'Venüs'],
    keywords: ['Dişil', 'Portal', 'Yaratılış', 'Doğum', 'Rahm', 'Ana Tanrıça'],
    colorHex: '#FF69B4',
    numberOfPoints: 2,
    geometricFormula: '2 eşit daire, merkezler arası mesafe = yarıçap',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // ALTIN ORAN (PHI)
  // ─────────────────────────────────────────────────────────────────────────
  'golden_ratio': const SacredGeometrySymbol(
    id: 'golden_ratio',
    name: 'Altın Oran',
    nameSanskrit: 'Brahma Anupata',
    symbol: 'φ',
    category: SacredGeometryCategory.fundamental,
    shortDescription:
        'İlahi orantı - 1.618... Doğanın ve güzelliğin evrensel şifresi.',
    deepMeaning: '''
ALTIN ORAN - TANRISAL PROPORSIYON

Altın Oran (Phi, φ = 1.6180339887...), matematiğin en gizemli ve en güzel sayısıdır. Doğada, sanatta, mimaride ve insan bedeninde sürekli karşımıza çıkar.

MATEMATİKSEL TANIM:
İki büyüklük altın orandaysa:
(a+b)/a = a/b = φ ≈ 1.618

FİBONACCİ BAĞLANTISI:
Fibonacci dizisi (1, 1, 2, 3, 5, 8, 13, 21, 34...) içinde ardışık sayıların oranı, sonsuza giderken Altın Oran'a yaklaşır.

DOĞADA ALTIN ORAN:
• Ayçiçeği tohumlarının spiral dizilimi
• Salyangoz ve deniz kabuğu spiralleri
• Ağaç dallarının dallanma paterni
• DNA çift sarmalının boyutları
• Galaksi kollarının spiralleri
• Arı kovanındaki erkek/dişi oranı

İNSAN BEDENİNDE:
• Göbek, baştan topuğa mesafeyi altın oranda böler
• Parmak eklemlerinin oranları
• Yüz güzelliği algısı (kaş-burun-çene oranları)
• Kalp atışı ritmi

MİMARİ ve SANATTA:
• Mısır piramitleri
• Parthenon Tapınağı
• Leonardo da Vinci'nin "Vitruvius Adamı"
• Mona Lisa'nın yüz kompozisyonu
• Gotik katedrallerin pencereleri

NEDEN "İLAHİ"?
Altın Oran, kendi kendini tekrar eden sonsuz bir fraktaldır. Parçalar bütünle aynı oranı taşır - "yukarıdaki aşağıdaki gibidir" ilkesinin matematiksel kanıtı.
''',
    cosmicOrigin: '''
Kadim öğretilere göre, Altın Oran evrenin "imzası"dır - Yaratan'ın her şeye koyduğu parmak izi.

Pisagor ve öğrencileri bu oranı "Pentagram"ın (beş köşeli yıldız) içinde keşfettiler ve onu kutsal sır olarak korudular.

Platon, "Timaeus" diyaloğunda evrenin bu orana göre yaratıldığını yazmıştır.

Rönesans sanatçıları buna "İlahi Oran" (Divina Proportione) dediler. Luca Pacioli 1509'da bu adla bir kitap yazdı, Leonardo da Vinci illüstrasyonlarını çizdi.

Kepler, gezegen yörüngelerinde Altın Oran'ı bulduğunu iddia etmiştir.
''',
    spiritualSignificance: '''
SPİRİTÜEL ÖNEMİ:

1. EVRENSEL GÜZELLİK: Altın Oran'a uygun her şey "güzel" algılanır. Bu, evrensel bir estetik yasasıdır - Yaratan'ın güzellik anlayışı.

2. BÜYÜME PRENSİBİ: Tüm organik büyüme bu orana göre gerçekleşir. Spiritüel büyüme de aynı paterni takip eder.

3. HARMONİ YASASI: Altın Oran, denge ve uyumun formülüdür. Yaşamda altın oranı uygulamak, harmoni getirir.

4. SONSUZLUK İÇİNDE SONLU: Phi, irrasyonel bir sayıdır - ondalık kısmı sonsuza gider. Sonlu formda sonsuzluğun tezahürüdür.

5. BİRLİK ve ÇOKLUK: Altın Oran, birden çokluğun, çokluktan birliğin nasıl türediğini gösterir.

PRATİK UYGULAMA:
• Yaşam alanlarınızı altın orana göre düzenleyin
• Günlük zamanlamanızda bu oranı kullanın
• Kararlarınızda "bütün/parça" dengesini gözleyin
''',
    meditationPractice: '''
ALTIN ORAN MEDİTASYONU:

ARAÇLAR:
- Altın spiral görseli veya deniz kabuğu
- Fibonacci dizisi yazılı kağıt
- Geometri pergeli (isteğe bağlı)

UYGULAMA (Spiral Yolculuk - 21 dk):

1. SPIRAL GÖZLEM (5 dk):
Altın spirali dıştan içe doğru gözlerinizle takip edin. Her dönüşte daha derine inin.

2. MERKEZE YOLCULUK (5 dk):
Gözlerinizi kapatın. Spiral boyunca içe doğru hareket ettiğinizi hayal edin. Her dönüşte bilinciniz yoğunlaşıyor.

3. NOKTA BİLİNCİ (5 dk):
Spiralin merkezine ulaştınız - sonsuz küçük nokta. Burada tüm evren sıkıştırılmış halde. Bu sonsuzluk noktasını deneyimleyin.

4. DIŞA AÇILIM (5 dk):
Şimdi noktadan dışa doğru açılın. Her spiral dönüşünde genişleyin. Evren sizin içinizden doğuyor.

5. ENTEGRASYON (1 dk):
Hem merkez hem de çevre olduğunuzu hissedin. Sonlu ve sonsuz aynı anda.

MANTRA:
"Aham Anantam" (Ben sonsuzum)

FİBONACCİ NEFES:
Nefes alış-veriş sürelerini Fibonacci oranlarında tutun:
• 3 saniye iç, 5 saniye dış
• 5 saniye iç, 8 saniye dış
• 8 saniye iç, 13 saniye dış
''',
    activationMantra: 'OM ANANTAYA NAMAHA - Sonsuzluğa selam',
    healingProperties: '''
ŞIFA ÖZELLİKLERİ:

FİZİKSEL:
• Büyüme hormonu dengeleme
• Organ onarımını hızlandırma
• Simetri bozukluklarını düzeltme
• Kalp ritmi harmonizasyonu

DUYGUSAL:
• Estetik tatmin ve iç huzur
• Dengesizlik hissini azaltma
• Mükemmeliyetçiliği yumuşatma

ENERJETİK:
• Enerji akış paternlerini optimize etme
• Çakra boyutlarını dengeleme
• Aurik alanı simetrik hale getirme

SPİRİTÜEL:
• Evrensel düzenle uyum
• Yaratıcı akış durumuna erişim
• "Flow" deneyimi kolaylaştırma
• Doğayla derin bağlantı
''',
    associatedChakras: ['Solar Plexus (Manipura)', 'Kalp (Anahata)'],
    associatedPlanets: ['Venüs', 'Jüpiter'],
    keywords: ['Orantı', 'Güzellik', 'Spiral', 'Fibonacci', 'Harmoni', 'Doğa'],
    colorHex: '#DAA520',
    numberOfPoints: 1,
    geometricFormula: 'φ = (1 + √5) / 2 ≈ 1.6180339887...',
  ),
};

// ═══════════════════════════════════════════════════════════════════════════
// 2. GEZEGEN YANTRALARI (PLANETARY YANTRAS)
// ═══════════════════════════════════════════════════════════════════════════

final Map<String, YantraContent> planetaryYantras = {
  // ─────────────────────────────────────────────────────────────────────────
  // SURYA YANTRA (GÜNEŞ)
  // ─────────────────────────────────────────────────────────────────────────
  'surya_yantra': const YantraContent(
    id: 'surya_yantra',
    name: 'Surya Yantra',
    nameSanskrit: 'सूर्य यन्त्र',
    deity: 'Surya Deva (Güneş Tanrısı)',
    planet: 'Güneş (Sun)',
    symbol: '☉',
    shortDescription:
        'Güneş\'in kozmik enerjisini çağıran yantra. Canlılık, otorite ve ruhsal güç için.',
    deepMeaning: '''
SURYA YANTRA - RUHUN IŞIK KAYNAĞI

Surya Yantra, Vedik astrolojide "Graha Raja" (Gezegenlerin Kralı) olan Güneş'in kutsal geometrisidir. Bu yantra, tüm yaşamın kaynağı olan güneş enerjisini yoğunlaştırır ve yönlendirir.

GÜNEŞ'İN KOZMİK ROLÜ:
Vedik kozmolojide Güneş, fiziksel ışığın ötesinde "Atman"ın (bireysel ruhun) sembolüdür. Nasıl güneş gezegenleri aydınlatıyorsa, Atman da insan deneyimini aydınlatır.

SURYA'NIN 12 FORMU:
Vedik geleneğe göre Güneş, yıl boyunca 12 farklı form (Aditya) alır:
1. Mitra (Dostluk)
2. Ravi (Parlaklık)
3. Surya (Yaratıcı enerji)
4. Bhanu (Işık)
5. Khaga (Gökyüzü yolcusu)
6. Pushan (Besleyen)
7. Hiranyagarbha (Altın rahm)
8. Maricha (Işınlar)
9. Aditya (Aditi'nin oğlu)
10. Savitri (Uyandırıcı)
11. Arka (Iyan)
12. Bhaskara (Işık yapan)

KİMLER İÇİN GEREKLİ?
• Doğum haritasında zayıf Güneş olanlar
• Özgüven eksikliği çekenler
• Kariyer ve otorite sorunları yaşayanlar
• Baba ile ilişki sorunları olanlar
• Kalp ve göz sağlığı için
• Liderlik pozisyonlarına yükselenler
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Saf güneş enerjisi, Atman'ın yansıması

2. İÇ ÜÇGEN: Yukarı bakan üçgen, ateş elementi, eril enerji

3. 8 YAPRAKLI LOTUS: 8 yönü temsil eder, güneş enerjisini tüm yönlere yayar

4. DAİRELER: 3 iç içe daire, üç guna'yı (sattva, rajas, tamas) temsil eder

5. DIŞ KARE (BHUPURA): 4 kapılı, dört ana yönden enerji girişi
''',
    centerBindu:
        'Merkezdeki nokta, "Aham Brahmasmi" (Ben Brahman\'ım) bilincini temsil eder. Burası saf benlik bilincinin odağıdır.',
    trianglesMeaning:
        'Yukarı bakan üçgen, yükselen enerjiyi, iradenin gücünü ve spiritüel yükselişi simgeler. Ateş elementi ile doğrudan bağlantılıdır.',
    circlesMeaning:
        'Üç daire, üç bilinç seviyesini temsil eder: Jagrat (uyanıklık), Svapna (rüya), Sushupti (derin uyku).',
    lotusGates:
        '8 yapraklı lotus, 8 Vasu\'yu (kozmik enerji taşıyıcıları) temsil eder. Her yaprak farklı bir güneş niteliğini aktive eder.',
    outerSquare:
        'Bhupura, maddesel dünyayı temsil eder. 4 kapı, güneş enerjisinin dört ana yönden girmesine izin verir.',
    activationRitual: '''
SURYA YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Pazar günü şafakta yapılır
• Bakır veya altın kaplama yantra idealdir
• Kırmızı çiçekler (özellikle lotus veya hibiskus)
• Ghee (sadeyağ) lambası
• Kırmızı sandal tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı Ganga suyu veya saf su ile yıkayın. "Om Suryaya Namaha" diyerek 7 kez üzerine su serpin.

2. PRANA PRATISHTHA (Can verme):
Sağ elinizi yantra üzerine koyun. "Om Hraam Hreem Hraum Sah Suryaya Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Kırmızı çiçekleri yantra'nın 4 köşesine ve merkezine yerleştirin.

4. DEEPA (Lamba):
Ghee lambasını yantra'nın önünde yakın.
"Om Bhaskaraya Vidmahe, Divaakaraya Dhimahi, Tanno Surya Prachodayat"

5. DHYANA (Meditasyon):
Merkez bindu'ya odaklanarak 21 dakika sessiz meditasyon yapın.
''',
    mantra: 'OM HRAAM HREEM HRAUM SAH SURYAYA NAMAHA',
    mantraCount: 7000,
    bestDay: 'Pazar',
    bestTime: 'Gün doğumu (Brahma Muhurta)',
    colorScheme: 'Kırmızı, altın, turuncu',
    metalRecommended: 'Altın veya bakır',
    benefits: [
      'Özgüven ve irade gücü artışı',
      'Kariyer yükselişi ve otorite',
      'Baba ile ilişkilerin iyileşmesi',
      'Kalp sağlığının korunması',
      'Göz sağlığı ve görüş netliği',
      'Liderlik yeteneklerinin gelişimi',
      'Hükümet işlerinde başarı',
      'Şöhret ve tanınırlık',
      'Düşmanların yenilmesi',
      'Ruhsal aydınlanma',
    ],
    healingAspects: [
      'Kalp hastalıkları',
      'Göz problemleri',
      'Kemik zayıflığı',
      'D vitamini eksikliği',
      'Düşük enerji ve yorgunluk',
      'Depresyon ve karamsarlık',
    ],
    meditationGuide: '''
SURYA YANTRA MEDİTASYONU:

ZAMAN: Gün doğumundan sonraki ilk 48 dakika içinde

POZİSYON: Doğuya bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes
2. Yantra'yı göz hizasına yerleştirin
3. Merkez bindu'ya odaklanın
4. "Om Suryaya Namaha" mantrasını 108 kez tekrarlayın
5. Gözlerinizi kapatın, kalbinizde parlayan bir güneş hayal edin
6. Güneşin ışığının tüm bedeninize yayıldığını hissedin
7. Sessizlikte 10 dakika kalın
''',
    weeklyPractice: '''
HAFTALIK SURYA SADHANA:

PAZAR: Ana ibadet günü - 108 mantra + yantra meditasyonu
PAZARTESİ: Güneş selamı (Surya Namaskar) 12 tur
SALI: Yantra'ya kırmızı çiçek sunumu
ÇARŞAMBA: Gayatri mantra 21 kez
PERŞEMBE: Güneş doğumu izleme meditasyonu
CUMA: Kırmızı yiyecekler yeme (domates, biber, nar)
CUMARTESİ: Muhtaçlara buğday veya bakır bağışı
''',
    warnings: '''
UYARILAR:
• Pitta (ateş) dengesizliği olanlar dikkatli olmalı
• Aşırı öfke veya saldırganlık durumunda azaltın
• Yaz aylarında öğlen meditasyonundan kaçının
• Kalp rahatsızlığı olanlar hekim danışmalı
''',
    viralQuote:
        '"İçindeki güneşi uyandır. Sen kendi evreninin ışık kaynağısın." 🌅',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // CHANDRA YANTRA (AY)
  // ─────────────────────────────────────────────────────────────────────────
  'chandra_yantra': const YantraContent(
    id: 'chandra_yantra',
    name: 'Chandra Yantra',
    nameSanskrit: 'चन्द्र यन्त्र',
    deity: 'Chandra Deva (Ay Tanrısı)',
    planet: 'Ay (Moon)',
    symbol: '☽',
    shortDescription:
        'Ay\'ın sakinleştirici enerjisini çağıran yantra. Duygusal şifa, sezgi ve annelik için.',
    deepMeaning: '''
CHANDRA YANTRA - DUYGUSAL OKYANUSUN PUSULASI

Chandra Yantra, Vedik astrolojide "Manas Karaka" (Zihin Göstergesi) olan Ay'ın kutsal geometrisidir. Bu yantra, zihnin dalgalarını sakinleştirir ve duygusal dengeyi sağlar.

AY'IN KOZMİK ROLÜ:
Ay, "Manas" (zihin) ve "Mana" (duygu) ile ilişkilidir. Güneş ruhu temsil ederken, Ay zihni temsil eder. Güneş babayı simgelerken, Ay anneyi simgeler.

CHANDRA'NIN 16 FAZI:
Vedik geleneğe göre Ay, her gece farklı bir "Tithi" (ay fazı) gösterir. 16. faz olan "Purnima" (dolunay), Ay'ın tam gücünü temsil eder.

SOMA - İLAHİ NEKTAR:
Ay, "Soma" olarak da bilinir - tanrıların içtiği ölümsüzlük nektarı. Chandra Yantra meditasyonu, bu kozmik nektarı bedenimize çağırır.

KİMLER İÇİN GEREKLİ?
• Doğum haritasında zayıf Ay olanlar
• Duygusal dengesizlik yaşayanlar
• Anksiyete ve depresyon çekenler
• Anne ile ilişki sorunları olanlar
• Uyku bozuklukları yaşayanlar
• Sezgisel yeteneklerini geliştirmek isteyenler
• Kadınlar için özellikle bereketli
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Saf ay enerjisi, duygusal çekirdeğin sembolü

2. HİLAL: Ay'ın karakteristik şekli, dişil enerji

3. 16 YAPRAKLI LOTUS: 16 Tithi'yi (ay fazı) temsil eder

4. İÇ DAİRE: Zihnin sonsuzluğu, bilinçaltının derinliği

5. KARE BHUPURA: Maddesel dünyadaki duygusal deneyim
''',
    centerBindu:
        'Merkezdeki nokta, "Chandrama Manaso Jatah" (Ay zihinden doğdu) bilincini temsil eder. Burası saf zihinsel huzurun odağıdır.',
    trianglesMeaning:
        'Aşağı bakan üçgenler, dişil enerjiyi, içe dönüşü ve bilinçaltına inişi simgeler.',
    circlesMeaning:
        'Daireler, zihnin dalgalarını, duygusal döngüleri ve biyoritmik akışı temsil eder.',
    lotusGates:
        '16 yapraklı lotus, 16 Nitya Devi\'yi (Ay tanrıçaları) temsil eder. Her yaprak farklı bir duygusal niteliği besler.',
    outerSquare:
        'Bhupura, duygusal deneyimin maddesel dünyada ifade bulmasını temsil eder.',
    activationRitual: '''
CHANDRA YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Pazartesi gecesi, özellikle dolunay
• Gümüş yantra idealdir
• Beyaz çiçekler (yasemin, zambak, beyaz lotus)
• Ghee lambası veya ay ışığı
• Beyaz sandal tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı süt veya saf su ile yıkayın. "Om Chandraya Namaha" diyerek 9 kez üzerine süt damlatın.

2. PRANA PRATISHTHA (Can verme):
Sağ elinizi yantra üzerine koyun. "Om Shraam Shreem Shraum Sah Chandraya Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Beyaz çiçekleri yantra'nın çevresine daire şeklinde yerleştirin.

4. DEEPA (Lamba):
Ghee lambasını yantra'nın önünde yakın veya dolunay ışığına maruz bırakın.

5. DHYANA (Meditasyon):
Ay ışığı altında 27 dakika sessiz meditasyon yapın.
''',
    mantra: 'OM SHRAAM SHREEM SHRAUM SAH CHANDRAYA NAMAHA',
    mantraCount: 11000,
    bestDay: 'Pazartesi',
    bestTime: 'Gece, özellikle dolunay',
    colorScheme: 'Beyaz, gümüş, açık mavi',
    metalRecommended: 'Gümüş',
    benefits: [
      'Duygusal denge ve iç huzur',
      'Sezgi ve psişik yeteneklerin gelişimi',
      'Anne ile ilişkilerin iyileşmesi',
      'Uyku kalitesinin artması',
      'Zihinsel netlik ve odaklanma',
      'Kadın sağlığı ve bereket',
      'Yaratıcılık ve hayal gücü',
      'Su elementi dengeleme',
      'Stres ve anksiyete azalması',
      'Empati kapasitesinin artması',
    ],
    healingAspects: [
      'Uyku bozuklukları',
      'Anksiyete ve panik atak',
      'Hormonal dengesizlikler',
      'Sindirim sorunları',
      'Sıvı tutma',
      'Menstrual düzensizlikler',
    ],
    meditationGuide: '''
CHANDRA YANTRA MEDİTASYONU:

ZAMAN: Gece, özellikle ay görünürken

POZİSYON: Kuzeye bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes, "So-Ham" ile
2. Yantra'yı göğüs hizasına yerleştirin
3. Hilal şekline odaklanın
4. "Om Chandraya Namaha" mantrasını 108 kez tekrarlayın
5. Gözlerinizi kapatın, alnınızda parlayan bir ay hayal edin
6. Ay ışığının serin bir nehir gibi bedeninizden aktığını hissedin
7. Sessizlikte 15 dakika kalın
''',
    weeklyPractice: '''
HAFTALIK CHANDRA SADHANA:

PAZARTESİ: Ana ibadet günü - 108 mantra + yantra meditasyonu
SALI: Süt veya pirinç bağışı
ÇARŞAMBA: Beyaz yiyecekler yeme (pirinç, süt, beyaz peynir)
PERŞEMBE: Gece yürüyüşü, ay izleme
CUMA: Şukra-Chandra uyumu için gümüş takma
CUMARTESİ: Anneye veya anne figürüne hizmet
PAZAR: Dinlenme ve su ritüelleri
''',
    warnings: '''
UYARILAR:
• Kapha (su) dengesizliği olanlar dikkatli olmalı
• Aşırı duygusallık durumunda dengeleme gerekli
• Karanlık ay döneminde pratik azaltılmalı
• Depresyon eğilimi olanlarda profesyonel destek önemli
''',
    viralQuote:
        '"Duygularının fırtınasında sakin kalan Ay ol. Evrelerin geçer, ışığın kalır." 🌙',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // MANGAL YANTRA (MARS)
  // ─────────────────────────────────────────────────────────────────────────
  'mangal_yantra': const YantraContent(
    id: 'mangal_yantra',
    name: 'Mangal Yantra',
    nameSanskrit: 'मंगल यन्त्र',
    deity: 'Mangal Deva (Mars Tanrısı)',
    planet: 'Mars (Mangal)',
    symbol: '♂',
    shortDescription:
        'Mars\'ın savaşçı enerjisini çağıran yantra. Cesaret, güç ve koruma için.',
    deepMeaning: '''
MANGAL YANTRA - SAVAŞÇI RUHUN GEOMETRİSİ

Mangal Yantra, Vedik astrolojide "Bhoomi Putra" (Toprak Ana'nın oğlu) olan Mars'ın kutsal geometrisidir. Bu yantra, cesaret, fiziksel güç ve koruma enerjisini aktive eder.

MARS'IN KOZMİK ROLÜ:
Mars, "Kuja" olarak da bilinir ve savaşçı arketipidir. Dharma'yı (adaleti) korumak için gerekli olan güç ve cesareti temsil eder. Hanuman ile özdeşleştirilir.

MANGAL'IN DOĞASI:
• Ateş elementi - tutkulu, yoğun
• Eril enerji - eylem, inisiyatif
• Kırmızı renk - kan, yaşam gücü
• Salı günü - Mangalvara

KİMLER İÇİN GEREKLİ?
• Doğum haritasında "Mangal Dosh" olanlar
• Fiziksel güç ve dayanıklılık isteyenler
• Kariyer mücadelesinde olanlar
• Hukuki davalarla uğraşanlar
• Korku ve çekingenlik yaşayanlar
• Kardeş sorunları olanlar
• Sporcular ve askerler
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Saf Mars enerjisi, irade merkezi

2. ALTI KÖŞELI YILDIZ: Shiva-Shakti dengesi, savaşta strateji

3. 6 YAPRAKLI LOTUS: 6 düşman (kama, krodha, lobha, moha, mada, matsarya)

4. ÜÇGENLER: Ateş üçgenleri, yukarı yönelim

5. KIRMIZI RENK: Kan, yaşam gücü, tutku
''',
    centerBindu:
        'Merkezdeki nokta, "Aham Balam" (Ben güçüm) bilincini temsil eder. Burası saf irade gücünün odağıdır.',
    trianglesMeaning:
        'Yukarı bakan üçgenler, ateş enerjisini, saldırı gücünü ve dönüştürücü eylemi simgeler.',
    circlesMeaning:
        'Daireler, koruma kalkanını ve döngüsel yenilenmeyi temsil eder.',
    lotusGates:
        '6 yapraklı lotus, 6 iç düşmanın kontrol altına alınmasını temsil eder. Her yaprak bir zaafın dönüşümüdür.',
    outerSquare:
        'Bhupura, fiziksel dünyadaki mücadeleyi ve toprak bağlantısını temsil eder.',
    activationRitual: '''
MANGAL YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Salı günü gündoğumu
• Bakır yantra idealdir
• Kırmızı çiçekler (kırmızı gül, hibiskus)
• Ghee veya susam yağı lambası
• Kırmızı sandal veya kırmızı tütsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı kırmızı sandal suyu ile yıkayın. "Om Mangalaya Namaha" diyerek 5 kez üzerine kırmızı sandal serpin.

2. PRANA PRATISHTHA (Can verme):
Sağ elinizi yantra üzerine koyun. "Om Kraam Kreem Kraum Sah Bhaumaya Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Kırmızı çiçekleri yantra'nın merkezine ve köşelerine yerleştirin.

4. DEEPA (Lamba):
Susam yağı lambasını yantra'nın güneyinde yakın.

5. DHYANA (Meditasyon):
21 dakika yantra'ya odaklanarak güç ve cesaret niyeti tutun.
''',
    mantra: 'OM KRAAM KREEM KRAUM SAH BHAUMAYA NAMAHA',
    mantraCount: 10000,
    bestDay: 'Salı',
    bestTime: 'Gün doğumu veya Mars saati',
    colorScheme: 'Kırmızı, turuncu, bakır',
    metalRecommended: 'Bakır veya kırmızı altın',
    benefits: [
      'Cesaret ve özgüven artışı',
      'Fiziksel güç ve dayanıklılık',
      'Düşmanlardan korunma',
      'Hukuki davalarda başarı',
      'Mangal Dosh etkisinin azalması',
      'Kardeş ilişkilerinin iyileşmesi',
      'Spor ve rekabette üstünlük',
      'Arazi ve mülk sorunlarının çözümü',
      'Kan hastalıklarından korunma',
      'Korku ve fobilerin üstesinden gelme',
    ],
    healingAspects: [
      'Kan hastalıkları',
      'Kas problemleri',
      'Ateşli hastalıklar',
      'Enfeksiyonlar',
      'Yaralanmalardan korunma',
      'Adrenal yorgunluk',
    ],
    meditationGuide: '''
MANGAL YANTRA MEDİTASYONU:

ZAMAN: Salı günü şafakta veya Mars saatinde

POZİSYON: Güneye bakarak oturun

UYGULAMA:
1. 5 dakika güçlü nefes (Bhastrika)
2. Yantra'yı karın hizasına yerleştirin
3. Altı köşeli yıldıza odaklanın
4. "Om Mangalaya Namaha" mantrasını 108 kez güçlü sesle tekrarlayın
5. Gözlerinizi kapatın, karnınızda kırmızı ateş topu hayal edin
6. Bu ateşin sizi koruyucu bir kalkan gibi sardığını hissedin
7. "Aham Balam, Aham Veerya" (Ben güçüm, Ben cesaretim) afirmasyonu
''',
    weeklyPractice: '''
HAFTALIK MANGAL SADHANA:

SALI: Ana ibadet günü - 108 mantra + yantra meditasyonu
ÇARŞAMBA: Fiziksel egzersiz veya dövüş sanatları
PERŞEMBE: Hanuman Chalisa okuma
CUMA: Kırmızı yiyecekler yeme (kırmızı mercimek, pancar)
CUMARTESİ: Kırmızı kumaş veya bakır bağışı
PAZAR: Güneş selamı ile Mars-Güneş uyumu
PAZARTESİ: Dinlenme, Mars enerjisini dengeleme
''',
    warnings: '''
UYARILAR:
• Öfke ve saldırganlık eğilimi olanlarda dikkatli kullanım
• Pitta dengesizliği olanlarda azaltma gerekebilir
• Hamilelikte kaçınılmalı
• Kalp rahatsızlığı olanlarda yorucu nefes çalışmalarından kaçının
''',
    viralQuote:
        '"Savaşçı, dışarıdaki düşmanı değil, içindeki korkuyu yenen kişidir." 🔥',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // BUDH YANTRA (MERKÜR)
  // ─────────────────────────────────────────────────────────────────────────
  'budh_yantra': const YantraContent(
    id: 'budh_yantra',
    name: 'Budh Yantra',
    nameSanskrit: 'बुध यन्त्र',
    deity: 'Budh Deva (Merkür Tanrısı)',
    planet: 'Merkür (Mercury)',
    symbol: '☿',
    shortDescription:
        'Merkür\'ün iletişim enerjisini çağıran yantra. Zeka, konuşma ve ticaret için.',
    deepMeaning: '''
BUDH YANTRA - ZİHNİN KANATLI ELÇISI

Budh Yantra, Vedik astrolojide "Vakpati" (Konuşma Lordu) olan Merkür'ün kutsal geometrisidir. Bu yantra, iletişim becerilerini, zekayı ve ticari başarıyı artırır.

MERKÜR'ÜN KOZMİK ROLÜ:
Budh, Ay'ın oğlu ve Tara'nın aşkından doğmuştur. Boyutsuz zekayt temsil eder - nötr, uyumlu ve her duruma adapte olabilen.

BUDH'UN NİTELİKLERİ:
• Hava elementi - iletişim, hareket
• Dual doğa - hem eril hem dişil
• Yeşil renk - büyüme, yenilik
• Çarşamba günü - Budhvara

KİMLER İÇİN GEREKLİ?
• Öğrenciler ve akademisyenler
• Yazarlar ve gazeteciler
• Tüccarlar ve iş insanları
• Konuşmacılar ve öğretmenler
• Astrologlar ve danışmanlar
• Hesap ve finans işinde çalışanlar
• İletişim sorunları yaşayanlar
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Saf zeka, anlık kavrayış

2. İKİ İÇ İÇE ÜÇGEN: Dual doğa, analiz ve sentez

3. 5 YAPRAKLI LOTUS: Beş duyu, bilgi toplama

4. DAİRELER: Döngüsel düşünme, sürekli öğrenme

5. YEŞİL RENK: Büyüme, adaptasyon, yenilik
''',
    centerBindu:
        'Merkezdeki nokta, "Aham Jnana" (Ben bilgiyim) bilincini temsil eder. Burası saf zekanın odağıdır.',
    trianglesMeaning:
        'İki iç içe üçgen, analitik ve sezgisel zekanın birleşimini, mantık ve sezginin dengesini simgeler.',
    circlesMeaning:
        'Daireler, düşüncenin sonsuz döngüsünü, bilginin akışkanlığını temsil eder.',
    lotusGates:
        '5 yapraklı lotus, beş duyudan gelen bilgiyi temsil eder. Her yaprak farklı bir algı kanalıdır.',
    outerSquare:
        'Bhupura, bilginin pratik uygulamasını ve iş dünyasını temsil eder.',
    activationRitual: '''
BUDH YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Çarşamba günü sabah veya akşam
• Bronz veya pirinç yantra idealdir
• Yeşil yapraklar ve çiçekler
• Ghee lambası
• Sandal tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı sandal suyu ile yıkayın. "Om Budhaya Namaha" diyerek 4 kez üzerine sandal serpin.

2. PRANA PRATISHTHA (Can verme):
Sağ elinizi yantra üzerine koyun. "Om Braam Breem Braum Sah Budhaya Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Yeşil yaprakları ve çiçekleri yantra'nın üzerine spiral şeklinde yerleştirin.

4. DEEPA (Lamba):
Ghee lambasını yantra'nın kuzeyinde yakın.

5. DHYANA (Meditasyon):
17 dakika yantra'ya odaklanarak netlik niyeti tutun.
''',
    mantra: 'OM BRAAM BREEM BRAUM SAH BUDHAYA NAMAHA',
    mantraCount: 9000,
    bestDay: 'Çarşamba',
    bestTime: 'Gün doğumu veya gün batımı',
    colorScheme: 'Yeşil, sarımsı yeşil',
    metalRecommended: 'Bronz veya pirinç',
    benefits: [
      'İletişim becerilerinin artması',
      'Akademik başarı ve sınav başarısı',
      'Ticari zeka ve iş başarısı',
      'Yazarlık ve hitabet yeteneği',
      'Çoklu dil öğrenme kolaylığı',
      'Matematiksel ve analitik düşünme',
      'Sinir sistemi dengelenmesi',
      'Cilt sağlığının iyileşmesi',
      'Stres ve gerginlik azalması',
      'Karar verme netliği',
    ],
    healingAspects: [
      'Sinir sistemi bozuklukları',
      'Konuşma güçlükleri',
      'Cilt hastalıkları',
      'Solunum problemleri',
      'Bellek zayıflığı',
      'Dikkat eksikliği',
    ],
    meditationGuide: '''
BUDH YANTRA MEDİTASYONU:

ZAMAN: Çarşamba sabahı veya akşamı

POZİSYON: Kuzeye bakarak oturun

UYGULAMA:
1. 5 dakika alternatif burun nefesi (Nadi Shodhana)
2. Yantra'yı göz hizasına yerleştirin
3. İç içe üçgenlere odaklanın
4. "Om Budhaya Namaha" mantrasını 108 kez sessizce tekrarlayın
5. Gözlerinizi kapatın, alnınızda yeşil bir ışık hayal edin
6. Bu ışığın beyin yapınızı aktive ettiğini hissedin
7. Sessizlikte 10 dakika kalın, gelen fikirleri izleyin
''',
    weeklyPractice: '''
HAFTALIK BUDH SADHANA:

ÇARŞAMBA: Ana ibadet günü - 108 mantra + yantra meditasyonu
PERŞEMBE: Yeni bir şey öğrenme, okuma
CUMA: Yazı yazma, günlük tutma
CUMARTESİ: Yeşil sebze bağışı
PAZAR: Eğitim ile ilgili hayır işleri
PAZARTESİ: Sessiz gözlem, dinleme pratiği
SALI: Matematik veya bulmaca çözme
''',
    warnings: '''
UYARILAR:
• Aşırı düşünme eğilimi olanlarda dengeleme gerekli
• Vata dengesizliği olanlarda topraklama önemli
• Retro Merkür dönemlerinde fazla yüklenmeyin
• Nefes çalışmalarını aç karnına yapmayın
''',
    viralQuote:
        '"Gerçek bilgelik, bildiğini paylaşmakta ve bilmediğini kabul etmektedir." 📚',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // GURU YANTRA (JÜPİTER)
  // ─────────────────────────────────────────────────────────────────────────
  'guru_yantra': const YantraContent(
    id: 'guru_yantra',
    name: 'Guru Yantra',
    nameSanskrit: 'गुरु यन्त्र',
    deity: 'Brihaspati (Jüpiter Tanrısı)',
    planet: 'Jüpiter (Jupiter)',
    symbol: '♃',
    shortDescription:
        'Jüpiter\'in genişletici enerjisini çağıran yantra. Bilgelik, şans ve spiritüel büyüme için.',
    deepMeaning: '''
GURU YANTRA - BİLGELİĞİN ALTAIR PORTALI

Guru Yantra, Vedik astrolojide "Deva Guru" (Tanrıların Öğretmeni) olan Jüpiter'in kutsal geometrisidir. Bu yantra, bilgeliği, şansı ve spiritüel gelişimi çağırır.

JÜPİTER'İN KOZMİK ROLÜ:
Brihaspati, tanrıların başrahibi ve öğretmenidir. En "Shubha" (hayırlı) gezegen olarak kabul edilir. Dharma (erdem), Jnana (bilgi) ve Bhagya (şans) karaka'sıdır.

GURU'NUN NİTELİKLERİ:
• Eter elementi - genişleme, sonsuzluk
• Eril enerji - koruma, öğretim
• Sarı renk - bilgelik, aydınlanma
• Perşembe günü - Brihaspativara/Guruvara

KİMLER İÇİN GEREKLİ?
• Spiritüel öğretmenler ve öğrenciler
• Hukuk ve adalet alanında çalışanlar
• Çocuk sahibi olmak isteyenler
• Mali bolluk arayanlar
• Yurtdışı seyahat ve eğitim isteyenler
• Evlilik arayanlar (özellikle kadınlar için)
• Yayıncılık ve akademi alanında olanlar
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Saf bilgelik, guru bilinci

2. ALTIN ÜÇGEN: Dharma-Artha-Kama'nın dengelenmesi

3. 8 YAPRAKLI LOTUS: Ashtanga (sekiz kollu yoga)

4. GENİŞ DAİRELER: Sonsuz genişleme, bolluk

5. SARI/ALTIN RENK: Bilgelik, zenginlik, aydınlanma
''',
    centerBindu:
        'Merkezdeki nokta, "Guru Brahma, Guru Vishnu, Guru Devo Maheshwara" bilincini temsil eder. Burası saf öğretinin kaynağıdır.',
    trianglesMeaning:
        'Altın üçgen, üç dünyayı (gök, yer, yeraltı) ve üç zamani (geçmiş, şimdi, gelecek) birleştiren bilgeliği simgeler.',
    circlesMeaning:
        'Daireler, bilgeliğin sonsuz genişlemesini, etkinin yayılmasını temsil eder.',
    lotusGates:
        '8 yapraklı lotus, Ashtanga Yoga\'nın sekiz dalını temsil eder: Yama, Niyama, Asana, Pranayama, Pratyahara, Dharana, Dhyana, Samadhi.',
    outerSquare:
        'Bhupura, bilgeliğin dünyevi hayatta uygulanmasını ve toplumsal statüyü temsil eder.',
    activationRitual: '''
GURU YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Perşembe günü sabah Brahma Muhurta'da
• Altın veya pirinç yantra idealdir
• Sarı çiçekler (sarı gül, kadife çiçeği)
• Ghee lambası
• Sandal veya safran tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı safran suyu ile yıkayın. "Om Gurave Namaha" diyerek 5 kez üzerine safran serpin.

2. PRANA PRATISHTHA (Can verme):
Sağ elinizi yantra üzerine koyun. "Om Graam Greem Graum Sah Gurave Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Sarı çiçekleri ve nohut tanelerini yantra'nın üzerine yerleştirin.

4. DEEPA (Lamba):
Ghee lambasını yantra'nın kuzeydoğusunda yakın.

5. DHYANA (Meditasyon):
19 dakika yantra'ya odaklanarak bilgelik ve bolluk niyeti tutun.
''',
    mantra: 'OM GRAAM GREEM GRAUM SAH GURAVE NAMAHA',
    mantraCount: 19000,
    bestDay: 'Perşembe',
    bestTime: 'Brahma Muhurta (şafaktan önce)',
    colorScheme: 'Sarı, altın',
    metalRecommended: 'Altın veya pirinç',
    benefits: [
      'Bilgelik ve spiritüel büyüme',
      'Mali bolluk ve şans',
      'Evlilik için uygun eş bulma',
      'Çocuk sahibi olma',
      'Yurtdışı fırsatları',
      'Akademik ve yayıncılık başarısı',
      'Hukuki davalarda lehte sonuç',
      'Guru ve öğretmen bulma',
      'Karaciğer ve kalça sağlığı',
      'Sosyal statü yükselmesi',
    ],
    healingAspects: [
      'Karaciğer hastalıkları',
      'Kalça ve uyluk problemleri',
      'Şeker hastalığı',
      'Obezite',
      'Kulak rahatsızlıkları',
      'Bağışıklık sistemi zayıflığı',
    ],
    meditationGuide: '''
GURU YANTRA MEDİTASYONU:

ZAMAN: Perşembe sabahı şafaktan önce

POZİSYON: Kuzeydoğuya bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes, minnet hissi ile
2. Yantra'yı kalp hizasına yerleştirin
3. Altın üçgene odaklanın
4. "Om Gurave Namaha" mantrasını 108 kez okuyun
5. Gözlerinizi kapatın, kalbinizde altın bir güneş hayal edin
6. Bu güneşin bilgelik ışığının sizi sardığını hissedin
7. Sessizlikte 15 dakika kalın, içsel öğretilere açık olun
''',
    weeklyPractice: '''
HAFTALIK GURU SADHANA:

PERŞEMBE: Ana ibadet günü - 108 mantra + yantra meditasyonu
CUMA: Spiritüel kitap okuma
CUMARTESİ: Sarı yiyecekler yeme (nohut, mısır, muz)
PAZAR: Öğretmenlere ve yaşlılara hizmet
PAZARTESİ: Vishnu sahasranama dinleme
SALI: Hayır kurumlarına sarı kumaş bağışı
ÇARŞAMBA: Bilgi paylaşma, öğretme
''',
    warnings: '''
UYARILAR:
• Aşırı iyimserlik ve gerçeklikten kopma riski
• Kapha dengesizliği olanlarda dikkatli olun
• Şişmanlık eğilimi varsa diyet önemli
• Ego şişmesine karşı alçakgönüllülük pratiği
''',
    viralQuote:
        '"Gerçek guru, dışarıda aradığını içinde bulmana yardım edendir." ✨',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // SHUKRA YANTRA (VENÜS)
  // ─────────────────────────────────────────────────────────────────────────
  'shukra_yantra': const YantraContent(
    id: 'shukra_yantra',
    name: 'Shukra Yantra',
    nameSanskrit: 'शुक्र यन्त्र',
    deity: 'Shukracharya (Venüs Tanrısı)',
    planet: 'Venüs (Venus)',
    symbol: '♀',
    shortDescription:
        'Venüs\'ün aşk ve güzellik enerjisini çağıran yantra. Romantizm, sanat ve lüks için.',
    deepMeaning: '''
SHUKRA YANTRA - AŞK VE GÜZELLİĞİN KRİSTAL KAPISI

Shukra Yantra, Vedik astrolojide "Kavi" (Şair) ve "Daityaguru" (Asuraların Öğretmeni) olan Venüs'ün kutsal geometrisidir. Bu yantra, aşk, güzellik, sanat ve maddi zevkleri çağırır.

VENÜS'ÜN KOZMİK ROLÜ:
Shukra, güzelliğin, aşkın, sanatın ve maddi mükemmelliğin tanrısıdır. Tantra'nın ve seksüel enerji biliminin (Kama Shastra) koruyucusudur.

SHUKRA'NIN NİTELİKLERİ:
• Su elementi - akışkanlık, çekicilik
• Dişil enerji - kabul edicilik, yaratıcılık
• Beyaz/pembe renk - saflık, aşk
• Cuma günü - Shukravara

TANTRİK BAĞLANTI:
Shukra, tantra yolunun koruyucusudur. "Shukra" kelimesi aynı zamanda "meni" anlamına gelir - yaratıcı yaşam gücü. Bu yantra, seksüel enerjiyi ruhsal güce dönüştürmeye yardımcı olur.

KİMLER İÇİN GEREKLİ?
• Aşk ve romantizm arayanlar
• Evlilik sorunları yaşayanlar
• Sanatçılar ve yaratıcılar
• Güzellik ve moda sektöründe çalışanlar
• Maddi lüks ve konfor isteyenler
• Araç alımı düşünenler
• Cinsel sağlık ve uyum arayanlar
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Saf aşk enerjisi, Shakti özü

2. VESİCA PİSCİS: İlahi dişil, yaratıcı rahm

3. 16 YAPRAKLI LOTUS: 16 Kala (sanat formu), 16 ay fazı

4. DAİRESEL AKIŞLAR: Su elementi, duygusal akış

5. BEYAZ/PEMBE RENK: Saflık, romantizm, şefkat
''',
    centerBindu:
        'Merkezdeki nokta, "Aham Prema" (Ben aşkım) bilincini temsil eder. Burası saf çekiciliğin ve aşkın kaynağıdır.',
    trianglesMeaning:
        'Aşağı bakan üçgenler, dişil enerjiyi, yaratıcı gücü ve maddi manifestasyonu simgeler.',
    circlesMeaning:
        'Daireler, ilişkilerin döngüselliğini, karma bağların akışını temsil eder.',
    lotusGates:
        '16 yapraklı lotus, 16 Kala\'yı (sanat formları) ve 16 Nitya Devi\'yi (tanrıçaları) temsil eder.',
    outerSquare:
        'Bhupura, maddi dünyada güzelliğin ve lüksün manifestasyonunu temsil eder.',
    activationRitual: '''
SHUKRA YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Cuma günü gün doğumu veya akşam
• Gümüş veya bakır yantra idealdir
• Beyaz veya pembe çiçekler (gül, zambak, yasemin)
• Ghee lambası veya güzel kokulu mum
• Gül veya yasemin tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı gül suyu ile yıkayın. "Om Shukraya Namaha" diyerek 6 kez üzerine gül suyu serpin.

2. PRANA PRATISHTHA (Can verme):
Sağ elinizi yantra üzerine koyun. "Om Draam Dreem Draum Sah Shukraya Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Gülleri ve yasemin çiçeklerini yantra'nın üzerine kalp şeklinde yerleştirin.

4. DEEPA (Lamba):
Ghee lambasını yantra'nın güneydoğusunda yakın.

5. DHYANA (Meditasyon):
16 dakika yantra'ya odaklanarak aşk ve güzellik niyeti tutun.
''',
    mantra: 'OM DRAAM DREEM DRAUM SAH SHUKRAYA NAMAHA',
    mantraCount: 16000,
    bestDay: 'Cuma',
    bestTime: 'Gün doğumu veya akşam',
    colorScheme: 'Beyaz, pembe, gümüş',
    metalRecommended: 'Gümüş veya bakır',
    benefits: [
      'Aşk ve romantizm çekme',
      'Evlilikte uyum ve mutluluk',
      'Sanatsal yeteneklerin gelişimi',
      'Fiziksel çekicilik artışı',
      'Maddi lüks ve konfor',
      'Araç ve mülk kazanımı',
      'Cinsel sağlık ve uyum',
      'Yaratıcılık ve ilham',
      'Sosyal popülerlik',
      'Moda ve güzellik başarısı',
    ],
    healingAspects: [
      'Böbrek hastalıkları',
      'Üreme sistemi sorunları',
      'Cilt problemleri',
      'Hormonal dengesizlikler',
      'Şeker metabolizması',
      'Boğaz ve ses teli sorunları',
    ],
    meditationGuide: '''
SHUKRA YANTRA MEDİTASYONU:

ZAMAN: Cuma akşamı veya şafakta

POZİSYON: Güneydoğuya bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes, gül kokusu ile
2. Yantra'yı kalp hizasına yerleştirin
3. Vesica Piscis'e odaklanın
4. "Om Shukraya Namaha" mantrasını 108 kez yumuşak sesle tekrarlayın
5. Gözlerinizi kapatın, kalbinizde pembe bir gül hayal edin
6. Gülün açılmasını ve güzel koku yaymasını izleyin
7. Sessizlikte 15 dakika kalın, aşkı hissedin
''',
    weeklyPractice: '''
HAFTALIK SHUKRA SADHANA:

CUMA: Ana ibadet günü - 108 mantra + yantra meditasyonu
CUMARTESİ: Sanat eseri yaratma veya izleme
PAZAR: Romantik aktivite, partnerle vakit
PAZARTESİ: Güzellik bakımı, öz bakım
SALI: Beyaz çiçek veya parfüm bağışı
ÇARŞAMBA: Müzik veya dans
PERŞEMBE: Beyaz yiyecekler yeme (pirinç, süt, şeker)
''',
    warnings: '''
UYARILAR:
• Aşırı haz düşkünlüğü riski
• Kapha dengesizliği ve şişmanlık eğilimi
• Bağımlılık yapıcı ilişkilerden kaçının
• Maddi lükse takılmayın, ruhsal değerleri unutmayın
''',
    viralQuote:
        '"Aşk, evrenin en güçlü büyüsüdür. Her şey onun için yaratıldı." 🌹',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // SHANI YANTRA (SATÜRN)
  // ─────────────────────────────────────────────────────────────────────────
  'shani_yantra': const YantraContent(
    id: 'shani_yantra',
    name: 'Shani Yantra',
    nameSanskrit: 'शनि यन्त्र',
    deity: 'Shani Deva (Satürn Tanrısı)',
    planet: 'Satürn (Saturn)',
    symbol: '♄',
    shortDescription:
        'Satürn\'ün karma enerjisini çağıran yantra. Disiplin, sabır ve karmik çözülme için.',
    deepMeaning: '''
SHANI YANTRA - KARMA LORDU'NUN ADALET TERAZİSİ

Shani Yantra, Vedik astrolojide "Karma Karaka" (Karma Lordu) ve "Nyaya Raja" (Adalet Kralı) olan Satürn'ün kutsal geometrisidir. Bu yantra, karmik yükleri hafifletir ve disiplin getirir.

SATÜRN'ÜN KOZMİK ROLÜ:
Shani, Güneş'in (Surya) oğludur ancak babasının ışığından uzak kalmıştır. Bu yüzden "gölgenin lordu" olarak bilinir. Adalet ve karma yasasının yürütücüsüdür.

SHANI'NIN ÖĞRETİLERİ:
• Sabır ve dayanıklılık
• Alçakgönüllülük ve hizmet
• Disiplin ve çalışkanlık
• Ayrılık ve yalnızlığın bilgeliği
• Zamanın değeri
• Maddi dünyadan kopuş

SADE SATI VE SHANI DASHA:
Shani Yantra özellikle Sade Sati (7.5 yıllık Satürn transit dönemi) veya Shani Dasha/Antardasha dönemlerinde çok önemlidir.

KİMLER İÇİN GEREKLİ?
• Sade Sati döneminde olanlar
• Shani Dasha yaşayanlar
• Kronik hastalıklar çekenler
• Kariyer engeleri olanlar
• Gecikmiş evlilik veya çocuk
• Hukuki sorunlar yaşayanlar
• Borç ve finansal sıkıntılar
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Karmik merkez, adalet noktası

2. KARE İÇİNDE KARE: Stabilite, sınırlar, yapı

3. 8 YAPRAKLI LOTUS: 8 yönün korunması

4. KOYU RENKLİ ÜÇGENLER: Gölge çalışması, bilinçaltı

5. SİYAH/KOYU MAVİ: Gece, derinlik, gizemler
''',
    centerBindu:
        'Merkezdeki nokta, "Karma Phala" (karmanın meyvesi) bilincini temsil eder. Burası karmik hesabın odağıdır.',
    trianglesMeaning:
        'Aşağı bakan üçgenler, bilinçaltının derinliklerine inişi, gölge entegrasyonunu simgeler.',
    circlesMeaning:
        'Daireler, zamanın döngüselliğini, karmik tekrarları temsil eder.',
    lotusGates:
        '8 yapraklı lotus, 8 yönden korunmayı ve 8 siddhi\'yi temsil eder.',
    outerSquare:
        'Bhupura, maddi dünyanın sınırlarını ve yapısal düzeni temsil eder.',
    activationRitual: '''
SHANI YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Cumartesi günü gün batımında veya gece
• Demir veya çelik yantra idealdir
• Koyu mavi veya siyah çiçekler
• Susam yağı lambası
• Lobhan (benzoin) tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı siyah susam suyu ile yıkayın. "Om Shanaye Namaha" diyerek 8 kez üzerine susam serpin.

2. PRANA PRATISHTHA (Can verme):
Sol elinizi yantra üzerine koyun. "Om Praam Preem Praum Sah Shanaye Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Koyu çiçekleri ve siyah susam tohumlarını yantra'nın etrafına yerleştirin.

4. DEEPA (Lamba):
Susam yağı lambasını yantra'nın batısında yakın.

5. DHYANA (Meditasyon):
23 dakika yantra'ya odaklanarak karmik çözülme niyeti tutun.
''',
    mantra: 'OM PRAAM PREEM PRAUM SAH SHANAYE NAMAHA',
    mantraCount: 23000,
    bestDay: 'Cumartesi',
    bestTime: 'Gün batımı veya gece',
    colorScheme: 'Siyah, koyu mavi, mor',
    metalRecommended: 'Demir veya çelik',
    benefits: [
      'Sade Sati etkilerinin hafiflemesi',
      'Karmik borçların ödenmesi',
      'Disiplin ve sabır kazanma',
      'Kariyer engellerinin kalkması',
      'Hukuki sorunların çözümü',
      'Kronik hastalıkların iyileşmesi',
      'Borçlardan kurtulma',
      'Gecikmiş evlilik/çocuk için destek',
      'Düşmanlardan korunma',
      'Spiritüel olgunlaşma',
    ],
    healingAspects: [
      'Kemik ve eklem hastalıkları',
      'Kronik ağrılar',
      'Sinir sistemi bozuklukları',
      'Depresyon ve melankoli',
      'Cilt hastalıkları',
      'Ayak ve bacak sorunları',
    ],
    meditationGuide: '''
SHANI YANTRA MEDİTASYONU:

ZAMAN: Cumartesi akşamı gün batımında

POZİSYON: Batıya bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes, her nefeşte geçmişi bırakın
2. Yantra'yı göğüs hizasına yerleştirin
3. İç içe karelere odaklanın
4. "Om Shanaye Namaha" mantrasını 108 kez sessizce tekrarlayın
5. Gözlerinizi kapatın, karanlık bir boşluk hayal edin
6. Bu boşlukta tüm korkuların ve karmaların eridiğini görün
7. Sessizlikte 20 dakika kalın, teslimiyeti deneyimleyin
''',
    weeklyPractice: '''
HAFTALIK SHANI SADHANA:

CUMARTESİ: Ana ibadet günü - 108 mantra + yantra meditasyonu
PAZAR: Yaşlılara ve engellilere hizmet
PAZARTESİ: Hanuman Chalisa okuma
SALI: Siyah susam veya demir bağışı
ÇARŞAMBA: Sessiz gün, iç gözlem
PERŞEMBE: Kargalara yiyecek verme
CUMA: Toprak işleri, bahçecilik
''',
    warnings: '''
UYARILAR:
• Depresyon eğilimi olanlarda dikkatli kullanım
• Aşırı yalnızlaşmaya karşı sosyal bağları koruyun
• Negatif düşünce döngülerine girmekten kaçının
• Profesyonel psikolojik destek almaktan çekinmeyin
''',
    viralQuote:
        '"Satürn seni yıkmak için değil, gerçekten ne olduğunu göstermek için gelir." 🪐',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // RAHU YANTRA
  // ─────────────────────────────────────────────────────────────────────────
  'rahu_yantra': const YantraContent(
    id: 'rahu_yantra',
    name: 'Rahu Yantra',
    nameSanskrit: 'राहु यन्त्र',
    deity: 'Rahu (Kuzey Ay Düğümü)',
    planet: 'Rahu (North Node)',
    symbol: '☊',
    shortDescription:
        'Rahu\'nun gölge enerjisini çağıran yantra. Obsesyonların dönüşümü ve gizli potansiyelin açığa çıkması için.',
    deepMeaning: '''
RAHU YANTRA - GÖLGE EJDERHA'NIN GİZEMLİ PORTALI

Rahu Yantra, Vedik astrolojide "Chaya Graha" (Gölge Gezegen) olan Rahu'nun kutsal geometrisidir. Bu yantra, gizli arzuları, obsesyonları ve karanlık potansiyeli aydınlatır.

RAHU'NUN KOZMİK ROLÜ:
Rahu, kozmik yılanın (Vasuki) başıdır. Efsaneye göre, tanrılar ölümsüzlük nektarını (amrita) içerken, Rahu da gizlice içmeye çalıştı. Vishnu onun başını kesti, ama nektar sayesinde baş ölümsüz kaldı.

RAHU'NUN DOĞASI:
• Gölge gezegen - fiziksel bedeni yok
• Kuzeyde yükselen düğüm
• Materyal arzular ve hırslar
• Obsesif ve bağımlılık eğilimleri
• Teknoloji ve modernite
• Yabancı kültürler ve seyahatler

RAHU'NUN GÖLGELERİ:
• Aşırı hırs ve açgözlülük
• Yanılsama ve kafa karışıklığı
• Bağımlılıklar
• Korkular ve fobiler
• Aldatma ve manipülasyon

KİMLER İÇİN GEREKLİ?
• Rahu Dasha veya Antardasha döneminde olanlar
• Bağımlılıklarla mücadele edenler
• Ani değişimler yaşayanlar
• Yurtdışı fırsatları arayanlar
• Teknoloji sektöründe çalışanlar
• Psişik koruma isteyenler
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Gizli arzu, gölge çekirdeği

2. SPIRAL FORMLAR: Yılan hareketi, enerji sarmalları

3. 18 YAPRAKLI LOTUS: 18 siddhi, gizli güçler

4. AYLIK DÜĞÜm SEMBOLÜ: Kuzey Ay Düğümü

5. KOYU RENKLER: Gizem, bilinmeyenler
''',
    centerBindu:
        'Merkezdeki nokta, bastırılmış arzuların ve gizli korkuların kaynağını temsil eder.',
    trianglesMeaning:
        'Spiral ve üçgenler, enerji sarmallarını ve yükselişi simgeler.',
    circlesMeaning:
        'Daireler, tutulma döngülerini ve karanlık-aydınlık geçişlerini temsil eder.',
    lotusGates:
        '18 yapraklı lotus, 18 gizli siddhi\'yi ve Rahu\'nun 18 yıllık döngüsünü temsil eder.',
    outerSquare: 'Bhupura, illüzyonun ve maya\'nın sınırlarını temsil eder.',
    activationRitual: '''
RAHU YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Cumartesi veya Çarşamba gece yarısı
• Kurşun veya karma metal yantra
• Mavi/mor çiçekler
• Hardal yağı lambası
• Lobhan veya guggul tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı mavi çiçek suyu ile yıkayın. "Om Rahave Namaha" diyerek 18 kez üzerine su serpin.

2. PRANA PRATISHTHA (Can verme):
Sol elinizi yantra üzerine koyun. "Om Bhram Bhreem Bhraum Sah Rahave Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Mavi çiçekleri ve hardal tohumlarını yantra'nın etrafına spiral şeklinde yerleştirin.

4. DEEPA (Lamba):
Hardal yağı lambasını yantra'nın güneybatısında yakın.

5. DHYANA (Meditasyon):
18 dakika yantra'ya odaklanarak gölge entegrasyonu niyeti tutun.
''',
    mantra: 'OM BHRAM BHREEM BHRAUM SAH RAHAVE NAMAHA',
    mantraCount: 18000,
    bestDay: 'Cumartesi veya Çarşamba',
    bestTime: 'Gece yarısı veya tutulma zamanları',
    colorScheme: 'Koyu mavi, siyah, duman rengi',
    metalRecommended: 'Kurşun veya karma metal',
    benefits: [
      'Rahu Dasha etkilerinin hafiflemesi',
      'Gölge entegrasyonu ve farkındalık',
      'Bağımlılıklardan kurtulma',
      'Psişik koruma',
      'Yurtdışı fırsatları',
      'Teknoloji ve inovasyonda başarı',
      'Ani şans ve beklenmedik kazançlar',
      'Düşmanlardan korunma',
      'Politika ve güç konularında başarı',
      'Gizli yeteneklerin açığa çıkması',
    ],
    healingAspects: [
      'Ruhsal bozukluklar',
      'Bağımlılıklar',
      'Fobiler ve panik atak',
      'Kronik yorgunluk sendromu',
      'Bilinmeyen hastalıklar',
      'Beyin ve sinir sistemi',
    ],
    meditationGuide: '''
RAHU YANTRA MEDİTASYONU:

ZAMAN: Cumartesi gece yarısı veya tutulma dönemlerinde

POZİSYON: Güneybatıya bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes, karanlığı kabul ederek
2. Yantra'yı göğüs hizasına yerleştirin
3. Spiral formlara odaklanın
4. "Om Rahave Namaha" mantrasını 108 kez fısıldayarak tekrarlayın
5. Gözlerinizi kapatın, bir yılanın sizin etrafınızda döndüğünü hayal edin
6. Yılanın sizi koruduğunu ve gizli bilgiyi aktardığını hissedin
7. Sessizlikte 18 dakika kalın, gelen görüntüleri izleyin
''',
    weeklyPractice: '''
HAFTALIK RAHU SADHANA:

CUMARTESİ: Ana ibadet günü - 108 mantra + yantra meditasyonu
PAZAR: Rüya günlüğü tutma
PAZARTESİ: Mavi/mor yiyecekler yeme (patlıcan, mor lahana)
SALI: Sessiz gözlem, gölge farkındalığı
ÇARŞAMBA: İkinci ibadet günü, hardal yağı bağışı
PERŞEMBE: Spiritüel kitap okuma
CUMA: Meditasyon ve bilinçaltı çalışması
''',
    warnings: '''
UYARILAR:
• Psikoz veya ciddi ruhsal bozukluk öyküsü olanlarda kaçının
• Uyuşturucu veya alkol kullanırken yapmayın
• Tutulma günlerinde dikkatli olun
• Profesyonel spiritüel rehberlik önerilir
• Karanlık enerjilerle oynamayın
''',
    viralQuote:
        '"Gölgeni kucakla. O da senin bir parçan - belki de en güçlü parçan." 🐍',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // KETU YANTRA
  // ─────────────────────────────────────────────────────────────────────────
  'ketu_yantra': const YantraContent(
    id: 'ketu_yantra',
    name: 'Ketu Yantra',
    nameSanskrit: 'केतु यन्त्र',
    deity: 'Ketu (Güney Ay Düğümü)',
    planet: 'Ketu (South Node)',
    symbol: '☋',
    shortDescription:
        'Ketu\'nun spiritüel ayrılık enerjisini çağıran yantra. Moksha, aydınlanma ve geçmiş yaşam bilgeliği için.',
    deepMeaning: '''
KETU YANTRA - KURTULUŞUN BAŞSIZ BİLGESİ

Ketu Yantra, Vedik astrolojide "Moksha Karaka" (Kurtuluş Göstergesi) olan Ketu'nun kutsal geometrisidir. Bu yantra, spiritüel ayrılığı, geçmiş yaşam bilgeliğini ve nihai kurtuluşu çağırır.

KETU'NUN KOZMİK ROLÜ:
Ketu, kozmik yılanın gövdesidir - başsız, yani mantık ve ego'dan arınmış. Sezgisel bilgeliği ve spiritüel kavrayışı temsil eder.

KETU'NUN DOĞASI:
• Gölge gezegen - fiziksel bedeni yok
• Güneyde alçalan düğüm
• Spiritüel ayrılık ve vazgeçiş
• Geçmiş yaşam karmaları
• Mistik deneyimler
• Sezgi ve psişik yetenekler

KETU'NUN HEDİYELERİ:
• Maddi dünyadan ayrılma yeteneği
• Derin meditasyon kapasitesi
• Geçmiş yaşam hatırlama
• Spiritüel görüşler
• Şifa yetenekleri
• Moksha'ya yol açma

KİMLER İÇİN GEREKLİ?
• Ketu Dasha veya Antardasha döneminde olanlar
• Spiritüel arayış içinde olanlar
• Geçmiş yaşam terapisi yapanlar
• Meditasyon derinleştirmek isteyenler
• Maddi bağlardan kurtulmak isteyenler
• Aydınlanma arayanlar
''',
    geometricStructure: '''
YAPISAL ELEMENTLER:

1. MERKEZ BİNDU: Boşluk, ego'nun erimesi

2. BAYRAK/KUYRUK SEMBOLÜ: Ketu'nun klasik gösterimi

3. 7 YAPRAKLI LOTUS: 7 çakra, spiritüel yükseliş

4. İÇ İÇE DAİRELER: Bilinç katmanları

5. DUMAN RENGİ: Belirsizlik, mistisizm
''',
    centerBindu:
        'Merkezdeki nokta, "Shunya" (boşluk) ve "Moksha" (kurtuluş) bilincini temsil eder. Burası egonun eridiği yerdir.',
    trianglesMeaning:
        'Aşağı bakan üçgenler, içe dönüşü, derinleşmeyi ve spiritüel inişi simgeler.',
    circlesMeaning:
        'Daireler, reenkarnasyon döngüsünü ve bundan kurtuluşu temsil eder.',
    lotusGates:
        '7 yapraklı lotus, 7 çakranın aşılmasını ve kundalini yolculuğunu temsil eder.',
    outerSquare:
        'Bhupura, maddi dünyanın terk edilmesini ve spiritüel sınırların aşılmasını temsil eder.',
    activationRitual: '''
KETU YANTRA AKTİVASYON RİTÜELİ:

HAZIRLIK:
• Salı veya Perşembe gün doğumunda
• Karma metal veya bakır yantra
• Çok renkli çiçekler veya kurutulmuş çiçekler
• Ghee lambası
• Kamfora (kafur) tütsüsü

RİTÜEL ADIMLARI:

1. SHODHANA (Arındırma):
Yantra'yı Ganga suyu veya kutsal su ile yıkayın. "Om Ketave Namaha" diyerek 7 kez üzerine su serpin.

2. PRANA PRATISHTHA (Can verme):
Her iki elinizi yantra üzerine koyun. "Om Sraam Sreem Sraum Sah Ketave Namaha" mantrasını 108 kez okuyun.

3. PUSHPANJALI (Çiçek sunumu):
Çok renkli veya kurutulmuş çiçekleri yantra'nın üzerine rastgele yerleştirin.

4. DEEPA (Lamba):
Ghee lambasını yantra'nın merkezine yakın tutun, sonra kuzeydoğuya yerleştirin.

5. DHYANA (Meditasyon):
27 dakika yantra'ya odaklanarak moksha niyeti tutun.
''',
    mantra: 'OM SRAAM SREEM SRAUM SAH KETAVE NAMAHA',
    mantraCount: 7000,
    bestDay: 'Salı veya Perşembe',
    bestTime: 'Brahma Muhurta (şafaktan önce)',
    colorScheme: 'Duman rengi, gri, çok renkli',
    metalRecommended: 'Karma metal veya bakır',
    benefits: [
      'Ketu Dasha etkilerinin hafiflemesi',
      'Spiritüel uyanış ve aydınlanma',
      'Geçmiş yaşam hatırlama',
      'Meditasyon derinleşmesi',
      'Maddi bağlardan özgürleşme',
      'Sezgi ve psişik yetenekler',
      'Moksha yolunda ilerleme',
      'Şifa yeteneklerinin açılması',
      'Ani spiritüel kavrayışlar',
      'Karma temizliği',
    ],
    healingAspects: [
      'Açıklanamayan hastalıklar',
      'Ruhsal problemler',
      'Geçmiş yaşam travmaları',
      'Bağışıklık sistemi',
      'Sinir sistemi',
      'Psikosomatik bozukluklar',
    ],
    meditationGuide: '''
KETU YANTRA MEDİTASYONU:

ZAMAN: Brahma Muhurta (şafaktan önce)

POZİSYON: Kuzeydoğuya bakarak oturun

UYGULAMA:
1. 5 dakika derin nefes, her nefeşte bırakarak
2. Yantra'yı üçüncü göz hizasına yerleştirin
3. Merkez boşluğa odaklanın
4. "Om Ketave Namaha" mantrasını 108 kez sessizce tekrarlayın
5. Gözlerinizi kapatın, sonsuz boşluğa dalın
6. Ego'nuzun eridiğini, sınırların kalktığını hissedin
7. Sessizlikte 30 dakika kalın, düşünce olmadan var olun
''',
    weeklyPractice: '''
HAFTALIK KETU SADHANA:

SALI: Ana ibadet günü - 108 mantra + yantra meditasyonu
ÇARŞAMBA: Geçmiş yaşam meditasyonu
PERŞEMBE: İkinci ibadet günü, spiritüel kitap okuma
CUMA: Muhtaçlara yiyecek ve giysi bağışı
CUMARTESİ: Sessiz inziva, konuşma orucu
PAZAR: Yoga ve nefes çalışmaları
PAZARTESİ: Doğa yürüyüşü, topraklanma
''',
    warnings: '''
UYARILAR:
• Depresyon veya derealizasyon yaşayanlarda dikkatli olun
• Sosyal izolasyona dikkat edin
• Maddi sorumlulukları ihmal etmeyin
• Deneyimli bir guru rehberliği önerilir
• Pratik hayatla dengeyi koruyun
''',
    viralQuote:
        '"Bırakmayı öğrendiğinde, tutmak istediğin her şeyin sana geldiğini göreceksin." ☸️',
  ),
};

// ═══════════════════════════════════════════════════════════════════════════
// 3. ÇAKRA YANTRALARI (CHAKRA YANTRAS)
// ═══════════════════════════════════════════════════════════════════════════

final Map<String, ChakraYantraContent> chakraYantras = {
  // ─────────────────────────────────────────────────────────────────────────
  // MULADHARA ÇAKRA (KÖK)
  // ─────────────────────────────────────────────────────────────────────────
  'muladhara': const ChakraYantraContent(
    id: 'muladhara',
    chakraName: 'Kök Çakra',
    chakraNameSanskrit: 'मूलाधार - Muladhara',
    location: 'Omurga tabanı, perine bölgesi',
    element: 'Toprak (Prithvi)',
    symbol: '◼',
    petalCount: 4,
    petalMeaning:
        '4 yaprak, 4 ana yönü ve 4 temel insan ihtiyacını (yiyecek, uyku, korku, üreme) temsil eder. Her yaprak bir Sanskrit harfi taşır: वं (Vam), शं (Sham), षं (Ṣam), सं (Sam).',
    centralSymbol:
        'Merkezdeki sarı kare, toprak elementini temsil eder. İçinde aşağı bakan kırmızı üçgen bulunur - Shakti yoni, yaratıcı dişil enerji.',
    geometricShape: 'Kare (4 köşeli) + 4 yapraklı lotus',
    seedMantra: 'LAM (लं)',
    deity: 'Ganesha, Brahma',
    shakti: 'Dakini Shakti',
    color: 'Kırmızı',
    colorHex: '#FF0000',
    shortDescription:
        'Hayatta kalma, güvenlik ve topraklanma çakrası. Fiziksel varoluşun ve maddi dünyanın temeli.',
    deepMeaning: '''
MULADHARA - VAROLUŞUN TEMELİ

Muladhara, Sanskrit'te "Mula" (kök) ve "Adhara" (destek/temel) kelimelerinden oluşur. Bu çakra, spiritüel yolculuğun başladığı yerdir - tüm yapının üzerine kurulduğu temel.

TOPRAK ENERJİSİ:
Muladhara, toprak elementi ile ilişkilidir. Nasıl bir ağaç kökleri olmadan ayakta duramazsa, insan da Muladhara'sız spiritüel yükseliş yapamaz. Bu çakra:
• Fiziksel bedeni destekler
• Maddi dünyada güvenlik sağlar
• Hayatta kalma içgüdülerini yönetir
• Atalarla bağlantı kurar

KUNDALİNİ'NİN YUVASI:
Kundalini Shakti, bu çakrada üç buçuk kez sarılmış yılan olarak uyur. "Mula" aynı zamanda "başlangıç" anlamına gelir - tüm enerjinin kaynağı burasıdır.

4 YAPRAK SİMGELEMİ:
• 4 Veda
• 4 yön (kuzey, güney, doğu, batı)
• 4 yaşam amacı (dharma, artha, kama, moksha)
• 4 element (toprak, su, ateş, hava)

GANESHA BAĞLANTISI:
Ganesha, bu çakranın koruyucu tanrısıdır. Fil başlı tanrı, engelleri kaldırır ve spiritüel yolculuğun güvenle başlamasını sağlar.
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Kronik yorgunluk
• Bel ve bacak ağrıları
• Sindirim sorunları (kabızlık)
• Bağışıklık zayıflığı
• Ayak problemleri
• Kemik ve diş sorunları

DUYGUSAL BLOKAJ BELİRTİLERİ:
• Kronik korku ve kaygı
• Güvensizlik hissi
• Maddi takıntılar veya yoksunluk korkusu
• Kök ailesi ile problemler
• Yerleşememe, sürekli hareket ihtiyacı
• Depresyon ve kaybolmuşluk hissi

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Topraklanma güçlüğü
• Meditasyonda odaklanamama
• "Havada uçma" hissi
• Bedenle bağlantı kopukluğu
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Derin güvenlik ve huzur hissi
• Fiziksel enerji artışı
• Bedenle barışık olma
• Maddi bolluk akışı
• Aile kökleriyle barış
• Doğa ile derin bağlantı
• Ayakların "kök saldığı" hissi
• Yaşam gücünün artması
''',
    meditationPractice: '''
MULADHARA MEDİTASYONU:

HAZIRLIK:
- Yere veya mindere oturun
- Mümkünse toprakla temas halinde olun
- Kırmızı mum veya kırmızı kristal kullanabilirsiniz

UYGULAMA (21 dakika):

1. TOPRAKLANMA (5 dk):
Oturduğunuz yerde kökler hayal edin. Bu kökler topraktan aşağı, dünyanın çekirdeğine kadar uzanıyor.

2. NEFES (5 dk):
Burnunuzdan nefes alın, topraktan kırmızı enerji çekin. Ağızdan verin, toksik enerjiyi bırakın.

3. MANTRA (7 dk):
"LAM" mantrasını karın bölgesinde titreştirecek şekilde söyleyin. 108 kez tekrarlayın.

4. VİZÜALİZASYON (4 dk):
Perine bölgesinde dönen kırmızı bir enerji çarkı görün. Her nefeste daha parlak ve güçlü dönüyor.

MUDRA:
Gyan Mudra (işaret parmağı ve başparmak birleşik) veya Prithvi Mudra (yüzük parmağı ve başparmak birleşik)
''',
    yantraVisualization: '''
MULADHARA YANTRA VİZÜALİZASYONU:

1. Dört yapraklı koyu kırmızı lotus hayal edin
2. Her yaprakta altın Sanskrit harfler parıldıyor: वं शं षं सं
3. Merkezdeki sarı kare, toprak elementini temsil ediyor
4. Karenin içinde kırmızı aşağı bakan üçgen - Shakti yoni
5. Üçgenin merkezinde altın "LAM" harfi titreşiyor
6. Üçgenin içinde sarılmış kundalini yılanı uyuyor
7. Ganesha'nın korumasını hissedin
''',
    breathingTechnique: '''
MULADHARA PRANAYAMA:

1. MULABİNDU NEFES:
- Perine kaslarını hafifçe sıkın (Mula Bandha)
- Nefes alırken enerjiyi kökten yukarı çekin
- Nefes verirken enerjiyi köke geri gönderin
- 10 döngü

2. PRİTHVİ PRANAYAMA:
- 4 saniye nefes alın
- 4 saniye tutun
- 4 saniye verin
- 4 saniye bekleyin
- "4" sayısı toprak elementi ile uyumludur
''',
    mudra: 'Prithvi Mudra - Yüzük parmağı ve başparmak uçları birleşik',
    affirmation:
        '"Ben güvendeyim. Evren beni destekliyor. Köklerim güçlü, varlığım sağlam."',
    associatedOrgans: [
      'Adrenal bezler',
      'Böbrekler',
      'Omurga tabanı',
      'Bacaklar',
      'Ayaklar',
      'Kemikler',
      'Kalın bağırsak',
      'Dişler',
    ],
    emotionalAspects: [
      'Güvenlik hissi',
      'Topraklanma',
      'Hayatta kalma içgüdüsü',
      'Maddi güvence',
      'Aile bağları',
      'Kabile bilinci',
    ],
    spiritualGifts: [
      'Kundalini uyanışı potansiyeli',
      'Fiziksel güç ve dayanıklılık',
      'Toprak ile iletişim',
      'Atalarla bağlantı',
      'Manifestasyon gücü',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Kundalini Shakti, Muladhara'da uyuyan dişi yılan enerjisidir. "Kunda" (sarmal) ve "lini" (dişil enerji) anlamına gelir.

Bu enerji uyandığında:
1. Muladhara'dan yükselmeye başlar
2. Sushumna nadi boyunca yukarı çıkar
3. Her çakrayı aktive ederek yükselir
4. Sahasrara'da Shiva ile birleşir

UYARI: Kundalini uyanışı güçlü bir deneyimdir. Hazırlıksız uyanış fiziksel ve psikolojik sorunlara yol açabilir. Deneyimli bir öğretmen rehberliği önerilir.
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra'da Muladhara, "maddi dünyayı reddetmek yerine kucaklama" felsefesinin başlangıç noktasıdır. Beden kutsal bir tapınaktır ve bu tapınağın temeli Muladhara'dır.

DAKİNİ SHAKTİ:
Bu çakranın Shakti'si Dakini'dir. O, kırmızı gözlü, dört kollu tanrıçadır. Ellerinde:
• Kılıç (cehaleti kesmek)
• Kalkan (koruma)
• Kafatası kadeh (ego'nun ölümü)
• Kitap (bilgelik)

Dakini, en temel korkularımızla yüzleşmemizi sağlar.
''',
    viralQuote: '"Gökyüzüne uzanmak istiyorsan, önce köklerini derine sal." 🌳',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // SVADHİSTHANA ÇAKRA (SAKRAL)
  // ─────────────────────────────────────────────────────────────────────────
  'svadhisthana': const ChakraYantraContent(
    id: 'svadhisthana',
    chakraName: 'Sakral Çakra',
    chakraNameSanskrit: 'स्वाधिष्ठान - Svadhisthana',
    location: 'Göbek altı, sakrum bölgesi',
    element: 'Su (Apas)',
    symbol: '🌙',
    petalCount: 6,
    petalMeaning:
        '6 yaprak, 6 olumsuz niteliği (düşmanlık, zalimlik, nefret, kıskançlık, arzu, gurur) dönüştürmeyi temsil eder. Sanskrit harfler: बं भं मं यं रं लं.',
    centralSymbol:
        'Merkezdeki beyaz hilal, su elementini temsil eder. Ay enerjisi ve duygusal akışkanlık.',
    geometricShape: 'Hilal (ay) + 6 yapraklı lotus',
    seedMantra: 'VAM (वं)',
    deity: 'Vishnu, Brahma',
    shakti: 'Rakini Shakti',
    color: 'Turuncu',
    colorHex: '#FF7F00',
    shortDescription:
        'Yaratıcılık, cinsellik ve duygusal akış çakrası. Hazzın, ilişkilerin ve suyun enerjisi.',
    deepMeaning: '''
SVADHİSTHANA - VARLIĞIN TATLILIĞI

Svadhisthana, Sanskrit'te "Sva" (kendi) ve "Adhisthana" (ikametgah) anlamına gelir - "Benliğin Evi". Bu çakra, duygusal kimliğimizin ve yaratıcı gücümüzün merkezidir.

SU ENERJİSİ:
Su, şekil değiştiren, adapte olan, akan ve arındıran bir elementtir. Svadhisthana:
• Duygusal akışkanlığı sağlar
• Yaratıcı enerjiyi harekete geçirir
• Cinsel enerjiyi yönetir
• İlişkilerde bağlanmayı oluşturur

DUYGUSAL OKYANUS:
Bu çakra, duygusal deneyimlerimizin okyanusudur. Tıpkı ay'ın gel-git'i etkilediği gibi, Svadhisthana da duygusal dalgalanmalarımızı kontrol eder.

6 YAPRAK SİMGELEMİ:
6 yaprak, 6 "ripu" (iç düşman) ve bunların dönüşümünü temsil eder:
1. Kama (şehvet) → Kutsal arzu
2. Krodha (öfke) → Sağlıklı sınırlar
3. Lobha (açgözlülük) → Bolluk bilinci
4. Moha (yanılsama) → Netlik
5. Mada (kibir) → Özgüven
6. Matsarya (kıskançlık) → Takdir

VİSHNU BAĞLANTISI:
Vishnu, koruyucu tanrı, bu çakranın yöneticisidir. O, kozmik okyanusu üzerinde yılan yatağında uzanır - yaratılışı besler ve korur.
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Üreme sistemi sorunları
• Böbrek ve mesane problemleri
• Bel ağrısı (alt sırt)
• Menstrual düzensizlikler
• Cinsel işlev bozuklukları
• Sıvı dengesizliği

DUYGUSAL BLOKAJ BELİRTİLERİ:
• Duygusal donukluk veya aşırı duygusallık
• Bağımlılık eğilimleri
• Suçluluk ve utanç
• Yakınlık korkusu
• Yaratıcı blokaj
• Zevk alamama (anhedoni)
• İlişki sorunları

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Cinsel enerjiyi spiritüel enerjiye dönüştürememe
• Duygusal zeka eksikliği
• Akışa teslim olamama
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Yaratıcılık patlaması
• Sağlıklı cinsel ifade
• Duygusal denge
• İlişkilerde derinlik
• Hayattan zevk alma
• Sanatsal ilham
• Sezgisel akış
• Dans ve hareket isteği
''',
    meditationPractice: '''
SVADHİSTHANA MEDİTASYONU:

HAZIRLIK:
- Su kenarında veya banyo sonrası idealdir
- Turuncu mum, turuncu kristal (karneol)
- Yumuşak, akışkan müzik

UYGULAMA (24 dakika):

1. SU VİZÜALİZASYONU (6 dk):
Kendinizi sıcak, turuncu bir okyanusta yüzüyormuş gibi hayal edin. Suyun sizi taşıdığını hissedin.

2. KALÇA AÇMA (6 dk):
Oturarak kalçaları dairesel hareketlerle gevşetin. Enerjinin bu bölgede aktığını hissedin.

3. MANTRA (8 dk):
"VAM" mantrasını göbek altında hissederek söyleyin. Sesin su gibi aktığını hayal edin.

4. HİLAL VİZÜALİZASYONU (4 dk):
Sakral bölgede parlayan turuncu bir hilal görün. Ay ışığı gibi sakin ve serin.

MUDRA:
Varuna Mudra - Küçük parmak ve başparmak uçları birleşik
''',
    yantraVisualization: '''
SVADHİSTHANA YANTRA VİZÜALİZASYONU:

1. Altı yapraklı turuncu lotus hayal edin
2. Her yaprakta kızıl Sanskrit harfler parıldıyor
3. Merkezdeki beyaz hilal, ay enerjisini taşıyor
4. Hilalin içinde dalgalanan turkuaz su
5. Suyun içinde timsah (makara) - tutku ve arzunun sembolü
6. "VAM" harfi merkezdeki altın lotus üzerinde titreşiyor
7. Vishnu'nun koruyucu enerjisini hissedin
''',
    breathingTechnique: '''
SVADHİSTHANA PRANAYAMA:

1. CHANDRA BHEDANA (Ay Nefesi):
- Sol burun deliğinden nefes alın
- Sağ burun deliğinden verin
- Su elementi ile bağlantı kurar
- Sakinleştirici, soğutucu
- 6 döngü

2. SITALI (Serinletici Nefes):
- Dili rulo yapın
- Dilden nefes alın (serinlik hissi)
- Burundan verin
- 6 döngü
''',
    mudra: 'Varuna Mudra - Küçük parmak ve başparmak uçları birleşik',
    affirmation:
        '"Yaratıcılığım özgürce akıyor. Duygularımı onurlandırıyorum. Hayattan zevk almak benim doğal hakkım."',
    associatedOrgans: [
      'Üreme organları',
      'Böbrekler',
      'Mesane',
      'Lenf sistemi',
      'Kalçalar',
      'Alt sırt',
      'Vücut sıvıları',
    ],
    emotionalAspects: [
      'Duygusal akış',
      'Yaratıcılık',
      'Cinsellik',
      'Haz ve zevk',
      'İlişkiler',
      'Tutku',
      'Hareketlilik',
    ],
    spiritualGifts: [
      'Yaratıcı vizyon',
      'Duygusal zeka',
      'Cinsel enerji transmutasyonu',
      'Empati',
      'Sanatsal ifade',
      'Akış durumu',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Kundalini Muladhara'dan yükseldiğinde, ilk durak Svadhisthana'dır. Burada enerji:
• Duygusal blokajlarla karşılaşır
• Cinsel enerji ile birleşir
• Arzu ve tutku ile yüzleşir

TANTRİK DÖNÜŞÜM:
Tantra, cinsel enerjiyi baskılamak yerine dönüştürmeyi öğretir. Svadhisthana'da bu enerji:
• Ojas'a (yaşam özü) dönüşür
• Yukarı doğru yükselir
• Spiritüel güce transmute olur
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra, Svadhisthana'yı "kutsal seksüalite" kapısı olarak görür. Cinsel enerji (Kama) doğru yönlendirildiğinde en güçlü spiritüel yakıt haline gelir.

RAKİNİ SHAKTİ:
Bu çakranın Shakti'si Rakini'dir. O, iki başlı, mavi tenli tanrıçadır. Ellerinde:
• Ok (odaklanmış arzu)
• Lotus (saflık)
• Davul (yaratıcı ritim)
• Balta (bağları kesme)

MAİTHUNA:
Tantrik birleşme (maithuna), sadece fiziksel değil, iki ruhun birliğidir. Svadhisthana aktive olduğunda:
• Partner ile enerji alışverişi derinleşir
• Orgazm spiritüel deneyime dönüşür
• Yaratıcı enerji manifestasyona akar
''',
    viralQuote:
        '"Duygular nehir gibidir. Onları tutmaya çalışırsan taşar, akmasına izin verirsen bereketli topraklar yaratır." 🌊',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // MANİPURA ÇAKRA (SOLAR PLEXUS)
  // ─────────────────────────────────────────────────────────────────────────
  'manipura': const ChakraYantraContent(
    id: 'manipura',
    chakraName: 'Solar Plexus Çakra',
    chakraNameSanskrit: 'मणिपूर - Manipura',
    location: 'Göbek ve mide bölgesi, güneş sinir ağı',
    element: 'Ateş (Agni)',
    symbol: '▽',
    petalCount: 10,
    petalMeaning:
        '10 yaprak, 10 Prana Vayu\'yu (hayati hava) temsil eder. Ayrıca 10 temel duyguyu yönetir. Sanskrit harfler: डं ढं णं तं थं दं धं नं पं फं.',
    centralSymbol:
        'Merkezdeki kırmızı aşağı bakan üçgen, ateş elementini temsil eder. Koç (ram) - içsel gücün ve iradenin sembolü.',
    geometricShape: 'Aşağı bakan üçgen + 10 yapraklı lotus',
    seedMantra: 'RAM (रं)',
    deity: 'Rudra (Shiva formu), Agni',
    shakti: 'Lakini Shakti',
    color: 'Sarı',
    colorHex: '#FFFF00',
    shortDescription:
        'Kişisel güç, irade ve dönüşüm çakrası. İç ateşin ve özgüvenin merkezi.',
    deepMeaning: '''
MANİPURA - MÜCEVHERLERİN ŞEHRİ

Manipura, Sanskrit'te "Mani" (mücevher) ve "Pura" (şehir) anlamına gelir - "Mücevherler Şehri". Bu çakra, içsel gücün, iradenin ve kişisel kimliğin parlak merkezi.

ATEŞ ENERJİSİ:
Ateş, dönüştüren, arındıran ve ısıtan elementtir. Manipura:
• Yiyeceği enerjiye dönüştürür (sindirim ateşi)
• Deneyimleri bilgeliğe dönüştürür
• Korkuyu cesarete dönüştürür
• İradeyi eyleme dönüştürür

İÇSEL GÜNEŞ:
Manipura, bedenin "iç güneşi"dir. Nasıl güneş gezegenleri aydınlatıp ısıtıyorsa, Manipura da iç dünyamızı aydınlatır ve enerji verir.

10 YAPRAK SİMGELEMİ:
10 yaprak, 10 Prana Vayu'yu temsil eder:
• Prana (içeri akan)
• Apana (dışarı akan)
• Samana (dengeleyen)
• Udana (yükselen)
• Vyana (yayan)
• + 5 Upa-prana (yardımcı hayati havalar)

AGNİ BAĞLANTISI:
Agni, ateş tanrısı, bu çakranın koruyucusudur. O, tüm sunuları tanrılara taşıyan aracı - dünyevi olanı ilahi olana dönüştüren güç.
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Sindirim sorunları (gastrit, ülser)
• Karaciğer ve safra kesesi problemleri
• Pankreas ve şeker metabolizması bozuklukları
• Orta bel yağlanması
• Enerji düşüklüğü
• Mide bulantısı

DUYGUSAL BLOKAJ BELİRTİLERİ:
• Düşük özgüven
• Karar verememe
• Kontrol takıntısı veya kontrolü tamamen bırakma
• Öfke patlamaları veya öfkeyi bastırma
• Mağduriyet hissi
• Güç oyunları
• Eleştiriye aşırı hassasiyet

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Kişisel gücü kullanamama
• Manifestasyon güçlüğü
• İç ateşin sönmesi
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Güçlü özgüven ve kararlılık
• Sağlıklı sindirim ve metabolizma
• Yüksek enerji seviyeleri
• Net karar verme yeteneği
• Liderlik kapasitesi
• Başarıyı çekme gücü
• Sağlıklı sınırlar koyabilme
• Korku üzerinde hakimiyet
''',
    meditationPractice: '''
MANİPURA MEDİTASYONU:

HAZIRLIK:
- Güneş ışığında veya ateş karşısında idealdir
- Sarı mum, sitrin veya kaplan gözü kristali
- Dinamik, güçlendirici müzik

UYGULAMA (30 dakika):

1. ATEŞ NEFES (8 dk):
Kapaluru (ateş nefesi) veya Bhastrika yapın. Karın bölgesinde ısı hissedin.

2. KARNI HAREKETLER (7 dk):
Nauli veya Agnisar Kriya - karın kaslarını çalıştırın. İç ateşi uyandırın.

3. MANTRA (10 dk):
"RAM" mantrasını güçlü ve kararlı bir şekilde söyleyin. Sesin göbek bölgesinde titreştiğini hissedin.

4. GÜNEŞ VİZÜALİZASYONU (5 dk):
Göbek bölgesinde parlayan sarı-altın bir güneş görün. Işınları tüm bedene yayılıyor.

MUDRA:
Rudra Mudra - Yüzük, işaret ve başparmak uçları birleşik
''',
    yantraVisualization: '''
MANİPURA YANTRA VİZÜALİZASYONU:

1. On yapraklı parlak sarı lotus hayal edin
2. Her yaprakta mavi Sanskrit harfler titreşiyor
3. Merkezdeki kırmızı aşağı bakan üçgen ateş gibi parlıyor
4. Üçgenin içinde beyaz bir koç (ram) duruyor
5. Koçun üzerinde "RAM" harfi altın renkte yazılı
6. Üçgenden alevler yükseliyor
7. Rudra'nın (Shiva) güçlendirici enerjisini hissedin
''',
    breathingTechnique: '''
MANİPURA PRANAYAMA:

1. KAPALABHATI (Ateş Nefesi):
- Hızlı ve güçlü nefes verişler (karın içeri)
- Nefes alış pasif
- 30-60 tekrar, 3 tur
- Karın bölgesinde ısı oluşturur

2. SURYA BHEDANA (Güneş Nefesi):
- Sağ burun deliğinden nefes alın
- Sol burun deliğinden verin
- Ateş elementi ile bağlantı kurar
- Isıtıcı, enerji verici
- 10 döngü

3. AGNİSAR KRİYA:
- Derin nefes alın, tamamen verin
- Nefesi tutarak karnı içeri-dışarı pompalayın
- Sindirim ateşini uyandırır
''',
    mudra: 'Rudra Mudra - Yüzük, işaret ve başparmak uçları birleşik',
    affirmation:
        '"Gücüm içimde. Kararlarıma güveniyorum. İradem güçlü, eylemlerim kararlı."',
    associatedOrgans: [
      'Mide',
      'Karaciğer',
      'Safra kesesi',
      'Pankreas',
      'Dalak',
      'İnce bağırsak',
      'Adrenal bezler (üst)',
      'Sindirim sistemi',
    ],
    emotionalAspects: [
      'Özgüven',
      'Kişisel güç',
      'İrade',
      'Motivasyon',
      'Kontrol',
      'Öz-değer',
      'Karar verme',
    ],
    spiritualGifts: [
      'Manifestasyon gücü',
      'Liderlik',
      'Korkusuzluk',
      'Dönüşüm yeteneği',
      'Enerji yönetimi',
      'Şifa gücü',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Manipura, kundalini yolculuğunda kritik bir geçiş noktasıdır. Burada enerji:
• Alt çakraların (hayatta kalma, duygular) ötesine geçer
• Kişisel iradeyle birleşir
• Dönüşüm ateşinden geçer

DÖNÜŞÜM NOKTASI:
Manipura, "dünyevi" enerjilerin "spiritüel" enerjilere dönüştüğü yerdir. Sindirim ateşi (Jatharagni) sadece yiyeceği değil, karma'yı da yakar.

AGNİ VE KUNDALİNİ:
Kundalini yükselirken, Manipura'nın ateşi onu daha da güçlendirir. Bu birleşme:
• Eski kalıpları yakar
• Ego'yu arındırır
• İradeyi spiritüel amaca yönlendirir
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra'da Manipura, "iç simya"nın gerçekleştiği yerdir. Ateş elementi:
• Kaba olanı inceltir
• Karanlığı aydınlatır
• Korkaklığı cesarete dönüştürür

LAKİNİ SHAKTİ:
Bu çakranın Shakti'si Lakini'dir. O, üç yüzlü, dört kollu tanrıçadır. Ellerinde:
• Vajra (yıldırım - güç)
• Şakti mızrağı (yönlendirme)
• Ateş (dönüşüm)
• Koruma hareketi (abhaya mudra)

TAPAS:
Tantrik pratik olarak "tapas" (spiritüel ateş/disiplin) Manipura ile doğrudan ilişkilidir. Disiplin ateşi:
• Karmaları yakar
• İradeyi güçlendirir
• Spiritüel ısı üretir
''',
    viralQuote:
        '"İçindeki ateşi söndürme - onu kontrol et. O senin en büyük dönüşüm gücün." 🔥',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // ANAHATA ÇAKRA (KALP)
  // ─────────────────────────────────────────────────────────────────────────
  'anahata': const ChakraYantraContent(
    id: 'anahata',
    chakraName: 'Kalp Çakra',
    chakraNameSanskrit: 'अनाहत - Anahata',
    location: 'Göğüs merkezi, kalp bölgesi',
    element: 'Hava (Vayu)',
    symbol: '✡',
    petalCount: 12,
    petalMeaning:
        '12 yaprak, 12 ilahi niteliği temsil eder: neşe, huzur, sevgi, uyum, berraklık, şefkat, saflık, birlik, anlayış, af, sabır, mutluluk. Sanskrit harfler: कं खं गं घं ङं चं छं जं झं ञं टं ठं.',
    centralSymbol:
        'Merkezdeki altı köşeli yıldız (hexagram), Shiva (yukarı üçgen) ve Shakti\'nin (aşağı üçgen) birleşimini temsil eder. İki üçgenin birleşimi - eril ve dişil dengenin simgesi.',
    geometricShape: 'Hexagram (6 köşeli yıldız) + 12 yapraklı lotus',
    seedMantra: 'YAM (यं)',
    deity: 'Ishana (Shiva formu), Vayu',
    shakti: 'Kakini Shakti',
    color: 'Yeşil (veya pembe)',
    colorHex: '#00FF00',
    shortDescription:
        'Koşulsuz sevgi, şefkat ve birlik çakrası. Ruhun evi ve evrensel aşkın kapısı.',
    deepMeaning: '''
ANAHATA - VURULMAYAN SESİN MERKEZİ

Anahata, Sanskrit'te "çarpışma olmadan üretilen ses" anlamına gelir - "vurulmayan ses". Bu, fiziksel dünyanın ötesindeki ilahi sesin, "Anahata Nada"nın çaldığı yerdir.

HAVA ENERJİSİ:
Hava, görünmeyen ama her yerde olan, serbest hareket eden elementtir. Anahata:
• Koşulsuz sevgiyi yayar
• Şefkati besler
• Alt ve üst çakraları birbirine bağlar
• Nefes ile bilinçi birleştirir

MERKEZ NOKTA:
Anahata, 7 çakra sisteminin tam ortasındadır - 3 alt (maddi) ve 3 üst (spiritüel) çakra arasındaki köprü. Burası, dünyevi ve ilahi olanın buluştuğu kutsal mekandır.

12 YAPRAK SİMGELEMİ:
12 yaprak, 12 ilahi kalp niteliğini temsil eder:
1. Ananda (neşe)
2. Shanti (huzur)
3. Prema (sevgi)
4. Samata (eşitlik)
5. Vairagyam (bağımsızlık)
6. Shraddha (inanç)
7. Maitri (dostluk)
8. Karuna (şefkat)
9. Mudita (sevinç)
10. Upeksha (eşit bakış)
11. Kshama (af)
12. Dhairya (sabır)

HEXAGRAM'IN SIRRI:
Altı köşeli yıldız, iki üçgenin birleşimidir:
• Yukarı bakan üçgen: Shiva, bilinç, eril, ateş
• Aşağı bakan üçgen: Shakti, enerji, dişil, su
Birleşimleri, polaritelerin dengesini ve evrensel aşkı yaratır.
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Kalp hastalıkları
• Solunum problemleri (astım, bronşit)
• Göğüs ağrıları
• Bağışıklık sistemi zayıflığı
• Omuz ve kol ağrıları
• Dolaşım bozuklukları

DUYGUSAL BLOKAJ BELİRTİLERİ:
• Yakınlık korkusu
• Kıskançlık ve sahiplenme
• Affetme güçlüğü
• Yalnızlık hissi (kalabalıklarda bile)
• Bağlanma sorunları
• Aşırı bağımlılık veya duygusal mesafe
• Öz-sevgi eksikliği
• Kalp kırıklığından koruma

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Koşulsuz sevgiyi deneyimleyememe
• Birlik bilincine ulaşamama
• Spiritüel kurukluk
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Derin, koşulsuz sevgi kapasitesi
• Şefkat ve empati artışı
• Affetme kolaylığı
• Her şeyde güzellik görme
• Kalp açıklığı (fiziksel olarak bile)
• Derin bağlantılar kurabilme
• Öz-sevgi ve öz-kabul
• Evrensel birlik deneyimi
• "Kalpten görme" yeteneği
''',
    meditationPractice: '''
ANAHATA MEDİTASYONU:

HAZIRLIK:
- Sessiz, huzurlu bir ortam
- Yeşil veya pembe mum, gül kuvars kristali
- Sakinleştirici, kalpten gelen müzik

UYGULAMA (36 dakika):

1. KALP NEFES (8 dk):
Nefesi kalpten alıp verin. Her nefeste göğsün genişlediğini hissedin.

2. METTA MEDİTASYONU (10 dk):
Kendinize, sevdiklerinize, nötr kişilere, zor kişilere ve tüm varlıklara sevgi gönderin.

3. MANTRA (12 dk):
"YAM" mantrasını kalp bölgesinde titreştirecek şekilde söyleyin. Sesin kalbinizde açılan bir çiçek gibi hissedilmesine izin verin.

4. HEXAGRAM VİZÜALİZASYONU (6 dk):
Kalbinizde dönen yeşil-altın bir hexagram görün. İki üçgenin mükemmel dengede döndüğünü izleyin.

MUDRA:
Hridaya Mudra - İşaret parmağı başparmak kökünde, orta ve yüzük parmaklar başparmak ucuyla birleşik
''',
    yantraVisualization: '''
ANAHATA YANTRA VİZÜALİZASYONU:

1. On iki yapraklı yeşil lotus hayal edin
2. Her yaprakta kırmızı Sanskrit harfler parıldıyor
3. Merkezdeki hexagram (6 köşeli yıldız) altın renkte
4. Yukarı bakan üçgen: parlak beyaz (Shiva)
5. Aşağı bakan üçgen: koyu kırmızı (Shakti)
6. Merkezde siyah antilop (hız, özgürlük)
7. Antilopun üzerinde "YAM" harfi duman renginde
8. Tüm yapı yeşil ışık saçıyor
9. Ishana Shiva'nın korumasını hissedin
''',
    breathingTechnique: '''
ANAHATA PRANAYAMA:

1. ANAHATA NEFES:
- Göğsün tam ortasına odaklanın
- Nefes alırken kalp genişliyor
- Nefes verirken sevgi yayılıyor
- 12 döngü

2. PRANAVA NEFES:
- Nefes alırken "SO" düşünün
- Nefes verirken "HAM" düşünün
- "So-Ham" = "Ben O'yum"
- Kalbin ritminde

3. SAMA VRİTTİ (Eşit Oran):
- Nefes alış = Nefes veriş
- Her biri 4-6 saniye
- Kalp atışını dengeler
''',
    mudra:
        'Hridaya Mudra - İşaret parmağı başparmak kökünde, orta ve yüzük parmaklar başparmak ucuyla birleşik',
    affirmation:
        '"Ben sevgiyim. Kalbim sınırsızca açık. Veririm ve alırım - ikisi de eşit değerli."',
    associatedOrgans: [
      'Kalp',
      'Akciğerler',
      'Timus bezi',
      'Kollar ve eller',
      'Omuzlar',
      'Kan dolaşımı',
      'Bağışıklık sistemi',
    ],
    emotionalAspects: [
      'Koşulsuz sevgi',
      'Şefkat',
      'Empati',
      'Af',
      'Kabul',
      'Birlik hissi',
      'Güven',
      'Bağlanma',
    ],
    spiritualGifts: [
      'Şifa gücü (özellikle eller)',
      'Empati/telepati',
      'Koşulsuz sevgi deneyimi',
      'Birlik bilinci',
      'Kalpten görme',
      'Anahata Nada işitme',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Anahata, kundalini yolculuğunda önemli bir dönüm noktasıdır. Burada enerji:
• Alt çakraların (maddi) etkisinden kurtulur
• Bireysel sevgiden evrensel sevgiye geçer
• Ego sınırları çözülmeye başlar

HAMSAH:
Anahata'nın hayvanı antilop veya kuğudur (Hamsa). Kuğu, nefesin ritmini temsil eder - "Ham-sah" veya "So-ham" (Ben O'yum).

Kundalini burada:
• Kalp açıklığı gerektirir
• Koşullu sevgiden koşulsuz sevgiye geçiş ister
• Ego bağlarının gevşemesini sağlar
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra'da Anahata, "aşk yoluyla aydınlanma" kapısıdır. Kalp, tüm polaritelerin birleştiği yerdir.

KAKİNİ SHAKTİ:
Bu çakranın Shakti'si Kakini'dir. O, altı yüzlü, dört kollu, sarı giysili tanrıçadır. Ellerinde:
• Kement (kötü eğilimleri bağlar)
• Kafatası (ego'nun ölümü)
• Koruma hareketi (abhaya)
• Bereket hareketi (varada)

HRIDAYA (KALP) TANTRA:
Kalp tantrası, sevginin en yüksek spiritüel yol olduğunu öğretir:
• Partner sevgisi ilahi sevgiye dönüşür
• Şefkat pratiği kalbi açar
• Beden-beden, kalp-kalp, ruh-ruh birleşmesi
''',
    viralQuote:
        '"Kalbin gözleri var - görünmeyeni görür. Kalbin kulakları var - söylenmeyeni duyar." 💚',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // VİSHUDDHA ÇAKRA (BOĞAZ)
  // ─────────────────────────────────────────────────────────────────────────
  'vishuddha': const ChakraYantraContent(
    id: 'vishuddha',
    chakraName: 'Boğaz Çakra',
    chakraNameSanskrit: 'विशुद्ध - Vishuddha',
    location: 'Boğaz, tiroid bölgesi',
    element: 'Eter/Akasha',
    symbol: '○',
    petalCount: 16,
    petalMeaning:
        '16 yaprak, 16 Sanskrit ünlü harfini ve 16 siddhi\'yi (doğaüstü güç) temsil eder. Bu yapraklar ayrıca 16 Kala\'yı (sanat formu) simgeler.',
    centralSymbol:
        'Merkezdeki beyaz daire, eter/akasha elementini temsil eder. İçinde aşağı bakan üçgen - yaratıcı ifadenin kapısı.',
    geometricShape: 'Daire (Akasha sembolü) + 16 yapraklı lotus',
    seedMantra: 'HAM (हं)',
    deity: 'Sadashiva (beş yüzlü Shiva)',
    shakti: 'Shakini',
    color: 'Mavi (açık mavi/turkuaz)',
    colorHex: '#00BFFF',
    shortDescription:
        'İletişim, ifade ve hakikat çakrası. Sesin ve yaratıcı ifadenin kutsal kapısı.',
    deepMeaning: '''
VİSHUDDHA - SAFLİĞİN MERKEZİ

Vishuddha, Sanskrit'te "özellikle saf" anlamına gelir. Bu çakra, tüm toksinlerden - fiziksel, duygusal ve karmik - arınmanın merkezidir.

ETER/AKASHA ENERJİSİ:
Eter, beşinci elementtir - boşluk, uzay, potansiyel. Diğer dört elementin (toprak, su, ateş, hava) içinde hareket ettiği alandır. Vishuddha:
• Sesi taşır ve yayar
• Hakikati ifade eder
• Yaratıcı vizyonu manifestte eder
• Zamansız bilgeliği aktarır

SESİN GÜCÜ:
Tantra'ya göre evren sesle yaratıldı - "Om" veya "Nada". Vishuddha, bu kozmik sesin bireysel ifadesidir. Söylediğimiz her söz, bir yaratım eylemidir.

16 YAPRAK SİMGELEMİ:
16 yaprak, 16 Sanskrit ünlü harfini (svara) taşır:
अ आ इ ई उ ऊ ऋ ॠ ऌ ॡ ए ऐ ओ औ अं अः
Bu ünlüler, tüm seslerin temeli - yaratıcı ifadenin alfabesi.

AKASHA'NIN SIRRI:
Akasha, "Akashik Kayıtlar"ın da bulunduğu yerdir - evrenin hafızası. Vishuddha aktive olduğunda, bu kayıtlara erişim mümkün olabilir.
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Boğaz enfeksiyonları
• Tiroid problemleri
• Ses kısıklığı
• Boyun ağrıları
• Diş ve diş eti sorunları
• Kulak problemleri

DUYGUSAL BLOKAJ BELİRTİLERİ:
• İfade güçlüğü
• Gerçeği söyleme korkusu
• Aşırı konuşma veya suskunluk
• Eleştiri korkusu
• Dinleme güçlüğü
• Yaratıcı blokaj
• Yetersiz hissetme

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Meditasyonda mantra kullanamama
• Spiritüel mesajları alamama
• Gerçek sesi (otantik ifadeyi) bulamama
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Net ve etkili iletişim
• Yaratıcı ifade akışı
• Gerçeği söyleme cesareti
• İyi dinleme becerisi
• Ses ve müzikte yetenek
• Telepati ve açık işitme (clairaudience)
• Düşünce ve söz tutarlılığı
• Zamansız bilgeliğe erişim
''',
    meditationPractice: '''
VİSHUDDHA MEDİTASYONU:

HAZIRLIK:
- Sessiz bir ortam (ses arındırması için)
- Mavi mum, akuamarin veya lapis lazuli kristali
- Mantra veya ses çanakları kullanılabilir

UYGULAMA (32 dakika):

1. SES ARINDIRMASI (6 dk):
"AAA" sesini boğazdan çıkarın. Boğazın titreştiğini hissedin.

2. UJJAYI NEFES (8 dk):
Okyanus sesi yaparak nefes alıp verin. Boğazı hafifçe daraltın.

3. MANTRA (12 dk):
"HAM" mantrasını boğaz bölgesinde titreştirecek şekilde söyleyin. Sesin uzaya yayıldığını hayal edin.

4. DAİRE VİZÜALİZASYONU (6 dk):
Boğazınızda parlayan mavi bir daire görün. İçinden ışık yayılıyor.

MUDRA:
Akasha Mudra - Orta parmak ve başparmak uçları birleşik
''',
    yantraVisualization: '''
VİSHUDDHA YANTRA VİZÜALİZASYONU:

1. On altı yapraklı duman mavisi lotus hayal edin
2. Her yaprakta kırmızı Sanskrit ünlü harfler parıldıyor
3. Merkezdeki gümüşi beyaz daire akasha'yı temsil ediyor
4. Dairenin içinde küçük beyaz aşağı bakan üçgen
5. Üçgenin içinde beyaz fil - güç ve bilgelik
6. Filin üzerinde "HAM" harfi altın renkte
7. Sadashiva'nın beş yüzünü görün - beş element
8. Tüm yapı mavi ışık saçıyor
''',
    breathingTechnique: '''
VİSHUDDHA PRANAYAMA:

1. UJJAYI (Okyanus Nefesi):
- Boğazı hafifçe daraltın
- Nefes alış ve verişte okyanus sesi çıkarın
- Boğaz çakrasını aktive eder
- 16 döngü

2. BRAHMARI (Arı Sesi):
- Nefes alın, verirken "mmmm" sesi çıkarın
- Dudaklar kapalı, sesin titreşimini hissedin
- Boğaz ve kafatasını titreştirir
- 8 döngü

3. SİMHASANA (Aslan Nefesi):
- Ağzı açın, dili dışarı çıkarın
- "HAAA" sesi ile nefes verin
- Boğazı temizler, cesaretlendirir
- 5 döngü
''',
    mudra: 'Akasha Mudra - Orta parmak ve başparmak uçları birleşik',
    affirmation:
        '"Sesim güçlü ve net. Gerçeğimi sevgiyle ifade ederim. Sözlerim yaratır."',
    associatedOrgans: [
      'Tiroid bezi',
      'Paratiroid',
      'Boğaz',
      'Boyun',
      'Ağız',
      'Dişler',
      'Çene',
      'Kulaklar',
      'Ses telleri',
    ],
    emotionalAspects: [
      'İfade',
      'İletişim',
      'Hakikat',
      'Yaratıcılık',
      'Dinleme',
      'Otantiklik',
      'Güvenilirlik',
    ],
    spiritualGifts: [
      'Telepati',
      'Clairaudience (açık işitme)',
      'Mantra gücü',
      'Şifa sesi',
      'Akashik kayıtlara erişim',
      'Channeling (kanal olma)',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Vishuddha, kundalini yolculuğunda "büyük arınma" noktasıdır. Burada enerji:
• Kaba maddeden saf tona dönüşür
• Bireysel ifade evrensel ifadeye açılır
• "Ben" den "Biz"e geçiş başlar

NADA YOGA:
Vishuddha, "Nada Yoga" (ses yogası) ile doğrudan ilişkilidir. Kundalini burada:
• Anahata Nada'yı (vurulmayan sesi) duyar
• Om'un kökenine ulaşır
• Kozmik ses ile rezonansa girer

AMRİT (NEKTAR):
Tantrik öğretilere göre, ay çakrasından (Bindu) damlayan ölümsüzlük nektarı (amrit) Vishuddha'da toplanır. Normal insanlarda bu nektar Manipura ateşinde yanar, ama yogi için şifa ve ölümsüzlük kaynağıdır.
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra'da Vishuddha, "ses yoluyla yaratım" kapısıdır. Mantra'nın gücü buradan kaynaklanır.

SHAKİNİ SHAKTİ:
Bu çakranın Shakti'si Shakini'dir. O, dört yüzlü, dört kollu, beyaz giysili tanrıçadır. Ellerinde:
• Yay ve ok (odaklanmış niyet)
• Kafatası (geçmişin ölümü)
• Kement (arzuların bağlanması)
• Tespih (mantra pratiği)

SES TANTRASI:
Tantrik ses pratiği, Vishuddha ile çalışır:
• Bija mantralar çakraları aktive eder
• Uzun mantralar kozmik güçleri çağırır
• Sessiz mantra (ajapa) en yüksek pratiktir
• "Om" tüm seslerin kaynağı ve sonu
''',
    viralQuote:
        '"Gerçeğini söylemeye cesaret et. Sessizlik bazen en yüksek yalan olabilir." 🔊',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // AJNA ÇAKRA (ÜÇÜNCÜ GÖZ)
  // ─────────────────────────────────────────────────────────────────────────
  'ajna': const ChakraYantraContent(
    id: 'ajna',
    chakraName: 'Üçüncü Göz Çakra',
    chakraNameSanskrit: 'आज्ञा - Ajna',
    location: 'Kaşlar arası, alın ortası',
    element: 'Manas (Zihin) / Işık',
    symbol: '◉',
    petalCount: 2,
    petalMeaning:
        '2 yaprak, iki temel nadi\'yi temsil eder: Ida (ay, dişil) ve Pingala (güneş, eril). Ayrıca zihin ve beden, bilinç ve bilinçaltı, dünyevi ve ilahi ikilikleri simgeler. Sanskrit harfler: हं (Ham) ve क्षं (Ksham).',
    centralSymbol:
        'Merkezdeki Om sembolü (ॐ), evrensel bilincin ifadesidir. İçinde üçgen ve Shiva lingam - saf bilinç.',
    geometricShape: 'Daire içinde ters üçgen + Om sembolü + 2 yapraklı lotus',
    seedMantra: 'OM veya AUM (ॐ)',
    deity: 'Ardhanarishvara (yarı kadın-yarı erkek Shiva-Shakti)',
    shakti: 'Hakini Shakti',
    color: 'İndigo / Lacivert',
    colorHex: '#4B0082',
    shortDescription:
        'Sezgi, içgörü ve bilgelik çakrası. Fiziksel gözlerin ötesinde gören üçüncü gözün merkezi.',
    deepMeaning: '''
AJNA - KOMUT MERKEZİ

Ajna, Sanskrit'te "algılamak, bilmek, komut vermek" anlamlarına gelir. Bu çakra, yüksek benlikten gelen komutları alan ve yönlendiren "guru çakra"dır.

IŞIK VE ZİHİN ENERJİSİ:
Beş fiziksel elementin ötesinde, Ajna "Manas" (zihin) ve "Jyotis" (ışık) ile ilişkilidir. Bu çakra:
• Sezgiyi ve içgörüyü yönetir
• Psişik yetenekleri aktive eder
• Geçmiş-şimdi-gelecek algısını birleştirir
• Düaliteyi aşar

ÜÇÜNCÜ GÖZ:
Hindu geleneğinde Shiva'nın alnındaki üçüncü göz, yıkımın ve dönüşümün gücünü temsil eder. Cehaleti yakan, illüzyonu yok eden, gerçeği gören gözdür.

2 YAPRAK SİMGELEMİ:
İki yaprak, tüm ikiliklerin son buluşunu temsil eder:
• Ida (Ay nadi) + Pingala (Güneş nadi) → Sushumna'da birleşir
• Sol beyin + Sağ beyin → Birlik bilinci
• Eril + Dişil → Ardhanarishvara
• Madde + Ruh → Brahman

PİNEAL (EPIFIZ) BEZİ BAĞLANTISI:
Modern bilim, Ajna'nın pineal bez ile örtüştüğünü kabul eder. Bu bez:
• Melatonin üretir (uyku-uyanıklık döngüsü)
• "Karanlıkta ışık algılar" (spiritüel görü?)
• DMT salgılayabilir (rüya ve mistik deneyimler)
• Florid kalsifikasyonuna hassastır
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Baş ağrıları ve migren
• Görme problemleri
• Uyku bozuklukları
• Konsantrasyon güçlüğü
• Hormonal dengesizlikler
• Sinüs problemleri

DUYGUSAL BLOKAJ BELİRTİLERİ:
• Sezgiye güvensizlik
• Aşırı mantıksallık veya aşırı fantezi
• Karar verememe
• Gerçeklikten kopukluk
• Obsesif düşünceler
• Kendini tanımada zorluk

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Spiritüel rehberlik alamama
• Rüyaları hatırlayamama
• Meditasyonda derinleşememe
• İçsel sese kapalılık
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Güçlü sezgi ve içgörü
• Vivid (canlı) ve anlamlı rüyalar
• Öngörü ve durugörü (clairvoyance)
• Meditasyonda derinlik ve netlik
• Kaşlar arasında basınç veya karıncalanma
• Renk ve ışık vizyonları
• Senkronisite artışı
• Telepati ve uzak algılama
''',
    meditationPractice: '''
AJNA MEDİTASYONU:

HAZIRLIK:
- Karanlık veya loş ortam idealdir
- Mor mum, ametist veya lapis lazuli kristali
- Sessizlik veya binaural beats

UYGULAMA (40 dakika):

1. TRATAKA (Mum Bakışı) (10 dk):
Bir mum alevine göz kırpmadan bakın. Yorulunca gözleri kapatın, alevlerin alnınızda parladığını görün.

2. SHAMBHAVİ MUDRA (10 dk):
Gözleri kapalı tutarak kaşlar arasına odaklanın. Gözler yukarı ve içe dönük.

3. MANTRA (12 dk):
"OM" mantrasını uzun ve derin söyleyin. Sesin alnınızda titreştiğini hissedin.

4. BOŞLUK MEDİTASYONU (8 dk):
Düşünceleri izleyin ama takip etmeyin. Düşünceler arasındaki boşluğa odaklanın.

MUDRA:
Kalesvara Mudra - Orta parmaklar birbirine temas, başparmaklar birleşik, diğerleri kıvrık
''',
    yantraVisualization: '''
AJNA YANTRA VİZÜALİZASYONU:

1. İki yapraklı parlak mor lotus hayal edin
2. Sol yaprakta beyaz "HAM", sağ yaprakta beyaz "KSHAM"
3. Merkezdeki daire içinde altın ters üçgen
4. Üçgenin içinde parlayan Om sembolü (ॐ)
5. Om'un merkezinde Shiva lingam - saf bilinç
6. Ardhanarishvara'yı görün (yarı Shiva, yarı Parvati)
7. Üçüncü gözden mor ışık yayılıyor
8. Bu ışık tüm evreni aydınlatıyor
''',
    breathingTechnique: '''
AJNA PRANAYAMA:

1. NADİ SHODHANA (Alternatif Burun Nefesi):
- Sağ burun deliğinden nefes alın
- Sol burun deliğinden verin
- Soldan alın, sağdan verin
- Ida ve Pingala'yı dengeler
- 12 döngü

2. BHRAMARI (Arı Sesi - Üçüncü Göz Versiyonu):
- Nefes alın, verirken "mmmm"
- Parmaklarla kulakları kapatın
- Titreşimi alında hissedin
- 11 döngü

3. ŞAMBHAVI NEFES:
- Gözler kaşlar arasına odaklı
- Derin ve yavaş nefes
- Her nefeste enerji üçüncü göze çekiliyor
- 6 dakika
''',
    mudra:
        'Kalesvara Mudra - Orta parmaklar birbirine temas, başparmaklar birleşik',
    affirmation:
        '"Sezgime güveniyorum. Gerçeği net görüyorum. İçsel bilgeliğim beni yönlendiriyor."',
    associatedOrgans: [
      'Pineal (epifiz) bezi',
      'Hipofiz bezi',
      'Gözler',
      'Beyin (özellikle ön lob)',
      'Sinir sistemi',
      'Alın bölgesi',
    ],
    emotionalAspects: [
      'Sezgi',
      'İçgörü',
      'Bilgelik',
      'Hayal gücü',
      'Konsantrasyon',
      'Netlik',
      'Ayrımcılık (viveka)',
    ],
    spiritualGifts: [
      'Durugörü (clairvoyance)',
      'Öngörü',
      'Telepati',
      'Astral görüş',
      'Aura okuma',
      'Spiritüel rehberlik',
      'Geçmiş yaşam hatırlama',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Ajna, kundalini yolculuğunda "birleşme noktası"dır. Burada:
• Ida ve Pingala nadiler Sushumna'da birleşir
• Düalite sona erer
• Bilinç genişler

TRİVENİ SANGAM:
Ajna, üç büyük nadinin (Ida, Pingala, Sushumna) birleştiği kutsal noktadır - tıpkı Ganj, Yamuna ve Saraswati nehirlerinin birleşimi gibi.

Son adım:
Kundalini Ajna'dan sonra Sahasrara'ya yükselir. Bu geçiş:
• Bireysel bilincin evrensel bilince açılması
• Maya'nın (illüzyon) tamamen düşmesi
• "Aham Brahmasmi" (Ben Brahman'ım) gerçekleşmesi
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra'da Ajna, "guru çakra" olarak bilinir - içsel öğretmenin sesi buradan duyulur.

HAKİNİ SHAKTİ:
Bu çakranın Shakti'si Hakini'dir. O, altı yüzlü, altı kollu, beyaz giysili tanrıçadır. Ellerinde:
• Kitap (bilgi)
• Kafatası (ego ölümü)
• Mala (mantra)
• Davul (yaratımın ritmi)
• Koruma hareketi (abhaya)
• Bereket hareketi (varada)

SHIVA'NIN ÜÇÜNCÜ GÖZÜ:
Tantrik mitoste, Shiva'nın üçüncü gözü açıldığında:
• Kama (arzu tanrısı) yanar
• Cehalet yok olur
• Gerçeklik apaçık görülür
• Dönüşüm ve yenilenme başlar

Bu yüzden Ajna "yıkımın gözü" değil, "cehaleti yakan göz"dür.
''',
    viralQuote:
        '"Gözlerini kapat, gerçeği gör. Dış dünya bir yansıma - orijinal içeride." 👁️',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // SAHASRARA ÇAKRA (TAÇ)
  // ─────────────────────────────────────────────────────────────────────────
  'sahasrara': const ChakraYantraContent(
    id: 'sahasrara',
    chakraName: 'Taç Çakra',
    chakraNameSanskrit: 'सहस्रार - Sahasrara',
    location: 'Başın tepesi, fontanel bölgesi',
    element: 'Saf Bilinç (Brahman) / Ötesi',
    symbol: '∞',
    petalCount: 1000,
    petalMeaning:
        '1000 (veya sonsuz) yaprak, sonsuz bilinci, sınırsız potansiyeli ve tüm bilinç seviyelerini temsil eder. 50 Sanskrit harfinin her biri 20 kez tekrarlanır = 1000 yaprak.',
    centralSymbol:
        'Merkezdeki boşluk (shunya), formun ötesini temsil eder. Tam ay veya parlak ışık - saf bilinç.',
    geometricShape: '1000 yapraklı lotus (sonsuzluk sembolü)',
    seedMantra: 'Sessizlik veya OM (ॐ) veya AH',
    deity: 'Paramashiva (Saf Bilinç), Adi Shakti (İlk Enerji)',
    shakti: 'Maha Shakti / Kundalini',
    color: 'Mor/Beyaz/Altın/Tüm renkler/Renksiz',
    colorHex: '#FFFFFF',
    shortDescription:
        'Aydınlanma, birlik bilinci ve kozmik bağlantı çakrası. Bireysel benliğin sonsuzlukla birleştiği nokta.',
    deepMeaning: '''
SAHASRARA - BİN YAPRAKLI LOTUS

Sahasrara, Sanskrit'te "bin yapraklı" anlamına gelir. Ancak "bin" burada "sonsuz" demektir - sınırsız bilinç, sınırsız potansiyel.

SALT BİLİNÇ:
Sahasrara, artık bir "çakra" değil, çakraların ötesidir. Burası:
• Bireysel bilincin evrensel bilince açıldığı yer
• Atman (bireysel ruh) ve Brahman'ın (evrensel ruh) bir olduğu nokta
• Formun formsuza dönüştüğü geçit
• Zamanın ve mekanın ötesi

TAÇ SİMGELEMİ:
Tıpkı bir kralın tacı onun egemenliğini simgelediği gibi, Sahasrara da ruhun kozmik egemenliğini simgeler. Burası:
• İnsan bilincinin en yüksek noktası
• Spiritüel evrimin zirvesi
• İlahi olanla birleşme

BİNDU VE NADA:
Sahasrara'nın merkezinde:
• Bindu (nokta) - saf potansiyel
• Nada (ses) - kozmik titreşim
• Kala (ışık) - saf aydınlanma
Üçü bir arada, yaratılışın ötesindeki kaynağı temsil eder.

SHİVA-SHAKTİ BİRLEŞMESİ:
Kundalini (Shakti) yükseldiğinde, Sahasrara'da bekleyen Shiva ile birleşir. Bu "kozmik evlilik":
• Düalitenin sonu
• Ayrılık illüzyonunun çözülmesi
• Moksha (kurtuluş) deneyimi
• Samadhi (trans bilinç durumu)
''',
    blockageSymptoms: '''
FİZİKSEL BLOKAJ BELİRTİLERİ:
• Kronik baş ağrıları (özellikle tepede)
• Işığa aşırı hassasiyet
• Nörolojik problemler
• Otoimmün hastalıklar
• Koordinasyon bozuklukları
• Kronik yorgunluk

DUYGUSAL BLOKAJ BELİRTİLERİ:
• Anlamsızlık ve boşluk hissi
• Spiritüel bağlantı eksikliği
• Aşırı materyalizm
• Dogmatik düşünce
• Depresyon ve umutsuzluk
• Yaşamdan kopukluk

SPİRİTÜEL BLOKAJ BELİRTİLERİ:
• Spiritüel arayışta tıkanma
• "Karanlık gece" deneyimi
• Evrenle bağlantı hissedememme
• Aydınlanmadan uzaklık hissi
''',
    activationSigns: '''
AKTİVASYON BELİRTİLERİ:
• Derin barış ve huzur
• Birlik bilinci deneyimi
• Koşulsuz sevgi ve şefkat
• Zamanın durması hissi
• Işık vizyonları
• Samadhi veya trans durumları
• Başın tepesinde karıncalanma veya basınç
• Spiritüel şarkılar veya sesler duyma
• Ego'nun geçici çözülmesi
• "Her şey bir" deneyimi
''',
    meditationPractice: '''
SAHASRARA MEDİTASYONU:

NOT: Sahasrara meditasyonu ileri seviye bir pratiktir. Diğer çakralar dengeli olmalıdır.

HAZIRLIK:
- Sessiz, kutsal alan
- Beyaz veya mor mum, berrak kuvars kristali
- Tam sessizlik önerilir

UYGULAMA (Sınırsız - en az 45 dakika):

1. ÇAKRA YOLCULUĞU (15 dk):
Muladhara'dan başlayarak her çakrayı aktive edin. Kundalini'nin yükseldiğini hissedin.

2. TAÇ AÇILIŞI (15 dk):
Başın tepesine odaklanın. Bin yapraklı lotusun açıldığını hayal edin.

3. SİMSİZLİK (15+ dk):
Tüm düşünceleri, tüm imgelemleri bırakın. Sadece "ol"un. Boşlukta kalın.

4. IŞIK DOLUŞU:
Yukarıdan gelen beyaz/altın ışığın sizi doldurduğunu hissedin. Sınırlarınızın eridiğini izleyin.

MUDRA:
Mahamudra veya Hakini Mudra - Tüm parmak uçları birleşik, elleri üçüncü göz hizasında
''',
    yantraVisualization: '''
SAHASRARA YANTRA VİZÜALİZASYONU:

1. Sonsuz yapraklı ışık lotusunu hayal edin
2. Her yaprak bir gökkuşağı renginde parıldıyor
3. Lotus, başınızın üzerinde yavaşça dönüyor
4. Merkezdeki boşluk saf beyaz veya altın ışık
5. Bu ışığın içine bakın - sınırsız derinlik
6. Shiva ve Shakti'nin birleşimini görün
7. Bireysel benliğinizin bu ışıkta eridiğini izleyin
8. Siz ve evren bir olun
''',
    breathingTechnique: '''
SAHASRARA PRANAYAMA:

1. KEVALİ (Spontan Nefes):
- Nefesi zorlamayın
- Doğal ritme bırakın
- Nefes neredeyse durur gibi olabilir
- Sınırsız

2. SAHAJA PRANAYAMA:
- "Sahaja" = doğal, spontan
- Hiçbir teknik yok, sadece farkındalık
- Nefesin kendi kendine aktığını izleyin

3. SUSHUMNA NEFES:
- Her iki burun deliğinden eşit nefes
- Enerjinin omurgadan yukarı çıktığını hissedin
- Sahasrara'da yayıldığını görün
- 21 dakika
''',
    mudra:
        'Hakini Mudra - Tüm parmak uçları karşı parmaklarla birleşik, eller üçüncü göz hizasında',
    affirmation:
        '"Ben saf bilinç. Evrenle birim. Ayrılık illüzyondur - gerçek birlik."',
    associatedOrgans: [
      'Pineal (epifiz) bezi',
      'Beyin korteksi',
      'Merkezi sinir sistemi',
      'Tüm beden (holografik)',
    ],
    emotionalAspects: [
      'Aşkınlık',
      'Birlik',
      'Huzur',
      'Anlam',
      'Bağlantı',
      'Kutsiyet',
      'Teslimiyet',
    ],
    spiritualGifts: [
      'Samadhi (trans bilinç)',
      'Kozmik bilinç',
      'Siddhiler (doğaüstü güçler)',
      'Moksha (kurtuluş)',
      'Işık bedeni aktivasyonu',
      'Spontan şifa',
    ],
    kundaliniConnection: '''
KUNDALİNİ BAĞLANTISI:

Sahasrara, kundalini yolculuğunun son durağıdır. Burada:
• Shakti, Shiva ile birleşir
• İlk ayrılık şifa bulur
• "Ben" ve "O" ayrımı sona erer

SAMADHİ DENEYİMİ:
Kundalini Sahasrara'ya ulaştığında:
• Savikalpa Samadhi: Dönüş mümkün bilinç genişlemesi
• Nirvikalpa Samadhi: Ego tamamen çözülür
• Sahaja Samadhi: Sürekli birlik bilinci (en yüksek)

KOZMOZ EŞİ:
Tantrik öğretiye göre, Shakti yükselip Shiva ile birleştiğinde, evren yaratılışından önceki durumuna döner - saf potansiyel, saf bilinç, saf aşk.
''',
    tantraTeaching: '''
TANTRİK ÖĞRETİ:

Tantra'da Sahasrara, "nihai birleşme" kapısıdır - Shakti'nin eve dönüşü.

PARAMASHIVA:
Sahasrara'nın tanrısı Paramashiva'dır - tüm formların ötesinde, saf bilinç olarak Shiva.

ADİ SHAKTİ:
Kundalini, yükseldiğinde orijinal formuna, Adi Shakti'ye (İlk Enerji) dönüşür.

BİRLEŞME:
Tantrik birleşmenin en yüksek formu, Sahasrara'da gerçekleşir:
• İki beden değil, iki bilinç
• İki ego değil, bir bilinç
• Ayrılık değil, sonsuz birlik

Bu birleşme, fiziksel cinselliğin ötesinde:
• Kozmik orgazm
• Ego ölümü ve yeniden doğuş
• Moksha (kurtuluş) deneyimi
''',
    viralQuote:
        '"Sen bir damla değilsin okyanusta. Sen okyanusun ta kendisisin, bir damlada." 🪷',
  ),
};

// ═══════════════════════════════════════════════════════════════════════════
// 4. BURÇ GEOMETRİLERİ (ZODIAC GEOMETRY)
// ═══════════════════════════════════════════════════════════════════════════

final Map<String, ZodiacGeometryContent> zodiacGeometry = {
  // ─────────────────────────────────────────────────────────────────────────
  // KOÇ (ARIES)
  // ─────────────────────────────────────────────────────────────────────────
  'aries': const ZodiacGeometryContent(
    id: 'aries',
    zodiacSign: 'Koç',
    symbol: '♈',
    element: GeometricElement.fire,
    geometricSignature:
        'Tetrahedron - Dört yüzlü piramit, ateşin en saf geometrik formu',
    sacredShape: '''
Koç'un kutsal şekli TETRAHEDRON'dur (dört yüzlü piramit).

Bu en temel Platonik katı cisimdir:
• 4 eşkenar üçgen yüz
• 4 köşe noktası
• 6 kenar

Tetrahedron, ateş elementinin geometrik manifestasyonudur. Koç'un:
• Öncü enerjisi
• Başlatıcı gücü
• Yükselen ateşi
Bu şekilde kristalize olur.
''',
    mandalaDescription: '''
KOÇ MANDALASI:

Merkez: Kırmızı spiral - yaşam gücünün püskürmesi
İlk halka: 4 tetrahedron - dört yöne yayılan enerji
İkinci halka: Koç boynuzları spiralleri - kararlılık ve güç
Dış halka: Ateş dalgaları - sürekli hareket ve dönüşüm

Renkler: Kırmızı, turuncu, altın, siyah aksan
Mantra: "OM KRAAM KREEM KRAUM SAH MANGALAYA NAMAHA"
''',
    colorPalette: 'Kırmızı (#FF0000), Turuncu (#FF4500), Altın (#FFD700)',
    planetaryRuler: 'Mars (Mangal)',
    shortDescription:
        'Ateşin ilk kıvılcımı. Tetrahedron enerjisi - saf başlatma gücü.',
    deepMeaning: '''
KOÇ'UN GEOMETRİK SIRRI:

Koç, zodyakın ilk burcu olarak "başlangıç"ın geometrisini taşır. Tetrahedron, en az yüzey alanına sahip en sağlam yapıdır - saf verimlilik ve güç.

GEOMETRİK ÖZELLİKLER:
• Tetrahedron'un her yüzü bir başlangıcı temsil eder
• 4 köşe: irade, cesaret, eylem, zafer
• 6 kenar: hedef-odak, enerji-hareket, niyet-manifestasyon bağlantıları

Koç enerjisi ile çalışırken:
• Tetrahedronu zihinsel olarak görselleştirin
• Kırmızı ışıkla dolduğunu hayal edin
• Solar plexus'a yerleştirin
• Eylem ve başlangıç niyetinizi tutun
''',
    geometricMeditation: '''
KOÇ TETRAHEDRON MEDİTASYONU:

1. Derin nefes alın, güneş doğarken yapın
2. Önünüzde dönen kırmızı bir tetrahedron görün
3. Tetrahedronun içine girin
4. Dört yüzden gelen enerjiyi hissedin
5. "RAM" mantrasını 21 kez tekrarlayın
6. Yeni bir projeyi başlatma niyetinizi tutun
7. Tetrahedronun kalbinize yerleştiğini görün
''',
    personalYantra:
        'Mars Yantra\'nın sadeleştirilmiş versiyonu - merkezdeki tetrahedron ile',
    activationPractice: '''
AKTİVASYON:
• Salı günleri yapın (Mars günü)
• Kırmızı giysiler giyin
• Kapalabhati (ateş nefesi) uygulayın
• Fiziksel egzersiz ekleyin
• Yeni bir şey başlatın
''',
    sacredNumbers: ['1', '9', '4'],
    powerSymbols: ['Tetrahedron', 'Koç boynuzları', 'Ateş üçgeni', 'Kılıç'],
    viralQuote: '"İlk adımı at. Evren cesurların yanında." 🔥',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // BOĞA (TAURUS)
  // ─────────────────────────────────────────────────────────────────────────
  'taurus': const ZodiacGeometryContent(
    id: 'taurus',
    zodiacSign: 'Boğa',
    symbol: '♉',
    element: GeometricElement.earth,
    geometricSignature:
        'Hexahedron (Küp) - Altı yüzlü, toprak elementinin mükemmel stabilitesi',
    sacredShape: '''
Boğa'nın kutsal şekli HEXAHEDRON/KÜP'tür.

Bu, toprak elementinin geometrik manifestasyonudur:
• 6 kare yüz
• 8 köşe noktası
• 12 kenar

Küp, Boğa'nın:
• Stabilite arayışı
• Maddi güvenlik ihtiyacı
• Kalıcılık arzusu
Bu şekilde kristalize olur.
''',
    mandalaDescription: '''
BOĞA MANDALASI:

Merkez: Yeşil kare - topraklanma ve bereket
İlk halka: 6 küp yüzü açılmış - tüm yönlere uzanan sağlamlık
İkinci halka: Boğa boynuzları hilalleri - ay enerjisi ve Venüs bağlantısı
Dış halka: Çiçek motifleri ve buğday başakları - bolluk ve bereket

Renkler: Yeşil, kahverengi, pembe, altın
Mantra: "OM DRAAM DREEM DRAUM SAH SHUKRAYA NAMAHA"
''',
    colorPalette: 'Yeşil (#228B22), Kahverengi (#8B4513), Pembe (#FFC0CB)',
    planetaryRuler: 'Venüs (Shukra)',
    shortDescription:
        'Toprağın sağlamlığı. Küp enerjisi - maddi manifestasyon gücü.',
    deepMeaning: '''
BOĞA'NIN GEOMETRİK SIRRI:

Boğa, "maddenin kutsallığı"nı temsil eder. Küp, üç boyutlu uzayın en temel yapısıdır - x, y, z eksenlerinin eşit uzanımı.

GEOMETRİK ÖZELLİKLER:
• 6 yüz: beş duyu + altıncı his (estetik)
• 8 köşe: sekiz yönde güvenlik
• 12 kenar: 12 ay döngüsü, 12 burç bağlantısı

Boğa enerjisi ile çalışırken:
• Küpü toprak altında görselleştirin
• Yeşil-altın ışıkla dolduğunu hayal edin
• Kök çakraya yerleştirin
• Bolluk ve stabilite niyetinizi tutun
''',
    geometricMeditation: '''
BOĞA KÜP MEDİTASYONU:

1. Doğada veya bahçede oturun
2. Ayaklarınızın altında yeşil bir küp görün
3. Küpün kökleri var, toprağa uzanıyor
4. Topraktan enerji çekin, küpü doldurun
5. "VAM" mantrasını 21 kez tekrarlayın (su elementi içindeki toprak)
6. Maddi bolluk niyetinizi tutun
7. Küpün kalçalarınıza yerleştiğini görün
''',
    personalYantra:
        'Venüs Yantra\'nın sadeleştirilmiş versiyonu - merkezdeki küp ile',
    activationPractice: '''
AKTİVASYON:
• Cuma günleri yapın (Venüs günü)
• Yeşil veya pembe giysiler giyin
• Yürüyüş yapın, toprakla temas edin
• Lezzetli yiyecekler hazırlayın
• Sanat veya müzikle ilgilenin
''',
    sacredNumbers: ['6', '2', '4'],
    powerSymbols: ['Küp', 'Boğa', 'Çiçek', 'Venüs sembolü'],
    viralQuote: '"Sağlam köklerin varsa, fırtınalar seni yıkamaz." 🌿',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // İKİZLER (GEMINI)
  // ─────────────────────────────────────────────────────────────────────────
  'gemini': const ZodiacGeometryContent(
    id: 'gemini',
    zodiacSign: 'İkizler',
    symbol: '♊',
    element: GeometricElement.air,
    geometricSignature:
        'Octahedron - Sekiz yüzlü, hava elementinin dans eden dengesi',
    sacredShape: '''
İkizler'in kutsal şekli OCTAHEDRON'dur (sekiz yüzlü).

Bu, hava elementinin geometrik manifestasyonudur:
• 8 eşkenar üçgen yüz
• 6 köşe noktası
• 12 kenar

Octahedron, İkizler'in:
• Düalite doğası
• Zihinsel çeviklik
• İletişim becerisi
Bu şekilde kristalize olur.
''',
    mandalaDescription: '''
İKİZLER MANDALASI:

Merkez: İki birleşen spiral - ikiz enerjiler
İlk halka: 8 üçgen - octahedron'un açılımı
İkinci halka: Kanatlar ve kuş motifleri - hava elementi
Dış halka: Sözcükler ve semboller - iletişim

Renkler: Sarı, açık mavi, gümüş, beyaz
Mantra: "OM BRAAM BREEM BRAUM SAH BUDHAYA NAMAHA"
''',
    colorPalette: 'Sarı (#FFFF00), Açık Mavi (#87CEEB), Gümüş (#C0C0C0)',
    planetaryRuler: 'Merkür (Budh)',
    shortDescription:
        'Havanın dans eden zekası. Octahedron enerjisi - zihinsel çeviklik.',
    deepMeaning: '''
İKİZLER'İN GEOMETRİK SIRRI:

İkizler, "düalitenin birliği"ni temsil eder. Octahedron, iki piramidi birleştirir - yukarı ve aşağı, sağ ve sol, analitik ve sezgisel.

GEOMETRİK ÖZELLİKLER:
• 8 yüz: 8 yönlü düşünce
• 6 köşe: 6 duyunun bilgi toplama
• 12 kenar: 12 iletişim kanalı

İkizler enerjisi ile çalışırken:
• Octahedronu havada asılı görselleştirin
• Sarı-gümüş ışıkla dolduğunu hayal edin
• Boğaz çakraya yerleştirin
• Netlik ve iletişim niyetinizi tutun
''',
    geometricMeditation: '''
İKİZLER OCTAHEDRON MEDİTASYONU:

1. Rüzgarlı bir yerde oturun veya fan açın
2. Başınızın üstünde dönen sarı bir octahedron görün
3. Sekiz yüzünden farklı bilgiler aktığını hayal edin
4. Bu bilgileri zihinsel olarak düzenleyin
5. "HAM" mantrasını 21 kez tekrarlayın
6. İletişim ve öğrenme niyetinizi tutun
7. Octahedronun boğazınıza yerleştiğini görün
''',
    personalYantra:
        'Merkür Yantra\'nın sadeleştirilmiş versiyonu - merkezdeki octahedron ile',
    activationPractice: '''
AKTİVASYON:
• Çarşamba günleri yapın (Merkür günü)
• Sarı veya açık mavi giysiler giyin
• Yeni bir şey öğrenin
• Yazı yazın veya konuşma yapın
• Nefes egzersizleri uygulayın
''',
    sacredNumbers: ['5', '3', '8'],
    powerSymbols: ['Octahedron', 'İkiz sütunlar', 'Kanat', 'Caduceus'],
    viralQuote: '"İki perspektif, bir gerçekliğin zenginliğidir." 🌬️',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // YENGEÇ (CANCER)
  // ─────────────────────────────────────────────────────────────────────────
  'cancer': const ZodiacGeometryContent(
    id: 'cancer',
    zodiacSign: 'Yengeç',
    symbol: '♋',
    element: GeometricElement.water,
    geometricSignature:
        'Icosahedron - Yirmi yüzlü, su elementinin akışkan mükemmelliği',
    sacredShape: '''
Yengeç'in kutsal şekli ICOSAHEDRON'dur (yirmi yüzlü).

Bu, su elementinin geometrik manifestasyonudur:
• 20 eşkenar üçgen yüz
• 12 köşe noktası
• 30 kenar

Icosahedron, Yengeç'in:
• Duygusal derinliği
• Koruyucu içgüdüsü
• Sezgisel akışı
Bu şekilde kristalize olur.
''',
    mandalaDescription: '''
YENGEÇ MANDALASI:

Merkez: Gümüş hilal ay - duygusal çekirdek
İlk halka: 20 su damlası - icosahedron yüzleri
İkinci halka: Yengeç kabukları - koruma
Dış halka: Gel-git dalgaları - duygusal döngüler

Renkler: Gümüş, beyaz, açık yeşil, deniz mavisi
Mantra: "OM SHRAAM SHREEM SHRAUM SAH CHANDRAYA NAMAHA"
''',
    colorPalette:
        'Gümüş (#C0C0C0), Deniz Mavisi (#20B2AA), Açık Yeşil (#90EE90)',
    planetaryRuler: 'Ay (Chandra)',
    shortDescription:
        'Suyun koruyucu derinliği. Icosahedron enerjisi - duygusal bilgelik.',
    deepMeaning: '''
YENGEÇ'İN GEOMETRİK SIRRI:

Yengeç, "ev ve yuva"nın kutsallığını temsil eder. Icosahedron, suya en yakın katı cisimdir - akışkanlık ve katılık arasındaki denge.

GEOMETRİK ÖZELLİKLER:
• 20 yüz: 20 duygusal nüans
• 12 köşe: 12 ay döngüsü
• 30 kenar: bir ayın gün sayısı

Yengeç enerjisi ile çalışırken:
• Icosahedronu suda yüzer görselleştirin
• Gümüş-mavi ışıkla dolduğunu hayal edin
• Kalp ve sakral çakraya yerleştirin
• Duygusal şifa ve koruma niyetinizi tutun
''',
    geometricMeditation: '''
YENGEÇ ICOSAHEDRON MEDİTASYONU:

1. Su kenarında veya banyo yaparken yapın
2. Kalbinizde gümüşümsü bir icosahedron görün
3. Su dalgaları içinde yüzdüğünüzü hayal edin
4. 20 yüzün her birinden bir duygu aktığını izleyin
5. "VAM" mantrasını 21 kez tekrarlayın
6. Duygusal şifa niyetinizi tutun
7. Icosahedronun göğsünüze yerleştiğini görün
''',
    personalYantra:
        'Ay Yantra\'nın sadeleştirilmiş versiyonu - merkezdeki icosahedron ile',
    activationPractice: '''
AKTİVASYON:
• Pazartesi günleri yapın (Ay günü)
• Beyaz veya gümüş giysiler giyin
• Su ritüelleri yapın (banyo, yüzme)
• Aileyle vakit geçirin
• Ev düzenleme ve süsleme
''',
    sacredNumbers: ['2', '7', '20'],
    powerSymbols: ['Icosahedron', 'Ay', 'Yengeç', 'Deniz kabuğu'],
    viralQuote: '"Yumuşaklığın gücü, sertliğin kıramayacağını eritir." 🌊',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // ASLAN (LEO)
  // ─────────────────────────────────────────────────────────────────────────
  'leo': const ZodiacGeometryContent(
    id: 'leo',
    zodiacSign: 'Aslan',
    symbol: '♌',
    element: GeometricElement.fire,
    geometricSignature: 'Güneş Mandala - Merkezi radyal yapı, ışığın yayılımı',
    sacredShape: '''
Aslan'ın kutsal şekli GÜNEŞ MANDALASI'dır.

Tetrahedronun ötesinde, Aslan merkezi bir radyal yapıya sahiptir:
• Merkez nokta (bindu) - kraliyet özü
• Işın çizgileri - karizmatik yayılım
• Dış halka - etki alanı

Bu, Aslan'ın:
• Merkezi varlığı
• Işıltılı doğası
• Liderlik enerjisi
Bu şekilde kristalize olur.
''',
    mandalaDescription: '''
ASLAN MANDALASI:

Merkez: Altın güneş diski - kalbin ışığı
İlk halka: 12 güneş ışını - 12 burca ışık yayılımı
İkinci halka: Aslan yelesi spiralleri - güç ve majeste
Dış halka: Alev dalgaları - yaratıcı tutku

Renkler: Altın, turuncu, kırmızı, kraliyet moru
Mantra: "OM HRAAM HREEM HRAUM SAH SURYAYA NAMAHA"
''',
    colorPalette: 'Altın (#FFD700), Turuncu (#FFA500), Kraliyet Moru (#7851A9)',
    planetaryRuler: 'Güneş (Surya)',
    shortDescription:
        'Ateşin kraliyet parıltısı. Güneş mandala enerjisi - karizmatik merkez.',
    deepMeaning: '''
ASLAN'IN GEOMETRİK SIRRI:

Aslan, "kraliyet bilinci"ni temsil eder. Güneş mandalası, merkezden çevreye yayılan ışık gibi, Aslan'ın doğal liderliğini ve karizmasını geometrize eder.

GEOMETRİK ÖZELLİKLER:
• Merkez bindu: öz-değer ve kimlik
• 12 ışın: 12 yaşam alanına etki
• Dış halka: etki alanının sınırları

Aslan enerjisi ile çalışırken:
• Güneş mandalasını kalbinizde görselleştirin
• Altın ışıkla dolduğunu hayal edin
• Kalp çakraya yerleştirin
• Özgüven ve yaratıcılık niyetinizi tutun
''',
    geometricMeditation: '''
ASLAN GÜNEŞ MANDALA MEDİTASYONU:

1. Güneş doğarken veya gün ortasında yapın
2. Kalbinizde parlayan bir güneş görün
3. Güneşten 12 ışın yayıldığını hayal edin
4. Her ışın hayatınızın bir alanını aydınlatıyor
5. "RAM" mantrasını 21 kez tekrarlayın (ateş mantrası)
6. Liderlik ve yaratıcılık niyetinizi tutun
7. Güneşin ışığının tüm bedeninize yayıldığını görün
''',
    personalYantra:
        'Güneş Yantra\'nın tam versiyonu - Aslan\'ın kişisel yantrası',
    activationPractice: '''
AKTİVASYON:
• Pazar günleri yapın (Güneş günü)
• Altın veya turuncu giysiler giyin
• Yaratıcı aktiviteler yapın
• Sahneye çıkın veya önderlik edin
• Güneş selamları (Surya Namaskar)
''',
    sacredNumbers: ['1', '5', '19'],
    powerSymbols: ['Güneş', 'Aslan', 'Taç', 'Kalp'],
    viralQuote: '"Işığını küçültme. Başkaları parlaklığına alışsın." ☀️',
  ),

  // Diğer burçlar için kısa versiyonlar...
  'virgo': const ZodiacGeometryContent(
    id: 'virgo',
    zodiacSign: 'Başak',
    symbol: '♍',
    element: GeometricElement.earth,
    geometricSignature: 'Altıgen Grid - Mükemmel düzen, arı kovanı geometrisi',
    sacredShape:
        'Başak\'ın kutsal şekli ALTI KENLI GRID\'dir - doğanın en verimli yapısı, arı kovanı paterni.',
    mandalaDescription:
        'Merkez: Buğday başağı, İç halka: Altıgen ağ yapısı, Dış halka: Hasat sembolleri',
    colorPalette: 'Yeşil, Kahverengi, Sarı, Bej',
    planetaryRuler: 'Merkür (Budh)',
    shortDescription: 'Toprağın analitik mükemmeliyeti. Altıgen grid enerjisi.',
    deepMeaning:
        'Başak, düzen ve analiz enerjisini altıgen grid ile temsil eder. Bu, en az malzeme ile en çok alan kaplayan yapıdır.',
    geometricMeditation:
        'Altıgen grid meditasyonu: Her hücrede bir detay organize edin, mükemmelliği arayın.',
    personalYantra: 'Merkür Yantra - Başak varyasyonu',
    activationPractice:
        'Çarşamba günleri, temizlik ve organizasyon, detaylara dikkat',
    sacredNumbers: ['5', '6', '14'],
    powerSymbols: ['Altıgen', 'Buğday', 'Başak', 'Kristal'],
    viralQuote: '"Mükemmellik detaylardadır." 🌾',
  ),

  'libra': const ZodiacGeometryContent(
    id: 'libra',
    zodiacSign: 'Terazi',
    symbol: '♎',
    element: GeometricElement.air,
    geometricSignature:
        'Vesica Piscis - İki dairenin mükemmel dengesi, ilişki geometrisi',
    sacredShape:
        'Terazi\'nin kutsal şekli VESİCA PİSCİS\'tir - iki eşit dairenin kesişimi, denge ve birlik.',
    mandalaDescription:
        'Merkez: Terazi sembolu, İç halka: Vesica Piscis açılımı, Dış halka: Simetrik desenler',
    colorPalette: 'Pembe, Açık Mavi, Lavanta, Beyaz',
    planetaryRuler: 'Venüs (Shukra)',
    shortDescription: 'Havanın harmonik dengesi. Vesica Piscis enerjisi.',
    deepMeaning:
        'Terazi, ilişki ve denge enerjisini Vesica Piscis ile temsil eder. İki ayrı varlığın mükemmel birlikteliği.',
    geometricMeditation:
        'Vesica Piscis meditasyonu: İki dairenin birleştiği alanda kalın, dengeyi hissedin.',
    personalYantra: 'Venüs Yantra - Terazi varyasyonu',
    activationPractice: 'Cuma günleri, sanat ve güzellik, ilişki harmonisi',
    sacredNumbers: ['6', '7', '15'],
    powerSymbols: ['Vesica Piscis', 'Terazi', 'Gül', 'Ayna'],
    viralQuote: '"Denge, iki gücün birbirini tamamlamasıdır." ⚖️',
  ),

  'scorpio': const ZodiacGeometryContent(
    id: 'scorpio',
    zodiacSign: 'Akrep',
    symbol: '♏',
    element: GeometricElement.water,
    geometricSignature: 'Spiral - Derinlere inen gizem, dönüşüm geometrisi',
    sacredShape:
        'Akrep\'in kutsal şekli SPİRAL\'dir - içe doğru dönen, derinleşen, dönüştüren.',
    mandalaDescription:
        'Merkez: Siyah spiral göz, İç halka: İç içe spiraller, Dış halka: Akrep kuyruğu ve zehir',
    colorPalette: 'Koyu Kırmızı, Siyah, Mor, Bordo',
    planetaryRuler: 'Mars ve Plüto',
    shortDescription: 'Suyun dönüştürücü derinliği. Spiral enerjisi.',
    deepMeaning:
        'Akrep, dönüşüm ve yeniden doğuş enerjisini spiral ile temsil eder. Ölüm ve yeniden doğuşun geometrisi.',
    geometricMeditation:
        'Spiral meditasyonu: Merkeze doğru dalın, gölgelerle yüzleşin, dönüşerek çıkın.',
    personalYantra: 'Rahu-Ketu Yantra kombinasyonu',
    activationPractice:
        'Salı günleri, gölge çalışması, derin meditasyon, dönüşüm niyeti',
    sacredNumbers: ['8', '9', '0'],
    powerSymbols: ['Spiral', 'Akrep', 'Anka kuşu', 'Yılan'],
    viralQuote: '"En derin karanlık, en parlak ışığın kaynağıdır." 🦂',
  ),

  'sagittarius': const ZodiacGeometryContent(
    id: 'sagittarius',
    zodiacSign: 'Yay',
    symbol: '♐',
    element: GeometricElement.fire,
    geometricSignature: 'Ok ve Yay - Hedef odaklı genişleme, vizyon geometrisi',
    sacredShape:
        'Yay\'ın kutsal şekli OK ve YAY\'dır - hedefe yönelik enerji, genişleyen vizyon.',
    mandalaDescription:
        'Merkez: Merkez hedef, İç halka: Yaydan çıkan oklar, Dış halka: Yıldız haritası',
    colorPalette: 'Mor, Lacivert, Altın, Turuncu',
    planetaryRuler: 'Jüpiter (Guru)',
    shortDescription: 'Ateşin genişleyen bilgeliği. Ok ve yay enerjisi.',
    deepMeaning:
        'Yay, vizyon ve genişleme enerjisini ok geometrisi ile temsil eder. Hedefe odaklanmış spiritüel arayış.',
    geometricMeditation:
        'Ok meditasyonu: Hedefinizi görün, enerjiyi odaklayın, bırakın ve ulaşın.',
    personalYantra: 'Jüpiter Yantra - Yay varyasyonu',
    activationPractice:
        'Perşembe günleri, yolculuk ve keşif, öğretme ve öğrenme, vizyon çalışması',
    sacredNumbers: ['3', '9', '12'],
    powerSymbols: ['Ok ve Yay', 'Centaur', 'Ateş', 'Kitap'],
    viralQuote:
        '"Hedefin büyük olsun - evren küçük hayallere zamanını vermez." 🏹',
  ),

  'capricorn': const ZodiacGeometryContent(
    id: 'capricorn',
    zodiacSign: 'Oğlak',
    symbol: '♑',
    element: GeometricElement.earth,
    geometricSignature: 'Piramit - Yükselen yapı, başarı geometrisi',
    sacredShape:
        'Oğlak\'ın kutsal şekli PİRAMİT\'tir - temelden zirveye yükselen, kademeli başarı.',
    mandalaDescription:
        'Merkez: Dağ zirvesi, İç halka: Piramit katmanları, Dış halka: Taş ve kayalar',
    colorPalette: 'Siyah, Koyu Kahverengi, Gri, Altın',
    planetaryRuler: 'Satürn (Shani)',
    shortDescription: 'Toprağın disiplinli yükselişi. Piramit enerjisi.',
    deepMeaning:
        'Oğlak, başarı ve yükseliş enerjisini piramit ile temsil eder. Sabır, disiplin ve kalıcı başarının geometrisi.',
    geometricMeditation:
        'Piramit meditasyonu: Temelden başlayın, her adımı sağlamlaştırın, zirveye ulaşın.',
    personalYantra: 'Satürn Yantra - Oğlak varyasyonu',
    activationPractice:
        'Cumartesi günleri, disiplin ve yapı, uzun vadeli planlama, sabır pratiği',
    sacredNumbers: ['8', '10', '22'],
    powerSymbols: ['Piramit', 'Keçi', 'Dağ', 'Saat'],
    viralQuote: '"Zirveye giden yol sabırla döşenir." 🏔️',
  ),

  'aquarius': const ZodiacGeometryContent(
    id: 'aquarius',
    zodiacSign: 'Kova',
    symbol: '♒',
    element: GeometricElement.air,
    geometricSignature: 'Dalga Paterni - Elektrik akışı, inovasyon geometrisi',
    sacredShape:
        'Kova\'nın kutsal şekli DALGA PATERNİ\'dir - sürekli hareket, yenilik ve devrim.',
    mandalaDescription:
        'Merkez: Elektrik spirali, İç halka: Dalga formları, Dış halka: Yıldız ağı',
    colorPalette: 'Elektrik Mavi, Mor, Gümüş, Turkuaz',
    planetaryRuler: 'Satürn ve Uranüs',
    shortDescription: 'Havanın devrimci akışı. Dalga paterni enerjisi.',
    deepMeaning:
        'Kova, inovasyon ve insanlık enerjisini dalga paterni ile temsil eder. Sürekli değişen, özgürleştiren geometri.',
    geometricMeditation:
        'Dalga meditasyonu: Elektrik dalgalarıyla titreşin, geleceği hayal edin, vizyonu yayın.',
    personalYantra: 'Uranüs-Satürn kombinasyon Yantrası',
    activationPractice:
        'Cumartesi günleri, teknoloji ve inovasyon, topluluk çalışması, vizyon paylaşımı',
    sacredNumbers: ['4', '11', '22'],
    powerSymbols: ['Dalga', 'Su taşıyıcı', 'Yıldız', 'Zincir kırma'],
    viralQuote: '"Geleceği hayal eden, onu yaratmaya başlamıştır." ⚡',
  ),

  'pisces': const ZodiacGeometryContent(
    id: 'pisces',
    zodiacSign: 'Balık',
    symbol: '♓',
    element: GeometricElement.water,
    geometricSignature:
        'Sonsuzluk Sembolü (∞) - Birleşen akışlar, mistik geometri',
    sacredShape:
        'Balık\'ın kutsal şekli SONSUZLUK SEMBOLÜ\'dür - iki balığın birbirini takip etmesi, döngüsel birlik.',
    mandalaDescription:
        'Merkez: Sonsuzluk sembolü, İç halka: İki balık dans ediyor, Dış halka: Okyanus dalgaları ve yıldızlar',
    colorPalette: 'Deniz Yeşili, Mor, Lavanta, Gümüş',
    planetaryRuler: 'Jüpiter ve Neptün',
    shortDescription: 'Suyun mistik sonsuzluğu. Sonsuzluk sembolü enerjisi.',
    deepMeaning:
        'Balık, spiritüalite ve birlik enerjisini sonsuzluk sembolü ile temsil eder. Maddi ve spiritüel dünyanın buluşması.',
    geometricMeditation:
        'Sonsuzluk meditasyonu: Sekiz çizerek nefes alın, sınırları eritin, birlik hissedin.',
    personalYantra: 'Ketu Yantra - Balık varyasyonu, moksha odaklı',
    activationPractice:
        'Perşembe günleri, meditasyon ve rüya çalışması, sanat ve müzik, spiritüel pratik',
    sacredNumbers: ['7', '12', '3'],
    powerSymbols: ['Sonsuzluk', 'İki balık', 'Okyanus', 'Nebula'],
    viralQuote: '"Sonsuzluk, bir anın içinde gizlidir." 🐟',
  ),
};

// ═══════════════════════════════════════════════════════════════════════════
// 5. MEDİTASYON TEKNİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

final List<GeometryMeditationTechnique> geometryMeditationTechniques = [
  // ─────────────────────────────────────────────────────────────────────────
  // TRATAKA (Yantra Bakışı)
  // ─────────────────────────────────────────────────────────────────────────
  const GeometryMeditationTechnique(
    id: 'trataka',
    name: 'Trataka',
    nameSanskrit: 'त्राटक',
    category: 'Yantra Bakışı',
    duration: '15-45 dakika',
    difficulty: 'Başlangıç-Orta',
    shortDescription:
        'Tek bir noktaya odaklanma pratiği. Yantra veya mum alevine sabit bakış.',
    deepMeaning: '''
TRATAKA - ODAKLANMIŞ GÖRÜNÜN GÜCÜ

Trataka, Sanskrit'te "bakmak, gözlemlemek" anlamına gelir. Bu kadim teknik, Hatha Yoga'nın altı arındırma pratiğinden (Shatkarma) biridir.

İKİ TİP TRATAKA:
1. Bahiranga (Dış): Fiziksel bir nesneye bakış
2. Antaranga (İç): Gözler kapalı, zihinsel görselleştirme

YANTRA İLE TRATAKA:
Yantra'ya trataka yapmak, sembolün enerji kodlarını bilinçaltına aktarır. Gözler fiziksel formu görürken, bilinç ötesine geçer.

FAYDALARI:
• Göz kaslarını güçlendirir
• Konsantrasyonu artırır
• Üçüncü gözü aktive eder
• Sezgiyi geliştirir
• Hafızayı güçlendirir
• Uykusuzluğu giderir
''',
    preparation: '''
HAZIRLIK:

FİZİKSEL:
• Göz sağlığınız yerinde olmalı (ciddi göz hastalığı varsa yapmayın)
• Kontakt lens çıkarın
• Gözlük takıyorsanız çıkarabilirsiniz

ORTAM:
• Karanlık veya loş ışıklı oda
• Yantra göz hizasında, 50-100 cm uzaklıkta
• Hava akımı olmamalı (mum için)
• Rahat oturma pozisyonu

ZİHİNSEL:
• Günün stresini bırakın
• Nefes ile sakinleşin
• Niyetinizi belirleyin
''',
    steps: [
      '1. Rahat bir pozisyonda oturun, sırtınız dik',
      '2. Birkaç derin nefes alın, gevşeyin',
      '3. Yantra\'nın merkez noktasına (bindu) odaklanın',
      '4. Göz kırpmadan bakmaya çalışın',
      '5. Gözler sulandığında veya yorulduğunda kapatın',
      '6. Gözler kapalıyken, yantra\'nın imgesini zihinsel olarak görün',
      '7. İmge kaybolunca gözleri açın, tekrarlayın',
      '8. Süreyi kademeli olarak artırın',
    ],
    breathingPattern: '''
NEFES PATERNİ:

• Nefes doğal ve derin olmalı
• Zorlamayın, rahat bırakın
• Dikkat nefesten uzaklaşabilir - bu normal
• Bazıları Ujjayi nefes ekler (isteğe bağlı)
''',
    visualization: '''
VİZÜALİZASYON:

GÖZLER AÇIK:
• Yantra'nın fiziksel formuna odaklanın
• Renkleri, çizgileri, sembolleri görün
• Merkezden başlayın, dışa doğru genişletin

GÖZLER KAPALI:
• Yantra'nın "negatif" görüntüsü belirecek
• Bu görüntüyü tutun, kaybolmasına izin vermeyin
• Görüntü üçüncü göz bölgesine yerleşsin
• Renklerin değiştiğini fark edebilirsiniz

İLERİ SEVİYE:
• Yantra'nın üç boyutlu hale geldiğini görün
• İçine girdiğinizi hayal edin
• Enerjiyi hissedin
''',
    mantra: 'İsteğe bağlı: Yantra\'nın bija mantrası sessizce tekrarlanabilir',
    mudra:
        'Jnana Mudra (işaret ve başparmak birleşik) veya ellerinizi dizlere koyun',
    expectedExperience: '''
OLASI DENEYİMLER:

BAŞLANGIÇTA:
• Gözlerin sulanması (normal, devam edin)
• Baş ağrısı veya göz yorgunluğu (süreyi azaltın)
• Konsantrasyon güçlüğü (pratikle gelişir)

İLERLEMEDE:
• Yantra'nın titremesi veya hareket etmesi
• Renkler değişimi veya parlama
• Zaman algısının kaybolması
• Derin huzur

İLERİ SEVİYEDE:
• Yantra'nın "canlı" görünmesi
• Enerji akışlarının görülmesi
• Vizyonlar ve içgörüler
• Samadhi benzeri durumlar
''',
    warnings: '''
UYARILAR:

• Ciddi göz hastalığı varsa yapmayın
• Migren eğilimi varsa dikkatli olun
• Epilepsi varsa kaçının
• Başlangıçta 5 dakikayı geçmeyin
• Baş dönmesi olursa durun
• Gözler çok ağrırsa profesyonel yardım alın
''',
    benefits: [
      'Konsantrasyon ve odaklanma artışı',
      'Hafıza güçlenmesi',
      'Göz sağlığı iyileşmesi',
      'Üçüncü göz aktivasyonu',
      'Sezgi gelişimi',
      'Uyku kalitesi artışı',
      'Kaygı ve stres azalması',
      'Zihinsel netlik',
    ],
    bestTime: 'Şafak veya gece yarısı',
    moonPhase: 'Dolunay en güçlü, yeni ay en derin',
    viralQuote: '"Göz beynin uzantısıdır. Gördüğün, düşündüğün olur." 👁️',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // VİZÜALİZASYON OLUŞTURMA
  // ─────────────────────────────────────────────────────────────────────────
  const GeometryMeditationTechnique(
    id: 'visualization_building',
    name: 'Geometri Visualizasyonu',
    nameSanskrit: 'Rupa Dhyana',
    category: 'Zihinsel Yapılandırma',
    duration: '20-60 dakika',
    difficulty: 'Orta-İleri',
    shortDescription:
        'Kutsal geometriyi zihinsel olarak inşa etme. Aşama aşama form oluşturma.',
    deepMeaning: '''
VİZÜALİZASYON OLUŞTURMA - ZİHNİN MİMARLIĞI

Bu teknik, Tibet Budizmi'ndeki "kyerim" (oluşturma aşaması) pratiğinden esinlenmiştir. Zihin, kutsal geometriyi adım adım inşa eder.

NEDEN ÖNEMLİ?
Fiziksel yantralar güçlüdür, ancak zihinsel olarak oluşturulan yantralar daha da güçlüdür çünkü:
• Zihnin yaratıcı gücünü kullanır
• Enerjiyi doğrudan yönlendirir
• Her an erişilebilirdir
• Kişiselleştirilebilir

AŞAMALAR:
1. Boşluk algısı (Shunya)
2. Tek nokta (Bindu)
3. Çizgi/üçgen
4. Daire
5. Lotus yaprakları
6. Renkler
7. Işık
8. Bütünlük
''',
    preparation: '''
HAZIRLIK:

• Çalışacağınız yantranın fiziksel bir kopyasını önceden inceleyin
• Yantranın yapısını, renklerini, katmanlarını ezberleyin
• Sessiz, rahat bir ortam oluşturun
• Derin nefes ile gevşeyin
• Görselleştirme becerilerinizi basit şekillerle ısındırın
''',
    steps: [
      '1. Gözlerinizi kapatın, derin nefes alın',
      '2. Zihinsel ekranınızda boşluk görün - saf karanlık veya saf beyaz',
      '3. Merkez noktayı (bindu) görselleştirin - parlak bir nokta',
      '4. Noktadan dışa doğru ilk şekli oluşturun (üçgen veya daire)',
      '5. Her katmanı sırayla ekleyin',
      '6. Renkleri yavaşça doldurun',
      '7. Işık eklemeye başlayın - parıltı, aura',
      '8. Tüm yapıyı bir bütün olarak görün',
      '9. Yantra\'yı döndürün veya yakınlaştırın (isteğe bağlı)',
      '10. Yantranın kalbinize veya üçüncü gözünüze yerleştiğini görün',
    ],
    breathingPattern: '''
NEFES PATERNİ:

• Her katman eklerken bir nefes döngüsü kullanın
• Nefes alışta enerji çekin
• Nefes verişte forma yönlendirin
• İleri seviyede, nefes otomatik olur
''',
    visualization: '''
VİZÜALİZASYON AŞAMALARI (Sri Yantra örneği):

AŞAMA 1: Boşluk ve Bindu
• Sonsuz boşlukta tek bir parlak nokta

AŞAMA 2: Üçgenler
• İlk üçgen (Shakti) - aşağı bakan
• İkinci üçgen (Shiva) - yukarı bakan
• Her üçgenin rengi ve parlaklığı

AŞAMA 3: Daireler
• Üçgenleri çevreleyen daireler
• Her dairenin farklı titreşimi

AŞAMA 4: Lotus
• 8 yapraklı iç lotus
• 16 yapraklı dış lotus
• Yaprakların renk ve dokusu

AŞAMA 5: Bhupura
• Dış kare çerçeve
• Dört kapı

AŞAMA 6: Bütünlük ve Işık
• Tüm yapı parlamaya başlar
• Enerji akışı görünür
• Yantra "canlı" hale gelir
''',
    mantra: 'Her katmanda ilgili bija mantra sessizce tekrarlanabilir',
    mudra: 'Dhyana Mudra (ellerinizi kucağınızda birleştirin)',
    expectedExperience: '''
OLASI DENEYİMLER:

• Başlangıçta görüntü kaybı (normal, tekrar oluşturun)
• Renklerin kendiliğinden değişmesi
• Formun hareket etmesi
• Enerji hissi (sıcaklık, karıncalanma)
• Derin konsantrasyon durumu
• Zaman algısının değişmesi
• Sezgisel mesajlar veya içgörüler
''',
    warnings: '''
UYARILAR:

• Zorlamayın - görüntü gelişmezse dinlenin
• Baş ağrısı olursa durun
• Gerçeklikten kopma hissi olursa topraklanın
• Karmaşık yantralarla başlamayın
• İlk önce basit şekillerle pratik yapın
''',
    benefits: [
      'Görselleştirme becerisi gelişimi',
      'Yaratıcı hayal gücü artışı',
      'Konsantrasyon derinleşmesi',
      'Manifestasyon gücü',
      'Zihinsel disiplin',
      'Spiritüel bağlantı',
    ],
    bestTime: 'Şafak veya gece yarısı',
    moonPhase: 'Büyüyen ay oluşturma için, dolan ay tamamlama için',
    viralQuote: '"Hayal ettiğin her şey, gerçekliğin bir tohumudur." 🎨',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // MANTRA + YANTRA KOMBİNASYONU
  // ─────────────────────────────────────────────────────────────────────────
  const GeometryMeditationTechnique(
    id: 'mantra_yantra_combo',
    name: 'Mantra-Yantra Senkronizasyonu',
    nameSanskrit: 'Mantra-Yantra Sadhana',
    category: 'Birleşik Pratik',
    duration: '30-90 dakika',
    difficulty: 'İleri',
    shortDescription:
        'Mantra ve yantra enerjilerini birleştiren güçlü pratik. Ses ve form birliği.',
    deepMeaning: '''
MANTRA-YANTRA BİRLEŞİMİ - SES VE FORM BİRLİĞİ

Mantra ses, Yantra form. Birlikte, evrenin iki temel boyutunu birleştirir:
• Nada (kozmik ses) + Bindu (kozmik nokta)
• Shakti (enerji) + Shiva (bilinç)
• Dalga (titreşim) + Parçacık (madde)

NEDEN BİRLEŞTİRMELİ?
Tek başına güçlü olan bu iki araç, birlikte üstel bir etki yaratır:
• Mantra yantra'yı "aktive" eder
• Yantra mantra'ya "form" verir
• İkisi birlikte bilinci odaklar ve yükseltir

TANTRİK PERSPEKTIF:
Tantra'da her yantra'nın bir veya daha fazla mantra'sı vardır. Bu ikili, tanrıçanın veya tanrının "ses bedeni" (mantra) ve "form bedeni" (yantra) olarak kabul edilir.
''',
    preparation: '''
HAZIRLIK:

• Yantra'yı önceden seçin ve inceleyin
• İlgili mantra'yı doğru telaffuzla öğrenin
• Mala (tespih) hazırlayın (108 boncuk)
• Sessiz, kutsal alan oluşturun
• Tütsü ve mum yakabilirsiniz
• Mantra sayısına karar verin (21, 54, 108, 1008...)
''',
    steps: [
      '1. Yantra\'yı göz hizasına yerleştirin',
      '2. Birkaç derin nefes ile merkeze gelin',
      '3. Yantra\'nın merkez noktasına odaklanın',
      '4. İlk mantra\'yı yüksek sesle söyleyin',
      '5. Mantra\'nın yantra\'da titreştiğini görselleştirin',
      '6. Sonraki mantraları söylerken yantra\'yı "doldurun"',
      '7. Her mantra ile yantra\'nın daha parlak olduğunu görün',
      '8. Yarı yolda sessiz mantraya geçin (ajapa)',
      '9. Son mantraları tamamen içsel yapın',
      '10. Sessizlikte kalın, enerjiyi absorbe edin',
    ],
    breathingPattern: '''
NEFES PATERNİ:

YÜKSEK SESLİ MANTRA:
• Nefes alın
• Nefes verirken mantra söyleyin
• Her mantra bir tam nefes verişi

SESSİZ MANTRA:
• Nefes alışta mantranın yarısı
• Nefes verişte mantranın yarısı
• Veya: Her tam nefes döngüsünde bir mantra

İÇSEL MANTRA:
• Nefes doğal akışında
• Mantra düşünce ile eşzamanlı
''',
    visualization: '''
VİZÜALİZASYON:

BAŞLANGIÇ:
• Yantra sabit, durağan
• Mantra ile enerji girmeye başlar

GELİŞME:
• Her mantra ile yantra parlar
• Renkler canlı hale gelir
• Titreşim hissedilir

DORUK:
• Yantra ışıkla dolu
• Mantra ses olarak değil, enerji olarak hissedilir
• Yantra "canlı" görünür

BİRLEŞME:
• Yantra ve mantra ayırt edilemez
• Siz ve pratik ayrımı kaybolur
• Birlik deneyimi
''',
    mantra: '''
ÖRNEK MANTRALAR:

Sri Yantra: "Om Shreem Hreem Kleem..."
Surya Yantra: "Om Hraam Hreem Hraum Sah Suryaya Namaha"
Chandra Yantra: "Om Shraam Shreem Shraum Sah Chandraya Namaha"

Her yantra'nın kendi bija mantra'sı vardır.
''',
    mudra: 'Yantra\'ya özel mudra veya Jnana Mudra',
    expectedExperience: '''
OLASI DENEYİMLER:

• Ses ve görüntünün birleşmesi
• Yantra'nın titreşmesi veya hareket etmesi
• Derin trans durumu
• Enerji dalgaları
• Işık vizyonları
• Tanrıça/tanrı vizyonları (ileri seviye)
• Kozmik birlik hissi
''',
    warnings: '''
UYARILAR:

• Mantra telaffuzunu doğru öğrenin
• Yanlış mantra zararlı olabilir (nadiren)
• Aşırı pratik tükenmeye yol açabilir
• Deneyimsiz kişiler güçlü tantra yantralarından kaçınmalı
• Rahatsızlık hissederseniz durun
• İlk sefer kısa tutun
''',
    benefits: [
      'Güçlü enerji aktivasyonu',
      'Derin meditasyon durumları',
      'Manifestasyon hızlanması',
      'Spiritüel bağlantı derinleşmesi',
      'Karma temizliği',
      'Siddhi (doğaüstü güç) gelişimi',
    ],
    bestTime: 'Brahma Muhurta (şafaktan önce) veya gece yarısı',
    moonPhase: 'Yantra\'nın gezegenine uygun ay fazı',
    viralQuote: '"Ses formun ruhudur. Form sesin bedenidir." 🕉️',
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// 6. TANTRİK GEOMETRİ
// ═══════════════════════════════════════════════════════════════════════════

final List<TantricGeometryContent> tantricGeometry = [
  // ─────────────────────────────────────────────────────────────────────────
  // SHIVA-SHAKTI ÜÇGENLERİ
  // ─────────────────────────────────────────────────────────────────────────
  const TantricGeometryContent(
    id: 'shiva_shakti_triangles',
    name: 'Shiva-Shakti Üçgenleri',
    nameSanskrit: 'Shiva-Shakti Trikona',
    polarityType: 'Eril-Dişil Birliği',
    symbol: '△▽',
    shortDescription:
        'Yukarı ve aşağı bakan üçgenlerin birliği. Kozmik eril ve dişilin dansı.',
    deepMeaning: '''
SHIVA-SHAKTI ÜÇGENLERİ - POLARİTELERİN DANSI

Tantra felsefesinin temelinde, iki kozmik güç yatar:
• SHIVA: Saf bilinç, durağanlık, potansiyel
• SHAKTI: Saf enerji, hareket, manifestasyon

Bu iki güç, geometrik olarak iki üçgenle temsil edilir:

YUKARI BAKAN ÜÇGEN (△) - SHIVA:
• Eril prensip
• Ateş elementi
• Yükseliş, transandans
• Bilinç, farkındalık
• "Purusha" - kozmik ruh

AŞAĞI BAKAN ÜÇGEN (▽) - SHAKTI:
• Dişil prensip
• Su elementi
• İniş, immanans
• Enerji, yaratıcılık
• "Prakriti" - kozmik doğa

BİRLEŞİMLERİ - HEXAGRAM (✡):
İki üçgen birleştiğinde altı köşeli yıldız (Shatkon) oluşur. Bu:
• Anahata çakranın sembolü
• Makrokozmos ve mikrokozmos birliği
• "Yukarıdaki aşağıdaki gibidir"
• Kozmik evlilik (Hieros Gamos)
''',
    shivaAspect: '''
SHIVA BOYUTU:

• Durağan, hareketsiz
• Saf bilinç, tanık
• Formun ötesinde
• Zamansız, mekansız
• "Ben" olmadan "Ben"lik
• Işığın kaynağı

Shiva üçgeni ile çalışırken:
• Yukarı bakan üçgeni görselleştirin
• Beyaz veya kristal berraklığında
• Tepede, taç çakrada
• Durağanlık ve farkındalık niyeti
''',
    shaktiAspect: '''
SHAKTI BOYUTU:

• Dinamik, hareketli
• Saf enerji, yaratıcı güç
• Tüm formların kaynağı
• Zaman ve mekan içinde
• "Ben" olma kapasitesi
• Işığın kendisi

Shakti üçgeni ile çalışırken:
• Aşağı bakan üçgeni görselleştirin
• Kırmızı veya altın renginde
• Tabanda, kök çakrada
• Yaratıcılık ve enerji niyeti
''',
    unionSymbolism: '''
BİRLİK SİMGELEMİ:

İki üçgen birleştiğinde:
• Düalite sona erer
• Bilinç ve enerji bir olur
• Yaratıcı ve yaratılmış ayrımı kaybolur
• "Aham Brahmasmi" (Ben Brahman'ım) gerçekleşir

Bu birleşme:
• Kozmik düzeyde: Evrenin yaratılışı
• Bireysel düzeyde: Kundalini uyanışı
• İlişki düzeyinde: Tantrik birleşme
''',
    energyFlowPattern: '''
ENERJİ AKIŞ PATERNİ:

Shiva'dan Shakti'ye:
• Bilinç aşağı doğru akar
• Enerjiyi aydınlatır
• Form verir

Shakti'den Shiva'ya:
• Enerji yukarı doğru akar
• Bilinci besler
• Deneyim yaratır

BİRLİKTE:
• Sürekli döngüsel akış
• Durağan dans
• Dinamik denge
''',
    kundaliniPath: '''
KUNDALİNİ YOLU:

Shiva-Shakti üçgenleri, kundalini yolculuğunun haritasıdır:

1. Shakti (Kundalini), Muladhara'da uyur
2. Uyandığında Shiva'ya doğru yükselir
3. Her çakrada iç içe üçgenler
4. Anahata'da altı köşeli yıldız (denge noktası)
5. Sahasrara'da Shiva ile birleşir
6. Birlik bilinci deneyimlenir
''',
    meditationPractice: '''
SHİVA-SHAKTİ ÜÇGEN MEDİTASYONU:

SÜRE: 30-45 dakika

1. HAZIRLIK (5 dk):
Derin nefes, merkeze gelme

2. SHAKTI ÜÇGEN (10 dk):
• Kök çakrada kırmızı aşağı bakan üçgen görün
• "SHAKTI" veya "HREEM" mantrası
• Yaratıcı enerjiyi hissedin

3. SHIVA ÜÇGEN (10 dk):
• Taç çakrada beyaz yukarı bakan üçgen görün
• "SHIVA" veya "OM NAMAH SHIVAYA" mantrası
• Saf bilinci hissedin

4. BİRLEŞME (10 dk):
• İki üçgenin birbirini çektiğini görün
• Kalpte buluştukları görün
• Altı köşeli yıldız oluşsun
• Birlik hissini deneyimleyin

5. ENTEGRASYON (5 dk):
Sessizlik, yavaşça geri dönüş
''',
    partnerPractice: '''
PARTNER PRATİĞİ:

Tantrik çiftler için:
• Karşı karşıya oturun
• Biri Shiva, diğeri Shakti rolünde
• Göz teması ile bağlantı kurun
• Her ikisi kendi üçgenini görselleştirsin
• Aranızda birleşen altı köşeli yıldız görün
• Enerji alışverişini hissedin
• Rolleri değiştirin
''',
    soloPractice: '''
SOLO PRATİK:

• Her bireyde her iki enerji de mevcuttur
• İç eril (animus) ve iç dişil (anima)
• Solo pratikte kendi içinizde birleştirin
• Sol taraf: Shakti/Ida/Dişil
• Sağ taraf: Shiva/Pingala/Eril
• Merkez: Sushumna/Birlik
''',
    benefits: [
      'Polarite dengesi',
      'Erkek-kadın enerjisi harmonisi',
      'Yaratıcılık ve bilinç birleşimi',
      'Kundalini hazırlığı',
      'İlişki harmonisi',
      'İç bütünlük',
    ],
    warnings:
        'Tantrik pratikler güçlüdür. Deneyimli bir öğretmen eşliğinde derinleştirin. Partner pratiği karşılıklı rıza ve saygı gerektirir.',
    viralQuote:
        '"Shiva Shakti olmadan ölü bir beden, Shakti Shiva olmadan yönsüz bir fırtınadır." 🔱',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // KUNDALINI YOL GEOMETRİSİ
  // ─────────────────────────────────────────────────────────────────────────
  const TantricGeometryContent(
    id: 'kundalini_path_geometry',
    name: 'Kundalini Yol Geometrisi',
    nameSanskrit: 'Kundalini Marga Yantra',
    polarityType: 'Yükseliş Spirali',
    symbol: '🐍',
    shortDescription:
        'Kundalini enerjisinin yükseliş yolu. Çakra geometrileri boyunca sarmal hareket.',
    deepMeaning: '''
KUNDALİNİ YOL GEOMETRİSİ - YILAN TANRIÇANIN YOLCULUĞU

Kundalini, omurga tabanında uyuyan "sarılmış yılan" enerjisidir. Uyandığında, yedi çakra boyunca yükselir ve Sahasrara'da Shiva ile birleşir.

GEOMETRİK YOL:

1. MULADHARA (Başlangıç):
• 4 yapraklı lotus, kare
• Kundalini 3.5 kez sarılı
• Uyku hali

2. SVADHİSTHANA:
• 6 yapraklı lotus, hilal
• İlk uyanış, hareket
• Su elementinden geçiş

3. MANİPURA:
• 10 yapraklı lotus, üçgen
• Ateşten arınma
• İrade aktivasyonu

4. ANAHATA (Orta Nokta):
• 12 yapraklı lotus, hexagram
• Alt ve üst birleşimi
• Koşulsuz sevgi kapısı

5. VİSHUDDHA:
• 16 yapraklı lotus, daire
• Eter elementine giriş
• İfade ve arınma

6. AJNA:
• 2 yapraklı lotus, Om
• Ida-Pingala birleşimi
• Guru çakra

7. SAHASRARA (Son):
• 1000 yapraklı lotus, sonsuzluk
• Shiva ile birleşme
• Moksha
''',
    shivaAspect:
        'Shiva, Sahasrara\'da bekler. O, kundalini\'nin ulaşacağı hedeftir - saf bilinç, durağan aşk.',
    shaktiAspect:
        'Kundalini, Shakti\'nin bireysel manifestasyonudur. O, yaratıcı enerji olarak yükselir ve kaynağına döner.',
    unionSymbolism: '''
BİRLİK:

Kundalini Sahasrara'ya ulaştığında:
• Shakti Shiva ile birleşir
• Birey evrenle bir olur
• Maya (illüzyon) çözülür
• Samadhi deneyimlenir

Bu geometrik olarak:
• Spiral düzleşir
• Nokta (bindu) genişler
• Sonsuzluk (ananta) açılır
''',
    energyFlowPattern: '''
ENERJİ AKIŞ PATERNİ:

SPIRAL HAREKET:
• Kundalini düz değil, spiral yükselir
• Ida ve Pingala etrafında döner
• Her çakrada bir dönüş tamamlar

ÜÇ NADİ:
• Ida (sol, ay, dişil): Spiral sol
• Pingala (sağ, güneş, eril): Spiral sağ
• Sushumna (merkez): Ana kanal

ÇAKRA GEÇİŞLERİ:
Her çakrada:
1. Enerji girer (bindu)
2. Lotus aktive olur
3. Element dönüşür
4. Bir sonraki katmana geçer
''',
    kundaliniPath: '''
YOLCULUĞUN DETAYI:

UYANIŞ:
• Nefes, bandha, mudra, mantra ile
• Kundalini kıpırdar, başını kaldırır
• Isı ve titreşim hissedilir

YÜKSELİŞ:
• Her çakrada duraklar
• Blokajlar temizlenir
• Deneyimler yaşanır (ışık, ses, his)
• Sabır gerektirir

ZİRVE:
• Sahasrara'ya ulaşım
• Ego çözülmesi
• Kozmik bilinç
• Mutlak huzur

DÖNÜŞ:
• Enerji inmez, yayılır
• Tüm beden aydınlanır
• Sahaja (doğal) durum
''',
    meditationPractice: '''
KUNDALİNİ YOL MEDİTASYONU:

UYARI: Bu meditasyon hazırlık gerektirir. Ani kundalini uyanışı sorunlara yol açabilir.

HAZIRLIK AŞAMASI (Aylar/Yıllar):
• Düzenli meditasyon pratiği
• Nefes çalışmaları (pranayama)
• Beden arındırma (shatkarma)
• Etik yaşam (yama-niyama)

GÜVENLI PRATİK:

1. TOPRAKLANMA (5 dk):
Kök çakrada kırmızı ışık

2. FARKINDALIK YOLCULUĞU (20 dk):
• Her çakrayı sırayla ziyaret edin
• Sadece gözlemleyin, zorlamayın
• Enerji akışını hissedin

3. BAĞLANTI (5 dk):
Taç çakrada beyaz ışık ile bağlantı

4. ENTEGRASYON (10 dk):
Tüm sistemi bir bütün olarak hissedin
''',
    partnerPractice: '''
PARTNER PRATİĞİ:

• Sırt sırta oturun
• Omurgalarınızı hizalayın
• Aynı anda nefes alın-verin
• Ortak enerji alanı oluşturun
• Birlikte çakra yolculuğu yapın
• Sonunda kalp bağlantısı
''',
    soloPractice: '''
SOLO PRATİK:

• Sushumna nadi'ye odaklanın
• Omurga boyunca ışık kanalı görün
• Nefes ile enerjiyi yönlendirin
• Zorlamadan akışa izin verin
• Sabır ve tutarlılık esastır
''',
    benefits: [
      'Spiritüel uyanış',
      'Yüksek bilinç durumları',
      'Siddhiler (doğaüstü yetenekler)',
      'Derin şifa',
      'Karma temizliği',
      'Moksha (kurtuluş)',
    ],
    warnings: '''
CİDDİ UYARILAR:

• Kundalini uyanışı hafife alınmamalı
• Hazırlıksız uyanış "Kundalini Sendromu"na yol açabilir
• Fiziksel semptomlar: ısı, titreme, ağrı
• Psikolojik semptomlar: kaygı, panik, psikoz benzeri durumlar
• Deneyimli bir guru şarttır
• Tedrici ilerleme en güvenli yoldur
''',
    viralQuote:
        '"Kundalini, içindeki kozmosu uyandırır. Dikkatli ol - güneşle oynamak ateşle oynamaktır." 🔥',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // BİRLİK SEMBOLLERİ
  // ─────────────────────────────────────────────────────────────────────────
  const TantricGeometryContent(
    id: 'union_symbols',
    name: 'Tantrik Birlik Sembolleri',
    nameSanskrit: 'Maithuna Yantra',
    polarityType: 'Kutsal Birleşme',
    symbol: '☯',
    shortDescription:
        'Tantrik birleşmeyi simgeleyen geometriler. Fiziksel ötesi, spiritüel birlik.',
    deepMeaning: '''
TANTRİK BİRLİK SEMBOLLERİ - KUTSAL EVLİLİK GEOMETRİSİ

Tantra, cinselliği dışlamak yerine kutsallaştırır. Ancak "maithuna" (birleşme) sadece fiziksel değil, kozmik bir olaydır.

BİRLİK SEMBOLLERİ:

1. YAB-YUM (Tibet):
• Erkek tanrı dik oturur
• Kadın tanrı kucağında
• Birlikte meditasyon
• Bilinç + enerji = aydınlanma

2. ARDHANARISVARA (Hindu):
• Yarı erkek, yarı kadın Shiva
• Tek bedende iki polarite
• İç birliğin simgesi

3. YIN-YANG (Tao):
• Beyaz ve siyah balıklar
• İç içe geçmiş daireler
• Her birinde diğerinin özü
• Dinamik denge

4. LİNGA-YONİ (Şiva-Şakti):
• Fallus (linga) ve rahm (yoni)
• Yaratıcı birleşme
• Kozmik doğurganlık
• Her Şiva tapınağında

5. HEXAGRAM (Yahudi/Hindu):
• Yukarı ve aşağı üçgenler
• Gök ve yer birleşimi
• Mikro ve makro kozmos
''',
    shivaAspect: '''
ERİL BOYUT (SHIVA/YANG/LİNGA):

• Penetran, aktif enerji
• Bilinç, farkındalık
• Yukarı yönelim
• Güneş, gündüz
• Sertlik ve stabilite
• Verici

Geometride:
• Yukarı bakan üçgen
• Dikey çizgi
• Phallus sembolü
''',
    shaktiAspect: '''
DİŞİL BOYUT (SHAKTI/YIN/YONİ):

• Alıcı, pasif (aktif pasiflik)
• Enerji, yaratıcılık
• Aşağı/içe yönelim
• Ay, gece
• Yumuşaklık ve akışkanlık
• Alıcı

Geometride:
• Aşağı bakan üçgen
• Yatay çizgi, daire
• Rahm sembolü
''',
    unionSymbolism: '''
BİRLEŞME SİMGELEMİ:

Fiziksel seviyede:
• İki bedenin birleşmesi
• Haz ve esrime
• Yaşam yaratma

Enerjetik seviyede:
• İki enerji alanının birleşmesi
• Kundalini aktivasyonu
• Çakra harmonizasyonu

Spiritüel seviyede:
• İki bilincin birleşmesi
• Ego sınırlarının erimesi
• Kozmik birlik deneyimi

Nihai seviyede:
• Birleşme illüzyonunun farkına varış
• Hiç ayrılmamış olduğunu görme
• Non-dual (advaya) gerçeklik
''',
    energyFlowPattern: '''
ENERJİ AKIŞI:

TANTRİK BİRLEŞMEDE:
• Muladhara'dan yukarı: Kundalini
• Sahasrara'dan aşağı: Amrit (nektar)
• Ortada buluşma: Kalp çakra
• 360° enerji döngüsü

TEKNİK DETAYLAR:
• Nefes senkronizasyonu
• Göz teması (gözler açık)
• Hareket minimizasyonu
• Enerji odaklı, boşalma değil
• Uzun süreli meditasyon durumu
''',
    kundaliniPath: '''
KUNDALİNİ VE BİRLEŞME:

Tantrik birleşmede kundalini:
• Her iki partnerde de uyandırılır
• Aura alanları birleşir
• Kolektif yükseliş olur
• Paylaşılan samadhi mümkün

DİKKAT:
Bu, rastgele cinsel aktivite değildir. Gerektirir:
• Uzun hazırlık
• Karşılıklı saygı ve sevgi
• Spiritüel niyet
• Deneyimli rehberlik
''',
    meditationPractice: '''
BİRLİK SEMBOL MEDİTASYONU (Solo):

1. Hexagram üzerinde meditasyon
2. İç eril ve iç dişilinizi görselleştirin
3. Onların kalbinizde buluştuğunu hayal edin
4. Birleşmeden doğan ışığı görün
5. Bu ışığın sizi doldurduğunu hissedin
''',
    partnerPractice: '''
PARTNER PRATİĞİ (Non-seksüel):

• Karşı karşıya oturun
• Elleri tutun (sol el alıcı, sağ el verici)
• Göz teması kurun
• Nefesleri senkronize edin
• Enerji döngüsünü hissedin
• Kalp bağlantısı oluşturun
• Sessizlikte paylaşın
''',
    soloPractice: '''
SOLO PRATİK:

İç Evlilik Meditasyonu:
• İç eril ve dişilinizi tanıyın
• Her birine isim verin
• Diyalog kurun
• Barış ve denge sağlayın
• Birleştirin
• Bütün olarak hissedin
''',
    benefits: [
      'İç polarite dengesi',
      'İlişki harmonisi',
      'Cinsel şifa',
      'Yaratıcılık patlaması',
      'Spiritüel birlik deneyimi',
      'Ego çözülmesi',
    ],
    warnings: '''
UYARILAR:

• Tantrik seks, pornografik değildir
• Rıza ve saygı şarttır
• Spiritüel niyet olmadan boş pratik
• Yanlış uygulama enerji kaybına yol açar
• Deneyimli öğretmen şiddetle tavsiye edilir
• Kültürel hassasiyetlere dikkat edin
''',
    viralQuote:
        '"Gerçek birleşme, iki yarımın bütün olması değil - iki bütünün sonsuzluk yaratmasıdır." 💞',
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// YARDIMCI FONKSİYONLAR VE GETİRİCİLER
// ═══════════════════════════════════════════════════════════════════════════

/// Tüm kutsal geometri sembollerini getirir
List<SacredGeometrySymbol> getAllSacredGeometrySymbols() {
  return sacredGeometryFundamentals.values.toList();
}

/// Belirli bir kategorideki sembolleri getirir
List<SacredGeometrySymbol> getSymbolsByCategory(
  SacredGeometryCategory category,
) {
  return sacredGeometryFundamentals.values
      .where((symbol) => symbol.category == category)
      .toList();
}

/// Tüm gezegen yantralarını getirir
List<YantraContent> getAllPlanetaryYantras() {
  return planetaryYantras.values.toList();
}

/// Belirli bir gezegen için yantra getirir
YantraContent? getYantraByPlanet(String planetName) {
  return planetaryYantras.values.firstWhere(
    (yantra) => yantra.planet.toLowerCase().contains(planetName.toLowerCase()),
    orElse: () => planetaryYantras.values.first,
  );
}

/// Tüm çakra yantralarını getirir
List<ChakraYantraContent> getAllChakraYantras() {
  return chakraYantras.values.toList();
}

/// Belirli bir çakra için yantra getirir
ChakraYantraContent? getChakraYantra(String chakraId) {
  return chakraYantras[chakraId];
}

/// Tüm burç geometrilerini getirir
List<ZodiacGeometryContent> getAllZodiacGeometry() {
  return zodiacGeometry.values.toList();
}

/// Belirli bir burç için geometri getirir
ZodiacGeometryContent? getZodiacGeometry(String signId) {
  return zodiacGeometry[signId];
}

/// Elemente göre burç geometrilerini getirir
List<ZodiacGeometryContent> getZodiacByElement(GeometricElement element) {
  return zodiacGeometry.values
      .where((geometry) => geometry.element == element)
      .toList();
}

/// Tüm meditasyon tekniklerini getirir
List<GeometryMeditationTechnique> getAllMeditationTechniques() {
  return geometryMeditationTechniques;
}

/// Zorluk seviyesine göre meditasyon tekniklerini getirir
List<GeometryMeditationTechnique> getMeditationsByDifficulty(
  String difficulty,
) {
  return geometryMeditationTechniques
      .where((technique) => technique.difficulty.contains(difficulty))
      .toList();
}

/// Tüm tantrik geometri içeriklerini getirir
List<TantricGeometryContent> getAllTantricGeometry() {
  return tantricGeometry;
}

/// Günün kutsal geometri önerisi
SacredGeometrySymbol getDailyGeometryRecommendation(DateTime date) {
  final symbols = sacredGeometryFundamentals.values.toList();
  final index = date.day % symbols.length;
  return symbols[index];
}

/// Günün yantra önerisi
YantraContent getDailyYantraRecommendation(DateTime date) {
  // Haftanın gününe göre gezegen yantrası öner
  final dayToYantra = {
    DateTime.sunday: 'surya_yantra',
    DateTime.monday: 'chandra_yantra',
    DateTime.tuesday: 'mangal_yantra',
    DateTime.wednesday: 'budh_yantra',
    DateTime.thursday: 'guru_yantra',
    DateTime.friday: 'shukra_yantra',
    DateTime.saturday: 'shani_yantra',
  };

  final yantraId = dayToYantra[date.weekday] ?? 'surya_yantra';
  return planetaryYantras[yantraId] ?? planetaryYantras.values.first;
}
