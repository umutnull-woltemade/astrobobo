// KUNDALINI AWAKENING GUIDE - KUNDALİNİ UYANIŞ REHBERİ
//
// Derin ezoterik tantrik bilgelik
// Yedi chakra yolculugu, nadi sistemi, uyaniş asamalari
//
// Kadim Sanskrit kaynaklarindan derlenmis içerik:
// - Serpent power (Shakti) açiklamalari
// - Üç ana nadi: Sushumna, Ida, Pingala
// - Chakra aktivasyonu ve kundalini deneyimleri
// - Güvenlik ve topraklama pratikleri
// - Astrolojik baglantılar

// ═══════════════════════════════════════════════════════════════════════════
// ENUMS VE MODELLER
// ═══════════════════════════════════════════════════════════════════════════

/// Kundalini uyaniş aşamalari
enum KundaliniStage {
  dormant, // Uyuyan - Muladhara'da sarili
  stirring, // Kivrilma - İlk hareketler
  awakening, // Uyaniş - Aktif yükseliş
  rising, // Yükseliş - Chakralardan geçiş
  piercing, // Delme - Granthileri aşma
  flowering, // Çiçeklenme - Üst chakralarda açiliş
  union, // Birleşme - Shiva-Shakti buluşmasi
}

extension KundaliniStageExtension on KundaliniStage {
  String get nameTr {
    switch (this) {
      case KundaliniStage.dormant:
        return 'Uyuyan Yilan';
      case KundaliniStage.stirring:
        return 'Kivrilma';
      case KundaliniStage.awakening:
        return 'Uyaniş';
      case KundaliniStage.rising:
        return 'Yükseliş';
      case KundaliniStage.piercing:
        return 'Düğümleri Aşma';
      case KundaliniStage.flowering:
        return 'Çiçeklenme';
      case KundaliniStage.union:
        return 'İlahi Birleşme';
    }
  }

  String get description {
    switch (this) {
      case KundaliniStage.dormant:
        return 'Kundalini enerjisi Muladhara chakrada üç buçuk kivirimla sarili uyuyor. Potansiyel sinirsiz, ama henüz aktive edilmemiş.';
      case KundaliniStage.stirring:
        return 'İlk titreşimler hissediliyor. Omurga tabaninda isilik, karincilanma. Ruhsal arayiş yoğunlaşiyor.';
      case KundaliniStage.awakening:
        return 'Yilan uyanmaya başladi. Spontan hareketler, enerji dalgalari, bilinç genişlemesi başliyor.';
      case KundaliniStage.rising:
        return 'Enerji Sushumna boyunca yükseliyor. Her chakrada farkli deneyimler, arınma süreçleri yaşaniyor.';
      case KundaliniStage.piercing:
        return 'Üç granthi (düğüm) aşılıyor: Brahma, Vishnu, Rudra. Her biri derin dönüşüm getiriyor.';
      case KundaliniStage.flowering:
        return 'Üst chakralar açılıyor. Psişik yetenekler, derin içgörüler, kozmik bilinç deneyimleri.';
      case KundaliniStage.union:
        return 'Shakti, Sahasrara\'da Shiva ile buluşuyor. Nirvikalpa samadhi, mutlak birlik deneyimi.';
    }
  }

  String get icon {
    switch (this) {
      case KundaliniStage.dormant:
        return '🐍';
      case KundaliniStage.stirring:
        return '🌀';
      case KundaliniStage.awakening:
        return '🔥';
      case KundaliniStage.rising:
        return '⬆️';
      case KundaliniStage.piercing:
        return '💫';
      case KundaliniStage.flowering:
        return '🌸';
      case KundaliniStage.union:
        return '☀️';
    }
  }
}

/// Yedi ana chakra
enum Chakra {
  muladhara, // Kök
  svadhisthana, // Sakral
  manipura, // Solar Pleksus
  anahata, // Kalp
  vishuddha, // Boğaz
  ajna, // Üçüncü Göz
  sahasrara, // Taç
}

extension ChakraExtension on Chakra {
  String get sanskritName {
    switch (this) {
      case Chakra.muladhara:
        return 'Muladhara';
      case Chakra.svadhisthana:
        return 'Svadhisthana';
      case Chakra.manipura:
        return 'Manipura';
      case Chakra.anahata:
        return 'Anahata';
      case Chakra.vishuddha:
        return 'Vishuddha';
      case Chakra.ajna:
        return 'Ajna';
      case Chakra.sahasrara:
        return 'Sahasrara';
    }
  }

  String get turkishName {
    switch (this) {
      case Chakra.muladhara:
        return 'Kök Chakra';
      case Chakra.svadhisthana:
        return 'Sakral Chakra';
      case Chakra.manipura:
        return 'Güneş Ağı Chakrası';
      case Chakra.anahata:
        return 'Kalp Chakrası';
      case Chakra.vishuddha:
        return 'Boğaz Chakrası';
      case Chakra.ajna:
        return 'Üçüncü Göz';
      case Chakra.sahasrara:
        return 'Taç Chakra';
    }
  }

  int get number {
    switch (this) {
      case Chakra.muladhara:
        return 1;
      case Chakra.svadhisthana:
        return 2;
      case Chakra.manipura:
        return 3;
      case Chakra.anahata:
        return 4;
      case Chakra.vishuddha:
        return 5;
      case Chakra.ajna:
        return 6;
      case Chakra.sahasrara:
        return 7;
    }
  }
}

/// Üç ana nadi
enum Nadi {
  sushumna, // Merkezi kanal
  ida, // Ay/dişil kanal
  pingala, // Güneş/eril kanal
}

extension NadiExtension on Nadi {
  String get nameTr {
    switch (this) {
      case Nadi.sushumna:
        return 'Sushumna - Merkezi Kanal';
      case Nadi.ida:
        return 'Ida - Ay Kanali';
      case Nadi.pingala:
        return 'Pingala - Güneş Kanali';
    }
  }

  String get quality {
    switch (this) {
      case Nadi.sushumna:
        return 'Denge, Bilinç, Aydınlanma';
      case Nadi.ida:
        return 'Dişil, Serinlik, Alıcılık';
      case Nadi.pingala:
        return 'Eril, Sıcaklık, Eylem';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// VERİ MODELLERİ
// ═══════════════════════════════════════════════════════════════════════════

/// Chakra detaylı içerik modeli
class ChakraContent {
  final Chakra chakra;
  final String sanskritMeaning;
  final String location;
  final String element;
  final String color;
  final String bijaMantra;
  final String deity;
  final String shaktiForm;
  final int petalCount;
  final String yantra;
  final String psychologicalThemes;
  final String physicalAssociations;
  final String blockedSymptoms;
  final String activatedSymptoms;
  final String kundaliniExperience;
  final String tantricPractices;
  final String affirmation;
  final List<String> balancingFoods;
  final List<String> balancingCrystals;
  final List<String> balancingAsanas;
  final String planetaryRuler;
  final String zodiacConnection;

  const ChakraContent({
    required this.chakra,
    required this.sanskritMeaning,
    required this.location,
    required this.element,
    required this.color,
    required this.bijaMantra,
    required this.deity,
    required this.shaktiForm,
    required this.petalCount,
    required this.yantra,
    required this.psychologicalThemes,
    required this.physicalAssociations,
    required this.blockedSymptoms,
    required this.activatedSymptoms,
    required this.kundaliniExperience,
    required this.tantricPractices,
    required this.affirmation,
    required this.balancingFoods,
    required this.balancingCrystals,
    required this.balancingAsanas,
    required this.planetaryRuler,
    required this.zodiacConnection,
  });
}

/// Nadi detaylı içerik modeli
class NadiContent {
  final Nadi nadi;
  final String sanskritMeaning;
  final String pathway;
  final String quality;
  final String energy;
  final String balancedState;
  final String imbalancedState;
  final String practices;
  final String breathingTechnique;
  final String astrologicalConnection;

  const NadiContent({
    required this.nadi,
    required this.sanskritMeaning,
    required this.pathway,
    required this.quality,
    required this.energy,
    required this.balancedState,
    required this.imbalancedState,
    required this.practices,
    required this.breathingTechnique,
    required this.astrologicalConnection,
  });
}

/// Kundalini pratik modeli
class KundaliniPractice {
  final String name;
  final String sanskritName;
  final String category;
  final String description;
  final String technique;
  final String benefits;
  final String precautions;
  final int durationMinutes;
  final String difficulty;
  final List<String> contraindications;

  const KundaliniPractice({
    required this.name,
    required this.sanskritName,
    required this.category,
    required this.description,
    required this.technique,
    required this.benefits,
    required this.precautions,
    required this.durationMinutes,
    required this.difficulty,
    required this.contraindications,
  });
}

/// Kundalini belirtisi modeli
class KundaliniSymptom {
  final String name;
  final String category;
  final String description;
  final String meaning;
  final String guidance;
  final bool isCommon;

  const KundaliniSymptom({
    required this.name,
    required this.category,
    required this.description,
    required this.meaning,
    required this.guidance,
    required this.isCommon,
  });
}

/// Granthi (düğüm) modeli
class GranthiContent {
  final String name;
  final String sanskritMeaning;
  final Chakra location;
  final String blockage;
  final String liberation;
  final String practices;

  const GranthiContent({
    required this.name,
    required this.sanskritMeaning,
    required this.location,
    required this.blockage,
    required this.liberation,
    required this.practices,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// KUNDALİNİ TEMELLERİ - SERPENT POWER
// ═══════════════════════════════════════════════════════════════════════════

class KundaliniFundamentals {
  static const String introduction = '''
KUNDALİNİ: UYUYAN YILAN GÜC

Kadim Sanskrit metinlerinde "Kundalini" kelimesi "kundala" kökünden gelir -
"kıvrılmış, sarılmış" anlamına taşır. Bu ilahi enerji, omurganın en alt
noktasında, kuyruk sokumu kemiğinin dibinde, üç buçuk kıvrımla sarılı
halde uyur - tıpkı yuvasında kıvrılmış bir yılan gibi.

Ama bu sıradan bir enerji değildir. Kundalini, evrenin yaratıcı gücü olan
Shakti'nin bireysel bedendeki tezahürüdür. O, mikrokozmos içindeki
makrokozmostur. Uyanışı, insanın sınırlı benliğinden sınırsız bilince
geçişini simgeler.

Tantrik geleneğe göre, Kundalini dişil ilahi prensiptir - Shakti.
Taç chakrada bekleyen eril ilahi prensip Shiva ile birleşmek için
omurga boyunca yükselir. Bu yükseliş, sadece enerjetik bir olay
değil, bilincin evriminin ta kendisidir.
''';

  static const String serpentPowerExplanation = '''
YILAN GÜCÜ (SERPENT POWER) AÇIKLAMASI

Yılan sembolizmi evrenseldir. Mısır'da Uraeus, Yunan'da Asklepios'un
asası, Aztek'te Quetzalcoatl, Hint'te Kundalini - hepsi aynı kadim
bilgeliğe işaret eder: Yılan, dönüşümün ve yeniden doğuşun sembolüdür.

Kundalini'nin yılan olarak tasvir edilmesinin derin anlamları vardır:

1. DERİ DEĞİŞTİRME
Yılan deri değiştirir, kendini yeniler. Kundalini uyanışı da
eski benliğin ölümü, yeni benliğin doğuşudur. Her chakradan
geçişte, eski kimlikler, inançlar ve sınırlamalar dökülür.

2. SARMAL HAREKET
Kundalini düz bir çizgide yükselmez. DNA'nın çift sarmalı gibi,
Ida ve Pingala nadileri etrafında dans ederek yükselir. Bu
sarmal, evrenin temel geometrisidir - galaksilerden atomlara.

3. ZEHİR VE NEKTAR
Yılan hem zehir hem şifa taşır. Kundalini de hazırlıksız
bedende "zehir" etkisi yaratabilir - fiziksel ve psikolojik
krizler. Ama arınmış bedende, ölümsüzlük nektarı (amrita)
olur. Her şey hazırlığa bağlıdır.

4. TOPRAK BAĞLANTISI
Yılan toprağa yakındır, köklere bağlıdır. Kundalini de
kök chakrada başlar - maddesel varoluşun en yoğun noktasında.
Spiritüellik, toprağı reddetmek değil, topraktan göğe
köprü kurmaktır.

5. HİPNOTİK GÜÇ
Yılanın bakışı hipnotize eder. Kundalini uyanışı da
olağan bilinç halini "hipnotize ederek" daha yüksek
farkındalık durumlarına geçiş sağlar.
''';

  static const String shaktiExplanation = '''
SHAKTİ: İLAHİ DİŞİL ENERJİ

Shakti, Sanskrit'te "güç, enerji, yetenek" anlamına gelir. Ama tantrik
felsefede çok daha derin bir anlam taşır: Shakti, evrenin dinamik,
yaratıcı, dişil prensibidir.

Shiva durağan bilinçtir - saf farkındalık, değişmeyen tanık.
Shakti ise hareket, yaratım, tezahür - bilincin dansıdır.

Birlikte, gerçekliğin tamamını oluştururlar. Ne Shiva Shakti'siz
var olabilir, ne Shakti Shiva'sız. Tantrik metinler der ki:
"Shiva, Shakti olmadan şava'dır (ceset)."

Kundalini, Shakti'nin bireysel bedendeki uykudaki formudur.
Uyanışı, Shakti'nin kendi kaynağı Shiva'ya (taç chakrada)
dönüş yolculuğudur. Bu dönüş, aynı zamanda bilincin
madde'den ruha, sınırlıdan sınırsıza evrimidir.

SHAKTİ'NİN ÜÇ TEMEL GÜCÜ (TRİPURA):

1. ICCHA SHAKTI (İrade Gücü)
İstek, niyet, motivasyonun kaynağı. Muladhara ile bağlantılı.
"Yapmak istiyorum" enerjisi.

2. JNANA SHAKTI (Bilgi Gücü)
Anlama, kavrama, aydınlanma kapasitesi. Ajna ile bağlantılı.
"Biliyorum, görüyorum" enerjisi.

3. KRIYA SHAKTI (Eylem Gücü)
Tezahür ettirme, yaratma, gerçekleştirme. Manipura ile bağlantılı.
"Yapıyorum, yaratıyorum" enerjisi.

Kundalini uyanışında bu üç güç dengeli şekilde aktive olmalıdır.
Sadece iradenin uyanışı obsesyona, sadece bilginin uyanışı
soğuk entelektüalizme, sadece eylemin uyanışı kontrolsüz
aktivizme yol açar.
''';

  static const String historicalOrigins = '''
TARİHSEL KÖKENLER

Kundalini kavramı binlerce yıllık bir geçmişe sahiptir. Ancak
yazılı kaynaklar belirli dönemlere işaret eder:

VEDİK DÖNEM (MÖ 1500-500)
Rigveda'da "tapas" (içsel ateş) kavramı var. Upanişadlar'da
prana ve nadiler hakkında ilk sistematik açıklamalar.

TANTRİK DÖNEM (MS 500-1200)
Kundalini'nin altın çağı. Hatha Yoga Pradipika, Shiva Samhita,
Gheranda Samhita gibi temel metinler yazıldı. Chakra sistemi
detaylandırıldı.

KAŞMIR ŞAİVİZMİ (MS 800-1100)
Abhinavagupta ve diğer üstatlar, Kundalini'yi felsefi ve
deneyimsel olarak derinleştirdi. Spanda (titreşim) doktrini
geliştirildi.

NATH GELENEĞİ (MS 1000-1400)
Gorakhnath ve takipçileri, Hatha Yoga'yı sistemleştirdi.
Kundalini pratikleri geniş kitlelere yayıldı.

MODERN DÖNEM (1900-Günümüz)
Swami Vivekananda, Paramahansa Yogananda, Swami Muktananda
gibi üstatlar Kundalini bilgisini Batı'ya taşıdı. Günümüzde
hem geleneksel hem modern yorumlar bir arada var.

UYARI: Modern "Kundalini Yoga" (Yogi Bhajan geleneği) ile
klasik tantrik Kundalini arasında önemli farklar vardır.
Her ikisi de değerlidir, ama kökenler ve metodoloji farklıdır.
''';

  static const String pranaRelationship = '''
PRANA VE KUNDALİNİ İLİŞKİSİ

Prana ve Kundalini sık sık karıştırılır, ama aralarında
önemli farklar ve derin bağlantılar vardır.

PRANA: YAŞAM ENERJİSİ
Prana, evrensel yaşam enerjisidir. Her nefeste alırız,
yiyeceklerden, güneşten, doğadan absorbe ederiz. Beden
fonksiyonlarını sürdüren temel enerjidir.

Prana beş ana forma ayrılır (Pancha Prana):
• Prana Vayu: Göğüste, alıma yönetir
• Apana Vayu: Pelvik bölgede, atıma yönetir
• Samana Vayu: Karında, sindirim/özümsemeyi yönetir
• Udana Vayu: Boğazda, konuşma/yükselişi yönetir
• Vyana Vayu: Tüm bedende, dolaşımı yönetir

KUNDALİNİ: UYUYAN POTANSİYEL
Kundalini ise sıradan prana değildir. O, bilincin evrimsel
potansiyelidir - uykuda bekleyen ilahi enerji. Prana
günlük yaşamı sürdürürken, Kundalini aydınlanmaya yol açar.

İLİŞKİ NASIL İŞLER?
Pranayama (nefes çalışmaları) prana'yı yoğunlaştırır ve
yönlendirir. Yeterli prana birikimi ve doğru yönlendirme,
Kundalini'yi uyandıran kıvılcım olabilir.

Metafor: Prana elektrik gibidir - sürekli akar, cihazları
çalıştırır. Kundalini ise yıldırım gibidir - nadir ama
dönüştürücü, dünyayı değiştiren güç.

Prana'sız Kundalini uyanamaz. Ama Kundalini uyandığında,
prana'nın ötesine geçer - saf bilinç enerjisi olur.
''';

  static const String subtleBodyAnatomy = '''
İNCE BEDEN ANATOMİSİ (SUKSHMA SHARIRA)

Tantrik anatomi, fiziksel bedenin ötesinde "ince beden"
kavramını tanımlar. Bu ince beden, nadiler, chakralar
ve prana'dan oluşan enerjetik yapıdır.

NADİ SİSTEMİ
Geleneksel olarak 72.000 nadi olduğu söylenir. Bunlar
ince enerji kanallarıdır - fiziksel sinirler veya
damarlar değil, ama onlarla bağlantılı.

Ana üç nadi:
1. SUSHUMNA: Omurga içinde, merkezi kanal
2. IDA: Sol taraf, ay enerjisi
3. PINGALA: Sağ taraf, güneş enerjisi

Ida ve Pingala, Muladhara'dan başlayıp her chakrada
çapraz yaparak Ajna'da birleşir. Sushumna ise düz
bir hat olarak merkezden geçer.

CHAKRA SİSTEMİ
Yedi ana chakra, Sushumna üzerinde enerji merkezleri
olarak bulunur. Her biri farklı bilinç seviyesini,
elementleri ve yaşam alanlarını yönetir.

GRANTHİLER (DÜĞÜMLER)
Üç psişik düğüm, Kundalini'nin yükselişini "engelleyen"
ama aynı zamanda "koruyan" yapılardır:
• Brahma Granthi (Muladhara-Svadhisthana)
• Vishnu Granthi (Manipura-Anahata)
• Rudra Granthi (Vishuddha-Ajna)

Bu düğümler, Kundalini'nin hazırlıksız yükselmesini
önler. Ama çalışmalarla açıldığında, büyük dönüşümler
ve serbest bırakılmalar yaşanır.

KOŞALAR (ÖRTÜLER)
Beş koşa, bilinci "örten" katmanlardır:
1. Annamaya Koşa: Fiziksel beden
2. Pranamaya Koşa: Enerji bedeni
3. Manomaya Koşa: Zihinsel beden
4. Vijnanamaya Koşa: Bilgelik bedeni
5. Anandamaya Koşa: Mutluluk bedeni

Kundalini bu koşaları "deler" ve saf bilince ulaşır.
''';
}

// ═══════════════════════════════════════════════════════════════════════════
// ÜÇ ANA NADİ - DETAYLI İÇERİK
// ═══════════════════════════════════════════════════════════════════════════

final Map<Nadi, NadiContent> nadiContents = {
  Nadi.sushumna: const NadiContent(
    nadi: Nadi.sushumna,
    sanskritMeaning: '"Çok zarif" veya "çok nazik" - en ince, en saf kanal',
    pathway: '''
Sushumna, omurganın tam merkezinde, medulla oblongata'dan (beyin sapı)
kuyruk sokumu kemiğine kadar uzanan merkezi enerji kanalıdır.

Fiziksel olarak spinal kord ile örtüşür, ama onunla aynı değildir.
Daha ince bir boyutta var olur. İçinde üç iç içe kanal daha vardır:
• Vajra Nadi (en dış)
• Chitrini Nadi (orta)
• Brahma Nadi (en iç, en ince)

Kundalini, en içteki Brahma Nadi boyunca yükselir. Bu kanal o kadar
incedir ki, sadece en rafine enerji geçebilir. Bu nedenle arınma
ve hazırlık bu kadar önemlidir.
''',
    quality: 'Denge, Nötralite, Saf Bilinç',
    energy: '''
Sushumna ne sıcak ne soğuktur, ne eril ne dişil. O, tüm zıtlıkların
ötesinde, saf denge halidir. Aktive olduğunda, zihin durur, zaman
durur, benlik erir - sadece saf farkındalık kalır.

Normal insanlarda Sushumna nadiren aktiftir. Prana genellikle
Ida veya Pingala'dan akar. Ama meditasyon, pranayama ve çalışmalarla
Sushumna açılabilir. O an, "sandhi" (kavşak) denir - derin
meditasyon durumları için kapı açılır.
''',
    balancedState: '''
Sushumna aktif olduğunda:
• Zihin sessizleşir, düşünceler durulur
• Zamansızlık hissi, "an"da kalma
• Derin huzur, içsel sessizlik
• Meditasyon doğal ve zahmetsiz olur
• Psişik algılar açılabilir
• Kundalini yükselişi mümkün olur
''',
    imbalancedState: '''
Sushumna bloke olduğunda:
• Sürekli zihinsel gürültü
• Meditasyonda zorluk
• Dengesiz duygusal durumlar
• Fiziksel ve enerjetik tıkanıklıklar
• Spiritüel gelişimde durgunluk
''',
    practices: '''
SUSHUMNA'YI AKTİVE ETME PRATİKLERİ:

1. NADİ SHODHANA (Alternatif Burun Nefesi)
En temel ve güvenli pratik. Ida ve Pingala'yı dengeler,
Sushumna'nın açılmasına zemin hazırlar.

2. KUMBHAKA (Nefes Tutma)
Nefes tutma sırasında prana Sushumna'ya yönelir.
Ama dikkatli olunmalı - aşırı kumbhaka tehlikeli olabilir.

3. MUDRAlar
Özellikle Khechari Mudra (dilin damağa kıvrılması) ve
Shambhavi Mudra (kaşlar arasına odaklanma) Sushumna'yı
aktive eder.

4. MEDİTASYON
Omurga boyunca ışık hayal etme, chakralar arasında
farkındalık gezintisi yapma.

5. BANDHA'lar
Üç bandha bir arada (Maha Bandha) Sushumna'yı güçlü
şekilde uyarır. Ama sadece deneyimli pratisyenler için.
''',
    breathingTechnique: '''
SUSHUMNA NİDRA (Sushumna Uyandırma Nefesi)

1. Rahat bir meditasyon pozisyonunda otur
2. Omurgayı düzelt, başı hafifçe eğ (Jalandhara Bandha)
3. Sol burun deliğinden derin nefes al (Ida)
4. Nefesi tut, dikkatini omurganın tabanına ver
5. Enerjiyi omurga boyunca yukarı çıktığını hayal et
6. Sağ burun deliğinden yavaşça ver (Pingala)
7. Tekrarla, her seferinde ortada (Sushumna) hisset

Başlangıçta 5-10 dakika, zamanla uzat.
''',
    astrologicalConnection: '''
Sushumna, astrolojide Satürn ve Ketu ile ilişkilendirilir.

SATÜRN BAĞLANTISI:
Satürn, sınırlar, yapı, disiplin gezegenidir. Sushumna'nın
açılması da disiplin, sabır ve sürekli çalışma gerektirir.
Satürn transitlerinde spiritüel çalışmalar derinleşir.

KETU BAĞLANTISI:
Ketu, ayrılma, transcendence, geçmiş yaşam karması ile
ilgilidir. Sushumna aktive olduğunda, maddi dünyadan
ayrılma, benliğin ötesine geçme deneyimleri yaşanır.

Doğum haritasında güçlü Satürn veya Ketu, Kundalini
uyanışına doğal yatkınlığa işaret edebilir. Özellikle
8. ev veya 12. ev vurgusu önemlidir.
''',
  ),

  Nadi.ida: const NadiContent(
    nadi: Nadi.ida,
    sanskritMeaning: '"Konfor, rahat" - besleyici, dinlendirici kanal',
    pathway: '''
Ida nadi, sol burun deliğinden başlayıp Muladhara'ya inen,
sonra her chakrada Pingala ile çapraz yaparak Ajna'da
(üçüncü göz) birleşen enerji kanalıdır.

Sol beden yarısıyla ve beynin sağ hemisfer ile bağlantılıdır.
Parasempatik sinir sistemiyle de ilişkilidir - dinlenme,
sindirme, iyileşme süreçlerini yönetir.

Ida, ay enerjisi taşır. Serinletici, sakinleştirici,
içe dönük. Gece aktiftir, introvert etkinlikler için
uygundur: meditasyon, yaratıcı çalışma, uyku.
''',
    quality: 'Dişil, Alıcı, Sezgisel, Serinletici',
    energy: '''
Ida enerjisi:
• Yin, dişil, pasif (alıcı anlamda)
• Serinlik, nemlilik (ay gibi)
• İçe dönüklük, tefekkür
• Sezgi, rüyalar, hayal gücü
• Duygusal derinlik, empati
• Geçmiş, anılar, kökler

Ida, "anımsama" ile ilgilidir. Geçmiş yaşamlar, çocukluk
anıları, bilinçdışı malzeme Ida üzerinden yüzeye çıkar.
''',
    balancedState: '''
Ida dengeli olduğunda:
• Derin sezgisel bilgi
• Sağlıklı duygusal ifade
• İyi uyku kalitesi
• Yaratıcı akış
• Empati ve şefkat
• Rahat, stressiz hal
• Spiritüel alıcılık
''',
    imbalancedState: '''
Ida aşırı aktif olduğunda:
• Aşırı pasiflik, tembellik
• Depresif eğilimler
• Soğukluk, bağlanamama
• Aşırı hayalcilik, gerçeklikten kopma
• Melankoli, geçmişte takılma
• Fiziksel soğukluk, yavaş metabolizma

Ida zayıf olduğunda:
• Sezgiden kopukluk
• Uyku sorunları
• Yaratıcılık blokajı
• Duygusal körlük
• Aşırı rasyonellik
''',
    practices: '''
IDA'YI DENGELEME PRATİKLERİ:

IDA AKTİVASYONU İÇİN:
1. Chandra Bhedana: Sadece sol burundan nefes al, sağdan ver
2. Sol burun deliğini tıkayıp sağ burunla nefes al (Ida'yı azaltır)
3. Sağ tarafına yatarak dinlen (sol burun açılır)
4. Ay ışığında meditasyon
5. Serinletici yiyecekler (salatalık, hindistancevizi)
6. Beyaz ve gümüş renklerle çalışma
7. Su kenarında vakit geçirme

IDA AŞIRI AKTİFSE:
1. Surya Bhedana: Sadece sağ burundan nefes al
2. Fiziksel aktivite, hareket
3. Sıcak, baharatlı yiyecekler
4. Güneş ışığı, ateş yanında oturma
5. Kırmızı ve turuncu renklerle çalışma
''',
    breathingTechnique: '''
CHANDRA BHEDANA (Ay Nefesi)

Bu teknik Ida'yı güçlendirir, serinletir, sakinleştirir.

1. Sukhasana veya Padmasana'da otur
2. Sağ el Vishnu Mudra'da (işaret ve orta parmak bükülü)
3. Sağ başparmakla sağ burun deliğini kapat
4. Sol burun deliğinden yavaşça ve derin nefes al (4 sayı)
5. Her iki deliği kapatıp tut (16 sayı - ileri seviye)
6. Sağ burun deliğinden yavaşça ver (8 sayı)
7. 10-15 döngü tekrarla

ETKİLERİ:
• Zihni sakinleştirir
• Vücut ısısını düşürür (yazın ideal)
• Kan basıncını düzenler
• Uyku kalitesini artırır
• Sezgiyi güçlendirir

UYARI: Düşük tansiyon, soğuk algınlığı, depresyon
varsa dikkatli olunmalı veya kaçınılmalı.
''',
    astrologicalConnection: '''
Ida, Ay (Chandra) ile doğrudan bağlantılıdır.

AY BAĞLANTISI:
Ay, duygular, anne, ev, sezgi, bilinçdışı ile ilgilidir.
Ida da aynı temaları taşır. Dolunay'da Ida doğal olarak
daha aktiftir, yeniay'da daha zayıf.

Doğum haritasında Ay'ın konumu Ida'nın doğal gücünü gösterir:
• Güçlü Ay (Yengeç, Boğa): Güçlü Ida, sezgisel doğa
• Zayıf Ay (Akrep, Oğlak): Duygusal zorluklar, Ida blokajları
• Ay-Neptün açısı: Aşırı Ida, sınır sorunları

Ay evreleriyle çalışma Ida'yı dengeler:
• Dolunay: Ida meditasyonları için ideal
• Yeniay: Pingala çalışmaları için uygun
• Büyüyen ay: Ida'yı güçlendirme
• Küçülen ay: Ida'yı sakinleştirme
''',
  ),

  Nadi.pingala: const NadiContent(
    nadi: Nadi.pingala,
    sanskritMeaning: '"Kızılımsı, turuncu" - güneşin rengi, ateşin enerjisi',
    pathway: '''
Pingala nadi, sağ burun deliğinden başlayıp Muladhara'ya inen,
sonra Ida ile çapraz yaparak her chakrada dans edip Ajna'da
birleşen enerji kanalıdır.

Sağ beden yarısıyla ve beynin sol hemisferi ile bağlantılıdır.
Sempatik sinir sistemini temsil eder - savaş ya da kaç
tepkisi, eylem, hareket.

Pingala, güneş enerjisi taşır. Isıtıcı, uyarıcı, dışa
dönük. Gündüz aktiftir, ekstrovert etkinlikler için
uygundur: iş, spor, sosyal aktiviteler.
''',
    quality: 'Eril, Verici, Analitik, Isıtıcı',
    energy: '''
Pingala enerjisi:
• Yang, eril, aktif (verici anlamda)
• Sıcaklık, kuruluk (güneş gibi)
• Dışa dönüklük, eylem
• Mantık, analiz, hesaplama
• İrade gücü, kararlılık
• Gelecek, planlama, hedefler

Pingala, "unutma" ile ilgilidir. Geçmişi bırakma, ileri
hareket etme, yeni başlangıçlar Pingala üzerinden olur.
''',
    balancedState: '''
Pingala dengeli olduğunda:
• Sağlıklı enerji seviyesi
• Net düşünme, keskin zeka
• Etkili iletişim
• Güçlü irade
• Fiziksel dayanıklılık
• Liderlik yeteneği
• Hedefe yönelik eylem
''',
    imbalancedState: '''
Pingala aşırı aktif olduğunda:
• Agresiflik, öfke patlamaları
• Aşırı rekabetçilik
• Tükenmişlik, burnout
• Uyku sorunları, insomnia
• Sindirim problemleri
• Aşırı ısınma, ateş basması
• Empati eksikliği

Pingala zayıf olduğunda:
• Enerji düşüklüğü
• Motivasyon kaybı
• Karar verememe
• Fiziksel zayıflık
• Özgüven eksikliği
''',
    practices: '''
PINGALA'YI DENGELEME PRATİKLERİ:

PINGALA AKTİVASYONU İÇİN:
1. Surya Bhedana: Sadece sağ burundan nefes al, soldan ver
2. Sağ burun deliğini tıkayıp sol burunla nefes al (Pingala'yı azaltır)
3. Sol tarafına yatarak dinlen (sağ burun açılır)
4. Güneş ışığında meditasyon (sabah güneşi ideal)
5. Isıtıcı yiyecekler (zencefil, biber, tarçın)
6. Kırmızı ve turuncu renklerle çalışma
7. Fiziksel egzersiz, özellikle güçlendirici hareketler

PINGALA AŞIRI AKTİFSE:
1. Chandra Bhedana: Sadece sol burundan nefes al
2. Yavaş, sakin aktiviteler
3. Serinletici yiyecekler
4. Su kenarında, doğada vakit geçirme
5. Mavi ve yeşil renklerle çalışma
6. Meditasyon, tefekkür
''',
    breathingTechnique: '''
SURYA BHEDANA (Güneş Nefesi)

Bu teknik Pingala'yı güçlendirir, ısıtır, enerji verir.

1. Sukhasana veya Padmasana'da otur
2. Sol el dizde Chin Mudra'da
3. Sağ el Vishnu Mudra'da
4. Sol başparmakla sol burun deliğini kapat
5. Sağ burun deliğinden yavaşça ve derin nefes al (4 sayı)
6. Her iki deliği kapatıp tut (16 sayı - ileri seviye)
7. Sol burun deliğinden yavaşça ver (8 sayı)
8. 10-15 döngü tekrarla

ETKİLERİ:
• Enerji seviyesini artırır
• Vücut ısısını yükseltir (kışın ideal)
• Sindirim ateşini (agni) güçlendirir
• Zihni canlandırır, odaklanmayı artırır
• Depresyona karşı etkili

UYARI: Yüksek tansiyon, kalp sorunları, ateş,
aşırı sıcaklarda kaçınılmalı. Akşam yapılmamalı.
''',
    astrologicalConnection: '''
Pingala, Güneş (Surya) ile doğrudan bağlantılıdır.

GÜNEŞ BAĞLANTISI:
Güneş, benlik, irade, vitalite, baba, otorite ile ilgilidir.
Pingala da aynı temaları taşır. Gündüz saatlerinde Pingala
doğal olarak daha aktiftir.

Doğum haritasında Güneş'in konumu Pingala'nın doğal gücünü gösterir:
• Güçlü Güneş (Aslan, Koç): Güçlü Pingala, liderlik
• Zayıf Güneş (Terazi, Kova): İrade zorlukları, Pingala zayıflığı
• Güneş-Mars açısı: Aşırı Pingala, öfke eğilimi

Mars da Pingala ile ilişkilidir - eylem, enerji, savaşçı ruhu.

Güneş geçişleriyle çalışma Pingala'yı dengeler:
• Gün doğumu: Pingala aktivasyonu için ideal (Surya Namaskar)
• Öğle: Pingala zirvede - yoğun aktiviteler için
• Gün batımı: Pingala'dan Ida'ya geçiş
• Gece: Ida dominantlığı
''',
  ),
};

// ═══════════════════════════════════════════════════════════════════════════
// 72.000 NADİ SİSTEMİ
// ═══════════════════════════════════════════════════════════════════════════

class NadiSystem {
  static const String overview = '''
72.000 NADİ: İNCE BEDEN AĞI

Tantrik anatomi, bedende 72.000 enerji kanalı (nadi) olduğunu
öğretir. Bu sayı sembolik olabilir, ama ince bedenin ne kadar
karmaşık ve kapsamlı olduğunu gösterir.

Bu nadiler, prana'nın (yaşam enerjisi) tüm bedene dağılmasını
sağlar. Tıpkı kan damarlarının kanı taşıması gibi, nadiler
de prana'yı taşır.

SINIFLANDIRMA:

1. ÜÇ ANA NADİ
Sushumna, Ida, Pingala - en önemli ve en güçlü üç kanal.

2. ON DÖRT ÖNEMLİ NADİ
Ana üçe ek olarak 11 önemli nadi daha vardır:
• Gandhari: Sol gözden başlar, Ida ile birlikte aşağı iner
• Hastijihva: Sağ gözden başlar, Pingala ile birlikte aşağı iner
• Kuhu: Cinsel organlarla bağlantılı
• Saraswati: Dil ve konuşmayla bağlantılı
• Pusha: Sağ kulakla bağlantılı
• Shankhini: Sol kulakla bağlantılı
• Payasvini: Sağ kulak ile Pusha arasında
• Varuni: Tüm bedene yayılır, boşaltımla ilgili
• Alambusha: Ağız ve boşaltım arasında bağlantı
• Vishvodhara: Nabhi (göbek) bölgesinde, sindirimle ilgili
• Yashasvini: Sol ayak başparmağından sol kulağa uzanır

3. KALAN 71.986 NADİ
Tüm bedene yayılan daha ince kanallar ağı.
''';

  static const String blockagesAndClearing = '''
NADİ BLOKLARI VE TEMİZLEME

Nadiler çeşitli nedenlerle bloke olabilir:
• Yanlış beslenme ve yaşam tarzı
• Bastırılmış duygular
• Fiziksel travmalar
• Zihinsel stres
• Çevresel toksinler
• Spiritüel ihmal

BLOKAJ BELİRTİLERİ:
• Kronik yorgunluk
• Duygusal dengesizlik
• Fiziksel ağrılar (özellikle omurga boyunca)
• Zihinsel bulanıklık
• Meditasyonda zorluk
• Enerji akışında hissedilen tıkanıklıklar

TEMİZLEME PRATİKLERİ:

1. NADİ SHODHANA (Alternatif Burun Nefesi)
En temel ve en güvenli temizleme tekniği. Günde
15-20 dakika yapıldığında, tüm nadi sistemi
zamanla arınır.

2. KAPALABHATI (Kafatası Parlatma Nefesi)
Hızlı, ritmik nefes verişleriyle nadiler temizlenir.
Enerji birikintileri atılır.

3. BHASTRIKA (Körük Nefesi)
Daha yoğun bir temizleme. Blokajları "eritir" ama
dikkatli uygulanmalı.

4. ASANA
Yoga pozisyonları fiziksel blokajları çözer,
enerji akışını sağlar.

5. BANDHA
Üç bandha (Mula, Uddiyana, Jalandhara) nadileri
temizler ve prana'yı yönlendirir.

6. KRIYA
Satkarma (altı arınma tekniği): Neti, Dhauti,
Nauli, Basti, Kapalbhati, Trataka.

7. SATTVIK DİYET
Temiz, hafif, canlı yiyecekler nadileri temiz tutar.

8. ETİK YAŞAM
Yama ve Niyama'lar (ahimsa, satya, vb.) zihinsel
ve duygusal blokajları önler.
''';
}

// ═══════════════════════════════════════════════════════════════════════════
// YEDİ CHAKRA YOLCULUĞU - DETAYLI İÇERİK
// ═══════════════════════════════════════════════════════════════════════════

final Map<Chakra, ChakraContent> chakraContents = {
  // ─────────────────────────────────────────────────────────────────────────
  // 1. MULADHARA - KÖK CHAKRA
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.muladhara: const ChakraContent(
    chakra: Chakra.muladhara,
    sanskritMeaning: '''
"Mula" = Kök, Temel, Kaynak
"Adhara" = Destek, Temel, Dayanak

Muladhara, varoluşun temeli, tüm yapının üzerine kurulduğu
kök sistemdir. Tıpkı bir ağacın görünmez kökleri gibi, bu
chakra bizi maddesel dünyaya bağlar ve besler.
''',
    location: '''
Fiziksel olarak perine bölgesinde (erkeklerde anüs ile skrotum
arası, kadınlarda anüs ile vajina arası) yer alır. Omurganın
en alt noktasında, kuyruk sokumu (coccyx) hizasındadır.

Enerjetik olarak tüm ince bedenin temelidir. Burası Kundalini
Shakti'nin uyuduğu yerdir - yılan üç buçuk kıvrımla sarılmış
halde, ağzı Sushumna'nın girişini kapatır.
''',
    element: '''
TOPRAK (Prithvi)

Toprak elementi, en yoğun, en katı elementtir. Stabilite,
sağlamlık, güvenlik, yapı anlamlarını taşır.

Muladhara'nın toprak elementi:
• Fiziksel bedenle bağlantı
• Maddi dünyada kök salma
• Güvenlik ve hayatta kalma içgüdüleri
• Pratiklik ve somutluk
• Yerçekimi ile uyum

Dengesizlikte: Ya aşırı maddecilik, donukluk; ya da
topraklanamama, havada kalma hissi.
''',
    color: '''
KIRMIZI

Derin, koyu kırmızı - kanın, ateşin, ilkel yaşam gücünün rengi.

Kırmızı titreşimi:
• En düşük frekanslı görünür ışık
• Fiziksel aktivasyon, enerji
• Hayatta kalma içgüdüsü
• Tutku, güç, cesaret
• Köklere ve atalarla bağlantı

Meditasyonda kırmızı ışık hayal etmek Muladhara'yı uyarır.
''',
    bijaMantra: '''
LAM (लं)

Telaffuz: Derin, rezonans yapan "LAAAMM" sesi.
Titreşim omurga tabanında hissedilmeli.

"Lam" toprak elementinin ses karşılığıdır. Bu sesi
çıkardığınızda, toprak elementi aktive olur, köklere
bağlantı güçlenir.

Pratik:
• Rahat otur, gözleri kapat
• Dikkatini perine bölgesine ver
• Derin nefes al
• Nefes verirken "LAAAMM" sesini çıkar
• Titreşimi kök bölgede hisset
• 21-108 tekrar yap

İleri seviye: Mula Bandha ile birlikte yapmak
etkiyi güçlendirir.
''',
    deity: '''
BRAHMA VE DAKİNİ

Brahma: Yaratıcı tanrı, evrenin başlangıcı. Dört yüzlü,
dört kollu, beyaz giyimli olarak tasvir edilir. Muladhara'da
yaratımın tohumu vardır.

Dakini: Muladhara'nın Shakti'si (dişil güç). Kırmızı giyimli,
dört kollu, üç gözlü. Bir elinde mızrak (koruma), diğerinde
kafatası kupası (ölümsüzlük nektarı). Korku ile yüzleşmeyi,
güvenliği temsil eder.
''',
    shaktiForm: '''
KUNDALİNİ SHAKTİ (Uyuyan Form)

Muladhara'da Shakti, Kundalini olarak uyur. Parlayan, ışıldayan
bir yılan olarak tasvir edilir - üç buçuk kıvrımla Shiva Lingam
(bilincin sembolü) etrafında sarılmış.

Uyuyan Kundalini:
• Potansiyel enerji - henüz aktive edilmemiş
• Evrenin yaratıcı gücünün mikrokozmik formu
• Uyanınca Sushumna'dan yükselecek
• Nihai hedef: Sahasrara'da Shiva ile birleşmek

Buradaki Shakti "tamasik" (atalet) karakterdedir -
hareketsiz, uyuyan, bekleyen.
''',
    petalCount: 4,
    yantra: '''
DÖRTGEN (Sarı Kare) + AŞAĞI BAKAN ÜÇGEN

Muladhara yantrası:
• Dış çember: Evrensel bilinç
• Dört yapraklı lotus: Dört yön, dört Veda, dört puruşartha
• Sarı kare: Toprak elementi, stabilite
• Aşağı bakan kırmızı üçgen: Shakti, dişil enerji
• Merkezdeki Shiva Lingam: Bilinç
• Etrafında sarılı yılan: Kundalini

Yantra meditasyonu için bu imgeyi zihinsel olarak
inşa edip, onda kalın.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

GÜVENLİK VE HAYATTA KALMA
• Temel ihtiyaçların karşılanması
• Fiziksel güvenlik hissi
• Maddi istikrar, barınma, beslenme
• "Dünya güvenli bir yer mi?" sorusu

AİLE VE KÖKENLER
• Kan bağı, aile sistemleri
• Ata kalıtımı (genetik ve enerjetik)
• Kabile bilinci
• Ait olma duygusu

İÇGÜDÜLER
• Savaş ya da kaç tepkisi
• Hayatta kalma mekanizmaları
• Beden farkındalığı
• Topraklanmış olma

KİMLİK TEMELLERİ
• "Ben varım" hissi
• Fiziksel bedende var olma
• Maddi dünyayla bağlantı
• Kök kimlik, isim, aile, ülke
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Bacaklar, ayaklar, kemikler
• Kalın bağırsak, rektum
• Böbrekler, böbreküstü bezleri
• Omurga temeli
• Bağışıklık sistemi temeli

BEZLER:
• Adrenal bezler (böbreküstü) - stres hormonu kortizol
• Gonorlar (kısmen) - temel cinsel enerji

SAĞLIK KONULARI:
• Kemik sağlığı, osteoporoz
• Alt sindirim sistemi
• Ayak/bacak sorunları
• Bağışıklık sistemi
• Kronik yorgunluk
''',
    blockedSymptoms: '''
BLOKE MULADHARA BELİRTİLERİ

FİZİKSEL:
• Kronik yorgunluk
• Alt sırt ağrısı
• Kabızlık, hemoroid
• Bağışıklık zayıflığı
• Bacak/ayak sorunları
• Kilo problemleri (aşırı yeme veya iştahsızlık)
• Uyku bozuklukları

DUYGUSAL:
• Sürekli korku ve endişe
• Güvensizlik, paranoya
• Maddi kaygılar
• Aile sorunları
• Öfke patlamaları
• Aşırı materyalizm veya tamamen reddetme

ZİHİNSEL:
• Odaklanamama
• Topraklanamama hissi
• "Havada" olma
• Gerçeklikten kopukluk
• Hayatta kalma modunda takılı kalma
• Çocukluk travmalarının yeniden yaşanması

SPİRİTÜEL:
• Spiritüel pratiklerde ilerleme olmaması
• "Yüksek" deneyimlerden sonra çakılma
• Beden-ruh bütünleşmesi eksikliği
''',
    activatedSymptoms: '''
AKTİVE MULADHARA BELİRTİLERİ

FİZİKSEL:
• Güçlü, dayanıklı beden
• İyi bağışıklık sistemi
• Sağlıklı enerji seviyesi
• Düzenli sindirim
• Rahat, derin uyku
• Bedenle barışık olma

DUYGUSAL:
• Temel güvenlik hissi
• Korku ile sağlıklı ilişki
• Aile konularıyla barışıklık
• Maddi dünyayla dengeli ilişki
• Duygusal istikrar

ZİHİNSEL:
• Topraklanmış düşünce
• Pratik zeka
• Kararlılık
• Odaklanma yeteneği
• "Şimdi ve burada" kalabilme

SPİRİTÜEL:
• Sağlam spiritüel temel
• Deneyimleri entegre edebilme
• Bedeni tapınak olarak kabul etme
• Madde ve ruh arasında köprü olma
''',
    kundaliniExperience: '''
KUNDALİNİ MULADHARA'DAN GEÇİŞ DENEYİMİ

BAŞLANGIÇ:
Kundalini uyanışı burada başlar. İlk deneyimler genellikle:
• Perine bölgesinde ısınma, titreşim
• Karıncalanma, "elektrik" hissi
• Spontan Mula Bandha (pelvik taban kasılması)
• Omurga tabanında basınç veya nabız hissi

YOĞUNLAŞMA:
Enerji birikir, basınç artar:
• Sıcak enerji dalgaları
• Perinede "atan" his
• Yoğun kök bölgesi farkındalığı
• Hayatta kalma içgüdülerinin yüzeye çıkması

DELİNME:
Kundalini Brahma Granthi'yi (ilk düğüm) deler:
• Patlayıcı enerji salınımı
• Derin, ilkel sesler çıkarma isteği
• Yoğun ısı (tapas)
• Korku ve güvenlik konularının çözülmesi
• Geçmiş travmaların yüzeye çıkması ve temizlenmesi

SONRASI:
• Derin topraklanma hissi
• Varoluşsal güvenlik
• Atalarla bağlantı hissi
• Dünyada "ev"de olma duygusu
• Fiziksel bedenle yeni, derin ilişki
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

1. MULA BANDHA
Pelvik taban kaslarını sıkma ve tutma. En temel ve
en önemli pratik. Kundalini'yi uyarır, enerjiyi yukarı
yönlendirir.

Teknik:
• Rahat otur
• Anal sfinkteri sık (erkeklerde skrotum ile anüs arası,
  kadınlarda serviks bölgesi)
• Tut, nefes normal devam
• 5-10 saniye tut, bırak
• Tekrarla

2. ASHWINI MUDRA
Anal sfinkteri ritmik olarak sıkıp bırakma. Muladhara'yı
"pompalama" etkisi yapar.

3. MULADHARA DRİŞTİ
Gözler kapalı, dikkat perine bölgesine sabitlenmiş
meditasyon. Saatlerce yapılabilir.

4. KÖK CHAKRA NEFES
Nefesi kök bölgesine "çekerek" enerji biriktirme.
Her nefeste köklerin büyüdüğünü hayal et.

5. BHUMI SPARSHA MUDRA
Yere dokunma mudrası (Buda'nın aydınlanma anı).
Toprakla fiziksel bağlantı.

6. RED LIGHT MEDİTASYON
Kırmızı ışık topunun kök bölgede parlayıp büyüdüğünü
hayal etme.

7. LAM MANTRA JAPASİ
108 kere "LAM" mantrası, her tekrarda vibrasyon
kök bölgede hissedilmeli.
''',
    affirmation: '''
MULADHARA OLUMLAMA

"Ben güvendeyim. Dünya beni destekliyor.
Köklerim derin, temelin sağlam.
Bedenim kutsal tapınağımdır.
Atalarımın bilgeliğini taşıyorum.
Varoluşum bir lütuftur.
Ben burdayım. Ben şimdi buradayım."

Sanskrit: "Om Lam - Muladharaya Namaha"
''',
    balancingFoods: [
      'Kırmızı yiyecekler: Pancar, domates, kırmızı biber',
      'Kök sebzeler: Havuç, patates, turp, zencefil',
      'Protein: Kırmızı et (seçime bağlı), baklagiller',
      'Topraktan gelen: Mantar, yer fıstığı',
      'Baharatlar: Zerdeçal, tarçın, karanfil',
    ],
    balancingCrystals: [
      'Kırmızı jasper - Güç ve stabilite',
      'Hematit - Topraklama',
      'Siyah turmalin - Koruma',
      'Dumanlı kuvars - Köklendirme',
      'Granat - Yaşam gücü',
      'Obsidyen - Negatif enerji temizliği',
    ],
    balancingAsanas: [
      'Tadasana (Dağ pozu) - Temel duruş',
      'Virabhadrasana I, II, III (Savaşçı pozları)',
      'Malasana (Çömelme pozu)',
      'Pavanamuktasana (Rüzgar salan poz)',
      'Apanasana (Dizler göğse)',
      'Savasana (Ceset pozu) - Toprakla tam temas',
    ],
    planetaryRuler: '''
MARS VE SATÜRN

Mars (Mangal):
• Enerji, eylem, hayatta kalma içgüdüsü
• Cesaret, güç, mücadele
• Kırmızı renk bağlantısı
• Adrenal bezler yönetimi

Satürn (Shani):
• Yapı, sınırlar, temel
• Kemikler, omurga
• Sabır, disiplin, dayanıklılık
• Karma, atalar, kökenler
''',
    zodiacConnection: '''
KOÇ VE OĞLAK

Koç (Aries):
• İlk burç - yeni başlangıç
• Mars yönetimi
• Hayatta kalma içgüdüsü
• Cesaret, öncülük

Oğlak (Capricorn):
• Satürn yönetimi
• Yapı, temel, ambisyon
• Toprak elementi
• Pratik gerçekçilik

Doğum haritasında bu burçlar veya yöneticileri vurgulanmışsa,
Muladhara temaları öne çıkar.
''',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // 2. SVADHISTHANA - SAKRAL CHAKRA
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.svadhisthana: const ChakraContent(
    chakra: Chakra.svadhisthana,
    sanskritMeaning: '''
"Sva" = Kendi, Öz
"Adhisthana" = Yer, Mekan, Konut

Svadhisthana, "kendi yeri" veya "öz mekan" anlamına gelir.
Burası bireysel benliğin ikametgahı, kişisel kimliğin ve
yaratıcılığın kaynağıdır.

Muladhara'dan farklı olarak, burada "ben" kolektiften
ayrışmaya başlar. Aile/kabile bilincinden bireysel
kimliğe geçiş bu chakrada gerçekleşir.
''',
    location: '''
Göbeğin yaklaşık 4 parmak altında, pubik kemiğin üzerinde,
sakrum (kuyruk sokumu üstü) hizasında bulunur. Kadınlarda
rahim, erkeklerde prostat bölgesiyle örtüşür.

Omurga üzerinde sakral vertebra (S1-S4) bölgesine karşılık
gelir. Cinsel organlar ve üreme sistemiyle doğrudan
bağlantılıdır.
''',
    element: '''
SU (Jala/Apas)

Su elementi, akışkanlık, adaptasyon, duygusallık temsil eder.
Tıpkı suyun her kalıba girmesi gibi, Svadhisthana da
esneklik ve değişimi yönetir.

Su elementinin özellikleri:
• Akış ve hareket
• Arınma ve temizleme
• Doğurganlık ve yaratıcılık
• Duyguların taşıyıcısı
• Hayatın kaynağı

Dengesizlikte: Ya duygusal taşkınlık, sınırsızlık; ya da
kurumuşluk, donukluk, yaratıcılık blokajı.
''',
    color: '''
TURUNCU

Canlı, sıcak turuncu - gün batımının, ateşin dansının rengi.

Turuncu titreşimi:
• Kırmızıdan sonraki frekans - yükseliş
• Yaratıcılık ve coşku
• Sosyallik ve sıcaklık
• Cinsellik ve haz
• Duygusal ifade

Turuncu, kırmızının fizikselliğini sarının zihinselliğiyle
birleştirir - böylece duygusal ve yaratıcı ifade ortaya çıkar.
''',
    bijaMantra: '''
VAM (वं)

Telaffuz: Yumuşak, akıcı "VAAMM" sesi.
Titreşim karın alt bölgesinde hissedilmeli.

"Vam" su elementinin ses karşılığıdır. Bu ses, duygusal
akışı başlatır, yaratıcılığı uyandırır, cinsel enerjiyi
canlandırır.

Pratik:
• Rahat otur veya yat
• Dikkatini göbek altına ver
• Derin nefes al
• Nefes verirken "VAAMM" sesini çıkar
• Sesin dalgalar gibi yayıldığını hisset
• 21-108 tekrar yap

Svadhisthana ile çalışırken duygular yüzeye çıkabilir -
buna izin ver, akışa bırak.
''',
    deity: '''
VİSHNU VE RAKİNİ

Vishnu: Koruyucu tanrı, evrenin sürdürücüsü. Mavi tenli,
dört kollu, lotus üzerinde tasvir edilir. Svadhisthana'da
hayatın devamını, döngüleri, korunmayı temsil eder.

Rakini: Svadhisthana'nın Shakti'si. Mavi giyimli, üç gözlü,
iki kollu. Elinde balta (bağımlılıkları kesme) ve lotus
(saflık). Duygusal arınmayı ve yaratıcı gücü simgeler.
''',
    shaktiForm: '''
KAKİNİ / RAKİNİ SHAKTİ

Bu chakrada Shakti daha hareketli, daha aktif formda.
Artık uyumuyor - dans etmeye başlıyor.

Shakti burada:
• Yaratıcı güç olarak tezahür eder
• Duygusal akışkanlık sağlar
• Cinsel/üreme enerjisini yönetir
• İlişkilerdeki çekimi düzenler

"Rajasik" (hareketli, tutkulu) karakter taşır.
Artık hareket var, arzu var, yaratma dürtüsü var.
''',
    petalCount: 6,
    yantra: '''
ALTI YAPRAKLI LOTUS + HİLAL AY

Svadhisthana yantrası:
• Dış çember: Evrensel bilinç
• Altı yapraklı lotus: Altı düşman (kama, krodha, vb.),
  aşılması gereken altı engel
• Beyaz hilal ay: Su elementi, ay döngüleri, dişil enerji
• Merkezdeki makara (timsah): Bilinçaltı güçler, içgüdüler
• Mavi su sembolleri: Akış, duygusallık

Ayın değişen evreleri gibi, bu chakra da sürekli
dönüşüm halindedir.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

DUYGULAR VE HİSSETME
• Duyguları deneyimleme kapasitesi
• Duygusal zeka
• Haz ve acı
• Neşe, üzüntü, korku, öfke

CİNSELLİK VE ARZU
• Cinsel kimlik
• Arzu ve haz ilişkisi
• Çekim ve cazibe
• İlişkisel dinamikler

YARATICILIK
• Sanatsal ifade
• Yeni fikirler üretme
• Problem çözme
• Hayallere form verme

İLİŞKİLER VE BAĞLANMA
• İkili ilişkiler
• Yakınlık ve mesafe
• Bağımlılık-bağımsızlık dengesi
• "Biz" bilinci (aileden sonra)
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Cinsel organlar
• Rahim, yumurtalıklar (kadın)
• Prostat, testisler (erkek)
• Mesane, böbrekler
• Kalça, pelvis
• Alt sırt

BEZLER:
• Gonadlar (cinsel bezler)
• Yumurtalıklar veya testisler
• Hormonlar: Östrojen, testosteron

SAĞLIK KONULARI:
• Üreme sistemi sağlığı
• Menstrüel düzen
• Cinsel fonksiyon
• Alt sırt sorunları
• Böbrek, mesane
• Vücut sıvıları dengesi
''',
    blockedSymptoms: '''
BLOKE SVADHISTHANA BELİRTİLERİ

FİZİKSEL:
• Cinsel işlev bozuklukları
• Üreme sistemi sorunları
• Alt sırt/kalça ağrısı
• Böbrek sorunları
• İdrar sistemi enfeksiyonları
• Menstrüel düzensizlikler
• Düşük enerji/libido

DUYGUSAL:
• Duygusal uyuşukluk veya aşırı reaktivite
• Haz alamama (anhedoni)
• Suçluluk duyguları
• Utanç, özellikle bedenle ilgili
• Bağımlılık eğilimleri
• İlişki sorunları
• Yakınlık korkusu veya bağımlılığı

ZİHİNSEL:
• Yaratıcılık blokajı
• Değişime direnç
• Katılık, esneklik kaybı
• Obsesif düşünceler (haz/arzu ile ilgili)

SPİRİTÜEL:
• Cinsellikle ilgili spiritüel çatışmalar
• Beden-ruh ayrımı
• Yaşamın tadını çıkaramama
• Asketik aşırılıklar veya hedonizm
''',
    activatedSymptoms: '''
AKTİVE SVADHISTHANA BELİRTİLERİ

FİZİKSEL:
• Sağlıklı cinsel yaşam
• Dengeli hormonlar
• Akıcı hareket, esneklik
• İyi hidrasyon, parlak cilt
• Güçlü üreme sağlığı

DUYGUSAL:
• Duyguları rahatça hissetme ve ifade etme
• Haz ve neşe kapasitesi
• Sağlıklı arzu ilişkisi
• Yakınlık kurabilme
• Duygusal dayanıklılık
• Akan yaratıcılık

ZİHİNSEL:
• Esnek düşünce
• Yaratıcı problem çözme
• Yeniliğe açıklık
• Oyunculuk, eğlenme kapasitesi

SPİRİTÜEL:
• Cinselliğin kutsallığını kavrama
• Yaratıcılığı spiritüel ifade olarak kullanma
• Bedensel hazları reddetmeden transcend etme
• Tantra anlayışı
''',
    kundaliniExperience: '''
KUNDALİNİ SVADHISTHANA'DAN GEÇİŞ DENEYİMİ

YAKLAŞIM:
Kundalini Muladhara'dan yükselip Svadhisthana'ya ulaştığında:
• Yoğun cinsel enerji dalgaları
• Pelvis bölgesinde ısı, titreşim
• Spontan kalça hareketleri
• Duygusal dalgalanmalar

YOĞUNLAŞMA:
• Cinsel enerjinin "yukarı çekilmesi" hissi
• Yoğun duygusal temizleme
• Geçmiş cinsel deneyimler/travmalar yüzeye çıkabilir
• Yaratıcı patlamalar
• Çok canlı, bazen erotik rüyalar

GEÇİŞ:
• Cinsel enerjinin dönüşümü (ojas'a)
• Duygusal serbestlik
• Yaratıcılık akışı
• İlişki kalıplarının farkındalığı
• Arzu ile özgür ilişki

ETKİLER:
• Duygusal arınma
• Yaratıcı güç artışı
• Cinselliğe yeni bakış
• Haz ve acı ötesi anlayış
• Shakti ile bilinçli ilişki
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

1. VAJROLİ/SAHAJOLİ MUDRA
Cinsel organların kasılması ve enerji yönlendirmesi.
Erkeklerde Vajroli, kadınlarda Sahajoli.

2. SVADHISTHANA NEFES
Nefesi pelvis bölgesine çekerek, orada tutarak,
turuncu ışık hayal ederek çalışma.

3. KALÇA AÇICI ASANALAR
Baddha Konasana, Mandukasana, Supta Baddha Konasana
gibi pozlar bu chakrayı açar.

4. SU MEDİTASYONU
Su kenarında oturma, suyun sesini dinleme,
akışla bir olma meditasyonu.

5. YARATICI İFADE
Dans, resim, müzik, yazı - duygusal enerjiyi
sanatsal forma dönüştürme.

6. AY FAZLARI ÇALIŞMASI
Ay döngüsüyle uyumlu pratikler. Dolunayda
duygusal ifade, yeniayda içe dönüş.

7. VAM MANTRA + HİP SİRKÜLASYON
Kalçaları dairesel hareket ettirirken VAM
mantrasını söyleme.
''',
    affirmation: '''
SVADHISTHANA OLUMLAMA

"Hayatın akışına güveniyorum.
Duygularım bilgeliğimin elçileridir.
Yaratıcı gücüm sınırsızdır.
Haz, varlığımın doğal parçasıdır.
Cinselliğim kutsaldır.
Ben akıyorum, dönüşüyorum, yaratıyorum."

Sanskrit: "Om Vam - Svadhisthanaya Namaha"
''',
    balancingFoods: [
      'Turuncu yiyecekler: Havuç, balkabağı, kayısı, portakal',
      'Sulu meyveler: Karpuz, kavun, şeftali',
      'Bal ve doğal tatlandırıcılar',
      'Hindistancevizi (suyu ve yağı)',
      'Balık ve deniz ürünleri',
      'Badem ve ceviz',
    ],
    balancingCrystals: [
      'Karneol - Yaratıcılık ve tutku',
      'Ay taşı - Dişil enerji',
      'Turuncu kalsit - Duygusal denge',
      'Amber (kehribar) - Sıcaklık ve ışık',
      'Sitrin - Neşe ve bolluk',
      'Mercan - Su elementi bağlantısı',
    ],
    balancingAsanas: [
      'Baddha Konasana (Kelebek pozu)',
      'Mandukasana (Kurbağa pozu)',
      'Eka Pada Rajakapotasana (Güvercin pozu)',
      'Utkata Konasana (Tanrıça pozu)',
      'Bhujangasana (Kobra pozu)',
      'Hip circles (Kalça daireleri)',
    ],
    planetaryRuler: '''
AY VE VENÜS

Ay (Chandra):
• Duygular, döngüler, değişim
• Dişil enerji, anne
• Su elementi bağlantısı
• Bilinçaltı, sezgi

Venüs (Shukra):
• Aşk, güzellik, sanat
• Cinsellik, çekim
• Haz ve zevk
• İlişkiler, uyum
''',
    zodiacConnection: '''
YENGEÇ VE BALIK

Yengeç (Cancer):
• Ay yönetimi
• Duygusal derinlik
• Ev, aile, yuva
• Koruyuculuk

Balık (Pisces):
• Su elementi doruk noktası
• Hayal gücü, rüyalar
• Duygusal emPati
• Spiritüel bağlantı

Doğum haritasında 2. ev, Venüs veya Ay vurgulu ise
Svadhisthana temaları öne çıkar.
''',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // 3. MANIPURA - GÜNEŞ AĞI CHAKRASI
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.manipura: const ChakraContent(
    chakra: Chakra.manipura,
    sanskritMeaning: '''
"Mani" = Mücevher, İnci
"Pura" = Şehir, Mekan

Manipura, "mücevherler şehri" veya "parıldayan mücevherin yeri"
anlamına gelir. Burası içsel güneşin, kişisel gücün ve
iradenin merkezi - parıldayan hazinelerin bulunduğu yer.

Ego'nun sağlıklı formda şekillendiği, dünyada etkili olma
kapasitesinin geliştiği chakradır.
''',
    location: '''
Göbek ile sternum (göğüs kemiği) arasında, solar pleksus
(güneş ağı) bölgesinde bulunur. Mideyle yakından ilişkilidir.

Omurga üzerinde torasik vertebralar (T6-T10) hizasına
karşılık gelir. Karın boşluğundaki birçok organı enerjetik
olarak etkiler.
''',
    element: '''
ATEŞ (Agni/Tejas)

Ateş elementi, dönüşüm, enerji, güç ve ışık temsil eder.
Sindirim ateşi (jatharagni) bu chakrada bulunur - hem
fiziksel hem enerjetik sindirim.

Ateş elementinin özellikleri:
• Dönüştürme ve arındırma
• Işık ve sıcaklık yayma
• Yukarı hareket (alev yükselir)
• İrade ve determinasyon
• Metabolizma ve enerji üretimi

Dengesizlikte: Ya aşırı ateş (öfke, kontrol tutkusu); ya da
ateş eksikliği (güçsüzlük, özgüven yoksunluğu).
''',
    color: '''
SARI

Parlak, güneş sarısı - aydınlık, güç, neşe ve zekanın rengi.

Sarı titreşimi:
• Güneş ışığı frekansı
• Zihinsel netlik
• Özgüven ve kişisel güç
• Neşe ve iyimserlik
• Sindirim ve metabolizma

Sarı, zihinsel ve fiziksel enerjiyi temsil eder. Çok fazlası
kaygıya, yetersizi depresyona yol açabilir.
''',
    bijaMantra: '''
RAM (रं)

Telaffuz: Güçlü, rezonans yapan "RAAMM" sesi.
Titreşim göbek-mide bölgesinde hissedilmeli.

"Ram" ateş elementinin ses karşılığıdır. Bu ses,
içsel ateşi (agni) uyandırır, iradenin gücünü aktive eder,
özgüveni güçlendirir.

Pratik:
• Rahat otur, omurgayı düzelt
• Dikkatini solar pleksus bölgesine ver
• Derin nefes al
• Nefes verirken güçlü "RAAMM" sesi çıkar
• Göbekte sıcak bir ateş topunun parladığını hisset
• 21-108 tekrar yap

Kapalabhati (ateş nefesi) ile birleştirmek
etkiyi artırır.
''',
    deity: '''
RUDRA VE LAKİNİ

Rudra: Shiva'nın yıkıcı/dönüştürücü yönü. Beyaz tenli,
kül sürünmüş, üç gözlü olarak tasvir edilir. Ego'nun
dönüşümünü, eski kalıpların yakılmasını temsil eder.

Lakini: Manipura'nın Shakti'si. Koyu tenli, kırmızı giyimli,
üç yüzlü, dört kollu. Elinde yıldırım (güç) ve ok (hedef).
Korku ile yüzleşme ve aşma gücünü simgeler.
''',
    shaktiForm: '''
LAKİNİ SHAKTİ

Manipura'da Shakti, savaşçı formunda. Artık sadece
dans etmiyor - dönüştürüyor, yakıyor, yeniden yaratıyor.

Shakti burada:
• Dönüştürücü güç olarak tezahür eder
• Engelleri yakar, yolu açar
• İradeyi ve kararlılığı yönetir
• Ego'yu olgunlaştırır

"Rajasik" karakterin zirvesi - tam güç, tam eylem.
Ama dikkat: Kontrolsüz olursa yıkıcı olabilir.
''',
    petalCount: 10,
    yantra: '''
ON YAPRAKLI LOTUS + AŞAĞI ÜÇGEN

Manipura yantrası:
• Dış çember: Evrensel bilinç
• On yapraklı lotus: On prana akımı
• Kırmızı aşağı bakan üçgen: Ateş elementi, sindirim
• Merkezdeki koç: Mars sembolü, güç hayvanı
• Parıldayan sarı güneş: Kişisel güç merkezi

Aşağı bakan üçgen, enerjinin sindirim ve dönüşüm için
yoğunlaştığını gösterir.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

KİŞİSEL GÜÇ VE İRADE
• Benlik gücü, ego sağlığı
• Karar verme yeteneği
• Hayatı yönlendirme kapasitesi
• "Ben yapabilirim" hissi

ÖZGÜVEN VE ÖZDEĞERLİK
• Kendine güven
• Yeteneklerin farkındalığı
• Başarı kapasitesi
• Öz saygı

KİMLİK VE BİREYSELLİK
• Ben kimim sorusu
• Sosyal kimlik
• Kariyerel kimlik
• Otantiklik arayışı

DÖNÜŞÜM VE GELİŞİM
• Zorlukları fırsata çevirme
• Krizlerden güçlenerek çıkma
• Eski kalıpları yakma
• Yenilenme ve büyüme
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Mide, pankreas
• Karaciğer, safra kesesi
• Dalak
• İnce bağırsak (üst kısım)
• Karın kasları
• Solar pleksus sinir ağı

BEZLER:
• Pankreas - İnsülin, kan şekeri
• Adrenal bezler (kısmen) - Kortizol
• Karaciğer fonksiyonları

SAĞLIK KONULARI:
• Sindirim sistemi
• Kan şekeri dengesi, diyabet
• Karaciğer sağlığı
• Mide ülseri, gastrit
• Metabolizma hızı
• Kronik yorgunluk
''',
    blockedSymptoms: '''
BLOKE MANIPURA BELİRTİLERİ

FİZİKSEL:
• Sindirim sorunları
• Kan şekeri dengesizlikleri
• Karaciğer problemleri
• Mide ülseri, reflü
• Düşük enerji, yorgunluk
• Kilo alma veya verme sorunları
• Bağırsak sorunları

DUYGUSAL:
• Düşük özgüven
• Güçsüzlük hissi
• Karar verememe
• Mağduriyet duygusu
• Öfke patlamaları veya bastırılmış öfke
• Reddedilme korkusu
• Utanç, değersizlik

ZİHİNSEL:
• Perfectionism veya tamamen vazgeçme
• Kontrolcülük veya kontrolsüzlük
• Obsesif düşünceler (başarı/başarısızlık)
• Karşılaştırma ve kıskançlık

SPİRİTÜEL:
• Spiritüel bypassing (egodan kaçış)
• Aşırı ego şişkinliği
• Güç oyunları
• Manipülasyon
''',
    activatedSymptoms: '''
AKTİVE MANIPURA BELİRTİLERİ

FİZİKSEL:
• Güçlü sindirim sistemi
• Dengeli metabolizma
• İyi enerji seviyeleri
• Güçlü çekirdek kaslar
• Sağlıklı karaciğer
• Dengeli kan şekeri

DUYGUSAL:
• Sağlıklı özgüven
• İrade gücü
• Duygusal dayanıklılık
• Sağlıklı sınırlar
• Öfkeyle yapıcı ilişki
• Liderlik kapasitesi

ZİHİNSEL:
• Net düşünme
• Karar verme yeteneği
• Hedef belirleme ve takip
• Problem çözme
• Kritik düşünce

SPİRİTÜEL:
• Sağlıklı ego (transcend etmek için gerekli)
• Güç ve alçakgönüllülük dengesi
• Hizmet odaklı liderlik
• Dönüşüm kapasitesi
''',
    kundaliniExperience: '''
KUNDALİNİ MANIPURA'DAN GEÇİŞ DENEYİMİ

VİSHNU GRANTHİ'YE YAKLAŞIM:
Kundalini Svadhisthana'dan yükselip Manipura'ya ulaştığında,
ikinci büyük düğümle (Vishnu Granthi) karşılaşır.

• Göbek bölgesinde yoğun ısı
• "İç ateş" hissi
• Spontan Uddiyana Bandha
• Sindirim değişimleri
• Güç dalgalanmaları

VİSHNU GRANTHİ:
Bu düğüm, dünyevi bağımlılıkları, statü, güç ve kontrol
arzularını temsil eder. Kundalini burayı geçerken:
• Ego yapıları sarsılır
• Kontrol tutkusu yüzeye çıkar
• Güç oyunlarının farkındalığı
• Maddi bağımlılıkların çözülmesi

DELİNME:
Vishnu Granthi delindığında:
• Yoğun enerji salınımı
• Mide bölgesinde kasılmalar
• Eski ego yapılarının çöküşü
• Sahte güç kaynaklarından vazgeçiş
• Gerçek gücün keşfi

SONRASI:
• İç güç kaynağına erişim
• Dünyevi güçten ilahi güce geçiş
• Ego'nun hizmetkar olması
• Dönüşüm kapasitesinin artması
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

1. UDDIYANA BANDHA
Karın duvarını içeri ve yukarı çekme. En güçlü
Manipura aktivasyonu. Sindirim ateşini uyarır.

Teknik:
• Ayakta veya oturarak
• Derin nefes al, tamamen ver
• Nefes tutarak karını içeri çek
• Diyafram yukarı çekilir
• 10-30 saniye tut
• Yavaşça bırak, nefes al

2. NAULI
Karın kaslarını dairesel hareket ettirme. İleri
seviye teknik, Uddiyana'dan sonra öğrenilir.

3. KAPALABHATI
"Ateş nefesi" - hızlı, ritmik nefes verişleri.
Sindirim ateşini (agni) canlandırır.

4. TRATAKA
Mum alevine bakma meditasyonu. Ateş elementi
ile doğrudan bağlantı. İrade gücünü artırır.

5. GÜNEŞ SELAMLAMASİ (Surya Namaskar)
12 pozluk akış, güneş enerjisini bedene çeker.

6. SAVAŞÇı POZLARI
Virabhadrasana serileri - güç, kararlılık, odak.

7. ATEŞ MEDİTASYONU
Karın merkezinde yanan altın güneş hayal etme.
Her nefeste büyüyen, arındıran ateş.
''',
    affirmation: '''
MANIPURA OLUMLAMA

"Ben güçlüyüm. İradem güçlüdür.
Hayatımı bilinçle yönlendiriyorum.
Kararlarıma güveniyorum.
İç ateşim her engeli eritir.
Dönüşüm gücüm sınırsızdır.
Ben parıldayan bir güneşim."

Sanskrit: "Om Ram - Manipuraya Namaha"
''',
    balancingFoods: [
      'Sarı yiyecekler: Mısır, ananas, muz, limon',
      'Kompleks karbonhidratlar: Yulaf, bulgur, kinoa',
      'Baharatlar: Zencefil, zerdeçal, karabiber, kimyon',
      'Probiyotikler: Yoğurt, kefir, turşu',
      'Sarımsak ve soğan',
      'Tam tahıllar',
    ],
    balancingCrystals: [
      'Sitrin - Güneş enerjisi, bolluk',
      'Sarı jasper - İrade gücü',
      'Kaplan gözü - Cesaret, güç',
      'Pirit - Koruma, özgüven',
      'Sarı topaz - Neşe, enerji',
      'Sarı apatit - Motivasyon',
    ],
    balancingAsanas: [
      'Navasana (Tekne pozu)',
      'Ardha Matsyendrasana (Oturarak bükülme)',
      'Phalakasana (Plank)',
      'Bhujangasana (Kobra pozu)',
      'Dhanurasana (Yay pozu)',
      'Surya Namaskar (Güneş selamlaması)',
    ],
    planetaryRuler: '''
GÜNEŞ VE MARS

Güneş (Surya):
• Benlik, ego, irade
• Vitalite, enerji
• Liderlik, otorite
• Kendini ifade etme

Mars (Mangal):
• Eylem, güç, cesaret
• Mücadele, rekabet
• Enerji, ateş
• Hedef odaklılık
''',
    zodiacConnection: '''
ASLAN VE KOÇ

Aslan (Leo):
• Güneş yönetimi
• Özgüven, liderlik
• Yaratıcı ifade
• Cömertlik

Koç (Aries):
• Mars yönetimi
• Öncülük, cesaret
• Eylem, başlatma
• Rekabet

Doğum haritasında güçlü Güneş, Mars veya 5. ev vurgusu
Manipura temasını güçlendirir.
''',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // 4. ANAHATA - KALP CHAKRASI
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.anahata: const ChakraContent(
    chakra: Chakra.anahata,
    sanskritMeaning: '''
"Anahata" = Vurulmadan çıkan ses, Çarpılmadan oluşan titreşim

Anahata, "vurulmadan çıkan ses" anlamına gelir - müzik aletine
dokunmadan ortaya çıkan ilahi melodi. Bu, kalbin sessiz
fısıltısıdır - sevginin, şefkatin, koşulsuz kabulün sesi.

Alt üç chakra (maddesel) ile üst üç chakra (spiritüel) arasındaki
köprüdür. Dönüşümün gerçek merkezi burasıdır.
''',
    location: '''
Göğüs kafesinin merkezinde, sternum (göğüs kemiği) arkasında,
kalp hizasında bulunur. Fiziksel kalbin biraz sağında yer alır.

Omurga üzerinde torasik vertebralar (T1-T6) hizasına karşılık
gelir. Akciğerler, kalp ve timus beziyle bağlantılıdır.
''',
    element: '''
HAVA (Vayu)

Hava elementi, hareket, özgürlük, genişleme, nefes temsil eder.
Görünmez ama her yerde var - tıpkı sevgi gibi.

Hava elementinin özellikleri:
• Sınırsız genişleme
• Özgürlük ve hareket
• Nefes - yaşamın temeli
• Dokunuş duyusu
• Bağlantı kurma

Dengesizlikte: Ya aşırı dağılma, sınırsızlık; ya da
sıkışmışlık, nefessizlik, duygusal kapalılık.
''',
    color: '''
YEŞİL (bazen pembe)

Doğanın yeşili - büyüme, şifa, yenilenme, uyumun rengi.
Pembe ise koşulsuz sevginin, şefkatin rengi.

Yeşil titreşimi:
• Görünür spektrumun ortası - denge noktası
• Şifa ve yenilenme
• Doğa ile bağlantı
• Büyüme ve gelişim
• Kalp açıklığı

Pembe: Koşulsuz sevgi, naziklik, şefkat, kabul.
''',
    bijaMantra: '''
YAM (यं)

Telaffuz: Yumuşak, açık "YAAMM" sesi.
Titreşim göğüs merkezinde hissedilmeli.

"Yam" hava elementinin ses karşılığıdır. Bu ses,
kalbi açar, sevgi akışını başlatır, şefkati uyandırır.

Pratik:
• Rahat otur, omurgayı düzelt
• Ellerini kalp üzerine koy
• Dikkatini göğüs merkezine ver
• Derin nefes al
• Nefes verirken yumuşak "YAAMM" sesi çıkar
• Kalbin yeşil ışıkla dolduğunu hisset
• 21-108 tekrar yap

Göz teması meditasyonu ile birleştirmek
derin bağlantı yaratır.
''',
    deity: '''
ISHANA VE KAKİNİ

Ishana: Shiva'nın barışçıl, lütufkar yönü. Beş yüzlü,
on kollu, altın tenli olarak tasvir edilir. Koşulsuz
sevgi, şefkat ve bağışlamanın ilahi kaynağını temsil eder.

Kakini: Anahata'nın Shakti'si. Sarı giyimli, dört yüzlü,
dört kollu. Elinde ilmik (bağlanma) ve kafatası (bırakma).
Bağlanma ve bırakma arasındaki dengeyi simgeler.
''',
    shaktiForm: '''
KAKİNİ SHAKTİ

Anahata'da Shakti, sevgi ve şefkat formunda tezahür eder.
Artık savaşçı değil - şifa veren, birleştiren, seven.

Shakti burada:
• Koşulsuz sevgi olarak tezahür eder
• Şifa enerjisi yayar
• İlişkileri besler
• Karşıtları birleştirir

"Sattvic" karaktere geçiş başlıyor - arınmış, hafif,
aydınlık. Ama hala "rajasik" kalıntılar var.
''',
    petalCount: 12,
    yantra: '''
ON İKİ YAPRAKLI LOTUS + İKİ İÇ İÇE ÜÇGEN

Anahata yantrası:
• Dış çember: Evrensel bilinç
• On iki yapraklı lotus: 12 ilahi kalite (sevgi, neşe,
  barış, harmoni, netlik, şefkat, arınmışlık, birlik,
  anlayış, bağışlama, nezaket, sabır)
• İki iç içe üçgen (altıgen yıldız): Shiva (yukarı) ve
  Shakti (aşağı) birleşimi - erkekle dişilin dengesi
• Merkezdeki antilop: Hafiflik, zarafet, hassasiyet

Altıgen yıldız (Shatkona), Yahudi yıldızına benzer ve
eril-dişil, gök-yer, ruh-madde birliğini simgeler.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

SEVGİ VE ŞEFKAT
• Kendini ve başkalarını sevme kapasitesi
• Koşulsuz kabul
• Şefkat ve merhamet
• Empati derinliği

İLİŞKİLER VE BAĞLANMA
• Sağlıklı bağlanma stilleri
• Yakınlık ve özerklik dengesi
• Güven ve kırılganlık
• Verme ve alma dengesi

İYİLEŞME VE BAĞIŞLAMA
• Geçmiş yaraları iyileştirme
• Affetme kapasitesi
• Acıyı dönüştürme
• Travmadan büyüme

DENGE VE UYUM
• İç denge
• Karşıtların entegrasyonu
• Uyum arayışı
• Barış ile var olma
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Kalp, dolaşım sistemi
• Akciğerler, solunum sistemi
• Kollar, eller
• Üst sırt, omuzlar
• Göğüs, meme dokusu
• Cilt (dokunma)

BEZLER:
• Timus bezi - Bağışıklık sistemi
• Kalp hormonları

SAĞLIK KONULARI:
• Kardiyovasküler sağlık
• Solunum sistemi
• Bağışıklık gücü
• Göğüs/meme sağlığı
• Cilt sorunları
• Omuz/kol ağrıları
''',
    blockedSymptoms: '''
BLOKE ANAHATA BELİRTİLERİ

FİZİKSEL:
• Kalp sorunları, çarpıntı
• Nefes darlığı, astım
• Göğüs ağrısı, sıkışma hissi
• Zayıf bağışıklık
• Omuz/üst sırt ağrısı
• Kolarda uyuşma
• Cilt sorunları

DUYGUSAL:
• Sevme/sevilme korkusu
• Yakınlık korkusu veya bağımlılığı
• Yalnızlık, izolasyon
• Bağışlayamama, kin tutma
• Kıskançlık, sahiplenme
• Kalp kırıklığından korunma duvarları
• Empati eksikliği veya aşırı empati

ZİHİNSEL:
• "Beni kimse sevmiyor" inancı
• İlişki sabotajı
• Aşırı fedakarlık veya bencillik
• Güvensizlik

SPİRİTÜEL:
• İlahi sevgiden kopukluk
• Şifa almaya/vermeye kapalılık
• Spiritüel yalnızlık
• Bağlantı hissinden yoksunluk
''',
    activatedSymptoms: '''
AKTİVE ANAHATA BELİRTİLERİ

FİZİKSEL:
• Sağlıklı kalp ve dolaşım
• Derin, rahat nefes
• Güçlü bağışıklık
• Sıcak, açık göğüs
• İyileşme kapasitesi
• Canlı, sağlıklı cilt

DUYGUSAL:
• Koşulsuz sevgi kapasitesi
• Sağlıklı bağlanma
• Empati ve şefkat
• Bağışlama yeteneği
• Duygusal açıklık ve güvenlik
• Neşe ve minnet

ZİHİNSEL:
• Kendini ve başkalarını kabul
• Yargısız farkındalık
• Verme ve alma dengesi
• Sağlıklı sınırlar

SPİRİTÜEL:
• İlahi sevgiyle bağlantı
• Şifa kanalı olma
• Tüm varlıklarla birlik hissi
• Kalp bilgeliği
''',
    kundaliniExperience: '''
KUNDALİNİ ANAHATA'DAN GEÇİŞ DENEYİMİ

YAKLAŞIM:
Kundalini Manipura'dan yükselip Anahata'ya ulaştığında
büyük bir dönüşüm başlar. Alt chakralardan üst chakralara
geçiş burada olur.

• Göğüste genişleme, açılma hissi
• Derin nefes ihtiyacı
• Duygusal dalga
• Sevgi seli

KALP AÇILIŞI:
• Yoğun sevgi duygusu - herkese, her şeye
• Gözyaşları (sevinç veya üzüntü)
• Geçmiş kalp yaralarının yüzeye çıkması
• Bağışlama dalgaları
• Birlik deneyimi

DERİN DENEYİMLER:
• Koşulsuz sevginin doğrudan deneyimi
• "Anahata nada" - vurulmadan çıkan ses duyulabilir
• Zaman ve mekan algısında değişim
• İlahi varlıkların hissedilmesi
• Kalp bilgeliğine erişim

SONRASI:
• Kalbin kalıcı olarak daha açık olması
• Şefkatin doğal hal olması
• İlişkilerde derin değişimler
• Şifa kapasitesinin artması
• Sevginin korkuyu yenmesi
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

1. ANAHATA NEFES
Kalbe nefes çekme meditasyonu. Her nefeste kalbin
genişlediğini, her verişte sevginin yayıldığını hayal et.

2. KALP MUDRALARI
• Anjali Mudra: Avuç içleri kalp hizasında birleşik
• Padma Mudra: Lotus mudra - kalbin açılışı
• Hridaya Mudra: Parmaklarla kalp sembolü

3. METTA (SEVGİ DOLU NEZAKET) MEDİTASYONU
Kadim Budist pratiği. Sevgiyi önce kendine, sonra
yakınlara, sonra tanımadıklara, sonra "düşmanlara",
sonra tüm varlıklara genişletme.

4. GÖZ TEMASI MEDİTASYONU
Bir partnerle karşılıklı oturup, sessizce göz teması
kurarak kalp bağlantısı oluşturma. 10-30 dakika.

5. GÖĞÜS AÇICI ASANALAR
Ustrasana, Bhujangasana, Matsyasana gibi pozlar
göğsü açar, kalp chakrasını uyarır.

6. YEŞİL IŞIK MEDİTASYONU
Kalp merkezinde yeşil veya pembe ışık topunun
parlayıp büyüdüğünü hayal etme.

7. DOKUNUŞLA ŞİFA
Elleri kalp üzerine koyarak, sevgi ve şifa enerjisi
göndererek kendi kendini iyileştirme.
''',
    affirmation: '''
ANAHATA OLUMLAMA

"Kalbim açıktır. Sevgi içimden akar.
Kendimi koşulsuz seviyorum.
Başkalarını yargısızca kucaklıyorum.
Bağışlama benim özgürlüğümdür.
Sevgi en büyük güçtür.
Ben sevgiyim, sevgi benim."

Sanskrit: "Om Yam - Anahataya Namaha"
''',
    balancingFoods: [
      'Yeşil yapraklı sebzeler: Ispanak, pazı, kale',
      'Brokoli, kuşkonmaz, avokado',
      'Yeşil çay, matcha',
      'Elma, kivi, yeşil üzüm',
      'Taze otlar: Nane, fesleğen, maydanoz',
      'Kakao (kalp sağlığı)',
    ],
    balancingCrystals: [
      'Yeşim (Jade) - Kalp şifası, uyum',
      'Gül kuvars - Koşulsuz sevgi',
      'Yeşil aventurin - Duygusal sakinlik',
      'Malakit - Dönüşüm, koruma',
      'Amazonit - Kalp ve boğaz dengesi',
      'Rodonit - Duygusal şifa',
    ],
    balancingAsanas: [
      'Ustrasana (Deve pozu)',
      'Bhujangasana (Kobra pozu)',
      'Matsyasana (Balık pozu)',
      'Anahatasana (Kalp eriten poz)',
      'Gomukhasana (İnek yüzü pozu)',
      'Marjaryasana-Bitilasana (Kedi-İnek)',
    ],
    planetaryRuler: '''
VENÜS VE AY

Venüs (Shukra):
• Aşk, güzellik, uyum
• İlişkiler, çekim
• Estetik, sanat
• Değerler, neyi sevdiğimiz

Ay (Chandra):
• Duygular, şefkat
• Besleme, bakım
• Dişil enerji
• İç dünya, alıcılık
''',
    zodiacConnection: '''
TERAZİ VE BOĞA

Terazi (Libra):
• Venüs yönetimi
• İlişkiler, ortaklık
• Denge, uyum
• Güzellik, adalet

Boğa (Taurus):
• Venüs yönetimi
• Değerler, istikrar
• Duyusal deneyim
• Doğa bağlantısı

Doğum haritasında güçlü Venüs, 7. ev veya Terazi/Boğa
vurgusu Anahata temasını güçlendirir.
''',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // 5. VISHUDDHA - BOĞAZ CHAKRASI
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.vishuddha: const ChakraContent(
    chakra: Chakra.vishuddha,
    sanskritMeaning: '''
"Vishuddha" = Arınma, Saf, Temiz

Vishuddha, "özellikle saf" veya "arınmış" anlamına gelir.
Burası ifadenin, iletişimin ve yaratıcı sesin kaynağıdır.
Dış dünyayla iç dünya arasındaki köprü - sesin gücüyle.

Sesimiz, bilincimizin en doğrudan tezahürüdür. Ne söylediğimiz
ve nasıl söylediğimiz, kim olduğumuzu ortaya koyar.
''',
    location: '''
Boğaz bölgesinde, tiroid bezinin olduğu yerde, gırtlak
hizasında bulunur. Ses tellerinin tam arkasındadır.

Omurga üzerinde servikal vertebralar (C3-C7) hizasına
karşılık gelir. Tiroid, paratiroid bezleri ve boğaz
yapılarıyla bağlantılıdır.
''',
    element: '''
ETER/AKAŞA (Boşluk)

Eter, tüm diğer elementlerin içinde var olduğu "boşluk"tur.
Ses bu boşlukta yayılır. Eter, sınırsızlık, sonsuzluk,
tüm olasılıkların mekanıdır.

Eter elementinin özellikleri:
• Sonsuz genişlik
• Sesin taşıyıcısı
• Tüm potansiyellerin mekanı
• Sınırsızlık
• Arınmış farkındalık

Dengesizlikte: Ya aşırı boşluk, temelsizlik; ya da
sıkışmışlık, ifade edilemezlik.
''',
    color: '''
MAVİ

Gökyüzünün açık mavisi, iletişimin berraklığı, hakikatin rengi.

Mavi titreşimi:
• Yüksek frekans - spiritüelliğe yaklaşım
• Sakinlik ve netlik
• Hakikat ve dürüstlük
• Serin, arındırıcı
• Sonsuzluk hissi

Açık mavi iletişimi, koyu mavi bilgeliği ve derinliği temsil eder.
''',
    bijaMantra: '''
HAM (हं)

Telaffuz: Açık, hafif "HAAMM" sesi.
Titreşim boğazda hissedilmeli.

"Ham" eter elementinin ses karşılığıdır. Bu ses,
boğazı açar, sesi arındırır, hakikati ifade etme
kapasitesini güçlendirir.

Pratik:
• Rahat otur, boynu hafifçe geri al
• Dikkatini boğaz bölgesine ver
• Derin nefes al
• Nefes verirken açık "HAAMM" sesi çıkar
• Sesin boşlukta yayıldığını hisset
• 21-108 tekrar yap

Sesli meditasyonlar, şarkı söyleme, mantra
tekrarı bu chakrayı güçlendirir.
''',
    deity: '''
ARDHANARİSHVARA VE ŞAKİNİ

Ardhanarishvara: Shiva ve Shakti'nin tek bedende birleştiği
form - yarı erkek, yarı kadın. Dualitinin aşıldığını,
eril ve dişilin bütünleştiğini simgeler.

Shakini: Vishuddha'nın Shakti'si. Beyaz giyimli, beş yüzlü,
dört kollu. Elinde kemik ok (bırakma) ve yay (niyetlenme).
Söz ve sessizlik arasındaki dengeyi temsil eder.
''',
    shaktiForm: '''
ŞAKİNİ SHAKTİ

Vishuddha'da Shakti, yaratıcı ses ve bilgelik formunda.
Artık fiziksel dünyadan çok etersel alemlerle bağlantılı.

Shakti burada:
• Yaratıcı kelam (Vak Shakti) olarak tezahür eder
• Sonsuz bilgeliği ifade eder
• Hakikat söyler, yalandan arınır
• Sessizliğin gücünü bilir

"Sattvic" karakter güçlenir - saf, aydınlık, bilge.
''',
    petalCount: 16,
    yantra: '''
ON ALTI YAPRAKLI LOTUS + DAİRE

Vishuddha yantrası:
• Dış çember: Evrensel bilinç
• On altı yapraklı lotus: 16 Sanskrit sesli harfi
  (yaratıcı sesin temeli)
• İçteki gümüşi daire: Dolunay, arınmış bilinç
• Beyaz fil: Saflık, güç, şanslılık
• Merkezdeki üçgen: Aşağı bakan, enerji odaklanması

16 yaprak, 16 sesli harfi temsil eder - tüm dillerin
ve mantaraların temeli. Yaratıcı ses buradan doğar.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

İFADE VE İLETİŞİM
• Kendini ifade etme kapasitesi
• Sözlü ve sözsüz iletişim
• Dinleme yeteneği
• Dürüstlük ve hakikat

OTANTİKLİK
• Gerçek sesi bulma
• Maske ve rollerden arınma
• İç ve dış uyum
• Kendini gösterebilme

YARATICILIK (Sözel/İşitsel)
• Yazma, konuşma, şarkı söyleme
• Ses ve müzikle ifade
• Yaratıcı kelam
• Hikaye anlatıcılığı

ZAMAN VE RİTİM
• Zamanlama duygusu
• Yaşamın ritimleriyle uyum
• Ne zaman konuşup ne zaman susmak
• Senkronisite farkındalığı
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Boğaz, gırtlak, ses telleri
• Boyun, servikal omurlar
• Çene, ağız, dişler
• Kulaklar, işitme
• Üst solunum yolları
• Omuzlar (bağlantı)

BEZLER:
• Tiroid bezi - Metabolizma
• Paratiroid bezleri - Kalsiyum dengesi

SAĞLIK KONULARI:
• Tiroid sağlığı
• Ses sorunları, laringit
• Boyun ağrısı, sertliği
• Çene eklemi (TMJ)
• Kulak sorunları
• Diş/diş eti sağlığı
''',
    blockedSymptoms: '''
BLOKE VISHUDDHA BELİRTİLERİ

FİZİKSEL:
• Kronik boğaz sorunları
• Tiroid dengesizlikleri
• Ses kısıklığı, ses kaybı
• Boyun sertliği/ağrısı
• Çene sıkma, diş gıcırdatma
• Kulak sorunları
• Ağız yaraları

DUYGUSAL:
• Kendini ifade edememe
• Konuşma korkusu
• Aşırı konuşma (sinirli gevezelik)
• Yalan söyleme eğilimi
• Duyulamamış hissetme
• Yaratıcı blokaj

ZİHİNSEL:
• Düşünceleri organize edememe
• İletişim zorlukları
• Dinleyememe
• Dogmatizm, kapalı fikirlilik
• Eleştiri korkusu

SPİRİTÜEL:
• İç sesle bağlantı kaybı
• Mantra/dua güçsüzlüğü
• Spiritüel hakikati ifade edememe
• Sessizlikten korku
''',
    activatedSymptoms: '''
AKTİVE VISHUDDHA BELİRTİLERİ

FİZİKSEL:
• Güçlü, net ses
• Sağlıklı tiroid
• Esnek boyun
• İyi işitme
• Rahat çene
• Sağlıklı solunum

DUYGUSAL:
• Özgürce ifade edebilme
• Dürüstlük ve otantiklik
• Etkili iletişim
• Aktif dinleme
• Eleştiriye açıklık

ZİHİNSEL:
• Net düşünce ifadesi
• Yaratıcı yazma/konuşma
• Açık fikirlilik
• Uygun zamanlama
• Ses ve sessizlik dengesi

SPİRİTÜEL:
• İç rehberliği duyma
• Mantra gücü
• Channeling kapasitesi
• Hakikat söyleme cesareti
''',
    kundaliniExperience: '''
KUNDALİNİ VISHUDDHA'DAN GEÇİŞ DENEYİMİ

RUDRA GRANTHİ:
Kundalini Anahata'dan yükselip Vishuddha'ya ulaştığında,
üçüncü ve son büyük düğümle (Rudra Granthi) karşılaşır.
Bu düğüm en incedir ama en derin dönüşümü gerektirir.

• Boğazda sıkışma, basınç
• Ses değişimleri
• Yutkunma güçlüğü
• Baş ve boyun bağlantısı

RUDRA GRANTHİ:
Bu düğüm, bireysel bilinçten evrensel bilince geçişi temsil
eder. Ego'nun son kalıntıları burada çözülür.

• Kim olduğun sorusunun derinleşmesi
• Bireysel kimliğin çözülmeye başlaması
• Zamansızlık deneyimleri
• "Kozmik self" ile temas

DELİNME:
Rudra Granthi delindığında:
• Boğazda açılma, serbestlik
• Yaratıcı ses patlaması
• İç seslerin/rehberlerin duyulması
• Akashik kayıtlara erişim hissi
• Zaman algısının değişmesi

SONRASI:
• Otantik sesin bulunması
• Hakikat söyleme kapasitesi
• Channeling/medyumluk açılabilir
• İç bilgeliğe sürekli erişim
• Spiritüel öğretme kapasitesi
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

1. JALANDHARA BANDHA
Çene kilidleme - çene göğse doğru, boyun uzar.
Boğaz chakrasını aktive eder, enerjiyi tutar.

Teknik:
• Rahat otur
• Derin nefes al
• Nefes tutarak çeneyi göğse doğru indir
• Boyun arkasını uzat
• 10-30 saniye tut
• Yavaşça başı kaldır, nefes ver

2. UJJAYİ NEFES (Okyanus Nefesi)
Boğazı hafifçe daraltarak yapılan nefes. Okyanus
sesi gibi bir ses çıkar. Vishuddha'yı uyarır.

3. ŞARKI SÖYLEME
Özellikle mantra şarkıları, kirtan, bhajan.
Sesin spiritüel kullanımı.

4. MAUNA (Sessizlik Pratiği)
Bilinçli sessizlik dönemleri - konuşmadan.
Sessizliğin gücünü keşfetme.

5. BOYUN EGZERSIZLERI
Boyun döndürme, esnetme, gevşetme.
Fiziksel blokajları açma.

6. MAVI IŞIK MEDİTASYONU
Boğazda mavi ışık topunun parladığını,
genişlediğini hayal etme.

7. OM CANTLEME
En temel ve en güçlü ses pratiği.
Tüm chakraları etkiler ama özellikle Vishuddha.
''',
    affirmation: '''
VISHUDDHA OLUMLAMA

"Sesim güçlü ve nettir.
Hakikatimi cesaretle ifade ediyorum.
Hem konuşmayı hem dinlemeyi biliyorum.
Yaratıcılığım sözlerimle akar.
Sessizlik de ifademin parçasıdır.
Ben hakikatin sesi oluyorum."

Sanskrit: "Om Ham - Vishuddhaya Namaha"
''',
    balancingFoods: [
      'Mavi yiyecekler: Yaban mersini, erik, üzüm',
      'Sıvılar: Su, bitkisel çaylar, meyve suları',
      'Bal - boğazı yatıştırır',
      'Meyveler genel olarak',
      'Deniz yosunları',
      'Hafif, sulu yiyecekler',
    ],
    balancingCrystals: [
      'Akuamarin - İletişim, cesaret',
      'Lapis lazuli - Hakikat, bilgelik',
      'Sodalit - Zihinsel netlik',
      'Mavi kalsit - Sakinleştirici',
      'Türkuaz - Koruma, şifa',
      'Celestit - Melek bağlantısı',
    ],
    balancingAsanas: [
      'Sarvangasana (Omuz duruşu)',
      'Halasana (Saban pozu)',
      'Matsyasana (Balık pozu)',
      'Setu Bandhasana (Köprü pozu)',
      'Simhasana (Aslan pozu - dil çıkarma)',
      'Boyun esnemeleri',
    ],
    planetaryRuler: '''
MERKÜR VE JÜPİTER

Merkür (Budha):
• İletişim, konuşma, yazı
• Zeka, öğrenme
• Ticaret, değişim
• Bağlantı kurma

Jüpiter (Guru):
• Bilgelik, öğretme
• Genişleme, bolluk
• Dini/spiritüel ifade
• Hakikat arayışı
''',
    zodiacConnection: '''
İKİZLER VE YAY

İkizler (Gemini):
• Merkür yönetimi
• İletişim, merak
• Çeşitlilik, adaptasyon
• Sözel zeka

Yay (Sagittarius):
• Jüpiter yönetimi
• Bilgelik, felsefe
• Öğretme, yayma
• Daha yüksek hakikat

Doğum haritasında güçlü Merkür, 3. ev veya İkizler
vurgusu Vishuddha temasını güçlendirir.
''',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // 6. AJNA - ÜÇÜNCÜ GÖZ CHAKRASI
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.ajna: const ChakraContent(
    chakra: Chakra.ajna,
    sanskritMeaning: '''
"Ajna" = Bilme, Algılama, Komuta

Ajna, "algılama yeri" veya "komuta merkezi" anlamına gelir.
Burası içsel görüşün, sezginin, bilgeliğin merkezidir -
fiziksel gözlerin ötesinde gören "üçüncü göz".

Tüm duyu algılarının birleştiği, aşkın bilginin alındığı,
iç ve dış dünyanın bir olduğu noktadır.
''',
    location: '''
İki kaş arasında, alnın ortasında, "üçüncü göz" olarak bilinen
bölgede bulunur. Pineal bez (kozalaksı bez) ile bağlantılıdır.

Beyin içinde hipotalamus ve pineal bez hizasına karşılık
gelir. Görme, biliş ve bilinç durumlarıyla ilişkilidir.
''',
    element: '''
ZİHİN/IŞIK (Manas)

Ajna'nın elementi artık kaba elementler değil, saf zihin
veya ışıktır. Fiziksel dünyadan aşkın aleme geçiş burada.

Işık/zihin elementinin özellikleri:
• Saf farkındalık
• İçgörü ve aydınlanma
• Dualite ötesi algı
• Sezgisel bilgi
• Bilinç durumlarını yönetme

Elementler ötesinde - saf potansiyelin alanı.
''',
    color: '''
İNDİGO (Çivit Mavisi)

Derin, koyu mavi-mor - gece gökyüzü, derin bilinç, gizemin rengi.

İndigo titreşimi:
• Yüksek frekans - spiritüel algı
• Derinlik ve sonsuzluk
• İçgörü ve vizyon
• Gizem ve bilinmeyene açılma
• Bilinçdışına erişim

İndigo, fiziksel görüşün ötesine geçen içsel görüşü temsil eder.
''',
    bijaMantra: '''
OM / AUM (ॐ)

Telaffuz: Kutsal hece "A-U-M", kaynaşarak "OOOOMM".
Titreşim tüm kafada, özellikle kaşlar arasında hissedilmeli.

"Om" evrensel sesin kendisidir. Yaratılışın ilk sesi,
Brahman'ın ses tezahürü. Bu ses, tüm chakraları
etkiler ama özellikle Ajna'yı uyandırır.

Pratik:
• Rahat meditasyon pozisyonunda otur
• Gözleri kapat, dikkatini kaşlar arasına ver
• Derin nefes al
• Nefes verirken uzun "OOOOMM" sesi çıkar
• Titreşimi kafanın içinde hisset
• 21-108 tekrar yap

Shambhavi Mudra (kaşlar arasına bakış) ile
birleştirmek çok güçlüdür.
''',
    deity: '''
ARDHANARİSHVARA (HAKİMA) VE HAKİNİ

Paramashiva: Ajna'da Shiva, saf bilinç olarak bulunur.
Formdan öte, niteliklerin ötesinde - saf farkındalık.
İkili olmayan gerçeklik (Advaita).

Hakini: Ajna'nın Shakti'si. Beyaz giyimli, altı yüzlü,
altı kollu. Elinde kitap (bilgelik) ve kafatası (bırakma).
Mantraları ve kitapların ötesine geçen doğrudan bilgiyi simgeler.
''',
    shaktiForm: '''
HAKİNİ SHAKTİ

Ajna'da Shakti, saf bilgelik ve içgörü formunda.
Artık tamamen sattvic - arınmış, aydınlanmış, ışıklı.

Shakti burada:
• Doğrudan bilgi (prajna) olarak tezahür eder
• İkiliği aşan görüş sağlar
• Zamanı ve mekanı transcend eder
• Bilinç durumlarını yönetir

Shakti ve Shiva burada neredeyse birleşmiş - sadece
en ince ayrım kalmış. Taç chakrada tam birleşim olacak.
''',
    petalCount: 2,
    yantra: '''
İKİ YAPRAKLI LOTUS + OM

Ajna yantrası:
• İki yapraklı lotus: Ida ve Pingala'nın birleşimi,
  dualitinin son noktası, bilinç ve bilinçdışı
• Merkezdeki beyaz daire: Saf bilinç
• İçindeki Om sembolü: Evrensel ses, Brahman
• Üçgen (bazen): Shakti, manifestasyon gücü
• Itara Lingam: Shiva bilinci

İki yaprak, Ida ve Pingala'nın Ajna'da birleştiğini
gösterir. Bundan sonra sadece Sushumna devam eder.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

SEZGİ VE İÇGÖRÜ
• Altıncı his, sezgisel bilme
• İçsel rehberlik
• Sembolleri ve işaretleri okuma
• Rüya bilgeliği

GÖRÜŞ VE VİZYON
• Büyük resmi görme
• Geleceği öngörme
• Vizyoner düşünce
• Hayalleri görselleştirme

ZİHİNSEL NETLİK
• Zihinsel berraklık
• Odaklanma gücü
• Konsantrasyon
• Zihinsel disiplin

DUALITE ÖTESİ
• İyi-kötü ötesi algı
• Paradoksları kucaklama
• Birlik bilinci
• Non-dual farkındalık
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Beyin, sinir sistemi
• Gözler, görme
• Alın, kaşlar
• Burun (üst kısım)
• Yüz sinirleri

BEZLER:
• Pineal bez (epifiz) - Melatonin, biyoritimler
• Hipofiz bezi (pitüiter) - Ana kontrol bezi

SAĞLIK KONULARI:
• Baş ağrıları, migren
• Görme sorunları
• Uyku bozuklukları
• Nörolojik sorunlar
• Hormonal dengesizlikler
• Sinüs sorunları
''',
    blockedSymptoms: '''
BLOKE AJNA BELİRTİLERİ

FİZİKSEL:
• Kronik baş ağrıları
• Görme sorunları
• Uyku bozuklukları
• Konsantrasyon güçlüğü
• Hormonal dengesizlik
• Sinüs tıkanıklığı
• Nörolojik sorunlar

DUYGUSAL:
• Sezgiye güvensizlik
• Hayal gücü eksikliği
• Görsel düşünememe
• Rüya hatırlamama
• "Anlam" bulamama
• Spiritüel körlük hissi

ZİHİNSEL:
• Aşırı rasyonellik, sezgi reddi
• Veya aşırı hayalcilik, gerçeklikten kopma
• Paranoya, komplo düşüncesi
• Zihinsel kaos
• Karar verememe

SPİRİTÜEL:
• İç rehberlikten kopukluk
• Vizyon yoksunluğu
• Spiritüel deneyimleri entegre edememe
• Ego şişkinliği (spiritüel materyalizm)
''',
    activatedSymptoms: '''
AKTİVE AJNA BELİRTİLERİ

FİZİKSEL:
• Net görüş
• Dengeli uyku
• Sağlıklı beyin fonksiyonu
• Hassas algı
• Esnek biyoritimler

DUYGUSAL:
• Güçlü sezgi
• Canlı hayal gücü
• Rüya farkındalığı
• İç huzur
• Spiritüel bağlantı hissi

ZİHİNSEL:
• Derin konsantrasyon
• Zihinsel netlik
• Sembolik düşünme
• Rasyonel ve sezgisel denge
• Vizyon ve pratiklik birliği

SPİRİTÜEL:
• Psişik yetenekler
• İç rehberliğe erişim
• Vizyon ve içgörüler
• Non-dual farkındalık anlık deneyimleri
• Bilinç durumlarını kontrol
''',
    kundaliniExperience: '''
KUNDALİNİ AJNA'DAN GEÇİŞ DENEYİMİ

YÜKSELİŞ:
Kundalini Vishuddha'dan yükselip Ajna'ya ulaştığında,
bilinç büyük bir genişleme yaşar. Artık üst chakralardayız.

• Kaşlar arasında basınç, titreşim
• İçsel ışık görünümleri
• Spontan içgörüler
• Renkler, geometrik şekiller

DENEYİMLER:
• Üçüncü göz aktivasyonu hissi
• İçsel sesler, müzikler
• Vizyonlar, sembolik görüntüler
• Zaman-mekan algısının değişmesi
• Durağan bilinç deneyimleri

PSİŞİK AÇILIŞ:
• Telepati deneyimleri
• Öngörü, premonisyon
• Aura görme başlangıcı
• Enerji algılaması
• Rüyaların yoğunlaşması

SONRASI:
• Kalıcı olarak artmış sezgi
• Sembolik dili anlama
• İç rehberliğe güven
• Meditasyon derinliği artışı
• Spiritüel algı genişlemesi
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

1. SHAMBHAVI MUDRA
İç bakış - gözleri yarı kapalı, kaşlar arasına odaklanma.
En güçlü Ajna aktivasyon tekniği.

Teknik:
• Rahat otur, omurgayı düzelt
• Gözleri yarı kapat (veya kapat)
• Dikkatini kaşlar arasına, biraz içeri ver
• Bu noktada sabit kal
• Düşünceleri bırak, sadece farkındalık
• 10-30 dakika (veya daha uzun)

2. TRATAKA
Mum alevine veya başka bir noktaya sabit bakış.
Konsantrasyonu güçlendirir, Ajna'yı uyarır.

3. NADI SHODHANA (Alternatif Burun Nefesi)
Ida ve Pingala dengesini sağlayarak Ajna'da
buluşmalarını kolaylaştırır.

4. ÜÇÜNCÜ GÖZ MEDİTASYONU
Kaşlar arasında indigo ışık topu hayal etme.
Veya göz sembolü, lotus, Om sembolü.

5. YOGA NİDRA
Bilinçli uyku - Ajna'yı dolaylı yoldan uyarır,
bilinçaltına erişim sağlar.

6. AJNAYA DIKKAT MEDİTASYONU
Tüm gün boyunca ara ara kaşlar arasına dikkat verme.
Günlük hayatla entegrasyon.

7. BINAURAL BEATS
Özel frekanslarda ses dinleyerek beyin dalgalarını
değiştirme - teknolojik destek.
''',
    affirmation: '''
AJNA OLUMLAMA

"İçsel görüşüm açıktır.
Sezgime güveniyorum.
Her şeyin ardındaki hakikati görüyorum.
Bilgelik benim doğam.
İlahi rehberliğe açığım.
Ben saf farkındalığım."

Sanskrit: "Om - Ajnaya Namaha"
''',
    balancingFoods: [
      'Mor/mavi yiyecekler: Yaban mersini, böğürtlen, patlıcan',
      'Bitter çikolata, kakao',
      'Mor lahana, mor patates',
      'Üzüm, erik',
      'Ceviz (beyin şekli)',
      'Omega-3 (balık, keten tohumu)',
    ],
    balancingCrystals: [
      'Ametist - Spiritüel açılma',
      'Labradorit - Psişik koruma',
      'Florit - Zihinsel netlik',
      'Lapis lazuli - Üçüncü göz aktivasyonu',
      'Safir - Bilgelik',
      'Azurit - Vizyon',
    ],
    balancingAsanas: [
      'Balasana (Çocuk pozu - alın yere)',
      'Paschimottanasana (Oturarak öne eğilme)',
      'Sirsasana (Baş üstü duruş)',
      'Makarasana (Timsah pozu)',
      'Vajrasana meditasyonu',
      'Sukhasana ile Shambhavi Mudra',
    ],
    planetaryRuler: '''
JÜPİTER VE SATÜRN (+ NEPTÜN)

Jüpiter (Guru):
• Bilgelik, içgörü
• Genişleme, büyük resim
• Spiritüel öğretmen
• Anlam arayışı

Satürn (Shani):
• Disiplin, konsantrasyon
• Zamanın ötesi
• Sınırları aşma
• Derin meditasyon

Modern: Neptün
• Sezgi, vizyon
• Mistisizm
• İllüzyon çözülmesi
• Transendans
''',
    zodiacConnection: '''
BALIK VE YAY (+ AKREP)

Balık (Pisces):
• Sezgi, mistisizm
• Rüyalar, bilinçdışı
• Birlik deneyimi
• Sınırsızlık

Yay (Sagittarius):
• Bilgelik, vizyon
• Daha yüksek hakikat
• Felsefe
• Genişleme

Akrep (Scorpio):
• Derin görüş
• Gizemler, gizlilikler
• Dönüşüm
• Psişik algı

Doğum haritasında güçlü Neptün, 12. ev veya Balık
vurgusu Ajna temasını güçlendirir.
''',
  ),

  // ─────────────────────────────────────────────────────────────────────────
  // 7. SAHASRARA - TAÇ CHAKRASI
  // ─────────────────────────────────────────────────────────────────────────
  Chakra.sahasrara: const ChakraContent(
    chakra: Chakra.sahasrara,
    sanskritMeaning: '''
"Sahasrara" = Bin (yapraklı), Sonsuz

Sahasrara, "bin yapraklı lotus" anlamına gelir. Bu "bin"
sayısı sonsuzluğu, sınırsızlığı temsil eder. Burası
bireysel bilincin evrensel bilinçle birleştiği son nokta -
Kundalini'nin nihai hedefi.

Diğer chakraların aksine, Sahasrara tam olarak bir "chakra"
değildir - o, tüm chakraların ötesinde, saf bilincin
kendisidir. Shiva'nın tahtı.
''',
    location: '''
Başın tam tepesinde, saçlı derinin en üst noktasında,
"bıngıldak" (fontanel) olarak bilinen bölgede bulunur.

Anatomik olarak beyin korteksinin en üst kısmı ve
serebral yarıküreler arasındaki bölgeye karşılık gelir.
Bazı geleneklerde başın biraz üzerinde, aura içinde
tanımlanır.
''',
    element: '''
ELEMENT ÖTESİ - SAF BİLİNÇ

Sahasrara'nın elementi yoktur - o, tüm elementlerin
ötesinde, saf bilinçtir. Burada kategorizasyon biter,
tanımlamalar düşer. Sadece OLAN kalır.

Saf bilincin "nitelikleri":
• Sınırsızlık
• Zamansızlık
• Formdan özgürlük
• Mutlak sessizlik
• Sonsuz farkındalık

Elementler maddi dünyaya aittir. Sahasrara,
madde ötesidir - saf ruh.
''',
    color: '''
BEYAZ / MOR / ALTIN

En sık mor veya beyaz olarak tanımlanır. Altın da kullanılır.
Bazen renksiz, saf ışık olarak betimlenir.

Mor/Beyaz titreşimi:
• En yüksek frekans - spiritüelliğin zirvesi
• Saflık ve transcendence
• Evrensel bilinç
• Aydınlanma
• Tüm renklerin birliği (beyaz ışık)

Renk ötesi - çünkü renk de bir sınırlamadır.
Sahasrara sınırsızdır.
''',
    bijaMantra: '''
SESSIZLIK / OM / AH

Sahasrara'nın gerçek mantrası sessizliktir. Tüm seslerin
ötesinde, sesin olmadığı yerde. Bazı geleneklerde "Om"
veya "Ah" kullanılır.

Sessizlik pratiği:
• Tüm mantaraları bırak
• Tüm düşünceleri bırak
• Tüm çabaları bırak
• Sadece OL
• Saf farkındalıkta kal

"Ah" pratiği:
• Ağzı açık bırak
• Nefes verirken doğal "Aaahh" sesi
• Sesin kendiliğinden çıkmasına izin ver
• Taç chakrada titreşim hisset

Om'un uzantısı olarak "A-U-M" ve ardından gelen
sessizlik (turiya) Sahasrara'yı temsil eder.
''',
    deity: '''
SHİVA / PARAMASHIVA

Sahasrara'da sadece Shiva var - saf, değişmeyen, sonsuz
bilinç. Shakti (Kundalini) buraya ulaştığında Shiva ile
birleşir ve ikilik sona erer.

Shiva burada:
• Formsuz, niteliksiz, sınırsız
• Saf tanık, değişmeyen farkındalık
• "Ben O'yum" (Aham Brahmasmi)
• Atman = Brahman

Shakti ile birleşince: Shiva-Shakti bir, bilinç ve
enerji bir, tanıyan ve tanınan bir.
''',
    shaktiForm: '''
BİRLEŞMİŞ SHAKTİ / MAHASHAKTİ

Sahasrara'da Shakti artık ayrı değil - Shiva ile tam
birleşmiş. Kundalini yolculuğu tamamlanmış.

Bu birleşme:
• Samadhi deneyimi
• Nirvikalpa samadhi (ayrımsız birlik)
• Moksha (kurtuluş)
• Aydınlanma

Metafor: Nehir (Shakti) denize (Shiva) ulaşmış,
artık ayrı nehir yok - sadece okyanus.
''',
    petalCount: 1000, // veya sonsuz
    yantra: '''
BİN YAPRAKLI LOTUS

Sahasrara yantrası:
• Bin yapraklı lotus: Sonsuzluk, tüm olasılıklar
  (50 Sanskrit harfi x 20 = 1000)
• Merkezdeki boşluk: Saf bilinç, tanımsız alan
• Bazen parlayan ışık, güneş disk tasvir edilir
• Bindu (nokta): Tüm yaratılışın kaynağı ve hedefi
• Veya tamamen beyaz, saf ışık

Yantra bile burada yetersiz kalır - çünkü Sahasrara
form ötesidir. Görselleştirmeler ancak kapıya kadar
götürebilir, içeri adımı sen atarsın.
''',
    psychologicalThemes: '''
PSİKOLOJİK TEMALAR

BİRLİK BİLİNCİ
• Her şeyle bir olma
• Ayrılık illüzyonunun çözülmesi
• Evrensel bağlantı
• Kozmik perspektif

TRANSCENDENCE
• Egonun aşılması
• Bireyselliğin çözülmesi
• Sınırların düşmesi
• Ölüm korkusunun bitişi

ANLAM VE AMAÇ
• Varoluşsal anlam
• Yaşamın nihai amacı
• Spiritüel gerçekleşme
• Dharma netliği

İÇ HUZUR
• Derin, sarsılmaz huzur
• Tüm arayışın bitişi
• "Eve" varma hissi
• Koşulsuz tatmin
''',
    physicalAssociations: '''
FİZİKSEL İLİŞKİLER

BEDEN BÖLGELERİ:
• Beyin korteksi
• Kafatası tepesi
• Beyin zarları
• Merkezi sinir sistemi
• Tüm beden (holografik)

BEZLER:
• Pineal bez (üst bağlantı)
• Hipofiz bezi (master bez)

SAĞLIK KONULARI:
• Nörolojik durumlar
• Bilinç bozuklukları
• Sistemik hastalıklar
• Otoimmün durumlar
• Yaşlanma süreçleri

Not: Sahasrara, fiziksel sağlıkla dolaylı bağlantılıdır.
O daha çok bilinç durumlarıyla ilgilidir.
''',
    blockedSymptoms: '''
BLOKE SAHASRARA BELİRTİLERİ

Not: "Bloke Sahasrara" demek biraz yanıltıcıdır. Sahasrara
her zaman açıktır - saf bilinç her zaman var. Mesele
farkındalığın ona ulaşıp ulaşmamasıdır.

"KOPUKLUK" BELİRTİLERİ:

FİZİKSEL:
• Kronik yorgunluk, enerji düşüklüğü
• Işığa hassasiyet
• Koordinasyon sorunları
• Sistemik hastalıklara yatkınlık

DUYGUSAL:
• Derin anlamsızlık hissi
• Spiritüel depresyon
• Hiçbir şeyin önemli olmadığı hissi
• Derin yalnızlık, kopukluk

ZİHİNSEL:
• Spiritüel materyalizm
• Ego şişkinliği (aydınlanma iddiası)
• Dogmatizm
• Spiritüel bypass

SPİRİTÜEL:
• "Karanlık gece" deneyimleri
• İlahi bağlantıdan kopukluk hissi
• Spiritüel kuraklık
• Anlam krizi
''',
    activatedSymptoms: '''
AKTİVE SAHASRARA BELİRTİLERİ

TAM AKTİVASYON (Aydınlanma) nadirdir ve sürekli değildir.
Ama "dokunuşlar", anlık deneyimler mümkündür.

FİZİKSEL:
• Baş tepesinde titreşim, basınç
• Tüm bedende enerji akışı
• Işık hissi, aydınlık
• Derin dinlenme hali
• Vitalite artışı

DUYGUSAL:
• Derin huzur, koşulsuz mutluluk
• Korkunun bitişi
• Koşulsuz sevgi tüm varlıklara
• Minnet seli

ZİHİNSEL:
• Düşüncelerin durması veya yavaşlaması
• Mutlak netlik
• Paradoksların çözülmesi
• Anlık bilme (gnosis)

SPİRİTÜEL:
• Birlik deneyimi (samadhi)
• "Ben O'yum" gerçekleşmesi
• Ego ölümü ve yeniden doğuş
• Sonsuzluk hissi
• Ölümsüzlük bilinci
''',
    kundaliniExperience: '''
KUNDALİNİ SAHASRARA'DA - FINAL

YAKLAŞIM:
Kundalini Ajna'dan yükselip Sahasrara'ya ulaştığında,
yolculuğun zirvesine varılır. Bu, Shakti'nin Shiva
ile buluşmasıdır.

• Baş tepesinde yoğun basınç veya açılma
• Kafatasının "erimesi" hissi
• Enerji fışkırması
• Parlak ışık

BİRLEŞME:
• Shakti ve Shiva bir olur
• Bireysel bilinç evrensel bilince erir
• "Ben" kavramı çözülür
• Sadece saf farkındalık kalır

SAMADHİ DENEYİMLERİ:
• Savikalpa Samadhi: Ayrım hala var, ama birlik deneyimi
• Nirvikalpa Samadhi: Tam ayrımsızlık, saf birlik
• Sahaja Samadhi: Doğal, sürekli aydınlanmış hal

AMRITA (ÖLÜMSÜZLÜK NEKTARI):
Kundalini Sahasrara'ya ulaştığında, amrita (nektar)
aşağı akmaya başlar. Bu, her chakrayı kutsayan,
bedeni dönüştüren ilahi öz.

Bazen:
• Boğazda tatlı tat
• Tüm bedende isilik veya serinlik dalgası
• Hücresel seviyede yenilenme hissi

SONRASI:
• Kalıcı bilinç değişimi
• Dünyaya "dönüş" ama farklı gözlerle
• Ego geri gelebilir, ama eskisi gibi değil
• Yeni bir yaşam başlar
''',
    tantricPractices: '''
TANTRİK AKTİVASYON PRATİKLERİ

Not: Sahasrara çalışmaları ileri seviyedir. Temel
oluşmadan yapılmamalı. Aşağıdan yukarı, sırayla.

1. KECHARİ MUDRA
Dilin damağa, hatta yumuşak damak ötesine kıvrılması.
Amrita akışını tetikler, Sahasrara'yı uyarır.
Yıllar süren pratik gerektirir.

2. SHAMBHAVI MUDRA + OM
Kaşlar arasına bakış ile Om cantleme.
Enerjiyi yukarı yönlendirir.

3. SUSHUMNA NEFES
Tüm nefesi Sushumna boyunca hayal ederek,
Muladhara'dan Sahasrara'ya taşıma.

4. MAHA BANDHA
Üç bandhanın (Mula, Uddiyana, Jalandhara) birlikte
uygulanması. Enerjiyi güçlü şekilde yukarı iter.

5. SESSİZLİK (MAUNA)
Uzun süreli sessizlik pratikleri. Dış ve iç
sessizlik - düşüncelerin de durması.

6. TESLIMIYET MEDİTASYONU
Tüm çabayı bırakma, ilahi iradeye teslim olma.
"Yapma"nın ötesinde "olma".

7. GURU KRIPA (Ustanın Lütfu)
Gerçek bir ustanın (guru) aktarımı.
Shaktipat - enerji transferi.
''',
    affirmation: '''
SAHASRARA OLUMLAMA

"Ben saf farkındalığım.
Her şeyle bir olduğumu biliyorum.
Ego benim değil, bir araçtır.
Sonsuzluk benim doğam.
Ölüm, sadece formun değişimidir.
Ben OYUM."

Sanskrit: "Aham Brahmasmi" (Ben Brahman'ım)
"So'ham" (Ben O'yum)
''',
    balancingFoods: [
      'Oruç - En güçlü Sahasrara pratiği',
      'Hafif, sattvik yiyecekler',
      'Taze meyveler',
      'Temiz su',
      'Hava ve ışık (prana)',
      'Minimal yeme',
    ],
    balancingCrystals: [
      'Şeffaf kuvars (Clear quartz) - Evrensel kristal',
      'Ametist - Spiritüel açılma',
      'Selinit - Yüksek titreşim',
      'Elmas - Saf ışık',
      'Lepidolit - Dönüşüm',
      'Howlit - Bilinç genişletme',
    ],
    balancingAsanas: [
      'Sirsasana (Baş üstü duruş)',
      'Padmasana (Lotus oturuş)',
      'Savasana (Ceset pozu - derin bırakma)',
      'Yoga Mudra (Oturarak öne eğilme)',
      'Vrikshasana (Ağaç pozu)',
      'Uzun süreli meditasyon',
    ],
    planetaryRuler: '''
KETU / NEPTÜN / GÜNEŞ ÖTESİ

Ketu (Güney Ay Düğümü):
• Ayrılma, bırakma
• Geçmiş yaşam bilgeliği
• Spiritüel özgürleşme
• Ego çözülmesi

Neptün (Modern):
• Transcendence
• Evrensel bilinç
• Sınırların çözülmesi
• İllüzyon ötesi

Güneş (Ruhsal yön):
• İlahi benlik (Atman)
• Saf bilinç
• Işık kaynağı
• Yaşam özü
''',
    zodiacConnection: '''
BALIK / KOVA (Transatürnal)

Balık (Pisces):
• Son burç - döngünün bitişi
• Evrensel bilinç
• Çözülme, teslim olma
• Sınırsızlık

Kova (Aquarius):
• Evrensel vizyon
• İnsanlık bilinci
• Geleceğe bakış
• Bireysel-kolektif birliği

12. Ev:
• Görünmez dünya
• Bilinçdışı okyanus
• Spiritüel bağlantı
• Ego çözülmesi

Doğum haritasında güçlü 12. ev, Balık, Ketu veya
Neptün vurgusu Sahasrara temasını güçlendirir.
''',
  ),
};

// ═══════════════════════════════════════════════════════════════════════════
// KUNDALİNİ UYANIŞ AŞAMALARI - DETAYLI İÇERİK
// ═══════════════════════════════════════════════════════════════════════════

class KundaliniAwakeningStages {
  static const String overview = '''
KUNDALİNİ UYANIŞ AŞAMALARI

Kundalini uyanışı, ani bir patlama değil, çoğunlukla aşamalı
bir süreçtir. Her birey bu yolculuğu farklı yaşar, ama
genel aşamalar benzerdir.

SPONTAN VS. KASITLI UYANIŞ:

SPONTAN UYANIŞ:
• Beklenmedik, hazırlıksız
• Travma, yakın ölüm deneyimi, yoğun duygu tetikleyebilir
• Bazen zorlu, şoke edici
• Entegrasyon daha güç olabilir

KASITLI UYANIŞ:
• Yoga, meditasyon, pranayama ile
• Adım adım, kontrollü
• Hazırlık süreci var
• Genellikle daha yumuşak

Her iki yol da meşrudur. Ama spontan uyanış yaşayanların
rehberlik bulması özellikle önemlidir.
''';

  static const String dormantStage = '''
1. AŞAMA: UYUYAN KUNDALİNİ (Dormant)

Bu, çoğu insanın durumudur. Kundalini Muladhara'da uyur,
potansiyel olarak var ama aktif değil.

BELİRTİLER:
• Normal bilinç durumu
• Spiritüel farkındalık sınırlı veya yok
• Dünyevi kaygılarla meşgul
• Ego merkezli yaşam

BU AŞAMADA NE YAPILMALI:
• Temel yoga ve meditasyon başlat
• Sattvik yaşam tarzına geç
• Pranayama pratiklerine başla
• Etik yaşam (yama/niyama)
• Bedeni ve zihni arındır
• Uygun öğretmen bul

BU AŞAMA NE KADAR SÜRER:
Kişiye göre değişir. Bazıları yıllarca bu aşamada kalır,
bazıları hızla geçer. Acele etmeye gerek yok.
''';

  static const String stirringStage = '''
2. AŞAMA: KIVIRILMA / UYANMA BAŞLANGICI (Stirring)

Kundalini hareket etmeye başlıyor. İlk belirtiler.

FİZİKSEL BELİRTİLER:
• Omurga tabanında ısınma, titreşim
• Karıncalanma hissi (kök bölge)
• Spontan kasılmalar
• Enerji hareketleri hissi
• Uyku düzeninde değişim

DUYGUSAL BELİRTİLER:
• Spiritüel arayışın yoğunlaşması
• İçsel huzursuzluk
• Anlamı arayış
• Eski yaşam tarzından tatminsizlik
• Derin sorular

ZİHİNSEL BELİRTİLER:
• Artan farkındalık
• Meditasyonda derinleşme
• Sezgisel anlık içgörüler
• Rüyaların canlılaşması

BU AŞAMADA NE YAPILMALI:
• Pratikleri yoğunlaştır
• Topraklama çalışmalarına dikkat
• Diyeti arındır
• Uygun rehberlik bul
• Sabırlı ol
''';

  static const String awakeningStage = '''
3. AŞAMA: UYANIŞ (Awakening)

Kundalini aktif olarak uyanıyor. Artık geri dönüş yok.

KRİYALAR (İstemsiz Hareketler):
• Spontan beden hareketleri
• Titremeler, sallanmalar
• Spontan yoga pozları (asana)
• Spontan el işaretleri (mudra)
• Spontan nefes kalıpları (pranayama)
• Spontan sesler (mantra benzeri)

Bu kriyalar, enerjinin bedenden geçişinin doğal sonucu.
Korkmaya gerek yok, ama kontrol etmeye de çalışma -
akışa izin ver.

ISITMA DENEYİMLERİ (Tapas):
• Omurga boyunca sıcaklık
• "İç ateş" hissi
• Gece terlemeleri
• Sıcak basmaları (menopoz benzeri)

Bu ısı, arınma sürecinin parçası. Beden ve enerji bedeni
temizleniyor.

DUYGUSAL SERBEST BIRAKMA:
• Kontrol edilemeyen ağlama
• Ani gülme patlamaları
• Eski duyguların yüzeye çıkması
• Travma anılarının belirmesi

Bu, duygusal arınma. Yargılamadan, bastırmadan
deneyimle ve bırak.
''';

  static const String risingStage = '''
4. AŞAMA: YÜKSELİŞ (Rising)

Kundalini Sushumna boyunca yukarı hareket ediyor.
Her chakradan geçerken o chakranın temaları yüzeye çıkıyor.

MULADHARA'DAN GEÇİŞ:
• Güvenlik konularının çözülmesi
• Aile/köken temaları
• Topraklanma deneyimi
• Temel korkulara ile yüzleşme

SVADHISTHANA'DAN GEÇİŞ:
• Cinsel enerji dalgaları
• Duygusal temizleme
• Yaratıcılık patlamaları
• İlişki kalıplarının farkındalığı

MANIPURA'DAN GEÇİŞ:
• Güç konularıyla yüzleşme
• Ego yapılarının sarsılması
• İrade güçlenmesi
• Sindirim değişimleri

ANAHATA'DAN GEÇİŞ:
• Kalp açılması
• Yoğun sevgi deneyimi
• Bağışlama dalgaları
• Birlik hissi başlangıcı

VISHUDDHA'DAN GEÇİŞ:
• Ses değişimleri
• İfade özgürlüğü
• İç seslerin duyulması
• Yaratıcı kelam

AJNA'DAN GEÇİŞ:
• Vizyonlar
• Psişik açılmalar
• Zaman algısı değişimi
• İçgörü seli

Bu süreç haftalar, aylar veya yıllar sürebilir.
Herkesin hızı farklıdır.
''';

  static const String piercingStage = '''
5. AŞAMA: DÜĞÜMLERDEN GEÇME (Piercing the Granthis)

Üç granthi (düğüm), Kundalini'nin yükselişini "engelleyen"
ama aynı zamanda "koruyan" yapılardır. Her birinin delişi
büyük bir dönüşüm getirir.

BRAHMA GRANTHİ (Muladhara-Svadhisthana):
Dünyevi bağlanmalar düğümü
• Konum: Kök bölge
• Tema: Maddi güvenlik, fiziksel varoluş, hayatta kalma
• Engelledikleri: Maddi dünyaya aşırı bağlanma
• Delinme deneyimi: Derin varoluşsal korkunun çözülmesi,
  maddi kaygıların hafiflemesi
• Sonuç: Gerçek güvenliğin içeriden geldiği bilinci

VİSHNU GRANTHİ (Manipura-Anahata):
Duygusal bağlanmalar düğümü
• Konum: Göbek-kalp arası
• Tema: Güç, kontrol, statü, ilişkisel bağımlılıklar
• Engelledikleri: Ego şişkinliği, güç tutkusu
• Delinme deneyimi: Ego'nun çökmesi ve yeniden yapılanması
• Sonuç: Gücün hizmet için olduğu bilinci

RUDRA GRANTHİ (Vishuddha-Ajna):
Bireysellik düğümü
• Konum: Boğaz-alın arası
• Tema: Bireysel kimlik, "ben" kavramı
• Engelledikleri: Ayrı benlik yanılsaması
• Delinme deneyimi: Bireysel bilincin çözülmesi
• Sonuç: "Ben" in evrensel bilince açılması

Her düğümün delişi yoğun olabilir. Rehberlik önemli.
''';

  static const String floweringStage = '''
6. AŞAMA: ÇİÇEKLENME (Flowering)

Kundalini üst chakralara ulaşmış, büyük açılışlar yaşanıyor.

AJNA AKTİVASYONU:
• Üçüncü göz açılması
• Vizyoner deneyimler
• Psişik yeteneklerin güçlenmesi
• İçsel ışık görünümleri
• Derin meditasyon halleri

SİDDHİLER (Psişik Güçler):
Bu aşamada çeşitli yetenekler ortaya çıkabilir:
• Telepati (düşünce okuma/gönderme)
• Durugörü (uzaktan görme)
• Premonisyon (önceden bilme)
• Aura görme
• Şifa kapasitesi
• Astral seyahat

UYARI: Siddhiler amaç değil, yan etkidir. Bunlara
takılmak spiritüel ilerlemeyi durdurur. Kullan ama
bağlanma.

BİLİNÇ HALLERİ:
• Savikalpa samadhi deneyimleri (birlik, ama geri dönüşlü)
• Kozmik bilinç anlıları
• Zamansızlık deneyimi
• "Her şey bir" gerçekleşmesi

BU AŞAMADA DİKKAT:
• Ego şişmesi riski (spiritüel materyalizm)
• Güçlere bağlanma tehlikesi
• Dünyadan kopma riski
• Entegrasyon zorluğu

Topraklanmaya devam et. Günlük hayatla bağlantıyı koru.
''';

  static const String unionStage = '''
7. AŞAMA: BİRLEŞME (Union - Shiva-Shakti Yoga)

Kundalini yolculuğunun zirvesi. Shakti, Sahasrara'da
Shiva ile birleşiyor.

SAMADHİ DENEYİMLERİ:

1. Savikalpa Samadhi:
• Birlik deneyimi, ama "ben" hala var
• "Ben birlik deneyimliyorum"
• Geçici, meditasyon sonrası normal bilince dönüş
• Derin huzur ve neşe

2. Nirvikalpa Samadhi:
• Tam ayrımsızlık, "ben" yok
• Deneyimleyen ve deneyim bir
• Zaman ve mekan yok
• Saf bilinç, tarif edilemez
• Çıkışta dünyayı yeniden öğrenme gerekebilir

3. Sahaja Samadhi:
• Doğal, sürekli aydınlanmış hal
• Günlük yaşamda birlik bilinci
• Dünyada var olurken transcend
• En yüksek gerçekleşme

BİRLEŞMENİN BELİRTİLERİ:
• Ego'nun kalıcı olarak dönüşmesi
• Korkunun bitişi (özellikle ölüm korkusu)
• Koşulsuz sevgi hali
• Derin huzur, neşe ötesi neşe (ananda)
• "Her şey yolunda" bilinci
• Bireysel irade ile ilahi iradenin birliği

SONRA NE OLUR?
Aydınlanma son değil, yeni bir başlangıç. Artık:
• Dünyaya farklı gözlerle dönüş
• Başkalarına hizmet
• Bilgiyi paylaşma (uygunsa)
• "Normal" yaşama devam, ama içeriden farklı

Çoğu büyük usta, aydınlanma sonrası onlarca yıl
daha dünyada kalıp öğretmiştir.
''';

  static const String integrationChallenges = '''
ENTEGRASYON ZORLUKLARI

Kundalini uyanışı bitince bile entegrasyon yıllarca sürebilir.

YAŞANACAK ZORLUKLAR:

1. "KARAYA DÖNÜŞ" SENDROMu:
Yoğun deneyimlerden sonra "normal" hayata dönmek
zor olabilir. Bir yanda kozmik bilinç, diğer yanda
fatura ödemek, iş yapmak...

Çözüm: Her ikisi de gerçek. Spiritüel bypass yapma,
dünyevi sorumlulukları reddetme. Denge bul.

2. ÇEVRE İLE KOPUKLUK:
Eski arkadaşlar, aile anlayamayabilir. Yalnızlık hissi.

Çözüm: Anlayan insanlar bul. Ama eski ilişkileri de
reddetme - herkes kendi yolculuğunda.

3. PSİKOLOJİK ENTEGRASYON:
Ego çöküşü sonrası yeni ego inşası gerekir. Fonksiyonel
bir ego, aydınlanmış bilinçle uyumlu olmalı.

Çözüm: Psikoterapi yardımcı olabilir. "Spiritüel
aciliyet" konusunda deneyimli terapist ara.

4. FİZİKSEL ADAPTASYON:
Beden hala enerji değişimlerine adapte oluyor olabilir.

Çözüm: Beden çalışmaları, yumuşak yoga, iyi beslenme,
yeterli dinlenme. Süreci zorla.

5. SPİRİTÜEL EGO:
"Ben aydınlandım" düşüncesi, yeni bir ego tuzağı.

Çözüm: Alçakgönüllülük. Gerçek aydınlanmış
kişiler nadiren "aydınlandım" der.
''';
}

// ═══════════════════════════════════════════════════════════════════════════
// KUNDALİNİ BELİRTİLERİ VE SEMPTOMLAR
// ═══════════════════════════════════════════════════════════════════════════

final List<KundaliniSymptom> kundaliniSymptoms = [
  // FİZİKSEL BELİRTİLER
  const KundaliniSymptom(
    name: 'Omurga Isısı',
    category: 'Fiziksel',
    description: 'Omurga boyunca yükselen sıcaklık veya ateş hissi',
    meaning: 'Kundalini enerjisinin Sushumna boyunca hareketi',
    guidance:
        'Korkmayın. Serinletici yiyecekler, hafif giysiler. Aşırı ısınırsa pratikleri yavaşlatın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Spontan Titremeler',
    category: 'Fiziksel',
    description:
        'Kontrol dışı beden titremeleri, özellikle meditasyon sırasında',
    meaning: 'Enerji blokajlarının çözülmesi, sinir sisteminin uyarılması',
    guidance:
        'Bırakın olsun. Bastırmaya çalışmayın. Güvenli bir ortamda pratik yapın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Kriyalar (Spontan Hareketler)',
    category: 'Fiziksel',
    description: 'İstemsiz yoga pozları, el hareketleri, nefes kalıpları',
    meaning: 'Enerji bedenin kendini yeniden düzenlemesi',
    guidance:
        'Akışa izin verin. Güvenli bir ortamda. Çok yoğunsa topraklama yapın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Enerji Akışı Hissi',
    category: 'Fiziksel',
    description: 'Bedende akan elektrik, enerji dalgaları, karıncalanma',
    meaning: 'Prana/kundalini enerjisinin nadilerde hareketi',
    guidance: 'Normal bir belirtidir. Dikkatle gözlemleyin, korkmayın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Uyku Değişimleri',
    category: 'Fiziksel',
    description: 'Uykusuzluk, çok uyuma, canlı rüyalar, uyanık rüya halleri',
    meaning: 'Bilinç durumlarının yeniden düzenlenmesi',
    guidance: 'Düzenli uyku hijyeni. Gece pratiklerini azaltın. Sabırlı olun.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'İştah Değişimleri',
    category: 'Fiziksel',
    description: 'Aşırı açlık veya iştahsızlık, yeme alışkanlıklarında değişim',
    meaning: 'Enerji metabolizmasının değişmesi',
    guidance: 'Bedeni dinleyin. Hafif, sattvik yiyecekler. Zorlamayın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Baş Ağrısı/Basıncı',
    category: 'Fiziksel',
    description: 'Kaşlar arasında veya başın tepesinde basınç, ağrı',
    meaning: 'Üst chakraların aktivasyonu, enerji birikimi',
    guidance:
        'Topraklama pratikleri. Fiziksel aktivite. Çok yoğunsa doktora danışın.',
    isCommon: true,
  ),

  // DUYGUSAL BELİRTİLER
  const KundaliniSymptom(
    name: 'Duygusal Dalgalanmalar',
    category: 'Duygusal',
    description: 'Ani duygu değişimleri, açıklanamayan ağlamalar veya gülmeler',
    meaning: 'Eski duyguların temizlenmesi, duygusal arınma',
    guidance:
        'Yargılamadan deneyimleyin. Bırakın aksın. Güvenli kişilerle paylaşın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Yoğun Neşe/Ananda',
    category: 'Duygusal',
    description: 'Nedensiz mutluluk, sevinç patlamaları, aşırı iyi hissetme',
    meaning: 'Üst chakraların açılması, bilinç genişlemesi',
    guidance: 'Tadını çıkarın ama bağlanmayın. Bu da geçecek. Topraklı kalın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Korku/Panik',
    category: 'Duygusal',
    description: 'Açıklanamayan korku, panik ataklar, varoluşsal kaygı',
    meaning: 'Ego yapılarının sarsılması, bilinçdışı korkuların yüzeye çıkması',
    guidance:
        'Bu normal bir aşama. Topraklama. Derin nefes. Gerekirse profesyonel yardım.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Koşulsuz Sevgi Dalgaları',
    category: 'Duygusal',
    description: 'Herkese ve her şeye yoğun sevgi hissi',
    meaning: 'Kalp chakrasının açılması',
    guidance:
        'Kucaklayın ama davranışlarınızda dengeli kalın. Sınırları koruyun.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Travma Anılarının Canlanması',
    category: 'Duygusal',
    description:
        'Geçmiş travmaların, çocukluk anılarının canlı şekilde geri gelmesi',
    meaning: 'Psişik temizlenme, bilinçdışının arınması',
    guidance: 'Terapist desteği düşünün. Güvenli ortamda işleyin. Zorlamayın.',
    isCommon: true,
  ),

  // PSİŞİK BELİRTİLER
  const KundaliniSymptom(
    name: 'Vizyonlar',
    category: 'Psişik',
    description: 'İç görüntüler, semboller, geometrik şekiller, renkli ışıklar',
    meaning: 'Ajna chakrasının aktivasyonu, psişik algının açılması',
    guidance: 'Gözlemleyin ama bağlanmayın. Anlamları zamanla açılacak.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'İç Sesler/Müzikler',
    category: 'Psişik',
    description: 'Nada (içsel sesler), müzik, mantralar, sesler',
    meaning: 'İnce beden algısının açılması, Anahata nada',
    guidance: 'Meditasyonda dinleyin. Sesler yönlendirici olabilir.',
    isCommon: false,
  ),
  const KundaliniSymptom(
    name: 'Telepati Deneyimleri',
    category: 'Psişik',
    description: 'Başkalarının düşüncelerini/duygularını algılama',
    meaning: 'Psişik yeteneklerin açılması',
    guidance: 'Enerji korumasını öğrenin. Her düşünce sizin değil.',
    isCommon: false,
  ),
  const KundaliniSymptom(
    name: 'Premonisyonlar',
    category: 'Psişik',
    description: 'Geleceği önceden görme, rüyalarda veya sezgisel olarak',
    meaning: 'Zaman algısının genişlemesi',
    guidance: 'Not alın ama bağlanmayın. Her vizyon gerçekleşmez.',
    isCommon: false,
  ),
  const KundaliniSymptom(
    name: 'Aura Görme',
    category: 'Psişik',
    description: 'İnsanların veya nesnelerin etrafında enerji alanları görme',
    meaning: 'Eterik görüşün açılması',
    guidance: 'Pratikle geliştirilebilir. Ama bu güce bağlanmayın.',
    isCommon: false,
  ),
  const KundaliniSymptom(
    name: 'Beden Dışı Deneyimler',
    category: 'Psişik',
    description: 'Bedenden ayrılma hissi, astral seyahat',
    meaning: 'Astral bedenin aktivasyonu',
    guidance:
        'Güvenli ortamda olun. Korku duymayın. Geri dönüş her zaman mümkün.',
    isCommon: false,
  ),

  // SPİRİTÜEL BELİRTİLER
  const KundaliniSymptom(
    name: 'Birlik Deneyimleri',
    category: 'Spiritüel',
    description: 'Her şeyle bir olma hissi, ayrılık illüzyonunun düşmesi',
    meaning: 'Samadhi anlıları, bilinç genişlemesi',
    guidance: 'Entegre etmeye çalışın. Günlük hayata taşıyın.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Ego Çözülmesi',
    category: 'Spiritüel',
    description: '"Ben" hissinin zayıflaması veya geçici olarak kaybolması',
    meaning: 'Ahamkara\'nın (ego) dönüşümü',
    guidance:
        'Korkutucu olabilir ama doğal. Ego geri gelecek, dönüşmüş olarak.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'İlahi Mevcudiyet Hissi',
    category: 'Spiritüel',
    description: 'Tanrısal varlığın, kutsal olanın doğrudan hissedilmesi',
    meaning: 'Spiritüel kalbin açılması, bhakti uyanışı',
    guidance: 'Derin bir lütuf. Minnetle kabul edin.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Yaşamın Anlamsızlığı Hissi',
    category: 'Spiritüel',
    description: 'Eski anlamların düşmesi, "karanlık gece" deneyimi',
    meaning: 'Eski kimliğin ölümü, yenisinin henüz doğmaması',
    guidance:
        'Zor ama geçici. Profesyonel destek alın. İntihar düşünceleri varsa acil yardım.',
    isCommon: true,
  ),
  const KundaliniSymptom(
    name: 'Zamansızlık Deneyimi',
    category: 'Spiritüel',
    description: 'Zamanın durması veya genişlemesi hissi',
    meaning: 'Bilinç durumu değişimi, üst chakra aktivasyonu',
    guidance: 'Normal. Güvenli bir yerde olun. Araba kullanmayın bu hallerde.',
    isCommon: false,
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// GÜVENLİK VE TOPRAKLAMA
// ═══════════════════════════════════════════════════════════════════════════

class KundaliniSafety {
  static const String importanceOfPreparation = '''
HAZIRLIĞIN ÖNEMİ

Kundalini, son derece güçlü bir enerjidir. Hazırlıksız
bedende zararlı etkilere yol açabilir. Geleneksel olarak
yıllarca hazırlık önerilir.

NEDEN HAZIRLIK GEREKLİ?

1. NADİLERİN TEMİZLENMESİ
Tıkalı nadilerde enerji düzgün akmaz. Blokajlar
enerji birikimi, fiziksel ve duygusal sorunlara yol açar.

2. CHAKRALARIN DENGELENMESİ
Her chakra, üzerine düşen yükü taşıyabilecek kadar
sağlam olmalı. Dengesiz chakralar, dengesiz uyanışa yol açar.

3. FİZİKSEL BEDENİN HAZIRLANMASI
Sinir sistemi, bezler, kaslar enerji artışını
kaldırabilecek durumda olmalı.

4. ZİHNİN HAZIRLANMASI
Sakin, berrak, odaklanmış zihin gerekli. Dağınık zihin,
dağınık uyanış demek.

5. DUYGUSAL İSTİKRAR
Çözülmemiş travmalar, bastırılmış duygular,
uyanış sırasında yüzeye çıkacak. Bunları işleyebilecek
olgunluk gerekli.

HAZIRLIK NE KADAR SÜRER?
Geleneksel: 12 yıl (!) - ama modern pratisyenler için
gerçekçi değil.
Modern yaklaşım: En az 1-2 yıl düzenli pratik.
''';

  static const String signsOfPrematureAwakening = '''
ERKEN UYANIŞ BELİRTİLERİ

Kundalini hazırlıksız veya çok erken uyanırsa, "Kundalini
sendromu" veya "spiritüel aciliyet" olarak bilinen zorlu
durumlar ortaya çıkabilir.

UYARI İŞARETLERİ:

1. FİZİKSEL SORUNLAR
• Kontrol edilemeyen titremeler, kasılmalar
• Aşırı ısı veya soğukluk
• Kalp çarpıntısı, göğüs ağrısı
• Şiddetli baş ağrıları
• Uyuyamama (günlerce)
• Yeme içme bozuklukları

2. PSİKOLOJİK SORUNLAR
• Panik ataklar
• Derealizasyon (gerçeklik hissinin kaybı)
• Depersonalizasyon (benlik hissinin kaybı)
• Dissosiyasyon
• Psikotik belirtiler (halüsinasyonlar, paranoya)
• İntihar düşünceleri

3. SPİRİTÜEL KRİZ
• Kontrolsüz psişik deneyimler
• "Karanlık varlıklar" görme
• Varoluşsal panik
• Anlam kaybı
• Spiritüel obsesyon

NE YAPILMALI?

HEMEN:
• Tüm spiritüel pratikleri durdur
• Yoğun topraklama (yere otur/yat)
• Et yeme, ağır yiyecekler
• Fiziksel aktivite
• Doğada vakit geçir
• Güvendiğin biriyle konuş

PROFESYONEL YARDIM:
• "Spiritüel aciliyet" bilen terapist
• Kundalini deneyimli yoga öğretmeni
• Gerekirse psikiyatrist (ilaç son çare)
''';

  static const String groundingTechniques = '''
TOPRAKLAMA TEKNİKLERİ

Topraklama, yüksek enerjileri dünyaya verme, bedenle ve
gerçeklikle bağlantıda kalma pratiğidir. Kundalini çalışmalarında
ZORUNLUDUR.

FİZİKSEL TOPRAKLAMA:

1. AYAKLA YER TEMASI
• Çıplak ayakla toprak, çim, kumda yürü
• 20-30 dakika, her gün
• Enerjinin ayaklardan toprağa aktığını hisset

2. YATARAK TOPRAKLAMA
• Sırtüstü yere uzan (tercihen toprak)
• Bedenin tüm yüzeyinin yere değdiğini hisset
• Enerjinin toprağa aktığını hayal et

3. AĞAÇ SARGI
• Bir ağaca sırtını daya veya sarıl
• Kökleri ile toprağa bağlandığını hisset
• 10-15 dakika

4. SOĞUK SU
• Yüze veya bileklere soğuk su
• Soğuk duş (kısa)
• Ayakları soğuk suya koy

5. FIZIKSEL AKTİVİTE
• Yürüyüş, koşu (hafif)
• Bahçe işleri
• Temizlik, ev işleri
• Dans (topraklayıcı, ağır)

DİYETLE TOPRAKLAMA:

1. KÖK SEBZELER
Patates, havuç, turp, pancar - toprağın enerjisini taşır

2. PROTEIN
Et, yumurta, baklagiller - bedeni ağırlaştırır

3. AĞIR YİYECEKLER
Tahıllar, ekmek - topraklayıcı

4. KAÇINILACAKLAR (Aşırı enerji döneminde)
• Oruç
• Çok hafif yeme
• Aşırı çiğ gıda
• Kafein, alkol

ENERJİ TOPRAKLAMASI:

1. KÖK CHAKRA NEFESİ
Nefesi ayaklardan çekip, köklerin toprağa uzandığını hayal et

2. DAĞI HİSSET
Dağ pozunda (Tadasana) dur, dağ gibi sağlam ol

3. TOPRAK MANTRASI
"LAM" mantrasını tekrarla (Muladhara bija mantra)

4. KIRMIZI IŞIK
Kök bölgede kırmızı ışık topunu hayal et
''';

  static const String whenToSlowDown = '''
NE ZAMAN YAVASLAMALI

Kundalini pratiklerinde "daha fazla daha iyi" DEĞİL.
Bazen durdurmak veya yavaşlamak zorunludur.

YAVAŞLAMA İŞARETLERİ:

1. UYKU SORUNLARI
• Birkaç gün uyuyamama
• Aşırı uyuma (12+ saat)
• Çok yoğun, rahatsız edici rüyalar

2. DUYGUSAL DENGESIZLIK
• Günlük hayatı etkileyecek düzeyde
• İş/ilişkilerde sorunlar
• Kontrol edilemeyen ağlama/öfke

3. FIZIKSEL BELIRTILER
• Aşırı enerji veya bitkinlik
• Kalp sorunları belirtileri
• Baş ağrısı günlerce süren
• Sindirim ciddi bozulmuş

4. ZIHINSEL SORUNLAR
• Odaklanamama (iş yapamaz hale)
• Gerçeklik algısı değişimi
• Dissosiyatif belirtiler
• Psikotik benzeri deneyimler

NE YAPILMALI:

1. PRATİKLERİ DURDUR VEYA AZALT
• Yoğun pranayama'yı bırak
• Meditasyonu kısalt (5-10 dk max)
• Bandha'ları bırak
• Mantra tekrarını azalt

2. GÜNLÜK HAYATA ODAKLAN
• İş, ev, aile
• Sosyal aktiviteler
• Hobiler (spiritüel olmayan)
• Eğlence, rahatlama

3. TOPRAKLAYICI AKTİVİTELER
• Yürüyüş, spor
• Bahçe işleri
• El işleri
• Yemek yapma

4. DESTEK AL
• Deneyimli öğretmen
• Terapi
• Destek grupları
• Güvendiğin insanlar

NE KADAR BEKLE?
Belirtiler geçene kadar. Günler, haftalar veya aylar
olabilir. Acele etme.
''';

  static const String teacherGuidanceImportance = '''
ÖĞRETMEN REHBERLİĞİNİN ÖNEMİ

Geleneksel olarak Kundalini, bir guru olmadan ÇALİŞILMAZ.
Modern çağda bu zor olsa da, deneyimli rehberlik hala
çok değerlidir.

NEDEN ÖĞRETMEN ÖNEMLİ?

1. DOĞRU TEKNİK
Kitaplardan veya videolardan öğrenilen tekniklerde
hatalar olabilir. Küçük bir hata, büyük sorunlara
yol açabilir.

2. BİREYSEL UYARLAMA
Her beden, her bilinç farklı. Genel tarifler
herkese uymaz. Öğretmen, bireysel ihtiyaçları görür.

3. KORUMA
Deneyimli öğretmen, tehlikeli durumları önceden görür
ve önler. Sorun çıkınca müdahale eder.

4. ENERJİ AKTARIMI (ŞAKTİPAT)
Bazı öğretmenler, doğrudan enerji aktarımı yapabilir.
Bu, yolculuğu hızlandırır ve güvenliğini artırır.

5. ENTEGRASYON DESTEĞİ
Deneyimlerin ne anlama geldiğini, nasıl entegre
edileceğini bilirler.

ÖĞRETMEN SEÇİMİ:

ARAYIN:
• Uzun yıllık kişisel pratik
• Kendi uyanış deneyimi
• Kendi öğretmeni (soy ağacı)
• Dürüstlük, alçakgönüllülük
• Soru sormaya açıklık
• Etik davranış

KAÇININ:
• "Hemen aydınlanma" vaadi
• Aşırı para talebi
• Cinsel veya duygusal istismar
• Sorgulanamazlık iddiası
• "Sadece benim yolum" tutumu
• Güç gösterileri

ÖĞRETMEN BULAMAZSAN?
• Kitaplar dikkatli oku
• Online kaynakları araştır
• Yavaş ilerle
• Kendi bedenini dinle
• Şüphe duyduğunda durma
''';
}

// ═══════════════════════════════════════════════════════════════════════════
// PRANAYAMA TEKNİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

final List<KundaliniPractice> pranayamaPractices = [
  const KundaliniPractice(
    name: 'Nadi Shodhana (Alternatif Burun Nefesi)',
    sanskritName: 'नाडी शोधन',
    category: 'Pranayama',
    description: '''
En temel ve en güvenli kundalini hazırlık pratiği.
Ida ve Pingala nadilerini dengeler, Sushumna'nın
açılmasına zemin hazırlar.
''',
    technique: '''
1. Sukhasana veya Padmasana'da otur
2. Sol el dizde Chin Mudra'da
3. Sağ el Vishnu Mudra'da (işaret+orta parmak bükük)
4. Sağ başparmakla sağ burun deliğini kapat
5. Sol burun deliğinden 4 sayı nefes al
6. Her iki deliği kapatıp 16 sayı tut (ileri seviye)
   veya tutma yapma (başlangıç)
7. Sol burun deliğini kapatıp sağdan 8 sayı ver
8. Aynı taraftan (sağdan) 4 sayı al
9. Tut (isteğe bağlı)
10. Soldan 8 sayı ver
11. Bu bir döngü. 10-20 döngü tekrarla.

Oran: 1:4:2 (al:tut:ver) - ileri seviye
Başlangıç: 1:0:2 (tutma yok)
''',
    benefits: '''
• Ida ve Pingala dengelenir
• Zihin sakinleşir
• Nadiler temizlenir
• Sushumna'ya hazırlık
• Stres azalır
• Uyku düzelir
• Kan basıncı dengelenir
''',
    precautions: '''
• Soğuk algınlığında yapmayın
• Yemekten en az 2 saat sonra
• Zorlanıyorsanız oranı küçültün
• Baş dönmesi olursa bırakın
''',
    durationMinutes: 15,
    difficulty: 'Başlangıç',
    contraindications: ['Burun tıkanıklığı', 'Ciddi solunum hastalıkları'],
  ),

  const KundaliniPractice(
    name: 'Kapalabhati (Kafatası Parlatma)',
    sanskritName: 'कपालभाति',
    category: 'Pranayama',
    description: '''
Güçlü, arındırıcı nefes tekniği. Nadileri temizler,
sindirim ateşini (agni) güçlendirir, Manipura'yı uyarır.
''',
    technique: '''
1. Rahat bir oturuşta otur
2. Derin bir nefes al
3. Karın kaslarını hızla kasarak kısa, güçlü nefes ver
4. Nefes alma pasif, otomatik olsun (karın gevşeyince)
5. Başlangıç hızı: Saniyede 1 nefes
6. İleri seviye: Saniyede 2 nefes
7. 30 nefes yap, sonra derin nefes al, tut, yavaşça ver
8. 1 dakika dinlen
9. 3 set tekrarla

NOT: Odak nefes vermede. Nefes alma pasif.
''',
    benefits: '''
• Nadiler temizlenir
• Sindirim güçlenir
• Zihin berraklaşır
• Enerji artar
• Toksinler atılır
• Manipura aktive olur
• Kundalini uyarılır (hafif)
''',
    precautions: '''
• Yemekten 3-4 saat sonra
• Hamilelikte yapmayın
• Adet döneminde dikkatli
• Hipertansiyon varsa yavaş yapın
• Kalp hastalarına önerilmez
• Baş dönmesi olursa durdurun
''',
    durationMinutes: 10,
    difficulty: 'Orta',
    contraindications: [
      'Hamilelik',
      'Kalp hastalıkları',
      'Yüksek tansiyon (kontrolsüz)',
      'Epilepsi',
      'Hernia',
      'Son ameliyat',
    ],
  ),

  const KundaliniPractice(
    name: 'Bhastrika (Körük Nefesi)',
    sanskritName: 'भस्त्रिका',
    category: 'Pranayama',
    description: '''
Kapalabhati'den daha yoğun. Hem nefes alma hem verme aktif.
Güçlü arındırıcı, ısıtıcı. Kundalini'yi güçlü şekilde uyarır.
''',
    technique: '''
1. Vajrasana veya Padmasana'da otur
2. Derin bir nefes al ve ver
3. Güçlü, hızlı nefes al (karın genişler)
4. Hemen ardından güçlü, hızlı nefes ver (karın çekilir)
5. Her ikisi de aktif, eşit güçte
6. 20-30 nefes yap
7. Son verişte derin nefes al, tut (Kumbhaka)
8. Mula Bandha ve Jalandhara Bandha uygula
9. Tutabildiğin kadar tut
10. Yavaşça ver
11. 1 dakika dinlen, 3 set tekrarla

Hız: Saniyede 1-2 nefes (başlangıç yavaş)
''',
    benefits: '''
• Çok güçlü arındırma
• Kundalini'yi uyarır
• Sushumna'yı açar
• Enerji patlaması
• Toksinler atılır
• Metabolizma hızlanır
• Zihin aktifleşir
''',
    precautions: '''
• İLERİ SEVİYE TEKNİK
• Önce Kapalabhati'de ustalaşın
• Yemekten 4+ saat sonra
• Aşırı yapmayın (overbreathing)
• Hiperventilasyon belirtilerinde durun
• Deneyimli rehber eşliğinde öğrenin
''',
    durationMinutes: 10,
    difficulty: 'İleri',
    contraindications: [
      'Hamilelik',
      'Kalp hastalıkları',
      'Yüksek tansiyon',
      'Epilepsi',
      'Göz sorunları (glokom)',
      'Son ameliyat',
      'Psikiyatrik durumlar',
    ],
  ),

  const KundaliniPractice(
    name: 'Ujjayi (Okyanus/Zafer Nefesi)',
    sanskritName: 'उज्जायी',
    category: 'Pranayama',
    description: '''
Boğazı hafifçe daraltarak yapılan nefes. Okyanus sesi gibi
bir ses çıkar. Sakinleştirici, odaklandırıcı. Vishuddha'yı uyarır.
''',
    technique: '''
1. Rahat bir oturuşta otur
2. Ağzı kapat
3. Boğazın arkasını (glottis) hafifçe daralt
4. Burundan nefes al - hafif sürtünme sesi çıkmalı
   (fısıldamaya hazırlanır gibi)
5. Aynı ses ile burundan ver
6. Ses "okyanus dalgası" veya "Darth Vader" nefesi gibi
7. Nefes alma ve verme eşit uzunlukta
8. 5-20 dakika devam et

Asana pratiği sırasında da kullanılabilir.
''',
    benefits: '''
• Zihni sakinleştirir
• Odaklanmayı artırır
• Vishuddha'yı uyarır
• Kan basıncını düzenler
• Tiroidi masajlar
• Meditasyon için hazırlar
• Pratikte sürekliliği sağlar
''',
    precautions: '''
• Aşırı daraltmaktan kaçının (boğulma hissi)
• Ses çok yüksek olmamalı
• Yüz, boyun gergin olmamalı
• Baş ağrısı olursa bırakın
''',
    durationMinutes: 15,
    difficulty: 'Başlangıç',
    contraindications: ['Düşük tansiyon', 'Ciddi boğaz sorunları'],
  ),

  const KundaliniPractice(
    name: 'Kumbhaka (Nefes Tutma)',
    sanskritName: 'कुम्भक',
    category: 'Pranayama',
    description: '''
Nefes tutma pratiği. Prana'yı yoğunlaştırır, Sushumna'ya yönlendirir.
İleri seviye teknik, dikkatli çalışılmalı.
''',
    technique: '''
ANTARA KUMBHAKA (İç tutma):
1. Derin nefes al
2. Nefesi tut (akciğerler dolu)
3. Mula Bandha ve Jalandhara Bandha uygula
4. Rahat tutabildiğin kadar tut
5. Yavaşça ver

BAHYA KUMBHAKA (Dış tutma):
1. Tamamen nefes ver
2. Nefesi dışarıda tut (akciğerler boş)
3. Uddiyana Bandha ve Jalandhara Bandha uygula
4. Rahat tutabildiğin kadar tut
5. Yavaşça al

ORANLAR (İleri seviye):
1:4:2 (al:tut:ver) - Antara için
1:4:2:4 (al:tut:ver:tut) - Her ikisi için

Başlangıç: Kısa tutmalarla başla, zorlanmadan.
''',
    benefits: '''
• Prana yoğunlaşır
• Sushumna aktive olur
• Zihin durur
• Derin meditasyon kapısı
• Kundalini uyarılır
• Metabolizma yavaşlar
• Ömür uzar (geleneksel inanış)
''',
    precautions: '''
• İLERİ SEVİYE - yeni başlayanlar için değil
• Asla zorlamayın
• Baş dönmesi olursa bırakın
• Kalp sorunlarında yapmayın
• Deneyimli rehber eşliğinde
• Aşırı tutma tehlikeli olabilir
''',
    durationMinutes: 20,
    difficulty: 'İleri',
    contraindications: [
      'Kalp hastalıkları',
      'Yüksek tansiyon',
      'Glokom',
      'Akciğer hastalıkları',
      'Psikiyatrik durumlar',
    ],
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// BANDHA TEKNİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

final List<KundaliniPractice> bandhaPractices = [
  const KundaliniPractice(
    name: 'Mula Bandha (Kök Kilidi)',
    sanskritName: 'मूल बन्ध',
    category: 'Bandha',
    description: '''
Pelvik taban kilidi. Kundalini pratiğinin en temel tekniklerinden.
Enerjiyi yukarı yönlendirir, Muladhara'yı uyarır.
''',
    technique: '''
1. Rahat bir oturuşta otur (Siddhasana ideal)
2. Dikkatini perine bölgesine ver:
   - Erkekler: Anüs ile skrotum arası
   - Kadınlar: Serviks / vajina girişi bölgesi
3. Nefes ver
4. Nefes tutarak bu bölgeyi yukarı doğru çek (sık)
5. Kasılmayı tut, nefes normal devam edebilir
6. 5-10 saniye tut
7. Bırak, dinlen
8. 10-20 tekrar yap

İLERİ SEVİYE:
• Tüm gün boyunca hafif Mula Bandha tutmak
• Pranayama ve asana ile birleştirmek
• Kumbhaka sırasında uygulamak
''',
    benefits: '''
• Kundalini'yi doğrudan uyarır
• Apana vayu'yu yukarı yönlendirir
• Muladhara'yı aktive eder
• Pelvik taban kaslarını güçlendirir
• Cinsel enerjiyi dönüştürür
• Konsantrasyonu artırır
''',
    precautions: '''
• İnce, hassas bir kasılma yeterli
• Anüs kasılması değil (Ashwini Mudra farklı)
• Aşırı sıkmayın
• Hamilelikte dikkatli olun
''',
    durationMinutes: 10,
    difficulty: 'Başlangıç-Orta',
    contraindications: ['Akut hemoroid', 'Pelvik enfeksiyon'],
  ),

  const KundaliniPractice(
    name: 'Uddiyana Bandha (Karın Kilidi)',
    sanskritName: 'उड्डीयान बन्ध',
    category: 'Bandha',
    description: '''
Karın çekme kilidi. "Uddiyana" = "uçmak" - enerjiyi yukarı uçurur.
En güçlü bandha, Manipura'yı aktive eder.
''',
    technique: '''
1. Ayakta veya oturarak yap
2. Ayaklarını kalça genişliğinde aç
3. Elleri dizlere koy, hafifçe öne eğil
4. Derin nefes al, sonra tamamen ver (Bahya Kumbhaka)
5. Nefes tutarak:
   - Karın duvarını içeri ve yukarı çek
   - Göğüs kafesi genişler (sahte nefes alma)
   - Diyafram yükselir
   - Karın "çukur" gibi olur
6. Tutabildiğin kadar tut
7. Karın kaslarını gevşet, yavaşça nefes al
8. Dinlen, 3-5 tekrar yap

UYARI: SADECE BOŞ MİDEYLE ve NEFES DIŞARIDA iken yapılır!
''',
    benefits: '''
• Çok güçlü Kundalini uyarıcı
• Manipura'yı aktive eder
• Sindirim organlarını masajlar
• Constipation'a iyi gelir
• Abdominal kasları güçlendirir
• Prana'yı Sushumna'ya yönlendirir
''',
    precautions: '''
• Sadece boş mideyle (4+ saat sonra)
• Hamilelikte ASLA
• Adet döneminde yapmayın
• Kalp hastalarına önerilmez
• Hipertansiyonda dikkatli
• Zorlanıyorsanız bırakın
''',
    durationMinutes: 5,
    difficulty: 'Orta-İleri',
    contraindications: [
      'Hamilelik',
      'Adet dönemi',
      'Kalp hastalıkları',
      'Yüksek tansiyon',
      'Hernia',
      'Ülser',
      'Glaucoma',
    ],
  ),

  const KundaliniPractice(
    name: 'Jalandhara Bandha (Boğaz Kilidi)',
    sanskritName: 'जालन्धर बन्ध',
    category: 'Bandha',
    description: '''
Çene kilidi. Boğazı kapatarak enerji ve nefesi tutar.
Vishuddha'yı korur, prana'nın dağılmasını önler.
''',
    technique: '''
1. Rahat bir oturuşta otur (Padmasana, Siddhasana)
2. Elleri dizlerde
3. Derin nefes al
4. Nefes tutarak:
   - Çeneyi göğse doğru indir
   - Boyun arkasını uzat
   - Omuzlar rahat kalmalı
   - Göğüs hafifçe kalkık
5. Kumbhaka boyunca tut
6. Baş yukarı, nefes ver
7. Dinlen, tekrarla

NOT: Genellikle pranayama sırasında, kumbhaka ile birlikte uygulanır.
''',
    benefits: '''
• Prana'yı tutar, dağılmasını önler
• Tiroid ve paratiroid bezlerini uyarır
• Vishuddha'yı aktive eder
• Kalp atış hızını düzenler
• Kumbhaka'yı güçlendirir
• Enerjiyi aşağı inmekten alıkoyar
''',
    precautions: '''
• Boyun sorunlarında dikkatli
• Tiroid sorunlarında dikkatli
• Zorlanmayın, nazikçe uygulayın
• Baş dönmesi olursa bırakın
''',
    durationMinutes: 5,
    difficulty: 'Başlangıç-Orta',
    contraindications: [
      'Ciddi boyun sorunları',
      'Kontrolsüz hipertiroidizm',
      'Ciddi kalp sorunları',
    ],
  ),

  const KundaliniPractice(
    name: 'Maha Bandha (Büyük Kilit)',
    sanskritName: 'महा बन्ध',
    category: 'Bandha',
    description: '''
Üç bandhanın birlikte uygulanması. En güçlü kilitleme.
Kundalini'yi çok güçlü şekilde uyarır.
''',
    technique: '''
1. Siddhasana'da otur (topuk perineye baskı yapmalı)
2. Elleri dizlerde
3. Derin nefes al
4. Tamamen nefes ver (Bahya Kumbhaka)
5. Sırasıyla uygula:
   a. Jalandhara Bandha (çene aşağı)
   b. Uddiyana Bandha (karın içeri)
   c. Mula Bandha (pelvik taban yukarı)
6. Üçünü birlikte tut
7. Tutabildiğin kadar tut
8. Ters sırayla bırak:
   a. Mula Bandha
   b. Uddiyana Bandha
   c. Jalandhara Bandha
9. Baş yukarı, yavaşça nefes al
10. Dinlen, 3-5 tekrar yap

İLERİ SEVİYE TEKNİK - önce her bandha ayrı ayrı ustalaşılmalı.
''',
    benefits: '''
• Üç bandhanın tüm faydaları birlikte
• Kundalini'yi çok güçlü uyarır
• Üç granthi üzerinde çalışır
• Prana'yı Sushumna'da yoğunlaştırır
• Derin meditasyon hazırlığı
• Yaşlanmayı yavaşlatır (geleneksel)
''',
    precautions: '''
• İLERİ SEVİYE - acele etmeyin
• Önce her bandha ayrı ustalaşın
• Sadece boş mideyle
• Rehberlik altında öğrenin
• Tüm bandha kontraendikasyonları geçerli
''',
    durationMinutes: 10,
    difficulty: 'İleri',
    contraindications: [
      'Tüm bireysel bandha kontraendikasyonları',
      'Yeni başlayanlar',
      'Psikiyatrik durumlar',
      'Kontrolsüz yüksek tansiyon',
    ],
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// MUDRA TEKNİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

final List<KundaliniPractice> mudraPractices = [
  const KundaliniPractice(
    name: 'Khechari Mudra (Dil Mudrası)',
    sanskritName: 'खेचरी मुद्रा',
    category: 'Mudra',
    description: '''
"Gökyüzünde hareket eden" mudra. Dil damağa veya daha derine
kıvrılır. Amrita (ölümsüzlük nektarı) akışını tetikler.
En güçlü mudralardan biri.
''',
    technique: '''
BAŞLANGIÇ FORMU:
1. Dili yumuşak damağa değdir (sert damak arkası)
2. Dil ucu geriye kıvır
3. Bu pozisyonda meditasyon yap
4. Günde 15-30 dakika pratik

İLERİ FORM (Geleneksel):
1. Yıllar süren pratikle dil uzar
2. Dil, yumuşak damağın ötesine geçer
3. Nasal kavitenin arkasına ulaşır
4. Amrita akışı başlar (tatlı sıvı)

NOT: İleri form için geleneksel olarak dil altı
bağları kesme (frenulum) uygulanırdı. Modern
pratisyenler için gerekli veya önerilen değil.
''',
    benefits: '''
• Amrita (nektar) akışını tetikler
• Açlık ve susuzluğu azaltır
• Yaşlanmayı yavaşlatır
• Kundalini'yi uyarır
• Derin meditasyon durumları
• Bilinç durumlarını değiştirir
''',
    precautions: '''
• Uzun vadeli pratik gerektirir
• Zorlamayın - dil kendiliğinden uzar
• Frenulum kesme ÖNERİLMEZ
• Kusma refleksi olabilir başta
''',
    durationMinutes: 30,
    difficulty: 'İleri',
    contraindications: ['Dil sorunları', 'Ciddi gag refleksi'],
  ),

  const KundaliniPractice(
    name: 'Shambhavi Mudra (Kaşlar Arası Bakış)',
    sanskritName: 'शाम्भवी मुद्रा',
    category: 'Mudra',
    description: '''
Gözleri kaşlar arasına (Ajna noktası) odaklama mudrası.
En önemli meditasyon tekniklerinden. Ajna chakrasını
güçlü şekilde uyarır.
''',
    technique: '''
1. Rahat meditasyon pozisyonunda otur
2. Omurgayı düzelt, vücudu gevşet
3. Gözleri aç veya yarı kapat
4. Bakışı yukarı ve içeri yönlendir
5. Kaşlar arasına, alna biraz içeriye odaklan
6. Kaşları çatma, alın rahat kalsın
7. Gözler yorulursa kapat, içeriden bakmaya devam et
8. Nefes doğal aksın
9. 10-30 dakika devam et

Başta göz yorulması normal - zamanla dayanıklılık artar.
''',
    benefits: '''
• Ajna chakrasını doğrudan uyarır
• Derin meditasyon sağlar
• Konsantrasyonu güçlendirir
• İç görüşü açar
• Sushumna akışını tetikler
• Zihin sessizleşir
''',
    precautions: '''
• Gözleri zorlamayın
• Baş ağrısı olursa bırakın
• Glokom varsa dikkatli
• Düzenli ara verin
''',
    durationMinutes: 20,
    difficulty: 'Orta',
    contraindications: ['Glokom', 'Ciddi göz sorunları'],
  ),

  const KundaliniPractice(
    name: 'Yoni Mudra / Shanmukhi Mudra',
    sanskritName: 'योनि मुद्रा',
    category: 'Mudra',
    description: '''
Dış duyuları kapatma mudrası. Parmaklarla kulaklar, gözler,
burun ve ağız kapatılır. Pratyahara (duyuların geri çekilmesi)
için güçlü teknik.
''',
    technique: '''
1. Rahat meditasyon pozisyonunda otur
2. Dirsekleri yukarı kaldır
3. Parmakları yüze yerleştir:
   - Başparmaklar kulakları kapatır
   - İşaret parmakları göz kapaklarına (hafifçe)
   - Orta parmaklar burun kenarlarına
   - Yüzük parmakları üst dudağa
   - Serçe parmakları alt dudağa
4. Derin nefes al
5. Nefes tutarak mudraya gir
6. İç sesleri (nada) dinle
7. Tutabildiğin kadar tut
8. Yavaşça bırak, nefes ver
9. 5-10 tekrar yap
''',
    benefits: '''
• Dış dünyadan tamamen keser
• Pratyahara'yı güçlendirir
• İç sesleri (nada) duyurur
• Derin meditasyon sağlar
• Kundalini yükselişine hazırlar
• Psişik algıyı açar
''',
    precautions: '''
• Gözlere bastırmayın
• Kulağı tıkamayın, sadece kapatın
• Nefes tutma zorlamasız
• Klostrofobi hissi olursa bırakın
''',
    durationMinutes: 15,
    difficulty: 'Orta',
    contraindications: ['Kulak enfeksiyonu', 'Göz sorunları', 'Panik bozukluk'],
  ),

  const KundaliniPractice(
    name: 'Ashwini Mudra (At Mudrası)',
    sanskritName: 'अश्विनी मुद्रा',
    category: 'Mudra',
    description: '''
Anal sfinkteri ritmik olarak sıkıp gevşetme. Mula Bandha'nın
dinamik versiyonu. Apana enerji bölgesini uyarır.
''',
    technique: '''
1. Rahat bir oturuşta otur
2. Dikkatini anal bölgeye ver
3. Anal sfinkteri sık (sanki dışkıyı tutuyormuş gibi)
4. Hemen gevşet
5. Ritmik olarak tekrarla: Sık - gevşet - sık - gevşet
6. Hızlı başla, zamanla yavaşlatılabilir
7. 50-100 tekrar yap
8. Dinlen

VARYASYON:
Nefes al - sık, nefes ver - gevşet şeklinde
nefesle koordine edilebilir.
''',
    benefits: '''
• Mula Bandha'ya hazırlık
• Pelvik taban kaslarını güçlendirir
• Konstipasyona iyi gelir
• Hemoroid önler
• Apana vayu'yu uyarır
• Cinsel sağlığı destekler
''',
    precautions: '''
• Hemoroid ağrısı varsa yapmayın
• Aşırı yapmayın
• Kasılma hafif olmalı
''',
    durationMinutes: 5,
    difficulty: 'Başlangıç',
    contraindications: ['Akut hemoroid', 'Anal fissür'],
  ),

  const KundaliniPractice(
    name: 'Vajroli/Sahajoli Mudra',
    sanskritName: 'वज्रोली मुद्रा',
    category: 'Mudra',
    description: '''
Cinsel organ kaslarını çalıştırma mudrası. Erkeklerde Vajroli,
kadınlarda Sahajoli. Cinsel enerjiyi dönüştürür, yukarı yönlendirir.
''',
    technique: '''
ERKEKLER (VAJROLİ):
1. Rahat otur
2. İdrar akışını durduran kasları sık
   (pubococcygeus - PC kasları)
3. Testisleri yukarı çeken hissi de dahil
4. 3-5 saniye tut
5. Gevşet
6. 20-50 tekrar yap

KADINLAR (SAHAJOLİ):
1. Rahat otur
2. Vajinal kasları sık (Kegel benzeri)
3. Serviks bölgesini yukarı çek
4. 3-5 saniye tut
5. Gevşet
6. 20-50 tekrar yap

Her iki cinsiyette Mula Bandha ile birleştirilebilir.
''',
    benefits: '''
• Cinsel enerjiyi (ojas) korur
• Enerjiyi yukarı yönlendirir
• Cinsel sağlığı güçlendirir
• Üreme sistemini destekler
• Brahmacharya pratiği için
• Svadhisthana'yı uyarır
''',
    precautions: '''
• Aşırı yapmayın
• Üriner enfeksiyon varsa dikkatli
• Prostat sorunlarında dikkatli
''',
    durationMinutes: 10,
    difficulty: 'Orta',
    contraindications: ['Akut üriner enfeksiyon', 'Prostat iltihabı'],
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// GRANTHİ (DÜĞÜM) İÇERİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

final List<GranthiContent> granthiContents = [
  const GranthiContent(
    name: 'Brahma Granthi',
    sanskritMeaning: 'Brahma\'nın Düğümü - Yaratıcının Bağı',
    location: Chakra.muladhara,
    blockage: '''
BRAHMA GRANTHİ - BİRİNCİ DÜĞÜM

Konum: Muladhara ve Svadhisthana chakralar arasında.

BU DÜĞÜM NEYİ ENGELLİYOR?
• Fiziksel dünyaya aşırı bağlanma
• Maddi güvenlik obsesyonu
• Hayatta kalma korkusu
• Bedensel kimlikle özdeşleşme
• Cinsel dürtülerin kontrolsüzlüğü
• Dünyevi zevklere tutunma

PSİKOLOJİK TEMALAR:
• Temel güvensizlik
• Aşırı materyalizm
• Fiziksel bağımlılıklar
• Korku ve kaygı temelli yaşam
• Kökenlerle/aileyle çatışmalar

Bu düğüm, bilinci maddi dünyaya "bağlar". Çözülmeden
spiritüel yükseliş mümkün değil.
''',
    liberation: '''
BRAHMA GRANTHİ'NİN AÇILIŞI

NE OLUR?
Kundalini bu düğümü deldığinde:
• Varoluşsal güvensizlik çözülür
• Maddi dünyayla sağlıklı ilişki kurulur
• Ölüm korkusu azalır veya kalkar
• Bedensel kimlik ötesine geçilir
• Dünyevi zevkler bağlayıcılığını kaybeder
• Gerçek güvenliğin içeride olduğu anlaşılır

DENEYIMLER:
• Derin ısı dalgaları
• Omurga tabanında patlama hissi
• Yoğun duygusal boşalma
• Çocukluk/geçmiş anıları
• Korku ve ardından özgürleşme
• "Kök salma" hissi, ama bağlanma olmadan

Süreç yoğun olabilir. Rehberlik ve sabır önemli.
''',
    practices: '''
BRAHMA GRANTHİ ÇALIŞMALARI

1. MULA BANDHA PRATİĞİ
Her gün düzenli Mula Bandha. Başlangıçta kısa,
zamanla uzayan tutmalar.

2. KÖK CHAKRA MEDİTASYONU
Kırmızı ışık, LAM mantrası, perine odaklı meditasyon.

3. TOPRAKLAMA
Yere oturma, doğada vakit geçirme, kök sebzeler.

4. KORKU ÇALIŞMASI
Korkuları tespit et, bilinçli olarak onlarla yüzleş.
Terapi destekli olabilir.

5. AİLE SİSTEMİ ÇALIŞMASI
Aile konstelesyonu, ata şifası, köken temaları.

6. ASANAlar
Muladhara uyarıcı pozlar: Dağ, savaşçı, köprü.

7. DİYET
Topraklayıcı yiyecekler, kök sebzeler, protein.
''',
  ),

  const GranthiContent(
    name: 'Vishnu Granthi',
    sanskritMeaning: 'Vishnu\'nun Düğümü - Koruyucunun Bağı',
    location: Chakra.manipura,
    blockage: '''
VİSHNU GRANTHİ - İKİNCİ DÜĞÜM

Konum: Manipura ve Anahata chakralar arasında.

BU DÜĞÜM NEYİ ENGELLİYOR?
• Duygusal bağlanmalar
• Güç ve kontrol arzusu
• Statü ve tanınma ihtiyacı
• Ego şişkinliği
• İlişkisel bağımlılıklar
• "Yapma" ve "başarma" obsesyonu

PSİKOLOJİK TEMALAR:
• Güç oyunları
• Kontrol ihtiyacı
• Narsistik eğilimler
• İlişkilerde bağımlılık
• Onay ve beğeni arayışı
• Rekabet ve kıskançlık

Bu düğüm, ego yapısını ve duygusal bağlanmaları temsil eder.
Kalbe giden yolu tıkar.
''',
    liberation: '''
VİSHNU GRANTHİ'NİN AÇILIŞI

NE OLUR?
Kundalini bu düğümü deldığinde:
• Ego yapıları çöker ve yeniden yapılanır
• Güç tutkusu dönüşür
• Kontrolü bırakma gerçekleşir
• Duygusal bağımlılıklar çözülür
• Koşulsuz sevgiye kapı açılır
• "Yapmak" yerine "olmak" öncelik kazanır

DENEYİMLER:
• Göbek bölgesinde yoğun aktivite
• Ego ölümü deneyimi
• Yoğun duygusal salınımlar
• Eski ilişki kalıplarının çözülmesi
• Güç fantezilerinin düşmesi
• Alçakgönüllülük ve teslimiyet

Bu aşama özellikle zorlu olabilir - ego ölmek istemez.
''',
    practices: '''
VİSHNU GRANTHİ ÇALIŞMALARI

1. UDDIYANA BANDHA
Manipura'yı güçlü şekilde uyarır, enerjiyi yukarı iter.

2. MANIPURA MEDİTASYONU
Sarı ışık, RAM mantrası, göbek odaklı meditasyon.

3. EGO ÇALIŞMASI
Ego yapılarını fark etme, sorgulama. Terapi destekli.
"Ben kimim?" sorusu.

4. TESLİMİYET PRATİĞİ
Kontrolü bırakma, sonucu bağlamama, akışa güvenme.

5. HİZMET (SEVA)
Karşılıksız hizmet. Ego'nun azalması için.

6. ASANAlar
Manipura ve Anahata uyarıcı: Kobra, deve, balık.

7. KALP AÇILIŞ ÇALIŞMALARI
Metta meditasyonu, bağışlama pratikleri.
''',
  ),

  const GranthiContent(
    name: 'Rudra Granthi',
    sanskritMeaning: 'Rudra\'nın Düğümü - Yıkıcının Bağı',
    location: Chakra.ajna,
    blockage: '''
RUDRA GRANTHİ - ÜÇÜNCÜ DÜĞÜM

Konum: Vishuddha ve Ajna chakralar arasında.

BU DÜĞÜM NEYİ ENGELLİYOR?
• Bireysel kimlik bağlanması
• "Ben" kavramına tutunma
• Entelektüel kibir
• Spiritüel ego
• Siddhilere (güçlere) bağlanma
• İkiliğe (duality) bağlılık

PSİKOLOJİK TEMALAR:
• Kimlik sabitliği
• "Ben şöyleyim, böyleyim"
• Spiritüel materyalizm
• Güçlere sahip olma arzusu
• Ayrı benlik yanılsaması

Bu düğüm en incedir ama en derin. Bireysel bilinçten
evrensel bilince geçişi engeller.
''',
    liberation: '''
RUDRA GRANTHİ'NİN AÇILIŞI

NE OLUR?
Kundalini bu düğümü deldığinde:
• Bireysel kimlik çözülmeye başlar
• "Ben" in sabitliği sorgulanır
• Evrensel bilinçle temas
• Siddhiler gelir ama bağlanılmaz
• İkilik (duality) algısı zayıflar
• Non-dual farkındalık anlıları

DENEYİMLER:
• Boğaz/alın bölgesinde yoğun aktivite
• Kimlik krizi (sağlıklı anlamda)
• "Ben kimim?" sorusunun derinleşmesi
• Vizyonlar, psişik açılmalar
• Zaman/mekan algısında değişim
• Birlik deneyimleri

Bu son kapı - ardında aydınlanma bekler.
''',
    practices: '''
RUDRA GRANTHİ ÇALIŞMALARI

1. JALANDHARA BANDHA
Vishuddha'yı uyarır, enerjiyi üst chakralarda tutar.

2. AJNA MEDİTASYONU
Om mantrası, Shambhavi Mudra, üçüncü göz odaklı pratik.

3. KİMLİK SORGULAMA
"Ben kimim?" sorusu (Ramana Maharshi metodu).
Self-inquiry, atma vichara.

4. SİDDHİLERİ BIRAKMA
Psişik güçlere bağlanmama, amaç değil yan etki.

5. NON-DUAL ÇALIŞMALAR
Advaita Vedanta çalışması, non-dual öğretmenlerle temas.

6. SESSİZLİK
Uzun süreli mauna (sessizlik). Konuşmanın ötesine geçme.

7. TESLİMİYET
İlahi iradeye tam teslimiyet. "Benim iradem değil,
Senin iraden olsun."
''',
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// KUNDALİNİ VE ASTROLOJİ BAĞLANTISI
// ═══════════════════════════════════════════════════════════════════════════

class KundaliniAstrology {
  static const String overview = '''
KUNDALİNİ VE ASTROLOJİ BAĞLANTISI

Astroloji ve Kundalini, aynı kozmik enerjinin farklı
yansımalarıdır. Makrokozmos (gökyüzü) ve mikrokozmos
(insan bedeni) aynı prensipleri paylaşır.

Doğum haritası, bireyin Kundalini potansiyelini, uyanış
zamanlamasını ve deneyim türlerini gösterebilir.
''';

  static const String marsPlutoConnection = '''
MARS VE PLUTO BAĞLANTISI

Kundalini enerjisi, astrolojik olarak en çok Mars ve Pluto
ile ilişkilendirilir.

MARS (MANGAL):
Mars, ham enerji, tutku, eylem ve güç gezegenidir.
• İlkel yaşam gücü (prana)
• Cinsel enerji
• İrade ve eylem kapasitesi
• Cesaret ve savaşçı ruhu

Doğum haritasında güçlü Mars:
• Yüksek enerji seviyesi
• Pratiklere hızlı yanıt
• Bazen kontrolsüz uyanış riski
• Kızgın, yoğun uyanış deneyimleri

PLUTO:
Pluto, derin dönüşüm, ölüm-yeniden doğuş ve gizli
güçlerin gezegenidir.
• Kundalini'nin transformatif doğası
• Ego ölümü ve yeniden doğuş
• Gizli, yeraltı güçleri
• Psişik ve okült yetenekler

Doğum haritasında güçlü Pluto:
• Derin dönüşüm kapasitesi
• Yoğun, bazen zorlu uyanış
• Gölge çalışması gerekliliği
• Güçlü psişik potansiyel

MARS-PLUTO AÇILARI:
Doğum haritasında Mars-Pluto açısı olanlar,
özellikle güçlü Kundalini potansiyeli taşır.
• Kavuşum: Çok yoğun, volkanik enerji
• Kare: Zorlayıcı ama dönüştürücü
• Üçgen: Akışkan güç, kolay erişim
• Karşıt: Güç mücadeleleri, dışa projeksiyon
''';

  static const String eighthHouseIndicators = '''
8. EV VE KUNDALİNİ

8. ev, astrolojide Kundalini ile en doğrudan bağlantılı evdir.

8. EV TEMALARI:
• Dönüşüm ve yeniden doğuş
• Ölüm (fiziksel ve sembolik)
• Cinsel enerji ve Tantra
• Gizli güçler, okült
• Başkalarının kaynakları
• Psişik yetenekler
• Derin psikoloji, bilinçdışı

8. EV VE KUNDALİNİ:
Güçlü 8. ev vurgusu (gezegen kümeleri, yönetici güçlü):
• Doğal Kundalini çekimi
• Dönüşüm deneyimlerine açıklık
• Derin, yoğun uyanış potansiyeli
• Gölge çalışması zorunluluğu
• Psişik yeteneklere yatkınlık

8. EVDE GEZEGENLER:

Güneş 8. evde: Ego dönüşümü merkezi tema
Ay 8. evde: Duygusal yoğunluk, psişik alıcılık
Mars 8. evde: Güçlü Kundalini potansiyeli, cesur dönüşüm
Pluto 8. evde: En yoğun - derin, kaçınılmaz dönüşümler
Neptün 8. evde: Spiritüel arayış, çözülme deneyimleri
Uranüs 8. evde: Ani, şoke edici uyanışlar
''';

  static const String scorpioEnergy = '''
AKREP ENERJİSİ VE KUNDALİNİ

Akrep burcu, 8. evin doğal yöneticisi olarak Kundalini
ile derin bağlantı taşır.

AKREP TEMALaRI:
• Dönüşüm, ölüm, yeniden doğuş
• Yoğunluk, tutku, derinlik
• Gizlilik, gizemler
• Cinsellik ve güç
• Kontrol ve bırakma
• Hayatta kalma içgüdüsü (yükseliş yoluyla)

AKREP SEMBOLÜ ÜÇ FORMU:
1. Akrep: En düşük - intikam, yıkım, zehir
2. Yılan: Orta - Kundalini uyanışı, dönüşüm
3. Kartal/Phoenix: En yüksek - transcendence, yeniden doğuş

Kundalini yolculuğu, bu üç aşamayı yansıtır.

DOĞUM HARİTASINDA AKREP:
Güçlü Akrep vurgusu (Güneş, Ay, Yükselen veya gezegen kümesi):
• Doğal dönüşüm kapasitesi
• Yoğun deneyimlere çekim
• Gölge ile yüzleşme zorunluluğu
• Güç konularını çalışma
• Kundalini'ye doğal yatkınlık

PLUTO (Akrep yöneticisi) transitlerinde Kundalini
deneyimleri yoğunlaşabilir.
''';

  static const String triggeringTransits = '''
UYANIŞI TETİKLEYEN TRANSİTLER

Belirli astrolojik transitler, Kundalini uyanışını
tetikleyebilir veya yoğunlaştırabilir.

PLUTO TRANSİTLERİ:
• Natal Güneş'e Pluto: Ego dönüşümü, yeniden doğuş
• Natal Ay'a Pluto: Duygusal arınma, derinler çıkar
• Natal Mars'a Pluto: Enerji dönüşümü, güç teması
• Natal 1. eve Pluto: Kimlik dönüşümü
• Natal 8. eve Pluto: En yoğun - derin transformasyon

URANÜS TRANSİTLERİ:
Uranüs ani, beklenmedik uyanışları temsil eder.
• Natal Güneş'e Uranüs: Ani aydınlanmalar
• Natal Ay'a Uranüs: Duygusal şoklar, özgürleşme
• Natal 1. eve Uranüs: Kimlik devrimi
• Natal 8. eve Uranüs: Ani spiritüel deneyimler

NEPTÜN TRANSİTLERİ:
Neptün çözülme, spiritüel açılma getirir.
• Natal Güneş'e Neptün: Ego çözülmesi
• Natal 12. eve Neptün: Derin spiritüel deneyimler
• Natal 8. eve Neptün: Mistik uyanışlar

SATÜRN GERİ DÖNÜŞÜ:
28-30 yaş civarı, 58-60 yaş civarı.
Olgunlaşma dönemleri, spiritüel ciddiyetin başlangıcı.

AY DÜĞÜMÜ TRANSİTLERİ:
Kuzey/Güney düğüm natal noktalara geldiğinde:
Karmik kapılar açılır, spiritüel yolculuk hızlanır.
''';

  static const String natalChartIndicators = '''
DOĞUM HARİTASINDA KUNDALİNİ GÖSTERGELERİ

Aşağıdaki faktörler, doğuştan Kundalini potansiyelini
veya uyanış eğilimini gösterebilir.

GÜÇLÜ GÖSTERGELER:

1. 8. EV VURGUSU
• 3+ gezegen 8. evde
• 8. ev yöneticisi güçlü aspektli

2. AKREP VURGUSU
• Güneş, Ay veya Yükselen Akrep'te
• Gezegen kümesi Akrep'te

3. GÜÇLÜ PLUTO
• Angular evlerde (1, 4, 7, 10)
• Güneş veya Ay ile aspektli
• Diğer dış gezegenlerle aspektli

4. MARS-PLUTO ASPEKTİ
• Özellikle kavuşum, kare, karşıt

5. 12. EV VURGUSU
• Spiritüel, mistik boyut
• Ego çözülmesi kapasitesi

6. KETU (Güney Düğüm)
• Güçlü Ketu, spiritüel geçmişi gösterir
• Akrep veya 8. evde Ketu: Kundalini karması

7. YOD (Tanrının Parmağı)
• Bu nadir konfigürasyon, özel bir misyon
  ve potansiyel dönüşümü gösterir

8. ÇİFT BEDEN BURÇLARI (Mutable)
• Yay, İkizler, Balık, Başak vurgusu
• Esnek bilinç, geçişlere açıklık

ZAMANLAMA:
Doğum haritasına bakarak Kundalini "ne zaman" uyanır
kesin söylenemez. Ama yukarıdaki göstergeler +
tetikleyici transitler = potansiyel uyanış dönemleri.
''';
}

// ═══════════════════════════════════════════════════════════════════════════
// TANTRİK KUNDALİNİ - PARTNER PRATİKLERİ
// ═══════════════════════════════════════════════════════════════════════════

class TantricKundalini {
  static const String overview = '''
TANTRİK KUNDALİNİ

Tantra, Kundalini'nin en doğrudan yoludur. Cinsel enerjiyi
(yaratıcı gücün en yoğun formu) bilinçli olarak kullanarak
Kundalini uyanışını hızlandırır.

UYARI: Tantrik pratikler ileri seviyedir ve yanlış
anlaşılmaya çok açıktır. Gerçek Tantra, cinsel istismar
veya "serbest seks" değildir. Disiplin, saygı ve kutsal
niyet gerektirir.
''';

  static const String partnerPractices = '''
PARTNER PRATİKLERİ

Tantrik çift çalışmaları, iki bireyin enerjilerini
birleştirerek Kundalini'yi uyandırır.

TEMEL PRENSİPLER:

1. KUTSAL NİYET
Pratik, haz için değil, spiritüel amaçla yapılır.
Niyet açık olmalı: "Bu çalışma, her ikimizin
spiritüel büyümesi içindir."

2. EŞİT SAYGI
Her iki partner eşit derecede değerli ve kutsal.
Sömürü, baskı, manipülasyon YOK.

3. HAZIRLIK
Her iki partner de bireysel pratiklerde ilerlemiş olmalı.
Temel chakra, nadi, pranayama bilgisi şart.

4. RITÜEL YAKLAŞIM
Pratik, rastgele değil, ritüel formatında yapılır.
Hazırlık, açılış, pratik, kapanış, entegrasyon.

TEMEL PARTNER PRATİKLERİ:

1. YAB-YUM OTURUŞU
• Erkek lotus pozisyonunda oturur
• Kadın erkeğin kucağına oturur (bacaklar arkada)
• Göbek göbeğe, kalp kalbe, alın alna
• Nefesler senkronize edilir
• Enerji döngüsü oluşturulur

2. GÖZ TEMASI MEDİTASYONU
• Karşı karşıya otur
• 10-30 dakika sessiz göz teması
• Gözler "ruhun penceresi" - derin bağlantı

3. NEFES PAYLAŞIMI
• Biri nefes verirken diğeri alır
• Enerji alışverişi
• "Ben sana veriyorum, sen bana veriyorsun"

4. CHAKRA UYUMU
• Aynı anda aynı chakraya odaklanma
• Her chakra için 5-10 dakika
• Aşağıdan yukarı veya yukarıdan aşağı
''';

  static const String sexualEnergyTransmutation = '''
CİNSEL ENERJİ DÖNÜŞÜMÜ

Tantra'da cinsel enerji (tejas/ojas) en güçlü yaratıcı
güç olarak kabul edilir. Bu enerji, bilinçli olarak
dönüştürülüp yukarı yönlendirilebilir.

DÖNÜŞÜM PRENSİPLERİ:

1. ENERJİYİ TUTMA
Cinsel uyarılma sırasında enerjiyi boşaltmak yerine tutma.
Erkeklerde: Ejakülasyonu geciktirme veya durdurma
Kadınlarda: Orgazm enerjisini içeri çekme

2. YUKARI YÖNLENDİRME
Tutulan enerjiyi omurga boyunca yukarı yönlendirme.
• Nefes ile
• Bandha ile
• Görselleştirme ile

3. DÖNÜŞTÜRME
Cinsel enerji (tejas) → Ojas (vitality) → Üst chakra enerjisi.
Bu dönüşüm, Kundalini'yi besler ve uyandırır.

PRATİK TEKNİKLER:

1. ENERJİ KİLİTLEME
Uyarılma zirvesine yaklaşırken:
• Mula Bandha uygula
• Nefesi tut
• Dikkatini omurgaya ver
• Enerjiyi yukarı çek

2. SOĞUK ÇEKİM
Orgazm hissine yaklaşırken:
• Derin nefes al
• Enerjiyi başın tepesine çek
• "Soğutma" hissi

3. ÇİFT DÖNÜŞÜM
Partner ile birlikte:
• Birinin enerjisi diğerine geçer
• Döngü oluşur
• Her iki partner de yükselir

UYARI: Bu pratikler çok güçlüdür ve yanlış uygulandığında
zararlı olabilir. Deneyimli Tantra öğretmeni ile çalışın.
''';

  static const String shivaShaktiUnion = '''
SHİVA-SHAKTİ BİRLEŞMESİ

Tantrik Kundalini'nin nihai amacı, Shakti'nin (dişil,
enerji, yaratıcı güç) Shiva (eril, bilinç, durağan
farkındalık) ile taç chakrada birleşmesidir.

SEMBOLIZM:

SHİVA:
• Saf bilinç, değişmeyen tanık
• Formlar ötesinde, niteliklerin ötesinde
• "Ben" in kaynağı
• Sahasrara'da (taç) bekler
• Durağan, pasif (ama ölü değil)

SHAKTİ:
• Yaratıcı enerji, dinamik güç
• Formların, manifestasyonun kaynağı
• "Her şey"in özü
• Muladhara'da uyur, Shiva'yı arar
• Hareketli, aktif

BİRLEŞME:
Kundalini (Shakti) yükselip Sahasrara'ya ulaştığında,
Shiva ile birleşir. Bu an:
• İkilik sona erer
• Erkek/dişil bir olur
• Bilinç/enerji bir olur
• Yaratıcı/yaratılan bir olur
• Samadhi deneyimi

TANTRİK ÇİFT YANSIMASI:
Partner pratiğinde:
• Erkek partner Shiva'yı temsil eder
• Kadın partner Shakti'yi temsil eder
• Birleşmeleri, kozmik birleşmenin yansımasıdır
• "Yukarıda ne varsa, aşağıda da o var"

UYARI: Bu sembolizm, cinsiyetler arası hiyerarşi
DEĞİLDİR. Her bireyde hem Shiva hem Shakti var.
Partner pratikleri, dış birleşme aracılığıyla
iç birleşmeyi tetikler.
''';

  static const String sacredSexualityConnection = '''
KUTSAL CİNSELLİK BAĞLANTISI

Tantra, cinselliği reddetmez - onu dönüştürür ve kutsallaştırır.
Cinsel enerji, Kundalini uyanışının en güçlü yakıtıdır.

KUTSAL CİNSELLİK NEDİR?

1. NİYET
Haz ötesinde spiritüel amaç. "Bu birleşme,
ilahi birliğin yansımasıdır."

2. MEVCUDIYET
Tamamen şimdi ve burada olma. Fanteziler, geçmiş,
gelecek değil - sadece an.

3. BAĞLANTI
Sadece fiziksel değil - enerjetik, duygusal, spiritüel
seviyede derin bağlantı.

4. SAYGI
Partner ilahi varlığın tezahürü olarak görülür.
Sömürü, bencillik YOK.

5. ENERJİ FARKINDALIĞI
Cinsel enerjiyi hissetme, yönlendirme, dönüştürme.

PRATİK ÖNERILER:

1. YAVASLA
Modern seks genellikle acelecidir. Tantrik yaklaşım
çok yavaş, saatlerce sürebilir.

2. NEFES ENTEGRASYONU
Cinsel aktivite sırasında nefes farkındalığı.
Partner ile nefes senkronizasyonu.

3. GÖZ TEMASI
Birleşme sırasında göz teması. Ruhları görmek.

4. SES KULLANIMI
Doğal sesler, mantrik sesler. Vibrasyonun gücü.

5. ORGAZM ÖTESİ
Fiziksel orgazm amaç değil. Enerjetik orgazm,
tüm beden orgazmı, spiritüel orgazm.

6. ENTEGRASYON
Sonrası en az pratik kadar önemli. Sarılma, paylaşma,
meditasyon. Enerjinin yerleşmesine izin ver.
''';
}

// ═══════════════════════════════════════════════════════════════════════════
// SERVİS SINIFI
// ═══════════════════════════════════════════════════════════════════════════

class KundaliniContent {
  // Chakra içerikleri
  static Map<Chakra, ChakraContent> getChakraContents() => chakraContents;

  static ChakraContent? getChakraContent(Chakra chakra) =>
      chakraContents[chakra];

  static ChakraContent? getChakraByNumber(int number) {
    try {
      final chakra = Chakra.values.firstWhere((c) => c.number == number);
      return chakraContents[chakra];
    } catch (_) {
      return null;
    }
  }

  // Nadi içerikleri
  static Map<Nadi, NadiContent> getNadiContents() => nadiContents;

  static NadiContent? getNadiContent(Nadi nadi) => nadiContents[nadi];

  // Pratikler
  static List<KundaliniPractice> getAllPranayamas() => pranayamaPractices;

  static List<KundaliniPractice> getAllBandhas() => bandhaPractices;

  static List<KundaliniPractice> getAllMudras() => mudraPractices;

  static List<KundaliniPractice> getAllPractices() => [
    ...pranayamaPractices,
    ...bandhaPractices,
    ...mudraPractices,
  ];

  static List<KundaliniPractice> getPracticesByDifficulty(String difficulty) =>
      getAllPractices()
          .where((p) => p.difficulty.toLowerCase() == difficulty.toLowerCase())
          .toList();

  static List<KundaliniPractice> getPracticesByCategory(String category) =>
      getAllPractices()
          .where((p) => p.category.toLowerCase() == category.toLowerCase())
          .toList();

  // Belirtiler
  static List<KundaliniSymptom> getAllSymptoms() => kundaliniSymptoms;

  static List<KundaliniSymptom> getSymptomsByCategory(String category) =>
      kundaliniSymptoms
          .where((s) => s.category.toLowerCase() == category.toLowerCase())
          .toList();

  static List<KundaliniSymptom> getCommonSymptoms() =>
      kundaliniSymptoms.where((s) => s.isCommon).toList();

  // Granthiler
  static List<GranthiContent> getAllGranthis() => granthiContents;

  static GranthiContent? getGranthiByName(String name) {
    try {
      return granthiContents.firstWhere(
        (g) => g.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  // Uyaniş aşamaları
  static String getAwakeningStageContent(KundaliniStage stage) {
    switch (stage) {
      case KundaliniStage.dormant:
        return KundaliniAwakeningStages.dormantStage;
      case KundaliniStage.stirring:
        return KundaliniAwakeningStages.stirringStage;
      case KundaliniStage.awakening:
        return KundaliniAwakeningStages.awakeningStage;
      case KundaliniStage.rising:
        return KundaliniAwakeningStages.risingStage;
      case KundaliniStage.piercing:
        return KundaliniAwakeningStages.piercingStage;
      case KundaliniStage.flowering:
        return KundaliniAwakeningStages.floweringStage;
      case KundaliniStage.union:
        return KundaliniAwakeningStages.unionStage;
    }
  }

  // Fundamentals
  static String get fundamentalsIntro => KundaliniFundamentals.introduction;
  static String get serpentPower =>
      KundaliniFundamentals.serpentPowerExplanation;
  static String get shaktiExplanation =>
      KundaliniFundamentals.shaktiExplanation;
  static String get historicalOrigins =>
      KundaliniFundamentals.historicalOrigins;
  static String get pranaRelationship =>
      KundaliniFundamentals.pranaRelationship;
  static String get subtleBodyAnatomy =>
      KundaliniFundamentals.subtleBodyAnatomy;

  // Nadi System
  static String get nadiSystemOverview => NadiSystem.overview;
  static String get nadiBlockagesAndClearing => NadiSystem.blockagesAndClearing;

  // Güvenlik
  static String get safetyPreparation =>
      KundaliniSafety.importanceOfPreparation;
  static String get prematureAwakening =>
      KundaliniSafety.signsOfPrematureAwakening;
  static String get groundingTechniques => KundaliniSafety.groundingTechniques;
  static String get whenToSlowDown => KundaliniSafety.whenToSlowDown;
  static String get teacherGuidance =>
      KundaliniSafety.teacherGuidanceImportance;

  // Astroloji
  static String get astrologyOverview => KundaliniAstrology.overview;
  static String get marsPlutoConnection =>
      KundaliniAstrology.marsPlutoConnection;
  static String get eighthHouseIndicators =>
      KundaliniAstrology.eighthHouseIndicators;
  static String get scorpioEnergy => KundaliniAstrology.scorpioEnergy;
  static String get triggeringTransits => KundaliniAstrology.triggeringTransits;
  static String get natalChartIndicators =>
      KundaliniAstrology.natalChartIndicators;

  // Tantrik
  static String get tantricOverview => TantricKundalini.overview;
  static String get partnerPractices => TantricKundalini.partnerPractices;
  static String get sexualTransmutation =>
      TantricKundalini.sexualEnergyTransmutation;
  static String get shivaShaktiUnion => TantricKundalini.shivaShaktiUnion;
  static String get sacredSexuality =>
      TantricKundalini.sacredSexualityConnection;

  // Günlük pratik önerisi
  static KundaliniPractice getDailyPractice() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final allPractices = getAllPractices();
    return allPractices[dayOfYear % allPractices.length];
  }

  // Seviyeye göre pratik yolu
  static List<KundaliniPractice> getBeginnerPath() {
    return [
      ...pranayamaPractices.where((p) => p.difficulty == 'Başlangıç'),
      ...bandhaPractices.where((p) => p.difficulty.contains('Başlangıç')),
      ...mudraPractices.where((p) => p.difficulty == 'Başlangıç'),
    ];
  }

  static List<KundaliniPractice> getIntermediatePath() {
    return [
      ...pranayamaPractices.where((p) => p.difficulty == 'Orta'),
      ...bandhaPractices.where((p) => p.difficulty.contains('Orta')),
      ...mudraPractices.where((p) => p.difficulty == 'Orta'),
    ];
  }

  static List<KundaliniPractice> getAdvancedPath() {
    return [
      ...pranayamaPractices.where((p) => p.difficulty == 'İleri'),
      ...bandhaPractices.where((p) => p.difficulty.contains('İleri')),
      ...mudraPractices.where((p) => p.difficulty == 'İleri'),
    ];
  }
}
