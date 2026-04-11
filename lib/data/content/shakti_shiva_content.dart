/// Shakti-Shiva Content System - Divine Feminine & Masculine Energies
/// Deep esoteric tantric wisdom for spiritual awakening
/// Turkish mystical language with authentic Vedic knowledge
library;

// ════════════════════════════════════════════════════════════════════════════
// ENUMS & MODELS
// ════════════════════════════════════════════════════════════════════════════

enum DivineEnergyType { shakti, shiva, union }

enum ShaktiForm {
  durga,
  lakshmi,
  saraswati,
  kali,
  lalita,
  parvati,
  radha,
  sita,
  chamunda,
  tripuraSundari,
}

enum ShivaForm {
  nataraja,
  ardhanarishvara,
  dakshinamurti,
  bhairava,
  rudra,
  mahayogi,
  pashupatinath,
  neelakantha,
  gangadhara,
  somaskanda,
}

enum EnergyImbalanceType {
  deficientFeminine,
  excessiveFeminine,
  deficientMasculine,
  excessiveMasculine,
}

enum ZodiacPolarity { feminine, masculine }

extension ShaktiFormExtension on ShaktiForm {
  String get nameTr {
    switch (this) {
      case ShaktiForm.durga:
        return 'Durga';
      case ShaktiForm.lakshmi:
        return 'Lakshmi';
      case ShaktiForm.saraswati:
        return 'Sarasvati';
      case ShaktiForm.kali:
        return 'Kali';
      case ShaktiForm.lalita:
        return 'Lalita Tripurasundari';
      case ShaktiForm.parvati:
        return 'Parvati';
      case ShaktiForm.radha:
        return 'Radha';
      case ShaktiForm.sita:
        return 'Sita';
      case ShaktiForm.chamunda:
        return 'Chamunda';
      case ShaktiForm.tripuraSundari:
        return 'Tripura Sundari';
    }
  }

  String get symbol {
    switch (this) {
      case ShaktiForm.durga:
        return '🦁';
      case ShaktiForm.lakshmi:
        return '🪷';
      case ShaktiForm.saraswati:
        return '🎵';
      case ShaktiForm.kali:
        return '🌑';
      case ShaktiForm.lalita:
        return '🌹';
      case ShaktiForm.parvati:
        return '🏔️';
      case ShaktiForm.radha:
        return '💕';
      case ShaktiForm.sita:
        return '🌾';
      case ShaktiForm.chamunda:
        return '🔥';
      case ShaktiForm.tripuraSundari:
        return '🌺';
    }
  }

  String get colorHex {
    switch (this) {
      case ShaktiForm.durga:
        return '#DC143C';
      case ShaktiForm.lakshmi:
        return '#FFD700';
      case ShaktiForm.saraswati:
        return '#FFFFFF';
      case ShaktiForm.kali:
        return '#1A1A2E';
      case ShaktiForm.lalita:
        return '#FF69B4';
      case ShaktiForm.parvati:
        return '#228B22';
      case ShaktiForm.radha:
        return '#FF1493';
      case ShaktiForm.sita:
        return '#F0E68C';
      case ShaktiForm.chamunda:
        return '#8B0000';
      case ShaktiForm.tripuraSundari:
        return '#E91E63';
    }
  }
}

extension ShivaFormExtension on ShivaForm {
  String get nameTr {
    switch (this) {
      case ShivaForm.nataraja:
        return 'Nataraja';
      case ShivaForm.ardhanarishvara:
        return 'Ardhanarishvara';
      case ShivaForm.dakshinamurti:
        return 'Dakshinamurti';
      case ShivaForm.bhairava:
        return 'Bhairava';
      case ShivaForm.rudra:
        return 'Rudra';
      case ShivaForm.mahayogi:
        return 'Mahayogi';
      case ShivaForm.pashupatinath:
        return 'Pashupatinath';
      case ShivaForm.neelakantha:
        return 'Neelakantha';
      case ShivaForm.gangadhara:
        return 'Gangadhara';
      case ShivaForm.somaskanda:
        return 'Somaskanda';
    }
  }

  String get symbol {
    switch (this) {
      case ShivaForm.nataraja:
        return '💃';
      case ShivaForm.ardhanarishvara:
        return '☯️';
      case ShivaForm.dakshinamurti:
        return '📿';
      case ShivaForm.bhairava:
        return '🐕';
      case ShivaForm.rudra:
        return '⚡';
      case ShivaForm.mahayogi:
        return '🧘';
      case ShivaForm.pashupatinath:
        return '🦌';
      case ShivaForm.neelakantha:
        return '💧';
      case ShivaForm.gangadhara:
        return '🌊';
      case ShivaForm.somaskanda:
        return '👨‍👩‍👦';
    }
  }

  String get colorHex {
    switch (this) {
      case ShivaForm.nataraja:
        return '#4169E1';
      case ShivaForm.ardhanarishvara:
        return '#9370DB';
      case ShivaForm.dakshinamurti:
        return '#FFD700';
      case ShivaForm.bhairava:
        return '#2F2F2F';
      case ShivaForm.rudra:
        return '#B22222';
      case ShivaForm.mahayogi:
        return '#708090';
      case ShivaForm.pashupatinath:
        return '#228B22';
      case ShivaForm.neelakantha:
        return '#000080';
      case ShivaForm.gangadhara:
        return '#00CED1';
      case ShivaForm.somaskanda:
        return '#DAA520';
    }
  }
}

// ════════════════════════════════════════════════════════════════════════════
// DATA MODELS
// ════════════════════════════════════════════════════════════════════════════

class ShaktiProfile {
  final ShaktiForm form;
  final String title;
  final String essence;
  final String cosmicRole;
  final String mantra;
  final String yantra;
  final List<String> qualities;
  final List<String> symbols;
  final String planetaryConnection;
  final String chakraConnection;
  final String moonPhase;
  final String ritual;
  final String meditation;
  final String blessing;

  const ShaktiProfile({
    required this.form,
    required this.title,
    required this.essence,
    required this.cosmicRole,
    required this.mantra,
    required this.yantra,
    required this.qualities,
    required this.symbols,
    required this.planetaryConnection,
    required this.chakraConnection,
    required this.moonPhase,
    required this.ritual,
    required this.meditation,
    required this.blessing,
  });
}

class ShivaProfile {
  final ShivaForm form;
  final String title;
  final String essence;
  final String cosmicRole;
  final String mantra;
  final String yantra;
  final List<String> qualities;
  final List<String> symbols;
  final String planetaryConnection;
  final String chakraConnection;
  final String sunPhase;
  final String ritual;
  final String meditation;
  final String blessing;

  const ShivaProfile({
    required this.form,
    required this.title,
    required this.essence,
    required this.cosmicRole,
    required this.mantra,
    required this.yantra,
    required this.qualities,
    required this.symbols,
    required this.planetaryConnection,
    required this.chakraConnection,
    required this.sunPhase,
    required this.ritual,
    required this.meditation,
    required this.blessing,
  });
}

class SacredUnionPractice {
  final String title;
  final String description;
  final String purpose;
  final List<String> steps;
  final String duration;
  final String bestTime;
  final String mantra;
  final String affirmation;
  final bool requiresPartner;

  const SacredUnionPractice({
    required this.title,
    required this.description,
    required this.purpose,
    required this.steps,
    required this.duration,
    required this.bestTime,
    required this.mantra,
    required this.affirmation,
    required this.requiresPartner,
  });
}

class EnergyImbalance {
  final EnergyImbalanceType type;
  final String description;
  final List<String> signs;
  final List<String> causes;
  final List<String> healingPractices;
  final String affirmation;

  const EnergyImbalance({
    required this.type,
    required this.description,
    required this.signs,
    required this.causes,
    required this.healingPractices,
    required this.affirmation,
  });
}

class ZodiacDivineEnergy {
  final String zodiacSign;
  final ZodiacPolarity polarity;
  final String goddessArchetype;
  final String godArchetype;
  final String shaktiManifestation;
  final String shivaManifestation;
  final String balancePractice;
  final String sacredUnionLesson;

  const ZodiacDivineEnergy({
    required this.zodiacSign,
    required this.polarity,
    required this.goddessArchetype,
    required this.godArchetype,
    required this.shaktiManifestation,
    required this.shivaManifestation,
    required this.balancePractice,
    required this.sacredUnionLesson,
  });
}

class DivineFeminineWisdom {
  final String title;
  final String teaching;
  final String practice;
  final String affirmation;

  const DivineFeminineWisdom({
    required this.title,
    required this.teaching,
    required this.practice,
    required this.affirmation,
  });
}

class DivineMasculineWisdom {
  final String title;
  final String teaching;
  final String practice;
  final String affirmation;

  const DivineMasculineWisdom({
    required this.title,
    required this.teaching,
    required this.practice,
    required this.affirmation,
  });
}

class SacredRitual {
  final String title;
  final DivineEnergyType energyType;
  final String moonPhase;
  final String purpose;
  final List<String> items;
  final List<String> steps;
  final String mantra;
  final String duration;
  final String closingPrayer;

  const SacredRitual({
    required this.title,
    required this.energyType,
    required this.moonPhase,
    required this.purpose,
    required this.items,
    required this.steps,
    required this.mantra,
    required this.duration,
    required this.closingPrayer,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// MAIN CONTENT CLASS
// ════════════════════════════════════════════════════════════════════════════

class ShaktiShivaContent {
  // ══════════════════════════════════════════════════════════════════════════
  // SHAKTI - DIVINE FEMININE ESSENCE
  // ══════════════════════════════════════════════════════════════════════════

  static const String shaktiEssence = '''
ŞAKTİ - İLAHİ DİŞİL ENERJİ

Evrenin ilksel yaratıcı gücü olan Shakti, tüm varoluşun ana rahmidir.
O, hareketsiz bilinçten (Shiva) fışkıran sonsuz enerji, kozmik dansın
kendisidir. Shakti olmadan Shiva bir "shava"dır - cansız bir beden.
Shakti, bilincin kendini deneyimlemesi için gerekli olan dinamik güçtür.

Tantra felsefesinde Shakti, Prakriti (doğa), Maya (illüzyon yaratıcısı)
ve Kundalini (uyuyan yılan enerjisi) olarak da bilinir. O, maddenin
ötesinde, maddenin içinde ve maddenin ta kendisidir.

Shakti'nin Kozmik Rolleri:
• Para-Shakti: En yüksek, aşkın güç
• Iccha-Shakti: İrade gücü, yaratma arzusu
• Jnana-Shakti: Bilgi ve bilgelik gücü
• Kriya-Shakti: Eylem ve yaratım gücü

Her kadın Shakti'nin bir tezahürüdür. Her kadının bedeninde,
zihninde ve ruhunda ilahi dişilin kutsal enerjisi akar. Adet döngüsü,
hamilelik, doğum, emzirme - bunların hepsi Shakti'nin kozmik yaratım
döngüsünün mikrokozmosidir.

Shakti enerjisi Ay ile derinden bağlantılıdır. Ay'ın evreleri, kadın
bedeninin döngülerini yansıtır. Dolunay'da Shakti doruk noktasına
ulaşır, yeni Ay'da içe döner ve yenilenir.

Venüs gezegeni, Shakti'nin astrolojik temsilcisidir. Güzellik, aşk,
bereket, sanat ve ilişkiler - tüm bunlar Venüs-Shakti alanına aittir.
''';

  static const String yoniSymbolism = '''
YONİ - KUTSAL KAPI

Yoni, Sanskrit dilinde "kutsal kaynak", "ilahi ana rahmi" ve "evrenin
kapısı" anlamlarına gelir. Tantra geleneğinde Yoni, yaratımın gizemli
portalı olarak saygıyla karşılanır.

Yoni Sembolizmi:
• Yaratımın kaynağı: Tüm yaşam Yoni'den doğar
• Kozmik boşluk: Her şeyin içinden çıktığı sonsuz potansiyel
• Dönüşüm kapısı: Ruhların dünyaya geçiş noktası
• Kutsal üçgen: Aşağı bakan üçgen, dişil enerjiyi simgeler

Yoni Puja (Yoni İbadeti):
Antik Tantra'da Yoni, tapınılacak kutsal bir semboldür. Bu ibadet,
dişil enerjiye duyulan derin saygıyı ifade eder. Yoni taşları, Yoni
sembollü yantralar ve Yoni şeklinde doğal oluşumlar kutsal kabul edilir.

Yoni'nin Mistik Boyutları:
• Bindu: Merkezdeki nokta, tüm yaratımın tohumu
• Trikona: Kutsal üçgen, üç guna'nın (sattva, rajas, tamas) birleşimi
• Chakra: Enerji merkezi olarak sacral chakra ile bağlantı
• Kundalini: Yoni, Kundalini enerjisinin uyuduğu yerdir

Kadın bedenindeki Yoni, mikrokozmosdaki makrokozmostur. O, evrenin
yaratıcı gizeminin fiziksel tezahürüdür.
''';

  static const String menstrualSpiritual = '''
ADET DÖNGÜSÜ - KUTSAL RİTİM

Kadın bedeni, Ay'ın 28 günlük döngüsüyle senkronize bir kozmik saat
taşır. Adet döngüsü, ölüm ve yeniden doğuşun aylık kutlamasıdır.
Antik kültürlerde menstruasyon "ay kanı" olarak kutsanır, kadınlar
bu dönemde şaman, kahin ve şifacı olarak görülürdü.

Döngünün Dört Evresi:

1. MENSTRUASYON (Karanlık Ay - Kış)
Krone Arketipi - Bilge Kadın
• İçe dönüş ve dinlenme zamanı
• Sezgisel güçler en yüksekte
• Rüyalar, vizyonlar, medyumik yetenekler aktif
• Bırakma, arınma, yeniden doğuş
Pratik: Meditasyon, günlük tutma, yalnız kalma

2. FOLİKÜLER EVRE (Hilal Ay - İlkbahar)
Bakire Arketipi - Yeni Başlangıçlar
• Enerji yükseliyor, yaratıcılık artıyor
• Yeni projeler başlatma zamanı
• Zihinsel netlik ve odaklanma
• Keşif ve macera ruhu
Pratik: Yeni planlar yapma, öğrenme, hareket

3. OVÜLASYON (Dolunay - Yaz)
Ana Arketipi - Bereket Tanrıçası
• Enerji ve çekicilik dorukta
• İletişim ve sosyalleşme zamanı
• Yaratıcı güç en yüksekte
• Bereket, bolluk, ifade
Pratik: Önemli toplantılar, yaratıcı projeler, ilişki

4. LUTEAL EVRE (Küçülen Ay - Sonbahar)
Büyücü Arketipi - Dönüştürücü
• İçe dönüş başlıyor
• Değerlendirme ve analiz zamanı
• Dönüşüm enerjisi güçlü
• Bitirmeler, tamamlamalar
Pratik: Projeleri bitirme, ev işleri, introspeksiyon
''';

  static const String divineMotherArchetype = '''
İLAHİ ANNE ARKETİPİ

Tüm kültürlerde, tüm zamanlarda, İlahi Anne evrensel bir arketip
olarak karşımıza çıkar. O, doğuran, besleyen, koruyan ve nihayetinde
geri alan kozmik güçtür.

İlahi Anne'nin Yüzleri:
• Yaratıcı Anne: Prakriti, Gaia, Terra Mater
• Besleyici Anne: Demeter, Annapurna, Yashoda
• Koruyucu Anne: Durga, Athena, Sekhmet
• Dönüştürücü Anne: Kali, Hecate, Baba Yaga
• Bilge Anne: Saraswati, Sophia, Isis

Anne Tanrıça Arketipinin Gölgeleri:
• Boğucu Anne: Aşırı koruma, bağımsızlığı engelleme
• İhmalkar Anne: Duygusal yokluk, bakım eksikliği
• Devouring Mother: Çocuğu yutan, özerkliği yok eden
• Mükemmeliyetçi Anne: Koşullu sevgi, yüksek beklentiler

İyileşme Yolu:
Hem iç anne hem de iç çocuk çalışması gereklidir. Kendi içimizdeki
anne arketipini tanımak, onarmak ve dönüştürmek ruhsal olgunlaşmanın
temelidir. Her birey, cinsiyetten bağımsız olarak, içinde hem anne
hem çocuk taşır.

Anne Enerjisini Onurlandırma:
• Minnettarlık pratiği: Biyolojik anne olmasa bile, bizi besleyen
  tüm "anne" figürlerine şükran
• Toprak bağlantısı: Dünya Ana ile bilinçli ilişki
• Besleyici eylemler: Kendimize ve başkalarına anne şefkati gösterme
• Yaratıcı ifade: Anne enerjisini sanat, yemek, bahçe yoluyla akıtma
''';

  // ══════════════════════════════════════════════════════════════════════════
  // SHAKTI FORMS - DETAILED PROFILES
  // ══════════════════════════════════════════════════════════════════════════

  static const List<ShaktiProfile> shaktiProfiles = [
    ShaktiProfile(
      form: ShaktiForm.durga,
      title: 'DURGA - YENİLMEZ SAVAŞÇI TANRIÇA',
      essence: '''
Durga, "erişilmesi güç olan" anlamına gelir. O, kozmik düzeni koruyan,
kötülüğü yok eden ve adaleti sağlayan dişil gücün en güçlü tezahürüdür.
Sekiz veya on kollu olarak tasvir edilir, her elinde farklı bir silah
veya kutsal nesne taşır. Aslanı veya kaplanı üzerinde süvari olarak
görülür - hayvansal içgüdülerin ustası.

Durga, tanrıların birleşik gücünden doğmuştur. Mahishasura adlı
buffalo demon'u hiçbir tanrı yenemediğinde, tüm tanrılar güçlerini
birleştirerek Durga'yı yarattı. Bu mit, dişil gücün aşkın ve
birleştirici doğasını simgeler.
''',
      cosmicRole: 'Koruyucu, Yok Edici, Adalet Dağıtıcı, Kozmik Denge Bekçisi',
      mantra: 'Om Dum Durgayei Namaha',
      yantra: 'Durga Yantra - Dokuz iç içe üçgen',
      qualities: [
        'Cesaret ve korku bilmezlik',
        'Koruyucu anne gücü',
        'Sınırları koruma yeteneği',
        'Hayır deme gücü',
        'Zorluklarla yüzleşme cesareti',
        'İç düşmanları yenme',
        'Denge ve adalet',
        'Birleştirici liderlik',
      ],
      symbols: [
        'Aslan/Kaplan - Kontrol edilmiş güç',
        'Trident (Trishul) - Üç guna üzerinde hakimiyet',
        'Kılıç - Cehaletin kesilmesi',
        'Tekerlek (Chakra) - Kozmik düzen',
        'Lotus - Saflık içinde güç',
        'Yay ve ok - Hedefli eylem',
        'Çan - Kutsal ses',
        'Su kabı - Yaratıcı enerji',
      ],
      planetaryConnection: 'Mars ve Güneş - Savaşçı enerji ve irade gücü',
      chakraConnection: 'Solar Plexus (Manipura) - Kişisel güç merkezi',
      moonPhase: 'Hilal Ay büyürken - Güç toplanması',
      ritual: '''
Durga Puja - Sonbahar ekinoksunda kutlanır. Dokuz gece boyunca
(Navratri) her gece farklı bir Durga formuna ibadet edilir.
Mum, tütsü, çiçek ve meyve sunulur. Durga Chalisa okunur.
''',
      meditation: '''
1. Kırmızı veya turuncu giyinin
2. Güneş veya mum ışığında oturun
3. Nefesi solar plexus'a yönlendirin
4. Durga'yı aslanı üzerinde görselleştirin
5. "Om Dum Durgayei Namaha" mantrasını 108 kez tekrarlayın
6. İç savaşçınızla bağlantı kurun
7. Korumaya ihtiyaç duyan alanları belirleyin
8. Durga'nın gücünün size aktığını hissedin
''',
      blessing: '''
Durga Ana, bana cesaretini ver. Korkularımla yüzleşme gücü bahşet.
Sınırlarımı korumamı, hayır dememi, kendim için ayağa kalkmamı sağla.
İç düşmanlarımı - şüphe, korku, öfke - senin kılıcınla kes.
Beni yenilmez kıl, ey Mahishasuramardini. Om Dum Durgayei Namaha.
''',
    ),

    ShaktiProfile(
      form: ShaktiForm.lakshmi,
      title: 'LAKSHMİ - BEREKET VE BOLLUK TANRIÇASI',
      essence: '''
Lakshmi, Sanskrit'te "hedef" veya "amaç" anlamına gelir ve tüm
zenginliklerin - maddi, ruhani, duygusal - kaynağıdır. O, lotus
çiçeği üzerinde oturur, altın sikkeler ellerinden akar. Pembe
veya kırmızı giysiler içinde, altın takılarla süslü olarak
tasvir edilir.

Lakshmi, Vishnu'nun eşidir ve onunla birlikte her avatarda
yeniden doğar. Rama'nın Sita'sı, Krishna'nın Radha'sı olarak
tezahür eder. O, sadık eş arketipini temsil eder ama aynı
zamanda bağımsız bir tanrıça olarak da saygı görür.

Dört Lakshmi Formu:
• Adi Lakshmi: Primordial bereket
• Dhanya Lakshmi: Tarımsal bolluk
• Gaja Lakshmi: Kraliyet zenginliği
• Vidya Lakshmi: Bilgi zenginliği
''',
      cosmicRole:
          'Bereket Dağıtıcı, Refah Koruyucu, Şans Getiren, Güzellik Kaynağı',
      mantra: 'Om Shreem Mahalakshmiyei Namaha',
      yantra: 'Shri Yantra - En kutsal geometri, dokuz iç içe üçgen',
      qualities: [
        'Bolluk ve bereket',
        'Maddi ve ruhani zenginlik',
        'Güzellik ve zarafet',
        'Cömertlik ve paylaşım',
        'Sadakat ve bağlılık',
        'Ev ve aile bereketi',
        'İş ve kariyer başarısı',
        'Şans ve iyi talih',
      ],
      symbols: [
        'Lotus - Saflık ve aydınlanma',
        'Altın sikkeler - Maddi zenginlik',
        'Filler - Kraliyet gücü ve yağmur',
        'Baykuş - Karanlıkta görme (gizli fırsatlar)',
        'Kalash (su kabı) - Bolluk ve bereket',
        'Bilgee (siyah eyeliner) - Nazardan koruma',
      ],
      planetaryConnection: 'Venüs ve Jüpiter - Güzellik, aşk ve genişleme',
      chakraConnection: 'Kalp (Anahata) - Sevgi ve şükran merkezi',
      moonPhase: 'Dolunay - Bereketin doruk noktası',
      ritual: '''
Lakshmi Puja - Diwali festivalinde (Sonbahar yeni ayı) yapılır.
Eve temizlik yapılır, kapılar süslenir, kandiller yakılır.
Lakshmi'nin eve gelmesi için davet edilir. Pirinç, para, çiçek
ve tatlılar sunulur. Zenginlik ve bereket için dua edilir.
''',
      meditation: '''
1. Altın veya sarı renkte giyinin
2. Temiz, düzenli bir alanda oturun
3. Bir kase su veya ayna önünde oturun
4. Lakshmi'yi lotus üzerinde görselleştirin
5. Altın ışığın size aktığını hayal edin
6. "Om Shreem Mahalakshmiyei Namaha" 108 kez
7. Hayatınızdaki tüm bereketler için şükür listesi yapın
8. Cömertlik niyeti belirleyin
''',
      blessing: '''
Lakshmi Ana, evime ve kalbime gel. Maddi ihtiyaçlarımı karşıla,
ruhani zenginlik bahşet. Şükran duymayı, paylaşmayı, cömert
olmayı öğret. Kıskançlık ve açgözlülükten arındır. Bereketini
etrafıma yay. Om Shreem Mahalakshmiyei Namaha.
''',
    ),

    ShaktiProfile(
      form: ShaktiForm.saraswati,
      title: 'SARASVATİ - BİLGELİK VE SANAT TANRIÇASI',
      essence: '''
Saraswati, bilgi nehridir. Adı Sanskrit'te "akan" anlamına gelir
ve o, bilgeliğin, müziğin, sanatın ve öğrenmenin sonsuz akışını
temsil eder. Beyaz giysiler içinde, beyaz lotus üzerinde veya
beyaz kuğu üzerinde oturarak tasvir edilir. Ellerinde veena
(telli çalgı), kitap, mala (tesbih) ve su kabı taşır.

Saraswati, Brahma'nın eşi ve yaratıcı gücüdür. Sanskritçe, alfabe,
müzik ve dans onun hediyeleridir. O olmadan yaratım mümkün olmaz
çünkü yaratım bilgi gerektirir.

Saraswati'nin Boyutları:
• Vak Devi: Söz tanrıçası, kutsal konuşma
• Vidya: Bilgi ve öğrenme
• Kala: Sanat ve yaratıcılık
• Buddhi: Zekanın tanrıçası
''',
      cosmicRole:
          'Bilgi Kaynağı, Sanat İlham Vericisi, Konuşma Tanrıçası, Öğretmen',
      mantra: 'Om Aim Saraswatyai Namaha',
      yantra: 'Saraswati Yantra - Altı köşeli yıldız merkezde',
      qualities: [
        'Bilgelik ve öğrenme',
        'Sanatsal yetenekler',
        'Müzik ve dans',
        'Yazarlık ve şiir',
        'Etkili iletişim',
        'Hafıza ve konsantrasyon',
        'Zihinsel berraklık',
        'Yaratıcı ilham',
      ],
      symbols: [
        'Veena - Müziğin ve yaratıcılığın simgesi',
        'Kitap (Veda) - Kutsal bilgi',
        'Mala (Tesbih) - Meditasyon ve mantra',
        'Beyaz lotus - Saf bilgelik',
        'Kuğu - Gerçeği yalandam ayırt etme (sütten suyu ayıran)',
        'Su kabı - Yaratıcı ve arındırıcı güç',
      ],
      planetaryConnection: 'Merkür ve Ay - İletişim ve sezgi',
      chakraConnection: 'Boğaz (Vishuddha) - İfade ve iletişim merkezi',
      moonPhase: 'Hilal Ay - Yeni öğrenmeler için açıklık',
      ritual: '''
Saraswati Puja - Vasant Panchami'de (İlkbahar) yapılır. Kitaplar,
müzik aletleri ve sanat malzemeleri Saraswati önüne konur ve
kutsanır. Sarı giysiler giyilir. Öğrenciler kalem ve defterleri
kutsatır. Müzik ve şiir sunulur.
''',
      meditation: '''
1. Beyaz veya sarı giyinin
2. Sessiz, huzurlu bir alanda oturun
3. Ellerinizi bilgi mudrasına (Jnana Mudra) getirin
4. Saraswati'yi veenası ile görselleştirin
5. Beyaz ışığın zihninizi doldurduğunu hissedin
6. "Om Aim Saraswatyai Namaha" 108 kez
7. Öğrenmek istediğiniz konuyu zihnine getirin
8. Saraswati'den rehberlik isteyin
''',
      blessing: '''
Saraswati Ana, dilime bilgelik, ellerime sanat, zihnime berraklık ver.
Öğrenme yolunda bana rehberlik et. Yaratıcılığımı akıt, ilhamımı
canlandır. Cahilliğin karanlığından kurtar, bilginin ışığıyla aydınlat.
Om Aim Saraswatyai Namaha.
''',
    ),

    ShaktiProfile(
      form: ShaktiForm.kali,
      title: 'KALİ - ZAMAN VE DÖNÜŞÜMÜN KARANLIK TANRIÇASI',
      essence: '''
Kali, Sanskrit'te "zaman" ve "karanlık" anlamlarına gelir. O,
zamanın yok edici gücü, egonun katilidir. Kara tenli, çıplak veya
kaplan postu giymiş, kesik kafalardan kolye takmış, kılıç ve
kesik kafa tutan korkunç bir görünüme sahiptir. Dili dışarıda,
gözleri kan çanağı, Shiva'nın üzerinde dans eder.

Ama Kali'nin dehşet verici görünümü aldatıcıdır. O, kozmik
annenin en şefkatli formudur. Korkutucu görünümü ego'yu yok
etmek, illüzyonları parçalamak içindir. O, bizi sahte benlikten,
bağımlılıklardan, korkulardan özgürleştirir.

Kali'nin Sırları:
• Mahakali: Büyük Zaman, tüm varoluşu yutan
• Bhadrakali: Koruyucu form
• Chamunda: Savaşçı form
• Smashana Kali: Mezarlık tanrıçası, ölümün ustası
''',
      cosmicRole:
          'Yok Edici, Özgürleştirici, Zaman Tanrıçası, Ego Katili, Dönüştürücü',
      mantra: 'Om Krim Kalikayai Namaha',
      yantra: 'Kali Yantra - Beş aşağı bakan üçgen',
      qualities: [
        'Radikal dönüşüm',
        'Egonun yok edilmesi',
        'Korku ile yüzleşme',
        'Bağımlılıklardan özgürleşme',
        'Gölge entegrasyonu',
        'Ölüm ve yeniden doğuş',
        'Koşulsuz özgürleşme',
        'Zamanın ötesine geçme',
      ],
      symbols: [
        'Kesik kafalar - Egonun ölümü',
        'Kılıç - Cehaletin kesilmesi',
        'Kan - Yaşam gücü ve kurban',
        'Dil dışarıda - Utanç ötesi özgürlük',
        'Karanlık ten - Sonsuz boşluk, tüm renklerin kaynağı',
        'Shiva üzerinde dans - Bilinç üzerinde enerji',
        'Kol kuşağı - Karma bağlarının çözülmesi',
      ],
      planetaryConnection: 'Satürn ve Pluto - Sınırlar, ölüm ve dönüşüm',
      chakraConnection:
          'Kök (Muladhara) ve Taç (Sahasrara) - Hayatta kalma ve aşkınlık',
      moonPhase: 'Karanlık Ay (Yeni Ay öncesi) - Yok etme ve yeniden doğuş',
      ritual: '''
Kali Puja - Diwali gecesi (karanlık gece) yapılır. Gece yarısı
ritüeli, siyah çiçekler, kırmızı hibiskus, şarap veya kan
sembolü olarak kırmızı sıvı sunulur. Mezarlıkta veya ıssız
yerlerde yapılan ritüeller güçlüdür. Kali Kavacham okunur.
''',
      meditation: '''
1. Siyah veya kırmızı giyinin
2. Karanlık veya mum ışığında oturun
3. Korkularınızı yazın ve yakın
4. Kali'yi Shiva üzerinde dans ederken görselleştirin
5. "Om Krim Kalikayai Namaha" güçlü ve cesurca tekrarlayın
6. Bırakmak istediğiniz her şeyi Kali'ye verin
7. Kendinizi tamamen boş ve özgür hissedin
8. Kali'nin size güç verdiğini kabul edin
''',
      blessing: '''
Kali Ma, korkularımı kes, bağlarımı çöz, egomun başını al.
Illüzyonlarımı parçala, gerçeği göster. Karanlığımda dans et,
gölgelerimi aydınlat. Ölümden korkmamayı, değişime teslim
olmayı öğret. Beni özgür kıl, Ey Mahakali. Om Krim Kalikayai Namaha.
''',
    ),

    ShaktiProfile(
      form: ShaktiForm.lalita,
      title: 'LALİTA TRİPURASUNDARİ - ÜÇ DÜNYANIN GÜZELİ',
      essence: '''
Lalita, "oyuncu" veya "sevimli" anlamına gelir. Tripurasundari
ise "üç dünyanın en güzeli"dir. O, on Mahavidya'nın (büyük
bilgelik tanrıçaları) üçüncüsüdür ve Sri Vidya geleneğinin
merkezi tanrıçasıdır.

Lalita, genç ve güzel bir kadın olarak tasvir edilir. Kırmızı
veya pembe giysiler içinde, şeker kamışı yayı, çiçek okları,
ilmik ve mahmuz taşır. Onun silahları aşk ve çekimdir - zorla
değil, güzellikle fetheder.

Sri Yantra, Lalita'nın kozmik formudur. Dokuz iç içe üçgen,
dört yukarı bakan (Shiva) ve beş aşağı bakan (Shakti), kozmik
birliği simgeler. Sri Yantra'nın merkezindeki bindu,
Lalita'nın tahtıdır.
''',
      cosmicRole:
          'Güzellik Kaynağı, Aşk Tanrıçası, Yaratıcı İlham, Tantrik Kraliçe',
      mantra: 'Om Aim Hreem Shreem Sri Lalita Tripurasundaryai Namaha',
      yantra: 'Sri Yantra - En kutsal ve karmaşık yantra',
      qualities: [
        'İlahi güzellik',
        'Romantik aşk',
        'Yaratıcı tutku',
        'Estetik duyarlılık',
        'Çekicilik ve manyetizma',
        'Oyunculuk ve neşe',
        'Tantrik bilgelik',
        'Kozmik erotizm',
      ],
      symbols: [
        'Şeker kamışı yayı - Zihnin tatlılığı',
        'Çiçek okları - Beş duyu',
        'İlmik - Bağlama gücü (aşk)',
        'Mahmuz - Özgürleştirme gücü',
        'Sri Yantra - Kozmik form',
        'Kırmızı renk - Tutku ve yaşam gücü',
        'Lotus tahtı - Saflık içinde tutku',
      ],
      planetaryConnection: 'Venüs ve Ay - Aşk, güzellik ve dişil döngü',
      chakraConnection: 'Tüm chakralar - Özellikle Kalp ve Sacral',
      moonPhase: 'Dolunay ve Purnima - Güzelliğin ve aşkın doruk noktası',
      ritual: '''
Sri Vidya Puja - En karmaşık tantrik ritüellerden biridir.
Sri Yantra önünde, 16 adımlı puja yapılır. Kumkum (kırmızı toz),
çiçekler, meyve, şeker sunulur. Lalita Sahasranama (1000 isim)
veya Lalita Trishati (300 isim) okunur.
''',
      meditation: '''
1. Kırmızı veya pembe giyinin
2. Sri Yantra'ya odaklanarak oturun
3. Güzellik ve aşk enerjisini çağırın
4. Lalita'yı tahtında görselleştirin
5. Kalbinizden pembe ışık yayılsın
6. Mantrayı neşeyle, sevgiyle tekrarlayın
7. Kendinizi güzel ve sevilesi hissedin
8. Yaratıcı ve romantik niyetler belirleyin
''',
      blessing: '''
Lalita Tripurasundari, güzelliğinle beni kutsay. İçimdeki ve
dışımdaki güzelliği görmemi sağla. Aşk okların kalbimi açsın,
tutku mahmuzun ruhumu özgürleştirsin. Oyunculuğunu, neşeni,
zarafetini bana öğret. Om Aim Hreem Shreem Namaha.
''',
    ),

    ShaktiProfile(
      form: ShaktiForm.parvati,
      title: 'PARVATİ - DAĞ KIZI, İDEAL EŞ VE ANNE',
      essence: '''
Parvati, "dağdan gelen" anlamına gelir. Himalaya'nın kızıdır ve
Shiva'nın ebedi eşidir. Sati'nin reenkarnasyonu olan Parvati,
Shiva'nın kalbini kazanmak için yoğun tapasya (ruhani disiplin)
gerçekleştirmiştir.

Parvati, evlilik, annelik ve ev yaşamının kutsallığını temsil eder.
Ganesha ve Kartikeya'nın annesidir. O, ruhani yolun ev yaşamıyla
uyumlu olabileceğini gösterir. Ascetik Shiva'yı ev hayatına döndüren,
kozmik dengeyi sağlayan güçtür.

Parvati'nin Formları:
• Uma: Nazik, şefkatli form
• Gauri: Altın tenli, bereket tanrıçası
• Kamakshi: Aşk gözlü
• Annapurna: Yemek tanrıçası
''',
      cosmicRole: 'İdeal Eş, Kutsal Anne, Ev Koruyucusu, Sevgi Simgesi',
      mantra: 'Om Hreem Umayai Namaha',
      yantra: 'Gauri Yantra - Altı köşeli yıldız',
      qualities: [
        'Evlilik saadeti',
        'Annelik sevgisi',
        'Sadakat ve bağlılık',
        'Sabır ve sebat',
        'Ev bereketi',
        'Besleyici şefkat',
        'Uyum ve denge',
        'İç güç ve kararlılık',
      ],
      symbols: [
        'Dağ - Kararlılık ve güç',
        'Lotus - Saflık',
        'Ayna - Öz farkındalık',
        'Tesbih - Maneviyat',
        'Trishul (üçlü mızrak) - Shiva ile birlik',
        'Yeşil giysiler - Bereket ve yenilenme',
      ],
      planetaryConnection: 'Ay ve Venüs - Duygusal derinlik ve aşk',
      chakraConnection: 'Kalp (Anahata) - Koşulsuz sevgi',
      moonPhase: 'Büyüyen Ay - İlişkilerin gelişmesi',
      ritual: '''
Gauri Puja - Evlilik ve aile bereketi için yapılır. Kırmızı çiçekler,
meyve, pirinç sunulur. Evli kadınlar Gauri Vrat tutar.
Mangalsutra (evlilik kolyesi) kutsanır. Shiva-Parvati çifti
birlikte tapınılır.
''',
      meditation: '''
1. Yeşil veya kırmızı giyinin
2. Ev ortamında, aile fotoğrafları yakınında oturun
3. Ailenize sevgi gönderin
4. Parvati'yi Shiva ile birlikte görselleştirin
5. "Om Hreem Umayai Namaha" tekrarlayın
6. Evliliğiniz veya partnerliğiniz için niyetler belirleyin
7. Annelik/babalık enerjisini kucaklayın
8. Evi kutsal alan olarak kutsayın
''',
      blessing: '''
Parvati Ana, evime bereket, evliliğime mutluluk, çocuklarıma
sağlık ver. Sabır, şefkat ve sadakati öğret. Sevdiklerimi
korumamı, beslememi sağla. Ev yaşamını ruhani yol kıl.
Om Hreem Umayai Namaha.
''',
    ),

    ShaktiProfile(
      form: ShaktiForm.radha,
      title: 'RADHA - İLAHİ AŞKIN TİMSALİ',
      essence: '''
Radha, Krishna'nın en sevdiği gopi'dir ve ilahi aşkın (bhakti)
en yüksek simgesidir. O, insan ruhunun (jiva) Tanrı'ya (Krishna)
duyduğu tutkulu özlemin arketipidir.

Radha-Krishna ilişkisi, dünyevi romantik aşkın ötesindedir. O,
ruh ile Mutlak arasındaki mistik birliği, ayrılık acısının
(viraha) dönüştürücü gücünü ve kavuşmanın ekstazını temsil eder.

Radha, tüm gopilerin en cesur, en tutkulu olanıdır. Sosyal
kuralları, aile beklentilerini Krishna için feda eder. Bu
"deli aşk" (unmada), ruhani yolda ego'nun teslimiyetini simgeler.
''',
      cosmicRole: 'İlahi Aşk Simgesi, Bhakti Kraliçesi, Ruhun Özlemi',
      mantra: 'Radhe Radhe',
      yantra: 'Radha-Krishna Yantra - İç içe iki lotus',
      qualities: [
        'Koşulsuz aşk',
        'Tutkulu bağlılık',
        'Mistik birlik özlemi',
        'Cesur teslimiyet',
        'Aşk acısının kutsallığı',
        'Romantik maneviyat',
        'Kalp açıklığı',
        'İlahi sarhoşluk',
      ],
      symbols: [
        'Flüt sesi - Krishna\'nın çağrısı',
        'Mavi ve sarı - Radha-Krishna renkleri',
        'Yamuna nehri - Buluşma yeri',
        'Kadamba ağacı - Aşk ağacı',
        'Dans (Raas) - Kozmik birlik dansı',
        'Ay ışığı - Romantik atmosfer',
      ],
      planetaryConnection: 'Venüs ve Neptün - Aşk ve mistik birlik',
      chakraConnection: 'Kalp (Anahata) - Saf aşk',
      moonPhase: 'Dolunay - Aşkın eksiksizliği',
      ritual: '''
Raas Leela - Krishna'nın gopilerle dansının yeniden canlandırılması.
Janmashtami gecesi yapılır. Şarkılar, danslar, Krishna-Radha
hikayeleri anlatılır. Tereyağı, süt, tatlılar sunulur.
''',
      meditation: '''
1. Sarı veya mavi giyinin
2. Flüt müziği veya Krishna bhajan açın
3. Kalbinizdeki aşk özlemini hissedin
4. Radha-Krishna'yı dans ederken görselleştirin
5. "Radhe Radhe" veya "Hare Krishna" tekrarlayın
6. İlahi aşka teslim olun
7. Tüm ilişkilerinize bu aşkı yayın
8. Minnettar kalple kapanış yapın
''',
      blessing: '''
Radha Rani, kalbimi aşkla doldur. Krishna'ya duyduğun özlemi
bana öğret. Aşk acısını tatlıya çevir, ayrılığı kavuşmaya
dönüştür. Cesaretini, tutkunnu, teslimiyetini ver. Radhe Radhe.
''',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // SHIVA - DIVINE MASCULINE ESSENCE
  // ══════════════════════════════════════════════════════════════════════════

  static const String shivaEssence = '''
ŞİVA - İLAHİ MASKÜLİN ENERJİ

Shiva, "uğurlu olan" veya "iyilik getiren" anlamına gelir. O,
Hinduizm'in üç büyük tanrısından (Trimurti) biridir - yok edici
ve dönüştürücü. Ama Shiva sadece yok edici değildir; o, aynı
zamanda yogi'lerin efendisi, bilgeliğin kaynağı ve kozmik
dansçıdır.

Tantra'da Shiva, saf bilinçtir (Purusha). O, hareketsiz, değişmez,
ebedi tanıktır. Shakti (enerji) onun dinamik gücüdür; Shiva
(bilinç) ise o gücün farkındalığıdır. Birlikte, tüm varoluşu
oluştururlar.

Shiva'nın Kozmik Rolleri:
• Mahayogi: Büyük yogi, meditasyonun ustası
• Nataraja: Kozmik dansçı, evrenin ritmi
• Dakshinamurti: Güneye bakan öğretmen, sessiz guru
• Bhairava: Korkutucu form, zamanın yok edicisi
• Rudra: Fırtına tanrısı, yıkıcı güç

Her erkek Shiva'nın bir tezahürüdür. Her erkeğin içinde sessiz
tanık, yogi, savaşçı ve sevgili birlikte yaşar. Maskülin enerji,
koruma, sağlama, yön verme ve tutma kapasitesidir.

Shiva enerjisi Güneş ile bağlantılıdır. Güneş'in ışığı, bilinç
gibi aydınlatır, netlik getirir, yön gösterir. Shiva, Mars
gezegeniyle de bağlantılıdır - savaşçı enerji, koruyucu güç.
''';

  static const String lingamSymbolism = '''
LİNGAM - IŞIK SÜTUNU

Lingam, Sanskrit'te "işaret" veya "sembol" anlamına gelir.
Yaygın yanılgının aksine, lingam sadece fallik bir sembol değildir;
o, kozmik yaratımın, bilinç ve enerjinin birliğinin simgesidir.

Lingam Sembolizmi:
• Shiva'nın formisiz formunun işareti
• Işık sütunu (Jyotirlinga) - sonsuz bilinç
• Brahmanda (kozmik yumurta) - evrenin şekli
• Yukarı yükselen enerji - Kundalini'nin yükselişi

Shiva Lingam ve Yoni:
Geleneksel lingam, yoni (dişil sembol) içinde durur. Bu birlik,
Shiva-Shakti'nin ayrılmazlığını, bilinç ve enerjinin dansını
gösterir. Lingam yoni'siz, yoni lingam'sız tamamlanmaz.

Kutsal Lingam Türleri:
• Swayambhu Lingam: Doğal oluşumlu, en kutsal
• Jyotirlinga: 12 ışık lingamı, Hindistan'daki en kutsal yerler
• Bana Lingam: Narmada nehrinden çıkarılan oval taşlar
• Parada Lingam: Cıvadan yapılmış (simyevi)
• Sphatika Lingam: Kristal lingam

Lingam Puja:
Lingam üzerine su, süt, bal, yoğurt dökülür (abhisheka).
Bu, bilincin arındırılmasını, beslenmesinI simgeler. Bel yaprakları,
çiçekler sunulur. "Om Namah Shivaya" tekrarlanır.
''';

  static const String warriorProtector = '''
SAVAŞÇI VE KORUYUCU ARKETİPİ

Maskülin enerjinin temel ifadelerinden biri, koruyucu savaşçıdır.
Bu, fiziksel şiddetten çok, sınır koyma, savunma ve güç kullanma
kapasitesiyle ilgilidir.

Sağlıklı Savaşçı Özellikleri:
• Sınır koyma ve koruma yeteneği
• Zayıfları savunma dürtüsü
• Disiplin ve öz kontrol
• Cesaret ve korku yönetimi
• Amaç ve misyon odaklılık
• Stratejik düşünme
• Eylem kapasitesi
• Kararlılık ve sebat

Savaşçının Gölgeleri:
• Saldırgan Savaşçı: Kontrolsüz öfke, şiddet
• Mazoşist Savaşçı: Kendini feda eden, şehit
• Sadist Savaşçı: Güçten zevk alan, zorba
• Korkak Savaşçı: Harekete geçemeyen, pasif

İç Savaşçıyı Uyandırma:
Gerçek savaş dışarıda değil, içeridedir. Shiva'nın gerçek savaşı
maya (illüzyon) ile, ego ile, cehalet ile olmuştur. İç savaşçı,
kendi gölgelerimizle, korkularımızla, sınırlayıcı inançlarımızla
savaşır.

Mars ve Savaşçı:
Mars gezegeni, savaşçı enerjinin astrolojik karşılığıdır.
Doğum haritasında Mars'ın konumu, savaşçı enerjimizin nasıl
ifade edildiğini gösterir. Mars-Shiva bağlantısı, bu enerjinin
kutsallaştırılmasını mümkün kılar.
''';

  static const String asceticHouseholder = '''
ASCETİK VE EV SAHİBİ DENGESİ

Shiva, hem büyük yogi (Mahayogi) hem de ideal eştir (Parvati'nin
kocası). Bu iki görünüşte çelişkili rol, aslında maskülin
enerjinin bütünlüğünü gösterir.

Ascetik Yol (Sannyasa):
• Dünyevi bağlardan vazgeçme
• Meditasyon ve tapasya
• Brahmacharya (bekarlık)
• Doğada yaşam
• İç sessizlik arayışı
• Ego'nun eritilmesi

Ev Sahibi Yolu (Grihastha):
• Aile ve toplum sorumluluğu
• Evlilik ve çocuk yetiştirme
• Maddi ve duygusal sağlama
• Dharma'yı günlük yaşamda uygulama
• İlişki içinde büyüme
• Sevgi yoluyla teslimiyet

Shiva'nın Dengesi:
Shiva'nın hikayesi, bu iki yolun birleşebileceğini gösterir.
Parvati, Shiva'yı dağdan (inziva) indirmiş, ev yaşamına
çekmiştir. Ama Shiva, evde bile yogi kalmıştır.

Modern Erkek İçin Denge:
Bugünün erkeği, kariyer ve ilişki, başarı ve iç huzur, sağlama
ve varoluş arasında denge aramalıdır. Shiva modeli, bunların
birbirini dışlamadığını öğretir.
''';

  // ══════════════════════════════════════════════════════════════════════════
  // SHIVA FORMS - DETAILED PROFILES
  // ══════════════════════════════════════════════════════════════════════════

  static const List<ShivaProfile> shivaProfiles = [
    ShivaProfile(
      form: ShivaForm.nataraja,
      title: 'NATARAJA - KOZMİK DANSÇI',
      essence: '''
Nataraja, "dansın lordu" anlamına gelir. Shiva'nın bu formu,
kozmik yaratım, koruma ve yok edişin ebedi dansını gerçekleştirir.
Ateş çemberi içinde, bir ayağı cüce demon Apasmara (cehalet)
üzerinde, diğer ayağı havada dans eder.

Nataraja'nın dansı (Tandava), evrenin ritmik patternini temsil eder.
Her hareket bir yaratım veya yok oluş, her adım bir başlangıç
veya son demektir. Dans durduğunda, evren çöker; yeniden
başladığında, yeni bir kozmik döngü açılır.

Nataraja'nın ikonografisi, fizik ve kozmolojinin sembolik dilidir.
CERN'deki (Avrupa Nükleer Araştırma Merkezi) Nataraja heykeli,
bu bağlantıyı onurlandırır.
''',
      cosmicRole: 'Kozmik Yaratıcı ve Yok Edici, Ritim Lordu, Evrenin Dansçısı',
      mantra: 'Om Namo Bhagavate Natarajaya',
      yantra: 'Nataraja Yantra - Dans pozunda Shiva',
      qualities: [
        'Kozmik ritim farkındalığı',
        'Yaratım ve yok ediş döngüsü',
        'Hareket içinde durgunluk',
        'Paradoksları kucaklama',
        'Cehaletin üstesinden gelme',
        'Kozmik perspektif',
        'Dinamik meditasyon',
        'Sanatsal ifade',
      ],
      symbols: [
        'Ateş çemberi - Samsara, kozmik döngü',
        'Damaru (davul) - Yaratımın sesi, Om',
        'Ateş eli - Yok edici güç',
        'Havadaki ayak - Özgürleşme, kurtuluş',
        'Apasmara - Ezilen cehalet',
        'Ganga - Saçlarından akan nehir, kutsama',
        'Hilal ay - Zaman kontrolü',
        'Kobra - Kundalini, ölümsüzlük',
      ],
      planetaryConnection: 'Güneş ve Satürn - Bilinç ve kozmik düzen',
      chakraConnection: 'Sahasrara (Taç) - Kozmik bilinç',
      sunPhase: 'Gün ortası - Güneş dorukta, tam aydınlık',
      ritual: '''
Tandava dans meditasyonu - Ritimik müzik eşliğinde serbest
dans. Bedenin spontan hareketlerine izin verilir. Shiva'nın
kozmik dansına katılım hissedilir. Sonunda tamamen durulur,
sessizliğe geçilir.
''',
      meditation: '''
1. Ritimik müzik açın (davul sesleri ideal)
2. Ayakta durun, gözler kapalı
3. Bedenin kendi ritmini bulmasına izin verin
4. Nataraja'yı görselleştirin
5. Hareket ettikçe "Shivo'ham" (Ben Shiva'yım) düşünün
6. Dans ve durgunluğu bir arada hissedin
7. Yavaş yavaş hareketi durdurun
8. Tamamen hareketsiz, saf farkındalıkta kalın
''',
      blessing: '''
Nataraja, beni kozmik dansına davet et. Yaratım ve yok edişin
ritmini bedenimde hissettir. Cehaletimi ez, zincirlerimi çöz.
Hareket içinde durgunluğu, kaos içinde düzeni göster.
Om Namo Bhagavate Natarajaya.
''',
    ),

    ShivaProfile(
      form: ShivaForm.ardhanarishvara,
      title: 'ARDHANARİSHVARA - YARI KADIN LORD',
      essence: '''
Ardhanarishvara, Shiva ve Shakti'nin tek bedende birleşmiş
formudur. Yarısı erkek (sağ), yarısı kadın (sol) olarak tasvir
edilir. Bu form, eril ve dişil enerjilerin aslında tek bir
bütünün iki yüzü olduğunu öğretir.

Ardhanarishvara, tantrik felsefenin özünü görsel olarak ifade
eder: ayrılık illüzyondur, gerçekte sadece birlik vardır.
Shiva-Shakti, bilinç-enerji, erkek-kadın - bunlar aynı
gerçekliğin farklı görünümleridir.

Her bireyin içinde hem maskülin hem feminin enerji vardır.
Ardhanarishvara, bu iç dengenin önemini, bütünleşmenin
gerekliliğini hatırlatır.
''',
      cosmicRole: 'Birlik Simgesi, Dualite Ötesi, İç Denge Öğretmeni',
      mantra: 'Om Ardhanareeshwaraaya Namaha',
      yantra: 'Ardhanarishvara Yantra - Yarı Shiva yarı Shakti',
      qualities: [
        'İç erkek-kadın dengesi',
        'Dualite ötesi bilinç',
        'Bütünleşme ve entegrasyon',
        'Karşıtların kucaklanması',
        'Cinsiyet ötesi farkındalık',
        'Yin-Yang dengesi',
        'Tam insan olma',
        'Mistik birlik deneyimi',
      ],
      symbols: [
        'Yarı erkek yarı kadın beden - Birlik',
        'Sağ taraf (Shiva) - Mavi, aslan postu',
        'Sol taraf (Shakti) - Pembe/altın, sari',
        'Üçüncü göz - Her iki tarafta, birleşik görü',
        'Trishul ve lotus - Erkek ve kadın sembolleri',
        'Nandi (boğa) - Sadık taşıyıcı, her iki enerjiye hizmet',
      ],
      planetaryConnection: 'Güneş-Ay birliği - Erkek-kadın gezegenler',
      chakraConnection: 'Ajna (Üçüncü Göz) - Dualite ötesi görü',
      sunPhase: 'Gündönümü ve ekinoks - Gece-gündüz dengesi',
      ritual: '''
Yab-Yum pozisyonu meditasyonu - Partnerle veya görselleştirmeyle
yapılır. İç erkek ve kadın enerjileri birleştirilir.
Nefes senkronizasyonu, enerji değişimi hissedilir.
''',
      meditation: '''
1. Rahat bir pozisyonda oturun
2. Sağ tarafınızda maskülin enerjiyi hissedin (güç, koruma, yön)
3. Sol tarafınızda feminin enerjiyi hissedin (alıcılık, sezgi, akış)
4. İki enerjiyi omurgada birleştirin
5. Ardhanarishvara'yı görselleştirin
6. "Ben hem Shiva hem Shakti'yim" düşünün
7. Tamamlanma ve bütünlük hissini genişletin
8. Bu dengeyle günlük yaşama dönün
''',
      blessing: '''
Ardhanarishvara, beni bütün kıl. İçimdeki erkek ve kadını
birleştir. Dengesizliği dengele, eksikliği tamamla. Karşıtlar
bende buluşsun, ayrılık birliğe dönüşsün. Tek olduğumu hatırlat.
Om Ardhanareeshwaraaya Namaha.
''',
    ),

    ShivaProfile(
      form: ShivaForm.dakshinamurti,
      title: 'DAKSHİNAMURTİ - SESSİZ GURU',
      essence: '''
Dakshinamurti, "güneye bakan" anlamına gelir. Shiva'nın guru,
öğretmen formu olarak, bir ağacın altında oturur, genç öğrenciler
(rishiler) karşısında. Ama o konuşmaz - sessizlikle öğretir.

Bu paradoks, en derin bilgeliğin kelimelerle aktarılamayacağını
gösterir. Gerçek anlayış, gurunun mevcudiyetinde, sessiz iletişimde
(darshan) oluşur. Dakshinamurti, "o kim" sorusunun cevabını
sessizliğiyle verir.

Dakshinamurti, dört Veda'yı, altı darshana'yı (felsefe sistemleri)
ve tüm bilimi temsil eder. O, genç görünmesine rağmen en yaşlı,
sessiz olmasına rağmen en etkili öğretmendir.
''',
      cosmicRole: 'Adi Guru, Sessiz Öğretmen, Bilgelik Kaynağı, Jnana Lordu',
      mantra: 'Om Dakshinamurtaye Namaha',
      yantra: 'Dakshinamurti Yantra - Güneye bakan Shiva',
      qualities: [
        'Sessizliğin bilgeliği',
        'Öğretmenlik kapasitesi',
        'Derin dinleme',
        'Mevcudiyet gücü',
        'Bilgi aktarımı',
        'Saflık ve berraklık',
        'Genç bilgelik',
        'Ego-olmayan öğretme',
      ],
      symbols: [
        'Banyan ağacı - Sonsuz bilgi, köklerin genişliği',
        'Güneye bakış - Ölüm (yama) yönüne bakma, ölümsüzlük',
        'Chin mudra - Birlik işareti',
        'Sessizlik - En derin öğreti',
        'Genç rishiler - Bilgeliğin yaşla ilgisi yoktur',
        'Davul ve ateş - Yaratım ve yok ediş bilgisi',
      ],
      planetaryConnection: 'Jüpiter (Guru) - Bilgelik ve öğretmenlik',
      chakraConnection: 'Ajna ve Sahasrara - Bilgelik ve aydınlanma',
      sunPhase: 'Tan ve şafak - Aydınlanmanın başlangıcı',
      ritual: '''
Guru Purnima'da (Dolunay) yapılır. Sessizlik orucu (mouna)
tutulur. Guruya çiçek ve meyve sunulur. Öğretmenlik zinciri
(guru parampara) onurlandırılır. Shanti mantraları okunur.
''',
      meditation: '''
1. Sessiz, huzurlu bir yerde oturun
2. Guru arayışı niyeti belirleyin
3. Dakshinamurti'yi banyan ağacı altında görselleştirin
4. Sessizce karşısına oturun
5. Sorularınızı zihninizde sunun
6. Cevabı kelimelerde değil, histe arayın
7. Sessizliğin öğretisine açılın
8. Minnetle ayrılın
''',
      blessing: '''
Dakshinamurti, bana sessizliğin dilini öğret. Kelimesiz
anlayışı, kavrayışı bahşet. İç sesimi duyabilmem için dış
sesleri sustur. Bilgelik ışığını yak, cehalet karanlığını
dağıt. Om Dakshinamurtaye Namaha.
''',
    ),

    ShivaProfile(
      form: ShivaForm.bhairava,
      title: 'BHAİRAVA - KORKUTUCU FORM',
      essence: '''
Bhairava, "korkunç" veya "dehşet verici" anlamına gelir.
Shiva'nın en korkutucu, en güçlü formudur. Siyah tenli, keskin
dişli, kapala (kafatası kadehi) tutan, köpeğiyle dolaşan vahşi
bir figür olarak tasvir edilir.

Ama Bhairava'nın korkutuculuğu, koruyuculuğundandır. O, zamanın
(Kala) ve ölümün (Yama) efendisidir. Korkularımızla yüzleşmemizi,
sınırlarımızı aşmamızı sağlar.

64 Bhairava ve 8 ana Bhairava (Ashtanga Bhairava) vardır.
Kal Bhairava, zamanın efendisi olarak, Kashi (Varanasi) şehrinin
koruyucusudur. O şehirde ölenler doğrudan moksha'ya (kurtuluş)
ulaşır - Bhairava'nın lütfuyla.
''',
      cosmicRole: 'Zaman Efendisi, Koruyucu, Korku Dönüştürücü, Sınır Bekçisi',
      mantra: 'Om Kal Bhairavaya Namaha',
      yantra: 'Bhairava Yantra - Sekiz yapraklı lotus',
      qualities: [
        'Korkuyu dönüştürme',
        'Sınırları koruma',
        'Zaman farkındalığı',
        'Ölüm kabulü',
        'Gölge çalışması',
        'Güçlü koruma',
        'Disiplin ve ceza',
        'Radikal dürüstlük',
      ],
      symbols: [
        'Kapala (kafatası kadehi) - Ego\'nun ölümü',
        'Köpek - Sadakat, alt dürtülerin dönüşümü',
        'Trishul - Üç guna üzerinde hakimiyet',
        'Damaru - Kozmik ritim',
        'Siyah renk - Bilinmeyenin kutsallığı',
        'Yılan - Kundalini, ölümsüzlük',
        'Kılıç - Cehaletin kesilmesi',
      ],
      planetaryConnection: 'Satürn ve Mars - Sınırlar ve savaşçı enerji',
      chakraConnection: 'Muladhara (Kök) - Hayatta kalma ve korku',
      sunPhase: 'Gece yarısı - Karanlığın doruk noktası',
      ritual: '''
Kalashtami'de (ayın sekizinci günü) yapılır. Gece yarısı
meditasyonu, siyah çiçekler, içki (bazı geleneklerde) sunulur.
Bhairava Ashtakam okunur. Korku ile yüzleşme ritüeli yapılır.
''',
      meditation: '''
1. Gece veya karanlık ortamda oturun
2. Korkularınızı listeleyin
3. Her korkuyu Bhairava'ya sunun
4. "Om Kal Bhairavaya Namaha" güçlü sesle tekrarlayın
5. Bhairava'nın korkuları yuttuğunu görselleştirin
6. Korku yerini güce bırakır
7. Sınırlarınızı güçlendirin
8. Korunmuş hissedin
''',
      blessing: '''
Bhairava, korkularımı al, cesaretimi ver. Zamanın geçiciliğini
hatırlat ama zamana bağlı kılma. Sınırlarımı koru, düşmanlarımı
uzaklaştır. Karanlığımda ışık ol, zayıflığımda güç.
Om Kal Bhairavaya Namaha.
''',
    ),

    ShivaProfile(
      form: ShivaForm.mahayogi,
      title: 'MAHAYOGİ - BÜYÜK YOGİ',
      essence: '''
Mahayogi, "büyük birleştirici" veya "büyük yogi" anlamına gelir.
Shiva'nın meditasyondaki formu olarak, Himalaya'nın zirvesinde,
Kailash dağında, derin samadhi'de (aşkın bilinç) oturur.

Shiva, yoga'nın kurucusu kabul edilir. Adi Yogi (ilk yogi) olarak,
yoga bilimini yedi rishi'ye (Saptarishi) aktarmıştır. Bu nedenle
o, Yogeshwara - yoginin lordu olarak da bilinir.

Mahayogi formu, derin meditasyonun, içsel sessizliğin, dünyevi
bağlardan kopmanın idealini temsil eder. O, binlerce yıl
meditasyonda kalabilir - zamanın ötesinde, formun ötesinde.
''',
      cosmicRole: 'Yoga\'nın Kurucusu, Meditasyon Ustası, İç Sessizlik Kaynağı',
      mantra: 'Om Namah Shivaya',
      yantra: 'Shiva Lingam - Formisiz formun sembolü',
      qualities: [
        'Derin meditasyon',
        'İç sessizlik',
        'Dünyevi bağsızlık',
        'Bilinç genişlemesi',
        'Beden hakimiyeti',
        'Nefes kontrolü',
        'Kundalini uyandırma',
        'Samadhi deneyimi',
      ],
      symbols: [
        'Kaplan postu - Kontrol edilmiş hayvansal doğa',
        'Rudraksha - Shiva\'nın gözyaşları, meditasyon yardımcısı',
        'Kül (Vibhuti) - Maddenin geçiciliği',
        'Matted saç - Dünyevi çekiciliğe kayıtsızlık',
        'Üçüncü göz - İç görü',
        'Trishul - Üç guna üzerinde hakimiyet',
        'Damaru - Kozmik titreşim, Nada',
        'Ganga - Saf bilinç akışı',
      ],
      planetaryConnection: 'Ketu - Dünyevi bağlardan kopuş, moksha',
      chakraConnection: 'Tüm chakralar - Kundalini yolculuğu',
      sunPhase: 'Brahma muhurta (gün doğmadan önce) - Meditasyon zamanı',
      ritual: '''
Maha Shivaratri - Yılın en kutsal gecesi, Shiva'nın kozmik
dansının gecesi. Gece boyu uyanık kalınır, meditasyon yapılır,
oruç tutulur. Lingam'a süt, bal, su dökülür. Om Namah Shivaya
tekrarlanır.
''',
      meditation: '''
1. Brahma muhurta'da (04:00-06:00) oturun
2. Omurga dik, surat Kuzey veya Doğu'ya
3. Rudraksha mala ile "Om Namah Shivaya" 108 kez
4. Nefesi izleyin, yavaşlatın
5. Shiva'yı Kailash'ta görselleştirin
6. Onunla birleşin, eriyin
7. Düşüncesiz farkındalıkta kalın
8. Yavaşça dönün
''',
      blessing: '''
Mahayogi Shiva, bana meditasyonun sırrını öğret. Zihnimin
dalgalanmalarını durdur, iç sessizliğe ulaştır. Dünyada
olayım ama dünyaya ait olmayayım. Yoga yolunda bana rehberlik et.
Om Namah Shivaya.
''',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // SACRED UNION - SHIVA-SHAKTI DANCE
  // ══════════════════════════════════════════════════════════════════════════

  static const String sacredUnionEssence = '''
KUTSAL BİRLİK - SHİVA-SHAKTİ DANSI

Shiva ve Shakti'nin birliği, evrenin temel ilkesidir. Onların
ayrılığı illüzyon, birliği gerçekliktir. Her yaratım, bu kozmik
çiftin dans etmesinden doğar.

Shiva-Shakti Dinamiği:
• Shiva: Bilinç, değişmez, tanık, durgun göl
• Shakti: Enerji, değişen, deneyim, akan nehir
• Birlikte: Yaşayan evren, bilinçli varoluş

Tantra'da aşkınlık, dünyayı reddetmekle değil, dönüştürmekle
olur. Cinsellik, ilişki, beden - bunlar engelller değil,
uyanış araçlarıdır. Shakti-Shiva birliği, bu dönüşümün modelidir.

HİEROS GAMOS - KUTSAL EVLİLİK

Antik kültürlerde kutsal evlilik (hieros gamos) ritüelleri,
Tanrı ve Tanrıça'nın birleşmesini temsil ederdi. Bu ritüeller,
kozmik döngülerin devamını, bereketik ve yeniden doğuşu
sembolize eder.

Shiva-Shakti'nin kutsal birliği, her sevişmede yansır.
Bilinçli partnerler, kozmik dansın parçası olduklarını
bilirler. Cinsel enerji, en güçlü yaratıcı güçtür ve
ruhani uyanış için kullanılabilir.

ARDHANARISHVARA - İÇSEL BİRLİK

Dış birlikten önce, iç birlik gelmelidir. Her birey kendi
içinde hem Shiva hem Shakti taşır. İç erkek ve iç kadın
enerjilerini tanımak, kabul etmek ve entegre etmek,
gerçek ilişkinin temelidir.

İç Birlik Çalışması:
• İç erkek: Koruyucu, sağlayıcı, yön verici, tutucu
• İç kadın: Alıcı, besleyici, sezgisel, akışkan
• Entegrasyon: Her iki enerjiye bilinçli erişim
''';

  static const List<SacredUnionPractice> sacredUnionPractices = [
    SacredUnionPractice(
      title: 'Yab-Yum Meditasyonu',
      description: '''
Yab-Yum, Tibetçe'de "baba-anne" anlamına gelir. Tantrik
ikonografide, erkek tanrı (yab) oturur, kadın tanrıça (yum)
onun kucağında, yüz yüze pozisyonda yer alır. Bu, enerji
değişiminin ve birliğin güçlü bir sembolüdür.
''',
      purpose: 'Enerji değişimi, kalp bağlantısı, kundalini uyandırma',
      steps: [
        'Partner bağdaş kurarak oturur',
        'Diğer partner kucağına, yüz yüze oturur',
        'Bacaklar partnerin arkasından dolanır',
        'Alınlar birbirine değer',
        'Nefesler senkronize edilir',
        'Kalp merkezleri hizalanır',
        'Enerji değişimi hissedilir',
        'Sessizlikte kalınır (15-30 dakika)',
        'Yavaşça ayrılır, göz temasıyla',
      ],
      duration: '20-45 dakika',
      bestTime: 'Akşam, özellikle Dolunay',
      mantra: 'Om Mani Padme Hum',
      affirmation: 'Biz biriz, ayrılık yoktur, sadece aşk vardır',
      requiresPartner: true,
    ),

    SacredUnionPractice(
      title: 'Shiva-Shakti Nefes Döngüsü',
      description: '''
Bu pratik, partnerler arasında enerji döngüsü oluşturur.
Nefes, enerjiyi taşır. Bir partner verirken diğeri alır,
sonra roller değişir. Sürekli bir akış, "sonsuzluk" deseni
oluşur.
''',
      purpose: 'Enerji sirkülasyonu, bağ derinleştirme, senkronizasyon',
      steps: [
        'Yüz yüze oturun veya yan yana yatın',
        'El ele tutuşun',
        'Göz teması kurun',
        'Partner A nefes verir, B alır',
        'Partner B nefes verir, A alır',
        'Ritmik döngü oluşturun',
        'Enerjinin eller ve kalp arasında aktığını hissedin',
        '10-20 döngü sonra spontan nefese geçin',
        'Sessizlikte birlikte kalın',
      ],
      duration: '15-30 dakika',
      bestTime: 'Sabah veya gece yatmadan önce',
      mantra: 'So-Ham (Nefes alırken So, verirken Ham)',
      affirmation: 'Nefesimiz bir, enerjimiz bir, aşkımız bir',
      requiresPartner: true,
    ),

    SacredUnionPractice(
      title: 'Kalp Köprüsü Meditasyonu',
      description: '''
İki kalp merkezi arasında ışık köprüsü kurulur. Bu pratik,
duygusal bağı derinleştirir, geçmiş yaraları iyileştirir,
koşulsuz sevgiyi aktive eder.
''',
      purpose: 'Duygusal iyileşme, kalp açma, koşulsuz sevgi',
      steps: [
        'Karşılıklı oturun, dizler değecek şekilde',
        'Sol elinizi partnerin kalbine koyun',
        'Partnerin sol eli sizin kalbinizde',
        'Gözler kapalı veya yumuşak bakış',
        'Kalbinizden yeşil veya pembe ışık yayıldığını görselleştirin',
        'Işık partnerin kalbine ulaşır',
        'Partnerin ışığı sizin kalbinize gelir',
        'Köprü tamamlanır, enerji döngüsel akar',
        'Birbirinize "Seni seviyorum" deyin (içten)',
        '10-15 dakika kalın',
      ],
      duration: '15-20 dakika',
      bestTime: 'Gün batımı veya mum ışığında',
      mantra: 'Aham Prema (Ben sevgiyim)',
      affirmation: 'Kalbim senin kalbine açık, aşk aramızda özgürce akar',
      requiresPartner: true,
    ),

    SacredUnionPractice(
      title: 'İç Birleşme - Solo Pratik',
      description: '''
Partnere gerek kalmadan, kendi iç eril ve dişil enerjilerini
birleştirme pratiği. Ardhanarishvara meditasyonu olarak da bilinir.
Bütünleşme, özgüven ve duygusal denge sağlar.
''',
      purpose: 'İç denge, bütünleşme, kendi kendine yetme',
      steps: [
        'Rahat bir pozisyonda oturun',
        'Bedeninizin sağ yarısına odaklanın (maskülin)',
        'Güç, koruma, yapı hissedin',
        'Sol yarıya geçin (feminin)',
        'Alıcılık, sezgi, akış hissedin',
        'Omurgada iki enerjiyi birleştirin',
        'Merkez kanalda (sushumna) yükselen enerji',
        'Ardhanarishvara\'yı görselleştirin',
        '"Ben bütünüm" deyin',
        'Bu bütünlükle günlük yaşama dönün',
      ],
      duration: '20-30 dakika',
      bestTime: 'Ekinoks ve gündönümü günleri, veya her gün',
      mantra: 'Om Ardhanareeshwaraaya Namaha',
      affirmation: 'İçimde hem Shiva hem Shakti yaşar, ben bütünüm',
      requiresPartner: false,
    ),

    SacredUnionPractice(
      title: 'Tantrik Sarılma (Tantric Embrace)',
      description: '''
Basit ama güçlü bir pratik. Uzun süre, bilinçli, sessiz sarılma.
Zihin sakinleşir, kalpler senkronize olur, oksit osin ve
bağlanma hormonları salgılanır. Cinsel enerji dönüştürülür.
''',
      purpose: 'Bağlanma, güven, huzur, enerji yenileme',
      steps: [
        'Ayakta veya yatarak kucaklaşın',
        'Kalpler temas etsin',
        'Sessiz kalın, konuşmayın',
        'Nefeslerin doğal senkronize olmasına izin verin',
        'Bedenin gevşemesine izin verin',
        'Herhangi bir duyguyu kabul edin (gözyaşı normal)',
        'En az 10 dakika kalın (ideal 20-30)',
        'Yavaşça, minnetle ayrılın',
        'Göz teması ile tamamlayın',
      ],
      duration: '10-30 dakika',
      bestTime: 'Her an, özellikle stres sonrası',
      mantra: 'Sessizlik',
      affirmation: 'Bu anda güvendeyim, seviliyorum, bütünüm',
      requiresPartner: true,
    ),

    SacredUnionPractice(
      title: 'Maithuna Hazırlık Ritüeli',
      description: '''
Maithuna, tantrik birleşme pratiğidir. Bu ritüel, fiziksel
birleşmeden önce yapılır. Kutsal alan yaratır, niyetler
belirlenir, enerji hazırlanır. Cinsellik ibadete dönüşür.
''',
      purpose: 'Kutsal cinsellik, enerji yükseltme, birlik deneyimi',
      steps: [
        'Temiz, özenli bir alan hazırlayın',
        'Mumlar, çiçekler, güzel kokular',
        'Birbirinizi yıkayın (ritüel banyo)',
        'Güzel giysiler giyin veya çıplak kalın',
        'Karşılıklı oturun',
        'Birbirinize çiçek sunun',
        'Niyetinizi belirtin: "Bu birlik kutsal olsun"',
        'Beş duyuyu onurlandırın (koku, tat, ses, dokunuş, görüntü)',
        'Yavaşça, bilinçli olarak yaklaşın',
        'Her dokunuş ibadet olsun',
      ],
      duration: '30-60 dakika (birleşme öncesi)',
      bestTime: 'Dolunay, Purnima geceleri, özel günler',
      mantra: 'Om Aim Hreem Shreem',
      affirmation: 'Bedenlerimiz tapınak, birleşmemiz ibadet',
      requiresPartner: true,
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // ENERGY BALANCING
  // ══════════════════════════════════════════════════════════════════════════

  static const List<EnergyImbalance> energyImbalances = [
    EnergyImbalance(
      type: EnergyImbalanceType.deficientFeminine,
      description: '''
Dişil enerji eksikliği, almakta, hissetmekte, teslim olmakta
zorlanma olarak tezahür eder. Aşırı erillik, dengeyi bozar.
Kişi sürekli "yapar", asla "olur" durumunda kalamaz.
''',
      signs: [
        'Yardım veya hediye kabul edememe',
        'Duygulardan kopukluk',
        'Aşırı kontrol ihtiyacı',
        'Sezgilere güvenmeme',
        'Bedenle bağlantı eksikliği',
        'Yaratıcılık bloğu',
        'İlişkilerde mesafe',
        'Doğa ile kopukluk',
        'Uyku sorunları',
        'Kronik gerginlik',
        'Ağlamakta zorluk',
        'Hassasiyeti zayıflık olarak görme',
      ],
      causes: [
        'Anneden yeterli sevgi almama',
        'Dişil enerjinin küçümsenmesi',
        'Travma sonucu duyguları kapama',
        'Aşırı rekabetçi ortamlar',
        'Feminin özelliklerin cezalandırılması',
        'Kültürel eril baskınlık',
      ],
      healingPractices: [
        'Su elementı ile çalışma (yüzme, banyo, nehir kenarı)',
        'Ay meditasyonları, özellikle Dolunay',
        'Dans, özellikle serbest akış',
        'Doğada vakit geçirme',
        'Yaratıcı sanatlar (resim, seramik, müzik)',
        'Yavaşlama, boşluk bırakma',
        'Alıcılık pratiği (hediye kabul etme)',
        'Duygu günlüğü tutma',
        'Shakti meditasyonları',
        'Kadın çemberleri veya törenlere katılma',
      ],
      affirmation: '''
Almaya layığım. Duygularım değerlidir. Teslim olmak güçtür.
Sezgilerim rehberimdir. Bedenime güveniyorum. Shakti bende yaşar.
''',
    ),

    EnergyImbalance(
      type: EnergyImbalanceType.excessiveFeminine,
      description: '''
Aşırı dişil enerji, sınır eksikliği, aşırı duygusallık ve
kendin için ayağa kalkamama olarak tezahür eder. Maskülin
destek olmadan, enerji dağılır ve tükenir.
''',
      signs: [
        'Sınır koyamama, hayır diyememe',
        'Aşırı duygusal tepkiler',
        'Başkalarının duygularını sünger gibi emme',
        'Karar vermekte zorluk',
        'Bağımlı ilişkiler',
        'Kendin savunamama',
        'Sürekli kurban hissetme',
        'Enerji vampirlerine açıklık',
        'Aşırı empati, tükenme',
        'Yapısızlık, dağınıklık',
        'Pasiflik, eylemsizlik',
        'Kendini ihmal etme',
      ],
      causes: [
        'Aşırı koruyucu büyütülme',
        'Bağımsızlığın engellenmesi',
        'Eril gücün travma ile ilişkilendirilmesi',
        'Güçlü babayı olamama',
        'Kültürel olarak kadını zayıf gösterme',
        'Kendi sesini bulamamış olma',
      ],
      healingPractices: [
        'Fiziksel egzersiz, güç antrenmanı',
        'Sınır koyma pratiği (küçükten başlayarak)',
        'Ateş elementi ile çalışma (mum, şömine, güneş)',
        'Kök çakra güçlendirme',
        'Durga meditasyonları',
        'Dövüş sanatları veya boks',
        'Net iletişim pratiği',
        'Liderlik rolleri üstlenme',
        'Solo aktiviteler, bağımsızlık',
        'Hedef belirleme ve takip',
      ],
      affirmation: '''
Sınırlarım kutsaldır. Hayır demek sevgi eylemidir.
Kendi ayaklarım üzerinde durabilirim. Gücüm içimde.
Korumak ve korunmak hakkımdır.
''',
    ),

    EnergyImbalance(
      type: EnergyImbalanceType.deficientMasculine,
      description: '''
Eril enerji eksikliği, yön bulmakta, karar vermekte, korumakta
ve sağlamakta zorlanma olarak görülür. Yapı ve disiplin eksiktir.
''',
      signs: [
        'Karar verememe, kararsızlık',
        'Harekete geçememe, procrastination',
        'Yön ve amaç eksikliği',
        'Pasif agresiflik',
        'Sorumluluk almaktan kaçınma',
        'Sınır ihlallerine tepkisizlik',
        'Mali istikrarsızlık',
        'İrade zayıflığı',
        'Taahhüt korkusu',
        'Çatışmadan kaçınma',
        'Otorite figürleri ile sorunlar',
        'Baba yaraları',
      ],
      causes: [
        'Baba yokluğu veya zayıf baba',
        'Eril modellerin olmaması',
        'Erilliğin toksik örnekleri nedeniyle reddi',
        'Aşırı koruyucu anne',
        'Başarısızlık korkusu',
        'Erkeklik ile ilgili utanç',
      ],
      healingPractices: [
        'Fiziksel aktivite, özellikle güç gerektiren',
        'Hedef belirleme ve takip sistemi',
        'Mars enerjisi meditasyonları',
        'Soğuk duş, disiplin pratikleri',
        'Mentor veya koç ile çalışma',
        'Sorumluluk alma (proje, takım, vb.)',
        'Karar verme pratiği (küçükten başlayarak)',
        'Savaşçı arketipi çalışması',
        'Shiva meditasyonları, özellikle Rudra',
        'Ateş ritüelleri',
      ],
      affirmation: '''
Ben güçlüyüm. Kararlarım önemlidir. Yön bulabilirim.
Koruyabilirim, sağlayabilirim. İç savaşçım uyanık.
Shiva bende yaşar.
''',
    ),

    EnergyImbalance(
      type: EnergyImbalanceType.excessiveMasculine,
      description: '''
Aşırı eril enerji, saldırganlık, kontrolcülük ve duygusal
uzaklık olarak tezahür eder. Dişil yumuşaklık ve alıcılık eksiktir.
''',
      signs: [
        'Öfke patlamaları',
        'Aşırı kontrol ihtiyacı',
        'İş bağımlılığı',
        'Duygusal ifade zorluğu',
        'İlişkilerde mesafe',
        'Rekabetçilik takıntısı',
        'Başkalarını dinlememe',
        'Empati eksikliği',
        'Beden ihmal (aşırı zorlanma)',
        'Tükenme, burnout',
        'Yardım istemekten kaçınma',
        'Hassasiyeti zayıflık olarak görme',
      ],
      causes: [
        'Toksik maskülinite modelleri',
        'Duygusal ihmal',
        'Zayıflığın cezalandırıldığı ortamlar',
        'Aşırı rekabetçi kültür',
        'Feminin enerjinin değersizleştirilmesi',
        'Erkek olmak ile ilgili baskılar',
      ],
      healingPractices: [
        'Su elementi çalışması (yüzme, banyo)',
        'Meditasyon ve mindfulness',
        'Yavaşlama pratiği',
        'Duygusal okuryazarlık geliştirme',
        'Shakti meditasyonları',
        'Dans, özellikle yavaş ve akışkan',
        'Doğada vakit geçirme',
        'Terapi veya danışmanlık',
        'Dinleme pratiği',
        'Yardım isteme cesareti',
        'Hassasiyet gösterme denemeleri',
        'Kadın danışman veya mentor',
      ],
      affirmation: '''
Yumuşaklık güçtür. Almak da vermek kadar kutsaldır.
Duygularım beni bütünleştirir. Yavaşlamak iyidir.
Shaktinin akışına teslim oluyorum.
''',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // FEMININE ENERGY WISDOM
  // ══════════════════════════════════════════════════════════════════════════

  static const List<DivineFeminineWisdom> feminineWisdoms = [
    DivineFeminineWisdom(
      title: 'Alıcılığın Gücü',
      teaching: '''
Dişil enerji almada ustadır. Toprak nasıl tohumu alır, ay nasıl
güneşin ışığını yansıtır, rahim nasıl yaşamı barındırır -
alıcılık pasiflik değil, aktif bir kapasitedir. Almadan vermek,
kuyuyu kurutur.
''',
      practice: '''
Bugün bir şey "al" - bir iltifat, bir hediye, bir yardım teklifi.
Reddetme dürtüsünü fark et, ona rağmen kabul et. "Teşekkür ederim"
de ve alıcılığın hissini bedeninde izle.
''',
      affirmation: 'Almaya layığım. Almak vermek kadar kutsaldır.',
    ),

    DivineFeminineWisdom(
      title: 'Sezginin Bilgeliği',
      teaching: '''
Shakti, sezgisel biliştir. Mantık analiz eder, sezgi bilir.
Kadın bedeni kozmik antendir - duyguları, enerjileri, gizli
niyetleri hisseder. Bu, antik bir hayatta kalma becerisidir
ve ruhani bir hediyedir.
''',
      practice: '''
Bir karar vermeden önce, mantığı bir kenara koy. Sessizliğe
geç. Bedenine sor: "Bu doğru mu?" İlk gelen hissi kaydet.
Mantık daha sonra test edebilir, ama sezgi önce konuşsun.
''',
      affirmation: 'Sezgilerim bilgeliğimdir. Bedenimi dinliyorum.',
    ),

    DivineFeminineWisdom(
      title: 'Döngüselliğin Kutsallığı',
      teaching: '''
Dişil enerji döngüseldir, lineer değil. Ay döngüsü, adet döngüsü,
mevsimler, gelgitler - hepsi tekrarlayan spirallerdir. Dişil
bilgelik, döngüleri tanır, onurlar ve onlarla çalışır.
''',
      practice: '''
Ay takvimine bak. Şu an hangi evredesin? Beden döngün nerede?
Enerjinin doğal ritmine uy. Karanlık ay'da dinlen, Dolunay'da
parla. Doğayla senkronize ol.
''',
      affirmation: 'Ben döngünün parçasıyım. Her evre kutsal ve gerekli.',
    ),

    DivineFeminineWisdom(
      title: 'Yaratıcılığın Kaynağı',
      teaching: '''
Shakti, yaratıcı güçtür. Sadece çocuk doğurmak değil, her türlü
yaratım - sanat, iş, fikirler, ilişkiler - dişil enerjiden doğar.
Esinlenme, hamilelik, doğum, emzirme... yaratım döngüsü her
alanda geçerlidir.
''',
      practice: '''
Yarattığın her şeyi gözden geçir: ilişkiler, projeler, evler,
yemekler, fikirler... Hepsinde Shakti'nin elini gör. Bugün
bir şey yarat - küçük olabilir. Yarattığını kutsay.
''',
      affirmation: 'Ben yaratıcıyım. Her eylemim yaratım eylemidir.',
    ),

    DivineFeminineWisdom(
      title: 'Bağlantının Gücü',
      teaching: '''
Dişil enerji bağlantı kurar. İlişki dokusu, toplum yapıştırıcısı,
empati köprüsü - bunlar Shakti'nin hediyeleridir. Ayrılık illüzyonu,
birlik gerçekliği dişil bilgeliğin çekirdeğidir.
''',
      practice: '''
Bugün bir bağlantıyı derinleştir. Bir arkadaşa yaz, aile üyesini
ara, yabancıya gülümse. Bağlantının enerjisini hisset. Ayrı
olmadığımızı hatırla.
''',
      affirmation: 'Ben bağlıyım. Sevgi beni tüm varlıklarla birleştirir.',
    ),

    DivineFeminineWisdom(
      title: 'Teslimiyet Sanatı',
      teaching: '''
Teslimiyet zayıflık değil, en büyük güçtür. Su nasıl kayaya teslim
olur ve onu aşındırır, rüzgar nasıl eğilir ve her yere ulaşır -
dişil bilgelik direnişte değil, akışta güç bulur.
''',
      practice: '''
Bugün bir şeyle savaşmayı bırak. Kontrolü bırak, sonucun ne olacağını
görmeden hareket et. "Olan olsun" de ve rahatlamanın bedeninde
yarattığı gevşemeyi hisset.
''',
      affirmation: 'Akışa teslim oluyorum. Teslimiyet benim gücüm.',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // MASCULINE ENERGY WISDOM
  // ══════════════════════════════════════════════════════════════════════════

  static const List<DivineMasculineWisdom> masculineWisdoms = [
    DivineMasculineWisdom(
      title: 'Bilinçli Mevcudiyet',
      teaching: '''
Shiva saf bilinçtir - değişen her şeyin değişmez tanığı. Eril
enerjinin özü, farkındalıkta var olmaktır. "Yapmadan önce olmak"
Shiva'nın öğretisidir. Mevcudiyet, aksiyondan önce gelir.
''',
      practice: '''
Bir dakika, sadece ol. Hiçbir şey yapma, hiçbir şey düşünme,
sadece farkında ol. Nefesin, bedenin, çevrenin tanığı ol.
Eylem öncesi bu mevcudiyeti hisset.
''',
      affirmation: 'Ben bilinçli mevcudiyetim. Yapmadan önce varım.',
    ),

    DivineMasculineWisdom(
      title: 'Koruma Kapasitesi',
      teaching: '''
Sağlıklı eril enerji korur. Kendi sınırlarını, sevdiklerini,
değerlerini, ideallerini koruma kapasitesi. Bu saldırganlık
değil, mukaddes bir görevdir. Koruyucu savaşçı, şiddetten
kaçınır ama gerektiğinde harekete geçer.
''',
      practice: '''
Bugün bir şeyi koru. Bir sınır koy, bir değeri savun, birini
destekle. Koruma enerjisini hisset. Bu güç sana ait, onu
kullanmak hakkındır.
''',
      affirmation:
          'Koruyucu gücüm içimde. Sevdiklerimi ve değerlerimi savunurum.',
    ),

    DivineMasculineWisdom(
      title: 'Yön ve Amaç',
      teaching: '''
Eril enerji yön verir, pusulası içseldir. Hedef belirleme,
yol çizme, ilerleme - bunlar Shiva'nın özellikleridir. Amaçsız
enerji dağılır, amaçlı enerji dağları hareket ettirir.
''',
      practice: '''
Bir yön belirle - bugün için, bu hafta için, bu yıl için.
Yazılı hedef koy. Küçük bir adım at o yöne. Adımın yarattığı
momentumu hisset.
''',
      affirmation: 'Yönümü biliyorum. Her adım beni amacıma yaklaştırır.',
    ),

    DivineMasculineWisdom(
      title: 'Disiplin Sanatı',
      teaching: '''
Tapasya (ruhani disiplin), Shiva'nın yoludur. O, binlerce yıl
meditasyonda kalabilir. Disiplin, irade kasını güçlendirir,
anlık tatmini erteleyerek derin doyumu mümkün kılar.
''',
      practice: '''
Küçük bir disiplin seç - erken uyanmak, soğuk duş, günlük
meditasyon. Bugün başla, 21 gün sürdür. Disiplinin yarattığı
iç gücü deneyimle.
''',
      affirmation: 'Disiplinim özgürlüğümdür. Güçlü iradem beni yüceltir.',
    ),

    DivineMasculineWisdom(
      title: 'Sessizliğin Gücü',
      teaching: '''
Dakshinamurti sessizlikle öğretir. Gerçek eril güç, gürültüde
değil sessizlikte bulunur. Konuşmadan önce dinlemek, harekete
geçmeden önce beklemek, bilgeliğin işaretidir.
''',
      practice: '''
Bugün fazladan konuşma. Dinle. Cevap vermeden önce 3 saniye
bekle. Sessizliğin rahatsızlığını hisset, ona alış. Sessizlikte
güç var.
''',
      affirmation:
          'Sessizliğim bilgeliktir. Dinliyorum, anlıyorum, sonra konuşurum.',
    ),

    DivineMasculineWisdom(
      title: 'Dönüştürücü Güç',
      teaching: '''
Shiva, yok edici ve dönüştürücüdür. Artık işe yaramayan her
şeyi sonlandırma cesareti gerektirir. Ama bu yıkım, yaratımın
önkoşuludur. Eski yıkılmadan yeni inşa edilemez.
''',
      practice: '''
Hayatında bitirmesi gereken bir şeyi belirle - bir alışkanlık,
bir ilişki, bir inanç. Bugün bitirme sürecini başlat. Bitiş
acı verici olabilir ama gereklidir.
''',
      affirmation: 'Bitirme gücüm var. Eski gidince yeni gelir.',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // ZODIAC DIVINE ENERGIES
  // ══════════════════════════════════════════════════════════════════════════

  static const String zodiacPolarityExplanation = '''
BURÇLAR VE İLAHİ ENERJİLER

Zodyak, altı dişil ve altı eril burçtan oluşur. Bu, cinsiyet değil,
enerji polaritesidir. Ateş ve Hava burçları eril/yang enerjisi taşır;
Toprak ve Su burçları dişil/yin enerjisi taşır.

Eril Burçlar (Ateş + Hava):
Koç, İkizler, Aslan, Terazi, Yay, Kova
• Dışa dönük, aktif, girişimci
• Veren, yönlendiren, harekete geçiren
• Güneş ve Mars enerjisi baskın

Dişil Burçlar (Toprak + Su):
Boğa, Yengeç, Başak, Akrep, Oğlak, Balık
• İçe dönük, alıcı, koruyucu
• Alan, besleyen, saklayan
• Ay ve Venüs enerjisi baskın

Her birey, cinsiyetinden bağımsız olarak, haritasına göre farklı
dengede eril ve dişil enerji taşır. Güneş burcu bu polariteyi gösterir
ama Ay, Yükselen ve diğer gezegenler de dikkate alınmalıdır.
''';

  static const List<ZodiacDivineEnergy> zodiacDivineEnergies = [
    ZodiacDivineEnergy(
      zodiacSign: 'Koç',
      polarity: ZodiacPolarity.masculine,
      goddessArchetype: 'Durga / Amazon Savaşçı',
      godArchetype: 'Mars / Ares / Rudra',
      shaktiManifestation: '''
Koç'ta Shakti, savaşçı tanrıça olarak tezahür eder. Durga gibi
cesaretli, korkusuz ve koruyucu. Koç kadınında Shakti ateşli,
bağımsız ve liderdir. Öncü enerji, yeni yollar açar.
''',
      shivaManifestation: '''
Koç'ta Shiva, Rudra (fırtına tanrısı) olarak görülür. Saf ateş,
saf irade. Koç erkeğinde Shiva, savaşçı ve koruyucu olarak aktif.
Harekete geçen, yol açan, mücadele eden eril enerji.
''',
      balancePractice: '''
Koç'un ateşi, Su elementi ile dengelenir. Yengeç veya Balık
enerjisi getirecek pratikler: yüzme, duygusal ifade, empati
çalışması. Mars enerjisini Venüs ile yumuşat.
''',
      sacredUnionLesson: '''
Koç, bağımsızlık ve birliktelik arasındaki dengeyi öğrenir.
Partner ilişkisinde liderliği paylaşmayı, kontrol bırakmayı
öğrenmeli. "Ben" ve "biz" arasındaki dans.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Boğa',
      polarity: ZodiacPolarity.feminine,
      goddessArchetype: 'Lakshmi / Afrodit / Bereket Tanrıçası',
      godArchetype: 'Pan / Dionysos / Toprak Lordu',
      shaktiManifestation: '''
Boğa'da Shakti, bereket ve güzellik tanrıçasıdır. Lakshmi gibi
bolluk, konfor ve duygusal güvenlik sağlar. Boğa kadınında Shakti
duyusal, besleyici ve sadıktır. Toprak anası enerjisi güçlüdür.
''',
      shivaManifestation: '''
Boğa'da Shiva, toprakla bağlı, koruyucu güç olarak görülür.
Sağlayıcı, inşa edici, sabırlı. Boğa erkeğinde Shiva, güvenilir
ve somut. Maddi dünyada manifestasyon ustası.
''',
      balancePractice: '''
Boğa'nın ataleti, Ateş elementi ile dengelenir. Koç veya Aslan
enerjisi getirecek pratikler: fiziksel aktivite, risk alma,
spontanlık. Venüs'ü Mars ile harekete geçir.
''',
      sacredUnionLesson: '''
Boğa, sahiplenme ve özgürlük arasındaki dengeyi öğrenir.
Partneri tutmak ama boğmamak. Konfor zonundan çıkmaya
cesaret etmek. Değişimin güvenliği tehdit etmediğini görmek.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'İkizler',
      polarity: ZodiacPolarity.masculine,
      goddessArchetype: 'Saraswati / Hermes / İletişim Tanrıçası',
      godArchetype: 'Merkür / Thoth / Trickster',
      shaktiManifestation: '''
İkizler'de Shakti, bilgi ve iletişim tanrıçasıdır. Saraswati gibi
söz, yazı ve öğrenme ile ilişkili. İkizler kadınında Shakti
meraklı, çok yönlü ve zeki. Sosyal bağlantılar kurar.
''',
      shivaManifestation: '''
İkizler'de Shiva, Dakshinamurti'nin öğretmen yönü olarak görülür.
Bilgiyi aktaran, köprü kuran, bağlantı sağlayan. İkizler erkeğinde
Shiva, entelektüel ve iletişimci.
''',
      balancePractice: '''
İkizler'in dağınıklığı, Toprak elementi ile dengelenir. Başak
veya Oğlak enerjisi getirecek pratikler: odaklanma egzersizleri,
bir konuyu derinleştirme, topraklama.
''',
      sacredUnionLesson: '''
İkizler, yüzeysellik ve derinlik arasındaki dengeyi öğrenir.
Bir ilişkide kalmayı, derinleşmeyi, sıkılganlığı aşmayı öğrenmeli.
Söz ile eylem arasındaki tutarlılık.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Yengeç',
      polarity: ZodiacPolarity.feminine,
      goddessArchetype: 'Parvati / Demeter / Anne Tanrıça',
      godArchetype: 'Soma / Ay Lordu / Koruyucu Baba',
      shaktiManifestation: '''
Yengeç'te Shakti, anne tanrıça olarak tam gücündedir. Parvati
gibi besleyici, koruyucu ve ev yapıcı. Yengeç kadınında Shakti
anaç, empatik ve sezgisel. Duygusal derinlik taşır.
''',
      shivaManifestation: '''
Yengeç'te Shiva, koruyucu baba arketipidir. Gangadhara gibi
ailesini koruyan, yuvasını sağlayan. Yengeç erkeğinde Shiva,
duygusal zeka ve aile bağlılığı ile hareket eder.
''',
      balancePractice: '''
Yengeç'in aşırı duygusallığı, Hava elementi ile dengelenir.
Terazi veya Kova enerjisi getirecek pratikler: nesnellik,
duygusal mesafe, bağımsızlık çalışması.
''',
      sacredUnionLesson: '''
Yengeç, bağlanma ve bağımlılık arasındaki farkı öğrenir.
Partneri annelemeden sevmek. Kendi duygusal ihtiyaçlarını
karşılarken başkasına da alan bırakmak.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Aslan',
      polarity: ZodiacPolarity.masculine,
      goddessArchetype: 'Sekhmet / Lalita / Kraliçe',
      godArchetype: 'Surya / Apollo / Güneş Kral',
      shaktiManifestation: '''
Aslan'da Shakti, kraliçe arketipidir. Lalita'nın ihtişamı,
Sekhmet'in gücü. Aslan kadınında Shakti yaratıcı, dramatik
ve kalpten liderdir. Sahne ışıkları altında parlar.
''',
      shivaManifestation: '''
Aslan'da Shiva, Surya (Güneş tanrısı) olarak görülür. Merkezi
ışık, yaratıcı güç, liderlik. Aslan erkeğinde Shiva, cömert
ve koruyucu kral arketipidir.
''',
      balancePractice: '''
Aslan'ın egosu, Su elementi ile dengelenir. Akrep veya
Balık enerjisi getirecek pratikler: alçakgönüllülük, hizmet,
ego çalışması, başkalarının ışığına yer açma.
''',
      sacredUnionLesson: '''
Aslan, sahnenin ortasını paylaşmayı öğrenir. Partnerin
başarısını kıskanmadan kutlamak. Egodan aşka geçiş.
Dikkat ihtiyacını sağlıklı yollarla karşılamak.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Başak',
      polarity: ZodiacPolarity.feminine,
      goddessArchetype: 'Demeter / Vesta / Bakire Tanrıça',
      godArchetype: 'Chiron / Şifacı / Usta Zanaatkar',
      shaktiManifestation: '''
Başak'ta Shakti, kutsal bakire arketipidir - kendine ait,
bütün. Hizmet ve şifa yoluyla Shakti ifade edilir. Başak
kadınında Shakti pratik, mükemmeliyetçi ve şifacıdır.
''',
      shivaManifestation: '''
Başak'ta Shiva, Dakshinamurti'nin pratik bilgeliği olarak
görülür. Detaylara hakim, işine adanmış, mükemmellik arayan.
Başak erkeğinde Shiva, ustaca hizmet eder.
''',
      balancePractice: '''
Başak'ın aşırı eleştirelliği, Ateş elementi ile dengelenir.
Koç veya Yay enerjisi getirecek pratikler: spontanlık,
büyük resme bakma, mükemmeliyetçiliği bırakma.
''',
      sacredUnionLesson: '''
Başak, partneri "düzeltmekten" vazgeçmeyi öğrenir. Kabul
ve sevgi, eleştiri ile bir arada. Mükemmel olmayan ilişkide
mükemmel olmayı keşfetmek.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Terazi',
      polarity: ZodiacPolarity.masculine,
      goddessArchetype: 'Afrodit / Lakshmi / Güzellik Tanrıçası',
      godArchetype: 'Kamadeva / Eros / Aşk Lordu',
      shaktiManifestation: '''
Terazi'de Shakti, ilişki ve güzellik tanrıçasıdır. Harmonik
enerji, estetik duyarlılık, diplomatik zarafet. Terazi kadınında
Shakti çekici, dengeleyici ve ilişki odaklıdır.
''',
      shivaManifestation: '''
Terazi'de Shiva, Ardhanarishvara'nın denge arayan yönüdür.
Karşıtları birleştiren, adalet sağlayan, güzellik yaratan.
Terazi erkeğinde Shiva, romantik ve estetik.
''',
      balancePractice: '''
Terazi'nin kararsızlığı, Toprak elementi ile dengelenir.
Boğa veya Oğlak enerjisi getirecek pratikler: karar verme
cesareti, tek başına durmak, kendi merkezini bulmak.
''',
      sacredUnionLesson: '''
Terazi, kendini ilişki içinde kaybetmemeyı öğrenir. "Biz"
olurken "ben"i korumak. Kendi ihtiyaçlarını da görmek.
Çatışmadan kaçmak yerine sağlıklı ifade etmek.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Akrep',
      polarity: ZodiacPolarity.feminine,
      goddessArchetype: 'Kali / Persephone / Karanlık Tanrıça',
      godArchetype: 'Pluto / Yama / Ölüm ve Dönüşüm Lordu',
      shaktiManifestation: '''
Akrep'te Shakti, Kali'nin dönüştürücü gücüdür. Derinlere inen,
gizleri açığa çıkaran, yeniden doğuşu sağlayan. Akrep kadınında
Shakti yoğun, gizemli ve transformatiftir.
''',
      shivaManifestation: '''
Akrep'te Shiva, Bhairava'nın yoğun formu olarak görülür.
Karanlıkla yüzleşen, gölgeleri aydınlatan, ölüm-yeniden doğuş
döngüsünü yöneten. Akrep erkeğinde Shiva derinlikli ve güçlü.
''',
      balancePractice: '''
Akrep'in aşırı yoğunluğu, Hava elementi ile dengelenir.
İkizler veya Kova enerjisi getirecek pratikler: hafiflik,
mizah, obsesyondan kopuş, yüzeyde kalabilme.
''',
      sacredUnionLesson: '''
Akrep, kontrol ve güven arasındaki dengeyi öğrenir.
Partnerin sırlarını bilme ihtiyacını bırakmak. Kıskançlığı
sevgiye dönüştürmek. Yaralanabilirliğe izin vermek.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Yay',
      polarity: ZodiacPolarity.masculine,
      goddessArchetype: 'Artemis / Diana / Avcı Tanrıça',
      godArchetype: 'Jupiter / Zeus / Guru',
      shaktiManifestation: '''
Yay'da Shakti, özgür ruhlu tanrıçadır. Artemis gibi bağımsız,
doğayla bir, maceracı. Yay kadınında Shakti felsefi, idealist
ve sınır tanımaz. Hakikat arayışındadır.
''',
      shivaManifestation: '''
Yay'da Shiva, Dakshinamurti'nin bilgelik öğretmen formu olarak
görülür. Büyük resmi gören, anlam arayan, öğreten. Yay erkeğinde
Shiva, rehber ve vizyoner.
''',
      balancePractice: '''
Yay'ın aşırı idealizmi, Toprak elementi ile dengelenir.
Boğa veya Başak enerjisi getirecek pratikler: pratik adımlar,
detaylara dikkat, şimdiki anı yaşama.
''',
      sacredUnionLesson: '''
Yay, özgürlük ve bağlılık arasındaki dengeyi öğrenir.
İlişki kaçış değil, büyüme alanı olabilir. Partnere söz verip
tutmak. Kaçmak yerine derinleşmek.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Oğlak',
      polarity: ZodiacPolarity.feminine,
      goddessArchetype: 'Hera / Vesta / Otorite Tanrıçası',
      godArchetype: 'Satürn / Kronos / Zaman ve Yapı Lordu',
      shaktiManifestation: '''
Oğlak'ta Shakti, sorumlu otorite olarak tezahür eder. Yapı,
disiplin, hedef. Oğlak kadınında Shakti kariyer odaklı, hırslı
ve sınırları net. Ataerkil dünyada gezinme becerisi.
''',
      shivaManifestation: '''
Oğlak'ta Shiva, Mahakala (büyük zaman) formu olarak görülür.
Disiplin, yapı, otorite, zaman yönetimi. Oğlak erkeğinde
Shiva sorumlu, inşa edici ve kararlı.
''',
      balancePractice: '''
Oğlak'ın katılığı, Su elementi ile dengelenir. Yengeç veya
Balık enerjisi getirecek pratikler: duygusal ifade, oyun,
kontrolü bırakma, süreçten keyif alma.
''',
      sacredUnionLesson: '''
Oğlak, iş ve ilişki dengesini öğrenir. Partnere zaman ayırma,
duygusal erişilebilirlik. Başarının sevgiyi değiştirmeyeceğini
görmek. Kırılganlığa izin vermek.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Kova',
      polarity: ZodiacPolarity.masculine,
      goddessArchetype: 'Athena / Sophia / Bilgelik ve İnsanlık Tanrıçası',
      godArchetype: 'Uranus / Prometheus / Devrimci',
      shaktiManifestation: '''
Kova'da Shakti, kolektif bilinci taşıyan tanrıçadır. Toplum için
çalışan, yenilikçi, sıradışı. Kova kadınında Shakti bağımsız,
hümanist ve orijinal. Gelecek vizyoneri.
''',
      shivaManifestation: '''
Kova'da Shiva, Mahayogi'nin özgürleşmiş formu olarak görülür.
Sosyal normların ötesinde, bireysel özgürlük. Kova erkeğinde
Shiva devrimci, idealist ve özgün.
''',
      balancePractice: '''
Kova'nın mesafesi, Ateş elementi ile dengelenir. Aslan veya
Koç enerjisi getirecek pratikler: kişisel bağ, tutku, bireysel
ilişkilere yatırım.
''',
      sacredUnionLesson: '''
Kova, bireysel ve kolektif aşk arasındaki dengeyi öğrenir.
Özel birini seçmek, yakınlığa izin vermek. "Herkes için aşk"
yerine "bir kişi için derin bağ" yaşamak.
''',
    ),

    ZodiacDivineEnergy(
      zodiacSign: 'Balık',
      polarity: ZodiacPolarity.feminine,
      goddessArchetype: 'Kuan Yin / Maria / Merhamet Tanrıçası',
      godArchetype: 'Neptune / Poseidon / Okyanus Lordu',
      shaktiManifestation: '''
Balık'ta Shakti, evrensel sevgi ve merhamet olarak akar.
Sınırları eriten, birleştiren, iyileştiren. Balık kadınında
Shakti empatik, ruhani ve sanatçı. Kozmik alıcılık.
''',
      shivaManifestation: '''
Balık'ta Shiva, Vishnu'nun rüya hali gibi kozmik bilinçtir.
Sınırsız, formisiz, her şeyle bir. Balık erkeğinde Shiva
mistik, şair ve şifacı.
''',
      balancePractice: '''
Balık'ın sınırsızlığı, Toprak elementi ile dengelenir.
Başak veya Boğa enerjisi getirecek pratikler: sınır koyma,
pratik adımlar, ayakları yere basma.
''',
      sacredUnionLesson: '''
Balık, birleşme ve erime arasındaki farkı öğrenir.
Partnerde kaybolmadan sevmek. Kendi sınırlarını bilmek.
Kurban kompleksinden çıkmak. Sağlıklı bağlanma.
''',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // SACRED RITUALS
  // ══════════════════════════════════════════════════════════════════════════

  static const List<SacredRitual> sacredRituals = [
    SacredRitual(
      title: 'Dolunay Tanrıça Ritüeli',
      energyType: DivineEnergyType.shakti,
      moonPhase: 'Dolunay',
      purpose: '''
Dişil enerjinin doruk noktası olan Dolunay'da, Shakti'nin tüm
formlarını onurlandırma, dişil gücü kutlama, bereket ve bolluk
davet etme ritüeli.
''',
      items: [
        'Gümüş veya beyaz mum (Ay\'ı temsilen)',
        'Su kadehi (Shakti\'nin elementi)',
        'Beyaz veya gümüş çiçekler',
        'Ayna (Ay\'ın yansıması)',
        'Kadın sembolleri (yoni taşı, deniz kabuğu, vb.)',
        'Tütsü (yasemin, gül veya sandal)',
        'Meyve ve tatlılar (bereket sunusu)',
      ],
      steps: [
        'Ay ışığının görülebildiği bir yer seçin (tercihen dışarıda)',
        'Küçük bir altar oluşturun, nesneleri yerleştirin',
        'Mum ve tütsüyü yakın',
        'Gözlerinizi kapatın, Ay\'a dönerek üç derin nefes alın',
        'Shakti\'yi çağırın: "Ey İlahi Anne, ışığınla gel..."',
        'Ay\'a bakarak dileklerinizi söyleyin',
        'Su kadehini Ay\'a tutun, ışığını almasını sağlayın',
        'Bu "Ay suyu"nu için veya cildinize sürün',
        '"Om Shreem Chandrayai Namaha" mantrasını 27 kez tekrarlayın',
        'Sunularınızı bırakın, minnetle kapanış yapın',
      ],
      mantra: 'Om Shreem Chandrayai Namaha',
      duration: '30-45 dakika',
      closingPrayer: '''
Shakti Ana, Dolunayın ışığıyla beni kutsadın. Dişil gücümü
onurlandırıyorum, döngülerimi kabul ediyorum. Ayın her
evresinde seninleyim. Bereketin, bilgeliğin, güzelliğin için
şükürler. Om Shanti, Shanti, Shanti.
''',
    ),

    SacredRitual(
      title: 'Yeni Ay Shiva Meditasyonu',
      energyType: DivineEnergyType.shiva,
      moonPhase: 'Yeni Ay (Karanlık Ay)',
      purpose: '''
Karanlık Ay, iç görünün en güçlü olduğu zamandır. Shiva'nın
meditasyon ve sessizlik yönünü onurlandırma, içe dönme, yeniden
başlangıç için alan yaratma ritüeli.
''',
      items: [
        'Siyah veya lacivert mum',
        'Rudraksha mala (tesbih)',
        'Vibhuti (kutsal kül) veya beyaz sandal macunu',
        'Tütsü (sandal veya loban)',
        'Shiva imgesi veya Lingam',
        'Su kabı',
        'Bel yaprakları (varsa)',
      ],
      steps: [
        'Karanlık, sessiz bir yer seçin',
        'Kuzey veya Doğu\'ya dönün',
        'Mum ve tütsüyü yakın',
        'Vibhuti ile alnınıza üç çizgi çekin (tilak)',
        'Omurga dik, gözler kapalı oturun',
        'Shiva\'yı Kailash\'ta meditasyonda görselleştirin',
        '"Om Namah Shivaya" mantrasını mala ile 108 kez tekrarlayın',
        'Sessizliğe geçin, en az 11 dakika hiç düşünmeden kalın',
        'Bırakmak istediğiniz her şeyi zihnen Shiva\'ya verin',
        'Yavaşça gözleri açın, ritueli kapatın',
      ],
      mantra: 'Om Namah Shivaya',
      duration: '45-60 dakika',
      closingPrayer: '''
Mahadeva, karanlıkta senin ışığın. Sessizlikte senin mevcudiyetin.
Beni boşluğa, sıfır noktasına getirdin. Buradan yeni başlıyorum.
Artık olmayan her şey gitsin, yeni olan için yer açılsın.
Om Namah Shivaya. Har Har Mahadev.
''',
    ),

    SacredRitual(
      title: 'Shiva-Shakti Birlik Ritüeli',
      energyType: DivineEnergyType.union,
      moonPhase: 'Hilal Ay (büyüyen veya küçülen)',
      purpose: '''
İç eril ve dişil enerjilerin birleşmesi, Ardhanarishvara
bilincinin uyanması. Tek başına veya partnerle yapılabilir.
Dualiteden birliğe geçiş.
''',
      items: [
        'İki mum: biri altın/sarı (Shiva), biri gümüş/beyaz (Shakti)',
        'Üçüncü mor veya pembe mum (birlik)',
        'Shiva-Shakti veya Ardhanarishvara imgesi',
        'İki farklı tütsü (biri eril, biri dişil koku)',
        'Şarap veya meyve suyu (birlik içeceği)',
        'İç içe geçmiş halka veya düğüm sembolü',
      ],
      steps: [
        'Altar\'ın merkezine birlik imgesini koyun',
        'Sol tarafa gümüş mumu (Shakti), sağ tarafa altın mumu (Shiva) yerleştirin',
        'Her iki mumu da yakın',
        'Sol elinizi kalbe, sağ elinizi karnınıza koyun',
        'Nefes alırken "Shakti", verirken "Shiva" düşünün',
        'İki enerjiyi omurgada birleştirin',
        'Her iki mumdan üçüncü (birlik) mumunu yakın',
        'Partnerliyseniz, kadeh içeceği paylaşın',
        '"Om Ardhanareeshwaraaya Namaha" 54 kez',
        'Birlik hissini tüm bedene yayın',
        'Minnetle kapanış yapın',
      ],
      mantra: 'Om Ardhanareeshwaraaya Namaha',
      duration: '30-45 dakika',
      closingPrayer: '''
Ardhanarishvara, içimde birleştir. Erkek ve kadın, veren ve alan,
güç ve zarafet, bilinç ve enerji - hepsi bende bir. Ayrılık
illüzyonunu aşıyorum, birliğe uyanıyorum. Ben Shivayım, ben
Shaktiyim, ben birliğim. Om.
''',
    ),

    SacredRitual(
      title: 'Dişil Enerji Uyandırma Ritüeli',
      energyType: DivineEnergyType.shakti,
      moonPhase: 'Büyüyen Ay',
      purpose: '''
Bastırılmış veya uyuyan dişil enerjiyi uyandırma, Shakti'yi
aktive etme. Kadınlar ve erkekler için geçerlidir. İçteki
tanrıçayı çağırma.
''',
      items: [
        'Kırmızı veya pembe mum',
        'Gül suyu veya gül yağı',
        'Kırmızı çiçekler (gül, karanfil, hibiskus)',
        'Ayna (tercihen oval veya yuvarlak)',
        'Kırmızı veya pembe kumaş',
        'Kadın sembolü (yoni, deniz kabuğu, vb.)',
        'Şeker veya tatlı (Lalita sunusu)',
      ],
      steps: [
        'Pembe veya kırmızı giysiler giyin',
        'Yere kırmızı kumaş serin, üzerine oturun',
        'Çiçekleri etrafa yerleştirin, mumu yakın',
        'Gül suyunu bileğinize ve boynunuza sürün',
        'Aynaya bakın, gözlerinizin içinde tanrıçayı görün',
        '"Ben güzelim, ben güçlüyüm, ben Shakti\'yim" deyin',
        'Kalça daireler çizerek hafifçe sallanın',
        '"Om Aim Hreem Shreem" mantrasını tekrarlayın',
        'Shakti enerjisinin karnınızdan yükseldiğini hissedin',
        'Dans edin, özgürce hareket edin',
        'Şekerden tadın, tatlılığı kabul edin',
        'Minnetle kapanış yapın',
      ],
      mantra: 'Om Aim Hreem Shreem',
      duration: '30-45 dakika',
      closingPrayer: '''
Shakti Ana, bende uyan. Uyuyan tanrıça, gözlerini aç.
Güzelliğimi, gücümü, yaratıcılığımı kabul ediyorum.
Ben kadınım, ben Shakti'yim, ben yaşamın kaynağıyım.
Om Aim Hreem Shreem Namaha.
''',
    ),

    SacredRitual(
      title: 'Maskülen Enerji Güçlendirme Ritüeli',
      energyType: DivineEnergyType.shiva,
      moonPhase: 'Güneş doğarken veya öğlen',
      purpose: '''
Eril enerjiyi güçlendirme, iç savaşçıyı uyandırma, irade ve
kararlılık geliştirme. Erkekler ve kadınlar için geçerlidir.
İçteki Shiva'yı aktive etme.
''',
      items: [
        'Turuncu veya altın rengi mum',
        'Sandal veya sedir tütsüsü',
        'Rudraksha mala',
        'Shiva veya Lingam imgesi',
        'Bakır veya bronz kap (Güneş metali)',
        'Su (lingam yıkama için)',
        'Taze çiçekler (tercihen beyaz veya sarı)',
      ],
      steps: [
        'Güneş doğarken veya güçlü güneş ışığında başlayın',
        'Güneş\'e dönün, ayakta durun',
        'Omuzlarınızı geri çekin, göğsünüzü açın',
        'Güneş ışığını içinize çekin, güç hissedin',
        'Mum ve tütsüyü yakın',
        'Lingam varsa, su ile yıkayın (abhisheka)',
        'Rudraksha mala ile "Om Namah Shivaya" 108 kez',
        'Güç pozisyonları alın (ayaklar açık, eller kalçada)',
        '"Ben güçlüyüm, ben kararlıyım, ben Shiva\'yım" deyin',
        '10 dakika güçlü, ritmik nefes alın',
        'Bugünkü hedefinizi net olarak söyleyin',
        'Minnetle kapanış yapın',
      ],
      mantra: 'Om Namah Shivaya',
      duration: '20-30 dakika',
      closingPrayer: '''
Mahadeva, gücünle beni doldur. İrade kaslarımı güçlendir,
korkularımı yenmemi sağla. Ben savaşçıyım, ben koruyucuyum,
ben yapabilirim. Bugün hedeflerime ulaşmak için gerekli
güç ve kararlılık bende. Om Namah Shivaya. Har Har Mahadev.
''',
    ),

    SacredRitual(
      title: 'Maha Shivaratri Gece Uyanıklığı',
      energyType: DivineEnergyType.shiva,
      moonPhase: 'Phalguna ayının karanlık on dördüncü gecesi',
      purpose: '''
Yılın en kutsal Shiva gecesi olan Maha Shivaratri'de gece boyu
uyanık kalarak ibadet. Shiva'nın kozmik dansının en güçlü
olduğu gece. Karmanın eritilmesi, moksha (kurtuluş) yolu.
''',
      items: [
        'Shiva Lingam veya imgesi',
        'Süt, bal, yoğurt, şeker, ghee (panchamrita)',
        'Bel yaprakları (Bilva patra)',
        'Çiçekler, özellikle beyaz',
        'Sandal veya loban tütsüsü',
        'Rudraksha mala',
        'Su kabı (abhisheka için)',
        'Kandil veya mum',
        'Oruç yiyecekleri (meyve, süt)',
      ],
      steps: [
        'Gün batımında oruç tutmaya başlayın',
        'Banyo yapın, temiz beyaz giysiler giyin',
        'Altar hazırlayın, Lingam veya Shiva imgesini yerleştirin',
        'Gece boyunca dört prahar (3 saatlik bölümler) yapın',
        'Her prahar\'da Lingam\'a abhisheka (su, süt, bal dökme)',
        'Her seferinde bel yaprakları ve çiçek sunun',
        '"Om Namah Shivaya" mantrasını sürekli tekrarlayın',
        'Shiva hikayeleri okuyun veya dinleyin',
        'Meditasyon ve pranayama yapın',
        'Sabah güneş doğarken son abhisheka',
        'Orucu bozun, prasad (kutsanmış yiyecek) paylaşın',
      ],
      mantra: 'Om Namah Shivaya',
      duration: 'Tüm gece (12+ saat)',
      closingPrayer: '''
Mahadeva, bu kutsal gecede seninle uyandım. Karanlığın en
derin noktasında senin ışığını gördüm. Cehaletimin zehirini
iç, Neelakantha. Beni Mayadan kurtar, mokshaya götür.
Sonsuz Shiva, bu gece senin dansınla birlikte dans ettim.
Om Namah Shivaya. Har Har Mahadev. Boom Shankar.
''',
    ),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // VENUS-SHAKTI AND MARS-SHIVA CONNECTIONS
  // ══════════════════════════════════════════════════════════════════════════

  static const String venusShaktiConnection = '''
VENÜS VE ŞAKTİ - DİŞİL GEZEGENİN İLAHİ BAĞLANTISI

Astrolojide Venüs, dişil gezegen olarak Shakti enerjisinin
gökyüzündeki temsilcisidir. Aşk, güzellik, bereket, sanat ve
ilişkiler - tüm bunlar Venüs-Shakti alanına aittir.

Venüs'ün Shakti Boyutları:

1. LAKSHMI BOYUTU
Venüs Boğa ve Terazi'de evindedir. Burada Lakshmi enerjisi aktif:
• Maddi refah ve bereket
• Fiziksel güzellik ve çekicilik
• Konfor ve lüks
• İstikrar ve güvenlik
• Değer ve öz değer

2. LALITA BOYUTU
Venüs en yüksek noktasında (exaltation) Balık'tadır:
• Koşulsuz aşk
• Romantik idealizm
• Sanatsal ilham
• Mistik güzellik
• Ruhani aşk

3. SARASWATI BOYUTU
Venüs, sanat ve yaratıcılıkla ilişkili olduğunda:
• Müzik ve dans
• Görsel sanatlar
• Yazarlık ve şiir
• Estetik duyarlılık
• Kültürel incelik

4. PARVATI BOYUTU
Venüs, ilişki ve evlilik evlerinde:
• Romantik partnerlik
• Evlilik uyumu
• Sadakat ve bağlılık
• Duygusal bağlanma
• Aile bereketi

Doğum Haritasında Venüs:
Venüs'ün burcu, evi ve açıları, Shakti enerjinizin nasıl aktığını
gösterir. Güçlü Venüs, Shakti'ye kolay erişim sağlar. Zayıf veya
zorlu Venüs, Shakti'nin ifadesinde blokajlara işaret edebilir.

Venüs Transitlerinde Shakti:
Venüs geçişleri, Shakti enerjisinin aktive olduğu zamanları gösterir.
Venüs burca girdiğinde, o burcun Shakti kalitesi öne çıkar.
Venüs retrosu, iç dişil çalışma zamanıdır.
''';

  static const String marsShivaConnection = '''
MARS VE ŞİVA - ERİL GEZEGENİN İLAHİ BAĞLANTISI

Astrolojide Mars, eril gezegen olarak Shiva enerjisinin
gökyüzündeki temsilcisidir. Güç, irade, eylem, koruma ve
savaşçı ruh - tüm bunlar Mars-Shiva alanına aittir.

Mars'ın Shiva Boyutları:

1. RUDRA BOYUTU
Mars Koç ve Akrep'te evindedir. Burada Rudra enerjisi aktif:
• Ham güç ve irade
• Savaşçı ruh
• Cesaret ve korku yönetimi
• Koruyucu içgüdü
• Fiziksel enerji

2. BHAIRAVA BOYUTU
Mars zorlu açılar veya yoğun konumlarda:
• Dönüştürücü güç
• Karanlıkla yüzleşme
• Korku dönüşümü
• Sınırları koruma
• Radikal eylem

3. NATARAJA BOYUTU
Mars, yaratıcı ifade ile birleştiğinde:
• Dinamik eylem
• Ritimsel güç
• Enerji yönetimi
• Fiziksel ifade
• Dans ve hareket

4. MAHAYOGI BOYUTU
Mars, disiplin ve odaklanma gerektiren işlerde:
• İrade gücü
• Disiplin ve tapasya
• Hedef odaklılık
• Kararlılık
• Sebat

Doğum Haritasında Mars:
Mars'ın burcu, evi ve açıları, Shiva enerjinizin nasıl aktığını
gösterir. Güçlü Mars, Shiva'ya kolay erişim sağlar. Zayıf veya
zorlu Mars, eril gücün ifadesinde blokajlara işaret edebilir.

Mars Transitlerinde Shiva:
Mars geçişleri, Shiva enerjisinin aktive olduğu zamanları gösterir.
Mars burca girdiğinde, o burcun Shiva kalitesi öne çıkar.
Mars retrosu, iç savaşçı çalışma zamanıdır.
''';

  static const String moonNodesPolarity = '''
AY DÜĞÜMLERİ VE KUTUPLAŞMA

Ay'ın Kuzey Düğümü (Rahu) ve Güney Düğümü (Ketu), Shiva-Shakti
polaritesini karma ve dharma açısından temsil eder.

RAHU - SHAKTİ BOYUTU
Rahu, arzu, çoğaltma, genişleme ve dünyevi deneyim ister:
• Dişil çoğaltma enerjisi
• Maddi arzuların peşinden gitme
• Deneyim yoluyla öğrenme
• Maya (illüzyon) ile dans
• Dünyaya bağlanma

KETU - SHİVA BOYUTU
Ketu, bırakma, tecrit, ruhani arayış ve özgürleşme ister:
• Eril bırakma enerjisi
• Dünyevi bağlardan kopuş
• Moksha (kurtuluş) arzusu
• Maya'nın aşılması
• Aşkın bilinç

Düğümlerin Dengelenmesi:
Rahu ve Ketu her zaman karşı burçlardadır. Bu, hayatın temel
polaritesini gösterir: dünyaya bağlanmak mı (Rahu-Shakti) yoksa
ondan özgürleşmek mi (Ketu-Shiva)?

Tantrik Yol:
Tantra, bu polariteyi aşmayı öğretir. Ne sadece dünyaya bağlanma,
ne sadece dünyadan kaçış - her ikisini de içeren bilinç. Rahu'nun
arzularını Ketu'nun bilgeliği ile dengelemek, Shakti'nin coşkusunu
Shiva'nın farkındalığı ile birleştirmek.
''';

  // ══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ══════════════════════════════════════════════════════════════════════════

  static ShaktiProfile? getShaktiProfile(ShaktiForm form) {
    try {
      return shaktiProfiles.firstWhere((p) => p.form == form);
    } catch (_) {
      return null;
    }
  }

  static ShivaProfile? getShivaProfile(ShivaForm form) {
    try {
      return shivaProfiles.firstWhere((p) => p.form == form);
    } catch (_) {
      return null;
    }
  }

  static ZodiacDivineEnergy? getZodiacEnergy(String zodiacSign) {
    try {
      return zodiacDivineEnergies.firstWhere(
        (z) => z.zodiacSign.toLowerCase() == zodiacSign.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  static List<SacredRitual> getRitualsByEnergyType(DivineEnergyType type) {
    return sacredRituals.where((r) => r.energyType == type).toList();
  }

  static List<SacredRitual> getRitualsByMoonPhase(String moonPhase) {
    return sacredRituals
        .where(
          (r) => r.moonPhase.toLowerCase().contains(moonPhase.toLowerCase()),
        )
        .toList();
  }

  static EnergyImbalance? getImbalanceInfo(EnergyImbalanceType type) {
    try {
      return energyImbalances.firstWhere((i) => i.type == type);
    } catch (_) {
      return null;
    }
  }

  static List<SacredUnionPractice> getSoloPractices() {
    return sacredUnionPractices.where((p) => !p.requiresPartner).toList();
  }

  static List<SacredUnionPractice> getPartnerPractices() {
    return sacredUnionPractices.where((p) => p.requiresPartner).toList();
  }

  static DivineFeminineWisdom getDailyFeminineWisdom() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    return feminineWisdoms[dayOfYear % feminineWisdoms.length];
  }

  static DivineMasculineWisdom getDailyMasculineWisdom() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    return masculineWisdoms[dayOfYear % masculineWisdoms.length];
  }

  static String getEnergyBalanceAdvice({
    required bool hasStrongFeminine,
    required bool hasStrongMasculine,
  }) {
    if (hasStrongFeminine && hasStrongMasculine) {
      return '''
Enerjileriniz dengede görünüyor. Ardhanarishvara bilinci sizinle.
Hem almayı hem vermeyi, hem hissetmeyi hem eylemeyi biliyorsunuz.
Bu dengeyi korumak için günlük pratikler yapın.
''';
    } else if (hasStrongFeminine && !hasStrongMasculine) {
      return '''
Dişil enerjiniz güçlü ama eril enerji desteğe ihtiyaç duyuyor.
Shiva pratikleri ekleyin: disiplin, hedef belirleme, fiziksel güç.
Mars enerjisi ile çalışın, savaşçı arketipini uyandırın.
''';
    } else if (!hasStrongFeminine && hasStrongMasculine) {
      return '''
Eril enerjiniz güçlü ama dişil enerji desteğe ihtiyaç duyuyor.
Shakti pratikleri ekleyin: alıcılık, sezgi, döngüsellik.
Venüs ve Ay enerjisi ile çalışın, tanrıça arketipini uyandırın.
''';
    } else {
      return '''
Her iki enerji de güçlendirmeye ihtiyaç duyuyor.
Hem Shiva hem Shakti pratikleri ile başlayın.
Ardhanarishvara meditasyonu, her iki enerjiyi dengeli uyandırır.
''';
    }
  }
}
