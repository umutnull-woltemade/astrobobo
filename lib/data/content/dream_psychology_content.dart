/// Dream Psychology Content - Freud, Jung, Gestalt, ve Modern Yaklaşımlar
/// Derinlemesine psikolojik rüya analizi içeriği
library;

// ════════════════════════════════════════════════════════════════════════════
// JUNG PSİKOLOJİSİ - DERİNLİK PSİKOLOJİSİ
// ════════════════════════════════════════════════════════════════════════════

/// Jungian rüya analizi sistemi
class JungianDreamPsychology {
  /// Kolektif Bilinçdışı Arketipleri
  static const Map<String, ArchetypeDeepAnalysis> arketipler = {
    'shadow': ArchetypeDeepAnalysis(
      name: 'Gölge (Shadow)',
      emoji: '🌑',
      description:
          'Ego tarafından reddedilen, bastırılan veya kabul edilmeyen kişilik yönleri. '
          'Rüyalarda genellikle tehdit edici, korkutucu veya utanç verici figürler olarak belirir.',
      manifestations: [
        'Kovalayan tehlikeli figürler',
        'Tanımadığın ama tanıdık gelen insanlar',
        'Aynı cinsiyetten rahatsız edici karakterler',
        'Suçlu, hırsız, katil figürleri',
        'Vahşi veya tehlikeli hayvanlar',
        'Karanlık, yeraltı mekanları',
      ],
      integrationPath:
          'Gölge ile yüzleşme, onu reddetmek yerine anlamaya çalışmaktır. '
          '"Bu figür bana ne öğretmek istiyor?" sorusu sorulmalı.',
      questions: [
        'Bu figür hangi yönümü temsil ediyor?',
        'Hayatımda neyi bastırıyorum?',
        'Bu "düşman" aslında hangi gücümü taşıyor?',
        'Onu kucaklasam ne olur?',
      ],
      healingAffirmation:
          'Karanlığım da ışığım kadar benim bir parçam. Tüm yönlerimle barışıyorum.',
      relatedSymbols: ['kurt', 'yılan', 'canavar', 'hırsız', 'karanlık'],
    ),
    'anima': ArchetypeDeepAnalysis(
      name: 'Anima (İç Kadın)',
      emoji: '🌙',
      description:
          'Erkeklerin bilinçdışındaki feminen yön. Duyguları, sezgiyi, yaratıcılığı '
          've ilişkilenme kapasitesini temsil eder.',
      manifestations: [
        'Gizemli, çekici kadın figürleri',
        'Bilge kadın, büyücü kadın',
        'Kurtarılması gereken prenses',
        'Tehlikeli, baştan çıkarıcı kadın',
        'Anne figürü (olumlu/olumsuz)',
        'Deniz kızı, peri, melek',
      ],
      integrationPath:
          'Anima entegrasyonu, duygusal zekayı geliştirmek ve feminen enerjiyi '
          'kabul etmektir. İlişkilerdeki kalıpları anlamak için anahtar.',
      questions: [
        'Bu kadın figürü hangi duygumu temsil ediyor?',
        'İlişkilerimde hangi kalıp tekrar ediyor?',
        'Feminen enerjimle barışık mıyım?',
        'Sezgilerimi ne kadar dinliyorum?',
      ],
      healingAffirmation:
          'İçimdeki feminen bilgeliği onurlandırıyorum. Sezgilerime güveniyorum.',
      relatedSymbols: ['ay', 'su', 'deniz', 'mağara', 'çiçek', 'ayna'],
    ),
    'animus': ArchetypeDeepAnalysis(
      name: 'Animus (İç Erkek)',
      emoji: '☀️',
      description:
          'Kadınların bilinçdışındaki maskülen yön. Mantığı, eylemi, kararlılığı '
          've dış dünyayla ilişkilenmeyi temsil eder.',
      manifestations: [
        'Güçlü, koruyucu erkek figürleri',
        'Bilge yaşlı adam',
        'Kral, prens, kahraman',
        'Tehlikeli, saldırgan erkek',
        'Baba figürü (olumlu/olumsuz)',
        'Öğretmen, rehber, mentor',
      ],
      integrationPath:
          'Animus entegrasyonu, iç otoriteyi geliştirmek ve maskülen enerjiyi '
          'sağlıklı şekilde ifade etmektir. Özgüven ve eylem kapasitesi.',
      questions: [
        'Bu erkek figürü hangi gücümü temsil ediyor?',
        'Kendi otoriteme ne kadar güveniyorum?',
        'Hayatımda kim adına hareket ediyorum?',
        'Maskülen enerjimi nasıl ifade ediyorum?',
      ],
      healingAffirmation:
          'Kendi gücüme ve otoriteme sahip çıkıyorum. Eylemlerimde kararlıyım.',
      relatedSymbols: ['güneş', 'kılıç', 'dağ', 'kartal', 'ateş', 'aslan'],
    ),
    'self': ArchetypeDeepAnalysis(
      name: 'Benlik (Self)',
      emoji: '☯️',
      description:
          'Kişiliğin bütünlüğü, tüm zıtlıkların birleşimi. Jung\'un en yüksek '
          'arketipi, bireyleşme sürecinin hedefi.',
      manifestations: [
        'Mandala, daire, küre şekilleri',
        'Altın, elmas, değerli taşlar',
        'Bilge yaşlı figürler (her iki cins)',
        'Işık, aydınlanma deneyimleri',
        'Merkez, kale, tapınak',
        'Çocuk figürü (ilahi çocuk)',
      ],
      integrationPath:
          'Benlik ile bağlantı, bireyleşme yolculuğunun ödülüdür. Tüm arketiplerin '
          'entegrasyonu sonucu ortaya çıkan bütünlük hissi.',
      questions: [
        'Hayatımın anlamı nedir?',
        'Tüm yönlerimi nasıl bütünleyebilirim?',
        'Gerçek potansiyelim ne?',
        'En derin değerlerim neler?',
      ],
      healingAffirmation:
          'Ben bir bütünüm. Tüm parçalarım uyum içinde dans ediyor.',
      relatedSymbols: ['mandala', 'güneş', 'taç', 'elmas', 'ağaç', 'merkez'],
    ),
    'persona': ArchetypeDeepAnalysis(
      name: 'Persona (Maske)',
      emoji: '🎭',
      description:
          'Sosyal kimlik, dünyaya gösterdiğimiz yüz. Toplumsal beklentilere '
          'uyum sağlamak için geliştirilen dış kimlik.',
      manifestations: [
        'Maske takmak, kostüm giymek',
        'Tanınmama, kimlik karışıklığı',
        'Sahne, performans rüyaları',
        'Çıplak kalma (persona kaybı)',
        'Kıyafet değiştirme',
        'Ayna/yansıma sorunları',
      ],
      integrationPath:
          'Persona\'nın farkında olmak, sosyal kimliğimizin kim olduğumuz olmadığını '
          'anlamaktır. Otantiklik ile sosyal uyum arasında denge.',
      questions: [
        'Gerçekten ben miyim yoksa rol mü oynuyorum?',
        'Hangi maskelerim var?',
        'Maskemin altında kim var?',
        'Otantik olmak ne demek benim için?',
      ],
      healingAffirmation:
          'Maskelerimi tanıyorum ama onlar ben değil. Gerçek benliğimi ifade etme cesaretim var.',
      relatedSymbols: ['maske', 'ayna', 'sahne', 'kostüm', 'yüz'],
    ),
    'hero': ArchetypeDeepAnalysis(
      name: 'Kahraman (Hero)',
      emoji: '⚔️',
      description:
          'Ego\'nun gelişimi ve güçlenmesi. Zorlukların üstesinden gelme, '
          'engelleri aşma, cesaret ve irade.',
      manifestations: [
        'Canavar öldürme, savaş',
        'Engelleri aşma, tırmanma',
        'Kurtarma görevleri',
        'Yolculuk, macera',
        'Test ve sınavlar',
        'Zafer anları',
      ],
      integrationPath:
          'Kahraman arketipi, ego gücünü geliştirmek için gereklidir ancak '
          'enflasyona (şişirilmiş ego) dikkat edilmeli.',
      questions: [
        'Hangi zorluklarla yüzleşiyorum?',
        'İçimdeki kahraman ne istiyor?',
        'Neyi kurtarmaya çalışıyorum?',
        'Cesaret nereden geliyor?',
      ],
      healingAffirmation: 'Kendi kahramanımım. Zorluklarla yüzleşme gücüm var.',
      relatedSymbols: ['kılıç', 'ejderha', 'yol', 'dağ', 'hazine'],
    ),
    'trickster': ArchetypeDeepAnalysis(
      name: 'Düzenbaz (Trickster)',
      emoji: '🃏',
      description:
          'Kuralları yıkan, beklenmedik değişim getiren enerji. Kaos, şaka, '
          'dönüşüm ve sınırları aşma.',
      manifestations: [
        'Palyaço, joker figürleri',
        'Tilki, karga, maymun',
        'Absürt, mantıksız durumlar',
        'Şakalar, oyunlar, aldatmacalar',
        'Rollerin değişmesi',
        'Beklenmedik dönüşler',
      ],
      integrationPath:
          'Trickster, katı yapıları kırmak ve yeni perspektifler kazanmak için '
          'gereklidir. Mizah ve esneklik öğretir.',
      questions: [
        'Hayatımda neyi çok ciddiye alıyorum?',
        'Hangi kurallar beni kısıtlıyor?',
        'Oyunculuğumu nasıl ifade edebilirim?',
        'Kaos bana ne öğretiyor?',
      ],
      healingAffirmation:
          'Hayata hafiflikle yaklaşabilirim. Değişim benim dostumdur.',
      relatedSymbols: ['tilki', 'maymun', 'palyaço', 'karga', 'joker'],
    ),
    'wise_old_man': ArchetypeDeepAnalysis(
      name: 'Bilge Yaşlı (Wise Old Man/Woman)',
      emoji: '🧙',
      description:
          'İçsel bilgelik, rehberlik, anlam arayışı. Spiritüel öğretmen, '
          'mentor, içsel ses.',
      manifestations: [
        'Yaşlı bilge figürler',
        'Büyücü, şaman, keşiş',
        'Öğretmen, profesör',
        'Dini liderler',
        'Ata ruhları',
        'Konuşan hayvanlar (bilge)',
      ],
      integrationPath:
          'Bilge Yaşlı ile bağlantı, içsel rehberliğe güvenmek ve hayatın '
          'derin anlamlarını araştırmaktır.',
      questions: [
        'İçsel bilgeliğime ne kadar güveniyorum?',
        'Hayatımda kim benim mentorum?',
        'Hangi derin soruları sormaktan kaçınıyorum?',
        'Spiritüel yolculuğum nerede?',
      ],
      healingAffirmation:
          'İçimdeki bilge sese kulak veriyorum. Rehberlik her zaman mevcut.',
      relatedSymbols: ['kitap', 'asa', 'baykuş', 'dağ', 'yıldız'],
    ),
    'great_mother': ArchetypeDeepAnalysis(
      name: 'Büyük Anne (Great Mother)',
      emoji: '🌍',
      description:
          'Yaratıcı ve yıkıcı anne enerjisi. Beslenme, koruma, doğurganlık '
          'ama aynı zamanda yutma, boğma, kontrol.',
      manifestations: [
        'Anne figürleri (olumlu/olumsuz)',
        'Doğa ana, toprak, deniz',
        'Mağara, ev, yuva',
        'Hamilelik, doğum',
        'Yiyecek, beslenme',
        'Büyük hayvanlar (ayı, inek)',
      ],
      integrationPath:
          'Büyük Anne arketipi, bağımlılık ile bağımsızlık arasındaki dengeyi '
          'bulmaktır. Hem beslenme hem de bireyselleşme.',
      questions: [
        'Annemle ilişkim nasıl?',
        'Kendimi besliyor muyum?',
        'Bağımlılık kalıplarım var mı?',
        'Yaratıcı enerjimi nasıl kullanıyorum?',
      ],
      healingAffirmation:
          'Kendimi besleyebilir ve koruyabilirim. İçimdeki anne enerjisiyle barışıyorum.',
      relatedSymbols: ['toprak', 'mağara', 'deniz', 'ay', 'çiçek', 'ağaç'],
    ),
    'divine_child': ArchetypeDeepAnalysis(
      name: 'İlahi Çocuk (Divine Child)',
      emoji: '👶',
      description:
          'Saflık, potansiyel, yenilenme. Yaratıcılık, merak, yeni başlangıçlar '
          've gelecek vaadi.',
      manifestations: [
        'Bebek, küçük çocuk',
        'Kayıp çocuk (terk edilmiş)',
        'Harika çocuk (özel güçler)',
        'Oyun, yaratıcılık',
        'Masumiyet',
        'Yeni başlangıçlar',
      ],
      integrationPath:
          'İlahi Çocuk, iç çocuğumuzu şifalandırmak ve yaratıcılığımızı '
          'yeniden keşfetmektir.',
      questions: [
        'İç çocuğum nasıl?',
        'Neşemi ne zaman kaybettim?',
        'Yaratıcılığımı bastırıyor muyum?',
        'Yenilenmeye hazır mıyım?',
      ],
      healingAffirmation:
          'İç çocuğumla oynayabilir, onun neşesini yeniden keşfedebilirim.',
      relatedSymbols: ['bebek', 'oyuncak', 'güneş', 'kuş', 'çiçek'],
    ),
  };

  /// Bireyleşme Süreci (Individuation)
  static const IndividuationProcess bireylesmeSureci = IndividuationProcess(
    description:
        'Jung\'un bireyleşme (individuation) kavramı, kişinin kendi benzersiz '
        'bütünlüğünü gerçekleştirme sürecidir. Rüyalar bu sürecin haritasıdır.',
    stages: [
      IndividuationStage(
        name: 'Persona Farkındalığı',
        description: 'Sosyal maskelerin tanınması ve sorgulanması',
        dreamSigns: ['Maske düşmesi', 'Çıplaklık', 'Kimlik karışıklığı'],
        task: 'Kim olduğun ile kim göründüğün arasındaki farkı anla',
      ),
      IndividuationStage(
        name: 'Gölge ile Yüzleşme',
        description: 'Bastırılan yönlerin kabul edilmesi',
        dreamSigns: ['Düşman figürler', 'Karanlık yerler', 'Kovalanma'],
        task: 'Reddettiğin yönlerini kucakla',
      ),
      IndividuationStage(
        name: 'Anima/Animus Entegrasyonu',
        description: 'Karşı cinsiyet enerjisinin dengelenmesi',
        dreamSigns: ['Aşk rüyaları', 'Gizemli figürler', 'Birleşme'],
        task: 'İç feminen/maskülen dengeyi bul',
      ),
      IndividuationStage(
        name: 'Benlik Gerçekleşmesi',
        description: 'Bütünlük ve anlam deneyimi',
        dreamSigns: ['Mandala', 'Merkez', 'Aydınlanma', 'Hazine bulma'],
        task: 'Tüm parçaları birleştir, bütün ol',
      ),
    ],
  );

  /// Rüya Amplifikasyonu
  static const List<AmplificationTechnique> amplifikasyonTeknikleri = [
    AmplificationTechnique(
      name: 'Mitolojik Amplifikasyon',
      description:
          'Rüya sembollerini dünya mitolojileriyle ilişkilendirme. '
          'Evrensel hikayelerle kişisel anlamı derinleştirme.',
      steps: [
        'Rüyadaki ana sembolü belirle',
        'Bu sembolün mitolojideki karşılıklarını araştır',
        'Farklı kültürlerdeki benzer hikayeleri incele',
        'Kişisel bağlantını kur',
        'Mitin öğretisini hayatına uygula',
      ],
      example:
          'Yılan rüyası → Gilgameş destanında ölümsüzlük bitkisini çalan yılan → '
          'Asklepios\'un şifa yılanı → Kundalini enerjisi → Dönüşüm ve şifa teması',
    ),
    AmplificationTechnique(
      name: 'Sembolik Seri Analizi',
      description:
          'Birden fazla rüyayı bir seri olarak inceleme. '
          'Tekrar eden semboller ve evrimleşen temalar.',
      steps: [
        'Son 10-20 rüyayı gözden geçir',
        'Tekrar eden sembolleri listele',
        'Sembollerin evrimini izle',
        'Bir "rüya hikayesi" oluştur',
        'Ana tema ve mesajı belirle',
      ],
      example:
          'İlk rüya: Boğulma → 3. rüya: Yüzme öğrenme → 7. rüya: Dalma → '
          '10. rüya: Sualtı hazinesi → Duygusal derinleşme yolculuğu',
    ),
    AmplificationTechnique(
      name: 'Aktif İmajinasyon',
      description:
          'Jung\'un geliştirdiği teknik. Rüya imajlarıyla uyanıkken diyalog kurma.',
      steps: [
        'Rahat bir pozisyonda otur, gözlerini kapat',
        'Rüyadaki bir imajı çağır',
        'İmajın hareket etmesine izin ver',
        'İmajla konuş, sorular sor',
        'Diyaloğu kaydet',
      ],
      example:
          'Rüyadaki bilge kadına: "Kim sin?" → "Sezginin sesiyim" → '
          '"Ne öğretmek istiyorsun?" → "Düşünmeden önce hisset"',
    ),
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// FREUD PSİKANALİZİ
// ════════════════════════════════════════════════════════════════════════════

/// Freudian rüya analizi
class FreudianDreamPsychology {
  /// Temel kavramlar
  static const FreudianTheory temelTeori = FreudianTheory(
    wishFulfillment:
        'Freud\'a göre her rüya bir dilek gerçekleştirmesidir. Bilinçdışı arzular, '
        'gündüz bastırılanlar gece sembolik olarak ifade bulur.',
    latentContent:
        'Rüyanın gizli içeriği (latent content) - gerçek anlam. '
        'Sansürden geçerek manifest içerik haline dönüşür.',
    manifestContent:
        'Rüyanın açık içeriği (manifest content) - hatırlanan hikaye. '
        'Gizli içeriğin sembolik kılığı.',
    dreamWork:
        'Rüya çalışması (dream work) - bilinçdışı materyalin rüyaya dönüşüm süreci. '
        'Yoğunlaştırma, yer değiştirme, sembolleştirme.',
  );

  /// Rüya mekanizmaları
  static const List<DreamMechanism> mekanizmalar = [
    DreamMechanism(
      name: 'Yoğunlaştırma (Condensation)',
      description:
          'Birden fazla fikir, kişi veya duygu tek bir imajda birleşir. '
          'Rüyadaki tek bir figür birçok anlamı temsil edebilir.',
      examples: [
        'Bir yüz birçok kişinin özelliklerini taşıyabilir',
        'Tek bir mekan birden fazla yeri temsil edebilir',
        'Bir nesne birçok duyguyu simgeleyebilir',
      ],
      interpretationTip:
          'Rüyadaki her öğenin birden fazla çağrışımı olabileceğini düşün. '
          '"Bu imaj başka neyi hatırlatıyor?" sorusunu sor.',
    ),
    DreamMechanism(
      name: 'Yer Değiştirme (Displacement)',
      description:
          'Duygusal yük önemli bir nesneden daha az önemli bir nesneye kaydırılır. '
          'Rüyanın en yoğun kısmı gerçek mesajı gizleyebilir.',
      examples: [
        'Anneye duyulan öfke bir yabancıya yöneltilir',
        'Cinsel arzu bir nesneye simgelenir',
        'Korku zararsız bir figürde belirir',
      ],
      interpretationTip:
          'Rüyanın en duygusal kısmı değil, en "anlamsız" kısmı önemli olabilir. '
          'Önemsiz görünen detaylara dikkat et.',
    ),
    DreamMechanism(
      name: 'Sembolleştirme (Symbolization)',
      description:
          'Yasak veya kabul edilemez içerikler sembollerle ifade edilir. '
          'Özellikle cinsel ve agresif içerikler.',
      examples: [
        'Uzun nesneler → Maskülen semboller',
        'Kapalı alanlar → Feminen semboller',
        'Silah, bıçak → Saldırganlık',
        'Merdiven çıkma → Cinsel eylem',
      ],
      interpretationTip:
          'Semboller evrensel olabilir ama kişisel çağrışımlar daha önemlidir. '
          '"Bu sembol SANA ne ifade ediyor?" sorusu.',
    ),
    DreamMechanism(
      name: 'İkincil İşleme (Secondary Revision)',
      description:
          'Uyanırken beyin rüyayı mantıklı bir hikayeye dönüştürmeye çalışır. '
          'Boşluklar doldurulur, tutarsızlıklar düzeltilir.',
      examples: [
        'Rüyayı anlatırken "mantıklı" hale getirmek',
        'Eksik kısımları tamamlamak',
        'Tutarsız sahneleri birleştirmek',
      ],
      interpretationTip:
          'Rüyanın tutarsız, mantıksız kısımları önemli. '
          'Onları "düzeltme" dürtüsüne diren.',
    ),
  ];

  /// Freudian semboller
  static const Map<String, FreudianSymbol> semboller = {
    // Maskülen semboller
    'yilan': FreudianSymbol(
      symbol: 'Yılan',
      freudianMeaning: 'Fallik sembol, cinsel enerji, tehlike ve cazibe',
      unconsciousContent: 'Bastırılmış cinsellik veya erkeklik enerjisi',
      relatedFeelings: ['Korku', 'Çekim', 'Güç'],
    ),
    'kilic': FreudianSymbol(
      symbol: 'Kılıç',
      freudianMeaning: 'Maskülen güç, penetrasyon, saldırganlık',
      unconsciousContent: 'Kontrol arzusu, cinsel dürtüler',
      relatedFeelings: ['Güç', 'Saldırganlık', 'Koruma'],
    ),
    'silah': FreudianSymbol(
      symbol: 'Silah',
      freudianMeaning: 'Fallik sembol, güç, tehdit veya koruma',
      unconsciousContent: 'Bastırılmış öfke, kontrol ihtiyacı',
      relatedFeelings: ['Korku', 'Güç', 'Savunma'],
    ),
    // Feminen semboller
    'magara': FreudianSymbol(
      symbol: 'Mağara',
      freudianMeaning: 'Rahim sembolü, bilinçdışı, kadınlık',
      unconsciousContent: 'Anneye dönüş arzusu, güvenlik ihtiyacı',
      relatedFeelings: ['Güvenlik', 'Korku', 'Merak'],
    ),
    'ev': FreudianSymbol(
      symbol: 'Ev',
      freudianMeaning: 'Beden, benlik, aile. Katlar ruhun katmanları.',
      unconsciousContent: 'Öz-imaj, aile dinamikleri',
      relatedFeelings: ['Güvenlik', 'Kimlik', 'Aidiyet'],
    ),
    'su': FreudianSymbol(
      symbol: 'Su',
      freudianMeaning: 'Amniyotik sıvı, bilinçdışı, doğum',
      unconsciousContent: 'Duygusal dünya, anne ilişkisi',
      relatedFeelings: ['Sakinlik', 'Korku', 'Arınma'],
    ),
    // Diğer önemli semboller
    'ucmak': FreudianSymbol(
      symbol: 'Uçmak',
      freudianMeaning: 'Cinsel heyecan, özgürleşme, üstünlük',
      unconsciousContent: 'Kısıtlamalardan kaçış arzusu',
      relatedFeelings: ['Özgürlük', 'Heyecan', 'Korku'],
    ),
    'dusmek': FreudianSymbol(
      symbol: 'Düşmek',
      freudianMeaning: 'Kontrol kaybı, başarısızlık korkusu, cinsel teslim',
      unconsciousContent: 'Güvensizlik, ego tehdit altında',
      relatedFeelings: ['Korku', 'Çaresizlik', 'Panik'],
    ),
    'disler': FreudianSymbol(
      symbol: 'Dişler (dökülme)',
      freudianMeaning: 'Kastrasyon anksiyetesi, yaşlanma, güç kaybı',
      unconsciousContent: 'Cinsel/güç kaygıları',
      relatedFeelings: ['Utanç', 'Korku', 'Güçsüzlük'],
    ),
  };

  /// Serbest çağrışım tekniği
  static const FreeAssociationTechnique serbestCagrisim =
      FreeAssociationTechnique(
        description:
            'Freud\'un temel tekniği. Rüya öğelerinden başlayarak akla gelen '
            'her şeyi sansürsüz söyleme.',
        steps: [
          'Rüyadan bir imaj seç',
          'O imajla ilgili aklına gelen ilk şeyi söyle',
          'Sonra onunla ilgili aklına geleni...',
          'Zinciri takip et, sansürleme',
          'Direnç noktalarına dikkat et',
          'Duyguların yoğunlaştığı yere bak',
        ],
        tips: [
          'Mantıklı olmaya çalışma',
          'Utanç verici düşünceleri sansürleme',
          'Duraksadığın yerlere dikkat et',
          'Duygusal tepkileri not et',
        ],
      );
}

// ════════════════════════════════════════════════════════════════════════════
// GESTALT RÜYA ÇALIŞMASI
// ════════════════════════════════════════════════════════════════════════════

/// Gestalt rüya yaklaşımı
class GestaltDreamPsychology {
  static const String temelYaklasim =
      'Gestalt\'ta rüyanın her öğesi rüya görenin bir parçasıdır. '
      'Yorum yapmak yerine, rüyayı yeniden yaşamak ve her parçayı '
      '"olmak" önemlidir.';

  /// Gestalt teknikleri
  static const List<GestaltTechnique> teknikler = [
    GestaltTechnique(
      name: 'Sıcak Sandalye (Hot Seat)',
      description:
          'Rüyadaki farklı öğeler arasında diyalog kurma. Her parçaya ses verme.',
      steps: [
        'İki sandalye koy: Sen ve rüyadaki figür',
        'Figürün yerine otur, onun gibi konuş',
        'Kendi yerinde otur, figüre cevap ver',
        'Diyaloğu sürdür',
        'Duyguların değişimini izle',
      ],
      example:
          '"Ben rüyandaki kızgın köpeğim. Sana saldırıyorum çünkü..." → '
          '"Sana öfkeliyim çünkü beni ihmal ediyorsun."',
    ),
    GestaltTechnique(
      name: 'Her Şey Ben (I Am Everything)',
      description:
          'Rüyadaki her nesne, kişi, hatta mekan olarak konuş. Her şey seni temsil eder.',
      steps: [
        'Rüyadaki bir öğe seç',
        '"Ben [öğe]\'yim. Ben..." diye başla',
        'Birinci şahıs olarak tanımla',
        'Ne hissettiğini, ne istediğini söyle',
        'Diğer öğeler için tekrarla',
      ],
      example:
          '"Ben rüyadaki kapanmış kapıyım. Kapanmış tutuyorum çünkü...'
          'İçeride ne olduğunu göstermek istemiyorum."',
    ),
    GestaltTechnique(
      name: 'Şimdiki Zamanda Anlatım',
      description:
          'Rüyayı geçmiş zaman değil, şu an oluyormuş gibi anlat. '
          'Duyguları canlı tut.',
      steps: [
        'Rüyayı "şu an" olarak anlat',
        '"Gördüm" değil "görüyorum"',
        'Bedendeki duyumları hisset',
        'Duyguları isimlendirin',
        'Ne istediğini belirt',
      ],
      example:
          'Değil: "Bir ormanda koşuyordum, korkuyordum" → '
          'Evet: "Bir ormanda koşuyorum. Kalbim hızlı atıyor. Korkuyorum."',
    ),
    GestaltTechnique(
      name: 'Tamamlanmamış İş (Unfinished Business)',
      description:
          'Rüyadaki yarım kalan eylemleri tamamlama. Söylenmemiş sözleri söyleme.',
      steps: [
        'Rüyada ne yarım kaldı?',
        'Ne söylemek veya yapmak istedin?',
        'Şimdi tamamla (imajinasyonda)',
        'Duygusal değişimi gözlemle',
        'Bu kalıp hayatta nerelerde tekrar ediyor?',
      ],
      example:
          'Rüyada babama bağıramadım → Şimdi, boş sandalyeye babammış '
          'gibi: "Baba, sana kızgınım çünkü..."',
    ),
  ];

  /// Polariteler çalışması
  static const PolaritiesWork polariteler = PolaritiesWork(
    description:
        'Gestalt\'ta zıtlıklar önemlidir. Rüyadaki zıt öğeler '
        'kişiliğin bölünmüş parçalarıdır.',
    commonPolarities: [
      'Kovalayan / Kaçan',
      'Güçlü / Zayıf',
      'İyi / Kötü',
      'Korkutan / Korkan',
      'Veren / Alan',
      'Kontrol eden / Teslim olan',
    ],
    integration:
        'Her iki kutbu da deneyimle. Her ikisi de senin. '
        'Onları entegre etmek bütünlük getirir.',
  );
}

// ════════════════════════════════════════════════════════════════════════════
// MODERN BİLİŞSEL YAKLAŞIM
// ════════════════════════════════════════════════════════════════════════════

/// Modern bilişsel rüya teorisi
class CognitiveDreamTheory {
  static const String temelYaklasim =
      'Bilişsel yaklaşım rüyaları beynin gece boyunca bilgiyi işlemesi, '
      'anıları konsolide etmesi ve problem çözmesi olarak görür.';

  /// Bilişsel fonksiyonlar
  static const List<CognitiveFunction> fonksiyonlar = [
    CognitiveFunction(
      name: 'Bellek Konsolidasyonu',
      description:
          'Gündüz öğrenilenler gece REM uykusunda uzun süreli belleğe aktarılır.',
      dreamManifestation:
          'Gündüz deneyimleri rüyada tekrar eder, bazen değişmiş formda.',
      practicalUse:
          'Öğrenme öncesi iyi uyku önemli. Rüyalar öğrenmeyi pekiştirir.',
    ),
    CognitiveFunction(
      name: 'Duygusal İşleme',
      description:
          'REM uykusu duygusal anıları işler ve "soğutarak" depolamasını sağlar.',
      dreamManifestation:
          'Stresli olaylar rüyada tekrar işlenir. Travma rüyaları.',
      practicalUse:
          'Duygusal iyileşme için REM uykusu kritik. Uyku yoksunluğu kaygıyı artırır.',
    ),
    CognitiveFunction(
      name: 'Problem Çözme',
      description:
          'Beyin uyurken de problem üzerinde çalışır. Yaratıcı çözümler gelebilir.',
      dreamManifestation: 'Uyandığında "Ah!" anları. Rüyada çözüm bulma.',
      practicalUse:
          'Uyumadan önce problemi düşün. Sabah yeni fikirler olabilir.',
    ),
    CognitiveFunction(
      name: 'Tehdit Simülasyonu',
      description:
          'Evrimsel teori: Rüyalar tehlikeli durumları güvenle prova etmemizi sağlar.',
      dreamManifestation:
          'Kovalanma, savaş, kaçış rüyaları. Tehdit senaryoları.',
      practicalUse: 'Kâbuslar "antrenman" olabilir. Bilinçaltı hazırlık.',
    ),
  ];

  /// Rüya günlüğü için bilişsel sorular
  static const List<String> bilisselSorular = [
    'Bu rüya dünkü hangi olaylarla bağlantılı?',
    'Rüyadaki problem gerçek hayattaki neyi yansıtıyor?',
    'Rüyada hangi duygu yoğundu? Gündüz de bu duyguyu yaşıyor muyum?',
    'Rüya bir çözüm önerisi içeriyor mu?',
    'Beyin neyi "işliyor" olabilir?',
    'Bu rüya bir kalıbın parçası mı?',
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// MODEL SINIFLARI
// ════════════════════════════════════════════════════════════════════════════

class ArchetypeDeepAnalysis {
  final String name;
  final String emoji;
  final String description;
  final List<String> manifestations;
  final String integrationPath;
  final List<String> questions;
  final String healingAffirmation;
  final List<String> relatedSymbols;

  const ArchetypeDeepAnalysis({
    required this.name,
    required this.emoji,
    required this.description,
    required this.manifestations,
    required this.integrationPath,
    required this.questions,
    required this.healingAffirmation,
    required this.relatedSymbols,
  });
}

class IndividuationProcess {
  final String description;
  final List<IndividuationStage> stages;

  const IndividuationProcess({required this.description, required this.stages});
}

class IndividuationStage {
  final String name;
  final String description;
  final List<String> dreamSigns;
  final String task;

  const IndividuationStage({
    required this.name,
    required this.description,
    required this.dreamSigns,
    required this.task,
  });
}

class AmplificationTechnique {
  final String name;
  final String description;
  final List<String> steps;
  final String example;

  const AmplificationTechnique({
    required this.name,
    required this.description,
    required this.steps,
    required this.example,
  });
}

class FreudianTheory {
  final String wishFulfillment;
  final String latentContent;
  final String manifestContent;
  final String dreamWork;

  const FreudianTheory({
    required this.wishFulfillment,
    required this.latentContent,
    required this.manifestContent,
    required this.dreamWork,
  });
}

class DreamMechanism {
  final String name;
  final String description;
  final List<String> examples;
  final String interpretationTip;

  const DreamMechanism({
    required this.name,
    required this.description,
    required this.examples,
    required this.interpretationTip,
  });
}

class FreudianSymbol {
  final String symbol;
  final String freudianMeaning;
  final String unconsciousContent;
  final List<String> relatedFeelings;

  const FreudianSymbol({
    required this.symbol,
    required this.freudianMeaning,
    required this.unconsciousContent,
    required this.relatedFeelings,
  });
}

class FreeAssociationTechnique {
  final String description;
  final List<String> steps;
  final List<String> tips;

  const FreeAssociationTechnique({
    required this.description,
    required this.steps,
    required this.tips,
  });
}

class GestaltTechnique {
  final String name;
  final String description;
  final List<String> steps;
  final String example;

  const GestaltTechnique({
    required this.name,
    required this.description,
    required this.steps,
    required this.example,
  });
}

class PolaritiesWork {
  final String description;
  final List<String> commonPolarities;
  final String integration;

  const PolaritiesWork({
    required this.description,
    required this.commonPolarities,
    required this.integration,
  });
}

class CognitiveFunction {
  final String name;
  final String description;
  final String dreamManifestation;
  final String practicalUse;

  const CognitiveFunction({
    required this.name,
    required this.description,
    required this.dreamManifestation,
    required this.practicalUse,
  });
}
