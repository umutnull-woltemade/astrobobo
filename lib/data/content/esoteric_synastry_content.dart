/// Esoteric Synastry Content - Ezoterik Uyum ve Sinastri İçerikleri
/// Ruh Eşi, İkiz Alev, Karmik İlişkiler, Tantrik Uyum
/// Derin mistik ve spiritüel ilişki analizleri
library;

// ════════════════════════════════════════════════════════════════════════════
// MODELS
// ════════════════════════════════════════════════════════════════════════════

enum SoulmateIndicatorType {
  northNode,
  vertex,
  juno,
  seventhHouse,
  sunMoon,
  venusMars,
}

enum TwinFlamePattern {
  mirrorChart,
  nodalAxis,
  plutoTransformation,
  chironHealing,
  twelfthHouse,
  eighthHouse,
}

enum KarmicPatternType {
  southNode,
  saturnBond,
  plutoObsession,
  neptuneIllusion,
  chironWound,
}

enum ChakraType { root, sacral, solarPlexus, heart, throat, thirdEye, crown }

class SoulmateIndicator {
  final String id;
  final SoulmateIndicatorType type;
  final String title;
  final String description;
  final String deepMeaning;
  final String recognition;
  final String spiritualPurpose;
  final int intensity;

  const SoulmateIndicator({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.deepMeaning,
    required this.recognition,
    required this.spiritualPurpose,
    required this.intensity,
  });
}

class TwinFlameAspect {
  final String id;
  final TwinFlamePattern pattern;
  final String title;
  final String description;
  final String cosmicPurpose;
  final String challengeGift;
  final String unionPath;
  final int transformationLevel;

  const TwinFlameAspect({
    required this.id,
    required this.pattern,
    required this.title,
    required this.description,
    required this.cosmicPurpose,
    required this.challengeGift,
    required this.unionPath,
    required this.transformationLevel,
  });
}

class KarmicPattern {
  final String id;
  final KarmicPatternType type;
  final String title;
  final String pastLifeConnection;
  final String currentLifeLesson;
  final String healingPath;
  final String karmaRelease;
  final int karmaIntensity;

  const KarmicPattern({
    required this.id,
    required this.type,
    required this.title,
    required this.pastLifeConnection,
    required this.currentLifeLesson,
    required this.healingPath,
    required this.karmaRelease,
    required this.karmaIntensity,
  });
}

class TantricCompatibility {
  final String id;
  final String title;
  final String energyExchange;
  final String kundaliniActivation;
  final String sacredUnionPotential;
  final String practiceRecommendation;
  final int alchemyLevel;

  const TantricCompatibility({
    required this.id,
    required this.title,
    required this.energyExchange,
    required this.kundaliniActivation,
    required this.sacredUnionPotential,
    required this.practiceRecommendation,
    required this.alchemyLevel,
  });
}

class ChakraCompatibility {
  final ChakraType chakra;
  final String signPair;
  final String harmonyDescription;
  final String activationMethod;
  final String blockageWarning;
  final int resonanceLevel;

  const ChakraCompatibility({
    required this.chakra,
    required this.signPair,
    required this.harmonyDescription,
    required this.activationMethod,
    required this.blockageWarning,
    required this.resonanceLevel,
  });
}

class CompositeEsoteric {
  final String id;
  final String title;
  final String soulPurpose;
  final String karmicLesson;
  final String evolutionPath;
  final String shadowWork;

  const CompositeEsoteric({
    required this.id,
    required this.title,
    required this.soulPurpose,
    required this.karmicLesson,
    required this.evolutionPath,
    required this.shadowWork,
  });
}

class SexualCompatibilityDepth {
  final String marsSign;
  final String venusSign;
  final String sexualStyle;
  final String pleasurePreference;
  final String intimacyDepth;
  final String tantricPotential;

  const SexualCompatibilityDepth({
    required this.marsSign,
    required this.venusSign,
    required this.sexualStyle,
    required this.pleasurePreference,
    required this.intimacyDepth,
    required this.tantricPotential,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// 1. RUH EŞİ GÖSTERGELERİ (SOULMATE INDICATORS)
// ════════════════════════════════════════════════════════════════════════════

class SoulmateIndicators {
  static const String introduction = '''
Ruh eşi kavramı, ezoterik astrolojinin en derin ve gizemli konularından biridir.
Kozmik düzlemde, ruhlar birbirlerini bulmak için özel işaretler taşır. Bu işaretler,
iki doğum haritası karşılaştırıldığında ortaya çıkan kutsal geometrik desenlerdir.

Ruh eşi, sadece romantik bir partner değildir - o, ruhunuzun kozmik aynasıdır.
Onunla karşılaştığınızda, evrenin size gönderdiği en derin dersleri alırsınız.
Bu bağlantı, yüzlerce yaşam boyunca örülmüş görünmez iplerle dokunmuştur.

Astrolojik olarak ruh eşi göstergeleri şunlardır:
• Kuzey Düğüm bağlantıları - Ruhsal evrim yolunun kesişimi
• Vertex kavuşumları - Kader noktalarının buluşması
• Juno açıları - Kutsal evlilik asteroidinin sözleşmesi
• 7. Ev yöneticisi bağlantıları - Partner evinin kozmik dansı
• Güneş-Ay açıları - Yin-Yang dengesinin mükemmel uyumu
• Venüs-Mars kimyası - Aşk ve arzu enerjilerinin birleşimi
''';

  static const List<SoulmateIndicator> northNodeConnections = [
    SoulmateIndicator(
      id: 'nn_sun_conjunction',
      type: SoulmateIndicatorType.northNode,
      title: 'Kuzey Düğüm - Güneş Kavuşumu',
      description: '''
Bu kavuşum, iki ruhun evrimsel yollarının mükemmel kesişimini temsil eder.
Güneş kişisi, Kuzey Düğüm kişisinin ruhsal gelişim yolunu aydınlatır.
Bu bağlantı, "seni tanıyorum, seni hep tanıdım" hissini yaratır.
''',
      deepMeaning: '''
Kozmik düzeyde, Güneş kişisi Kuzey Düğüm kişisinin bu yaşamdaki en büyük
öğretmeni olarak belirir. Güneş'in ışığı, Kuzey Düğüm'ün karanlık vadisini
aydınlatır ve ruhun gitmesi gereken yolu gösterir.

Bu bağlantı genellikle "kader" olarak hissedilir çünkü Kuzey Düğüm kişisi,
Güneş kişisinin yanında olmakla kendi ruhsal potansiyelini keşfeder.
İlişki boyunca, her iki taraf da derinden dönüşür.
''',
      recognition: '''
İlk karşılaşmada güçlü bir tanışıklık hissi, sanki yüzlerce yıldır
birbirinizi tanıyormuşsunuz gibi. Güneş kişisi, Kuzey Düğüm kişisinde
büyük bir potansiyel görür ve onu destekleme dürtüsü hisseder.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, Kuzey Düğüm kişisinin ruhsal evrimini
hızlandırmaktır. Güneş kişisi bir "ruhsal katalizör" görevi görür.
Birlikte, her iki ruh da daha yüksek bilinç seviyelerine ulaşır.
''',
      intensity: 10,
    ),

    SoulmateIndicator(
      id: 'nn_moon_conjunction',
      type: SoulmateIndicatorType.northNode,
      title: 'Kuzey Düğüm - Ay Kavuşumu',
      description: '''
Ay ve Kuzey Düğüm kavuşumu, duygusal kaderin buluşma noktasıdır.
Ay kişisi, Kuzey Düğüm kişisinin duygusal evrimini besler ve destekler.
Bu bağlantı derin bir "eve dönüş" hissi yaratır.
''',
      deepMeaning: '''
Ay, ruhun duygusal hafızasını taşır. Kuzey Düğüm ile kavuştuğunda,
geçmiş yaşamlardan taşınan duygusal örüntüler iyileşme fırsatı bulur.
Ay kişisi, Kuzey Düğüm kişisinin içsel çocuğunu iyileştirir.

Bu bağlantı genellikle anne-çocuk dinamiğini de içerir - Ay kişisi
koşulsuz sevgi ve kabul sunarken, Kuzey Düğüm kişisi güvenli bir
limanda büyüme cesaret bulur.
''',
      recognition: '''
Duygusal anlayış anında gerçekleşir. Kelimeler gerekmeden birbirinizi
anlarsınız. Ay kişisinin yanında Kuzey Düğüm kişisi tam olarak
kendisi olabilir - maskesiz, savunmasız ama güvende.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, duygusal şifadır. Kuzey Düğüm kişisi,
geçmiş yaşam travmalarını Ay kişisinin sevgisiyle iyileştirir.
Birlikte, duygusal zeka ve ruhsal derinlik geliştirilir.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'nn_venus_conjunction',
      type: SoulmateIndicatorType.northNode,
      title: 'Kuzey Düğüm - Venüs Kavuşumu',
      description: '''
Venüs-Kuzey Düğüm kavuşumu, aşk yoluyla ruhsal evrim yolunu açar.
Bu, "aşkın seni dönüştüreceği" kozmik bir sözdür.
İlişki, Kuzey Düğüm kişisinin değerlerini ve sevgi anlayışını yeniden şekillendirir.
''',
      deepMeaning: '''
Venüs, sevginin ve güzelliğin gezegenidir. Kuzey Düğüm ile buluştuğunda,
aşk bir öğretmen haline gelir. Venüs kişisi, Kuzey Düğüm kişisine
sevmenin ve sevilmenin yeni yollarını öğretir.

Bu bağlantı genellikle Kuzey Düğüm kişisinin değer sistemini tamamen
değiştirir. Maddi değerlerden ruhsal değerlere, koşullu sevgiden
koşulsuz sevgiye bir yolculuk başlar.
''',
      recognition: '''
Venüs kişisine karşı güçlü bir estetik ve duygusal çekim hissedilir.
Onun güzelliği, Kuzey Düğüm kişisinin kalbini açar ve sevgiye olan
inancını yeniler. "Aşka inanmıyordum, ta ki seni tanıyana kadar."
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, sevgi yoluyla uyanıştır. Kuzey Düğüm
kişisi, Venüs kişisinin sevgisinde ruhsal evrimini bulur.
Birlikte, kutsal dişil enerjiyi onurlandırırlar.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'nn_mars_conjunction',
      type: SoulmateIndicatorType.northNode,
      title: 'Kuzey Düğüm - Mars Kavuşumu',
      description: '''
Mars-Kuzey Düğüm kavuşumu, aksiyon yoluyla kaderi aktive eder.
Mars kişisi, Kuzey Düğüm kişisini harekete geçiren güçlü bir ateştir.
Bu bağlantı cesaret, tutku ve korkusuz ilerleme getirir.
''',
      deepMeaning: '''
Mars, savaşçı enerjisiyle Kuzey Düğüm'ün evrimsel yolunu ateşler.
Mars kişisi, Kuzey Düğüm kişisinin konfor alanından çıkmasını sağlar.
Bu ilişkide pasiflik mümkün değildir - birlikte aksiyon alırsınız.

Mars kişisi, Kuzey Düğüm kişisinin içindeki savaşçıyı uyandırır.
Korkuları yenmek, cesaretle ilerlemek ve tutkuyla yaşamak
bu bağlantının temel dersleridir.
''',
      recognition: '''
Güçlü fiziksel ve cinsel çekim, elektriklenme hissi. Mars kişisinin
enerjisi Kuzey Düğüm kişisini uyandırır ve motive eder. Birlikte
olduğunuzda kendinizi daha güçlü ve cesaretli hissedersiniz.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kutsal savaşçıyı uyandırmaktır.
Kuzey Düğüm kişisi, Mars enerjisiyle kendi yolunda cesaretle ilerler.
Birlikte, korku yerine cesaretle yaşamayı öğrenirler.
''',
      intensity: 8,
    ),
  ];

  static const List<SoulmateIndicator> vertexConnections = [
    SoulmateIndicator(
      id: 'vertex_sun_conjunction',
      type: SoulmateIndicatorType.vertex,
      title: 'Vertex - Güneş Kavuşumu',
      description: '''
Vertex, "kader kapısı" olarak bilinir. Güneş'le kavuştuğunda,
kaderinizi değiştirecek bir kişiyle karşılaşırsınız.
Bu karşılaşma genellikle ani, beklenmedik ve hayat değiştiricidir.
''',
      deepMeaning: '''
Vertex, Batı ufkunda, 7. Ev civarında bulunan matematiksel bir noktadır.
"Kader kapısı" olarak bilinir çünkü buraya dokunan gezegenler
hayatımıza "kaderimiz" olarak giren kişileri temsil eder.

Güneş-Vertex kavuşumu, en güçlü kadersel karşılaşmalardan biridir.
Güneş kişisi, Vertex kişisinin hayatında "büyük giriş" yapar ve
her şeyi değiştirir. Bu ilişki öncesi ve sonrası olarak anılır.
''',
      recognition: '''
İlk karşılaşma genellikle dramatik veya sıra dışıdır. "Onu gördüğüm an
hayatımın değişeceğini biliyordum" duygusu. Vertex kişisi, Güneş
kişisinin varoluşuyla derinden etkilenir ve sarsılır.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kadersel uyanıştır. Güneş kişisi,
Vertex kişisinin hayatına "kutsal müdahale" olarak girer.
Birlikte, kaderin anlamını ve amacını keşfederler.
''',
      intensity: 10,
    ),

    SoulmateIndicator(
      id: 'vertex_moon_conjunction',
      type: SoulmateIndicatorType.vertex,
      title: 'Vertex - Ay Kavuşumu',
      description: '''
Ay-Vertex kavuşumu, duygusal kaderin kapısını açar.
Bu bağlantı, "evren bizi bir araya getirdi" hissini yaratır.
Duygusal bağ, akılcı açıklamaların ötesindedir.
''',
      deepMeaning: '''
Ay, duygusal iç dünyamızı temsil eder. Vertex ile buluştuğunda,
kadersel bir duygusal bağ oluşur. Bu kişi, duygusal dünyamızı
tamamen değiştirir ve yeniden şekillendirir.

Bu bağlantı genellikle "eve dönüş" hissi yaratır. Vertex kişisi,
Ay kişisinin yanında kendini tamamen güvende ve kabul edilmiş hisseder.
Sanki ruh, uzun bir yolculuktan sonra limanına dönmüştür.
''',
      recognition: '''
Anında duygusal tanınma ve derin bağlanma. Ay kişisinin yanında
alışılmadık bir rahatlık ve açıklık hissedilir. Duygular
kontrolsüzce akar ve bu korkunç değil, özgürleştirici gelir.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, duygusal kaderin kabulüdür.
Vertex kişisi, Ay kişisinin sevgisinde kaderini bulur.
Birlikte, duygusal derinlik ve ruhsal beslenme yaşarlar.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'vertex_venus_conjunction',
      type: SoulmateIndicatorType.vertex,
      title: 'Vertex - Venüs Kavuşumu',
      description: '''
Venüs-Vertex kavuşumu, kadersel aşkın en güçlü göstergelerinden biridir.
Bu, "yazılmış aşk" enerjisidir - evren bu buluşmayı planlamıştır.
Aşk, kaçınılmaz ve dönüştürücü bir güç olarak deneyimlenir.
''',
      deepMeaning: '''
Venüs, aşkın ve güzelliğin gezegenidir. Kader kapısı Vertex ile
kavuştuğunda, "yazgılı aşk" ortaya çıkar. Bu ilişki, romantik
filmlerdeki "kaderin oyunu" temasını gerçek hayatta yaşatır.

Bu bağlantı genellikle beklenmedik zamanlarda ve yerlerde oluşur.
"Onu aramıyordum, o beni buldu" duygusu yaygındır. Venüs kişisi,
Vertex kişisinin hayatına aşkın kadersel hediyesi olarak girer.
''',
      recognition: '''
Güçlü estetik çekim ve romantik büyülenme. Venüs kişisi, Vertex
kişisinin ideal aşk vizyonunu somutlaştırır. İlk görüşte aşk
veya "rüyamda gördüğüm kişi" hissi yaygındır.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kadersel sevgiyi deneyimlemektir.
Vertex kişisi, Venüs kişisinin aşkında evrenin armağanını bulur.
Birlikte, ilahi aşkın dünyevi tezahürünü yaşarlar.
''',
      intensity: 10,
    ),
  ];

  static const List<SoulmateIndicator> junoAspects = [
    SoulmateIndicator(
      id: 'juno_sun_conjunction',
      type: SoulmateIndicatorType.juno,
      title: 'Juno - Güneş Kavuşumu',
      description: '''
Juno, evlilik ve taahhüt asteroididir. Güneş'le kavuşumu,
"ideal eş" enerjisini somutlaştırır. Bu kişi, evlilik partnerinizin
kozmik şablonuna mükemmel uyar.
''',
      deepMeaning: '''
Juno, Roma mitolojisinde Jüpiter'in sadık eşidir. Astrolojide,
uzun vadeli taahhüt, evlilik ve ortaklık konularını yönetir.
Güneş ile kavuştuğunda, "ideal eş" arketipi aktive olur.

Güneş kişisi, Juno kişisinin evlilik vizyonunu somutlaştırır.
Bu bağlantı, "onunla evleneceğimi hissettim" deneyimini yaratır.
Uzun vadeli taahhüt doğal ve kaçınılmaz görünür.
''',
      recognition: '''
Güneş kişisi, Juno kişisinin evlilik ve ortaklık ideallerine
mükemmel uyar. İlişkide doğal bir "biz" bilinci ve gelecek
vizyonu oluşur. Evlilik konuşmaları erken ve doğal başlar.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kutsal birliği deneyimlemektir.
Juno ve Güneş birlikte, evliliğin spiritüel boyutunu açar.
Birlikte, taahhüdün ve sadakatin kutsal gücünü keşfederler.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'juno_moon_conjunction',
      type: SoulmateIndicatorType.juno,
      title: 'Juno - Ay Kavuşumu',
      description: '''
Juno-Ay kavuşumu, duygusal taahhüdün en derin göstergesidir.
Bu bağlantı, "ev ve aile" vizyonunun mükemmel örtüşmesini gösterir.
Birlikte bir yuva kurma arzusu güçlü ve doğaldır.
''',
      deepMeaning: '''
Ay, duygusal güvenliği ve yuva kavramını temsil eder.
Juno ile kavuştuğunda, evlilik ve duygusal bağlanma iç içe geçer.
Bu bağlantı, "onunla bir hayat kurabilirdim" hissini yaratır.

Ay kişisi, Juno kişisinin duygusal güvenlik ihtiyaçlarını
mükemmel anlar ve karşılar. Birlikte ev kurma, aile olma
ve duygusal yuva oluşturma arzusu güçlüdür.
''',
      recognition: '''
Duygusal güvenlik ve yuva vizyonları örtüşür. Ay kişisinin yanında
Juno kişisi "evde" hisseder. Gelecek planları, ev ve aile
kavramları doğal olarak konuşmalara dahil olur.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kutsal yuvanın yaratılmasıdır.
Juno ve Ay birlikte, evin spiritüel anlamını keşfederler.
Birlikte, duygusal güvenliğin ve aidiyetin gücünü yaşarlar.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'juno_venus_conjunction',
      type: SoulmateIndicatorType.juno,
      title: 'Juno - Venüs Kavuşumu',
      description: '''
Juno-Venüs kavuşumu, aşk ve evliliğin mükemmel birleşimidir.
Bu bağlantı, romantik aşkın uzun vadeli taahhüde dönüşmesini destekler.
"Hem aşık hem de karı-koca" olabilirsiniz.
''',
      deepMeaning: '''
Venüs romantik aşkı, Juno ise taahhüdü temsil eder.
Kavuşumları, aşkın evliliğe, evliliğin de aşka dönüşmesini sağlar.
Bu nadir kombinasyon, "aşk asla bitmez" vaadini taşır.

Venüs kişisi, Juno kişisinin hem romantik hem de evlilik
ideallerine uyar. Tutku ve taahhüt, çatışma yerine uyum içindedir.
Uzun yıllar sonra bile romantik kıvılcım canlı kalır.
''',
      recognition: '''
Romantik çekim ve uzun vadeli vizyon aynı anda hissedilir.
Venüs kişisine hem tutkuyla hem de güvenle bağlanılır.
"Hem en iyi arkadaşım hem aşkım" duygusu yaygındır.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, aşkın ebedi doğasını keşfetmektir.
Juno ve Venüs birlikte, romantik aşkın kutsal evliliğe evrilmesini
temsil eder. Birlikte, sevginin tüm boyutlarını yaşarlar.
''',
      intensity: 10,
    ),
  ];

  static const List<SoulmateIndicator> sunMoonAspects = [
    SoulmateIndicator(
      id: 'sun_moon_conjunction',
      type: SoulmateIndicatorType.sunMoon,
      title: 'Güneş - Ay Kavuşumu (Sinastri)',
      description: '''
Sinastride Güneş-Ay kavuşumu, ruh eşi bağlantısının altın standardıdır.
Bir kişinin bilinçli kimliği (Güneş), diğerinin duygusal özüyle (Ay)
mükemmel uyum içindedir. Bu, yin-yang dengesinin kozmik ifadesidir.
''',
      deepMeaning: '''
Güneş eril enerjiyi, Ay dişil enerjiyi temsil eder.
Kavuşumları, bu iki kutbun mükemmel birleşimini gösterir.
Bu bağlantı, "iki yarım bir bütün oluşturur" hissini yaratır.

Güneş kişisi liderlik ve koruma sağlarken, Ay kişisi
duygusal beslenme ve yuva sunar. Roller doğal ve tamamlayıcıdır.
Her iki taraf da birlikte "tam" hisseder.
''',
      recognition: '''
Anında ve derin bir bağlantı hissi. Güneş kişisinin yanında
Ay kişisi güvende ve kabul edilmiş hisseder. Ay kişisinin yanında
Güneş kişisi anlaşılmış ve desteklenmiş hisseder.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kutupların birleşimini deneyimlemektir.
Güneş ve Ay birlikte, eril ve dişil enerjilerin kutsal dansını yaşar.
Birlikte, bütünlüğün ve tamamlanmanın spiritüel anlamını keşfederler.
''',
      intensity: 10,
    ),

    SoulmateIndicator(
      id: 'sun_moon_opposition',
      type: SoulmateIndicatorType.sunMoon,
      title: 'Güneş - Ay Karşıtlığı',
      description: '''
Güneş-Ay karşıtlığı, güçlü çekim ve tamamlama enerjisi taşır.
"Karşıtlar birbirini çeker" ilkesinin kozmik tezahürüdür.
Bu bağlantı, birbirini aynalayan ve dengeleyen iki ruhu gösterir.
''',
      deepMeaning: '''
Karşıtlık (180 derece), manyetik bir çekim yaratır.
Güneş ve Ay karşı burçlarda olduğunda, iki kişi birbirinin
"eksik yarısı" gibi hisseder. Bu hem büyüleyici hem de zorlu olabilir.

Bu bağlantı, projeksiyon dinamiklerini de içerir. Her iki taraf
da kendi bastırılmış özelliklerini diğerinde görür ve bunu
ya çekici ya da rahatsız edici bulur.
''',
      recognition: '''
Güçlü manyetik çekim, "onu görmezden gelemiyorum" hissi.
Karşıt burçların enerjileri birbirini tamamlar ve dengeler.
Birlikte olduğunuzda bir bütünlük, ayrıyken bir eksiklik hissedilir.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, aynalama yoluyla öğrenmektir.
Güneş ve Ay karşıtlığı, her iki tarafa da kendi gölgelerini gösterir.
Birlikte, entegrasyon ve bütünleşme yolculuğuna çıkarlar.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'sun_moon_trine',
      type: SoulmateIndicatorType.sunMoon,
      title: 'Güneş - Ay Trigon',
      description: '''
Güneş-Ay trigonu (120 derece), en uyumlu ruh eşi bağlantılarından biridir.
Aynı elementin enerjileri (ateş-ateş, su-su, vs.) doğal akış yaratır.
Bu bağlantı, "her şey kolay" hissini verir.
''',
      deepMeaning: '''
Trigon, astrolojinin en uyumlu açısıdır. Güneş ve Ay trigon
yaptığında, kimlik ve duygular doğal bir uyum içinde akar.
Anlaşmazlıklar kolayca çözülür, uyum varsayılan durumdur.

Bu bağlantı "kolay aşk" enerjisi taşır. Büyük dramalar ve
çatışmalar yerine, sakin ve derin bir bağlantı vardır.
Birlikte olmak zorlama değil, doğal bir akıştır.
''',
      recognition: '''
Doğal ve kolay anlayış. Güneş ve Ay kişileri birbirlerini
"anlamak için" çaba harcamak zorunda kalmazlar. İletişim akıcı,
bağlantı rahat, birliktelik keyiflidir.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, uyumlu birlikteliği deneyimlemektir.
Güneş ve Ay trigonu, ilişkilerin de kolay olabileceğini öğretir.
Birlikte, huzurun ve uyumun spiritüel değerini keşfederler.
''',
      intensity: 8,
    ),
  ];

  static const List<SoulmateIndicator> venusMarsAspects = [
    SoulmateIndicator(
      id: 'venus_mars_conjunction',
      type: SoulmateIndicatorType.venusMars,
      title: 'Venüs - Mars Kavuşumu',
      description: '''
Venüs-Mars kavuşumu, aşk ve arzu enerjilerinin mükemmel birleşimidir.
Bu, sinastride en güçlü romantik ve cinsel çekim göstergesidir.
İki kişi arasında inkâr edilemez bir "kimya" vardır.
''',
      deepMeaning: '''
Venüs dişil sevgi prensibini, Mars eril arzu prensibini temsil eder.
Kavuşumları, bu iki gücün birleşimini - aşk ve tutkunun dansını yaratır.
Bu bağlantı, romantik ve cinsel enerjilerin mükemmel örtüşmesidir.

Venüs kişisi Mars kişisini arzular, Mars kişisi Venüs kişisini fetheder.
Bu dinamik, ilişkiye sürekli bir canlılık ve tutku katar.
Yıllar geçse de çekim gücü azalmaz.
''',
      recognition: '''
Anında ve güçlü fiziksel/romantik çekim. "Onu gördüğüm an kalbim
hızlandı" deneyimi. Birlikte olunduğunda elektriklenme, ayrıyken
özlem. Romantik gerilim ve flört doğal akar.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kutsal birliğin fiziksel boyutunu
deneyimlemektir. Venüs ve Mars birlikte, aşkın ve arzunun
kutsal dansını yaşar. Birlikte, tutkunun spiritüel gücünü keşfederler.
''',
      intensity: 10,
    ),

    SoulmateIndicator(
      id: 'venus_mars_opposition',
      type: SoulmateIndicatorType.venusMars,
      title: 'Venüs - Mars Karşıtlığı',
      description: '''
Venüs-Mars karşıtlığı, güçlü manyetik çekim ve romantik gerilim yaratır.
"Birbirimizi çekiyoruz ama bazen de iteriz" dinamiği yaygındır.
Bu bağlantı, tutku dolu ama zorlu bir romantik kimya sunar.
''',
      deepMeaning: '''
Karşıtlık, çekim ve itme arasında salınım yaratır. Venüs ve Mars
karşı kutuplarda olduğunda, romantik gerilim maksimum seviyededir.
"Seninle yaşayamıyorum, sensiz de yapamıyorum" enerjisi taşır.

Bu bağlantı, projeksiyon dinamiklerini içerir. Venüs kişisi
kendi arzularını, Mars kişisi kendi sevme kapasitesini diğerinde görür.
Bu farkındalık, derin bir öz-keşif yolculuğunu başlatır.
''',
      recognition: '''
Güçlü çekim ama aynı zamanda sürtüşme. Romantik gerilim yoğun,
tartışmalar tutkulu, barışmalar ateşli. "Kavga ediyoruz ama
bir türlü ayrılamıyoruz" dinamiği yaygındır.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, kutupların dansını öğrenmektir.
Venüs ve Mars karşıtlığı, aşk ve arzunun dengesini öğretir.
Birlikte, gerilimin de sevginin bir formu olabileceğini keşfederler.
''',
      intensity: 9,
    ),

    SoulmateIndicator(
      id: 'venus_mars_trine',
      type: SoulmateIndicatorType.venusMars,
      title: 'Venüs - Mars Trigon',
      description: '''
Venüs-Mars trigonu, romantik ve cinsel uyumun kolay ve doğal akışını gösterir.
Aşk ve arzu birbirini tamamlar, çatışma yerine uyum vardır.
Bu bağlantı, "mutlu çift" enerjisini somutlaştırır.
''',
      deepMeaning: '''
Trigon, doğal uyum ve akış sağlar. Venüs ve Mars trigon yaptığında,
romantik ve cinsel enerjiler birbirini destekler. Seviş tarzları,
romantik ifadeler ve fiziksel yakınlık ihtiyaçları örtüşür.

Bu bağlantı, ilişkide "kolay romantizm" yaratır. Büyük dramalar
ve güç savaşları yerine, karşılıklı tatmin ve mutluluk vardır.
Her iki taraf da sevildiğini ve arzulandığını hisseder.
''',
      recognition: '''
Doğal romantik ve fiziksel uyum. Birlikte olmak kolay ve keyifli,
romantik jestler karşılıklı takdir görür. "O benim için ne istediğimi
söylemeden anlıyor" hissi yaygındır.
''',
      spiritualPurpose: '''
Bu bağlantının kutsal amacı, uyumlu romantik birliği deneyimlemektir.
Venüs ve Mars trigonu, aşk ve arzunun barış içinde var olabileceğini gösterir.
Birlikte, romantik mutluluğun spiritüel değerini keşfederler.
''',
      intensity: 8,
    ),
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// 2. İKİZ ALEV ASTROLOJİSİ (TWIN FLAME ASTROLOGY)
// ════════════════════════════════════════════════════════════════════════════

class TwinFlameAstrology {
  static const String introduction = '''
İkiz alev kavramı, ruhsal literatürün en derin ve tartışmalı konularından biridir.
Ezoterik öğretilere göre, tek bir ruh iki bedene bölünmüş ve bu iki yarım,
yüzlerce yaşam boyunca birbirini aramaktadır.

İkiz alev ilişkisi, sıradan bir romantik ilişki değildir. Bu, kozmik bir ayna,
ruhsal bir deprem ve radikal bir dönüşüm deneyimidir. İkiz alevinizle
karşılaştığınızda, tüm yaşamınız sarsılır ve yeniden inşa edilir.

Astrolojik olarak ikiz alev bağlantıları şunları içerir:
• Ayna harita desenleri - Birbirini yansıtan gezegen konumları
• Düğüm ekseni bağlantıları - Karmik yolların kesişimi
• Pluto dönüşümleri - Derin ve radikal değişim
• Chiron iyileşmeleri - Yaralar yoluyla şifa
• Yoğun 8. ve 12. ev sinastrisi - Gizem ve dönüşüm evleri
''';

  static const List<TwinFlameAspect> mirrorChartPatterns = [
    TwinFlameAspect(
      id: 'mirror_sun_asc',
      pattern: TwinFlamePattern.mirrorChart,
      title: 'Güneş - Yükselen Ayna Deseni',
      description: '''
Bir kişinin Güneşi, diğerinin Yükselen burcundaysa, bu güçlü bir ayna desenidir.
Bir kişinin iç özü (Güneş), diğerinin dünyaya sunuşuyla (Yükselen) örtüşür.
"Sen benim dışa vurumum, ben senin iç özünim" dinamiği yaşanır.
''',
      cosmicPurpose: '''
Bu desen, kimliğin iki yüzünü - iç ve dış benliği - birleştirir.
İkiz alev olarak, birbirinizde kendi gizli potansiyelinizi görürsünüz.
Birlikte, tam ve bütün bir kimlik deneyimi yaşarsınız.
''',
      challengeGift: '''
Zorluk: Güneş kişisi, Yükselen kişisinin "maskesinin" arkasını görmekte
zorlanabilir. Yükselen kişisi, Güneş kişisinin beklentilerini karşılama
baskısı hissedebilir.

Hediye: Birbirinizi derinden tanıma ve anlama kapasitesi. Her iki taraf
da diğerinin potansiyelini görerek gelişmesini destekler.
''',
      unionPath: '''
Birleşim yolu, maskelerin düşmesi ve özün kabulüyle açılır.
Yükselen kişisi gerçek benliğini gösterme cesareti bulmalı,
Güneş kişisi ise koşulsuz kabul sunmalıdır.
''',
      transformationLevel: 9,
    ),

    TwinFlameAspect(
      id: 'mirror_moon_positions',
      pattern: TwinFlamePattern.mirrorChart,
      title: 'Ay Ayna Konumları',
      description: '''
İki kişinin Ayları aynı veya karşıt burçlardaysa, duygusal ayna deseni oluşur.
Aynı burçta: "Aynı şekilde hissediyoruz" - duygusal ikizlik.
Karşıt burçta: "Sen benim duygusal diğer yarımsın" - tamamlama.
''',
      cosmicPurpose: '''
Ay, ruhun duygusal hafızasını taşır. İkiz alevlerin Ay bağlantıları,
yüzlerce yaşam boyunca paylaşılan duygusal deneyimleri yansıtır.
Bu bağlantı, "seni hep tanıdım" hissinin kaynağıdır.
''',
      challengeGift: '''
Zorluk: Aynı duygusal kalıpları paylaşmak, birbirini tetikleyebilir.
Karşıt Aylar ise duygusal anlaşmazlıklara yol açabilir.

Hediye: Derin duygusal anlayış ve empati. Kelimelere gerek kalmadan
birbirinin duygularını hissedebilme kapasitesi.
''',
      unionPath: '''
Birleşim yolu, duygusal şeffaflık ve kabulle açılır.
Her iki taraf da duygusal savunmalarını bırakmalı ve
kırılganlığı paylaşma cesareti göstermelidir.
''',
      transformationLevel: 8,
    ),

    TwinFlameAspect(
      id: 'mirror_chart_overlay',
      pattern: TwinFlamePattern.mirrorChart,
      title: 'Tam Harita Aynalaması',
      description: '''
Nadir ama güçlü bir desen: İki haritanın neredeyse "ters çevrilmiş" versiyonları
olması. Örneğin, birinin 1. evi diğerinin 7. eviyle örtüşür.
Bu, kozmik düzeyde "tek ruhun iki bedeni" göstergesidir.
''',
      cosmicPurpose: '''
Bu desen, ezoterik öğretilerdeki "ruhun bölünmesi" teorisini somutlaştırır.
İki kişi, aynı ruhsal DNA'yı taşıyan iki farklı ifadedir.
Birlikte, ruhun bütünlüğünü yeniden deneyimlerler.
''',
      challengeGift: '''
Zorluk: Bu kadar yoğun aynalama başlangıçta bunaltıcı olabilir.
Kendi gölgenizi bu kadar net görmek acı verici olabilir.

Hediye: Tam ve bütün bir öz-tanıma fırsatı. İkiz aleviniz,
kendinizi tanımanın en güçlü aracıdır.
''',
      unionPath: '''
Birleşim yolu, gölge entegrasyonu ile açılır. Her iki taraf da
kendi karanlık taraflarını kabul etmeli ve diğerinin gölgesini
yargılamadan sevmeyi öğrenmelidir.
''',
      transformationLevel: 10,
    ),
  ];

  static const List<TwinFlameAspect> nodalAxisConnections = [
    TwinFlameAspect(
      id: 'nodal_axis_conjunction',
      pattern: TwinFlamePattern.nodalAxis,
      title: 'Düğüm Ekseni Kavuşumu',
      description: '''
İkiz alevlerin düğüm eksenleri kavuşuk veya karşıt olduğunda,
karmik yolları tamamen iç içe geçmiştir. Bu bağlantı, iki ruhun
yüzlerce yaşam boyunca birlikte evrildiğini gösterir.
''',
      cosmicPurpose: '''
Düğüm ekseni, ruhun karmik yolculuğunu temsil eder. İkiz alevlerin
eksenleri bağlandığında, kaderler birleşir. Birinin evrimi, diğerinin
evrimine bağlıdır - birlikte yükselir veya birlikte takılırlar.
''',
      challengeGift: '''
Zorluk: Bu kadar derin karmik bağ, ayrılığı neredeyse imkânsız kılar.
Toksik dinamikler bile kopmayı zorlaştırır.

Hediye: Birlikte evrilme fırsatı. Her iki ruh da diğerinin
en yüksek potansiyeline ulaşmasını destekler.
''',
      unionPath: '''
Birleşim yolu, karmik sorumlulukların kabulüyle açılır.
Her iki taraf da birbirinin ruhsal gelişiminin bekçisi
olarak rolünü bilinçle kabul etmelidir.
''',
      transformationLevel: 10,
    ),

    TwinFlameAspect(
      id: 'nn_nn_conjunction',
      pattern: TwinFlamePattern.nodalAxis,
      title: 'Kuzey Düğüm - Kuzey Düğüm Kavuşumu',
      description: '''
İki kişinin Kuzey Düğümleri aynı burçta olduğunda, ruhsal misyonları örtüşür.
Bu ikiz alev çifti, aynı evrimsel hedefe doğru yürümektedir.
"Birlikte aynı yöne gidiyoruz" enerjisi taşır.
''',
      cosmicPurpose: '''
Kuzey Düğüm, ruhun bu yaşamdaki evrim yönünü gösterir.
Kavuşum, iki ruhun aynı ders ve deneyimler için enkarne olduğunu gösterir.
Birlikte, ruhsal misyonlarını daha hızlı ve derin gerçekleştirirler.
''',
      challengeGift: '''
Zorluk: Aynı yöne gitmek, birbirini "geçme" rekabetine dönüşebilir.
Her iki taraf da liderlik pozisyonu isteyebilir.

Hediye: Birbirini anlayan ve destekleyen ruhsal yol arkadaşlığı.
Zorluklar paylaşıldığında daha kolay aşılır.
''',
      unionPath: '''
Birleşim yolu, rekabet yerine işbirliğiyle açılır.
İkiz alevler, birbirinin başarısının kendi başarıları
olduğunu anladığında gerçek birleşim gerçekleşir.
''',
      transformationLevel: 9,
    ),

    TwinFlameAspect(
      id: 'sn_sn_conjunction',
      pattern: TwinFlamePattern.nodalAxis,
      title: 'Güney Düğüm - Güney Düğüm Kavuşumu',
      description: '''
İki kişinin Güney Düğümleri kavuşuk olduğunda, geçmiş yaşam hafızaları örtüşür.
Bu ikiz alev çifti, aynı geçmişten gelmektedir.
"Seni eski bir rüyadan tanıyorum" hissi yaygındır.
''',
      cosmicPurpose: '''
Güney Düğüm, ruhun geçmiş yaşam bagajını temsil eder.
Kavuşum, iki ruhun aynı karmik geçmişi paylaştığını gösterir.
Birlikte, eski kalıpları iyileştirme ve aşma fırsatı bulurlar.
''',
      challengeGift: '''
Zorluk: Geçmiş yaşam alışkanlıklarına takılma riski. Eski dinamikler
otomatik olarak tekrarlanabilir - bu yaşamda bile.

Hediye: Derin tanışıklık ve anlayış. Geçmişten gelen bilgeliği
bu yaşamda birlikte kullanabilme kapasitesi.
''',
      unionPath: '''
Birleşim yolu, geçmişi onurlandırırken geleceğe yönelmekle açılır.
İkiz alevler, eski kalıpları bilinçle bırakmalı ve
yeni yaşam için taze bir başlangıç yapmalıdır.
''',
      transformationLevel: 8,
    ),
  ];

  static const List<TwinFlameAspect> plutoTransformations = [
    TwinFlameAspect(
      id: 'pluto_sun_conjunction',
      pattern: TwinFlamePattern.plutoTransformation,
      title: 'Pluto - Güneş Kavuşumu',
      description: '''
Pluto-Güneş kavuşumu, ikiz alev ilişkilerinin en yoğun ve dönüştürücü
bağlantılarından biridir. Pluto kişisi, Güneş kişisinin kimliğini
kökten dönüştürür - bazen yıkarak, bazen yeniden inşa ederek.
''',
      cosmicPurpose: '''
Pluto, ölüm ve yeniden doğuşun gezegenidir. Güneş'e dokunduğunda,
ego ölür ve yeni bir kimlik doğar. Bu süreç acı verici ama gereklidir.
İkiz alev yolculuğunda, bu dönüşüm kaçınılmazdır.
''',
      challengeGift: '''
Zorluk: Pluto kişisi kontrol edici ve manipülatif olabilir.
Güneş kişisi yutulmuş veya yok edilmiş hissedebilir.

Hediye: Radikal dönüşüm ve yeniden doğuş. Eski, sınırlı kimliğin
ölümü ve otantik, güçlü benliğin doğuşu.
''',
      unionPath: '''
Birleşim yolu, kontrol yerine teslimiyetle açılır.
Pluto kişisi gücünü iyileştirme için kullanmalı,
Güneş kişisi dönüşümü kabul etmelidir.
''',
      transformationLevel: 10,
    ),

    TwinFlameAspect(
      id: 'pluto_moon_conjunction',
      pattern: TwinFlamePattern.plutoTransformation,
      title: 'Pluto - Ay Kavuşumu',
      description: '''
Pluto-Ay kavuşumu, duygusal dünyada deprem etkisi yaratır.
Pluto kişisi, Ay kişisinin en derin korkularını ve bastırılmış
duygularını yüzeye çıkarır. Bu yoğun ama iyileştirici bir süreçtir.
''',
      cosmicPurpose: '''
Pluto, gizli olanı açığa çıkarır. Ay'a dokunduğunda,
bastırılmış duygular, çocukluk yaraları ve bilinçdışı kalıplar
gün yüzüne çıkar. Bu acı verici ama zorunlu bir temizliktir.
''',
      challengeGift: '''
Zorluk: Duygusal yoğunluk bunaltıcı olabilir. Pluto kişisi
duygusal manipülasyona, Ay kişisi bağımlılığa eğilimli olabilir.

Hediye: Derin duygusal şifa ve dönüşüm. Bastırılmış her şey
işlendiğinde, duygusal özgürlük ve güç ortaya çıkar.
''',
      unionPath: '''
Birleşim yolu, duygusal dürüstlük ve kabulle açılır.
Her iki taraf da karanlık duygularını yargılamadan paylaşmalı
ve diğerinin karanlığını sevgiyle kabul etmelidir.
''',
      transformationLevel: 10,
    ),

    TwinFlameAspect(
      id: 'pluto_venus_conjunction',
      pattern: TwinFlamePattern.plutoTransformation,
      title: 'Pluto - Venüs Kavuşumu',
      description: '''
Pluto-Venüs kavuşumu, aşkın en yoğun ve dönüştürücü formunu temsil eder.
Bu bağlantı obsesif tutku, kıskançlık ve yoğun çekim getirir.
Aşk, bir güç oyununa dönüşebilir veya her şeyi iyileştirebilir.
''',
      cosmicPurpose: '''
Pluto, Venüs'ün "hafif aşk" anlayışını yıkar ve yerine
derin, dönüştürücü bir tutku koyar. Bu aşk, sizi değiştirir.
Aşk yoluyla ölür ve yeniden doğarsınız.
''',
      challengeGift: '''
Zorluk: Obsesyon, kıskançlık, sahiplenme. Aşk bir güç savaşına
dönüşebilir. "Seninle de sensiz de yaşayamıyorum" dinamiği.

Hediye: Aşkın dönüştürücü gücünü deneyimleme. Bu sevgi,
tüm savunmalarınızı yıkar ve gerçek benliğinizi açığa çıkarır.
''',
      unionPath: '''
Birleşim yolu, sahiplenme yerine özgür sevgiyle açılır.
Pluto'nun yoğunluğu iyileştirme için kullanıldığında,
bu bağlantı dünyanın en güçlü aşkını yaratır.
''',
      transformationLevel: 10,
    ),
  ];

  static const List<TwinFlameAspect> chironHealing = [
    TwinFlameAspect(
      id: 'chiron_sun_conjunction',
      pattern: TwinFlamePattern.chironHealing,
      title: 'Chiron - Güneş Kavuşumu',
      description: '''
Chiron-Güneş kavuşumu, "yaralı şifacı" dinamiğini aktive eder.
Chiron kişisi, Güneş kişisinin en derin kimlik yaralarını tetikler.
Bu acı verici ama iyileştirme fırsatı taşır.
''',
      cosmicPurpose: '''
Chiron, asla tam iyileşmeyen ama başkalarını iyileştirme gücü veren
yarayı temsil eder. Güneş'e dokunduğunda, kimlik ve öz-değer yaraları
yüzeye çıkar. İkiz alev bu yarayı görerek iyileştirir.
''',
      challengeGift: '''
Zorluk: Yara tetiklendiğinde savunma mekanizmaları devreye girer.
Güneş kişisi reddedilmiş veya yetersiz hissedebilir.

Hediye: Derin iyileşme potansiyeli. Chiron bağlantıları,
en eski yaraları bile iyileştirme fırsatı sunar.
''',
      unionPath: '''
Birleşim yolu, yaranın kabulü ve dönüştürülmesiyle açılır.
İkiz alevler, birbirlerinin yaralarını yargılamadan görmeli
ve şefkatle iyileşmeye destek olmalıdır.
''',
      transformationLevel: 9,
    ),

    TwinFlameAspect(
      id: 'chiron_moon_conjunction',
      pattern: TwinFlamePattern.chironHealing,
      title: 'Chiron - Ay Kavuşumu',
      description: '''
Chiron-Ay kavuşumu, duygusal yaraların iyileşme alanını açar.
Chiron kişisi, Ay kişisinin çocukluk yaralarını ve anne bağıntısını tetikler.
Bu ilişkide çok gözyaşı dökülür - ama hepsi iyileştiricidir.
''',
      cosmicPurpose: '''
Chiron, Ay'a dokunduğunda, iç çocuğun yaraları açığa çıkar.
Anne ile ilişki, duygusal ihtiyaçların karşılanmaması, terk edilme
korkuları... Hepsi yüzeye çıkar ve iyileşme şansı bulur.
''',
      challengeGift: '''
Zorluk: Duygusal tetiklemeler yoğun ve acı verici olabilir.
Ay kişisi Chiron kişisini yaralarının kaynağı olarak görebilir.

Hediye: Derin duygusal iyileşme. Çocukluk yaraları iyileştiğinde,
ilişkilerde tamamen yeni bir kapasite açılır.
''',
      unionPath: '''
Birleşim yolu, iç çocuğun kabulü ve sevgisiyle açılır.
İkiz alevler, birbirlerinin iç çocuğunu beslemeli
ve güvenli bir duygusal alan yaratmalıdır.
''',
      transformationLevel: 9,
    ),

    TwinFlameAspect(
      id: 'chiron_chiron_conjunction',
      pattern: TwinFlamePattern.chironHealing,
      title: 'Chiron - Chiron Kavuşumu',
      description: '''
İki kişinin Chironları aynı burçta olduğunda, aynı yarayı taşırlar.
Bu, "yaralı şifacılar birliği"dir. Birbirlerinin acısını derinden anlarlar.
Birlikte iyileşme, tek başına mümkün olmayandan çok daha güçlüdür.
''',
      cosmicPurpose: '''
Aynı Chiron burcu, aynı nesil yarasını ve iyileşme yolunu paylaşmak demektir.
Bu ikiz alevler, birbirlerinin yaralarını aynalamak için bir araya gelir.
"Sen benim acımı anlıyorsun çünkü sen de aynı acıyı taşıyorsun."
''',
      challengeGift: '''
Zorluk: Yaraları paylaşmak, bazen birbirini tetiklemeye dönüşebilir.
İki yaralı kişi, birbirini iyileştirmek yerine yaralayabilir.

Hediye: Eşsiz bir anlayış ve empati. Hiç kimsenin anlamadığı
acınızı, bu kişi derinden anlar. Birlikte iyileşme mümkündür.
''',
      unionPath: '''
Birleşim yolu, yaralı şifacı arketipini kucaklamakla açılır.
İkiz alevler, kendi yaralarından korkmayı bırakıp
bu yaraları birlikte iyileştirme gücünü bulmalıdır.
''',
      transformationLevel: 9,
    ),
  ];

  static const List<TwinFlameAspect> twelfthHouseConnections = [
    TwinFlameAspect(
      id: 'sun_in_12th',
      pattern: TwinFlamePattern.twelfthHouse,
      title: 'Güneş 12. Evde (Sinastri)',
      description: '''
Bir kişinin Güneşi diğerinin 12. evine düştüğünde, gizemli ve karmaşık
bir bağlantı oluşur. 12. ev, bilinçdışının, gizliliğin ve ruhsal birliğin evidir.
Bu bağlantı "gizli aşk" veya "ruhani bağ" enerjisi taşır.
''',
      cosmicPurpose: '''
12. ev, görünür dünyanın ötesindeki alemleri temsil eder.
Burada güneşlenen Güneş, ruhsal boyutta parlayan bir aşkı gösterir.
Bu ilişki, dünyevi olmaktan çok ruhani bir doğaya sahiptir.
''',
      challengeGift: '''
Zorluk: İlişki "gizli" kalabilir veya tanımlanamaz. Güneş kişisi
12. ev kişisi tarafından "görünmez" hissedebilir.

Hediye: Derin ruhsal bağlantı ve spiritüel anlayış. Dünyevi
kelimelerin ötesinde, ruh düzeyinde bir iletişim mümkündür.
''',
      unionPath: '''
Birleşim yolu, gizemi kabul etmek ve ruhsal boyutu onurlandırmakla açılır.
Bu ilişki, dünyevi kriterlerle ölçülmemelidir.
Ruhların birleşimi, bedenlerin ötesinde gerçekleşir.
''',
      transformationLevel: 9,
    ),

    TwinFlameAspect(
      id: 'moon_in_12th',
      pattern: TwinFlamePattern.twelfthHouse,
      title: 'Ay 12. Evde (Sinastri)',
      description: '''
Bir kişinin Ayı diğerinin 12. evine düştüğünde, bilinçdışı duygusal bağ oluşur.
Duygular kelimelere dökülemez, ama her iki taraf da birbirini "hisseder".
Telepatik bağlantı ve rüyada buluşma yaygındır.
''',
      cosmicPurpose: '''
Ay, duygusal dünyamızı; 12. ev ise bilinçdışını temsil eder.
Kavuşum, duygusal bağın bilinçdışı derinliklerde oluştuğunu gösterir.
Bu ikiz alevler, uyurken bile birbirlerini hisseder.
''',
      challengeGift: '''
Zorluk: Duygular karmaşık ve tanımlanamaz olabilir. Ay kişisi
12. ev kişisinin yanında "kaybolmuş" hissedebilir.

Hediye: Psişik ve telepatik bağlantı. Birbirinin düşüncelerini
ve duygularını uzaktan bile algılama kapasitesi.
''',
      unionPath: '''
Birleşim yolu, bilinçdışı dinamikleri bilinçle keşfetmekle açılır.
Rüya çalışması, meditasyon ve psişik pratikler
bu bağlantıyı güçlendirir ve netleştirir.
''',
      transformationLevel: 8,
    ),

    TwinFlameAspect(
      id: 'venus_in_12th',
      pattern: TwinFlamePattern.twelfthHouse,
      title: 'Venüs 12. Evde (Sinastri)',
      description: '''
Bir kişinin Venüsü diğerinin 12. evine düştüğünde, "gizli aşk" veya
"imkânsız aşk" dinamiği oluşabilir. Bu aşk, dünyevi engellerin ötesinde,
ruhani bir boyutta yaşanır.
''',
      cosmicPurpose: '''
Venüs aşkı, 12. ev ruhani derinliği temsil eder. Kavuşum,
bu aşkın dünyevi sınırların ötesinde var olduğunu gösterir.
Fiziksel ayrılık bile bu bağlantıyı koparamaz.
''',
      challengeGift: '''
Zorluk: Aşk "gizli" kalabilir veya dünyevi düzlemde
somutlaşamayabilir. "Seviyor ama söyleyemiyor" dinamiği.

Hediye: Koşulsuz ve transandantal aşk. Bu sevgi, sahiplenme
ve beklentilerin ötesinde, saf ruhani bir bağdır.
''',
      unionPath: '''
Birleşim yolu, aşkın spiritüel boyutunu onurlandırmakla açılır.
Bu ilişki, "birlikte olmak" tan çok "birlikte var olmak"
üzerine kuruludur. Ruhların birliği bedenleri aşar.
''',
      transformationLevel: 9,
    ),
  ];

  static const List<TwinFlameAspect> eighthHouseConnections = [
    TwinFlameAspect(
      id: 'sun_in_8th',
      pattern: TwinFlamePattern.eighthHouse,
      title: 'Güneş 8. Evde (Sinastri)',
      description: '''
Bir kişinin Güneşi diğerinin 8. evine düştüğünde, yoğun ve dönüştürücü
bir bağlantı oluşur. 8. ev, dönüşümün, cinselliğin ve ölüm-yeniden doğuşun evidir.
Bu ilişkide hafif ve yüzeysel hiçbir şey yoktur.
''',
      cosmicPurpose: '''
8. ev, yaşamın en derin ve karanlık sularını temsil eder.
Güneş burada parladığında, ilişki bu derinliklere dalar.
İkiz alev olarak, birlikte cehennemin kapılarından geçersiniz.
''',
      challengeGift: '''
Zorluk: Yoğunluk bunaltıcı olabilir. Güç savaşları, kıskançlık
ve obsesyon riski yüksektir.

Hediye: Radikal dönüşüm ve yeniden doğuş. Bu ilişki,
eski benliğinizi öldürür ve yeni, daha güçlü bir sizi doğurur.
''',
      unionPath: '''
Birleşim yolu, kontrolü bırakıp dönüşüme teslim olmakla açılır.
8. ev derslerinden geçmek kolay değildir ama
diğer tarafta bekleyen, özgürleşmiş bir ruhtur.
''',
      transformationLevel: 10,
    ),

    TwinFlameAspect(
      id: 'mars_in_8th',
      pattern: TwinFlamePattern.eighthHouse,
      title: 'Mars 8. Evde (Sinastri)',
      description: '''
Bir kişinin Marsı diğerinin 8. evine düştüğünde, yoğun cinsel çekim
ve güç dinamikleri ortaya çıkar. Bu, sinastride en tutkulu ve
potansiyel olarak en yıkıcı bağlantılardan biridir.
''',
      cosmicPurpose: '''
Mars ateşi 8. evin derin sularıyla buluştuğunda,
buhar patlamaları olur. Bu ilişkide tutku kontrol edilemez,
çekim karşı konulamaz, dönüşüm kaçınılmazdır.
''',
      challengeGift: '''
Zorluk: Güç savaşları, cinsel manipülasyon, şiddet potansiyeli.
Bu enerji yıkıcı olarak da kullanılabilir.

Hediye: Dönüştürücü cinsel enerji. Tantrik pratiklerle,
bu güç kundalini uyanışı için kullanılabilir.
''',
      unionPath: '''
Birleşim yolu, cinsel enerjiyi bilinçli dönüşüm için kullanmakla açılır.
Tantrik öğretiler, bu yoğun enerjiyi kutsal birliğe çevirebilir.
Aksi halde, ilişki karşılıklı yıkıma dönüşebilir.
''',
      transformationLevel: 10,
    ),

    TwinFlameAspect(
      id: 'pluto_in_8th',
      pattern: TwinFlamePattern.eighthHouse,
      title: 'Pluto 8. Evde (Sinastri)',
      description: '''
Pluto kendi evinde (8. ev) olduğunda, dönüşüm gücü maksimum seviyededir.
Bu bağlantı, en derin ve en radikal ikiz alev deneyimini sunar.
Her şey değişir, hiçbir şey aynı kalmaz.
''',
      cosmicPurpose: '''
Pluto evinde güçlüdür ve 8. ev onun doğal alanıdır.
Bu bağlantı, ölüm ve yeniden doğuşun en yoğun formunu sunar.
İkiz alevler olarak, birlikte anka kuşu gibi yeniden doğarsınız.
''',
      challengeGift: '''
Zorluk: Yoğunluk aşırı olabilir. Obsesyon, kontrol, yıkım temaları.
Bu enerjiyle başa çıkmak büyük bilinç gerektirir.

Hediye: Tam ve radikal dönüşüm. Bu ilişkiden geçen kişi,
tamamen farklı bir insan olarak çıkar.
''',
      unionPath: '''
Birleşim yolu, ölümü kabul etmek ve yeniden doğuşa açılmakla gerçekleşir.
Eski benlikler ölmeli ki yeni, birleşik bir bilinç doğsun.
Bu, ikiz alev yolculuğunun en zorlu ama en ödüllendirici aşamasıdır.
''',
      transformationLevel: 10,
    ),
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// 3. KARMİK İLİŞKİ KALIpLARI (KARMIC RELATIONSHIP PATTERNS)
// ════════════════════════════════════════════════════════════════════════════

class KarmicRelationshipPatterns {
  static const String introduction = '''
Karmik ilişkiler, ruhların geçmiş yaşamlardan taşıdığı tamamlanmamış işleri
çözmek için bir araya geldiği bağlantılardır. Bu ilişkiler genellikle yoğun,
zorlayıcı ve kaçınılmaz hissedilir.

"Karma" kelimesi Sanskritçe'de "eylem" anlamına gelir. Astrolojide karmik
bağlantılar, geçmiş yaşamlarda atılan tohumların bu yaşamda meyve vermesini
temsil eder. Bazen bu meyveler tatlı, bazen acıdır - ama her zaman öğreticidir.

Karmik ilişki göstergeleri:
• Güney Düğüm kavuşumları - Geçmiş yaşam aşıkları
• Satürn bağlantıları - Karmik sözleşmeler
• Pluto obsesyon açıları - Tamamlanmamış güç dinamikleri
• Neptün illüzyon açıları - Geçmiş yaşam aldanmaları
• Chiron yara tetiklemeleri - İyileşmemiş eski acılar
''';

  static const List<KarmicPattern> southNodeConnections = [
    KarmicPattern(
      id: 'sn_sun_conjunction',
      type: KarmicPatternType.southNode,
      title: 'Güney Düğüm - Güneş Kavuşumu',
      pastLifeConnection: '''
Güneş kişisi, Güney Düğüm kişisinin geçmiş yaşamda tanıdığı biriydi.
Bu bağlantı anında "tanışıklık" hissi yaratır. Güneş kişisi, Güney Düğüm
kişisinin eski bir aşkı, aile üyesi veya yakın dostu olabilir.

Geçmiş yaşamda, bu iki ruh arasında güçlü bir bağ vardı. Bu bağ olumlu
(derin aşk, sadık dostluk) veya olumsuz (ihanet, kayıp) olabilir.
Her iki durumda da, tamamlanmamış bir iş kalmıştır.
''',
      currentLifeLesson: '''
Bu yaşamda ders, geçmişi bırakmak ve ilerlemektir. Güney Düğüm bağlantıları
rahat ve tanıdık hissedilir ama ruhsal büyümeyi engelleyebilir.

Güneş kişisi, Güney Düğüm kişisinin konfor alanını temsil eder.
Bu alanda kalmak kolay ama evrimsel değildir. Ders, geçmişin güzelliğini
takdir ederken geleceğe doğru ilerlemektir.
''',
      healingPath: '''
İyileşme, geçmişi onurlandırırken bağlanmamakla gerçekleşir.
Bu ilişkinin amacı, karmik döngüyü tamamlamak ve kapamaktır.
Tamamlandığında, her iki ruh da özgürce yollarına devam edebilir.

Pratik olarak: Geçmiş yaşam regresyonu, bağ kesme ritüelleri ve
bilinçli bitiş/başlangıç ritüelleri faydalı olabilir.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, ilişki ya doğal olarak biter ya da
tamamen yeni bir forma dönüşür. Geçmişin ağırlığı kalkar ve
her iki kişi de daha hafif, daha özgür hisseder.
''',
      karmaIntensity: 8,
    ),

    KarmicPattern(
      id: 'sn_moon_conjunction',
      type: KarmicPatternType.southNode,
      title: 'Güney Düğüm - Ay Kavuşumu',
      pastLifeConnection: '''
Ay kişisi, Güney Düğüm kişisinin geçmiş yaşamda duygusal olarak bağlı
olduğu biriydi. Bu genellikle anne, eş veya bakım veren figürü gösterir.
"Eve dönmek" hissi bu bağlantının karakteristiğidir.

Geçmiş yaşamda güçlü bir duygusal bağ, muhtemelen aile bağı vardı.
Ay kişisi, Güney Düğüm kişisini beslemiş, korumuş ve sevmiştir.
Bu sevgi, yüzlerce yıl sonra bile ruhta yankılanır.
''',
      currentLifeLesson: '''
Bu yaşamda ders, duygusal bağımlılık ve konfor alanından çıkmaktır.
Ay kişisinin yanında her şey tanıdık ve güvenli hissedilir - belki
fazla güvenli. Bu rahatlık, büyümeyi engelleyebilir.

Ders, duygusal güvenliği içsel olarak bulmaktır. Dışarıdan
(Ay kişisinden) gelen beslenmeye bağımlı olmak yerine,
kendi duygusal olgunluğunuzu geliştirmelisiniz.
''',
      healingPath: '''
İyileşme, sağlıklı sınırlar koymak ve kendi duygusal ihtiyaçlarınızı
karşılamayı öğrenmekle gerçekleşir. Ay kişisi hâlâ hayatınızda olabilir
ama rol ve dinamikler değişmelidir.

Pratik olarak: İç çocuk çalışması, anne arketipiyle yüzleşme ve
kendi kendinizi beslenme pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, bağımlılık sevgiye dönüşür.
Artık Ay kişisine ihtiyaç duymak yerine, onu özgürce seversiniz.
İlişki, zorunluluk yerine tercih haline gelir.
''',
      karmaIntensity: 8,
    ),

    KarmicPattern(
      id: 'sn_venus_conjunction',
      type: KarmicPatternType.southNode,
      title: 'Güney Düğüm - Venüs Kavuşumu',
      pastLifeConnection: '''
Venüs kişisi, Güney Düğüm kişisinin geçmiş yaşam aşıkıydı. Bu, en güçlü
"geçmiş yaşam aşkı" göstergelerinden biridir. İlk görüşte aşk,
"onu hep tanıdım" hissi bu bağlantıdan kaynaklanır.

Geçmiş yaşamda derin bir romantik bağ vardı. Bu aşk ya trajik bir şekilde
sona erdi (ölüm, ayrılık, yasak aşk) ya da tamamlanmadan kaldı.
Ruhlar, bu yaşamda "bitirilmemiş işi" tamamlamak için buluşur.
''',
      currentLifeLesson: '''
Bu yaşamda ders, geçmiş aşka takılı kalmamaktır. Venüs kişisi tanıdık
ve çekici hissedilir ama bu çekim evrimsel olmayabilir. Soru şudur:
Bu ilişki sizi ileriye mi götürüyor, yoksa geçmişte mi tutuyor?

Geçmiş yaşam aşıkıyla bu yaşamda da bir ilişki mümkündür ama
dinamikler değişmelidir. Aynı kalıpları tekrarlamak karma yaratır.
''',
      healingPath: '''
İyileşme, geçmiş aşkı onurlandırırken serbest bırakmakla gerçekleşir.
Bu, bazen vedalaşmak, bazen de ilişkiyi yeni bir temele oturtmak demektir.
Her iki durumda da, eski kalıplar bilinçle fark edilmeli ve bırakılmalıdır.

Pratik olarak: Geçmiş yaşam regresyonu, bağ kesme meditasyonları ve
bilinçli affetme pratikleri çok faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, eski aşkın acısı veya özlemi geçer.
Venüs kişisiyle ilişki ya barışla biter ya da tamamen yeni,
karmadan arınmış bir form alır. Kalp özgürleşir.
''',
      karmaIntensity: 9,
    ),

    KarmicPattern(
      id: 'sn_mars_conjunction',
      type: KarmicPatternType.southNode,
      title: 'Güney Düğüm - Mars Kavuşumu',
      pastLifeConnection: '''
Mars kişisi, Güney Düğüm kişisinin geçmiş yaşamda "savaşçı ortağı" veya
rakibiydi. Bu bağlantı yoğun enerji, rekabet ve bazen çatışma getirir.
"Seninle savaştım veya seninle birlikte savaştım" hissi yaygındır.

Geçmiş yaşamda, bu iki ruh arasında güçlü bir aksiyon ve enerji paylaşımı
vardı. Birlikte savaşmış, birlikte inşa etmiş veya birbirleriyle
çatışmış olabilirler. Enerji yoğun ve tanıdıktır.
''',
      currentLifeLesson: '''
Bu yaşamda ders, gücü bilinçle kullanmaktır. Mars kişisi, Güney Düğüm
kişisinin eski güç kalıplarını tetikler. Rekabet, saldırganlık ve
kontrol mücadeleleri yüzeye çıkabilir.

Ders, gücü yıkım yerine yaratım için kullanmaktır. Eski savaşları
tekrarlamak yerine, birlikte yeni şeyler inşa etmek mümkündür.
''',
      healingPath: '''
İyileşme, öfke ve agresyonu dönüştürmekle gerçekleşir. Geçmiş yaşam
çatışmaları affedilmeli, eski düşmanlıklar bırakılmalıdır.
Güç, kontrol etmek yerine güçlendirmek için kullanılmalıdır.

Pratik olarak: Öfke yönetimi, dövüş sanatları (bilinçli güç kullanımı)
ve rekabeti işbirliğine dönüştürme pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, eski savaşlar sona erer.
Mars kişisiyle ilişki, rekabetten ortaklığa dönüşür.
Enerji, yıkım yerine yaratıcı projelere yönlendirilir.
''',
      karmaIntensity: 7,
    ),
  ];

  static const List<KarmicPattern> saturnBonds = [
    KarmicPattern(
      id: 'saturn_sun_conjunction',
      type: KarmicPatternType.saturnBond,
      title: 'Satürn - Güneş Kavuşumu',
      pastLifeConnection: '''
Satürn-Güneş kavuşumu, geçmiş yaşamdan taşınan bir "karmik sözleşme"yi
gösterir. Satürn kişisi, Güneş kişisinin geçmiş yaşamda otoritesi,
öğretmeni veya sorumluluğu olmuş olabilir.

Bu bağlantı genellikle bir "borç" veya "yükümlülük" hissi taşır.
Sanki birbirinize bir şey borçlusunuz gibi - ve bu borç,
bu yaşamda ödenmelidir.
''',
      currentLifeLesson: '''
Bu yaşamda ders, sorumluluk ve olgunluktur. Satürn kişisi, Güneş kişisine
"büyü" der. Bu bazen destekleyici, bazen kısıtlayıcı hissedilebilir.
Önemli olan, bu dersleri bilinçle almaktır.

Ders, bağımlılık yerine karşılıklı sorumluluk geliştirmektir.
Satürn'ün dersleri zor ama değerlidir. Direnç yerine kabul,
daha hızlı ve kolay öğrenmeyi sağlar.
''',
      healingPath: '''
İyileşme, Satürn'ün derslerini kabul etmek ve entegre etmekle gerçekleşir.
Kısıtlamalar, aslında yapıyı sağlayan sınırlardır. Bu sınırlar
içselleştirildiğinde, dışarıdan dayatılmaya gerek kalmaz.

Pratik olarak: Disiplin pratikleri, sorumluluk alma egzersizleri ve
otorite figürleriyle ilişkileri iyileştirme çalışmaları faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, "borç" ödenmiş hissedilir.
Satürn kişisiyle ilişki, baskıdan desteğe dönüşür.
Kısıtlamalar yerini yapıcı sınırlara bırakır.
''',
      karmaIntensity: 9,
    ),

    KarmicPattern(
      id: 'saturn_moon_conjunction',
      type: KarmicPatternType.saturnBond,
      title: 'Satürn - Ay Kavuşumu',
      pastLifeConnection: '''
Satürn-Ay kavuşumu, duygusal boyutta bir karmik sözleşmeyi gösterir.
Satürn kişisi, Ay kişisinin geçmiş yaşamda duygusal olarak
sorumlu olduğu veya duygusal destek vermesi gereken biriydi.

Bu bağlantı genellikle bir "duygusal borç" hissi taşır.
Ay kişisi, Satürn kişisine karşı bir yükümlülük, bir "bakım" sorumluluğu
hissedebilir - bu yaşamda bile.
''',
      currentLifeLesson: '''
Bu yaşamda ders, duygusal olgunluk ve sağlıklı sınırlardır.
Satürn kişisi, Ay kişisinin duygusal dünyasına "ciddiyet" ve "sorumluluk"
getirir. Bu destekleyici veya boğucu olabilir.

Ders, duygusal bağımlılık ile duygusal sorumluluk arasındaki
farkı öğrenmektir. Başkalarının duygusal refahı için sorumluyuz
ama onların yerine duygularını yaşayamayız.
''',
      healingPath: '''
İyileşme, duygusal özerklik geliştirmekle gerçekleşir. Her iki taraf da
kendi duygusal ihtiyaçlarını karşılamayı öğrenmeli, birbirine
bağımlı olmak yerine birbirini desteklemelidir.

Pratik olarak: Duygusal sınır çalışmaları, içsel ebeveynlik ve
duygusal bağımsızlık pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, duygusal yük kalkar.
İlişki, borç yerine sevgi üzerine yeniden kurulur.
Duygusal özgürlük ve karşılıklı destek mümkün olur.
''',
      karmaIntensity: 8,
    ),

    KarmicPattern(
      id: 'saturn_venus_conjunction',
      type: KarmicPatternType.saturnBond,
      title: 'Satürn - Venüs Kavuşumu',
      pastLifeConnection: '''
Satürn-Venüs kavuşumu, aşk alanında bir karmik sözleşmeyi gösterir.
Bu bağlantı genellikle "zorunlu evlilik", "kısıtlanmış aşk" veya
"tamamlanmamış taahhüt" temalarını geçmiş yaşamdan taşır.

Geçmiş yaşamda, bu iki ruh arasında bir aşk vardı ama bu aşk
sosyal, ekonomik veya aile baskıları nedeniyle engellenmiş olabilir.
Ya da bir evlilik vardı ama sevgiden çok görevden kaynaklanıyordu.
''',
      currentLifeLesson: '''
Bu yaşamda ders, sevgi ve sorumluluk arasındaki dengeyi bulmaktır.
Satürn kişisi, Venüs kişisine "ciddiyet" ve "taahhüt" getirir.
Bu destekleyici olabilir ama aşkı "görev" haline de getirebilir.

Ders, aşkı hem özgür hem de taahhütlü yaşamaktır. Ne boş vaatler
ne de duygusuz yükümlülükler - gerçek, olgun bir sevgi.
''',
      healingPath: '''
İyileşme, aşkı ve taahhüdü entegre etmekle gerçekleşir.
Romantik özgürlük ve uzun vadeli bağlılık çelişmek zorunda değildir.
Her ikisini de onurlandıran bir ilişki mümkündür.

Pratik olarak: İlişki taahhütleri üzerine çalışma, sevgi dillerini keşfetme
ve aşkın "koşulsuz" formlarını deneyimleme pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, aşk özgürleşir.
İlişki, görevden zevke dönüşür. Taahhüt, kısıtlama değil
güvenli bir liman haline gelir.
''',
      karmaIntensity: 8,
    ),

    KarmicPattern(
      id: 'saturn_saturn_conjunction',
      type: KarmicPatternType.saturnBond,
      title: 'Satürn - Satürn Kavuşumu',
      pastLifeConnection: '''
İki kişinin Satürnleri aynı burçta olduğunda, aynı karmik dersleri
ve sorumlulukları paylaşırlar. Bu genellikle aynı neslin üyeleri
arasında görülür ve ortak karmik temaları işaret eder.

Bu bağlantı, "aynı sınıfta" olmak gibidir. Aynı dersleri, aynı
zorlukları ve aynı olgunlaşma sürecini paylaşırsınız.
''',
      currentLifeLesson: '''
Bu yaşamda ders, birlikte olgunlaşmaktır. Aynı Satürn burcu,
benzer korku, kısıtlama ve sorumluluk temaları demektir.
Bu ortaklık, dersleri birlikte çalışmayı kolaylaştırır.

Ders, birbirinin olgunlaşma sürecini desteklemek ve
kendi Satürn derslerinizi birlikte entegre etmektir.
''',
      healingPath: '''
İyileşme, Satürn derslerini birlikte çalışmakla hızlanır.
Birbirinizin zorluklarını anlarsınız çünkü aynı zorlukları yaşarsınız.
Bu anlayış, karşılıklı desteğe dönüşebilir.

Pratik olarak: Ortak hedefler belirleme, birlikte disiplin pratikleri
ve karşılıklı hesap verebilirlik sistemleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, bireysel olgunluk tamamlanır.
İlişki, zorunluluk yerine seçim haline gelir.
Satürn'ün dersleri içselleştirilmiş olur.
''',
      karmaIntensity: 7,
    ),
  ];

  static const List<KarmicPattern> plutoObsession = [
    KarmicPattern(
      id: 'pluto_sun_obsession',
      type: KarmicPatternType.plutoObsession,
      title: 'Pluto - Güneş Obsesyon Açısı',
      pastLifeConnection: '''
Pluto-Güneş bağlantısı (özellikle kare ve karşıtlık), geçmiş yaşamdan
taşınan bir güç mücadelesini gösterir. Bu iki ruh arasında bir
"tamamlanmamış güç oyunu" vardır.

Geçmiş yaşamda, biri diğerinin gücünü, kimliğini veya hayatını
kontrol etmiş olabilir. Şimdi, bu dinamik çözülmek için yüzeye çıkar.
''',
      currentLifeLesson: '''
Bu yaşamda ders, gücü sağlıklı kullanmaktır. Pluto kişisi, Güneş kişisi
üzerinde kontrol kurma dürtüsü hissedebilir. Güneş kişisi ya boyun eğer
ya da isyan eder. Her iki tepki de karmayı çözmez.

Ders, gücü paylaşmak ve birbirini güçlendirmektir.
Kontrol yerine karşılıklı güç, sahiplenme yerine özgürleştirme.
''',
      healingPath: '''
İyileşme, güç dinamiklerini bilinçli hale getirmekle başlar.
Kim kontrol ediyor? Kim teslim oluyor? Bu roller neden oluştu?
Bilinçli farkındalık, kalıbı kırmaya yardımcı olur.

Pratik olarak: Güç dengesizliklerini fark etme çalışmaları, kontrol
bırakma meditasyonları ve sağlıklı sınır pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, güç savaşları sona erer.
İlişki, kontrolden ortaklığa dönüşür. Her iki taraf da
kendi gücünü korurken diğerini de güçlendirir.
''',
      karmaIntensity: 10,
    ),

    KarmicPattern(
      id: 'pluto_moon_obsession',
      type: KarmicPatternType.plutoObsession,
      title: 'Pluto - Ay Obsesyon Açısı',
      pastLifeConnection: '''
Pluto-Ay bağlantısı, duygusal boyutta bir geçmiş yaşam güç mücadelesini
gösterir. Bu bağlantı genellikle yoğun duygusal bağımlılık, manipülasyon
veya duygusal kontrol temalarını taşır.

Geçmiş yaşamda, biri diğerinin duygusal dünyasını kontrol etmiş,
manipüle etmiş veya duygusal olarak "yutmuş" olabilir.
''',
      currentLifeLesson: '''
Bu yaşamda ders, duygusal özerklik ve sağlıklı bağlanmadır.
Pluto kişisi, Ay kişisini duygusal olarak "yutma" eğiliminde olabilir.
Ay kişisi, duygusal bağımlılık ve kaybolma riski taşır.

Ders, derin duygusal bağı korurken bireyselliği korumaktır.
İç içe geçmek, birleşmek demek değildir.
''',
      healingPath: '''
İyileşme, duygusal sınırları güçlendirmekle gerçekleşir.
Her iki taraf da kendi duygusal alanını korumalı, birbirinin
duygusal dünyasına saygıyla yaklaşmalıdır.

Pratik olarak: Duygusal sınır çalışmaları, bağımlılık kalıplarını
fark etme ve sağlıklı bağlanma pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, duygusal özgürlük gelir.
Yoğun bağlantı kalır ama boğuculuk gider.
Derin sevgi ve bireysellik bir arada var olur.
''',
      karmaIntensity: 10,
    ),

    KarmicPattern(
      id: 'pluto_venus_obsession',
      type: KarmicPatternType.plutoObsession,
      title: 'Pluto - Venüs Obsesyon Açısı',
      pastLifeConnection: '''
Pluto-Venüs bağlantısı, aşk alanında en yoğun karmik kalıplardan birini
gösterir. Bu bağlantı obsesif tutku, kıskançlık ve sahiplenme
temalarını geçmiş yaşamdan taşır.

Geçmiş yaşamda, bu iki ruh arasında "yıkıcı bir tutku" vardı.
Aşk, kontrole; tutku, sahiplenmeye dönüşmüş olabilir.
Bu kalıp, bu yaşamda çözülmek için tekrar ortaya çıkar.
''',
      currentLifeLesson: '''
Bu yaşamda ders, aşkı ve tutkuyu sağlıklı yaşamaktır.
Pluto-Venüs enerjisi, dünyanın en güçlü aşkını veya en yıkıcı
obsesyonunu yaratabilir. Seçim bilinçli farkındalıktadır.

Ders, sahiplenme olmadan sevmek, kıskançlık olmadan tutku,
kontrol olmadan bağlanmaktır.
''',
      healingPath: '''
İyileşme, aşkı özgürleştirmekle gerçekleşir. Gerçek sevgi, sahiplenme değildir.
Gerçek tutku, kontrol gerektirmez. Güvenlik, kıskançlıktan değil
güvenden gelir.

Pratik olarak: Kıskançlık ve sahiplenme tetiklerini fark etme,
güvensizlik köklerini iyileştirme pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, aşk özgürleşir.
Tutku kalır ama obsesyon gider. Derin çekim kalır ama
kıskançlık ve kontrol ihtiyacı çözülür.
''',
      karmaIntensity: 10,
    ),
  ];

  static const List<KarmicPattern> neptuneIllusion = [
    KarmicPattern(
      id: 'neptune_sun_illusion',
      type: KarmicPatternType.neptuneIllusion,
      title: 'Neptün - Güneş İllüzyon Açısı',
      pastLifeConnection: '''
Neptün-Güneş bağlantısı, geçmiş yaşamdan taşınan aldanma, idealleştirme
veya kaybolma temalarını gösterir. Bu iki ruh arasında bir
"sis perdesi" vardır - her şey net değildir.

Geçmiş yaşamda, biri diğerini aldatmış veya idealleştirmiş olabilir.
Ya da spiritüel bir bağlantı vardı ama dünyevi gerçeklikten kopuktu.
''',
      currentLifeLesson: '''
Bu yaşamda ders, illüzyon ve gerçeklik arasındaki dengeyi bulmaktır.
Neptün kişisi, Güneş kişisini idealleştirme veya aldatma eğiliminde
olabilir. Güneş kişisi gerçek kimliğini kaybedebilir.

Ders, spiritüel bağlantıyı korurken ayakları yere basmaktır.
Rüya güzeldir ama gerçeklikten kopmak tehlikelidir.
''',
      healingPath: '''
İyileşme, netlik ve şeffaflıkla gerçekleşir. Neptün'ün sisi dağıtılmalı,
gerçekler görülmelidir. Bu bazen acı vericidir ama gereklidir.

Pratik olarak: Topraklama pratikleri, gerçeklik kontrolü ve
illüzyonları fark etme çalışmaları faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, gerçeklik netleşir.
İlişki, illüzyon üzerinden değil gerçek üzerinden kurulur.
Spiritüel bağlantı kalır ama yanılsama çözülür.
''',
      karmaIntensity: 7,
    ),

    KarmicPattern(
      id: 'neptune_venus_illusion',
      type: KarmicPatternType.neptuneIllusion,
      title: 'Neptün - Venüs İllüzyon Açısı',
      pastLifeConnection: '''
Neptün-Venüs bağlantısı, aşk alanında aldanma, idealleştirme ve
hayal kırıklığı temalarını taşır. Bu, "peri masalı aşkı" veya
"imkânsız aşk" enerjisidir.

Geçmiş yaşamda, bu iki ruh arasında "gerçek olmayan" bir aşk vardı.
Belki biri diğerini idealize etti, belki de bir aldatma yaşandı.
''',
      currentLifeLesson: '''
Bu yaşamda ders, gerçek ve ideal arasındaki dengeyi bulmaktır.
Neptün-Venüs enerjisi, en romantik aşkı veya en büyük hayal kırıklığını
yaratabilir. Her şey algıya bağlıdır.

Ders, aşkı hem ruhani hem de gerçekçi yaşamaktır.
Pembe gözlükler çıkarılmalı ama romantizm de korunmalıdır.
''',
      healingPath: '''
İyileşme, beklentileri gerçeklikle uyumlu hale getirmekle gerçekleşir.
Mükemmel partner yoktur - ama mükemmel uyum olabilir.
İdealleri bırakmak, gerçek sevgiyi bulmayı mümkün kılar.

Pratik olarak: Beklenti çalışmaları, gerçeklik kontrolü ve
koşulsuz sevgi pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, gerçek aşk görünür olur.
İdealize edilmiş imaj çözülür, gerçek kişi ortaya çıkar.
Ve gerçek kişi, idealize edilmiş versiyondan daha güzel olabilir.
''',
      karmaIntensity: 7,
    ),
  ];

  static const List<KarmicPattern> chironWounds = [
    KarmicPattern(
      id: 'chiron_sun_wound',
      type: KarmicPatternType.chironWound,
      title: 'Chiron - Güneş Yara Tetiklemesi',
      pastLifeConnection: '''
Chiron-Güneş bağlantısı, geçmiş yaşamdan taşınan derin kimlik yaralarını
gösterir. Bu iki ruh arasında bir "yara paylaşımı" vardır.
Biri diğerinin yaralarını tetikler - bazen acı verici bir şekilde.

Geçmiş yaşamda, bu iki ruh arasında bir yara oluşumu veya iyileşme
süreci yaşanmış olabilir. Şimdi, bu yara yeniden işlenmelidir.
''',
      currentLifeLesson: '''
Bu yaşamda ders, yaralar yoluyla şifa bulmaktır. Chiron kişisi,
Güneş kişisinin en derin yaralarını tetikler. Bu acı vericidir
ama aynı zamanda iyileşme fırsatı taşır.

Ders, yaralardan kaçmak yerine onlarla yüzleşmektir.
Tetikleme, iyileşmenin başlangıcıdır.
''',
      healingPath: '''
İyileşme, yarayı kabul etmek ve dönüştürmekle gerçekleşir.
Chiron yaraları asla tam kapanmaz ama bilgeliğe dönüşür.
Bu bilgelik, başkalarını iyileştirme gücü verir.

Pratik olarak: Yara çalışması, terapi, öz-şefkat pratikleri
ve yaralı şifacı arketipini kucaklama faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, yara bilgeliğe dönüşür.
Tetikleme, artık acı vermez - öğretir.
İlişki, yaralama yerine iyileştirme alanı olur.
''',
      karmaIntensity: 8,
    ),

    KarmicPattern(
      id: 'chiron_venus_wound',
      type: KarmicPatternType.chironWound,
      title: 'Chiron - Venüs Yara Tetiklemesi',
      pastLifeConnection: '''
Chiron-Venüs bağlantısı, aşk alanında derin yaraları gösterir.
Bu bağlantı, geçmiş yaşam kırık kalpleri, reddedilmeleri ve
"sevilmeye layık değilim" inançlarını taşır.

Geçmiş yaşamda, aşk yoluyla bir yara oluşmuş olabilir.
Terk edilme, ihanet veya karşılıksız aşk temaları yaygındır.
''',
      currentLifeLesson: '''
Bu yaşamda ders, aşk yaralarını iyileştirmektir. Chiron kişisi,
Venüs kişisinin aşk yaralarını tetikler. "Sevilmiyorum",
"Reddedileceğim" korkuları yüzeye çıkar.

Ders, sevilmeye layık olduğunuzu bilmek ve kabul etmektir.
Yara, sevginin yokluğundan değil, sevginin yanlış anlaşılmasından doğar.
''',
      healingPath: '''
İyileşme, öz-sevgiyi geliştirmekle başlar. Dışarıdan gelen sevgi
ne kadar çok olursa olsun, içeride bir yara varsa hissedilemez.
Önce kendinizi sevmeyi öğrenmelisiniz.

Pratik olarak: Öz-sevgi meditasyonları, değersizlik inançlarını
çalışma ve koşulsuz kabul pratikleri faydalıdır.
''',
      karmaRelease: '''
Karma serbest bırakıldığında, aşk yarası iyileşir.
Sevilmeye layık olduğunuzu bilirsiniz - hissedersiniz.
İlişki, yara yerine şifa alanı olur.
''',
      karmaIntensity: 9,
    ),
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// 4. TANTRİK UYUM (TANTRIC COMPATIBILITY)
// ════════════════════════════════════════════════════════════════════════════

class TantricCompatibilityContent {
  static const String introduction = '''
Tantra, Sanskritçe'de "dokuma" veya "genişletme" anlamına gelir.
Tantrik astroloji, iki ruhun enerji bedenlerinin nasıl etkileştiğini,
kundalini enerjisinin nasıl aktive olduğunu ve kutsal birliğin
astrolojik temellerini inceler.

Tantrik uyum, sadece fiziksel çekim değildir. Bu, enerji bedenlerinin
rezonansı, çakraların uyumu ve ruhsal alev alışverişidir.
Gerçek tantrik birlik, iki bedeni aşar ve kozmik bilince ulaşır.

Tantrik uyumun astrolojik göstergeleri:
• Mars-Venüs enerji alışverişi - Eril ve dişil enerjilerin dansı
• 8. ev bağlantıları - Cinsel ve dönüşümsel enerji
• Kundalini aktivasyonu - Ateş işaretleri ve Mars bağlantıları
• Çakra uyumu - Burç elementleri ve gezegen enerjileri
• Kutsal birlik potansiyeli - Güneş-Ay ve Yükselen uyumu
''';

  static const List<TantricCompatibility> marsVenusExchange = [
    TantricCompatibility(
      id: 'mars_venus_fire',
      title: 'Ateş Mars - Ateş Venüs Alışverişi',
      energyExchange: '''
Her iki gezegenin de ateş burçlarında (Koç, Aslan, Yay) olması,
patlamaya hazır bir enerji yaratır. Bu çift "tutuşur" - hemen
ve yoğun. Tutku fiziksel, anlık ve yakıcıdır.

Enerji alışverişi hızlı ve yoğundur. Sakınma veya yavaşlama yoktur.
Her iki taraf da "şimdi ve burada" enerjisiyle yanar.
''',
      kundaliniActivation: '''
Ateş-ateş kombinasyonu, kundalini enerjisini hızlıca yükseltir.
Muladhara (kök) çakradan başlayan enerji, hızla yukarı tırmanır.
Bu aktivasyon güçlüdür ama kontrol gerektirir.

Dikkat: Enerji çok hızlı yükselirse, baş dönmesi, sıcak basması
veya duygusal dengesizlik yaşanabilir. Topraklama önemlidir.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli yüksektir ama sabır gerektirir.
Ateş-ateş çiftleri hemen zirveye ulaşmak ister. Tantrik pratik,
yavaşlamayı ve enerjiyi biriktirmeyi öğretir.

Potansiyel: Eğer enerji bilinçle yönetilirse, bu çift kozmik
bilince ulaşabilir. Aksi halde, hızlı yanış ve tükenme riski.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Nefes senkronizasyonu - Hızlı enerjiyi yavaşlatmak için
• Göz teması meditasyonu - Enerjinin üst çakralara yükselmesi için
• Topraklama ritüelleri - Her pratik öncesi ve sonrası
• Enerji biriktirme teknikleri - Hemen boşalmak yerine bekletme
''',
      alchemyLevel: 9,
    ),

    TantricCompatibility(
      id: 'mars_venus_water',
      title: 'Su Mars - Su Venüs Alışverişi',
      energyExchange: '''
Her iki gezegenin de su burçlarında (Yengeç, Akrep, Balık) olması,
derin duygusal ve psişik bir bağlantı yaratır. Bu çift "erir" -
birbirlerinin içinde kaybolurlar.

Enerji alışverişi yavaş, derin ve sınırsızdır. Fiziksel boyutun
ötesine geçerek, duygusal ve ruhsal birleşme gerçekleşir.
''',
      kundaliniActivation: '''
Su-su kombinasyonu, kundalini enerjisini duygusal ve psişik kanallarda
aktive eder. Anahtar çakra Svadhisthana (sakral) ve Ajna (üçüncü göz).

Bu aktivasyon, vizyon deneyimleri, telepatik bağlantı ve
astral seyahat potansiyeli taşır. Duygusal yoğunluk çok güçlüdür.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli çok yüksektir. Su-su çiftleri doğal olarak
sınırları eritir ve bir olur. Tantrik birlik, bu çift için
neredeyse otomatik bir deneyimdir.

Potansiyel: Derin mistik birleşme, ruhsal aşk ve kozmik erişim.
Risk: Kaybolma, sınır kaybı ve kimlik erimesi.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Birlikte meditasyon - Ruhsal bağlantıyı derinleştirmek için
• Sular altında pratik - Yüzme, banyo ritüelleri
• Rüya çalışması - Birlikte rüya görme ve paylaşma
• Duygusal şeffaflık - Her duyguyu paylaşma pratiği
''',
      alchemyLevel: 10,
    ),

    TantricCompatibility(
      id: 'mars_venus_earth',
      title: 'Toprak Mars - Toprak Venüs Alışverişi',
      energyExchange: '''
Her iki gezegenin de toprak burçlarında (Boğa, Başak, Oğlak) olması,
yavaş, derin ve duyusal bir bağlantı yaratır. Bu çift "tattırır" -
her anın tadını çıkarırlar.

Enerji alışverişi yavaş ve ayrıntılıdır. Acele yoktur, her dokunuş
hissedilir, her an yaşanır. Bedensel farkındalık çok yüksektir.
''',
      kundaliniActivation: '''
Toprak-toprak kombinasyonu, kundalini enerjisini bedensel ve fiziksel
kanallarda aktive eder. Anahtar çakra Muladhara (kök).

Bu aktivasyon yavaş ama sağlamdır. Enerji bedenin her hücresine
nüfuz eder. Derin topraklanma ve fiziksel uyanış deneyimlenir.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli yüksektir ama sabır gerektirir.
Toprak-toprak çiftleri koşmaz - yürür. Tantrik yolculuk,
bu çift için uzun ama çok tatmin edici olabilir.

Potansiyel: Derin bedensel uyanış ve fiziksel aşkınlık.
Risk: Rutine düşme ve enerjiyi sadece fiziksel seviyede tutma.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Yavaş dokunuş meditasyonu - Her dokunuşu tam hissetme
• Yemek ritüelleri - Birlikte hazırlama ve besleme
• Doğa pratikleri - Toprakta çıplak ayakla yürüme
• Masaj ve beden çalışması - Fiziksel farkındalık geliştirme
''',
      alchemyLevel: 8,
    ),

    TantricCompatibility(
      id: 'mars_venus_air',
      title: 'Hava Mars - Hava Venüs Alışverişi',
      energyExchange: '''
Her iki gezegenin de hava burçlarında (İkizler, Terazi, Kova) olması,
zihinsel ve iletişimsel bir bağlantı yaratır. Bu çift "konuşur" -
kelimeler, fikirler ve fanteziler paylaşılır.

Enerji alışverişi zihinsel ve yaratıcıdır. Düşünceler, fanteziler
ve fikirler enerjinin taşıyıcısıdır. Sözel oyunlar ve rol yapma.
''',
      kundaliniActivation: '''
Hava-hava kombinasyonu, kundalini enerjisini zihinsel ve yaratıcı
kanallarda aktive eder. Anahtar çakra Vishuddha (boğaz) ve Ajna.

Bu aktivasyon, yaratıcı ilham, telepatik iletişim ve
zihinsel genişleme deneyimleri yaratır.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli zihinden başlar ve oradan genişler.
Hava-hava çiftleri için tantrik pratik, düşüncenin ötesine
geçmeyi öğrenmek demektir - bu zorlayıcı olabilir.

Potansiyel: Zihinsel birleşme ve yaratıcı sinerji.
Risk: Sadece zihinde kalma, bedensel boyutu ihmal etme.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Sessizlik pratiği - Düşüncenin ötesine geçme
• Nefes çalışması - Zihni sakinleştirme
• Yaratıcı görselleştirme - Birlikte hayal kurma
• Sözsüz iletişim - Bedeni konuşturma
''',
      alchemyLevel: 7,
    ),

    TantricCompatibility(
      id: 'mars_venus_cross',
      title: 'Çapraz Element Alışverişi (Ateş-Su, Toprak-Hava)',
      energyExchange: '''
Mars ve Venüs farklı, çapraz elementlerde olduğunda (örn. Mars ateşte,
Venüs suda), zıtlıkların dansı başlar. Bu çift "dönüştürür" -
birbirlerini değiştirir.

Enerji alışverişi karmaşık ve dönüştürücüdür. Zıtlıklar birbirini
nötralize etmez, aksine yeni bir sentez yaratır.
''',
      kundaliniActivation: '''
Çapraz element kombinasyonu, kundalini enerjisini sıra dışı yollarla
aktive eder. Enerji, beklenmedik çakralarda ve kanallarda hareket eder.

Bu aktivasyon sürpriz ve dönüşüm getirir. Alışılmadık deneyimler,
beklenmedik açılımlar ve radikal değişimler mümkündür.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli, zıtlıkların entegrasyonunda yatar.
Bu çift, "birlik farklılıkta" prensibini somutlaştırır.
Kutsal evlilik (hieros gamos) arketipi burada güçlüdür.

Potansiyel: Zıtlıkların birleşimi yoluyla bütünlük.
Risk: Anlaşmazlık ve enerji çatışması.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Element dengeleme ritüelleri - Dört elementin onurlandırılması
• Nefes ve hareket kombinasyonu - Zıtlıkları birleştirme
• Yin-Yang meditasyonu - Zıtlıkların dansını izleme
• Enerji dönüşüm pratikleri - Bir enerjiyi diğerine çevirme
''',
      alchemyLevel: 9,
    ),
  ];

  static const List<TantricCompatibility> eighthHouseTantric = [
    TantricCompatibility(
      id: '8h_sun_tantric',
      title: '8. Ev Güneş Bağlantısı - Tantrik Dönüşüm',
      energyExchange: '''
Bir kişinin Güneşi diğerinin 8. evine düştüğünde, tantrik dönüşümün
kapıları açılır. 8. ev, cinsellik, ölüm ve yeniden doğuşun evidir.
Güneş burada parladığında, her şey dönüşür.

Enerji alışverişi derin ve radikal. Yüzeysellik imkânsızdır.
Her karşılaşma, bir ölüm ve yeniden doğuş deneyimidir.
''',
      kundaliniActivation: '''
8. ev Güneş bağlantısı, kundalini enerjisini güçlü ve radikal bir şekilde
aktive eder. Enerji, kök çakradan taç çakraya kadar tüm sistemi etkiler.

Bu aktivasyon ego ölümü ve spiritüel yeniden doğuş getirebilir.
Dikkat: Yoğunluk bunaltıcı olabilir. Rehberlik önerilir.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli maksimum seviyededir. 8. ev,
kutsal birliğin en derin formlarının deneyimlendiği yerdir.
Bu çift, gerçek tantrik aşkınlığı yaşama potansiyeline sahiptir.

Potansiyel: Tam ego çözülmesi ve kozmik birlik.
Risk: Kontrol kaybı, obsesyon ve yıkıcı dinamikler.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Deneyimli bir öğretmenle çalışma - Bu enerji rehberlik gerektirir
• Ego çalışması - Teslimiyete hazırlık
• Ölüm meditasyonları - Bırakma pratiği
• Güvenli alan oluşturma - Sınırlar içinde derinlik
''',
      alchemyLevel: 10,
    ),

    TantricCompatibility(
      id: '8h_mars_tantric',
      title: '8. Ev Mars Bağlantısı - Cinsel Ateş',
      energyExchange: '''
Bir kişinin Marsı diğerinin 8. evine düştüğünde, cinsel enerji
volkanik boyutlara ulaşır. Bu, sinastride en güçlü cinsel çekim
göstergelerinden biridir.

Enerji alışverişi yoğun, tutkulu ve bazen kontrolsüz.
Mars'ın ateşi 8. evin derin sularında buharlaşır.
''',
      kundaliniActivation: '''
8. ev Mars bağlantısı, kundalini enerjisini özellikle cinsel kanalda
güçlü aktive eder. Enerji, kök ve sakral çakralarda yoğunlaşır.

Bu aktivasyon, yoğun orgazmik deneyimler, enerji patlamaları ve
fiziksel dönüşüm getirebilir. Güvenlik önemlidir.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli çok yüksektir ama bilinç gerektirir.
Bu enerji, ya kutsal birliğe ya da karşılıklı yıkıma götürür.
Aradaki fark, bilinçli farkındalık ve niyettir.

Potansiyel: Cinsel enerji yoluyla kozmik birlik.
Risk: Obsesyon, şiddet ve enerji tükenmesi.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Enerji sınırlandırma - Güvenli alan oluşturma
• Nefes kontrolü - Enerjiyi yönetme
• Kutsal niyet belirleme - Her karşılaşmadan önce
• Soğutma pratikleri - Enerji çok yükseldiğinde
''',
      alchemyLevel: 10,
    ),

    TantricCompatibility(
      id: '8h_pluto_tantric',
      title: '8. Ev Pluto Bağlantısı - Derin Simya',
      energyExchange: '''
Bir kişinin Plutosu diğerinin 8. evine düştüğünde, simyanın
en derin formu aktive olur. Pluto evinde güçlüdür ve
dönüşüm kaçınılmazdır.

Enerji alışverişi, sözcüklerin ötesindedir. Bu, hücresel düzeyde
bir yeniden programlama, ruhsal bir başkalaşımdır.
''',
      kundaliniActivation: '''
8. ev Pluto bağlantısı, kundalini enerjisinin en yoğun ve en derin
aktivasyonunu tetikleyebilir. Bu, "küçük ölüm"den (la petite mort)
"büyük ölüm"e (ego ölümü) uzanan bir spektrumdur.

Bu aktivasyon, tam bir yeniden doğuş getirebilir. Dikkat: Sadece
hazır ruhlar için uygundur. Rehberlik şarttır.
''',
      sacredUnionPotential: '''
Kutsal birlik potansiyeli en yüksek seviyededir. Bu bağlantı,
tantrik öğretilerin en derin hedefine - tam birleşme ve
kozmik bilince erişime - ulaşma potansiyeli taşır.

Potansiyel: Tam dönüşüm ve kozmik birlik.
Risk: Psişik kırılma, kontrolsüz dönüşüm ve obsesyon.
''',
      practiceRecommendation: '''
Önerilen pratikler:
• Deneyimli tantrik öğretmenle uzun süreli çalışma
• Psikolojik hazırlık - Gölge çalışması
• Adım adım ilerleme - Acele etmeme
• Entegrasyon süreci - Her deneyimden sonra
''',
      alchemyLevel: 10,
    ),
  ];

  static const List<ChakraCompatibility> chakraBySign = [
    // KÖK ÇAKRA (Muladhara)
    ChakraCompatibility(
      chakra: ChakraType.root,
      signPair: 'Koç - Koç',
      harmonyDescription: '''
İki Koç burcu bir arada, kök çakrada yoğun enerji yaratır.
Hayatta kalma içgüdüsü, fiziksel güç ve topraklanma çok güçlü.
Birlikte, dünyada sağlam bir temel oluştururlar.
''',
      activationMethod: '''
Aktivasyon için: Birlikte fiziksel aktiviteler (koşu, dövüş sanatları),
kırmızı giyinme, toprakta çıplak ayakla yürüme, kök sebzeler yeme,
"LAM" mantrasını birlikte söyleme.
''',
      blockageWarning: '''
Blokaj belirtileri: Güvensizlik, korku, rekabet. İki Koç arasında
güç savaşı kök çakrayı bloke edebilir. Çözüm: İşbirliği ve
birbirini destekleme pratiği.
''',
      resonanceLevel: 9,
    ),

    ChakraCompatibility(
      chakra: ChakraType.root,
      signPair: 'Oğlak - Boğa',
      harmonyDescription: '''
Oğlak ve Boğa, toprak işaretleri olarak kök çakrada doğal uyum içindedir.
Maddi güvenlik, fiziksel konfor ve dünyevi başarı ortak temalardır.
Birlikte, sağlam ve kalıcı bir temel inşa ederler.
''',
      activationMethod: '''
Aktivasyon için: Birlikte finansal planlama, ev kurma projeleri,
bahçecilik, doğa yürüyüşleri, toprak elementli yiyecekler,
masaj ve bedensel çalışma.
''',
      blockageWarning: '''
Blokaj belirtileri: Aşırı maddecilik, tutuculuk, değişime direnç.
Bu çift, güvenliği o kadar çok arayabilir ki sıkışmış hissedebilir.
Çözüm: Ara sıra risk alma ve yenilik.
''',
      resonanceLevel: 8,
    ),

    // SAKRAL ÇAKRA (Svadhisthana)
    ChakraCompatibility(
      chakra: ChakraType.sacral,
      signPair: 'Akrep - Yengeç',
      harmonyDescription: '''
Akrep ve Yengeç, su işaretleri olarak sakral çakrada derin bağ kurar.
Duygusal ve cinsel enerji iç içe geçer. Yaratıcılık ve tutku güçlü.
Birlikte, duygusal derinlik ve fiziksel yakınlık deneyimlerler.
''',
      activationMethod: '''
Aktivasyon için: Su ritüelleri (birlikte yüzme, banyo), turuncu giyme,
yaratıcı projeler (resim, müzik, dans), duygusal paylaşım seansları,
"VAM" mantrasını birlikte söyleme.
''',
      blockageWarning: '''
Blokaj belirtileri: Duygusal manipülasyon, kıskançlık, bağımlılık.
Bu çiftin derinliği, bazen zehirli olabilir.
Çözüm: Sağlıklı sınırlar ve bireysel alan.
''',
      resonanceLevel: 10,
    ),

    ChakraCompatibility(
      chakra: ChakraType.sacral,
      signPair: 'Balık - Akrep',
      harmonyDescription: '''
Balık ve Akrep, sakral çakrada mistik ve derin bir bağ kurar.
Yaratıcılık, sezgi ve cinsellik spiritüel boyutlar kazanır.
Birlikte, fiziksel dünyayı aşan deneyimler yaşarlar.
''',
      activationMethod: '''
Aktivasyon için: Birlikte meditasyon, sanat terapisi, müzik dinleme,
su elementli ritüeller, tantrik pratikler, rüya çalışması,
ayışığında ritüeller.
''',
      blockageWarning: '''
Blokaj belirtileri: Gerçeklikten kopuş, kaçış mekanizmaları, bağımlılık.
Bu çift, dünyadan tamamen kopma riski taşır.
Çözüm: Topraklama ve günlük yaşam rutinleri.
''',
      resonanceLevel: 10,
    ),

    // SOLAR PLEKSUS ÇAKRA (Manipura)
    ChakraCompatibility(
      chakra: ChakraType.solarPlexus,
      signPair: 'Aslan - Yay',
      harmonyDescription: '''
Aslan ve Yay, ateş işaretleri olarak solar pleksusta güçlü rezonans kurar.
Güç, özgüven ve coşku birlikte parlar. Yaratıcı ifade ve liderlik güçlü.
Birlikte, dünyayı aydınlatan bir güç oluştururlar.
''',
      activationMethod: '''
Aktivasyon için: Birlikte sahne alma, liderlik projeleri, sarı giyme,
güneş banyosu, ateş ritüelleri, nefes çalışması (Kapalabhati),
"RAM" mantrasını birlikte söyleme.
''',
      blockageWarning: '''
Blokaj belirtileri: Ego savaşları, kibir, aşırı özgüven.
Bu çift, birbirinin parlaklığını gölgeleyebilir.
Çözüm: Karşılıklı takdir ve alçakgönüllülük.
''',
      resonanceLevel: 9,
    ),

    // KALP ÇAKRA (Anahata)
    ChakraCompatibility(
      chakra: ChakraType.heart,
      signPair: 'Terazi - İkizler',
      harmonyDescription: '''
Terazi ve İkizler, hava işaretleri olarak kalp çakrasında hafif ve akıcı
bir bağ kurar. İletişim yoluyla sevgi, anlayış yoluyla bağlanma.
Birlikte, sevginin entelektüel ve sosyal boyutlarını keşfederler.
''',
      activationMethod: '''
Aktivasyon için: Derin konuşmalar, birlikte yazı yazma, yeşil giyme,
doğa yürüyüşleri, nefes çalışması (kalbi açan pranayama),
"YAM" mantrasını birlikte söyleme.
''',
      blockageWarning: '''
Blokaj belirtileri: Yüzeysellik, duygusal mesafe, rasyonalizasyon.
Bu çift, duyguları düşünceye dönüştürerek hissetmekten kaçabilir.
Çözüm: Sessiz kalp meditasyonu ve dokunuş.
''',
      resonanceLevel: 7,
    ),

    ChakraCompatibility(
      chakra: ChakraType.heart,
      signPair: 'Yengeç - Balık',
      harmonyDescription: '''
Yengeç ve Balık, su işaretleri olarak kalp çakrasında derin ve
koşulsuz bir sevgi kurar. Empati, şefkat ve duygusal beslenme güçlü.
Birlikte, sevginin en derin formlarını deneyimlerler.
''',
      activationMethod: '''
Aktivasyon için: Bakım ritüelleri, birlikte yemek hazırlama,
ev ortamını güzelleştirme, hayvan sevgisi, yardım aktiviteleri,
kalp meditasyonu ve kucaklaşma.
''',
      blockageWarning: '''
Blokaj belirtileri: Aşırı verme, kendini kaybetme, ortak bağımlılık.
Bu çift, birbirinin içinde kaybolabilir.
Çözüm: Bireysel sınırları koruma.
''',
      resonanceLevel: 9,
    ),

    // BOĞAZ ÇAKRA (Vishuddha)
    ChakraCompatibility(
      chakra: ChakraType.throat,
      signPair: 'İkizler - Kova',
      harmonyDescription: '''
İkizler ve Kova, hava işaretleri olarak boğaz çakrasında mükemmel
iletişim kurar. Fikirler, kelimeler ve konseptler özgürce akar.
Birlikte, yaratıcı ve yenilikçi iletişim deneyimlerler.
''',
      activationMethod: '''
Aktivasyon için: Derin konuşmalar, birlikte yazı/blog/podcast yapma,
mavi giyme, şarkı söyleme, "HAM" mantrasını birlikte söyleme,
sesli meditasyon ve mantra çalışması.
''',
      blockageWarning: '''
Blokaj belirtileri: Aşırı konuşma, dinlememe, entellektüel kibir.
Bu çift, konuşmak yerine iletişim kurmayı öğrenmeli.
Çözüm: Aktif dinleme pratiği ve sessizlik.
''',
      resonanceLevel: 9,
    ),

    // ÜÇÜNCÜ GÖZ ÇAKRA (Ajna)
    ChakraCompatibility(
      chakra: ChakraType.thirdEye,
      signPair: 'Akrep - Balık',
      harmonyDescription: '''
Akrep ve Balık, su işaretleri olarak üçüncü göz çakrasında derin
psişik bağlantı kurar. Sezgi, telepati ve mistik deneyimler güçlü.
Birlikte, görünmeyen alemleri keşfederler.
''',
      activationMethod: '''
Aktivasyon için: Birlikte meditasyon, rüya paylaşımı, indigo giyme,
ay ritüelleri, tarot/astroloji çalışması, "OM" veya "AUM" mantrasını
birlikte söyleme, üçüncü göz masajı.
''',
      blockageWarning: '''
Blokaj belirtileri: Paranoya, aşırı psişik duyarlılık, gerçeklikten kopuş.
Bu çift, fiziksel dünyayı ihmal edebilir.
Çözüm: Topraklama ve günlük yaşam rutinleri.
''',
      resonanceLevel: 10,
    ),

    // TAÇ ÇAKRA (Sahasrara)
    ChakraCompatibility(
      chakra: ChakraType.crown,
      signPair: 'Yay - Balık',
      harmonyDescription: '''
Yay ve Balık, taç çakrasında spiritüel ve kozmik bağlantı kurar.
İnanç, anlam arayışı ve transandans ortak temalardır.
Birlikte, kozmik bilince doğru yolculuk ederler.
''',
      activationMethod: '''
Aktivasyon için: Birlikte ibadet veya spiritüel pratik, mor/beyaz giyme,
sessiz meditasyon, oruç, doğada sessizlik, "OM" mantrasını
birlikte söyleme, taç çakra meditasyonu.
''',
      blockageWarning: '''
Blokaj belirtileri: Spiritüel ego, dünyadan kopuş, "yüksekte takılma".
Bu çift, yeryüzü görevlerini ihmal edebilir.
Çözüm: Hizmet ve topraklama pratikleri.
''',
      resonanceLevel: 9,
    ),
  ];

  static const String kundaliniSynastry = '''
KUNDALİNİ SİNASTRİSİ

Kundalini enerjisi, omurganın tabanında uyuyan kozmik güçtür. İkiz alevler
veya derin tantrik partnerler bir araya geldiğinde, bu enerji spontan
olarak uyanabilir. Bu deneyim, dönüştürücü ama aynı zamanda zorlu olabilir.

MARS-MARS BAĞLANTILARI:
• Kavuşum: Patlamaya hazır kundalini enerjisi. Anında ve yoğun.
• Karşıtlık: Manyetik çekim, enerji çekme-itme dinamiği.
• Kare: Sürtüşme yoluyla aktivasyon, "yangın" potansiyeli.
• Trigon: Uyumlu enerji akışı, doğal kundalini yükselişi.

PLUTO-MARS BAĞLANTILARI:
• Kavuşum: En güçlü kundalini aktivasyonu. Dikkat gerektirir.
• Karşıtlık: Güç savaşı veya tam teslimiyet. Ortası yok.
• Kare: Zorlayıcı dönüşüm, direniş yoluyla uyanış.

URANÜS-MARS BAĞLANTILARI:
• Kavuşum: Elektriklenmiş kundalini, ani uyanışlar.
• Karşıtlık: Öngörülemeyen enerji dalgalanmaları.
• Kare: Şok dalgaları ve ani değişimler.

UYARI İŞARETLERİ:
- Kontrolsüz enerji patlamaları
- Fiziksel semptomlar (sıcak basması, titreme, baş ağrısı)
- Duygusal dengesizlik
- Uyku bozuklukları
- Psişik aşırı duyarlılık

GÜVENLİK ÖNLEMLERİ:
1. Deneyimli bir öğretmen veya rehberle çalışın
2. Enerji çok yükselirse topraklama yapın
3. Adım adım ilerleyin, acele etmeyin
4. Entegrasyon için zaman tanıyın
5. Fiziksel ve psikolojik sağlığınızı koruyun
''';

  static const String sacredUnionIndicators = '''
KUTSAL BİRLİK POTANSİYELİ GÖSTERGELERİ

Kutsal birlik (Hieros Gamos), astrolojide ve ezoterik öğretilerde
eril ve dişil prensiplerin tam birleşimini temsil eder.
Aşağıdaki göstergeler, bu birliğin potansiyelini işaret eder:

BİRİNCİL GÖSTERGELER:
1. Güneş-Ay kavuşumu veya karşıtlığı (en güçlü gösterge)
2. Mars-Venüs kavuşumu (eril-dişil birleşimi)
3. Kuzey Düğüm bağlantıları (karmik kader)
4. Yükselen-Yükselen veya Güneş-Yükselen eşleşmesi

İKİNCİL GÖSTERGELER:
1. Juno-Güneş veya Juno-Ay kavuşumu (evlilik asteroidi)
2. Vertex bağlantıları (kader noktası)
3. 7. ev yöneticisi bağlantıları (partner evi)
4. Chiron bağlantıları (yaralı şifacı birliği)

DESTEKLEYİCİ GÖSTERGELER:
1. Aynı element ağırlığı (ateş-ateş, su-su, vb.)
2. Tamamlayıcı modatile (kardinal-sabit, sabit-değişken)
3. Harmonik açı baskınlığı (trigon, sekstil)
4. Karşılıklı resepsiyon (gezegen değişimi)

KUTSAL BİRLİK İÇİN GEREKLİLİKLER:
1. Bireysel bütünlük - Her iki taraf da "tam" olmalı
2. Bilinçli farkındalık - Kalıpları görmek ve aşmak
3. Karşılıklı saygı - Birbirinin yolculuğunu onurlandırma
4. Spiritüel pratik - Birlikte büyüme taahhüdü
5. Gölge entegrasyonu - Karanlık yönleri kabul etme

KUTSAL BİRLİĞİN AŞAMALARI:
1. Tanıma - İlk karşılaşma ve çekim
2. Aynalama - Birbirini yansıtma ve tetikleme
3. Kaos - Ego ölümü ve yeniden yapılanma
4. Teslimiyet - Kontrol bırakma ve güven
5. Birleşme - Kutsal evlilik ve bir olma
''';
}

// ════════════════════════════════════════════════════════════════════════════
// 5. KOMPOZİT HARİTA EZOTERİKLERİ (COMPOSITE CHART ESOTERICS)
// ════════════════════════════════════════════════════════════════════════════

class CompositeChartEsoterics {
  static const String introduction = '''
Kompozit harita, iki kişinin doğum haritalarının orta noktalarından
oluşturulan üçüncü bir haritadır. Bu harita, ilişkinin kendisinin
"doğum haritası"dır - ilişkinin kendi ruhu, kaderi ve potansiyeli vardır.

Ezoterik açıdan kompozit harita, iki ruhun birleşiminden doğan
"üçüncü varlığı" temsil eder. Bu varlık, iki partnerin toplamından
fazlasıdır - kendi özü, kendi amacı ve kendi yolculuğu vardır.

Kompozit harita okurken şunlara bakılır:
• Güneş - İlişkinin temel kimliği ve amacı
• Ay - İlişkinin duygusal doğası
• Yükselen - İlişkinin dünyaya nasıl göründüğü
• Ev yerleşimleri - İlişkinin hangi alanlarda aktif olduğu
• Açılar - İlişkinin iç dinamikleri
''';

  static const List<CompositeEsoteric> compositePlacements = [
    CompositeEsoteric(
      id: 'composite_sun_1h',
      title: 'Kompozit Güneş 1. Evde',
      soulPurpose: '''
Bu ilişkinin ruh amacı, bireyselliği ve kimliği birlikte keşfetmektir.
İlişki, her iki partnerin de kim olduklarını daha net görmelerine
yardımcı olur. "Seninle birlikte kendimi daha iyi tanıyorum."

Bu çift, dünyada belirgin ve görünür olma eğilimindedir. İlişki,
başkalarına ilham veren bir "örnek" veya "model" olabilir.
''',
      karmicLesson: '''
Karmik ders, ego ve ortaklık arasında denge kurmaktır.
Kim daha görünür? Kim liderlik ediyor? Bu sorular, karşılıklı
saygı ve takdir ile yanıtlanmalıdır.

Eski kalıp: Ego savaşları ve dikkat çekme rekabeti.
Yeni öğrenme: Birlikte parlamak, birbirini yükseltmek.
''',
      evolutionPath: '''
Evrim yolu, bireysel kimliği korurken "biz" bilinci geliştirmektir.
Bu ilişki, her iki tarafı da daha özgün ve otantik olmaya iter.
Maske düşer, gerçek ben ortaya çıkar.

Zaman içinde: Bireysellikten ortaklığa, rekabetten işbirliğine,
ego'dan ortak amaça doğru evrilme.
''',
      shadowWork: '''
Gölge çalışması, dikkat ve tanınma ihtiyacıyla yüzleşmeyi içerir.
Neden görünür olmak bu kadar önemli? Dikkat almadığınızda ne hissediyorsunuz?
Birbirinizin gölgesinde olmak ne anlama geliyor?

Sorular:
• Birbirinizin parlamasına izin verebiliyor musunuz?
• Dikkat için rekabet ediyor musunuz?
• "Biz" kimliği "ben" kimliğini eziyor mu?
''',
    ),

    CompositeEsoteric(
      id: 'composite_sun_7h',
      title: 'Kompozit Güneş 7. Evde',
      soulPurpose: '''
Bu ilişkinin ruh amacı, ortaklık ve denge yoluyla büyümektir.
7. ev, ilişkinin doğal evidir. Güneş burada parladığında,
ortaklık hayatın merkezindedir.

Bu çift, birlikte olmak için yaratılmış gibi hisseder. "Biz" bilinci
güçlüdür ve ilişki, her iki tarafın da hayatının odak noktası olur.
''',
      karmicLesson: '''
Karmik ders, bağımlılık ve karşılıklı bağlılık arasındaki farkı
öğrenmektir. Bu çift, birbirlerine o kadar bağlı olabilir ki
bireyselliği kaybetme riski taşır.

Eski kalıp: Birbirini tamamlama ihtiyacı, eksiklik hissi.
Yeni öğrenme: Tam olarak bir araya gelmek, birbirini zenginleştirmek.
''',
      evolutionPath: '''
Evrim yolu, denge ve uyum ustası olmaktır. Bu ilişki, diplomatik
beceriler, uzlaşma sanatı ve "biz" düşüncesi geliştirmeyi öğretir.

Zaman içinde: Bağımlılıktan karşılıklı bağlılığa, ihtiyaçtan sevgiye,
tamamlanma arayışından bütünlük paylaşımına evrilme.
''',
      shadowWork: '''
Gölge çalışması, tek başınalık korkusu ve kimlik kaybıyla yüzleşmeyi içerir.
Birbiriniz olmadan kim olursunuz? Bireysel kimliğinizi koruyor musunuz?

Sorular:
• Birbiriniz olmadan var olabilir misiniz?
• Bireysel ihtiyaçlarınızı feda ediyor musunuz?
• "Biz" için "ben"i kaybediyor musunuz?
''',
    ),

    CompositeEsoteric(
      id: 'composite_sun_8h',
      title: 'Kompozit Güneş 8. Evde',
      soulPurpose: '''
Bu ilişkinin ruh amacı, derin dönüşüm ve yeniden doğuştur.
8. ev, ölüm ve yeniden doğuşun evidir. Güneş burada parladığında,
ilişki radikal bir değişim aracı olur.

Bu çift, birlikte olduğunda her şeyin değiştiğini hisseder. Eski
kimlikler ölür, yeni benlikler doğar. Yüzeysellik imkânsızdır.
''',
      karmicLesson: '''
Karmik ders, kontrol ve teslimiyet arasında denge kurmaktır.
8. ev güç dinamikleriyle ilişkilidir. Kim kontrol ediyor?
Kim teslim oluyor? Güç nasıl paylaşılıyor?

Eski kalıp: Güç savaşları, manipülasyon, obsesyon.
Yeni öğrenme: Karşılıklı güçlendirme, dönüşümü birlikte yönetme.
''',
      evolutionPath: '''
Evrim yolu, ölüm ve yeniden doğuş döngüsünü bilinçle yaşamaktır.
Bu ilişki, ego ölümü ve ruhsal yeniden doğuş deneyimini sunar.
Her kriz, bir fırsattır.

Zaman içinde: Kontrolden teslimiyete, korkudan güvene,
ölüm korkusundan dönüşüm kabulüne evrilme.
''',
      shadowWork: '''
Gölge çalışması, güç, kontrol ve kayıp korkularıyla yüzleşmeyi içerir.
Kontrolü bırakabilir misiniz? Kayıpla nasıl başa çıkıyorsunuz?
Dönüşümden korkuyor musunuz?

Sorular:
• Birbirinizi kontrol etmeye çalışıyor musunuz?
• Kayıpla nasıl başa çıkıyorsunuz?
• Dönüşüme izin verebiliyor musunuz?
''',
    ),

    CompositeEsoteric(
      id: 'composite_sun_12h',
      title: 'Kompozit Güneş 12. Evde',
      soulPurpose: '''
Bu ilişkinin ruh amacı, ruhani birleşme ve transandanstır.
12. ev, bilinçdışının ve spiritüel alemin evidir. Güneş burada
parladığında, ilişki dünyevi olmaktan çok ruhani bir doğaya sahiptir.

Bu çift, fiziksel dünyada "görünmez" olabilir ama ruhsal boyutta
güçlü bir bağ kurar. "Seni rüyamda gördüm" hissi yaygındır.
''',
      karmicLesson: '''
Karmik ders, gizlilik ve ifade arasında denge kurmaktır.
12. ev gizliliğin evidir. Bu ilişki neden gizli kalıyor?
Korku mu var yoksa kutsal bir sır mı korunuyor?

Eski kalıp: Kaçış, kurban olma, kaybolma.
Yeni öğrenme: Bilinçli mahremiyet, spiritüel koruma, kutsal alan.
''',
      evolutionPath: '''
Evrim yolu, dünyevi ve ruhani arasında köprü kurmaktır.
Bu ilişki, hem bu dünyada hem de ruhsal boyutta var olmayı öğretir.
Gizlilik, izolasyon değil, kutsal alan olabilir.

Zaman içinde: Kaçıştan bilinçli çekilmeye, kurban olmaktan
hizmete, kaybolmaktan birleşmeye evrilme.
''',
      shadowWork: '''
Gölge çalışması, kaçış, kurban olma ve kimlik kaybıyla yüzleşmeyi içerir.
Dünyadan neden kaçmak istiyorsunuz? Birbirinizde mi kayboluyorsunuz?
Gizlilik koruma mı yoksa utanç mı?

Sorular:
• Bu ilişki neden gizli?
• Birbirinizde mi yoksa birlikte mi kayboluyorsunuz?
• Ruhani bağı dünyada nasıl ifade edebilirsiniz?
''',
    ),

    CompositeEsoteric(
      id: 'composite_moon_4h',
      title: 'Kompozit Ay 4. Evde',
      soulPurpose: '''
Bu ilişkinin ruh amacı, duygusal yuva ve aile oluşturmaktır.
4. ev, yuvanın ve ailenin evidir. Ay burada çok güçlüdür.
Birlikte, duygusal bir sığınak yaratırsınız.

Bu çift, birlikte "ev" hissi yaratır. Fiziksel bir mekân değil,
duygusal bir alan. Birlikte olduğunuzda "evinizdesiniz".
''',
      karmicLesson: '''
Karmik ders, aile kalıplarını iyileştirmektir. Her iki tarafın
aile geçmişi bu ilişkide gün yüzüne çıkar. Eski yaralar
iyileşme fırsatı bulur.

Eski kalıp: Aile travmalarının tekrarı.
Yeni öğrenme: Sağlıklı aile dinamikleri yaratmak.
''',
      evolutionPath: '''
Evrim yolu, duygusal olgunluk ve sağlıklı yuva kurmaktır.
Bu ilişki, "ev" kavramını yeniden tanımlar. Ev, bir yer değil,
bir duygusal durumdur.

Zaman içinde: Bağımlılıktan güvenliğe, travmadan iyileşmeye,
geçmişten geleceğe evrilme.
''',
      shadowWork: '''
Gölge çalışması, aile yaraları ve duygusal bağımlılıkla yüzleşmeyi içerir.
Ailenizden ne taşıyorsunuz? Bu ilişkide hangi aile kalıplarını
tekrarlıyorsunuz?

Sorular:
• Birbirinize "anne/baba" gibi mi davranıyorsunuz?
• Duygusal güvenliği nereden buluyorsunuz?
• Sağlıklı sınırlarınız var mı?
''',
    ),

    CompositeEsoteric(
      id: 'composite_pluto_conjunction_sun',
      title: 'Kompozit Pluto-Güneş Kavuşumu',
      soulPurpose: '''
Bu ilişkinin ruh amacı, radikal dönüşüm ve güç ustası olmaktır.
Pluto-Güneş kavuşumu, ilişkinin özünde dönüşüm olduğunu gösterir.
Birlikte olduğunuzda, her şey değişir - kaçınılmaz olarak.

Bu ilişki, "hafif" olamaz. Her karşılaşma yoğun, her an derin,
her deneyim dönüştürücüdür.
''',
      karmicLesson: '''
Karmik ders, gücü sağlıklı kullanmaktır. Bu ilişkide güç
dinamikleri çok belirgindir. Kim güçlü? Güç nasıl kullanılıyor?
Kontrol mu yoksa güçlendirme mi?

Eski kalıp: Güç savaşları, manipülasyon, yıkım.
Yeni öğrenme: Birbirini güçlendirme, ortak dönüşüm.
''',
      evolutionPath: '''
Evrim yolu, Pluto'nun dönüştürücü gücünü bilinçle kullanmaktır.
Bu ilişki, alev gibi yakabilir veya aydınlatabilir.
Seçim bilinçli farkındalıktadır.

Zaman içinde: Yıkımdan yaratıma, kontrolden güçlendirmeye,
ölümden yeniden doğuşa evrilme.
''',
      shadowWork: '''
Gölge çalışması, güç, kontrol ve obsesyonla yüzleşmeyi içerir.
Birbirinizi kontrol etmeye mi çalışıyorsunuz? Güç savaşları var mı?
Obsesif dinamikler fark ediyor musunuz?

Sorular:
• Gücü nasıl paylaşıyorsunuz?
• Kontrolü bırakabilir misiniz?
• Bu ilişki sizi özgürleştiriyor mu yoksa tutsak mı ediyor?
''',
    ),
  ];

  static const String compositeSpiritualEvolution = '''
KOMPOZİT HARİTA VE SPİRİTÜEL EVRİM

Kompozit harita, ilişkinin spiritüel evrim potansiyelini gösterir.
İlişki, iki ruhun birlikte nasıl evrildiğinin bir haritasıdır.

EVRİM GÖSTERGELERİ:

1. Kuzey Düğüm Yerleşimi:
Kompozit Kuzey Düğüm, ilişkinin evrimsel yönünü gösterir.
• 1. evde: Birlikte yeni kimlik keşfi
• 7. evde: Ortaklık yoluyla evrim
• 9. evde: Spiritüel arayış yoluyla büyüme
• 12. evde: Ruhani birleşme ve transandans

2. Jüpiter Yerleşimi:
Kompozit Jüpiter, ilişkinin büyüme alanını gösterir.
• Ateş evlerinde: Yaratıcı ve macera yoluyla büyüme
• Toprak evlerinde: Maddi ve pratik yoluyla büyüme
• Hava evlerinde: Entelektüel ve sosyal yoluyla büyüme
• Su evlerinde: Duygusal ve spiritüel yoluyla büyüme

3. Neptün Yerleşimi:
Kompozit Neptün, ilişkinin spiritüel potansiyelini gösterir.
• Açısal evlerde: Güçlü spiritüel misyon
• Su evlerinde: Derin mistik bağlantı
• 12. evde: Transandantal birleşme potansiyeli

BİRLİKTE SPİRİTÜEL PRATİK ÖNERİLERİ:
1. Düzenli meditasyon - Birlikte sessizlikte olmak
2. Ortak niyet belirleme - Her yeni döngüde (yeni ay, yeni yıl)
3. Ritüel ve seremoni - Geçişleri kutlamak
4. Hizmet çalışması - Birlikte başkalarına hizmet
5. Doğa bağlantısı - Birlikte doğada zaman geçirme
''';

  static const String compositeShadowWork = '''
KOMPOZİT HARİTA VE GÖLGE ÇALIŞMASI

Her ilişkinin bir gölgesi vardır. Kompozit harita, bu gölgenin
doğasını ve nasıl çalışılacağını gösterir.

GÖLGE GÖSTERGELERİ:

1. Kompozit Pluto:
İlişkinin en derin gölgesi Pluto tarafından temsil edilir.
• 1. evde: Kimlik ve güç gölgesi
• 7. evde: Ortaklık ve bağımlılık gölgesi
• 8. evde: Cinsellik ve kontrol gölgesi
• 12. evde: Bilinçdışı ve kaçış gölgesi

2. Kompozit Satürn:
İlişkinin korkuları ve kısıtlamaları Satürn tarafından temsil edilir.
• Kare açılar: Sürtüşme ve zorluk alanları
• Karşıtlık açılar: Dış dünyayla çatışma

3. Kompozit Chiron:
İlişkinin yaraları ve iyileşme potansiyeli Chiron tarafından temsil edilir.
• Ev yerleşimi: Ortak yara alanı
• Açılar: İyileşme yolu

GÖLGE ÇALIŞMASI PRATİKLERİ:
1. Tetikleyicileri fark etme - Ne sizi tetikliyor?
2. Projeksiyon kontrolü - Birbirinize ne yansıtıyorsunuz?
3. Gölge diyaloğu - Karanlık taraflarla konuşma
4. Kabul pratiği - Yargılamadan görme
5. Entegrasyon ritüeli - Gölgeyi kucaklama
''';
}

// ════════════════════════════════════════════════════════════════════════════
// 6. CİNSEL UYUM DERİNLİĞİ (SEXUAL COMPATIBILITY DEPTH)
// ════════════════════════════════════════════════════════════════════════════

class SexualCompatibilityContent {
  static const String introduction = '''
Cinsel uyum, astrolojide özellikle Mars, Venüs, 5. ev (romantizm)
ve 8. ev (derin yakınlık) tarafından temsil edilir. Bu gezegenler ve
evler, iki kişinin cinsel ve romantik uyumunu ortaya koyar.

Ezoterik açıdan cinsellik, sadece fiziksel bir eylem değil,
enerji alışverişi, ruhsal birleşme ve yaratıcı gücün ifadesidir.
Tantrik öğretilerde cinsellik, aydınlanma yollarından biri olarak
kabul edilir.

Cinsel uyumu etkileyen astrolojik faktörler:
• Mars burcu - Cinsel enerji ve ifade tarzı
• Venüs burcu - Zevk ve cinsel alıcılık
• 5. ev - Romantizm ve yaratıcı ifade
• 8. ev - Derin yakınlık ve dönüşüm
• Güneş-Ay açıları - Temel uyum
''';

  static const Map<String, SexualCompatibilityDepth> marsSexualStyles = {
    'mars_aries': SexualCompatibilityDepth(
      marsSign: 'Koç',
      venusSign: 'Genel',
      sexualStyle: '''
Koç Marsı, cinsel enerjinin en saf ve doğrudan ifadesidir.
Bu kişiler tutkulu, başlatıcı ve sabırsızdır. "Şimdi ve burada"
enerjisi hâkimdir. Flört kısa, eylem hızlıdır.

Cinsel ifade: Doğrudan, yoğun, fiziksel, atletik.
Başlatma: Her zaman hazır, genellikle ilk adımı atar.
Tempo: Hızlı başlar, yoğun devam eder.
''',
      pleasurePreference: '''
Koç Marsı, yoğunluk ve macera arar. Sürprizler, spontanlık
ve biraz "vahşilik" çekici gelir. Çok planlı veya rutine dönmüş
yakınlık sıkıcı bulunur.

Zevk alanları: Fiziksel güç gösterisi, meydan okuma, fetih duygusu.
Kaçınılan: Yavaşlık, aşırı duygusallık, uzun ön oyun.
''',
      intimacyDepth: '''
Yüzeysel görünse de Koç Marsı, doğru partnerle derin bir tutkuya
kapılabilir. Anahtar, onları yeterince zorlayan ama aynı zamanda
kabul eden bir partner bulmaktır.

Derinleşme: Tutkuyu sürdürmekle olur, rutin kırar.
Zorluk: Duygusal boyutu ihmal etme eğilimi.
''',
      tantricPotential: '''
Tantrik potansiyel, enerjiyi yavaşlatmayı ve yönlendirmeyi öğrenmekle
açılır. Koç'un ateşi, kundalini enerjisinin ham maddesidir.
Bilinçle yönetilirse, güçlü tantrik deneyimler mümkündür.

Önerilen pratik: Nefes kontrolü, enerji biriktirme, yavaşlama meditasyonu.
''',
    ),

    'mars_taurus': SexualCompatibilityDepth(
      marsSign: 'Boğa',
      venusSign: 'Genel',
      sexualStyle: '''
Boğa Marsı, cinsel enerjinin en duyusal ve sebatlı ifadesidir.
Bu kişiler yavaş ama kararlıdır. Acele etmezler, her anın
tadını çıkarırlar. Dokunuş ve fiziksel haz çok önemlidir.

Cinsel ifade: Yavaş, duyusal, sebatlı, somut.
Başlatma: Yavaş ama kararlı, asla acele etmez.
Tempo: Yavaş başlar, uzun sürer, doyuma kadar devam eder.
''',
      pleasurePreference: '''
Boğa Marsı, fiziksel konfor ve duyusal zevk arar. Güzel ortam,
hoş kokular, yumuşak dokunuşlar çekici gelir. Acele ve
yüzeysellik itici bulunur.

Zevk alanları: Uzun ön oyun, masaj, lüks ortam, yeme-içme.
Kaçınılan: Acele, rahatsız ortam, duygusal karmaşıklık.
''',
      intimacyDepth: '''
Boğa Marsı doğal olarak derinliğe yatkındır. Yüzeysel ilişkiler
yerine, derin ve kalıcı bir bağ tercih edilir. Sadakat ve
güven, derinleşmenin anahtarıdır.

Derinleşme: Güven inşası ve tutarlılıkla olur.
Zorluk: Değişime ve denemeye direnç.
''',
      tantricPotential: '''
Tantrik potansiyel çok yüksektir. Boğa'nın doğal yavaşlığı ve
duyusal farkındalığı, tantrik pratiğin temelidir.
Bu kişiler, doğuştan tantrik pratisyenlerdir.

Önerilen pratik: Duyusal farkındalık meditasyonu, uzatılmış zevk çalışması.
''',
    ),

    'mars_gemini': SexualCompatibilityDepth(
      marsSign: 'İkizler',
      venusSign: 'Genel',
      sexualStyle: '''
İkizler Marsı, cinsel enerjinin en zihinsel ve çeşitli ifadesidir.
Bu kişiler meraklı, konuşkan ve değişkendir. Zihinsel uyarılma,
fiziksel uyarılma kadar önemlidir.

Cinsel ifade: Oyuncu, sözel, değişken, meraklı.
Başlatma: Kelimelerle başlar, flört ve sözel oyun.
Tempo: Değişken, sürprizlerle dolu.
''',
      pleasurePreference: '''
İkizler Marsı, zihinsel uyarılma ve çeşitlilik arar. Konuşma,
fantezi paylaşımı ve zihinsel oyunlar çekici gelir.
Rutin ve sessizlik sıkıcı bulunur.

Zevk alanları: Sözel ifade, fantezi, rol yapma, yenilik.
Kaçınılan: Rutin, sessizlik, duygusal ağırlık.
''',
      intimacyDepth: '''
İkizler Marsı, derinlikten çok genişliğe eğilimlidir. Derinleşme,
entelektüel ve duygusal bağlantının birleşmesiyle mümkündür.

Derinleşme: İletişim ve paylaşımla olur.
Zorluk: Yüzeysellik ve dağınıklık eğilimi.
''',
      tantricPotential: '''
Tantrik potansiyel, zihni aşmayı öğrenmekle açılır. İkizler'in
zihinsel enerjisi, meditasyon ve sessizlik pratikleriyle
dengelenmelidir.

Önerilen pratik: Sessiz meditasyon, düşüncesiz farkındalık, nefes çalışması.
''',
    ),

    'mars_cancer': SexualCompatibilityDepth(
      marsSign: 'Yengeç',
      venusSign: 'Genel',
      sexualStyle: '''
Yengeç Marsı, cinsel enerjinin en duygusal ve koruyucu ifadesidir.
Bu kişiler hassas, bakım odaklı ve derin duygusal bağ arayan
kişilerdir. Güvenlik olmadan yakınlık olmaz.

Cinsel ifade: Duygusal, besleyici, koruyucu, dalgalı.
Başlatma: Duygusal bağ kurulduktan sonra, nazikçe.
Tempo: Duygusal duruma göre değişir.
''',
      pleasurePreference: '''
Yengeç Marsı, duygusal güvenlik ve yakınlık arar. Sarılma,
kucaklaşma ve duygusal ifade çekici gelir. Soğukluk ve
duygusal mesafe itici bulunur.

Zevk alanları: Sarılma, kucaklaşma, duygusal ifade, ev ortamı.
Kaçınılan: Soğukluk, duygusal mesafe, acelecilik.
''',
      intimacyDepth: '''
Yengeç Marsı doğal olarak derin yakınlık arar. Yüzeysel ilişkiler
tatmin etmez. Duygusal bağ, fiziksel bağdan önce gelir.

Derinleşme: Duygusal güvenlik inşasıyla olur.
Zorluk: Aşırı hassasiyet ve ruh hali dalgalanmaları.
''',
      tantricPotential: '''
Tantrik potansiyel yüksektir. Yengeç'in duygusal derinliği,
kalp merkezli tantrik pratikler için mükemmel bir temeldir.

Önerilen pratik: Kalp açma meditasyonu, duygusal şifa çalışması.
''',
    ),

    'mars_leo': SexualCompatibilityDepth(
      marsSign: 'Aslan',
      venusSign: 'Genel',
      sexualStyle: '''
Aslan Marsı, cinsel enerjinin en dramatik ve cömert ifadesidir.
Bu kişiler tutkulu, yaratıcı ve gösterişlidirler. Beğenilmek
ve takdir edilmek çok önemlidir.

Cinsel ifade: Dramatik, cömert, yaratıcı, gösterişli.
Başlatma: Büyük jestler, romantik sahneler.
Tempo: Yoğun ve performans odaklı.
''',
      pleasurePreference: '''
Aslan Marsı, takdir ve hayranlık arar. Övgü, beğeni ve
romantik atmosfer çekici gelir. İlgisizlik ve eleştiri
itici bulunur.

Zevk alanları: Övgü, romantik jestler, yaratıcı ifade, rol yapma.
Kaçınılan: İlgisizlik, eleştiri, sıradanlık.
''',
      intimacyDepth: '''
Aslan Marsı, ego korunduğu sürece derinleşebilir. Güvenli
bir alanda kırılganlık gösterebilir ve derin bağ kurabilir.

Derinleşme: Karşılıklı takdir ve güvenle olur.
Zorluk: Ego hassasiyeti ve dikkat ihtiyacı.
''',
      tantricPotential: '''
Tantrik potansiyel, ego'yu aşmayı öğrenmekle açılır. Aslan'ın
yaratıcı ateşi, bilinçle yönlendirilirse güçlü tantrik
deneyimler yaratabilir.

Önerilen pratik: Ego çalışması, teslimiyet pratiği, kalp açma.
''',
    ),

    'mars_virgo': SexualCompatibilityDepth(
      marsSign: 'Başak',
      venusSign: 'Genel',
      sexualStyle: '''
Başak Marsı, cinsel enerjinin en ayrıntılı ve hizmet odaklı ifadesidir.
Bu kişiler dikkatli, titiz ve partnerlerinin zevkine odaklıdırlar.
Mükemmeliyetçilik hem güç hem de zayıflık olabilir.

Cinsel ifade: Ayrıntılı, hizmet odaklı, teknik, titiz.
Başlatma: Yavaş, dikkatli, partner odaklı.
Tempo: Metodik, ayrıntılı, sabırlı.
''',
      pleasurePreference: '''
Başak Marsı, temizlik, düzen ve teknik ustalık arar. Hijyen,
sağlık ve "doğru teknik" önemlidir. Dağınıklık ve kaos
itici bulunur.

Zevk alanları: Masaj, ayrıntılı ön oyun, teknik ustalık.
Kaçınılan: Dağınıklık, acelecilik, hijyen eksikliği.
''',
      intimacyDepth: '''
Başak Marsı, güven ve rahatlık hissedildiğinde derinleşebilir.
Mükemmeliyetçilik bırakıldığında, derin ve doyurucu yakınlık mümkündür.

Derinleşme: Kabul ve rahatlamayla olur.
Zorluk: Aşırı eleştirellik ve kaygı.
''',
      tantricPotential: '''
Tantrik potansiyel, mükemmeliyetçiliği bırakmakla açılır.
Başak'ın ayrıntı odağı, bilinçli farkındalık pratiklerine
çok uygundur.

Önerilen pratik: Beden taraması, farkındalık meditasyonu, kabul pratiği.
''',
    ),

    'mars_libra': SexualCompatibilityDepth(
      marsSign: 'Terazi',
      venusSign: 'Genel',
      sexualStyle: '''
Terazi Marsı, cinsel enerjinin en zarif ve uyum odaklı ifadesidir.
Bu kişiler romantik, estetik ve partner odaklıdırlar.
Denge ve karşılıklılık çok önemlidir.

Cinsel ifade: Zarif, romantik, dengeli, estetik.
Başlatma: Romantik atmosfer, karşılıklı onay.
Tempo: Dengeli, uyumlu, partner odaklı.
''',
      pleasurePreference: '''
Terazi Marsı, güzellik, uyum ve karşılıklılık arar. Estetik ortam,
romantik atmosfer ve denge çekici gelir. Kaba davranış ve
dengesizlik itici bulunur.

Zevk alanları: Romantik atmosfer, estetik ortam, karşılıklı zevk.
Kaçınılan: Kabalık, dengesizlik, çatışma.
''',
      intimacyDepth: '''
Terazi Marsı, uyum ve denge hissedildiğinde derinleşebilir.
Çatışma kaçınma eğilimi, bazen derinliği engelleyebilir.

Derinleşme: Dürüstlük ve çatışma kabulüyle olur.
Zorluk: Çatışmadan kaçınma ve yüzeysellik.
''',
      tantricPotential: '''
Tantrik potansiyel, denge ve karşılıklılık üzerine kurulu pratiklerle
açılır. Terazi'nin uyum arayışı, tantrik birliğin temelidir.

Önerilen pratik: Partner meditasyonu, nefes senkronizasyonu, denge çalışması.
''',
    ),

    'mars_scorpio': SexualCompatibilityDepth(
      marsSign: 'Akrep',
      venusSign: 'Genel',
      sexualStyle: '''
Akrep Marsı, cinsel enerjinin en yoğun ve dönüştürücü ifadesidir.
Bu kişiler tutkulu, derin ve yoğundurlar. Yüzeysellik imkânsızdır.
Her karşılaşma bir dönüşüm deneyimi olabilir.

Cinsel ifade: Yoğun, derin, dönüştürücü, manyetik.
Başlatma: Güçlü göz teması, sessiz manyetizma.
Tempo: Yoğun ve derin, boşalımdan çok birleşim odaklı.
''',
      pleasurePreference: '''
Akrep Marsı, derinlik, yoğunluk ve dönüşüm arar. Tam teslimiyet,
güç dinamikleri ve tabu alanlar çekici gelebilir.
Yüzeysellik ve duygusal mesafe itici bulunur.

Zevk alanları: Derinlik, yoğunluk, güç dinamikleri, tabu keşfi.
Kaçınılan: Yüzeysellik, duygusal mesafe, kontrol kaybı korkusu.
''',
      intimacyDepth: '''
Akrep Marsı doğal olarak en derin yakınlığı arar. Yüzeysel ilişkiler
hiçbir anlam taşımaz. Ya tam birleşme ya da hiçbir şey.

Derinleşme: Güven ve teslimiyetle olur.
Zorluk: Obsesyon, kıskançlık ve kontrol.
''',
      tantricPotential: '''
Tantrik potansiyel maksimum seviyededir. Akrep Marsı, tantrik
öğretilerin en derin boyutlarına doğal olarak erişebilir.
Kontrol yerine teslimiyet öğrenilmelidir.

Önerilen pratik: Teslimiyet meditasyonu, güç bırakma, tantrik birleşim.
''',
    ),

    'mars_sagittarius': SexualCompatibilityDepth(
      marsSign: 'Yay',
      venusSign: 'Genel',
      sexualStyle: '''
Yay Marsı, cinsel enerjinin en maceraperest ve coşkulu ifadesidir.
Bu kişiler eğlenceli, spontan ve özgürlük odaklıdırlar.
Yakınlık bir macera, bir keşif yolculuğu gibidir.

Cinsel ifade: Maceraperest, coşkulu, spontan, özgür.
Başlatma: Spontan, eğlenceli, maceracı.
Tempo: Değişken, coşkulu, eğlenceli.
''',
      pleasurePreference: '''
Yay Marsı, macera, özgürlük ve eğlence arar. Yeni deneyimler,
farklı yerler ve spontanlık çekici gelir. Rutin ve
kısıtlama itici bulunur.

Zevk alanları: Macera, yeni deneyimler, açık hava, spontanlık.
Kaçınılan: Rutin, kısıtlama, ciddiyet.
''',
      intimacyDepth: '''
Yay Marsı, özgürlük hissiyle derinleşebilir. Kısıtlama hissedilirse
kaçış dürtüsü ortaya çıkar. Özgür ama bağlı - paradoks çözülmelidir.

Derinleşme: Özgürlük içinde bağlılıkla olur.
Zorluk: Taahhüt korkusu ve yüzeysellik eğilimi.
''',
      tantricPotential: '''
Tantrik potansiyel, macera ruhunu spiritüel arayışa yönlendirmekle
açılır. Yay'ın coşkusu, tantrik pratiklere enerji katar.

Önerilen pratik: Spiritüel macera, kutsal mekân ziyaretleri, felsefe.
''',
    ),

    'mars_capricorn': SexualCompatibilityDepth(
      marsSign: 'Oğlak',
      venusSign: 'Genel',
      sexualStyle: '''
Oğlak Marsı, cinsel enerjinin en kontrollü ve disiplinli ifadesidir.
Bu kişiler ciddi, kararlı ve dayanıklıdırlar. Dışarıdan soğuk
görünebilirler ama içeride derin bir tutku saklarlar.

Cinsel ifade: Kontrollü, disiplinli, dayanıklı, ciddi.
Başlatma: Yavaş, planlı, emin adımlarla.
Tempo: Uzun süreli, dayanıklı, hedef odaklı.
''',
      pleasurePreference: '''
Oğlak Marsı, kontrol, dayanıklılık ve başarı arar. Uzun süreli
yakınlık, hedef odaklı performans çekici gelir.
Kontrolsüzlük ve acelecilik itici bulunur.

Zevk alanları: Dayanıklılık, uzun süreli yakınlık, kontrol.
Kaçınılan: Kontrolsüzlük, acelecilik, duygusal taşkınlık.
''',
      intimacyDepth: '''
Oğlak Marsı, güven ve saygı hissedildiğinde çok derin olabilir.
Duvarların arkasında çok derin bir tutku vardır.

Derinleşme: Güven ve zaman ile olur.
Zorluk: Duygusal ifade zorluğu ve katılık.
''',
      tantricPotential: '''
Tantrik potansiyel, kontrolü bırakmayı öğrenmekle açılır.
Oğlak'ın disiplini, tantrik pratiklere yapı sağlar.

Önerilen pratik: Kontrol bırakma, teslimiyet, duygusal açılım.
''',
    ),

    'mars_aquarius': SexualCompatibilityDepth(
      marsSign: 'Kova',
      venusSign: 'Genel',
      sexualStyle: '''
Kova Marsı, cinsel enerjinin en sıra dışı ve deneysel ifadesidir.
Bu kişiler yenilikçi, bağımsız ve konvansiyonelliklere meydan
okuyandırlar. "Normal" sıkıcıdır.

Cinsel ifade: Sıra dışı, deneysel, bağımsız, yenilikçi.
Başlatma: Beklenmedik, sıra dışı, entelektüel.
Tempo: Değişken, deneysel, özgün.
''',
      pleasurePreference: '''
Kova Marsı, yenilik, özgürlük ve sıra dışılık arar. Deney,
yeni fikirler ve bağımsızlık çekici gelir. Rutin ve
konvansiyonellik itici bulunur.

Zevk alanları: Deney, yenilik, teknoloji, grup dinamikleri.
Kaçınılan: Rutin, geleneksellik, sahiplenme.
''',
      intimacyDepth: '''
Kova Marsı, bireysellik korunduğu sürece derinleşebilir.
Özgürlük içinde bağlılık - yine bir paradoks.

Derinleşme: Bireyselliğe saygı ile olur.
Zorluk: Duygusal mesafe ve kopukluk.
''',
      tantricPotential: '''
Tantrik potansiyel, sıra dışı pratiklerle açılır. Kova'nın
yenilikçiliği, tantrik öğretileri modern bağlamda keşfetmeye uygundur.

Önerilen pratik: Modern tantra, teknoloji destekli pratikler, grup çalışması.
''',
    ),

    'mars_pisces': SexualCompatibilityDepth(
      marsSign: 'Balık',
      venusSign: 'Genel',
      sexualStyle: '''
Balık Marsı, cinsel enerjinin en romantik ve transandantal ifadesidir.
Bu kişiler rüya gibi, sezgisel ve sınırsızdırlar. Fiziksel boyut,
ruhsal boyutun bir ifadesidir.

Cinsel ifade: Romantik, rüya gibi, sınırsız, transandantal.
Başlatma: Sezgisel, romantik, rüya gibi.
Tempo: Akışkan, değişken, sınırsız.
''',
      pleasurePreference: '''
Balık Marsı, romantizm, transandans ve birleşim arar. Rüya gibi
atmosfer, müzik ve spiritüel bağlantı çekici gelir.
Kabalık ve materyalizm itici bulunur.

Zevk alanları: Romantizm, müzik, rüya gibi atmosfer, birleşim.
Kaçınılan: Kabalık, materyalizm, sertlik.
''',
      intimacyDepth: '''
Balık Marsı doğal olarak sınırsız derinliğe ulaşabilir.
Fiziksel ve ruhsal arasında sınır yoktur.

Derinleşme: Ruhsal bağlantı ile olur.
Zorluk: Gerçeklikten kopma ve sınır kaybı.
''',
      tantricPotential: '''
Tantrik potansiyel en yüksek seviyededir. Balık Marsı, tantrik
birliğin ruhsal boyutuna doğal olarak erişebilir.

Önerilen pratik: Spiritüel birleşim meditasyonu, rüya çalışması, müzik.
''',
    ),
  };

  static const String fifthHouseRomance = '''
5. EV VE ROMANTİZM

5. ev, yaratıcılık, romantizm ve neşenin evidir. Sinastride 5. ev
bağlantıları, çiftin romantik ve eğlenceli dinamiklerini gösterir.

5. EV GEZEGENLERİ:

Güneş 5. Evde:
Partner, yaratıcılığınızı ve neşenizi uyandırır. Birlikte olmak
eğlenceli, yaratıcı ve canlıdır. Romantizm doğal akar.

Ay 5. Evde:
Duygusal yaratıcılık ve romantik duygusallık. Birlikte olmak
sıcak, besleyici ve duygusal olarak tatmin edicidir.

Venüs 5. Evde:
En güçlü romantik bağlantılardan biri. Aşk, güzellik ve zevk
birlikte aktifleşir. Birlikte olmak bir romantik film gibidir.

Mars 5. Evde:
Tutkulu romantizm ve yaratıcı ateş. Birlikte olmak heyecanlı,
maceralı ve cinsel olarak uyarıcıdır.

Jüpiter 5. Evde:
Bolluk ve neşe ile dolu romantizm. Birlikte olmak genişletici,
coşkulu ve şanslı hissettirir.

5. EV ROMANTİZMİ GELİŞTİRME:
1. Birlikte yaratıcı projeler yapın
2. Oyunculuğu ve eğlenceyi koruyun
3. Sürprizler ve spontanlık
4. Çocuksu neşeyi yaşayın
5. Sanat ve güzellik paylaşın
''';

  static const String eighthHouseIntimacy = '''
8. EV VE DERİN YAKINLIK

8. ev, dönüşüm, cinsellik ve derin birleşmenin evidir. Sinastride 8. ev
bağlantıları, çiftin derin yakınlık ve dönüşüm potansiyelini gösterir.

8. EV GEZEGENLERİ:

Güneş 8. Evde:
Derin dönüşüm ve kimlik birleşimi. Bu ilişkide eski benlik ölür,
yeni benlik doğar. Hafif bir ilişki değildir.

Ay 8. Evde:
Duygusal derinlik ve psişik bağlantı. Birbirinizin en derin
duygularını hissedersiniz. Gizli hiçbir şey kalmaz.

Venüs 8. Evde:
Derin, dönüştürücü aşk. Bu aşk, sizi değiştirir. Yüzeysel
romantizmden çok, ruhsal birleşim vardır.

Mars 8. Evde:
Yoğun cinsel enerji ve tutku. Bu bağlantı, sinastride en güçlü
cinsel çekim göstergelerinden biridir.

Pluto 8. Evde:
En derin ve en yoğun 8. ev bağlantısı. Tam dönüşüm, ego ölümü
ve yeniden doğuş. Bu ilişki, her şeyi değiştirir.

8. EV YAKINLIĞINI GELİŞTİRME:
1. Güvenli alan yaratın
2. Gizleri paylaşın
3. Kırılganlığı kabul edin
4. Dönüşüme izin verin
5. Kontrolü bırakın
''';
}

// ════════════════════════════════════════════════════════════════════════════
// 7. SPİRİTÜEL ORTAKLIK (SPIRITUAL PARTNERSHIP)
// ════════════════════════════════════════════════════════════════════════════

class SpiritualPartnershipContent {
  static const String introduction = '''
Spiritüel ortaklık, romantik ilişkinin en yüksek formudur. Bu ortaklıkta,
iki ruh sadece dünyevi yaşamı paylaşmakla kalmaz, aynı zamanda birlikte
ruhsal bir yolculuğa çıkar.

Gary Zukav'ın tanımıyla, spiritüel ortaklık "ruhsal büyüme amacıyla
bir araya gelen iki kişi arasındaki ortaklık"tır. Bu ilişkide,
ego tatmini yerine ruhsal evrim önceliklidir.

Astrolojik olarak spiritüel ortaklık göstergeleri:
• 9. ev bağlantıları - Paylaşılan inançlar ve felsefe
• 12. ev bağlantıları - Ruh bağı ve transandans
• Neptün açıları - Spiritüel birleşme
• Jüpiter açıları - Birlikte büyüme
• Kuzey Düğüm bağlantıları - Evrimsel ortaklık
''';

  static const String ninthHouseBeliefs = '''
9. EV VE PAYLAŞILAN İNANÇLAR

9. ev, felsefe, inanç, yüksek öğrenim ve ruhsal arayışın evidir.
Sinastride 9. ev bağlantıları, çiftin dünya görüşü ve spiritüel
yolculuğunun nasıl örtüştüğünü gösterir.

9. EV GEZEGENLERİ VE ANLAMI:

Güneş 9. Evde:
Partneriniz, dünya görüşünüzü ve inançlarınızı aydınlatır.
Birlikte, daha geniş bir perspektif ve daha derin bir anlam
keşfedersiniz. Felsefe ve spiritualite paylaşılır.

"Seninle birlikte hayatı daha anlamlı görüyorum."

Ay 9. Evde:
Duygusal olarak benzer inançlar ve değerler. İnançlar sadece
entelektüel değil, duygusal düzeyde de paylaşılır.
Birlikte dua etmek, meditasyon yapmak doğal gelir.

"Seninle aynı şeylere inanıyorum - ve bunu hissediyorum."

Venüs 9. Evde:
Sevgi, ortak inançlar ve değerler üzerine kurulu. Felsefe ve
spiritualite, ilişkinin romantik boyutunu besler.
Birlikte öğrenme ve keşif bir aşk dilidir.

"Seni seviyorum çünkü aynı şeylere değer veriyoruz."

Mars 9. Evde:
İnançlar için birlikte savaşmak, ortak bir dava için mücadele.
Aksiyon odaklı spiritualite - sadece inanmak değil, yaşamak.
Misyoner gibi birlikte dünyayı değiştirmek.

"Seninle birlikte inançlarım için savaşabilirim."

Jüpiter 9. Evde:
En güçlü 9. ev bağlantılarından biri. Jüpiter evinde güçlüdür.
Birlikte büyüme, öğrenme ve genişleme sınırsızdır.
Dünyayı birlikte keşfetmek - fiziksel ve spiritüel olarak.

"Seninle birlikte sınırlar genişliyor."

Satürn 9. Evde:
Ciddi ve kararlı spiritüel ortaklık. İnançlar sorgulanır,
test edilir ve güçlendirilir. Yapılandırılmış spiritüel pratik.

"Seninle birlikte inançlarımı derinleştiriyorum."

Neptün 9. Evde:
Mistik ve transandantal spiritüel bağlantı. Aynı rüyaları görmek,
aynı vizyonları paylaşmak mümkündür. Sınırsız spiritüel keşif.

"Seninle birlikte sınırların ötesine geçiyoruz."

9. EV SPİRİTÜALİTESİNİ GELİŞTİRME:
1. Ortak spiritüel pratik belirleyin
2. Birlikte öğrenin ve keşfedin
3. Kutsal mekânları birlikte ziyaret edin
4. Felsefe ve anlam üzerine konuşun
5. Birbirinizin inançlarına saygı gösterin
''';

  static const String twelfthHouseSoulConnection = '''
12. EV VE RUH BAĞLANTISI

12. ev, bilinçdışının, spiritüel boyutun ve sınırsız birliğin evidir.
Sinastride 12. ev bağlantıları, en gizemli ve en derin ruh bağlarını
gösterir.

12. EV BAĞLANTISININ GİZEMİ:

12. ev, görünür dünyanın ötesindeki alemleri temsil eder.
Bu evdeki bağlantılar, fiziksel dünyada tam olarak açıklanamayan
bir yakınlık yaratır. "Seni nasıl bu kadar iyi tanıyorum?"

12. EV GEZEGENLERİ VE ANLAMI:

Güneş 12. Evde:
Ruhani aşk - dünyevi olmaktan çok ilahi. Bu ilişki, toplumsal
normların ötesinde, ruhsal bir boyutta yaşanır.
"Gizli aşk" veya "spiritüel bağ" hissi.

Potansiyel: Derin ruhsal birleşme.
Risk: Gizlilik, açıklanamama, dünyevi engeleler.

Ay 12. Evde:
Psişik ve telepatik duygusal bağ. Birbirinizin duygularını
uzaktan bile hissedersiniz. Rüyalarda buluşma mümkündür.

Potansiyel: Sınırsız duygusal anlayış.
Risk: Sınır kaybı, kimlik erimesi.

Venüs 12. Evde:
Koşulsuz ve transandantal aşk. Bu sevgi, dünyevi koşulların
ötesindedir. "Seni her koşulda seviyorum" gerçek anlamıyla.

Potansiyel: İlahi aşk deneyimi.
Risk: Fedakârlık, kaybolma, açıklanama.

Mars 12. Evde:
Gizli veya bilinçdışı cinsel enerji. Bu çekim, bilinçli düzeyde
tam olarak ifade edilemeyebilir. Rüyalarda, fantezilerde yaşanır.

Potansiyel: Spiritüel cinsel birleşme.
Risk: Bastırma, gizli arzular, ifade zorluğu.

Neptün 12. Evde:
En güçlü 12. ev bağlantısı. Neptün evindedir ve sınırsız
spiritüel birleşme mümkündür. Rüya ve gerçeklik iç içe geçer.

Potansiyel: Tam spiritüel birleşme.
Risk: Gerçeklikten kopuş, illüzyon.

Pluto 12. Evde:
Derin bilinçdışı dönüşüm. Ruhsal düzeyde karşılıklı yeniden
programlama. Eski karmik kalıpların çözülmesi.

Potansiyel: Radikal ruhsal dönüşüm.
Risk: Bilinçdışı güç dinamikleri.

12. EV BAĞLANTISINI YAŞAMA:
1. Bilinçdışını keşfedin (rüya çalışması)
2. Meditasyonu birlikte yapın
3. Sessizliği paylaşın
4. Spiritüel pratiği birlikte geliştirin
5. Gizemi kabul edin, açıklamaya zorlamayın
''';

  static const String neptuneTranscendence = '''
NEPTÜN VE TRANSANDANS

Neptün, spiritüel birleşmenin, transandansın ve koşulsuz sevginin
gezegenidir. Sinastride güçlü Neptün bağlantıları, ilişkiye rüya gibi,
büyülü ve spiritüel bir kalite katar.

NEPTÜN AÇILARI VE ANLAMI:

Neptün-Güneş Kavuşumu:
Güneş kişisi, Neptün kişisi tarafından idealleştirilir.
Neptün kişisi, Güneş kişisinde ilahi bir şey görür.
"Sen benim için tanrısal bir varlıksın."

Potansiyel: İlahi aşkın dünyevi tezahürü.
Risk: İdealizasyon, hayal kırıklığı, illüzyon.

Neptün-Ay Kavuşumu:
Duygusal telepati ve psişik bağlantı. Birbirinizin duygularını
sözlere gerek kalmadan anlarsınız. Rüya paylaşımı yaygındır.

Potansiyel: Sınırsız duygusal anlayış.
Risk: Duygusal bulanıklık, sınır kaybı.

Neptün-Venüs Kavuşumu:
Romantik aşkın en transandantal formu. Bu aşk, dünyevi olmaktan
çok ilahi bir kaliteye sahiptir. "Peri masalı aşkı."

Potansiyel: Koşulsuz ve ilahi aşk.
Risk: Gerçeklikten kopuş, hayal kırıklığı.

Neptün-Mars Kavuşumu:
Cinsel enerjinin spiritüel boyutu. Tantra ve kutsal cinsellik
için güçlü bir gösterge. Cinsellik, transandans aracı olabilir.

Potansiyel: Tantrik birleşme ve aşkınlık.
Risk: Cinsel fantezi ve gerçeklik arasında kaybolma.

NEPTÜN İLİŞKİSİNDE DİKKAT EDİLECEKLER:
1. Gerçeklikle bağı koruyun
2. İdealizasyonun farkında olun
3. Sınırları koruyun ama sertleştirmeyin
4. Spiritüel bağı onurlandırın
5. Hayal kırıklıklarını affetme fırsatı olarak görün
''';

  static const String jupiterGrowthTogether = '''
JÜPİTER VE BİRLİKTE BÜYÜME

Jüpiter, büyüme, genişleme ve bolluk gezegenidir. Sinastride güçlü
Jüpiter bağlantıları, ilişkede karşılıklı büyüme, şans ve genişleme
potansiyelini gösterir.

JÜPİTER AÇILARI VE ANLAMI:

Jüpiter-Güneş Kavuşumu:
Jüpiter kişisi, Güneş kişisinin özgüvenini ve potansiyelini büyütür.
"Seninle birlikte her şey mümkün görünüyor."

Potansiyel: Karşılıklı büyüme ve başarı.
Enerji: İyimserlik, cömertlik, genişleme.

Jüpiter-Ay Kavuşumu:
Duygusal büyüme ve genişleme. Jüpiter kişisi, Ay kişisinin
duygusal dünyasını besler ve genişletir.

Potansiyel: Duygusal bolluk ve güvenlik.
Enerji: Sıcaklık, kabul, büyüme.

Jüpiter-Venüs Kavuşumu:
En şanslı ve en bereketli aşk bağlantılarından biri.
Bu ilişkede aşk bolca akar, cömertlik doğaldır.

Potansiyel: Bereketli ve cömert aşk.
Enerji: Romantizm, bolluk, lüks.

Jüpiter-Mars Kavuşumu:
Birlikte aksiyon ve başarı. Bu çift, birlikte büyük işler
başarabilir. Enerji ve şans birleşir.

Potansiyel: Büyük başarılar ve maceralar.
Enerji: Aksiyon, cesaret, genişleme.

Jüpiter-Jüpiter Kavuşumu:
Aynı büyüme alanları ve felsefe. Bu çift, birlikte aynı yöne
doğru genişler. Ortak vizyon ve hedefler.

Potansiyel: Ortak büyüme ve başarı.
Enerji: Uyum, paylaşılan değerler, ortak vizyon.

BİRLİKTE BÜYÜME PRATİKLERİ:
1. Ortak hedefler belirleyin
2. Birbirini destekleyin ve cesaretlendirin
3. Yeni deneyimlere birlikte açılın
4. Öğrenmeyi paylaşın
5. Cömertliği karşılıklı yaşayın
''';

  static const String spiritualPartnershipPrinciples = '''
SPİRİTÜEL ORTAKLIK İLKELERİ

Spiritüel ortaklık, bilinçli bir taahhüt ve sürekli bir pratik gerektirir.
Aşağıdaki ilkeler, ilişkiyi spiritüel bir ortaklığa dönüştürmeye
yardımcı olabilir:

1. BİREYSEL BÜTÜNLÜK
Spiritüel ortaklık, iki "tam" kişinin bir araya gelmesini gerektirir.
Eksiklik hissinden değil, bolluk hissinden bir araya gelmek.
"Sana ihtiyacım var" yerine "Seninle olmayı seçiyorum."

2. KARŞILIKLI SAYGI
Her iki tarafın da bireyselliği, yolculuğu ve seçimleri saygıyla
karşılanmalıdır. Değiştirmeye çalışmak yerine kabul etmek.
"Seni olduğun gibi seviyorum."

3. DÜRÜSTLÜK
Derin dürüstlük, spiritüel ortaklığın temelidir. Sadece söyledikleriniz
değil, hissettikleriniz de paylaşılmalıdır.
"Seninle gerçek olabilirim."

4. BÜYÜME ODAKLILIK
İlişkinin amacı, ego tatmini değil ruhsal büyümedir.
Rahatsızlık, büyüme fırsatı olarak görülür.
"Bu zorluk bizi büyütüyor."

5. GÖLGE ÇALIŞMASI
Birbirinin gölgelerini görmek ve kabul etmek. Yargılamak yerine
aydınlatmak. "Senin karanlığını seviyorum."

6. KUTSAL ALAN
İlişki, kutsal bir alan olarak görülür. Birlikte olduğunuzda
özel bir enerji oluşur. "Birlikte kutsal bir şey yaratıyoruz."

7. HİZMET
Sadece birbirine değil, dünyaya birlikte hizmet. İlişkinin
ötesine genişleyen bir amaç. "Birlikte dünyaya katkıda bulunuyoruz."

SPİRİTÜEL ORTAKLIK RİTÜELLERİ:
1. Sabah niyeti - Her güne ortak niyetle başlama
2. Akşam yansıması - Günü birlikte değerlendirme
3. Haftalık buluşma - Derinlemesine konuşma ve bağlantı
4. Aylık ritüel - Yeni ay veya dolunay seremeni
5. Yıllık değerlendirme - İlişkinin evrimi üzerine düşünme
''';

  static const String sacredUnionMeditation = '''
KUTSAL BİRLİK MEDİTASYONU

Bu meditasyon, iki partnerin enerji bedenlerini birleştirmek ve
kutsal birliği deneyimlemek için tasarlanmıştır.

HAZIRLIK:
• Sessiz ve rahat bir ortam seçin
• Karşı karşıya oturun (diz çökme veya bağdaş kurma)
• Gözlerinizi kapatın ve nefesinizi sakinleştirin

ADIM 1: BİREYSEL TOPRAKLANMA (3 dakika)
Her biriniz kendi nefesine odaklanın.
Ayaklarınızın altından toprağa köklerin uzadığını hayal edin.
Topraktan gelen enerjiyi yukarı çekin.

ADIM 2: KALP AÇILIMI (3 dakika)
Dikkatinizi kalp merkezinize getirin.
Kalbinizde yeşil veya pembe bir ışık hayal edin.
Bu ışığın genişleyip göğsünüzü doldurduğunu hissedin.

ADIM 3: GÖZ TEMASI (5 dakika)
Gözlerinizi yavaşça açın.
Partnerinizin gözlerinin içine yumuşak bir şekilde bakın.
Bakışınızı sabit tutun, ama yumuşak ve sevgi dolu olsun.

ADIM 4: NEFES SENKRONIZASYONU (5 dakika)
Birlikte nefes alıp vermeye başlayın.
Aynı ritimde nefes alın ve verin.
Nefesin sizi birleştirdiğini hissedin.

ADIM 5: ENERJİ DEĞİŞİMİ (5 dakika)
Nefes verirken, kalbinizden partnerinize enerji gönderin.
Nefes alırken, partnerinizden gelen enerjiyi kabul edin.
Bu alışverişin bir döngü oluşturduğunu hissedin.

ADIM 6: BİRLEŞME (5 dakika)
Aranızdaki sınırın eridiğini hayal edin.
İki enerji bedeninin birleştiğini hissedin.
Artık iki ayrı değil, bir bütünsünüz.

ADIM 7: KUTSAL MEKAN (3 dakika)
Bu birleşmiş durumda, etrafınızda altın bir ışık küresi hayal edin.
Bu küre, sizin kutsal alanınızdır.
Bu alanda güvende, sevgi dolu ve birleşik olduğunuzu hissedin.

ADIM 8: GERİ DÖNÜŞ (2 dakika)
Yavaşça bireysel farkındalığınıza dönün.
Ama bağlantının kalıcı olduğunu bilin.
Gözlerinizi kapatın, birkaç derin nefes alın.

ADIM 9: KAPANIŞ (1 dakika)
Gözlerinizi açın.
Partnerinize bakın ve gülümseyin.
Ellerinizi kalbinize koyun.
"Teşekkür ederim" deyin.

NOT:
Bu meditasyon güçlü duygusal ve enerjetik deneyimler yaratabilir.
İlk seferlerde kısa tutun ve zamanla uzatın.
Deneyimlerinizi sonrasında birbirinizle paylaşın.
''';
}

// ════════════════════════════════════════════════════════════════════════════
// CONTENT SERVICE
// ════════════════════════════════════════════════════════════════════════════

class EsotericSynastryContentService {
  // Soulmate Indicators
  static List<SoulmateIndicator> getAllSoulmateIndicators() {
    return [
      ...SoulmateIndicators.northNodeConnections,
      ...SoulmateIndicators.vertexConnections,
      ...SoulmateIndicators.junoAspects,
      ...SoulmateIndicators.sunMoonAspects,
      ...SoulmateIndicators.venusMarsAspects,
    ];
  }

  static List<SoulmateIndicator> getSoulmateIndicatorsByType(
    SoulmateIndicatorType type,
  ) {
    return getAllSoulmateIndicators().where((i) => i.type == type).toList();
  }

  // Twin Flame Aspects
  static List<TwinFlameAspect> getAllTwinFlameAspects() {
    return [
      ...TwinFlameAstrology.mirrorChartPatterns,
      ...TwinFlameAstrology.nodalAxisConnections,
      ...TwinFlameAstrology.plutoTransformations,
      ...TwinFlameAstrology.chironHealing,
      ...TwinFlameAstrology.twelfthHouseConnections,
      ...TwinFlameAstrology.eighthHouseConnections,
    ];
  }

  static List<TwinFlameAspect> getTwinFlameAspectsByPattern(
    TwinFlamePattern pattern,
  ) {
    return getAllTwinFlameAspects().where((a) => a.pattern == pattern).toList();
  }

  // Karmic Patterns
  static List<KarmicPattern> getAllKarmicPatterns() {
    return [
      ...KarmicRelationshipPatterns.southNodeConnections,
      ...KarmicRelationshipPatterns.saturnBonds,
      ...KarmicRelationshipPatterns.plutoObsession,
      ...KarmicRelationshipPatterns.neptuneIllusion,
      ...KarmicRelationshipPatterns.chironWounds,
    ];
  }

  static List<KarmicPattern> getKarmicPatternsByType(KarmicPatternType type) {
    return getAllKarmicPatterns().where((p) => p.type == type).toList();
  }

  // Tantric Compatibility
  static List<TantricCompatibility> getAllTantricCompatibilities() {
    return [
      ...TantricCompatibilityContent.marsVenusExchange,
      ...TantricCompatibilityContent.eighthHouseTantric,
    ];
  }

  // Chakra Compatibility
  static List<ChakraCompatibility> getAllChakraCompatibilities() {
    return TantricCompatibilityContent.chakraBySign;
  }

  static List<ChakraCompatibility> getChakraCompatibilityByType(
    ChakraType type,
  ) {
    return getAllChakraCompatibilities()
        .where((c) => c.chakra == type)
        .toList();
  }

  // Composite Esoterics
  static List<CompositeEsoteric> getAllCompositeEsoterics() {
    return CompositeChartEsoterics.compositePlacements;
  }

  // Sexual Compatibility
  static Map<String, SexualCompatibilityDepth> getAllMarsStyles() {
    return SexualCompatibilityContent.marsSexualStyles;
  }

  static SexualCompatibilityDepth? getMarsStyleBySign(String sign) {
    final key = 'mars_${sign.toLowerCase()}';
    return SexualCompatibilityContent.marsSexualStyles[key];
  }

  // Introduction Texts
  static String getSoulmateIntroduction() => SoulmateIndicators.introduction;
  static String getTwinFlameIntroduction() => TwinFlameAstrology.introduction;
  static String getKarmicIntroduction() =>
      KarmicRelationshipPatterns.introduction;
  static String getTantricIntroduction() =>
      TantricCompatibilityContent.introduction;
  static String getCompositeIntroduction() =>
      CompositeChartEsoterics.introduction;
  static String getSexualIntroduction() =>
      SexualCompatibilityContent.introduction;
  static String getSpiritualIntroduction() =>
      SpiritualPartnershipContent.introduction;

  // Extended Content
  static String getKundaliniSynastry() =>
      TantricCompatibilityContent.kundaliniSynastry;
  static String getSacredUnionIndicators() =>
      TantricCompatibilityContent.sacredUnionIndicators;
  static String getCompositeSpiritualEvolution() =>
      CompositeChartEsoterics.compositeSpiritualEvolution;
  static String getCompositeShadowWork() =>
      CompositeChartEsoterics.compositeShadowWork;
  static String getFifthHouseRomance() =>
      SexualCompatibilityContent.fifthHouseRomance;
  static String getEighthHouseIntimacy() =>
      SexualCompatibilityContent.eighthHouseIntimacy;
  static String getNinthHouseBeliefs() =>
      SpiritualPartnershipContent.ninthHouseBeliefs;
  static String getTwelfthHouseSoulConnection() =>
      SpiritualPartnershipContent.twelfthHouseSoulConnection;
  static String getNeptuneTranscendence() =>
      SpiritualPartnershipContent.neptuneTranscendence;
  static String getJupiterGrowthTogether() =>
      SpiritualPartnershipContent.jupiterGrowthTogether;
  static String getSpiritualPartnershipPrinciples() =>
      SpiritualPartnershipContent.spiritualPartnershipPrinciples;
  static String getSacredUnionMeditation() =>
      SpiritualPartnershipContent.sacredUnionMeditation;
}
