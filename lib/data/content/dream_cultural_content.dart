/// Dream Cultural Content - Türk, İslami, Antik ve Dünya Kültürlerinden Rüya Yorumları
/// Kültürel perspektiflerden zengin rüya tabiri içeriği
library;

// ════════════════════════════════════════════════════════════════════════════
// TÜRK HALK TABİRİ
// ════════════════════════════════════════════════════════════════════════════

/// Anadolu halk kültüründen rüya tabirleri
class TurkHalkTabiri {
  static const String kulturelGiris =
      'Anadolu\'da rüya, "düş" veya "hayal" olarak adlandırılır. Halk arasında '
      '"seher vakti görülen rüya gerçek olur" inancı yaygındır. Rüyalar ya "hayra" '
      'ya da "şerre" yorumlanır.';

  /// Geleneksel sembol tabirleri
  static const Map<String, TurkishDreamSymbol> semboller = {
    'at': TurkishDreamSymbol(
      symbol: 'At',
      hayirliYorum: 'Kısmet, bereket, yolculuk, iyi haber gelecek',
      serrliYorum: 'At kişnerse kötü haber, at düşerse kayıp',
      halkInanci:
          'Halk inancında beyaz at görmek hayırlı sayılır, evlilik çağındaki kız için iyi kısmet işareti olarak yorumlanır',
      bolgeselFarklar: {
        'İç Anadolu': 'Bereket ve zenginlik müjdesi',
        'Karadeniz': 'Yolculuk ve ticaret',
        'Ege': 'Aşk ve evlilik',
      },
    ),
    'yilan': TurkishDreamSymbol(
      symbol: 'Yılan',
      hayirliYorum: 'Yılanı öldürmek düşmana galip gelmek',
      serrliYorum: 'Yılan sokarsa hastalık, kara yılan kötü düşman',
      halkInanci:
          'Ev yılanı "sahabi" sayılır, öldürülmez. Rüyada ev yılanı koruyucu',
      bolgeselFarklar: {
        'Güneydoğu': 'Yılan define işareti',
        'Akdeniz': 'Sağlık uyarısı',
        'Marmara': 'Gizli düşman',
      },
    ),
    'su': TurkishDreamSymbol(
      symbol: 'Su',
      hayirliYorum: 'Berrak su içmek ömür uzunluğu, su kenarı huzur',
      serrliYorum: 'Bulanık su sıkıntı, selde boğulmak borç',
      halkInanci:
          'Zemzem görmek hacca gitmek, pınar bulmak rızık kapısı açılır',
      bolgeselFarklar: {
        'Orta Anadolu': 'Bereket ve bolluk',
        'Doğu Anadolu': 'Gözyaşı ve hasret',
        'Ege': 'Şifa ve sağlık',
      },
    ),
    'ekmek': TurkishDreamSymbol(
      symbol: 'Ekmek',
      hayirliYorum: 'Ekmek yemek rızık bolluğu, ekmek dağıtmak sevap',
      serrliYorum: 'Bayat ekmek zorluk, ekmek çöpe atmak haram',
      halkInanci: 'Sıcak ekmek müjde, tandır ekmeği ev saadeti',
      bolgeselFarklar: {'Her yerde': 'Rızık ve bereket sembolü'},
    ),
    'altin': TurkishDreamSymbol(
      symbol: 'Altın',
      hayirliYorum: 'Altın bulmak zenginlik, takı takmak evlilik',
      serrliYorum: 'Altın kaybetmek zarar, sahte altın aldanmak',
      halkInanci: 'Altın bilezik evliliğe, altın yüzük nişana işaret',
      bolgeselFarklar: {
        'Trakya': 'Çeyiz ve düğün',
        'Güneydoğu': 'Ticaret kazancı',
        'Karadeniz': 'Madencilik, define',
      },
    ),
    'bebek': TurkishDreamSymbol(
      symbol: 'Bebek',
      hayirliYorum: 'Bebek görmek müjde, kız bebek bereket, erkek bebek güç',
      serrliYorum: 'Ağlayan bebek sıkıntı, hasta bebek endişe',
      halkInanci: 'Beşikte bebek görmek hamilelik, bebek emzirmek sadaka',
      bolgeselFarklar: {'Genel': 'Yeni başlangıç ve umut'},
    ),
    'olum': TurkishDreamSymbol(
      symbol: 'Ölüm/Ölü',
      hayirliYorum: 'Ölüyü güler görmek rahmete, ölüyle konuşmak dua istemek',
      serrliYorum: 'Ölü kızmışsa küs gitmek, ölü çağırıyorsa dikkat',
      halkInanci: 'Ölü bir şey verirse kabul etme. Ölüye dua okumalı.',
      bolgeselFarklar: {
        'Her yerde': 'Mevta ile rüya görülünce dua ve sadaka verilir',
      },
    ),
    'dugun': TurkishDreamSymbol(
      symbol: 'Düğün',
      hayirliYorum: 'Düğünde oynamak mutluluk, gelin olmak kısmet',
      serrliYorum: 'Düğünde ağlamak ters, düğün bozulursa hayal kırıklığı',
      halkInanci:
          'Kendi düğününü görmek evlilik yakın, başkasının düğünü sevinç',
      bolgeselFarklar: {'Her yerde': 'Aile birliği ve mutluluk'},
    ),
    'cami': TurkishDreamSymbol(
      symbol: 'Cami/Mescit',
      hayirliYorum: 'Camide namaz kılmak huzur, ezan duymak müjde',
      serrliYorum: 'Cami yıkılırsa fitne, camiye girememek günah',
      halkInanci: 'Camide cemaatle namaz topluluk bereketi',
      bolgeselFarklar: {'Her yerde': 'Spiritüel arınma ve huzur'},
    ),
    'deniz': TurkishDreamSymbol(
      symbol: 'Deniz',
      hayirliYorum: 'Sakin deniz huzur, denizde yüzmek başarı',
      serrliYorum: 'Dalgalı deniz sıkıntı, denizde boğulmak borç',
      halkInanci: 'Gemi ile denize açılmak büyük iş, balık tutmak kazanç',
      bolgeselFarklar: {
        'Akdeniz/Ege': 'Rızık ve ticaret',
        'Karadeniz': 'Gurbet ve yolculuk',
        'İç bölgeler': 'Bilinmezlik ve korku',
      },
    ),
  };

  /// Halk deyişleri ve inanışlar
  static const List<String> halkDeyisleri = [
    'Seher vakti görülen rüya gerçek olur',
    'Rüya görenin, düş yoranın',
    'Hayra yor, hayra çıksın',
    'Düş de gerçek, uyan da gerçek',
    'Kötü rüyayı anlatma, iyi rüyayı sakla',
    'Halk inancında: Cuma gecesi rüya gerçek olabilir denir',
    'Abdestli yatanın rüyası doğru olur',
    'Rüyanda gördüğün sana verilmiş haber',
    'Sağ yanına yatarsan hayır, sol yanına yatarsan şer görürsün',
    'Tok karnına yatma, kâbus görürsün',
  ];

  /// Rüya adabı (geleneksel)
  static const List<String> ruyaAdabi = [
    'Yatmadan önce abdest al',
    'Sağ yanına yat',
    'Ayete\'l-Kürsi oku',
    'İyi niyetle uyu',
    'Kötü rüya görürsen sol tarafına tükür ve "Euzubillah" de',
    'İyi rüyayı herkese anlatma, sadece güvendiğine söyle',
    'Kötü rüyayı kimseye anlatma, hayra yor',
    'Rüya görünce şükret',
  ];
}

class TurkishDreamSymbol {
  final String symbol;
  final String hayirliYorum;
  final String serrliYorum;
  final String halkInanci;
  final Map<String, String> bolgeselFarklar;

  const TurkishDreamSymbol({
    required this.symbol,
    required this.hayirliYorum,
    required this.serrliYorum,
    required this.halkInanci,
    required this.bolgeselFarklar,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// İSLAMİ RÜYA TABİRİ
// ════════════════════════════════════════════════════════════════════════════

/// İslami gelenekte rüya yorumu
class IslamiRuyaTabiri {
  static const String kulturelGiris =
      'İslam\'da rüya, "nübüvvetin kırk altıda biri" olarak kabul edilir. '
      'Hz. Yusuf\'un rüya tabiri yeteneği Kuran\'da anlatılır. Rüyalar üç kategoride '
      'değerlendirilir: Rahman\'dan (sadık rüya), Şeytan\'dan (karışık), Nefisten (günlük kaygılar).';

  /// Rüya türleri
  static const List<IslamicDreamType> ruyaTurleri = [
    IslamicDreamType(
      name: 'Sadık Rüya (Ru\'ya Sadıka)',
      source: 'Rahman\'dan',
      description:
          'Allah\'tan gelen gerçek rüyalar. Salih kimselerin ve peygamberlerin gördüğü rüyalar. '
          'Açık mesaj taşır, kalbi rahatlatır.',
      signs: [
        'Seher vaktine yakın görülür',
        'Kalbe huzur verir',
        'Açık ve net',
        'Salih kişilerce görülür',
        'İyiliğe teşvik eder',
      ],
    ),
    IslamicDreamType(
      name: 'Hulm (Karışık Rüya)',
      source: 'Şeytan\'dan',
      description:
          'Şeytanın vesvesesi ile görülen rüyalar. Korku, üzüntü ve karışıklık taşır. '
          'Önemsenmemeli, anlatılmamalı.',
      signs: [
        'Korku ve tedirginlik',
        'Mantıksız ve karışık',
        'Harama teşvik',
        'Kalbi daraltır',
        'Uyanınca rahatsızlık',
      ],
    ),
    IslamicDreamType(
      name: 'Hadis-i Nefs (Nefsin Rüyası)',
      source: 'Kişinin nefsi',
      description:
          'Günlük kaygılar, arzular ve düşüncelerden kaynaklanan rüyalar. '
          'Gündüz düşünülen şeylerin gece yansıması.',
      signs: [
        'Gündüz düşünülenler görülür',
        'Arzu ve korkular yansır',
        'Ne hayır ne şer',
        'Fizyolojik ihtiyaçlar (açlık, susuzluk)',
        'İş ve günlük meseleler',
      ],
    ),
  ];

  /// İslami sembol tabirleri
  static const Map<String, IslamicSymbolTabir> semboller = {
    'su': IslamicSymbolTabir(
      symbol: 'Su',
      tabirler: [
        'Berrak su içmek: İlim ve hikmet',
        'Akan su: Rızık ve bereket',
        'Durgun su: Fitne tehlikesi',
        'Zemzem: Hacca gitme, şifa',
        'Yağmur: Rahmet ve bereket',
      ],
      kuranReferansi: 'Her canlıyı sudan yarattık (Enbiya 30)',
      hadisReferansi: 'Su müminlerin hayat kaynağıdır',
    ),
    'nur': IslamicSymbolTabir(
      symbol: 'Nur/Işık',
      tabirler: [
        'Nur görmek: Hidayet ve iman',
        'Yüzde nur: Salih amel',
        'Karanlıktan aydınlığa: Tevbe',
        'Güneş: İlim, sultan, baba',
        'Ay: İlim, güzellik, kadın',
      ],
      kuranReferansi: 'Allah göklerin ve yerin nurudur (Nur 35)',
      hadisReferansi: 'Mümin nurla bakar',
    ),
    'namaz': IslamicSymbolTabir(
      symbol: 'Namaz',
      tabirler: [
        'Namazda olmak: Dua kabul',
        'Cemaatle namaz: Birlik ve bereket',
        'Namazı kaçırmak: İhmalkarlık uyarısı',
        'Camide namaz: Huzur ve güven',
        'Kıbleye dönmek: Doğru yol',
      ],
      kuranReferansi: 'Namazı dosdoğru kılın (Bakara 43)',
      hadisReferansi: 'Namaz dinin direğidir',
    ),
    'kuran': IslamicSymbolTabir(
      symbol: 'Kuran-ı Kerim',
      tabirler: [
        'Kuran okumak: Hikmet ve ilim',
        'Kuran hediye almak: Hayırlı haber',
        'Kuran taşımak: Emanet ve sorumluluk',
        'Kuran dinlemek: Hidayet',
        'Kuran ezberlemek: Yüksek derece',
      ],
      kuranReferansi: 'Kuran kalplere şifadır (İsra 82)',
      hadisReferansi: 'Kuran okuyana her harfe on sevap',
    ),
    'kabe': IslamicSymbolTabir(
      symbol: 'Kabe',
      tabirler: [
        'Kabe\'yi görmek: Hacca gitme',
        'Kabe\'yi tavaf: Günahlardan arınma',
        'Kabe\'ye girmek: Eman ve güvenlik',
        'Kabe yönüne dönmek: Tevbe',
        'Kabe örtüsüne dokunmak: Şeref ve itibar',
      ],
      kuranReferansi: 'İlk ev Mekke\'de kurulandır (Al-i İmran 96)',
      hadisReferansi: 'Kabe\'yi ziyaret günahları döker',
    ),
    'peygamber': IslamicSymbolTabir(
      symbol: 'Hz. Peygamber (SAV)',
      tabirler: [
        'Peygamberi görmek: Sadık rüya, müjde',
        'Peygamberle konuşmak: Büyük nimet',
        'Peygamberi güler görmek: Razı olunmuş',
        'Peygamberden bir şey almak: İlim ve hikmet',
        'Peygamberin arkasında namaz: Sünnet üzere olmak',
      ],
      kuranReferansi: 'Sen güzel bir örnek sun (Ahzab 21)',
      hadisReferansi: 'Beni rüyada gören gerçekten görmüştür',
    ),
    'cennet': IslamicSymbolTabir(
      symbol: 'Cennet',
      tabirler: [
        'Cennet görmek: Salih amel ve hüsnü hatime',
        'Cennete girmek: Rahmet ve mağfiret',
        'Cennet nehirleri: Sonsuz nimet',
        'Cennet meyveleri: Dünyada helal rızık',
        'Cennet köşkleri: Ahirette mükafat',
      ],
      kuranReferansi: 'Altından ırmaklar akan cennetler (Tevbe 72)',
      hadisReferansi: 'Cennet anaların ayakları altındadır',
    ),
    'melekler': IslamicSymbolTabir(
      symbol: 'Melekler',
      tabirler: [
        'Melek görmek: Hayır ve bereket',
        'Melekle konuşmak: İlham ve hidayet',
        'Cebrail: Vahiy, ilim, büyük haber',
        'Azrail: Ömür hatırlatması, tevbe',
        'Meleklerin inişi: Rahmet ve huzur',
      ],
      kuranReferansi: 'Melekler Rablerini hamd ile tesbih eder (Zümer 75)',
      hadisReferansi: 'Her insanın melekleri vardır',
    ),
  };

  /// Büyük İslam alimleri ve tabir yöntemleri
  static const List<IslamicScholar> alimler = [
    IslamicScholar(
      name: 'İbn-i Sirin',
      period: '654-728',
      contribution:
          'Rüya tabirinin en büyük otoritesi. "Tabirü\'l-Ru\'ya" eseri hâlâ başvuru kaynağı.',
      methodology: [
        'Rüya görenin durumunu öğren',
        'Sembolün Kuran\'daki karşılığını ara',
        'Hadislerde geçen yorumları incele',
        'Zamana ve şartlara göre yorumla',
      ],
    ),
    IslamicScholar(
      name: 'Nablusi',
      period: '1641-1731',
      contribution:
          'Tasavvufi bakış açısı. "Ta\'tiru\'l-Enam" eseri detaylı sembol sözlüğü.',
      methodology: [
        'Batıni (içsel) anlam ara',
        'Sembolün tasavvufi karşılığı',
        'Manevi hal ile ilişkilendir',
        'Rüya görenin makamını değerlendir',
      ],
    ),
    IslamicScholar(
      name: 'İmam Gazali',
      period: '1058-1111',
      contribution:
          'Rüyanın ruhani boyutunu açıkladı. Kalp temizliğinin önemi.',
      methodology: [
        'Kalp aynası ne kadar temiz?',
        'Rüya melekut aleminden yansıma',
        'Takvası yüksek olanın rüyası sadık',
        'Nefis terbiyesi ile rüya kalitesi artar',
      ],
    ),
  ];

  /// Rüya görme adabı (İslami)
  static const List<String> ruyaAdabi = [
    'Abdestli ve temiz yat',
    'Sağ yanına dön',
    'Uyumadan önce Ayetel Kürsi oku',
    'İhlas, Felak, Nas surelerini oku',
    'Salavat getir',
    'Kötü rüya görürsen sol tarafa tükür',
    '"Euzubillahimineşşeytanirracim" de',
    'Kötü rüyayı anlatma',
    'İyi rüyayı sadece güvendiğine anlat',
    'Rüyadan sonra şükret ve dua et',
  ];
}

class IslamicDreamType {
  final String name;
  final String source;
  final String description;
  final List<String> signs;

  const IslamicDreamType({
    required this.name,
    required this.source,
    required this.description,
    required this.signs,
  });
}

class IslamicSymbolTabir {
  final String symbol;
  final List<String> tabirler;
  final String kuranReferansi;
  final String hadisReferansi;

  const IslamicSymbolTabir({
    required this.symbol,
    required this.tabirler,
    required this.kuranReferansi,
    required this.hadisReferansi,
  });
}

class IslamicScholar {
  final String name;
  final String period;
  final String contribution;
  final List<String> methodology;

  const IslamicScholar({
    required this.name,
    required this.period,
    required this.contribution,
    required this.methodology,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// ANTİK MISIR RÜYA GELENEĞİ
// ════════════════════════════════════════════════════════════════════════════

/// Antik Mısır rüya yorumu
class AntikMisirRuyaTabiri {
  static const String kulturelGiris =
      'Antik Mısır\'da rüyalar tanrıların mesajları olarak görülürdü. '
      'Tapınaklarda "incubation" ritüeli uygulanır, şifacı rüyalar için '
      'özel odalarda yatılırdı. Chester Beatty Papirüsü en eski rüya kitabıdır.';

  /// Mısır sembolleri
  static const Map<String, EgyptianDreamSymbol> semboller = {
    'nil': EgyptianDreamSymbol(
      symbol: 'Nil Nehri',
      meaning:
          'Hayat, bereket, yenilenme. Taşan Nil bolluk, kuruyan Nil kıtlık.',
      deity: 'Hapi - Nil tanrısı',
      ritual: 'Nil\'e adaklar sunulurdu',
    ),
    'gunes': EgyptianDreamSymbol(
      symbol: 'Güneş/Ra',
      meaning:
          'Hayat gücü, kral otoritesi, adalet. Doğan güneş yeni başlangıç.',
      deity: 'Ra - Güneş tanrısı',
      ritual: 'Güneşin doğuşuna ibadet',
    ),
    'skarab': EgyptianDreamSymbol(
      symbol: 'Skarab Böceği',
      meaning: 'Yeniden doğuş, dönüşüm, sabah güneşi. Koruyucu tılsım.',
      deity: 'Khepri - Sabah güneşi',
      ritual: 'Skarab muskası taşınırdı',
    ),
    'ankh': EgyptianDreamSymbol(
      symbol: 'Ankh (Yaşam Anahtarı)',
      meaning: 'Sonsuz yaşam, ölümsüzlük, ilahi koruma.',
      deity: 'Tüm tanrılar taşır',
      ritual: 'Mumyalama ritüelinde kullanılır',
    ),
    'yilan': EgyptianDreamSymbol(
      symbol: 'Kobra (Uraeus)',
      meaning: 'Kraliyet gücü, koruma, bilgelik. Firavunun tacında.',
      deity: 'Wadjet - Kobra tanrıçası',
      ritual: 'Kraliyet koruması',
    ),
    'ibis': EgyptianDreamSymbol(
      symbol: 'İbis Kuşu',
      meaning: 'Bilgelik, yazı, ay. Thoth\'un kutsal hayvanı.',
      deity: 'Thoth - Bilgelik tanrısı',
      ritual: 'Yazıcılar ibis\'e dua ederdi',
    ),
    'kedi': EgyptianDreamSymbol(
      symbol: 'Kedi',
      meaning: 'Ev koruması, doğurganlık, gece bilgeliği.',
      deity: 'Bastet - Kedi tanrıçası',
      ritual: 'Kediler kutsaldı, mumyalanırdı',
    ),
    'lotus': EgyptianDreamSymbol(
      symbol: 'Lotus Çiçeği',
      meaning: 'Yaratılış, yeniden doğuş, güneşin doğuşu.',
      deity: 'Nefertem - Lotus tanrısı',
      ritual: 'Tapınaklarda lotus adakları',
    ),
  };

  /// Incubation ritüeli
  static const IncubationRitual inkubasyon = IncubationRitual(
    description:
        'Şifacı veya kehanet rüyası almak için tapınakta özel odada yatma geleneği.',
    steps: [
      'Arınma ritüeli (yıkanma, oruç)',
      'Tanrıya dua ve adak',
      'Kutsal odada uyuma',
      'Sabah rahibe rüya anlatma',
      'Rahibin yorumu alma',
    ],
    famousTemples: [
      'Serapis Tapınağı (Şifa rüyaları)',
      'Imhotep Tapınağı (Tıbbi rüyalar)',
      'İsis Tapınağı (Kehanet)',
    ],
  );
}

class EgyptianDreamSymbol {
  final String symbol;
  final String meaning;
  final String deity;
  final String ritual;

  const EgyptianDreamSymbol({
    required this.symbol,
    required this.meaning,
    required this.deity,
    required this.ritual,
  });
}

class IncubationRitual {
  final String description;
  final List<String> steps;
  final List<String> famousTemples;

  const IncubationRitual({
    required this.description,
    required this.steps,
    required this.famousTemples,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// ANTİK YUNAN RÜYA GELENEĞİ
// ════════════════════════════════════════════════════════════════════════════

/// Antik Yunan rüya yorumu
class AntikYunanRuyaTabiri {
  static const String kulturelGiris =
      'Antik Yunan\'da rüyalar "Oneiroi" - uykunun çocukları olarak kişileştirilirdi. '
      'Morpheus şekil veren tanrıydı. Artemidoros\'un Oneirocritica\'sı '
      'sistematik rüya yorumunun ilk kitabıdır.';

  /// Yunan rüya tanrıları
  static const List<GreekDreamDeity> tanrilar = [
    GreekDreamDeity(
      name: 'Morpheus',
      domain: 'İnsan formunda rüyalar',
      description:
          'Uyku tanrısı Hypnos\'un oğlu. İnsanların rüyalarına şekil verir.',
      symbolism: 'Dönüşüm, şekil değiştirme, illüzyon',
    ),
    GreekDreamDeity(
      name: 'Phobetor',
      domain: 'Korkutucu rüyalar (kâbuslar)',
      description: 'Hayvan ve canavar formunda rüyalar gönderir.',
      symbolism: 'Korku, yüzleşme, gölge',
    ),
    GreekDreamDeity(
      name: 'Phantasos',
      domain: 'Cansız nesnelerin rüyaları',
      description: 'Doğa, nesneler ve soyut formlar.',
      symbolism: 'Hayal gücü, yaratıcılık',
    ),
    GreekDreamDeity(
      name: 'Hypnos',
      domain: 'Uyku',
      description: 'Rüya tanrılarının babası. Gece tanrıçası Nyx\'in oğlu.',
      symbolism: 'Bilinçdışı, dinlenme, geçiş',
    ),
  ];

  /// Artemidoros\'un yöntemi
  static const ArtemidorosMethod artemidorosYontemi = ArtemidorosMethod(
    principles: [
      'Rüya görenin mesleğini öğren',
      'Sosyal statüsünü değerlendir',
      'Cinsiyete göre yorumla',
      'Yaşa göre anlam değişir',
      'Kültürel bağlamı unutma',
    ],
    categories: ['Teorematik (doğrudan anlam)', 'Alegorik (sembolik anlam)'],
    famousInterpretations: [
      'Aslan görmek: Güç sahibi ile karşılaşma',
      'Uçmak: Kölelere özgürlük, tüccarlara kar',
      'Diş dökülmesi: Yakın kaybı (üst dişler üst kuşak)',
      'Ateş: Tehlike ama bazen bereket',
    ],
  );

  /// Yunan sembolleri
  static const Map<String, GreekDreamSymbol> semboller = {
    'zeus': GreekDreamSymbol(
      symbol: 'Zeus/Şimşek',
      meaning: 'Otorite, ilahi irade, ani değişim',
      mythReference: 'Zeus\'un gücü ve adaleti',
    ),
    'athena': GreekDreamSymbol(
      symbol: 'Baykuş/Athena',
      meaning: 'Bilgelik, strateji, el sanatları',
      mythReference: 'Athena\'nın kutsal hayvanı',
    ),
    'apollon': GreekDreamSymbol(
      symbol: 'Güneş/Defne',
      meaning: 'Kehanet, şifa, müzik, aydınlanma',
      mythReference: 'Apollon\'un Delphi tapınağı',
    ),
    'labirent': GreekDreamSymbol(
      symbol: 'Labirent',
      meaning: 'Karmaşık problem, iç yolculuk, Minotaur ile yüzleşme',
      mythReference: 'Girit labirenti ve Theseus',
    ),
    'phoenix': GreekDreamSymbol(
      symbol: 'Anka Kuşu',
      meaning: 'Ölümden yeniden doğuş, dönüşüm, ölümsüzlük',
      mythReference: 'Küllerinden doğan kuş',
    ),
  };
}

class GreekDreamDeity {
  final String name;
  final String domain;
  final String description;
  final String symbolism;

  const GreekDreamDeity({
    required this.name,
    required this.domain,
    required this.description,
    required this.symbolism,
  });
}

class ArtemidorosMethod {
  final List<String> principles;
  final List<String> categories;
  final List<String> famousInterpretations;

  const ArtemidorosMethod({
    required this.principles,
    required this.categories,
    required this.famousInterpretations,
  });
}

class GreekDreamSymbol {
  final String symbol;
  final String meaning;
  final String mythReference;

  const GreekDreamSymbol({
    required this.symbol,
    required this.meaning,
    required this.mythReference,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// HİNT/VEDİK RÜYA GELENEĞİ
// ════════════════════════════════════════════════════════════════════════════

/// Hint/Vedik rüya yorumu
class VedikRuyaTabiri {
  static const String kulturelGiris =
      'Vedik gelenekte rüyalar bilinç durumlarından biridir (Svapna). '
      'Upanişadlar\'da dört bilinç durumu tanımlanır: uyanıklık (Jagrat), '
      'rüya (Svapna), derin uyku (Sushupti), ve aşkın (Turiya).';

  /// Bilinç durumları
  static const List<ConsciousnessState> bilincDurumlari = [
    ConsciousnessState(
      name: 'Jagrat (Uyanıklık)',
      description: 'Dış dünyaya yönelik, duyular aktif',
      symbol: 'A (AUM\'un ilk harfi)',
      quality: 'Fiziksel farkındalık',
    ),
    ConsciousnessState(
      name: 'Svapna (Rüya)',
      description: 'İç dünyaya yönelik, zihin aktif',
      symbol: 'U (AUM\'un ikinci harfi)',
      quality: 'Astral/zihinsel farkındalık',
    ),
    ConsciousnessState(
      name: 'Sushupti (Derin Uyku)',
      description: 'Farkındalık olmadan varlık',
      symbol: 'M (AUM\'un üçüncü harfi)',
      quality: 'Nedensel farkındalık',
    ),
    ConsciousnessState(
      name: 'Turiya (Aşkın)',
      description: 'Saf bilinç, tüm durumları aşar',
      symbol: 'Sessizlik (AUM\'dan sonra)',
      quality: 'Mutlak farkındalık',
    ),
  ];

  /// Hint sembolleri
  static const Map<String, VedicDreamSymbol> semboller = {
    'lotus': VedicDreamSymbol(
      symbol: 'Lotus',
      meaning: 'Spiritüel uyanış, çakra açılması, aydınlanma',
      chakra: 'Sahasrara (Taç Çakra)',
      mantra: 'OM',
    ),
    'yilan': VedicDreamSymbol(
      symbol: 'Yılan/Kobra',
      meaning: 'Kundalini enerjisi, dönüşüm, bilgelik',
      chakra: 'Muladhara (Kök Çakra)',
      mantra: 'LAM',
    ),
    'fil': VedicDreamSymbol(
      symbol: 'Fil (Ganesha)',
      meaning: 'Engellerin kaldırılması, bilgelik, yeni başlangıç',
      chakra: 'Muladhara',
      mantra: 'OM GAM GANAPATAYE NAMAHA',
    ),
    'maymun': VedicDreamSymbol(
      symbol: 'Maymun (Hanuman)',
      meaning: 'Bağlılık, güç, hizmet',
      chakra: 'Anahata (Kalp Çakra)',
      mantra: 'OM HUM HANUMATE NAMAHA',
    ),
    'ates': VedicDreamSymbol(
      symbol: 'Ateş (Agni)',
      meaning: 'Dönüşüm, arınma, yaratıcı güç',
      chakra: 'Manipura (Solar Pleksus)',
      mantra: 'RAM',
    ),
    'gunes': VedicDreamSymbol(
      symbol: 'Güneş (Surya)',
      meaning: 'Atman (öz), aydınlanma, sağlık',
      chakra: 'Ajna (Üçüncü Göz)',
      mantra: 'OM SURYAYA NAMAHA',
    ),
  };

  /// Yoga Nidra ve rüya
  static const YogaNidra yogaNidra = YogaNidra(
    description:
        'Bilinçli uyku tekniği. Uyanıklık ve uyku arasındaki eşikte kalarak '
        'bilinçaltına erişim.',
    benefits: [
      'Lucid rüya kapasitesi artışı',
      'Bilinçaltı programlama',
      'Derin dinlenme',
      'Rüya hatırlama gelişimi',
    ],
    practice: [
      'Shavasana pozisyonunda yat',
      'Sankalpa (niyet) belirle',
      'Bedensel farkındalık taraması',
      'Nefes farkındalığı',
      'Zıt duyum çalışması',
      'Görselleştirme',
      'Sankalpa tekrarı',
    ],
  );
}

class ConsciousnessState {
  final String name;
  final String description;
  final String symbol;
  final String quality;

  const ConsciousnessState({
    required this.name,
    required this.description,
    required this.symbol,
    required this.quality,
  });
}

class VedicDreamSymbol {
  final String symbol;
  final String meaning;
  final String chakra;
  final String mantra;

  const VedicDreamSymbol({
    required this.symbol,
    required this.meaning,
    required this.chakra,
    required this.mantra,
  });
}

class YogaNidra {
  final String description;
  final List<String> benefits;
  final List<String> practice;

  const YogaNidra({
    required this.description,
    required this.benefits,
    required this.practice,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// ŞAMANİK RÜYA GELENEĞİ
// ════════════════════════════════════════════════════════════════════════════

/// Şamanik rüya yorumu
class SamanikRuyaTabiri {
  static const String kulturelGiris =
      'Şamanizmde rüya, ruhun gece yolculuğudur. Şaman rüya yoluyla '
      'diğer alemlere seyahat eder, ruhlarla iletişim kurar, şifa ve bilgi alır.';

  /// Rüya türleri (Şamanik)
  static const List<ShamanicDreamType> ruyaTurleri = [
    ShamanicDreamType(
      name: 'Güç Hayvanı Rüyası',
      description: 'Ruhani koruyucu ve rehber ile karşılaşma',
      significance: 'Hayatın her alanında güç ve rehberlik',
      howToWork: 'Hayvana saygı göster, ondan öğren, onun gibi hareket et',
    ),
    ShamanicDreamType(
      name: 'Ata Ruhları Rüyası',
      description: 'Ölmüş atalarla karşılaşma',
      significance: 'Bilgelik, koruma, aile mirası',
      howToWork: 'Mesajlarını dinle, onlara saygı göster, ritüel yap',
    ),
    ShamanicDreamType(
      name: 'Şifa Rüyası',
      description: 'Hastalığın kaynağı ve tedavisi gösterilir',
      significance: 'Fiziksel, duygusal veya ruhani şifa',
      howToWork: 'Rüyada gösterilen şifayı uyanıkken uygula',
    ),
    ShamanicDreamType(
      name: 'Kehanet Rüyası',
      description: 'Gelecek olayların önceden görülmesi',
      significance: 'Uyarı, hazırlık, rehberlik',
      howToWork: 'Sembolleri dikkatlice yorumla, hazırlıklı ol',
    ),
    ShamanicDreamType(
      name: 'İnisiyasyon Rüyası',
      description: 'Ruhani ölüm ve yeniden doğuş',
      significance: 'Şaman olma çağrısı, büyük dönüşüm',
      howToWork: 'Bir üstat bul, eğitime başla, korkmadan kabul et',
    ),
  ];

  /// Güç hayvanları
  static const Map<String, PowerAnimal> gucHayvanlari = {
    'kurt': PowerAnimal(
      animal: 'Kurt',
      qualities: ['Sadakat', 'İçgüdü', 'Özgürlük', 'Öğretmenlik'],
      teachings: 'Sürü bilinci, liderlik, vahşi doğanla bağlantı',
      element: 'Toprak/Ay',
    ),
    'kartal': PowerAnimal(
      animal: 'Kartal',
      qualities: ['Görüş', 'Özgürlük', 'İlahi bağlantı', 'Cesaret'],
      teachings: 'Yüksek perspektif, spiritüel görüş, güneşe bakabilmek',
      element: 'Hava/Güneş',
    ),
    'ayi': PowerAnimal(
      animal: 'Ayı',
      qualities: ['İçe dönüş', 'Şifa', 'Koruma', 'Döngüsel bilgelik'],
      teachings: 'Kış uykusu bilgeliği, şifacılık, anne enerjisi',
      element: 'Toprak',
    ),
    'yilan': PowerAnimal(
      animal: 'Yılan',
      qualities: ['Dönüşüm', 'Şifa', 'Bilgelik', 'Yenilenme'],
      teachings: 'Deri değiştirme, kundalini, yeraltı bilgeliği',
      element: 'Ateş/Toprak',
    ),
    'baykus': PowerAnimal(
      animal: 'Baykuş',
      qualities: ['Gece görüşü', 'Bilgelik', 'Gizem', 'Ölüm/Yeniden doğuş'],
      teachings: 'Karanlıkta görmek, gizli bilgi, sessiz uçuş',
      element: 'Hava/Gece',
    ),
    'geyik': PowerAnimal(
      animal: 'Geyik',
      qualities: ['Naziklik', 'Sezgi', 'Yenilenme', 'Doğa bağlantısı'],
      teachings: 'Orman bilgeliği, boynuz döngüsü, şefkat',
      element: 'Toprak/Orman',
    ),
  };

  /// Üst-Orta-Alt dünyalar
  static const ShamanicWorlds dunya = ShamanicWorlds(
    upperWorld: WorldDescription(
      name: 'Üst Dünya',
      description: 'Göksel alemler, yüksek ruhlar, öğretmenler',
      symbols: ['Gökyüzü', 'Bulutlar', 'Dağ tepesi', 'Yıldızlar', 'Kartal'],
      purpose: 'İlham, rehberlik, spiritüel öğretiler',
    ),
    middleWorld: WorldDescription(
      name: 'Orta Dünya',
      description: 'Fiziksel dünyanın ruhani boyutu',
      symbols: ['Orman', 'Göl', 'Mağara girişi', 'Ağaç', 'Hayvanlar'],
      purpose: 'Günlük yaşam rehberliği, doğa ruhları ile iletişim',
    ),
    lowerWorld: WorldDescription(
      name: 'Alt Dünya',
      description: 'Yeraltı alemleri, ata ruhları, güç hayvanları',
      symbols: ['Mağara', 'Tünel', 'Kök', 'Yeraltı suları', 'Kemikler'],
      purpose: 'Güç hayvanı bulma, şifa, ata bilgeliği',
    ),
  );
}

class ShamanicDreamType {
  final String name;
  final String description;
  final String significance;
  final String howToWork;

  const ShamanicDreamType({
    required this.name,
    required this.description,
    required this.significance,
    required this.howToWork,
  });
}

class PowerAnimal {
  final String animal;
  final List<String> qualities;
  final String teachings;
  final String element;

  const PowerAnimal({
    required this.animal,
    required this.qualities,
    required this.teachings,
    required this.element,
  });
}

class ShamanicWorlds {
  final WorldDescription upperWorld;
  final WorldDescription middleWorld;
  final WorldDescription lowerWorld;

  const ShamanicWorlds({
    required this.upperWorld,
    required this.middleWorld,
    required this.lowerWorld,
  });
}

class WorldDescription {
  final String name;
  final String description;
  final List<String> symbols;
  final String purpose;

  const WorldDescription({
    required this.name,
    required this.description,
    required this.symbols,
    required this.purpose,
  });
}
