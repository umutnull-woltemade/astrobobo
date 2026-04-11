/// Horoscope Mega Content - Günlük/Haftalık/Aylık/Yıllık Burç Yorumları
/// Her burç için kapsamlı yorum şablonları ve dinamik içerik
library;

// ════════════════════════════════════════════════════════════════════════════
// GÜNLÜK BURÇ YORUMU ŞABLONLARİ
// ════════════════════════════════════════════════════════════════════════════

class DailyHoroscopeTemplates {
  /// Ay fazlarına göre genel tema şablonları
  static const Map<String, MoonPhaseTheme> moonPhaseThemes = {
    'new_moon': MoonPhaseTheme(
      phase: 'Yeni Ay',
      generalTheme: 'Yeni başlangıçlar ve tohumlar ekme zamanı',
      energyLevel: 'İçsel, yansıtıcı',
      bestFor: [
        'Niyet belirleme',
        'Yeni projeler başlatma',
        'İç görü çalışması',
      ],
      avoid: ['Büyük kararlar', 'Kamusal girişimler', 'Aşırı sosyalleşme'],
      affirmation: 'Bugün tohum ektiğim niyetler, zamanla meyve verecek.',
    ),
    'waxing_crescent': MoonPhaseTheme(
      phase: 'Hilal (Büyüyen)',
      generalTheme: 'Momentum oluşturma ve harekete geçme',
      energyLevel: 'Artan, motive',
      bestFor: [
        'Planları harekete geçirme',
        'İlk adımları atma',
        'Engellerin üstesinden gelme',
      ],
      avoid: ['Tembellik', 'Erteleme', 'Şüpheye kapılma'],
      affirmation: 'Her küçük adım beni hedefime yaklaştırıyor.',
    ),
    'first_quarter': MoonPhaseTheme(
      phase: 'İlk Dördün',
      generalTheme: 'Meydan okumalar ve kararlılık testi',
      energyLevel: 'Gerilimli, zorlayıcı',
      bestFor: ['Zorlukları aşma', 'Kararlı duruş', 'Stratejik değişiklikler'],
      avoid: ['Vazgeçme', 'Öfke patlamaları', 'Sabırsızlık'],
      affirmation: 'Zorluklarla yüzleşmek beni güçlendiriyor.',
    ),
    'waxing_gibbous': MoonPhaseTheme(
      phase: 'Şişkin Ay (Büyüyen)',
      generalTheme: 'Rafine etme ve mükemmelleştirme',
      energyLevel: 'Yoğun, detay odaklı',
      bestFor: [
        'İnce ayarlar yapma',
        'Analiz ve değerlendirme',
        'Hazırlıkları tamamlama',
      ],
      avoid: ['Mükemmeliyetçilik', 'Aşırı eleştiri', 'Kaygıya kapılma'],
      affirmation: 'Detaylara dikkat ederken büyük resmi de görüyorum.',
    ),
    'full_moon': MoonPhaseTheme(
      phase: 'Dolunay',
      generalTheme: 'Doruk, aydınlanma ve sonuçlar',
      energyLevel: 'Maksimum, yoğun',
      bestFor: ['Kutlama', 'Farkındalık', 'İlişkiler', 'Bırakma ritüelleri'],
      avoid: ['Aşırı tepkiler', 'Büyük kararlar', 'Çatışma arama'],
      affirmation:
          'Işık her şeyi açığa çıkarıyor, ben de gerçeğimi kucaklıyorum.',
    ),
    'waning_gibbous': MoonPhaseTheme(
      phase: 'Şişkin Ay (Küçülen)',
      generalTheme: 'Paylaşma ve şükran',
      energyLevel: 'Azalan, içsel dönen',
      bestFor: ['Öğrenilenleri paylaşma', 'Şükran', 'Başkalarına yardım'],
      avoid: ['Yeni başlangıçlar', 'Aşırı harcama', 'Ego'],
      affirmation: 'Öğrendiklerimi paylaşarak çoğaltıyorum.',
    ),
    'last_quarter': MoonPhaseTheme(
      phase: 'Son Dördün',
      generalTheme: 'Bırakma ve temizlik',
      energyLevel: 'Gerilimli, dönüştürücü',
      bestFor: ['Eski kalıpları kırma', 'Temizlik', 'Bağışlama'],
      avoid: ['Geçmişe takılma', 'Pişmanlık', 'Direnç'],
      affirmation: 'Bıraktıklarım yerini yenilere açıyor.',
    ),
    'waning_crescent': MoonPhaseTheme(
      phase: 'Hilal (Küçülen)',
      generalTheme: 'Dinlenme ve içsel hazırlık',
      energyLevel: 'Minimum, içsel',
      bestFor: ['Meditasyon', 'Rüyalara dikkat', 'Sessizlik', 'Kendine bakım'],
      avoid: ['Yeni projeler', 'Sosyal etkinlikler', 'Fiziksel aşırılıklar'],
      affirmation: 'Dinlenmek de bir üretkenlik biçimidir.',
    ),
  };

  /// Haftanın günlerine göre gezegen enerjileri
  static const Map<String, DayPlanetaryEnergy> dailyPlanetaryEnergies = {
    'monday': DayPlanetaryEnergy(
      day: 'Pazartesi',
      rulingPlanet: 'Ay',
      planetSymbol: '☽',
      theme: 'Duygular, sezgi, ev ve aile',
      bestActivities: [
        'Ev işleri',
        'Aile zamanı',
        'Bakım ve beslenme',
        'Duygusal iyileşme',
      ],
      color: 'Beyaz, gümüş',
      crystal: 'Aytaşı, İnci',
      affirmation: 'Duygularımı onurlandırıyorum.',
    ),
    'tuesday': DayPlanetaryEnergy(
      day: 'Salı',
      rulingPlanet: 'Mars',
      planetSymbol: '♂',
      theme: 'Eylem, enerji, cesaret ve rekabet',
      bestActivities: [
        'Spor',
        'Yeni girişimler',
        'Fiziksel aktivite',
        'Liderlik',
      ],
      color: 'Kırmızı, turuncu',
      crystal: 'Kırmızı Jasper, Karneol',
      affirmation: 'Cesaretim ve enerjim beni ileriye taşıyor.',
    ),
    'wednesday': DayPlanetaryEnergy(
      day: 'Çarşamba',
      rulingPlanet: 'Merkür',
      planetSymbol: '☿',
      theme: 'İletişim, öğrenme, yazma ve seyahat',
      bestActivities: [
        'Yazışmalar',
        'Öğrenme',
        'Toplantılar',
        'Kısa yolculuklar',
      ],
      color: 'Sarı, turuncu',
      crystal: 'Sitrin, Kaplan Gözü',
      affirmation: 'Fikirlerimi açıkça ifade ediyorum.',
    ),
    'thursday': DayPlanetaryEnergy(
      day: 'Perşembe',
      rulingPlanet: 'Jüpiter',
      planetSymbol: '♃',
      theme: 'Genişleme, şans, yüksek öğrenim ve felsefe',
      bestActivities: [
        'Yasal işler',
        'Yayıncılık',
        'Eğitim',
        'Uzun yolculuklar',
      ],
      color: 'Mavi, mor',
      crystal: 'Ametist, Lapis Lazuli',
      affirmation: 'Evren benim için bolluğu açıyor.',
    ),
    'friday': DayPlanetaryEnergy(
      day: 'Cuma',
      rulingPlanet: 'Venüs',
      planetSymbol: '♀',
      theme: 'Aşk, güzellik, sanat ve para',
      bestActivities: ['Randevular', 'Sanat', 'Alışveriş', 'Güzellik bakımı'],
      color: 'Pembe, yeşil',
      crystal: 'Gül Kuvars, Yeşim',
      affirmation: 'Sevgi ve güzellik hayatıma akıyor.',
    ),
    'saturday': DayPlanetaryEnergy(
      day: 'Cumartesi',
      rulingPlanet: 'Satürn',
      planetSymbol: '♄',
      theme: 'Yapı, disiplin, sorumluluk ve kariyer',
      bestActivities: [
        'Planlama',
        'Organizasyon',
        'Kariyer işleri',
        'Yaşlılara saygı',
      ],
      color: 'Siyah, koyu mavi',
      crystal: 'Obsidyen, Oniks',
      affirmation: 'Disiplin ve sabırla hedeflerime ulaşıyorum.',
    ),
    'sunday': DayPlanetaryEnergy(
      day: 'Pazar',
      rulingPlanet: 'Güneş',
      planetSymbol: '☉',
      theme: 'Benlik, yaratıcılık, neşe ve liderlik',
      bestActivities: [
        'Kendine zaman',
        'Yaratıcı projeler',
        'Dinlenme',
        'Kutlama',
      ],
      color: 'Altın, sarı',
      crystal: 'Kaplan Gözü, Sitrin',
      affirmation: 'Işığımı dünyayla paylaşıyorum.',
    ),
  };

  /// Her burç için günlük yorum alanları
  static const Map<String, DailyHoroscopeAreas> horoscopeAreas = {
    'love': DailyHoroscopeAreas(
      area: 'Aşk',
      icon: '💕',
      questions: [
        'İlişkimde bugün ne beklemeliyim?',
        'Bekar olarak bugün şansım nasıl?',
        'Duygusal enerji bugün nasıl?',
      ],
    ),
    'career': DailyHoroscopeAreas(
      area: 'Kariyer',
      icon: '💼',
      questions: [
        'İş yerinde bugün nasıl bir gün geçireceğim?',
        'Finansal fırsatlar var mı?',
        'Mesleki gelişim için ipuçları',
      ],
    ),
    'health': DailyHoroscopeAreas(
      area: 'Sağlık',
      icon: '🏃',
      questions: [
        'Enerji seviyem bugün nasıl?',
        'Nelere dikkat etmeliyim?',
        'Stres yönetimi önerileri',
      ],
    ),
    'money': DailyHoroscopeAreas(
      area: 'Para',
      icon: '💰',
      questions: [
        'Finansal kararlar için uygun bir gün mü?',
        'Beklenmedik gelir/gider var mı?',
        'Yatırım zamanlaması',
      ],
    ),
    'mood': DailyHoroscopeAreas(
      area: 'Ruh Hali',
      icon: '🎭',
      questions: [
        'Genel duygusal durum nasıl?',
        'Motivasyon seviyesi',
        'İç huzur için öneriler',
      ],
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// BURÇ BAZLI GÜNLÜK İÇERİK ŞABLONLARI
// ════════════════════════════════════════════════════════════════════════════

class ZodiacDailyContent {
  /// Koç günlük içerik şablonları
  static const AriesDailyTemplates aries = AriesDailyTemplates();

  /// Boğa günlük içerik şablonları
  static const TaurusDailyTemplates taurus = TaurusDailyTemplates();

  // ... diğer burçlar
}

class AriesDailyTemplates {
  const AriesDailyTemplates();

  /// Yüksek enerjili günler için şablonlar
  static const List<String> highEnergyDays = [
    '''
Mars enerjisi bugün tam güçte! {sign} olarak doğal liderliğin parıldıyor.
Eylem zamanı - düşünmeden önce hareket etmek için mükemmel bir gün.

🔥 GÜNÜN ENERJİSİ: Ateşli ve dinamik
Bugün önüne çıkan her fırsat bir atlama tahtası. Tereddüt etme,
en iyi fikirlerin hareket ederken gelecek.

💡 GÜNÜN TAVSİYESİ:
Rekabeti sev ama düşmanlar yaratma. Enerjini spor veya fiziksel
aktiviteyle kanalize et - aksi halde gerilim olarak patlayabilir.

⚡ DİKKAT:
Aceleci kararlar verme eğilimin var. "Hızlı" ile "acele" arasındaki
farkı gözet. Önce soluğunu al, sonra atıl.
''',
    '''
Bugün bir savaşçı gibi hissedeceksin - ve haklısın da! Koç enerjisi
zirvede. Her engel aşılabilir, her rakip yenilebilir görünüyor.

🎯 ODAK ALANI: Başarı ve zafer
"Başaramam" kelimesi bugün sözlüğünde yok. Bu özgüveni akıllıca kullan.
Büyük hedefler koy ama detayları unutma.

🚀 FIRSAT:
Uzun süredir ertelediğin o girişimi bugün başlat. Mars seni destekliyor.
Cesaretin ödüllendirildiği bir gün.

⚠️ UYARI:
Ego patlamaları gündemde olabilir. Haklı olmak ile mutlu olmak
arasında seçim yapman gerekebilir.
''',
  ];

  /// Düşük enerjili günler için şablonlar
  static const List<String> lowEnergyDays = [
    '''
Bugün Mars retrosu etkisinde gibi hissedebilirsin. Enerjin her zamanki
gibi patlamıyor - ve bu aslında iyi bir şey.

🌙 GÜNÜN TEMASI: Yavaşla ve dinle
Her gün savaş meydanı olmak zorunda değil. Bugün stratejik geri çekilme
zamanı. Düşün, planla, biriktir.

🧘 İÇ DÜNYA:
Normalde dışa dönük enerjin bugün içe dönüyor. Meditasyon veya sessiz
yürüyüş sana iyi gelecek.

📝 TAVSİYE:
Büyük hamleler yapma, enerji biriktir. Yarın için hazırlan.
Sabır bir güç gösterisidir.
''',
  ];

  /// Aşk alanı şablonları
  static const Map<String, List<String>> loveTemplates = {
    'single': [
      '''
Bekar {sign} için bugün flört enerjisi yüksek! Cesaretin ve doğrudanlığın
potansiyel partnerleri etkileyecek. İlk adımı atmaktan çekinme.

❤️ ÇEKİM PUANI: %{attraction}
Bugün manyetik alanın güçlü. Göz göze gelişler, anlık bağlantılar
muhtemel. Spontan ol!

💘 İPUCU:
Koç'un doğrudan yaklaşımı bazılarını korkutabilir. Biraz gizem ekle -
hemen her kartı gösterme.
''',
    ],
    'relationship': [
      '''
İlişkideki {sign} için bugün tutku ve enerji var ama sabır da gerekiyor.
Partnerin senin hızına yetişemeyebilir - anlayış göster.

💑 İLİŞKİ ENERJİSİ: Dinamik ama zorlayıcı
Birlikte fiziksel aktivite yapın - spor, dans, macera. Oturarak tartışma
yerine hareket ederek bağlanın.

⚡ DİKKAT:
Küçük şeyleri büyütme eğilimin var. Her tartışmayı kazanmak zorunda
değilsin. Bazen geri adım atmak ileri gitmektir.
''',
    ],
  };

  /// Kariyer alanı şablonları
  static const Map<String, List<String>> careerTemplates = {
    'positive': [
      '''
İş hayatında bugün Koç liderlik enerjisi parlıyor! İnsiyatif almak,
yeni projeler başlatmak için ideal.

📈 KARİYER PUANI: %{score}
Üstlerin cesaretini fark edecek. Terfi veya tanınma gündemde olabilir.
Sesini çıkar, fikirlerini paylaş.

💼 FIRSAT:
Uzun süredir düşündüğün o projeyi sun. Risk almak bugün ödüllendiriliyor.
''',
    ],
    'challenging': [
      '''
İş yerinde bugün biraz gerilim var. Koç'un sabırsızlığı çatışmalara
yol açabilir. Dikkatli ol!

⚠️ ZORLUK:
Otoriteyle sürtüşme riski var. Haklı olsan bile, nasıl söylediğin
ne söylediğinden önemli.

🛠️ STRATEJİ:
Savaşlarını seç. Her tepeye tırmanmak zorunda değilsin. Büyük
resmi gör, küçük engellere takılma.
''',
    ],
  };
}

class TaurusDailyTemplates {
  const TaurusDailyTemplates();

  static const List<String> highEnergyDays = [
    '''
Venüs enerjisi bugün seni kucaklıyor, {sign}. Duyusal zevkler, güzellik
ve konfor gündemde. Hayatın tadını çıkarma zamanı!

🌸 GÜNÜN ENERJİSİ: Zengin ve huzurlu
Acele etme, her anın keyfini çıkar. Lezzetli bir yemek, güzel bir müzik,
yumuşak dokular - beş duyunu şımartmak için izin ver.

💎 DEĞER ODAĞI:
Bugün değerli olan şeylere odaklan - hem maddi hem manevi.
Neyin gerçekten önemli olduğunu hatırla.

🌿 TAVSİYE:
Doğayla vakit geçir. Toprakla bağlantı kurmak seni merkeze getirir.
''',
  ];

  static const Map<String, List<String>> loveTemplates = {
    'single': [
      '''
Bekar {sign} için bugün romantik potansiyel yüksek! Venüs çekiciliğini
artırıyor. Sakin, güvenilir enerjin dikkat çekecek.

❤️ ÇEKİM PUANI: %{attraction}
Hızlı ilişkiler aramıyorsun - ve bu doğru. Kalıcı bağlantılar için
sabırlı yaklaşımın seni doğru kişiye götürecek.

💕 İPUCU:
Güzel bir restoran veya sanat galerisi gibi yerlerde şansın daha yüksek.
Estetik zevklerini paylaşan biriyle karşılaşabilirsin.
''',
    ],
    'relationship': [
      '''
İlişkideki {sign} için bugün sevgi dolu ve besleyici bir gün.
Partnerin için bir şeyler pişir, masaj yap, fiziksel yakınlık göster.

💑 İLİŞKİ ENERJİSİ: Sıcak ve güven dolu
Derin sohbetler yerine sessiz birliktelik. Sadece birlikte olmak,
bir şey yapmak zorunda olmadan, bugün en değerli hediye.

🌹 ROMANTİK JEST:
Küçük ama anlamlı bir hediye. Çiçek, çikolata veya favori yemeği.
Maddi değil, düşünce önemli.
''',
    ],
  };
}

// ════════════════════════════════════════════════════════════════════════════
// HAFTALIK BURÇ YORUMLARI
// ════════════════════════════════════════════════════════════════════════════

class WeeklyHoroscopeContent {
  static const String introduction = '''
Haftalık burç yorumları, haftanın genel enerjisini ve her gün için
özel vurguları içerir. Gezegen transitlerinin hafta boyunca etkilerini
ve önemli tarihlerı öğrenin.
''';

  /// Haftalık yorum yapı şablonu
  static const WeeklyStructure structure = WeeklyStructure(
    sections: [
      'Haftanın Genel Enerjisi',
      'Önemli Gezegen Hareketleri',
      'Aşk ve İlişkiler Haftalığı',
      'Kariyer ve Finans Haftalığı',
      'Sağlık ve Enerji Takibi',
      'Şanslı Gün ve Saatler',
      'Haftanın Tavsiyesi',
    ],
    dailyHighlights: true,
    luckyNumbers: true,
    luckyColors: true,
  );

  /// Haftalık tema şablonları (gezegen hareketlerine göre)
  static const Map<String, WeeklyTheme> weeklyThemes = {
    'mercury_retrograde': WeeklyTheme(
      theme: 'Merkür Retrosu Haftası',
      generalAdvice: '''
Bu hafta iletişim ve teknoloji konularında ekstra dikkatli ol!
Merkür retrosu her şeyin yavaşladığı, geçmişin gündeme geldiği bir dönem.

DİKKAT EDİLECEKLER:
• Önemli belgeleri iki kez kontrol et
• Eski arkadaşlar veya eski sevgililer ortaya çıkabilir
• Teknolojik aksaklıklara hazırlıklı ol
• Yeni sözleşmeler imzalamaktan kaçın
• Seyahat planlarını esnek tut

POZİTİF KULLANIM:
• Yarım kalan projeleri tamamla
• Geçmişi gözden geçir ve öğren
• İletişimi tamir et, barış
• Detaylara dikkat et
''',
      doList: ['Yedekleme yap', 'Eski dostlara ulaş', 'Tamir ve bakım'],
      dontList: ['Yeni başlangıçlar', 'Büyük alımlar', 'Önemli sözleşmeler'],
    ),
    'venus_retrograde': WeeklyTheme(
      theme: 'Venüs Retrosu Haftası',
      generalAdvice: '''
Aşk ve değerler sorgulanıyor. Venüs retrosu ilişkileri ve
finansmanı yeniden değerlendirme zamanı.

AŞK HAYATINDA:
• Eski aşklar geri dönebilir
• Mevcut ilişkiler test edilir
• Ne istediğini sorgula
• Yeni ilişki başlatmak için bekle

FİNANSAL:
• Büyük harcamalardan kaçın
• Değerlerin üzerine düşün
• İmpulsif alışverişe hayır
''',
      doList: [
        'İlişki değerlendirmesi',
        'Öz-değer çalışması',
        'Sanat ve güzellik',
      ],
      dontList: ['Estetik operasyonlar', 'Büyük alımlar', 'Yeni ilişki'],
    ),
    'mars_retrograde': WeeklyTheme(
      theme: 'Mars Retrosu Haftası',
      generalAdvice: '''
Eylem enerjisi içe dönüyor. Mars retrosu fiziksel aktivite,
öfke ve motivasyonu etkiler.

ENERJİ YÖNETİMİ:
• Yorgunluk hissedebilirsin
• Öfke patlamalarına dikkat
• Fiziksel zorlamadan kaçın
• Strateji geliştirme zamanı

TAVSİYELER:
• Sabırlı ol
• Büyük kavgalardan kaçın
• Yoga ve meditasyon
• Enerji biriktir
''',
      doList: ['Strateji planlama', 'Dinlenme', 'İçsel motivasyon'],
      dontList: ['Saldırgan davranış', 'Riskli sporlar', 'Yeni savaşlar'],
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// AYLIK BURÇ YORUMLARI
// ════════════════════════════════════════════════════════════════════════════

class MonthlyHoroscopeContent {
  /// Ayların astrolojik temaları
  static const Map<int, MonthlyTheme> monthlyThemes = {
    1: MonthlyTheme(
      month: 'Ocak',
      sign: 'Oğlak',
      generalTheme: 'Yeni Yıl Niyetleri ve Yapılandırma',
      keyPhrases: ['Hedef belirleme', 'Disiplin', 'Yeni başlangıçlar'],
      collectiveEnergy: '''
Oğlak sezonu devam ediyor. Kariyer, hırs ve sorumluluk vurgulanıyor.
Yeni yıl kararlarını somut planlara dönüştürme zamanı.

Ocak ayı Satürn enerjisi taşır - yapı, disiplin ve uzun vadeli hedefler.
Hayallerini gerçeğe dönüştürecek temelleri şimdi at.
''',
    ),
    2: MonthlyTheme(
      month: 'Şubat',
      sign: 'Kova',
      generalTheme: 'İnovasyon ve Topluluk',
      keyPhrases: ['Özgünlük', 'Sosyal bağlar', 'Geleceği hayal etme'],
      collectiveEnergy: '''
Kova sezonu yenilik ve bağımsızlık getiriyor. Topluluk, arkadaşlık
ve insanlığa hizmet temaları öne çıkıyor.

Sevgililer Günü bu ayda - ama Kova enerjisi geleneksel romantizm
yerine benzersiz bağlantılar arıyor.
''',
    ),
    3: MonthlyTheme(
      month: 'Mart',
      sign: 'Balık',
      generalTheme: 'Maneviyat ve Yaratıcılık',
      keyPhrases: ['Sezgi', 'Rüyalar', 'Sanat', 'Şifa'],
      collectiveEnergy: '''
Balık sezonu mistik ve ruhani enerjiler getiriyor. Meditasyon,
sanat ve rüyalara dikkat için ideal zaman.

Bahar ekinoksu bu ayda - yeniden doğuş enerjisi. Kış uykusundan
uyanış ve yeni başlangıçlar için hazırlık.
''',
    ),
    4: MonthlyTheme(
      month: 'Nisan',
      sign: 'Koç',
      generalTheme: 'Eylem ve Yeni Başlangıçlar',
      keyPhrases: ['Cesaret', 'Başlatma', 'Enerji patlaması'],
      collectiveEnergy: '''
Koç sezonu! Zodyakın yeni yılı başlıyor. Enerji, cesaret ve
girişimcilik dorukta. Harekete geç!

Mars enerjisi her yerde. Projeler başlat, riskler al, öncü ol.
Tereddüt için zaman yok - şimdi!
''',
    ),
    5: MonthlyTheme(
      month: 'Mayıs',
      sign: 'Boğa',
      generalTheme: 'Değer ve Duyusal Zevkler',
      keyPhrases: ['İstikrar', 'Güzellik', 'Toprak', 'Bolluk'],
      collectiveEnergy: '''
Boğa sezonu yavaşlama ve tadını çıkarma zamanı. Baharın tam
ortasında doğa canlanıyor - ve sen de.

Değerler, finans ve duyusal zevkler öne çıkıyor. Ne istiyorsun?
Neye değer veriyorsun? Yanıtları bul.
''',
    ),
    6: MonthlyTheme(
      month: 'Haziran',
      sign: 'İkizler',
      generalTheme: 'İletişim ve Hareket',
      keyPhrases: ['Merak', 'Öğrenme', 'Sosyalleşme', 'Çeşitlilik'],
      collectiveEnergy: '''
İkizler sezonu - zihinsel aktivite zirveye çıkıyor! İletişim,
öğrenme ve sosyal bağlantılar hızlanıyor.

Yaz gündönümü bu ayda - yılın en uzun günü. Kutla, paylaş,
bağlan. Sosyal takvimin dolu olacak.
''',
    ),
    7: MonthlyTheme(
      month: 'Temmuz',
      sign: 'Yengeç',
      generalTheme: 'Ev ve Duygusal Kökler',
      keyPhrases: ['Aile', 'Yuva', 'Nostalji', 'Bakım'],
      collectiveEnergy: '''
Yengeç sezonu - ev, aile ve duygusal güvenlik ön planda.
Köklerine dön, sevdiklerinle vakit geçir.

Yaz tatili sezonu başlıyor. Dinlenme, yeniden şarj olma ve
duygusal bağları güçlendirme zamanı.
''',
    ),
    8: MonthlyTheme(
      month: 'Ağustos',
      sign: 'Aslan',
      generalTheme: 'Yaratıcılık ve Özgüven',
      keyPhrases: ['Parıldama', 'Eğlence', 'Romantizm', 'Liderlik'],
      collectiveEnergy: '''
Aslan sezonu - parıldama zamanı! Yaratıcılık, özgüven ve
bireysel ifade zirveye ulaşıyor.

Güneş kendi burcunda en güçlü. Işığını dünyayla paylaş,
sahnede yerini al. Seni görmelerini sağla!
''',
    ),
    9: MonthlyTheme(
      month: 'Eylül',
      sign: 'Başak',
      generalTheme: 'Düzen ve İyileştirme',
      keyPhrases: ['Analiz', 'Sağlık', 'Hizmet', 'Detaylar'],
      collectiveEnergy: '''
Başak sezonu - düzene koyma zamanı! Yaz gevşekliğinden sonra
odaklanma, organize olma ve sağlık ön planda.

Okul başlıyor, rutinler yeniden kuruluyor. Analitik düşünce
ve pratik iyileştirmeler için ideal.
''',
    ),
    10: MonthlyTheme(
      month: 'Ekim',
      sign: 'Terazi',
      generalTheme: 'Denge ve İlişkiler',
      keyPhrases: ['Ortaklık', 'Uyum', 'Güzellik', 'Adalet'],
      collectiveEnergy: '''
Terazi sezonu - ilişkiler ve denge merkeze alınıyor. Birliktelik,
ortaklık ve sosyal uyum vurgulanıyor.

Sonbahar ekinoksu - gece ve gündüz dengede. Hayatında dengeyi
sağlayacak ayarlamalar yap.
''',
    ),
    11: MonthlyTheme(
      month: 'Kasım',
      sign: 'Akrep',
      generalTheme: 'Dönüşüm ve Derinlik',
      keyPhrases: ['Yoğunluk', 'Gizem', 'Yeniden doğuş', 'Güç'],
      collectiveEnergy: '''
Akrep sezonu - derinliklere dalış! Dönüşüm, psikolojik farkındalık
ve gizli gerçekler gün yüzüne çıkıyor.

Ölüler Günü temaları - atalara saygı, ölüm ve yeniden doğuş.
Bırakman gerekenleri bırak, dönüşümü kucakla.
''',
    ),
    12: MonthlyTheme(
      month: 'Aralık',
      sign: 'Yay',
      generalTheme: 'Genişleme ve Kutlama',
      keyPhrases: ['İyimserlik', 'Seyahat', 'Felsefe', 'Şükran'],
      collectiveEnergy: '''
Yay sezonu - genişleme ve iyimserlik! Tatil sezonu, kutlamalar
ve yılın değerlendirmesi zamanı.

Kış gündönümü - karanlıktan aydınlığa dönüş. Şükran, umut ve
yeni yıl için hazırlık.
''',
    ),
  };

  /// Her burç için aylık yorum alanları
  static const List<String> monthlySections = [
    'Ayın Genel Teması',
    'Önemli Tarihler',
    'Yeni Ay ve Dolunay Etkileri',
    'Aşk ve İlişkiler Aylığı',
    'Kariyer ve Finans Aylığı',
    'Sağlık ve Wellness',
    'Kişisel Gelişim',
    'Ayın Tavsiyesi',
    'Şanslı Günler',
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// YILLIK BURÇ YORUMLARI
// ════════════════════════════════════════════════════════════════════════════

class YearlyHoroscopeContent {
  /// Yıllık yorum yapısı
  static const YearlyStructure structure = YearlyStructure(
    sections: [
      'Yılın Genel Teması',
      'Önemli Gezegen Transitları',
      'Aşk ve İlişkiler Yıllık',
      'Kariyer ve Finans Yıllık',
      'Sağlık ve Wellness',
      'Spiritüel Gelişim',
      'Yılın Dönemleri (3 aylık)',
      'Kritik Tarihler',
      'Yılın Tavsiyesi',
    ],
    quarterlyBreakdown: true,
    monthlyHighlights: true,
    luckyDays: true,
  );

  /// Dış gezegen transitlerinin uzun vadeli etkileri
  static const Map<String, LongTermTransit> majorTransits = {
    'pluto_in_aquarius': LongTermTransit(
      transit: 'Plüton Kova\'da',
      period: '2024-2044',
      generalTheme: 'Toplumsal dönüşüm ve teknoloji devrimi',
      collectiveEffect: '''
Plüton Kova'ya geçişi, nesiller boyu toplumu şekillendirecek
devasa bir dönüşüm başlatıyor.

TEMALAR:
• Teknoloji ve yapay zeka devrimi
• Toplumsal yapıların dönüşümü
• Bireysel özgürlük vs. kollektif
• Yeni güç yapıları
• Dijital dünya evrimi

BİREYSEL ETKİ:
Kova evine göre hayatında hangi alan dönüşüyor? Kendi
Plüton transitlerinin bu büyük dalganın parçası.
''',
      signEffects: {
        'aries': 'Sosyal çevren ve gelecek vizyonun dönüşüyor',
        'taurus': 'Kariyer ve kamusal imajın yeniden yapılanıyor',
        'gemini': 'Felsefe, inançlar ve yabancı bağlantılar dönüşüyor',
        'cancer': 'Derin psikolojik dönüşüm, ortak kaynaklar',
        'leo': 'İlişkiler ve ortaklıklar köklü dönüşüm geçiriyor',
        'virgo': 'Günlük yaşam, sağlık ve iş rutinleri değişiyor',
        'libra': 'Yaratıcılık, romantizm ve çocuklarla ilişki dönüşüyor',
        'scorpio': 'Ev, aile ve duygusal temel yeniden yapılanıyor',
        'sagittarius': 'İletişim, öğrenme ve kardeşlerle ilişki dönüşüyor',
        'capricorn': 'Değerler ve finansal yapın köklü değişiyor',
        'aquarius': 'KİMLİĞİN TAMAMIYLA DÖNÜŞÜYOR - yeniden doğuş',
        'pisces': 'Bilinçaltı, maneviyat ve gizli düşmanlar',
      },
    ),
    'neptune_in_aries': LongTermTransit(
      transit: 'Neptün Koç\'a Geçiyor',
      period: '2025-2039',
      generalTheme: 'Kolektif rüyaların yeni başlangıçları',
      collectiveEffect: '''
Neptün 2025'te Koç'a giriyor - 165 yıl sonra ilk kez!
Yeni bir kolektif rüya, yeni ilham çağı başlıyor.

TEMALAR:
• Spiritüel öncülük ve liderlik
• Yeni sanat ve müzik akımları
• Kolektif vizyonların yenilenmesi
• İnanç sistemlerinde devrim
• Teknoloji ve maneviyat birleşimi

Bu transit kuşakları etkileyecek büyük bir enerji değişimi.
''',
      signEffects: {
        'aries': 'BÜYÜK MANEVİ UYANIS - kimliğinin ruhsal dönüşümü',
        'taurus': 'Bilinçaltı ve rüyalar çok aktif',
        'gemini': 'Sosyal çevre ve idealler bulanıklaşıp netleşiyor',
        'cancer': 'Kariyer vizyonu ve hayat amacı yeniden tanımlanıyor',
        'leo': 'Felsefi ve spiritüel arayışlar yoğunlaşıyor',
        'virgo': 'Derin duygusal ve finansal konularda sezgisel rehberlik',
        'libra': 'İlişkilerde maneviyat ve kayıp sınırlar',
        'scorpio': 'Günlük yaşamda ilham ve hizmet',
        'sagittarius': 'Yaratıcılık ve romantizmde mistik boyut',
        'capricorn': 'Ev ve ailede spiritüel şifa',
        'aquarius': 'İletişimde sezgi ve telepati',
        'pisces': 'Değerlerde ve öz-değerde dönüşüm',
      },
    ),
    'uranus_in_gemini': LongTermTransit(
      transit: 'Uranüs İkizler\'e Geçiyor',
      period: '2025-2033',
      generalTheme: 'İletişim ve bilgi devrimi',
      collectiveEffect: '''
Uranüs 2025'te İkizler'e giriyor - iletişim, bilgi ve
medyada devrim başlıyor.

TEMALAR:
• Bilgi erişiminde devrim
• Medya ve haberleşme dönüşümü
• Eğitim sistemlerinin yenilenmesi
• Yapay zeka ve dil
• Seyahat ve ulaşımda inovasyon

84 yılda bir döngü - son kez 1940'larda!
''',
      signEffects: {
        'aries': 'İletişim ve öğrenme tarzın devrim geçiriyor',
        'taurus': 'Finansal değerler ve kazanç yöntemleri sarsılıyor',
        'gemini': 'KİMLİĞİN TAMAMIYLA DEVRİME UĞRUYOR',
        'cancer': 'Bilinçaltı ve maneviyatta beklenmedik uyanışlar',
        'leo': 'Sosyal çevre ve gelecek vizyonunda sürprizler',
        'virgo': 'Kariyer ve kamusal rolde ani değişiklikler',
        'libra': 'İnançlar ve yabancı bağlantılarda devrim',
        'scorpio': 'Ortak kaynaklar ve derin bağlarda sarsıntı',
        'sagittarius': 'İlişkilerde özgürlük ve beklenmedik gelişmeler',
        'capricorn': 'Günlük rutinlerde ve sağlıkta ani değişimler',
        'aquarius': 'Yaratıcılık ve romantizmde inovasyon',
        'pisces': 'Ev ve ailede beklenmedik dönüşümler',
      },
    ),
  };
}

// ════════════════════════════════════════════════════════════════════════════
// MODEL SINIFLAR
// ════════════════════════════════════════════════════════════════════════════

class MoonPhaseTheme {
  final String phase;
  final String generalTheme;
  final String energyLevel;
  final List<String> bestFor;
  final List<String> avoid;
  final String affirmation;

  const MoonPhaseTheme({
    required this.phase,
    required this.generalTheme,
    required this.energyLevel,
    required this.bestFor,
    required this.avoid,
    required this.affirmation,
  });
}

class DayPlanetaryEnergy {
  final String day;
  final String rulingPlanet;
  final String planetSymbol;
  final String theme;
  final List<String> bestActivities;
  final String color;
  final String crystal;
  final String affirmation;

  const DayPlanetaryEnergy({
    required this.day,
    required this.rulingPlanet,
    required this.planetSymbol,
    required this.theme,
    required this.bestActivities,
    required this.color,
    required this.crystal,
    required this.affirmation,
  });
}

class DailyHoroscopeAreas {
  final String area;
  final String icon;
  final List<String> questions;

  const DailyHoroscopeAreas({
    required this.area,
    required this.icon,
    required this.questions,
  });
}

class WeeklyStructure {
  final List<String> sections;
  final bool dailyHighlights;
  final bool luckyNumbers;
  final bool luckyColors;

  const WeeklyStructure({
    required this.sections,
    required this.dailyHighlights,
    required this.luckyNumbers,
    required this.luckyColors,
  });
}

class WeeklyTheme {
  final String theme;
  final String generalAdvice;
  final List<String> doList;
  final List<String> dontList;

  const WeeklyTheme({
    required this.theme,
    required this.generalAdvice,
    required this.doList,
    required this.dontList,
  });
}

class MonthlyTheme {
  final String month;
  final String sign;
  final String generalTheme;
  final List<String> keyPhrases;
  final String collectiveEnergy;

  const MonthlyTheme({
    required this.month,
    required this.sign,
    required this.generalTheme,
    required this.keyPhrases,
    required this.collectiveEnergy,
  });
}

class YearlyStructure {
  final List<String> sections;
  final bool quarterlyBreakdown;
  final bool monthlyHighlights;
  final bool luckyDays;

  const YearlyStructure({
    required this.sections,
    required this.quarterlyBreakdown,
    required this.monthlyHighlights,
    required this.luckyDays,
  });
}

class LongTermTransit {
  final String transit;
  final String period;
  final String generalTheme;
  final String collectiveEffect;
  final Map<String, String> signEffects;

  const LongTermTransit({
    required this.transit,
    required this.period,
    required this.generalTheme,
    required this.collectiveEffect,
    required this.signEffects,
  });
}
