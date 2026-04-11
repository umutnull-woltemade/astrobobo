/// Transit Mega Content - Gezegen Transitlerinin Derinlemesine Yorumları
/// Her gezegen kombinasyonu için kapsamlı transit yorumları
library;

// ════════════════════════════════════════════════════════════════════════════
// TRANSİT TEMELLERİ
// ════════════════════════════════════════════════════════════════════════════

/// Transit türleri ve önemi
class TransitFundamentals {
  static const String introduction = '''
Transitler, gökyüzündeki gezegenlerin doğum haritanızdaki noktalara yaptığı
açılardır. Her transit belirli bir enerji, tema ve zamanlama taşır.

Hızlı gezegenler (Ay, Merkür, Venüs, Güneş) günlük/haftalık etkiler yaratır.
Orta hızlı gezegenler (Mars, Jüpiter, Satürn) aylık/yıllık temalar getirir.
Yavaş gezegenler (Uranüs, Neptün, Plüton) nesil dönüştürücü etkiler bırakır.
''';

  static const Map<String, TransitType> transitTurleri = {
    'conjunction': TransitType(
      name: 'Kavuşum (0°)',
      symbol: '☌',
      nature: 'Güçlü, başlangıç',
      orb: 8.0,
      description: 'İki enerji birleşir. Yeni döngü başlar. Yoğun ve odaklı.',
      keywords: ['Başlangıç', 'Birleşme', 'Yoğunlaşma', 'Fokus'],
    ),
    'sextile': TransitType(
      name: 'Altmışlık (60°)',
      symbol: '⚹',
      nature: 'Uyumlu, fırsat',
      orb: 4.0,
      description:
          'Enerjiler uyumlu akar. Fırsatlar sunar ama eylem gerektirir.',
      keywords: ['Fırsat', 'Kolaylık', 'Destek', 'İşbirliği'],
    ),
    'square': TransitType(
      name: 'Kare (90°)',
      symbol: '□',
      nature: 'Gerilim, mücadele',
      orb: 8.0,
      description:
          'Çatışma ve gerilim. Zorlu ama büyüme getirir. Eylem zorlar.',
      keywords: ['Gerilim', 'Mücadele', 'Büyüme', 'Kriz'],
    ),
    'trine': TransitType(
      name: 'Üçgen (120°)',
      symbol: '△',
      nature: 'Uyumlu, akış',
      orb: 8.0,
      description: 'Doğal uyum ve akış. Yetenekler kolayca ifade bulur.',
      keywords: ['Uyum', 'Kolaylık', 'Şans', 'Akış'],
    ),
    'opposition': TransitType(
      name: 'Karşıt (180°)',
      symbol: '☍',
      nature: 'Gerilim, farkındalık',
      orb: 8.0,
      description:
          'Zıtlıklar yüzleşir. İlişki ve denge konuları. Farkındalık getirir.',
      keywords: ['Yüzleşme', 'Denge', 'İlişki', 'Farkındalık'],
    ),
  };

  static const Map<String, PlanetSpeed> gezegenHizlari = {
    'moon': PlanetSpeed(
      planet: 'Ay',
      orbitTime: '28 gün',
      transitDuration: '2-3 gün/burç',
      importance: 'Günlük ruh hali, anlık tepkiler',
    ),
    'mercury': PlanetSpeed(
      planet: 'Merkür',
      orbitTime: '88 gün',
      transitDuration: '2-3 hafta/burç',
      importance: 'İletişim, düşünce, kısa yolculuklar',
    ),
    'venus': PlanetSpeed(
      planet: 'Venüs',
      orbitTime: '225 gün',
      transitDuration: '3-4 hafta/burç',
      importance: 'İlişkiler, para, zevkler',
    ),
    'sun': PlanetSpeed(
      planet: 'Güneş',
      orbitTime: '365 gün',
      transitDuration: '1 ay/burç',
      importance: 'Kimlik, enerji, odak',
    ),
    'mars': PlanetSpeed(
      planet: 'Mars',
      orbitTime: '2 yıl',
      transitDuration: '6-7 hafta/burç',
      importance: 'Eylem, enerji, motivasyon, çatışma',
    ),
    'jupiter': PlanetSpeed(
      planet: 'Jüpiter',
      orbitTime: '12 yıl',
      transitDuration: '1 yıl/burç',
      importance: 'Genişleme, şans, büyüme, felsefe',
    ),
    'saturn': PlanetSpeed(
      planet: 'Satürn',
      orbitTime: '29 yıl',
      transitDuration: '2.5 yıl/burç',
      importance: 'Yapı, sorumluluk, sınırlar, olgunlaşma',
    ),
    'uranus': PlanetSpeed(
      planet: 'Uranüs',
      orbitTime: '84 yıl',
      transitDuration: '7 yıl/burç',
      importance: 'Devrim, özgürlük, beklenmedik değişim',
    ),
    'neptune': PlanetSpeed(
      planet: 'Neptün',
      orbitTime: '165 yıl',
      transitDuration: '14 yıl/burç',
      importance: 'Rüyalar, spiritüellik, illüzyon, çözülme',
    ),
    'pluto': PlanetSpeed(
      planet: 'Plüton',
      orbitTime: '248 yıl',
      transitDuration: '12-30 yıl/burç',
      importance: 'Dönüşüm, ölüm/yeniden doğuş, güç',
    ),
  };
}

class TransitType {
  final String name;
  final String symbol;
  final String nature;
  final double orb;
  final String description;
  final List<String> keywords;

  const TransitType({
    required this.name,
    required this.symbol,
    required this.nature,
    required this.orb,
    required this.description,
    required this.keywords,
  });
}

class PlanetSpeed {
  final String planet;
  final String orbitTime;
  final String transitDuration;
  final String importance;

  const PlanetSpeed({
    required this.planet,
    required this.orbitTime,
    required this.transitDuration,
    required this.importance,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// SATÜRN TRANSİTLERİ - HAYATIN ÖĞRETMENİ
// ════════════════════════════════════════════════════════════════════════════

class SaturnTransits {
  static const String introduction = '''
Satürn, zodyakın büyük öğretmeni ve sınırlayıcısıdır. Transitlerinde
"ne ekersen onu biçersin" prensibi işler. Çalışma, disiplin ve sorumluluk getirir.
Zorlu ama gerekli dersler öğretir. Her şeyi sınar ama geçenleri ödüllendirir.
''';

  static const Map<String, SaturnTransitToNatal> toNatalPlanets = {
    'saturn_sun': SaturnTransitToNatal(
      transit: 'Satürn - Güneş',
      conjunctionEffect: TransitEffect(
        duration: '1-2 hafta (exact)',
        theme: 'Kimlik krizi ve yeniden yapılanma',
        description: '''
Satürn güneşinize kavuştuğunda, yaklaşık 29 yıllık döngü tamamlanır.
Kimliğinizi, hedeflerinizi, yaşam yönünüzü sorgularsınız.
Kim olduğunuz ve kim olmak istediğiniz arasındaki uçurum görünür.

Bu transit ego için "sınav" zamanıdır. Gerçekten ne istediğinizi,
otantik misiniz yoksa rol mü oynadığınızı sorgularsınız.
Bazen depresyon, enerji düşüklüğü veya hayat krizi yaşanır.

Ancak bu "karanlık gece" gereklidir - sahte kimlikler dökülür,
gerçek benlik ortaya çıkar.
''',
        positiveManifestations: [
          'Olgunlaşma ve bilgelik kazanma',
          'Gerçek hedefleri netleştirme',
          'Otorite ve liderlik pozisyonu',
          'Kalıcı başarı temelleri',
          'Özgüven olgunlaşması',
        ],
        challenges: [
          'Özgüven krizi',
          'Enerji düşüklüğü',
          'Depresyon eğilimi',
          'Baba/otorite figürü sorunları',
          'Kariyer baskısı',
        ],
        advice: [
          'Kendinize karşı sabırlı olun',
          'Gerçek hedeflerinizi yazın',
          'Sağlığınıza dikkat edin',
          'Mentörlük alın',
          'Kısa vadeli başarısızlıklar sizi yıldırmasın',
        ],
        affirmation: 'Zaman benim dostumdur. Her adım beni olgunlaştırır.',
      ),
      squareEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'Çatışma ve yeniden yapılanma',
        description: '''
Satürn kareniz hayatınızdaki yapısal sorunları yüzünüze vurur.
"İşe yaramayan" her şey kriz yaratır - iş, ilişki, sağlık.
Değişmezseniz hayat sizi değiştirmeye zorlar.

Özellikle 7 yaş civarı (ilk kare), 21-22 (açılan kare), 36-37 (kapanan kare)
kritik yaşam dönüm noktalarıdır.
''',
        positiveManifestations: [
          'Krizden güçlenerek çıkma',
          'Gerçek öncelikleri belirleme',
          'Disiplin ve dayanıklılık kazanma',
        ],
        challenges: [
          'Engeller ve kısıtlamalar',
          'Otorite çatışmaları',
          'Motivasyon kaybı',
        ],
        advice: [
          'Direnmeyin, adapte olun',
          'Yapısal değişiklikler yapın',
          'Profesyonel yardım alın gerekirse',
        ],
        affirmation: 'Zorluklar beni daha güçlü yapıyor.',
      ),
      oppositionEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'Denge ve hesap verme',
        description: '''
Satürn karşıtlığı (14-15 yaş ve 43-44 yaş) hayatın "yarı yol" noktalarıdır.
Nereye geldiğinize bakarsınız. Beklentiler ile gerçeklik yüzleşir.
İlişkilerde özellikle "gerçeklik kontrolü" yaşanır.
''',
        positiveManifestations: [
          'Perspektif kazanma',
          'İlişkilerde olgunlaşma',
          'Denge bulma',
        ],
        challenges: [
          'Hayal kırıklığı',
          'İlişki krizi',
          'Orta yaş krizi (43-44\'te)',
        ],
        advice: [
          'Beklentilerinizi gözden geçirin',
          'İlişkilerde dürüst konuşmalar yapın',
          'Kendinize zaman tanıyın',
        ],
        affirmation: 'Denge, iki tarafa da adil olmaktır - kendime de.',
      ),
      trineEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'Kolay akış ve yapılandırma',
        description: '''
Satürn üçgeni nadir "ödül" zamanlarından biridir. Geçmiş emekler karşılık bulur.
Yapısal ilerlemeler kolay akar. Otorite figürleri destekler.
Kariyer ve statü ilerlemesi için ideal dönem.
''',
        positiveManifestations: [
          'Kariyer ilerlemesi',
          'Tanınma ve ödüller',
          'Kolay yapılandırma',
          'Mentor desteği',
          'Finansal güvenlik',
        ],
        challenges: [
          'Konfora kapılma tehlikesi',
          'Fırsatları kaçırma (çok rahat olunca)',
        ],
        advice: [
          'Bu dönemi iyi değerlendirin',
          'Uzun vadeli planlar yapın',
          'Kazanımları koruyun',
        ],
        affirmation: 'Emeklerimin karşılığını alıyorum.',
      ),
    ),
    'saturn_moon': SaturnTransitToNatal(
      transit: 'Satürn - Ay',
      conjunctionEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'Duygusal olgunlaşma',
        description: '''
Satürn ayınıza kavuştuğunda duygusal dünya "sıkıştırılır".
Duygularınızı bastırma veya kontrol etme eğilimi artar.
Anne/bakım temaları yüzeye çıkar. Geçmiş acılar işlenir.

Bu dönemde yalnızlık, melankoli veya depresyon yaşanabilir.
Ancak duygusal olgunlaşma ve iç güç kazanma fırsatıdır.
''',
        positiveManifestations: [
          'Duygusal dayanıklılık',
          'Olgun ilişkiler',
          'İç huzur',
          'Aile sorumluluğu kabul etme',
        ],
        challenges: [
          'Duygusal soğukluk',
          'Depresyon',
          'Anne/aile sorunları',
          'Yalnızlık hissi',
        ],
        advice: [
          'Kendinize şefkat gösterin',
          'Profesyonel destek alın gerekirse',
          'Aile ilişkilerini gözden geçirin',
          'Ev/yuva konularını düzenleyin',
        ],
        affirmation: 'Duygularım beni güçlendirir, zayıflatmaz.',
      ),
      squareEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'Duygusal gerilim',
        description: 'İç dünya ile dış dünya çatışır. Ev-iş dengesi sıkıntısı.',
        positiveManifestations: ['Sınır koymayı öğrenme', 'Duygusal disiplin'],
        challenges: ['Aile çatışmaları', 'Ev sorunları', 'Duygusal baskı'],
        advice: ['Duygusal ihtiyaçlarınızı ihmal etmeyin'],
        affirmation: 'İç huzurum dışsal başarı kadar önemli.',
      ),
      oppositionEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'İç-dış denge',
        description: 'Kariyer ve ev/aile arasında seçim baskısı.',
        positiveManifestations: ['Denge bulma', 'Öncelikleri netleştirme'],
        challenges: ['İş-aile çatışması', 'Duygusal yorgunluk'],
        advice: ['Her iki alanın da önemini kabul edin'],
        affirmation: 'Hem kariyer hem aile için yer var hayatımda.',
      ),
      trineEffect: TransitEffect(
        duration: '1-2 hafta',
        theme: 'Duygusal istikrar',
        description: 'Ev ve aile konularında kolay ilerleme.',
        positiveManifestations: ['Ev alma', 'Aile huzuru', 'Duygusal güvenlik'],
        challenges: ['Minimal'],
        advice: ['Ev/aile yatırımları için ideal dönem'],
        affirmation: 'Köklerim güçlü, temelem sağlam.',
      ),
    ),
    // Diğer natal gezegenlere Satürn transitler devam...
  };

  /// Satürn Dönüşü (Saturn Return)
  static const SaturnReturn saturnReturn = SaturnReturn(
    ages: [28, 29, 30, 57, 58, 59, 86, 87, 88],
    description: '''
Satürn Dönüşü, Satürn'ün doğum haritanızdaki orijinal konumuna dönmesidir.
İlk dönüş (28-30): Yetişkinliğe geçiş. Gençlik biter, sorumluluk başlar.
İkinci dönüş (57-59): Bilgelik çağı. Miras ve anlam soruları.
Üçüncü dönüş (86-88): Yaşamın değerlendirmesi. Kabul ve bırakma.
''',
    firstReturnThemes: [
      'Kariyer yönü netleşir veya tamamen değişir',
      'Ciddi ilişki/evlilik veya ayrılık',
      'Ev alma veya büyük taşınma',
      'Anne-baba olma veya bu konuda karar',
      'Gençlik ideallerinin gerçeklikle sınanması',
      'Kim olduğunuzu sorgulamak',
      'Otoriteyle yeni ilişki kurmak',
    ],
    survivalGuide: [
      'Bu dönem geçici - yaklaşık 2.5 yıl sürer',
      'Hayatınızda işe yaramayan her şeyi gözden geçirin',
      'Gerçekçi hedefler koyun',
      'Sağlığınıza dikkat edin (stres!)',
      'Mentor veya terapist desteği alın',
      'Büyük kararlar için acelement - düşünün',
      'Sorumluluklardan kaçmayın, kabul edin',
      'Bu bir "ölüm ve yeniden doğuş" dönemidir',
    ],
    affirmation:
        'Gerçek yetişkinliğe adım atıyorum. Her zorluk beni olgunlaştırıyor.',
  );
}

class SaturnTransitToNatal {
  final String transit;
  final TransitEffect conjunctionEffect;
  final TransitEffect squareEffect;
  final TransitEffect oppositionEffect;
  final TransitEffect trineEffect;

  const SaturnTransitToNatal({
    required this.transit,
    required this.conjunctionEffect,
    required this.squareEffect,
    required this.oppositionEffect,
    required this.trineEffect,
  });
}

class TransitEffect {
  final String duration;
  final String theme;
  final String description;
  final List<String> positiveManifestations;
  final List<String> challenges;
  final List<String> advice;
  final String affirmation;

  const TransitEffect({
    required this.duration,
    required this.theme,
    required this.description,
    required this.positiveManifestations,
    required this.challenges,
    required this.advice,
    required this.affirmation,
  });
}

class SaturnReturn {
  final List<int> ages;
  final String description;
  final List<String> firstReturnThemes;
  final List<String> survivalGuide;
  final String affirmation;

  const SaturnReturn({
    required this.ages,
    required this.description,
    required this.firstReturnThemes,
    required this.survivalGuide,
    required this.affirmation,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// JÜPİTER TRANSİTLERİ - BÜYÜK ŞANS
// ════════════════════════════════════════════════════════════════════════════

class JupiterTransits {
  static const String introduction = '''
Jüpiter, zodyakın "Büyük Şans" gezegenidir. Transitlerinde genişleme, fırsat,
bolluk ve büyüme getirir. Her 12 yılda bir haritanızı dolaşır.
Jüpiter nereye dokunursa, orada "daha fazlası" olur - iyi veya kötü.
''';

  static const Map<String, JupiterTransitEffect> throughHouses = {
    'house1': JupiterTransitEffect(
      house: 1,
      houseName: '1. Ev - Benlik',
      duration: '1 yıl',
      theme: 'Kişisel genişleme ve yeni başlangıçlar',
      description: '''
Jüpiter 1. evden geçerken siz "büyürsünüz". Fiziksel olarak (kilo alabilirsiniz!),
psikolojik olarak (özgüven artar), sosyal olarak (tanınırlık). Yeni projeler
başlatmak, kendinizi yeniden keşfetmek için ideal dönem.
''',
      opportunities: [
        'Yeni imaj/görünüm',
        'Kişisel projeler başlatma',
        'Özgüven artışı',
        'Tanınırlık',
        'Seyahat fırsatları',
      ],
      warnings: [
        'Aşırı özgüven',
        'Kilo alma',
        'Abartılı vaatler',
        'Kaynaklarda aşırılık',
      ],
      bestActivities: [
        'Kişisel markalaşma',
        'Yeni görünüm',
        'Seyahat',
        'Eğitim başlatma',
        'Yayın/paylaşım',
      ],
    ),
    'house2': JupiterTransitEffect(
      house: 2,
      houseName: '2. Ev - Kaynaklar',
      duration: '1 yıl',
      theme: 'Finansal genişleme',
      description: '''
Para ve kaynaklar artar veya artma potansiyeli doğar. Kazanç fırsatları çoğalır.
Ancak harcamalar da artabilir. Değerler sisteminiz genişler.
''',
      opportunities: [
        'Gelir artışı',
        'Yeni kazanç kaynakları',
        'Değerli edinimler',
        'Yatırım fırsatları',
      ],
      warnings: ['Aşırı harcama', 'Mali aşırılık', 'Materyalizme kapılma'],
      bestActivities: [
        'Maaş artışı isteme',
        'Yatırım',
        'Değerli alımlar',
        'İş geliştirme',
      ],
    ),
    'house7': JupiterTransitEffect(
      house: 7,
      houseName: '7. Ev - İlişkiler',
      duration: '1 yıl',
      theme: 'İlişkilerde genişleme',
      description: '''
İlişki fırsatları bollaşır. Evlilik, ortaklık, önemli anlaşmalar için ideal dönem.
Mevcut ilişkiler derinleşir veya genişler. Yeni insanlarla bağlantılar kurulur.
''',
      opportunities: [
        'Evlilik/nişan',
        'İş ortaklıkları',
        'Önemli anlaşmalar',
        'Sosyal çevrenin genişlemesi',
      ],
      warnings: [
        'Yanlış kişiyle bağlanma (aceleci)',
        'İlişkide aşırı beklenti',
        'Kötü ortaklık seçimi',
      ],
      bestActivities: [
        'Evlilik',
        'Ortaklık kurma',
        'Sözleşme imzalama',
        'Danışmanlık alma',
      ],
    ),
    'house10': JupiterTransitEffect(
      house: 10,
      houseName: '10. Ev - Kariyer',
      duration: '1 yıl',
      theme: 'Kariyer zirvesi',
      description: '''
Kariyer ve toplumsal statüde yükselme dönemi. Tanınma, terfi, başarı şansı yüksek.
12 yılın kariyer zirvesi olabilir. Büyük fırsatları değerlendirin.
''',
      opportunities: [
        'Terfi',
        'Tanınma',
        'Ödüller',
        'Liderlik pozisyonları',
        'Kamusal görünürlük',
      ],
      warnings: ['Kibirlenme', 'Aşırı iş yükü alma', 'Özel hayatı ihmal'],
      bestActivities: [
        'Terfi isteme',
        'Büyük proje başlatma',
        'Kamusal görünüm',
        'Profesyonel ağ genişletme',
      ],
    ),
  };

  /// Jüpiter Dönüşü
  static const String jupiterReturn = '''
Jüpiter Dönüşü her 12 yılda bir gerçekleşir (12, 24, 36, 48, 60, 72, 84...).
Bu dönemlerde yeni döngü başlar. Şans ve fırsatlar artar.

12 yaş: Gençliğe geçiş, genişleme arzusu
24 yaş: Yetişkin kimliği, dünyaya açılma
36 yaş: Olgunluk, ikinci gençlik
48 yaş: Bilgelik başlangıcı, öğretmen rolü
60 yaş: Emeklilik/yeni başlangıç
72 yaş: Miras ve aktarım
84 yaş: Spiritüel tamamlanma

Jüpiter Dönüşü yılında:
- Büyük projeler başlatın
- Seyahat edin
- Öğrenin/öğretin
- Risk alın (hesaplı)
- Vizyonunuzu genişletin
''';
}

class JupiterTransitEffect {
  final int house;
  final String houseName;
  final String duration;
  final String theme;
  final String description;
  final List<String> opportunities;
  final List<String> warnings;
  final List<String> bestActivities;

  const JupiterTransitEffect({
    required this.house,
    required this.houseName,
    required this.duration,
    required this.theme,
    required this.description,
    required this.opportunities,
    required this.warnings,
    required this.bestActivities,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// RETROGRAT DÖNEMLERİ
// ════════════════════════════════════════════════════════════════════════════

class RetrogradeContent {
  static const Map<String, RetrogradeGuide> guides = {
    'mercury': RetrogradeGuide(
      planet: 'Merkür',
      frequency: 'Yılda 3-4 kez, her biri ~3 hafta',
      generalTheme: 'İletişim, teknoloji, seyahat kaosları',
      description: '''
Merkür Retrosu en bilinen ve en sık yaşanan retrodur. İletişim hataları,
teknoloji arızaları, gecikmeler, yanlış anlaşılmalar artar.
Geçmişten insanlar/konular geri döner.

Ancak korkulacak bir dönem değil - sadece dikkatli olunacak bir dönem.
Gözden geçirme, revize etme, tamamlanmamış işleri bitirme için idealdir.
''',
      doList: [
        'Geçmiş projeleri gözden geçir',
        'Eski bağlantıları yenile',
        'Araştırma ve analiz yap',
        'Yedekleme yap (dijital)',
        'Esneklik göster planlarda',
        'Ekstra zaman bırak yolculuklarda',
        'İmzalamadan önce iki kez oku',
      ],
      avoidList: [
        'Yeni sözleşme imzalama',
        'Yeni teknoloji satın alma',
        'Önemli ilk buluşmalar',
        'Büyük lansman/açılış',
        'Net olmayan iletişim',
      ],
      shadowPeriod: 'Retrodan 2 hafta önce ve sonra etkileri hissedilir',
    ),
    'venus': RetrogradeGuide(
      planet: 'Venüs',
      frequency: 'Her 18 ayda bir, ~40 gün',
      generalTheme: 'İlişkiler, değerler, para konuları',
      description: '''
Venüs Retrosu ilişki ve finans konularını vurgular. Eski aşklar geri dönebilir.
Mevcut ilişkiler sorgulanır. Neyi gerçekten sevdiğinizi, değerli bulduğunuzu
yeniden değerlendirirsiniz.

Bu dönemde estetik prosedürler, büyük satın almalar (özellikle lüks),
yeni ilişkilere başlamak önerilmez.
''',
      doList: [
        'İlişkileri gözden geçir',
        'Değerlerini sorgula',
        'Eski aşkları/arkadaşları düşün',
        'Self-care ve iç güzellik',
        'Sanat ve yaratıcılık',
      ],
      avoidList: [
        'Evlilik/nişan',
        'Pahalı mücevher/lüks alımlar',
        'Estetik operasyonlar',
        'Büyük finansal kararlar',
        'Yeni ilişki başlatma',
      ],
      shadowPeriod: 'Retrodan 1-2 hafta önce ve sonra',
    ),
    'mars': RetrogradeGuide(
      planet: 'Mars',
      frequency: 'Her 2 yılda bir, ~2-2.5 ay',
      generalTheme: 'Enerji, motivasyon, çatışma',
      description: '''
Mars Retrosu enerji düşüklüğü, motivasyon kaybı, bastırılmış öfke dönemdir.
Eylemler gecikir, projeler yavaşlar. Geçmiş anlaşmazlıklar geri dönebilir.

Fiziksel enerji azalır - zorlu egzersizlere dikkat. Öfke patlamaları veya
tam tersi, öfkeyi bastırma görülebilir. İç savaşçıyı gözden geçirme zamanı.
''',
      doList: [
        'Strateji gözden geçir',
        'Enerjiyi yenile (dinlenme)',
        'Geçmiş çatışmaları çöz',
        'Bastırılmış öfkeyi işle',
        'Hafif egzersiz',
      ],
      avoidList: [
        'Yeni savaş/rekabet başlatma',
        'Ameliyat (acil değilse)',
        'Aşırı fiziksel yük',
        'Çatışmayı tırmandırma',
        'Önemli hukuki başlatma',
      ],
      shadowPeriod: '2-3 hafta önce ve sonra',
    ),
  };
}

class RetrogradeGuide {
  final String planet;
  final String frequency;
  final String generalTheme;
  final String description;
  final List<String> doList;
  final List<String> avoidList;
  final String shadowPeriod;

  const RetrogradeGuide({
    required this.planet,
    required this.frequency,
    required this.generalTheme,
    required this.description,
    required this.doList,
    required this.avoidList,
    required this.shadowPeriod,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// TUTULMALAR (ECLİPSES)
// ════════════════════════════════════════════════════════════════════════════

class EclipseContent {
  static const String introduction = '''
Tutulmalar güçlendirilmiş Yeniay (Güneş tutulması) ve Dolunay'dır (Ay tutulması).
Yılda 4-6 kez gerçekleşir. Kaderin parmağı olarak bilinir - ani değişimler,
kapanan ve açılan kapılar getirir.

Tutulma doğum haritanızın hassas bir noktasına denk gelirse,
o alan 6 ay - 1 yıl boyunca aktif olur.
''';

  static const Map<String, EclipseGuide> types = {
    'solar': EclipseGuide(
      type: 'Güneş Tutulması (Yeniay)',
      theme: 'Yeni başlangıçlar, kapıların açılması',
      duration: 'Etkileri 6 ay - 1 yıl',
      description: '''
Güneş tutulması güçlendirilmiş Yeniay'dır. Yeni başlangıçları zorlar.
Bazen bir alan "karanlığa gömülür" ki yeni ışık doğabilsin.
Ego ve kimlik konuları vurgulanır.

Güneş tutulması sırasında veya hemen sonrasında başlayan şeyler
"kadersel" bir kalite taşır.
''',
      effects: [
        'Yeni başlangıçlar (bazen zoraki)',
        'Kimlik değişimi',
        'Ego sınavları',
        'Baba/otorite figürü temaları',
        'Kariyer/yaşam yönü değişimleri',
      ],
      advice: [
        'Yeniay dileklerini güçlendirin',
        'Yeni projelere açık olun',
        'Eski kimliğe tutunmayın',
        'Kapanan kapılara üzülmeyin, yenisi açılacak',
      ],
    ),
    'lunar': EclipseGuide(
      type: 'Ay Tutulması (Dolunay)',
      theme: 'Tamamlama, kapanış, duygusal doruk',
      duration: 'Etkileri 3-6 ay',
      description: '''
Ay tutulması güçlendirilmiş Dolunay'dır. Bir şeylerin tamamlanması,
bitmesi, doruk noktasına ulaşması. Duygusal yoğunluk had safhada.
İlişki ve ev/aile konuları vurgulanır.

Ay tutulmasında bitişler "normal" bitiş değildir - kaderseldir.
Geri dönüşü zor kapanışlar olabilir.
''',
      effects: [
        'İlişki dorukları veya bitişleri',
        'Duygusal arınma',
        'Anne/aile temaları',
        'Ev değişiklikleri',
        'Gizli şeylerin açığa çıkması',
      ],
      advice: [
        'Duygusal şiddete hazırlıklı olun',
        'Bırakmanız gerekeni bırakın',
        'Aile konularına dikkat edin',
        'Bitişleri onurlandırın',
      ],
    ),
  };

  static const List<String> eclipseRules = [
    'Tutulmadan 3 gün önce ve sonra büyük karar vermekten kaçının',
    'Tutulma doğum gününüze denk gelirse: Önemli yıl!',
    'Tutulma natal gezegeninize denk gelirse: O alan aktif',
    'Tutulmalar çiftler halinde gelir (aynı eksen)',
    'Tutulma ekseni 1.5 yılda değişir',
    'Kişisel tutulma (sizin işaretinizde) = Büyük dönüşüm',
  ];
}

class EclipseGuide {
  final String type;
  final String theme;
  final String duration;
  final String description;
  final List<String> effects;
  final List<String> advice;

  const EclipseGuide({
    required this.type,
    required this.theme,
    required this.duration,
    required this.description,
    required this.effects,
    required this.advice,
  });
}
