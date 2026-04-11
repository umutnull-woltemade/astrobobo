/// Dream Content Expanded - Zenginleştirilmiş Rüya İçerikleri
/// 100+ Kadim Giriş, 50+ Yeni Sembol, Tekrarlayan Rüya Kalıpları, Kâbus Dönüşümleri
library;

import '../models/dream_interpretation_models.dart';

// ════════════════════════════════════════════════════════════════════════════
// KADİM GİRİŞ ŞABLONLARI - 100+ Varyasyon
// ════════════════════════════════════════════════════════════════════════════

/// Kadim giriş şablonları - mitolojik ve spiritüel
class KadimGirisTemplates {
  /// Genel kadim girişler
  static const List<String> genel = [
    'Kadim bilgeler derler ki, rüyalar ruhun aynadaki yansımasıdır. Bu gece bilinçaltın sana bir mesaj gönderdi.',
    'Binlerce yıldır rüya okuyucuları bilir: gece görülen her sembol, gündüz yaşanan bir hakikatin şifresidir.',
    'Antik Mısır tapınaklarında rüya yorumcuları kutsal kabul edilirdi. Çünkü rüya, tanrıların insanla konuşma dilidir.',
    'Sufi geleneğinde rüya "mükaşefe" - perdenin aralanmasıdır. Bu gece perde senin için aralandı.',
    'Jung şöyle derdi: "Rüya, egonun görmek istemediği gerçeği gösteren küçük gizli kapıdır."',
    'Şamanlar rüyayı "ruhun gece yolculuğu" olarak tanımlar. Bu gece ruhun nereye gitti?',
    'Eski Yunan\'da rüyalar Hypnos\'un armağanıydı. Uyku tanrısı bu gece sana ne fısıldadı?',
    'Tibet bilgeleri rüyayı "Bardo" - ara boyut olarak görür. Bu gece hangi boyuta geçtin?',
    'Kızılderili gelenekte rüya, ataların sesini taşır. Bu gece atalarından ne duydun?',
    'İslam mistiklerince rüya üç türdür: rahmani, nefsani, şeytani. Bu rüya hangi kapıdan geldi?',
  ];

  /// Ay fazına göre girişler
  static const Map<String, List<String>> ayFazina = {
    'yeniay': [
      'Yeniay\'ın karanlığında gelen rüyalar tohum mesajları taşır. Bu gece bilinçaltın yeni bir niyet ekti.',
      'Karanlık ay zamanında görülen rüyalar en kadim bilgeliği barındırır. Sessizlikte dinle.',
      'Yeniay, yeni döngünün başlangıcı. Bu rüya, önündeki 28 günün haritasını çiziyor.',
      'Ay görünmezken bile çalışır. Bu rüya, görünmeyen potansiyelini aydınlatıyor.',
    ],
    'hilal': [
      'Hilal Ay döneminde rüyalar büyüme çağrısı yapar. Tohum topraktan başını çıkarmak istiyor.',
      'Işık artarken gelen bu rüya, cesaret ve ilerleme mesajı taşıyor.',
      'Hilal, umudun sembolü. Bu rüya sana "başla" diyor.',
    ],
    'ilkDordun': [
      'İlk Dördün\'de rüyalar karar noktalarını gösterir. İki yol ayrımındasın.',
      'Yarı aydınlık, yarı karanlık - bu rüya sana dengeyi öğretiyor.',
      'Gerilim zamanı. Bu rüya bir çatışmayı veya seçimi yansıtıyor.',
    ],
    'dolunay': [
      'Dolunay\'ın aydınlığında gelen rüyalar farkındalık doruk noktasıdır. Her şey görünür.',
      'Ay tam daireyken bilinçaltı da tam konuşur. Bu rüya sana tüm gerçeği gösteriyor.',
      'Dolunay enerjisi yoğun. Bu rüya bastırılanları yüzeye çıkarıyor.',
      'Işık en güçlüyken gölge de en belirgin. Bu rüya sana aynayı tutuyor.',
    ],
    'sonDordun': [
      'Son Dördün bırakma zamanıdır. Bu rüya sana neyi bırakman gerektiğini gösteriyor.',
      'Işık azalırken bilgelik artar. Bu rüya bir döngüyü kapatmanı istiyor.',
      'Hasat zamanı geçti, şimdi toprak dinlenecek. Sen de neyi dinlendirmelisin?',
    ],
    'karanlikAy': [
      'Karanlık Ay\'da gelen rüyalar en derin katmandan gelir. Dikkatle dinle.',
      'Ay görünmeden önce, en kadim mesajlar iletilir. Bu rüya bir uyarı veya hazırlık.',
      'Karanlıkta görülen rüyalar, yaklaşan ışığın habercisidir.',
    ],
  };

  /// Sembol kategorisine göre girişler
  static const Map<SymbolCategory, List<String>> kategoriye = {
    SymbolCategory.hayvan: [
      'Hayvanlar, bilinçaltının en kadim dili. Bu gece hangi içgüdüsel güç seninle konuştu?',
      'Şamanlar hayvan rüyalarını "güç hayvanı" mesajı olarak yorumlar. Totem enerjin uyanıyor.',
      'Hayvan sembolleri, insanlığın en eski arketiplerindendir. İçgüdüsel bilgeliğine kulak ver.',
      'Doğa senin aracılığınla konuşuyor. Bu hayvan, bastırdığın hangi yönünü temsil ediyor?',
    ],
    SymbolCategory.mekan: [
      'Mekanlar, ruhsal yapının haritasıdır. Bu gece iç dünyanın hangi odasına girdin?',
      'Jung\'a göre evler benliği temsil eder. Rüyandaki mekan, psişenin bir bölgesi.',
      'Her oda bir sır, her koridor bir yolculuk. Mekan sana ne anlatıyor?',
      'İç mimarlık dış mimarlığı belirler. Rüyandaki yapı, iç yapını yansıtıyor.',
    ],
    SymbolCategory.insan: [
      'Rüyalardaki insanlar genellikle kendi yönlerimizi temsil eder. Bu figür sende neyi uyandırıyor?',
      'Jung\'un Anima/Animus teorisine göre karşı cins rüya figürleri, bilinçdışı yönlerimizdir.',
      'Tanıdık yüzler, tanıdık gölgeler. Bu kişi hangi projeksiyonunu taşıyor?',
      'İnsan figürleri ayna gibidir. Kendinin hangi yönünü gördün?',
    ],
    SymbolCategory.eylem: [
      'Rüyalardaki eylemler, hayattaki duruşumuzu yansıtır. Koşuyor musun, duruyorsun mu, uçuyor musun?',
      'Hareket yön belirler. Rüyandaki eylem, hayatındaki hareketi gösteriyor.',
      'Ne yapıyordun değil, nasıl hissediyordun önemli. Eylem duygusal durumunu yansıtıyor.',
    ],
    SymbolCategory.nesne: [
      'Nesneler, anlam yüklü sembollerdir. Bu obje senin için ne ifade ediyor?',
      'Objeler, iç dünyanın dış temsilleri. Rüyandaki nesne hangi değeri simgeliyor?',
      'Araçlar, güç ve yetenekleri temsil eder. Bu nesneyle ne yapabilirsin?',
    ],
    SymbolCategory.dogaOlayi: [
      'Doğa olayları, kozmik güçlerin dilidir. Evren senin aracılığınla konuşuyor.',
      'Fırtına, yağmur, deprem - iç dünyanın iklimi dışarıda görünüyor.',
      'Doğa olayları dönüşümün habercisidir. Hangi değişim kapıda?',
    ],
    SymbolCategory.soyut: [
      'Soyut rüyalar en derin mesajları taşır. Kavramlar imgelere dönüşüyor.',
      'Somut olmayan, sezgisel olan konuşuyor. Mantık değil, his rehberin.',
      'Soyut semboller evrensel arketiplerdir. Kolektif bilinçten mesaj alıyorsun.',
    ],
  };

  /// Duygusal tona göre girişler
  static const Map<EmotionalTone, List<String>> duygusalTona = {
    EmotionalTone.korku: [
      'Korku rüyaları, bilinçaltının alarm sistemidir. Bir şey dikkatini çekmeye çalışıyor.',
      'Korkutucu rüyalar paradoksal olarak şifa taşır. Gölgeyle yüzleşme daveti.',
      'Jung der ki: "Rüyada korktuğumuz şey, uyanıkken kaçtığımız şeydir."',
      'Kabus değil, çağrı. Bu korku sana ne öğretmek istiyor?',
    ],
    EmotionalTone.huzur: [
      'Huzurlu rüyalar, iç dengenin göstergesi. Bir şey doğru yolda.',
      'Sakinlik, bilinçaltının onay mührü. İçsel bir çatışma çözülmüş.',
      'Huzur rüyaları nadir ve değerli. Bu duyguyu uyanıkken de hatırla.',
    ],
    EmotionalTone.merak: [
      'Merak, ruhun pusulası. Bu rüya seni keşfe çağırıyor.',
      'Soru soran rüyalar, cevap arayan ruhlara gelir. Ne öğrenmek istiyorsun?',
      'Merak, bilgeliğin tohumudur. Bu rüya bir arayışın başlangıcı.',
    ],
    EmotionalTone.sucluluk: [
      'Suçluluk rüyaları, tamamlanmamış duygusal iş işareti. Affetme zamanı.',
      'Bilinçaltı hesap soruyor. Ama yargılamak için değil, iyileştirmek için.',
      'Suçluluk, bağlantı kopukluğunun sesi. Kiminle barışman gerekiyor - kendine mi?',
    ],
    EmotionalTone.ozlem: [
      'Özlem rüyaları, kayıp bütünlüğün anısını taşır. Ne eksik?',
      'Nostalji, zamanın ötesinden gelen çağrı. Geçmişte ne bıraktın?',
      'Özlem, sevginin başka hali. Bu duygu sana ne anlatıyor?',
    ],
    EmotionalTone.heyecan: [
      'Heyecan rüyaları, yaklaşan değişimin habercisi. Bir şey geliyor.',
      'Enerji yükseliyor. Bu rüya yeni bir döngünün açılışı.',
      'Heyecan, hayat enerjisinin doruğu. Bu gücü nereye yönlendireceksin?',
    ],
    EmotionalTone.donukluk: [
      'Donukluk, aşırı hissetmekten korunma. Bilinçaltı mola istiyor.',
      'Uyuşukluk bazen gerekli. Ama uyanma zamanı yaklaşıyor.',
      'Hissizlik, kalkanın arkasındaki duyguyu gizliyor. Ne hissetmekten kaçınıyorsun?',
    ],
    EmotionalTone.ofke: [
      'Öfke rüyaları, bastırılmış gücün sesi. Sınırların ihlal edildi.',
      'Kızgınlık, korunan bir değerin işareti. Ne uğruna öfkeleniyorsun?',
      'Öfke, dönüşüm enerjisi taşır. Bu gücü yapıcı kullan.',
    ],
  };

  /// Rastgele kadim giriş seç
  static String rastgeleSecim({
    MoonPhase? ayFazi,
    SymbolCategory? kategori,
    EmotionalTone? duygu,
  }) {
    // Öncelik: duygu > ay fazı > kategori > genel
    if (duygu != null && duygusalTona[duygu]!.isNotEmpty) {
      final liste = duygusalTona[duygu]!;
      return liste[DateTime.now().millisecond % liste.length];
    }

    if (ayFazi != null) {
      final key = ayFazi.name;
      if (ayFazina.containsKey(key) && ayFazina[key]!.isNotEmpty) {
        final liste = ayFazina[key]!;
        return liste[DateTime.now().millisecond % liste.length];
      }
    }

    if (kategori != null && kategoriye[kategori]!.isNotEmpty) {
      final liste = kategoriye[kategori]!;
      return liste[DateTime.now().millisecond % liste.length];
    }

    return genel[DateTime.now().millisecond % genel.length];
  }
}

// ════════════════════════════════════════════════════════════════════════════
// EK SEMBOLLER - 50+ Yeni Sembol
// ════════════════════════════════════════════════════════════════════════════

/// Ek sembol veritabanı - mevcut sembollere eklenir
class EkSemboller {
  static const List<DreamSymbolData> yeniSemboller = [
    // ═══════════════════════════════════════════════════════════
    // ULAŞIM & ARAÇLAR
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'airplane',
      symbolTr: 'Uçak',
      emoji: '✈️',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Yüksek hedefler ve ambisyon',
        'Hızlı değişim ve geçiş',
        'Özgürlük ve kaçış',
        'Uluslararası bağlantılar',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Büyük sıçrama yaklaşıyor - hedefler yükseliyor',
        EmotionalTone.korku: 'Kontrol kaybı korkusu - çok hızlı gidiyor',
        EmotionalTone.huzur: 'Doğru yoldasın - hedefe ulaşacaksın',
        EmotionalTone.merak: 'Yeni ufuklar keşfedilecek',
      },
      archetypes: ['Kahraman', 'Keşifçi', 'Özgür Ruh'],
      relatedSymbols: ['flying', 'sky', 'travel', 'clouds'],
      shadowAspect: 'Aşırı ambisyon, gerçeklikten kopma, kaçış',
      lightAspect: 'Vizyon, yükseliş, özgürlük, başarı',
    ),

    DreamSymbolData(
      symbol: 'train',
      symbolTr: 'Tren',
      emoji: '🚂',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Yaşam yolculuğu ve kader',
        'Kolektif yolculuk',
        'Belirlenmis rota',
        'Geçişler ve istasyonlar',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Doğru rotadasın - akışa güven',
        EmotionalTone.korku: 'Treni kaçırma korkusu - fırsat kaygısı',
        EmotionalTone.ozlem: 'Geçmiş bir istasyon - dönüş arzusu',
        EmotionalTone.heyecan: 'Yeni bir istasyon yaklaşıyor',
      },
      archetypes: ['Yolcu', 'Kader', 'Kolektif'],
      relatedSymbols: ['journey', 'station', 'tracks', 'travel'],
      shadowAspect: 'Kadercilik, bireysellik kaybı, raydan çıkma',
      lightAspect: 'Yön, topluluk, ilerleme, güvenilir akış',
    ),

    DreamSymbolData(
      symbol: 'boat',
      symbolTr: 'Tekne',
      emoji: '⛵',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Duygusal yolculuk',
        'Bilinçdışı geçişi',
        'Güvenli seyir',
        'Yaşam gemisi',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Duyguların dengesinde - güvenli seyir',
        EmotionalTone.korku: 'Fırtınalı sular - duygusal çalkantı',
        EmotionalTone.merak: 'Keşfedilecek kıyılar var',
        EmotionalTone.ozlem: 'Karaya özlem - güvenlik arayışı',
      },
      archetypes: ['Denizci', 'Keşifçi', 'Geçiş'],
      relatedSymbols: ['water', 'ocean', 'journey', 'anchor'],
      shadowAspect: 'Sürüklenme, kaybolma, batma',
      lightAspect: 'Duygusal ustalık, keşif, güvenli geçiş',
    ),

    DreamSymbolData(
      symbol: 'bicycle',
      symbolTr: 'Bisiklet',
      emoji: '🚲',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Denge ve koordinasyon',
        'Kendi gücünle ilerleme',
        'Çocuksu özgürlük',
        'Sürdürülebilir hareket',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Özgür hareket - kendi ritminde',
        EmotionalTone.korku: 'Denge kaybı - düşme korkusu',
        EmotionalTone.huzur: 'Uyum içinde - denge sağlanmış',
        EmotionalTone.ozlem: 'Çocukluk özgürlüğü - masumiyet',
      },
      archetypes: ['Çocuk', 'Özgür Ruh', 'Dengeci'],
      relatedSymbols: ['balance', 'freedom', 'childhood', 'movement'],
      shadowAspect: 'Dengesizlik, çocuksuluuk, kırılganlık',
      lightAspect: 'Öz-güç, denge, özgürlük, basitlik',
    ),

    // ═══════════════════════════════════════════════════════════
    // DOĞA ELEMENTLERİ
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'mountain',
      symbolTr: 'Dağ',
      emoji: '🏔️',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Hedef ve başarı',
        'Spiritüel yükseliş',
        'Engeller ve zorluklar',
        'Perspektif kazanma',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Zirve yaklaşıyor - hedefe ulaşacaksın',
        EmotionalTone.korku: 'Aşılmaz görünen engel',
        EmotionalTone.huzur: 'Zirveden bakış - her şey açık',
        EmotionalTone.donukluk: 'Tırmanış yorgunluğu - mola zamanı',
      },
      archetypes: ['Bilge', 'Kahraman', 'Keşifçi'],
      relatedSymbols: ['climb', 'summit', 'view', 'challenge'],
      shadowAspect: 'Ulaşılamaz hedefler, yalnızlık, zorluk',
      lightAspect: 'Başarı, perspektif, spiritüel yükseliş',
    ),

    DreamSymbolData(
      symbol: 'tree',
      symbolTr: 'Ağaç',
      emoji: '🌳',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Yaşam ağacı ve bağlantı',
        'Kökler ve kimlik',
        'Büyüme ve gelişim',
        'Doğa ile birlik',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Köklerin sağlam - güvendesin',
        EmotionalTone.ozlem: 'Aile ağacı - köklere dönüş',
        EmotionalTone.heyecan: 'Büyüme mevsimi - dal budak salıyorsun',
        EmotionalTone.korku: 'Kurumuş ağaç - beslenme eksikliği',
      },
      archetypes: ['Yaşam Ağacı', 'Anne', 'Bilge'],
      relatedSymbols: ['roots', 'leaves', 'forest', 'growth'],
      shadowAspect: 'Köksüzlük, kuruma, bağlantı kopukluğu',
      lightAspect: 'Yaşam gücü, kökler, büyüme, bağlantı',
    ),

    DreamSymbolData(
      symbol: 'flower',
      symbolTr: 'Çiçek',
      emoji: '🌸',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Güzellik ve açılma',
        'Geçicilik ve döngü',
        'Feminen enerji',
        'Sevgi ve şefkat',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Açılma zamanı - potansiyelini göster',
        EmotionalTone.ozlem: 'Solmuş çiçek - geçmiş güzellik',
        EmotionalTone.heyecan: 'Tomurcuk patlıyor - yeni başlangıç',
        EmotionalTone.sucluluk: 'Koparılmış çiçek - zarar verme korkusu',
      },
      archetypes: ['Feminen', 'Güzellik', 'Döngüsel'],
      relatedSymbols: ['garden', 'spring', 'beauty', 'nature'],
      shadowAspect: 'Geçicilik, solma, kırılganlık',
      lightAspect: 'Güzellik, açılma, döngüsel yenilenme',
    ),

    DreamSymbolData(
      symbol: 'snow',
      symbolTr: 'Kar',
      emoji: '❄️',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Arınma ve saflık',
        'Duygusal soğuma',
        'Dinlenme ve mola',
        'Geçici örtü',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Sessizlik ve arınma - her şey temizleniyor',
        EmotionalTone.donukluk: 'Duygusal donma - hissizlik',
        EmotionalTone.korku: 'Buzul gibi - sıcaklık eksikliği',
        EmotionalTone.merak: 'Beyaz sayfa - yeni başlangıç',
      },
      archetypes: ['Arınma', 'Dinlenme', 'Döngü'],
      relatedSymbols: ['winter', 'cold', 'white', 'silence'],
      shadowAspect: 'Soğukluk, tecrit, donukluk',
      lightAspect: 'Saflık, arınma, yenilenme, sessizlik',
    ),

    DreamSymbolData(
      symbol: 'rainbow',
      symbolTr: 'Gökkuşağı',
      emoji: '🌈',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Umut ve vaat',
        'Fırtına sonrası huzur',
        'Köprü ve bağlantı',
        'Çok boyutluluk',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Fırtına bitti - güzel günler geliyor',
        EmotionalTone.huzur: 'Evrensel vaat - korunuyorsun',
        EmotionalTone.merak: 'Renklerin anlamı - çok yönlülük',
        EmotionalTone.ozlem: 'Ulaşılamaz güzellik - idealler',
      },
      archetypes: ['Umut', 'Vaat', 'Köprü'],
      relatedSymbols: ['storm', 'colors', 'sky', 'hope'],
      shadowAspect: 'Ulaşılamaz idealler, illüzyon',
      lightAspect: 'Umut, vaat, bütünleşme, güzellik',
    ),

    DreamSymbolData(
      symbol: 'star',
      symbolTr: 'Yıldız',
      emoji: '⭐',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Rehberlik ve yön',
        'Kader ve amaç',
        'Işık ve ilham',
        'Ulaşılacak hedef',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Yıldızın rehberliğinde - yolun aydınlık',
        EmotionalTone.merak: 'Evrenin sırları - büyük sorular',
        EmotionalTone.ozlem: 'Ulaşılmaz ışık - idealler',
        EmotionalTone.heyecan: 'Parlayan yıldız - tanınma ve başarı',
      },
      archetypes: ['Rehber', 'Kader', 'İlahi'],
      relatedSymbols: ['sky', 'night', 'light', 'destiny'],
      shadowAspect: 'Ulaşılamazlık, soğuk uzaklık',
      lightAspect: 'Rehberlik, kader, ilham, amaç',
    ),

    DreamSymbolData(
      symbol: 'lightning',
      symbolTr: 'Şimşek',
      emoji: '⚡',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Ani aydınlanma',
        'Yıkıcı güç',
        'İlahi müdahale',
        'Enerji patlaması',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Yıkıcı güç - kontrolsüz değişim',
        EmotionalTone.heyecan: 'Ani içgörü - aydınlanma anı',
        EmotionalTone.donukluk: 'Şok - ani uyanış çağrısı',
        EmotionalTone.ofke: 'Öfke patlaması - enerji boşalması',
      },
      archetypes: ['Zeus', 'Dönüştürücü', 'İlahi Güç'],
      relatedSymbols: ['storm', 'power', 'sudden', 'energy'],
      shadowAspect: 'Yıkım, şok, kontrolsüz güç',
      lightAspect: 'Aydınlanma, enerji, ilahi içgörü',
    ),

    // ═══════════════════════════════════════════════════════════
    // YENİ HAYVANLAR
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'lion',
      symbolTr: 'Aslan',
      emoji: '🦁',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Güç ve otorite',
        'Cesaret ve liderlik',
        'Noble gurur',
        'Maskülen enerji',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'İçindeki aslan uyanıyor - gücünü göster',
        EmotionalTone.korku: 'Ezici güç korkusu - otoriteyle çatışma',
        EmotionalTone.huzur: 'Krallığında huzur - doğru yerdesin',
        EmotionalTone.ofke: 'Kükreme zamanı - sınırları koru',
      },
      archetypes: ['Kral', 'Savaşçı', 'Koruyucu'],
      relatedSymbols: ['power', 'crown', 'strength', 'pride'],
      shadowAspect: 'Tiranlık, kibir, saldırganlık',
      lightAspect: 'Noble güç, cesaret, koruyucu liderlik',
    ),

    DreamSymbolData(
      symbol: 'eagle',
      symbolTr: 'Kartal',
      emoji: '🦅',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Yüksek bakış açısı',
        'Spiritüel yükseliş',
        'Özgürlük ve güç',
        'Keskin görüş',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Gökyüzünden bakış - her şeyi görüyorsun',
        EmotionalTone.heyecan: 'Kanatların açılıyor - yükselme zamanı',
        EmotionalTone.merak: 'Keskin gözle bak - detayları gör',
        EmotionalTone.ozlem: 'Özgürlük çağrısı - yüksel',
      },
      archetypes: ['Bilge', 'Kahraman', 'Ruh'],
      relatedSymbols: ['sky', 'flying', 'vision', 'freedom'],
      shadowAspect: 'Kibirli izolasyon, soğuk uzaklık',
      lightAspect: 'Vizyon, spiritüel bakış, özgürlük',
    ),

    DreamSymbolData(
      symbol: 'owl',
      symbolTr: 'Baykuş',
      emoji: '🦉',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Bilgelik ve sezgi',
        'Gece ve gizem',
        'Ölüm ve geçiş (bazı kültürlerde)',
        'Görünmeyeni görme',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Gece bilgeliği - karanlıkta gör',
        EmotionalTone.korku: 'Ölüm habercisi - geçiş korkusu',
        EmotionalTone.huzur: 'Sessiz bilgelik - dinle ve öğren',
        EmotionalTone.donukluk: 'Gece bekçisi - uyanık kal',
      },
      archetypes: ['Bilge', 'Gizemli', 'Athena'],
      relatedSymbols: ['night', 'wisdom', 'mystery', 'death'],
      shadowAspect: 'Ölüm, karanlık, tecrit',
      lightAspect: 'Bilgelik, sezgi, gizli bilgi',
    ),

    DreamSymbolData(
      symbol: 'butterfly',
      symbolTr: 'Kelebek',
      emoji: '🦋',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Dönüşüm ve metamorfoz',
        'Ruhun özgürlüğü',
        'Kırılganlık ve güzellik',
        'Kısa ömür, anlık güzellik',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Kozadan çıkış - dönüşüm tamamlandı',
        EmotionalTone.huzur: 'Hafif uçuş - özgürsün',
        EmotionalTone.ozlem: 'Geçici güzellik - anı yakala',
        EmotionalTone.merak: 'Dönüşüm süreci - neler değişiyor?',
      },
      archetypes: ['Ruh', 'Dönüşüm', 'Güzellik'],
      relatedSymbols: ['transformation', 'beauty', 'soul', 'flight'],
      shadowAspect: 'Geçicilik, kırılganlık, tutarsızlık',
      lightAspect: 'Dönüşüm, ruhsal güzellik, özgürlük',
    ),

    DreamSymbolData(
      symbol: 'bear',
      symbolTr: 'Ayı',
      emoji: '🐻',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'İçsel güç ve koruma',
        'Anne içgüdüsü',
        'Kış uykusu - dinlenme',
        'İçe dönüş',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Koruyucu güç - güvendesin',
        EmotionalTone.korku: 'Vahşi güç - içgüdüsel tehdit',
        EmotionalTone.donukluk: 'Kış uykusu zamanı - dinlenmeye ihtiyacın var',
        EmotionalTone.ofke: 'Uyandırılmış ayı - sınır ihlali',
      },
      archetypes: ['Koruyucu Anne', 'Vahşi Doğa', 'Dinlenici'],
      relatedSymbols: ['protection', 'strength', 'hibernation', 'mother'],
      shadowAspect: 'Saldırganlık, izolasyon, uyuşukluk',
      lightAspect: 'Koruyucu güç, içe dönüş, doğal ritim',
    ),

    DreamSymbolData(
      symbol: 'dolphin',
      symbolTr: 'Yunus',
      emoji: '🐬',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Oyunculuk ve neşe',
        'Zeka ve iletişim',
        'Duygusal şifa',
        'Rehberlik',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Oyuncu enerji - hayatın tadını çıkar',
        EmotionalTone.heyecan: 'Neşeli rehber - doğru yoldasın',
        EmotionalTone.merak: 'Derin iletişim - sezgisel bağlantı',
        EmotionalTone.ozlem: 'Kayıp neşe - oyunculuğu hatırla',
      },
      archetypes: ['Oyuncu', 'Şifacı', 'Rehber'],
      relatedSymbols: ['ocean', 'play', 'communication', 'joy'],
      shadowAspect: 'Yüzeysellik, kaçış, sorumluluktan kaçınma',
      lightAspect: 'Neşe, zeka, şifa, rehberlik',
    ),

    DreamSymbolData(
      symbol: 'crow',
      symbolTr: 'Karga',
      emoji: '🪶',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Sihir ve gizem',
        'Dönüşüm ve değişim',
        'Zeka ve kurnazlık',
        'Ölüm ve yeniden doğuş',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Kötü şans habercisi - uyarı',
        EmotionalTone.merak: 'Sihirli mesaj - dinle',
        EmotionalTone.donukluk: 'Karanlık haberci - değişim kapıda',
        EmotionalTone.heyecan: 'Büyü aktif - dönüşüm başlıyor',
      },
      archetypes: ['Haberci', 'Sihirbaz', 'Gölge'],
      relatedSymbols: ['magic', 'death', 'transformation', 'message'],
      shadowAspect: 'Ölüm, kötü haber, karanlık',
      lightAspect: 'Sihir, dönüşüm, gizli bilgi',
    ),

    // ═══════════════════════════════════════════════════════════
    // EV & YAPI DETAYLARI
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'window',
      symbolTr: 'Pencere',
      emoji: '🪟',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Bakış açısı ve perspektif',
        'Dış dünyaya bağlantı',
        'Fırsat ve olasılık',
        'Şeffaflık',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Dışarıya bak - yeni perspektif',
        EmotionalTone.ozlem: 'Camın ardından - ulaşılamayan',
        EmotionalTone.huzur: 'Açık pencere - hava alıyorsun',
        EmotionalTone.korku: 'Kırık cam - savunmasızlık',
      },
      archetypes: ['Bakış', 'Bağlantı', 'Fırsat'],
      relatedSymbols: ['house', 'view', 'light', 'outside'],
      shadowAspect: 'İzolasyon, uzaklık, kırılganlık',
      lightAspect: 'Perspektif, fırsat, bağlantı',
    ),

    DreamSymbolData(
      symbol: 'stairs',
      symbolTr: 'Merdiven',
      emoji: '🪜',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Yükseliş veya iniş',
        'İlerleme ve değişim',
        'Bilinç seviyeleri',
        'Adım adım gelişim',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Yukarı çıkış - yükseliyorsun',
        EmotionalTone.korku: 'Sonsuz merdiven - yorgunluk',
        EmotionalTone.merak: 'Nereye çıkıyor? - keşfet',
        EmotionalTone.donukluk: 'İniş - bilinçaltına yolculuk',
      },
      archetypes: ['Yükseliş', 'Geçiş', 'İlerleme'],
      relatedSymbols: ['house', 'climb', 'levels', 'progress'],
      shadowAspect: 'Tükenmişlik, düşüş, tıkanıklık',
      lightAspect: 'İlerleme, yükseliş, bilinç genişlemesi',
    ),

    DreamSymbolData(
      symbol: 'bridge',
      symbolTr: 'Köprü',
      emoji: '🌉',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Geçiş ve bağlantı',
        'İki dünya arası',
        'Engeli aşma',
        'Birleştirme',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Karşıya geçiş - yeni dünya',
        EmotionalTone.korku: 'Sallanıyor - güvensiz geçiş',
        EmotionalTone.huzur: 'Sağlam köprü - geçiş güvenli',
        EmotionalTone.merak: 'Diğer tarafta ne var?',
      },
      archetypes: ['Bağlantı', 'Geçiş', 'Birleştirici'],
      relatedSymbols: ['crossing', 'connection', 'transition', 'river'],
      shadowAspect: 'Belirsizlik, tehlikeli geçiş, bağlantı kopukluğu',
      lightAspect: 'Geçiş, bağlantı, engelleri aşma',
    ),

    DreamSymbolData(
      symbol: 'tunnel',
      symbolTr: 'Tünel',
      emoji: '🚇',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Geçiş ve dönüşüm',
        'Karanlıktan ışığa',
        'Doğum kanalı',
        'Bilinçaltı yolculuğu',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Karanlık tünel - bilinmeyen',
        EmotionalTone.heyecan: 'Işık görünüyor - son yakın',
        EmotionalTone.donukluk: 'Sonsuz tünel - çıkış yok gibi',
        EmotionalTone.merak: 'Nereye çıkıyor? - keşif',
      },
      archetypes: ['Geçiş', 'Yeniden Doğuş', 'Dönüşüm'],
      relatedSymbols: ['darkness', 'light', 'passage', 'birth'],
      shadowAspect: 'Sıkışmışlık, karanlık, çıkışsızlık',
      lightAspect: 'Dönüşüm, yeniden doğuş, geçiş',
    ),

    DreamSymbolData(
      symbol: 'garden',
      symbolTr: 'Bahçe',
      emoji: '🏡',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'İç dünya ve bakım',
        'Büyüme ve gelişim',
        'Cennet ve huzur',
        'Yaratıcılık',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Cennet bahçesi - iç huzur',
        EmotionalTone.heyecan: 'Çiçek açıyor - büyüme zamanı',
        EmotionalTone.sucluluk: 'İhmal edilmiş bahçe - bakıma ihtiyaç',
        EmotionalTone.ozlem: 'Kayıp cennet - masumiyet',
      },
      archetypes: ['Cennet', 'Yaratıcı', 'Bakıcı'],
      relatedSymbols: ['flowers', 'growth', 'nature', 'care'],
      shadowAspect: 'İhmal, kurumuşluk, kayıp cennet',
      lightAspect: 'Bakım, büyüme, yaratıcılık, huzur',
    ),

    // ═══════════════════════════════════════════════════════════
    // İNSAN FİGÜRLERİ
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'baby',
      symbolTr: 'Bebek',
      emoji: '👶',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Yeni başlangıç ve potansiyel',
        'Masumiyet ve saflık',
        'İç çocuk',
        'Yaratıcı proje',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Yeni doğum - bir şey başlıyor',
        EmotionalTone.korku: 'Sorumluluk korkusu - hazır değilim',
        EmotionalTone.huzur: 'Masum potansiyel - saflık',
        EmotionalTone.sucluluk: 'İhmal edilmiş bebek - iç çocuk ihtiyacı',
      },
      archetypes: ['İç Çocuk', 'Yeni Başlangıç', 'Masumiyet'],
      relatedSymbols: ['birth', 'pregnancy', 'innocence', 'new'],
      shadowAspect: 'Sorumluluk korkusu, bağımlılık, savunmasızlık',
      lightAspect: 'Yeni başlangıç, potansiyel, masumiyet',
    ),

    DreamSymbolData(
      symbol: 'old-person',
      symbolTr: 'Yaşlı Kişi',
      emoji: '🧓',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Bilgelik ve deneyim',
        'Ata figürü',
        'Zamansız bilgi',
        'Yaşlanma ve ölümlülük',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Bilge rehber - yolu gösteren',
        EmotionalTone.korku: 'Ölüm hatırlatıcı - zaman korkusu',
        EmotionalTone.merak: 'Öğretici figür - ders zamanı',
        EmotionalTone.ozlem: 'Kayıp ata - kök bağlantısı',
      },
      archetypes: ['Bilge Yaşlı', 'Ata', 'Zaman'],
      relatedSymbols: ['wisdom', 'time', 'ancestor', 'death'],
      shadowAspect: 'Ölümlülük, zayıflık, geçmiş takıntı',
      lightAspect: 'Bilgelik, rehberlik, deneyim mirası',
    ),

    DreamSymbolData(
      symbol: 'crowd',
      symbolTr: 'Kalabalık',
      emoji: '👥',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Toplum ve aidiyet',
        'Kolektif bilinç',
        'Kimlik kaybı korkusu',
        'Sosyal baskı',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Kalabalıkta kaybolma - kimlik kaygısı',
        EmotionalTone.huzur: 'Topluluğa ait - kabul görüyorsun',
        EmotionalTone.donukluk: 'Yüzler bulanık - yabancılaşma',
        EmotionalTone.heyecan: 'Heyecanlı kalabalık - ortak enerji',
      },
      archetypes: ['Kolektif', 'Toplum', 'Sürü'],
      relatedSymbols: ['society', 'belonging', 'anonymity', 'group'],
      shadowAspect: 'Kimlik kaybı, baskı, yabancılaşma',
      lightAspect: 'Aidiyet, kolektif güç, topluluk',
    ),

    DreamSymbolData(
      symbol: 'celebrity',
      symbolTr: 'Ünlü Kişi',
      emoji: '🌟',
      category: SymbolCategory.insan,
      universalMeanings: [
        'İdealleştirme ve projeksiyon',
        'Başarı ve tanınma arzusu',
        'Gölge veya anima/animus',
        'Sosyal statü',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Başarı projeksiyonu - potansiyelini gör',
        EmotionalTone.ozlem: 'Ulaşılamaz ideal - özlem',
        EmotionalTone.merak: 'Bu ünlü sende neyi temsil ediyor?',
        EmotionalTone.huzur: 'Tanınma - değerin kabul görüyor',
      },
      archetypes: ['İdeal Benlik', 'Anima/Animus', 'Başarı'],
      relatedSymbols: ['fame', 'success', 'projection', 'admiration'],
      shadowAspect: 'Yetersizlik, kıskançlık, sahte idealler',
      lightAspect: 'Potansiyel, ilham, başarı vizyonu',
    ),

    // ═══════════════════════════════════════════════════════════
    // EYLEMLER & DURUMLAR
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'swimming',
      symbolTr: 'Yüzmek',
      emoji: '🏊',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Duygusal navigasyon',
        'Bilinçdışında hareket',
        'Yaşam gücü',
        'Adaptasyon',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Duyguların içinde ustalık - kontroldesin',
        EmotionalTone.korku: 'Boğulma riski - duygular çok yoğun',
        EmotionalTone.heyecan: 'Derinlere dalma - keşif',
        EmotionalTone.donukluk: 'Yüzeyde kalma - derinleşememe',
      },
      archetypes: ['Denizci', 'Keşifçi', 'Adaptör'],
      relatedSymbols: ['water', 'ocean', 'diving', 'drowning'],
      shadowAspect: 'Boğulma, yön kaybı, tükenmişlik',
      lightAspect: 'Duygusal ustalık, adaptasyon, keşif',
    ),

    DreamSymbolData(
      symbol: 'climbing',
      symbolTr: 'Tırmanmak',
      emoji: '🧗',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Hedefe ulaşma çabası',
        'Zorlukları aşma',
        'Yükseliş ve ilerleme',
        'Azim ve kararlılık',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Zirveye yaklaşıyorsun - devam et',
        EmotionalTone.korku: 'Düşme riski - başaramama korkusu',
        EmotionalTone.donukluk: 'Yorgunluk - mola zamanı',
        EmotionalTone.huzur: 'Sağlam tutunma - güvenli ilerleme',
      },
      archetypes: ['Kahraman', 'Mücadeleci', 'Azimli'],
      relatedSymbols: ['mountain', 'stairs', 'effort', 'summit'],
      shadowAspect: 'Tükenmişlik, düşüş, ulaşılamazlık',
      lightAspect: 'Azim, başarı, yükseliş',
    ),

    DreamSymbolData(
      symbol: 'dancing',
      symbolTr: 'Dans Etmek',
      emoji: '💃',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Özgür ifade',
        'Ritim ve uyum',
        'Kutlama ve sevinç',
        'Yaşam enerjisi',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Özgür ifade - kendin ol',
        EmotionalTone.huzur: 'Ritimle uyum - akıştasın',
        EmotionalTone.ozlem: 'Kaybedilen neşe - kutla',
        EmotionalTone.korku: 'Sahne korkusu - yargılanma',
      },
      archetypes: ['Özgür Ruh', 'Kutlayıcı', 'İfadeci'],
      relatedSymbols: ['music', 'joy', 'expression', 'freedom'],
      shadowAspect: 'Utanç, kasılma, ifade edememe',
      lightAspect: 'Özgür ifade, neşe, yaşam kutlaması',
    ),

    DreamSymbolData(
      symbol: 'fighting',
      symbolTr: 'Dövüşmek',
      emoji: '👊',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'İç çatışma',
        'Mücadele ve direniş',
        'Sınır koruma',
        'Güç gösterisi',
      ],
      emotionVariants: {
        EmotionalTone.ofke: 'Sınırlar ihlal edildi - savaş',
        EmotionalTone.korku: 'Yenilgi korkusu - güçsüzlük',
        EmotionalTone.heyecan: 'Güç gösterisi - kazanacaksın',
        EmotionalTone.donukluk: 'Bitmek bilmeyen savaş - yorgunluk',
      },
      archetypes: ['Savaşçı', 'Savunucu', 'Mücadeleci'],
      relatedSymbols: ['war', 'conflict', 'enemy', 'victory'],
      shadowAspect: 'Saldırganlık, yıkım, kontrol kaybı',
      lightAspect: 'Sınır koruma, cesaret, adalet',
    ),

    DreamSymbolData(
      symbol: 'hiding',
      symbolTr: 'Saklanmak',
      emoji: '🫣',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Kaçınma ve koruma',
        'Gizli yönler',
        'Utanç ve korku',
        'Güvenlik arayışı',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Tehditten kaçınma - ne korkutuyor?',
        EmotionalTone.sucluluk: 'Saklanan sır - açığa çıkma korkusu',
        EmotionalTone.donukluk: 'Görünmez olma arzusu - yok sayılma',
        EmotionalTone.huzur: 'Güvenli sığınak - korunma',
      },
      archetypes: ['Gölge', 'Kaçak', 'Korunan'],
      relatedSymbols: ['fear', 'secret', 'safety', 'shadow'],
      shadowAspect: 'Kaçınma, yüzleşmeme, inkâr',
      lightAspect: 'Koruma, sınırlar, güvenli alan',
    ),

    DreamSymbolData(
      symbol: 'crying',
      symbolTr: 'Ağlamak',
      emoji: '😢',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Duygusal boşalma',
        'Keder ve kayıp',
        'Arınma ve şifa',
        'Yardım çağrısı',
      ],
      emotionVariants: {
        EmotionalTone.sucluluk: 'Bastırılmış gözyaşları - izin ver',
        EmotionalTone.ozlem: 'Kayıp acısı - yas',
        EmotionalTone.huzur: 'Arınma gözyaşları - şifa',
        EmotionalTone.donukluk: 'Ağlayamama - blokaj',
      },
      archetypes: ['Şifacı', 'Yasçı', 'Arınmış'],
      relatedSymbols: ['tears', 'sadness', 'release', 'healing'],
      shadowAspect: 'Ezici üzüntü, kontrol kaybı, çaresizlik',
      lightAspect: 'Duygusal şifa, arınma, dürüstlük',
    ),

    DreamSymbolData(
      symbol: 'laughing',
      symbolTr: 'Gülmek',
      emoji: '😂',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Neşe ve özgürlük',
        'Gerilim boşaltma',
        'Sosyal bağlantı',
        'Bazen maskeleme',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Gerçek neşe - hayatın tadını çıkar',
        EmotionalTone.huzur: 'Hafiflik - yükler kalktı',
        EmotionalTone.korku: 'Kontrolsüz gülme - isteriyle başa çıkma',
        EmotionalTone.sucluluk: 'Uygunsuz gülme - gerçek duyguyu maskeleme',
      },
      archetypes: ['Soytarı', 'Özgür Ruh', 'Kutlayıcı'],
      relatedSymbols: ['joy', 'freedom', 'release', 'connection'],
      shadowAspect: 'Maskeleme, alay, uygunsuzluk',
      lightAspect: 'Neşe, özgürlük, şifa',
    ),

    // ═══════════════════════════════════════════════════════════
    // NESNELER & OBJELER
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'clock',
      symbolTr: 'Saat',
      emoji: '🕐',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Zaman ve ölümlülük',
        'Son tarihler ve baskı',
        'Yaşam döngüsü',
        'Anın değeri',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Zaman azalıyor - baskı',
        EmotionalTone.merak: 'Zaman ne anlatıyor? - farkındalık',
        EmotionalTone.donukluk: 'Durmuş saat - zamansızlık',
        EmotionalTone.heyecan: 'Doğru zaman - şimdi harekete geç',
      },
      archetypes: ['Zaman', 'Kader', 'Ölümlülük'],
      relatedSymbols: ['time', 'deadline', 'urgency', 'mortality'],
      shadowAspect: 'Zaman baskısı, ölüm korkusu, erteleme',
      lightAspect: 'An bilinci, zamanın değeri, farkındalık',
    ),

    DreamSymbolData(
      symbol: 'book',
      symbolTr: 'Kitap',
      emoji: '📚',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Bilgi ve öğrenme',
        'Hayat hikâyesi',
        'Gizli bilgelik',
        'Keşfedilecek sırlar',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Açılmayı bekleyen bilgi - öğren',
        EmotionalTone.huzur: 'Bilgelik kaynağı - rehberlik',
        EmotionalTone.korku: 'Kapalı kitap - erişilemeyen bilgi',
        EmotionalTone.ozlem: 'Eski kitap - geçmiş bilgelik',
      },
      archetypes: ['Bilge', 'Hikâye', 'Öğretmen'],
      relatedSymbols: ['knowledge', 'story', 'learning', 'wisdom'],
      shadowAspect: 'Bilgi kibirliliği, gerçeklikten kopuş',
      lightAspect: 'Bilgelik, öğrenme, hikâye gücü',
    ),

    DreamSymbolData(
      symbol: 'ring',
      symbolTr: 'Yüzük',
      emoji: '💍',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Bağlılık ve taahhüt',
        'Döngüsellik ve sonsuzluk',
        'Değer ve hazine',
        'Birlik ve evlilik',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Taahhüt - bağlanma zamanı',
        EmotionalTone.korku: 'Kayıp yüzük - bağlılık kaybı',
        EmotionalTone.huzur: 'Değerli bağ - güvendesin',
        EmotionalTone.ozlem: 'Eski yüzük - geçmiş bağlılık',
      },
      archetypes: ['Birlik', 'Taahhüt', 'Değer'],
      relatedSymbols: ['wedding', 'commitment', 'circle', 'treasure'],
      shadowAspect: 'Bağımlılık, kısıtlama, kayıp',
      lightAspect: 'Bağlılık, sonsuz sevgi, değer',
    ),

    DreamSymbolData(
      symbol: 'mask',
      symbolTr: 'Maske',
      emoji: '🎭',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Persona ve sosyal yüz',
        'Gizleme ve koruma',
        'Rol oynama',
        'Gerçek benlik sorusu',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Maskenin ardında kim var?',
        EmotionalTone.korku: 'Maske düşüyor - ifşa',
        EmotionalTone.donukluk: 'Maske kaynaşmış - kimliğini kaybetme',
        EmotionalTone.sucluluk: 'Sahtelik - gerçeği gizleme',
      },
      archetypes: ['Persona', 'Aldatıcı', 'Koruyucu'],
      relatedSymbols: ['face', 'identity', 'hiding', 'role'],
      shadowAspect: 'Sahtelik, kimlik kaybı, aldatma',
      lightAspect: 'Koruma, sosyal adaptasyon, rol esnekliği',
    ),

    DreamSymbolData(
      symbol: 'sword',
      symbolTr: 'Kılıç',
      emoji: '⚔️',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Güç ve irade',
        'Kesme ve ayırma',
        'Adalet ve karar',
        'Maskülen enerji',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Güç elinde - savaşa hazırsın',
        EmotionalTone.korku: 'Tehdit - saldırı korkusu',
        EmotionalTone.huzur: 'Adalet kılıcı - doğru taraf',
        EmotionalTone.ofke: 'Kesme zamanı - bitir',
      },
      archetypes: ['Savaşçı', 'Yargıç', 'Kral'],
      relatedSymbols: ['power', 'justice', 'cutting', 'battle'],
      shadowAspect: 'Saldırganlık, yıkım, acımasızlık',
      lightAspect: 'Adalet, güç, kararlılık',
    ),

    DreamSymbolData(
      symbol: 'treasure',
      symbolTr: 'Hazine',
      emoji: '💎',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Gizli değer ve potansiyel',
        'Öz-değer ve kıymet',
        'Keşfedilecek yetenekler',
        'Ruhsal zenginlik',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Hazine bulundu - değerini keşfet',
        EmotionalTone.merak: 'Gömülü hazine - neyi saklıyorsun?',
        EmotionalTone.korku: 'Kaybedilen hazine - değer kaygısı',
        EmotionalTone.huzur: 'Sahip olduklarının değeri',
      },
      archetypes: ['Değer', 'Keşif', 'Öz'],
      relatedSymbols: ['gold', 'jewels', 'finding', 'value'],
      shadowAspect: 'Açgözlülük, materyalizm, obsesyon',
      lightAspect: 'Öz-değer, gizli potansiyel, ruhsal zenginlik',
    ),
  ];
}

// ════════════════════════════════════════════════════════════════════════════
// TEKRARLAYAN RÜYA KALIPLARI
// ════════════════════════════════════════════════════════════════════════════

/// Tekrarlayan rüya kalıpları ve anlamları
class TekrarlayanRuyaKaliplari {
  static const List<RecurringDreamPattern> kaliplar = [
    RecurringDreamPattern(
      patternId: 'chase',
      title: 'Kovalanma Rüyaları',
      description: 'Sürekli bir şey veya biri tarafından kovalanıyorsun',
      commonSymbols: ['kovalayan', 'kaçmak', 'korku', 'koşmak'],
      frequency: 'En yaygın tekrarlayan rüya kalıbı',
      psychologicalMeaning:
          'Kaçınılan bir durumla yüzleşme çağrısı. Kovalayan genellikle bastırılmış korku, stres veya sorumluluğu temsil eder.',
      jungianAnalysis:
          'Jung\'a göre kovalayan figür genellikle Gölge arketipidir - kendi reddedilmiş yönlerimiz. '
          'Bu rüya, entegrasyon çağrısıdır.',
      actionAdvice: [
        'Rüyada dur ve kovalayan figürle yüzleş',
        'Kovalayan figüre "Ne istiyorsun?" diye sor',
        'Uyanıkken: Kaçındığın durumu belirle ve küçük adımlar at',
      ],
      evolutionNotes:
          'Eğer rüyada kovalayan figürle yüzleşmeyi başarırsan, bu rüyaların sıklığı azalır veya biter.',
      breakingAdvice:
          'Döngüyü kırmak için aktif hayal tekniği kullan: gün içinde rüyayı canlandır ve farklı bir sonuç hayal et.',
    ),
    RecurringDreamPattern(
      patternId: 'falling',
      title: 'Düşme Rüyaları',
      description: 'Boşlukta düşme, yüksekten düşme',
      commonSymbols: ['uçurum', 'düşmek', 'yerçekimi', 'korku'],
      frequency: 'Çok yaygın, özellikle stres dönemlerinde',
      psychologicalMeaning:
          'Kontrol kaybı, güvensizlik veya başarısızlık korkusunu yansıtır. Hayatta bir alanda "düşme" hissi.',
      jungianAnalysis:
          'Düşme, ego\'nun bilinçdışına düşüşünü sembolize edebilir. Dönüşüm öncesi "ölüm" deneyimi.',
      actionAdvice: [
        'Rüyada düşerken kanatların olduğunu hayal et',
        'Düşüşü kabul et ve nereye indiğini gör',
        'Uyanıkken: Kontrol kaybı korkunu incele',
      ],
      evolutionNotes:
          'Düşme rüyaları, bırakma ve teslim olma öğrenildiğinde uçma rüyalarına dönüşebilir.',
      breakingAdvice:
          'Yatmadan önce niyet koy: "Düşersem kanat açacağım." Bu lucid rüya girişimini tetikler.',
    ),
    RecurringDreamPattern(
      patternId: 'teeth',
      title: 'Diş Dökülme Rüyaları',
      description: 'Dişlerin dökülmesi, kırılması veya çürümesi',
      commonSymbols: ['dişler', 'düşmek', 'ayna', 'konuşmak'],
      frequency: 'Çok yaygın, özellikle imaj ve iletişim kaygılarında',
      psychologicalMeaning:
          'Özgüven kaybı, yaşlanma korkusu, iletişim sorunları. Dişler güç ve çekicilik sembolüdür.',
      jungianAnalysis:
          'Dişler persona ile bağlantılı - sosyal imajımız. Dökülen dişler, sosyal maskenin çatlamasını temsil edebilir.',
      actionAdvice: [
        'Rüyada aynaya bak ve kabul et',
        'İmaj kaygılarını sorgula',
        'Söyleyemediğin şeyleri not et',
      ],
      evolutionNotes:
          'Özgüven artışıyla bu rüyalar azalır. Bazen diş doktoruna gitme zamanı hatırlatıcısı olabilir!',
      breakingAdvice:
          'Kendine "Gerçek değerim dış görünüşümden bağımsızdır" onaylamasını tekrarla.',
    ),
    RecurringDreamPattern(
      patternId: 'naked',
      title: 'Çıplak Kalma Rüyaları',
      description: 'Toplum içinde çıplak veya uygunsuz giyinmiş olma',
      commonSymbols: ['çıplaklık', 'utanç', 'kalabalık', 'ifşa'],
      frequency: 'Yaygın, özellikle yeni durumlarda',
      psychologicalMeaning:
          'Savunmasızlık, ifşa olma korkusu, imposter sendromu. Gerçek benliğin açığa çıkması kaygısı.',
      jungianAnalysis:
          'Maskelerin düşürülmesi, persona\'nın çözülmesi. İlginç şekilde, çoğu zaman rüyadaki başkaları fark etmez - bu kendi kendini yargılamayı gösterir.',
      actionAdvice: [
        'Rüyada fark et: başkaları gerçekten umursuyor mu?',
        'Savunmasızlığı kabul et',
        'Mükemmeliyetçiliği sorgula',
      ],
      evolutionNotes:
          'Özgüven ve öz-kabul arttıkça, çıplaklık utancı rüyalarda azalır veya artık rahatsız etmez.',
      breakingAdvice:
          'Kırılganlık cesarettir. Brené Brown\'ın çalışmalarını oku.',
    ),
    RecurringDreamPattern(
      patternId: 'late',
      title: 'Geç Kalma / Kaçırma Rüyaları',
      description: 'Uçağı kaçırma, sınava geç kalma, randevuyu kaçırma',
      commonSymbols: ['saat', 'koşmak', 'kaçırmak', 'engeller'],
      frequency: 'Çok yaygın, özellikle iş/okul stresinde',
      psychologicalMeaning:
          'Zaman baskısı, fırsat kaçırma korkusu, yetersizlik hissi. Hayata yetişememe kaygısı.',
      jungianAnalysis:
          'Zaman, ölümlülüğün hatırlatıcısıdır. Geç kalma rüyaları, "yaşam görevi"ni tamamlayamama korkusunu yansıtabilir.',
      actionAdvice: [
        'Gerçekçi olmayan beklentileri sorgula',
        'Önceliklerini belirle',
        '"Yeterince iyi" kavramını öğren',
      ],
      evolutionNotes:
          'Zaman yönetimi ve önceliklendirme iyileştiğinde, bu rüyalar azalır.',
      breakingAdvice:
          'Yatmadan önce yarının planını yaz. Bilinçaltı, organize olduğunu bilsin.',
    ),
    RecurringDreamPattern(
      patternId: 'house',
      title: 'Ev Keşfi Rüyaları',
      description: 'Evde bilinmeyen odalar keşfetme',
      commonSymbols: ['ev', 'yeni odalar', 'gizli kapılar', 'bodrum', 'çatı'],
      frequency: 'Yaygın, özellikle kişisel gelişim dönemlerinde',
      psychologicalMeaning:
          'Keşfedilmemiş potansiyel, bilinmeyen benlik yönleri. Ev = psişe. Yeni odalar = fark edilmemiş yetenekler.',
      jungianAnalysis:
          'Jung ev rüyalarını çok önemsedi. Bodrum = bilinçdışı, üst katlar = bilinç, çatı = spiritüel.',
      actionAdvice: [
        'Keşfettiğin odanın özelliklerini not et',
        'Bu alan hayatında neyi temsil ediyor?',
        'Yeni yetenekleri keşfetme cesareti göster',
      ],
      evolutionNotes:
          'Pozitif gelişim işareti. Yeni odalar, büyüme potansiyelini gösterir.',
      breakingAdvice:
          'Bu kalıbı "kırmak" değil, takip etmek gerekir. Her yeni oda bir mesajdır.',
    ),
    RecurringDreamPattern(
      patternId: 'exam',
      title: 'Sınav Rüyaları',
      description: 'Hazırlıksız sınava girme, soruları bilememe',
      commonSymbols: ['sınav', 'okul', 'test', 'hazırlıksız', 'başarısızlık'],
      frequency: 'Çok yaygın, mezuniyetten yıllar sonra bile',
      psychologicalMeaning:
          'Değerlendirilme kaygısı, yetersizlik korkusu. Hayatta "sınanma" hissi.',
      jungianAnalysis:
          'Yargıç arketipinin aktif olması. İç eleştirmen çok güçlü. Bazen dış otoriteyle çatışma.',
      actionAdvice: [
        'Hangi alanda test edildiğini hissediyorsun?',
        'İç eleştirmenle diyalog kur',
        'Mükemmeliyetçiliği bırak',
      ],
      evolutionNotes:
          'Öz-kabul ve başarısızlık korkusunun azalmasıyla bu rüyalar seyrekleşir.',
      breakingAdvice:
          'Kendine hatırlat: Okulu bitirdin. Artık hayat sınavı var ve bunun cevap anahtarı yok.',
    ),
    RecurringDreamPattern(
      patternId: 'flying',
      title: 'Uçma Rüyaları (Olumlu Tekrar)',
      description: 'Kontrollü uçma, özgürce süzülme',
      commonSymbols: ['uçmak', 'gökyüzü', 'özgürlük', 'kontrol'],
      frequency: 'Yaygın, pozitif gelişim dönemlerinde artar',
      psychologicalMeaning:
          'Özgürlük, kontrol hissi, sınırlamaları aşma. Genellikle pozitif psikolojik durumun işareti.',
      jungianAnalysis:
          'Ego\'nun bilinçdışı ile sağlıklı ilişkisi. Kahraman arketipinin olumlu tezahürü.',
      actionAdvice: [
        'Uçuşu hatırla ve o özgürlük hissini gün içinde taşı',
        'Bu his hangi başarıyla bağlantılı?',
        'Daha fazla uçuş için: lucid rüya pratikleri',
      ],
      evolutionNotes:
          'Bu pozitif bir kalıp. Devam etmesi sağlıklı psişenin işareti.',
      breakingAdvice:
          'Kırma değil, artırma hedefle. Uçuş rüyalarını lucid rüyaya çevir.',
    ),
    RecurringDreamPattern(
      patternId: 'water-danger',
      title: 'Su Tehlikesi Rüyaları',
      description: 'Boğulma, sel, fırtınalı deniz',
      commonSymbols: ['su', 'boğulma', 'dalga', 'fırtına', 'sel'],
      frequency: 'Yaygın, duygusal çalkantı dönemlerinde',
      psychologicalMeaning:
          'Duygusal bunaltı, bastırılmış duyguların yüzeye çıkması. Su = duygular, tehlike = kontrol kaybı.',
      jungianAnalysis:
          'Bilinçdışının ego\'yu tehdit etmesi. Duyguların bastırılması artık işe yaramıyor.',
      actionAdvice: [
        'Hangi duygular bastırılıyor?',
        'Ağlamaya, hissetmeye izin ver',
        'Duygusal ifade kanalları bul',
      ],
      evolutionNotes:
          'Duygusal ifade öğrenildiğinde, su rüyaları sakinleşir - sakin göller, berrak akarsular.',
      breakingAdvice: 'Duygular bataklık değil, akarsudur. Akmasına izin ver.',
    ),
    RecurringDreamPattern(
      patternId: 'death-loved',
      title: 'Sevilen Birinin Ölümü Rüyaları',
      description: 'Anne, baba, eş veya çocuğun ölümü',
      commonSymbols: ['ölüm', 'aile', 'kayıp', 'cenaze', 'veda'],
      frequency: 'Yaygın, özellikle bağlanma kaygısı olanlarda',
      psychologicalMeaning:
          'Kaybetme korkusu, bağımlılık farkındalığı. Bazen ilişkideki "ölü" yönleri temsil eder.',
      jungianAnalysis:
          'İçselleştirilmiş figürün dönüşümü. Ebeveyn rüyaları, iç ebeveyn arketipinin değişimini gösterebilir.',
      actionAdvice: [
        'Bu kişiyle ilişkini incele',
        'Bağımlılık mı, sağlıklı bağ mı?',
        '"Ölüm" neyin bitişini temsil edebilir?',
      ],
      evolutionNotes:
          'İlişkiler olgunlaştığında, ölüm rüyaları dönüşüm rüyalarına dönüşür.',
      breakingAdvice:
          'Sevdiklerinle zaman geçir, ifade et. Ama bağımlılık değil, olgun sevgi geliştir.',
    ),
  ];

  /// Kalıp ID\'sine göre bul
  static RecurringDreamPattern? getByPatternId(String id) {
    try {
      return kaliplar.firstWhere((k) => k.patternId == id);
    } catch (e) {
      return null;
    }
  }

  /// Sembole göre kalıp bul
  static List<RecurringDreamPattern> findBySymbol(String symbol) {
    return kaliplar
        .where(
          (k) => k.commonSymbols.any(
            (s) => s.toLowerCase().contains(symbol.toLowerCase()),
          ),
        )
        .toList();
  }
}

/// Tekrarlayan rüya kalıbı modeli
class RecurringDreamPattern {
  final String patternId;
  final String title;
  final String description;
  final List<String> commonSymbols;
  final String frequency;
  final String psychologicalMeaning;
  final String jungianAnalysis;
  final List<String> actionAdvice;
  final String evolutionNotes;
  final String breakingAdvice;

  const RecurringDreamPattern({
    required this.patternId,
    required this.title,
    required this.description,
    required this.commonSymbols,
    required this.frequency,
    required this.psychologicalMeaning,
    required this.jungianAnalysis,
    required this.actionAdvice,
    required this.evolutionNotes,
    required this.breakingAdvice,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// KÂBUS DÖNÜŞÜM REHBERİ
// ════════════════════════════════════════════════════════════════════════════

/// Kâbus dönüşüm teknikleri ve yorumları
class KabusDonusumRehberi {
  static const List<NightmareGuide> rehberler = [
    NightmareGuide(
      nightmareType: 'monster',
      title: 'Canavar / Yaratık Kâbusları',
      description: 'Korkunç yaratıklar, canavarlar tarafından tehdit edilme',
      shadowElement: 'Reddedilen öfke, güç veya cinsellik',
      transformationMessage:
          'Canavar, bastırılmış gücündür. Korktukça büyür, kucakladıkça dost olur.',
      integrationSteps: [
        'Uyanınca canavari çiz - detaylara bak',
        'Canavara bir isim ver',
        'Hayal et: Canavarla konuşuyorsun, ne istiyor?',
        'Hangi bastırılmış gücü temsil ediyor?',
        'Bu gücü sağlıklı nasıl ifade edebilirsin?',
      ],
      empowermentNote:
          'Gölge entegre edildiğinde, canavar koruyucu güce dönüşür. Sonraki rüyalarında '
          'aynı yaratık sana yardım edebilir.',
      safetyReminder:
          'Bu yorumlar eğitim amaçlıdır. Travma sonrası kâbuslar için profesyonel destek alın.',
    ),
    NightmareGuide(
      nightmareType: 'attack',
      title: 'Saldırı / Şiddet Kâbusları',
      description: 'Fiziksel saldırı, silah, yaralanma',
      shadowElement: 'Sınır ihlalleri, bastırılmış öfke, travma',
      transformationMessage:
          'Saldırı rüyaları, sınırlarının ihlal edildiğini gösterir. İçsel savaşçını uyandırma çağrısı.',
      integrationSteps: [
        'Saldırgan kim? Tanıdık mı, yabancı mı?',
        'Hayatında sınırların nerede ihlal ediliyor?',
        'Savunma mekanizmalarını güçlendir',
        'Asertiflik pratikleri yap',
        'Güvenli ortamda öfke ifade et (spor, yazı, terapi)',
      ],
      empowermentNote:
          'Sınırlarını korumayı öğrendiğinde, rüyalarda saldırgana karşı koyabilir veya '
          'saldırı rüyaları biter.',
      safetyReminder:
          'Gerçek şiddet deneyimi varsa, mutlaka travma uzmanıyla çalış. EMDR etkili olabilir.',
    ),
    NightmareGuide(
      nightmareType: 'death-self',
      title: 'Kendi Ölümü Kâbusları',
      description: 'Ölmek, öldürülmek, ölüm anı deneyimi',
      shadowElement: 'Dönüşüm korkusu, ego ölümü, büyük değişim',
      transformationMessage:
          'Rüyada ölmek, genellikle ego\'nun dönüşümüdür. Bir şey bitiyor ki yenisi başlasın.',
      integrationSteps: [
        'Nasıl öldün? Bu detay önemli',
        'Ölümden sonra ne oldu? Rüya devam etti mi?',
        'Hayatında ne bitiyor veya bitmesi gerekiyor?',
        'Değişime direncini fark et',
        'Bırakma ritüeli yap: Ne gidecek, ne kalacak?',
      ],
      empowermentNote:
          'Ölüm rüyasını tamamlayabilenler (yani rüyada ölüp sonrasını görenler) '
          'genellikle derin dönüşüm yaşar.',
      safetyReminder:
          'Gerçek ölüm düşünceleri varsa, hemen yardım al: 182 (Türkiye İntihar Önleme Hattı)',
    ),
    NightmareGuide(
      nightmareType: 'paralysis',
      title: 'Uyku Felci Kâbusları',
      description: 'Hareket edememe, baskı hissi, gölge figürler',
      shadowElement: 'Kontrol kaybı, bastırılmış korku, yaşam geçişleri',
      transformationMessage:
          'Uyku felci, REM atonisinin farkındalığıdır. Korkunç hissettiren şey, '
          'kontrol kaybıdır - ki bu da bırakmayı öğretir.',
      integrationSteps: [
        'Felç anında paniğe kapılma - geçici',
        'Sadece bir parmağını kıpırdatmaya odaklan',
        'Nefese odaklan',
        'Gölge figür varsa, soru sor: "Ne istiyorsun?"',
        'Uyku hijyenini düzenle (düzenli uyku, az kafein)',
      ],
      empowermentNote:
          'Uyku felci, lucid rüyaya geçiş kapısı olabilir. Korku yerine merak ile yaklaş.',
      safetyReminder:
          'Sık uyku felci, uyku bozukluğunun işareti olabilir. Uyku kliniğine danış.',
    ),
    NightmareGuide(
      nightmareType: 'falling-endless',
      title: 'Sonsuz Düşüş Kâbusları',
      description: 'Bitmeyen düşüş, dibe çarpma',
      shadowElement: 'Kontrolsüzlük, başarısızlık korkusu, temelsizlik',
      transformationMessage:
          'Düşüş, bırakma çağrısıdır. Tutunmayı bıraktığında, kanatların açılır.',
      integrationSteps: [
        'Düşerken ne hissettin? Korku mu, teslim mi?',
        'Dibe çarptın mı? Sonra ne oldu?',
        'Hayatında neyi kontrol etmeye çalışıyorsun?',
        'Kontrolü bırakma pratiği yap',
        'Güven: Evren seni tutar',
      ],
      empowermentNote:
          'Düşüşü kabul edenler, rüyada uçmaya başlar. Bu en güçlü dönüşümlerden biridir.',
      safetyReminder:
          'Düşme rüyaları bazen fizyolojik (tansiyon, iç kulak). Sık oluyorsa kontrol ettir.',
    ),
    NightmareGuide(
      nightmareType: 'trapped',
      title: 'Sıkışmış Kalma Kâbusları',
      description: 'Dar alan, hapis, çıkış yok',
      shadowElement: 'Kısıtlanma, ilişki/iş tuzağı, özgürlük kaybı',
      transformationMessage:
          'Sıkışmışlık, farkındalık eksikliğidir. Çıkış her zaman var - bakış açını değiştir.',
      integrationSteps: [
        'Nerede sıkıştın? Detayları not et',
        'Hayatında nerede "tuzakta" hissediyorsun?',
        'Çıkış olasılıklarını listele (gerçek hayatta)',
        'En küçük adımı belirle',
        'Yardım istemeye cesaret et',
      ],
      empowermentNote:
          'Rüyada çıkış bulduğunda veya tuzağı kırdığında, gerçek hayatta da '
          'çözüm yolları açılır.',
      safetyReminder:
          'Gerçek hayatta sıkışmışlık hissi yoğunsa (ilişki, iş), profesyonel destek al.',
    ),
  ];

  /// Tip\'e göre rehber bul
  static NightmareGuide? getByType(String type) {
    try {
      return rehberler.firstWhere((r) => r.nightmareType == type);
    } catch (e) {
      return null;
    }
  }
}

/// Kâbus dönüşüm rehberi modeli
class NightmareGuide {
  final String nightmareType;
  final String title;
  final String description;
  final String shadowElement;
  final String transformationMessage;
  final List<String> integrationSteps;
  final String empowermentNote;
  final String safetyReminder;

  const NightmareGuide({
    required this.nightmareType,
    required this.title,
    required this.description,
    required this.shadowElement,
    required this.transformationMessage,
    required this.integrationSteps,
    required this.empowermentNote,
    required this.safetyReminder,
  });
}

// ════════════════════════════════════════════════════════════════════════════
// GENİŞLETİLMİŞ VİRAL ALINTILAR - 100+ Toplam
// ════════════════════════════════════════════════════════════════════════════

/// Genişletilmiş alıntı koleksiyonu
class GenisletilmisAlintilar {
  static const List<ShareableCard> ekAlintilar = [
    // GÖLGE & DÖNÜŞÜM
    ShareableCard(
      emoji: '🌑',
      quote: 'Gölgeni tanımadan ışığını bilemezsin.',
      category: 'Gölge',
    ),
    ShareableCard(
      emoji: '🦋',
      quote: 'Değişim acıtır, değişmemek daha çok.',
      category: 'Dönüşüm',
    ),
    ShareableCard(
      emoji: '🔥',
      quote: 'Anka kuşu önce yanar, sonra yükselir.',
      category: 'Yenilenme',
    ),
    ShareableCard(
      emoji: '🌙',
      quote: 'Ay bile her gece yeniden doğar.',
      category: 'Döngü',
    ),
    ShareableCard(
      emoji: '🌊',
      quote: 'Dalga olmak ister misin, okyanus olmak mı?',
      category: 'Derinlik',
    ),
    ShareableCard(
      emoji: '⚡',
      quote: 'Fırtına geçer, sen kalırsın.',
      category: 'Dayanıklılık',
    ),
    ShareableCard(
      emoji: '🗝️',
      quote: 'Kilit değişmez, anahtar ararız.',
      category: 'Çözüm',
    ),
    ShareableCard(
      emoji: '🪞',
      quote: 'Ayna yalan söylemez, sen yorumlarsın.',
      category: 'Gerçek',
    ),
    ShareableCard(
      emoji: '🌅',
      quote: 'Her gece bir şafağa gebedir.',
      category: 'Umut',
    ),
    ShareableCard(
      emoji: '🧭',
      quote: 'Kaybolmak bazen yolu bulmanın ta kendisidir.',
      category: 'Yolculuk',
    ),

    // BİLGELİK & SEZGİ
    ShareableCard(
      emoji: '🦉',
      quote: 'Bilgelik susmayı bilmekle başlar.',
      category: 'Bilgelik',
    ),
    ShareableCard(
      emoji: '🔮',
      quote: 'Gelecek sezende, geçmiş hafızanda yaşar.',
      category: 'Sezgi',
    ),
    ShareableCard(
      emoji: '📿',
      quote: 'Her nefes bir dua, her adım bir meditasyondur.',
      category: 'Spiritüellik',
    ),
    ShareableCard(
      emoji: '🌳',
      quote: 'Köklerin derinliği, dalların yüksekliğini belirler.',
      category: 'Temel',
    ),
    ShareableCard(
      emoji: '💫',
      quote: 'Evren seninle değil, senin aracılığınla konuşur.',
      category: 'Bağlantı',
    ),
    ShareableCard(
      emoji: '🕯️',
      quote: 'Tek bir mum bin karanlığı aydınlatır.',
      category: 'Işık',
    ),
    ShareableCard(
      emoji: '📜',
      quote: 'Kadim bilgelik modern sorunlara da yanıt verir.',
      category: 'Zamansız',
    ),
    ShareableCard(
      emoji: '🧘',
      quote: 'Dışarı bakarak arar, içeri bakarak bulursun.',
      category: 'İçsel',
    ),
    ShareableCard(
      emoji: '🎋',
      quote: 'Bambu rüzgârda eğilir ama kırılmaz.',
      category: 'Esneklik',
    ),
    ShareableCard(
      emoji: '⏳',
      quote: 'Zaman en iyi öğretmen, ama öğrencilerini öldürür.',
      category: 'Zaman',
    ),

    // CESARET & GÜÇ
    ShareableCard(
      emoji: '🦁',
      quote: 'İçindeki aslan uyumuyor, sessiz bekliyor.',
      category: 'Güç',
    ),
    ShareableCard(
      emoji: '⚔️',
      quote: 'Gerçek savaşçı önce kendini fetheder.',
      category: 'Zafer',
    ),
    ShareableCard(
      emoji: '🛡️',
      quote: 'En iyi savunma, saldırı değil farkındalıktır.',
      category: 'Koruma',
    ),
    ShareableCard(
      emoji: '🏹',
      quote: 'Ok geriye çekilmeden ileriye gidemez.',
      category: 'Hazırlık',
    ),
    ShareableCard(
      emoji: '💪',
      quote: 'Güç kaslarında değil, niyetinde saklı.',
      category: 'İrade',
    ),
    ShareableCard(
      emoji: '🌋',
      quote: 'Sessiz yanardağ en tehlikelisidir - patlama zamanını bekle.',
      category: 'Potansiyel',
    ),
    ShareableCard(
      emoji: '🔱',
      quote: 'Üç kol: Düşünce, söz, eylem - üçü bir olsun.',
      category: 'Bütünlük',
    ),
    ShareableCard(
      emoji: '👑',
      quote: 'Taç ağırdır, ama başın dik olsun.',
      category: 'Sorumluluk',
    ),
    ShareableCard(
      emoji: '🐉',
      quote: 'Ejderhayla savaşma, ejderha ol.',
      category: 'Dönüşüm',
    ),
    ShareableCard(
      emoji: '🏔️',
      quote: 'Dağ yerinden oynamaz, sen tırman.',
      category: 'Azim',
    ),

    // AŞK & İLİŞKİLER
    ShareableCard(
      emoji: '💕',
      quote: 'Gerçek aşk, maskelerin düştüğü yerde başlar.',
      category: 'Aşk',
    ),
    ShareableCard(
      emoji: '🌹',
      quote: 'Gül dikensiz olmaz, aşk acısız.',
      category: 'Kabullenme',
    ),
    ShareableCard(
      emoji: '🔗',
      quote: 'Bağ, bağımlılık değil; özgürlükte birlikteliktir.',
      category: 'İlişki',
    ),
    ShareableCard(
      emoji: '💑',
      quote: 'Ruh eşi bulmak değil, ruhunu paylaşmaktır.',
      category: 'Birlik',
    ),
    ShareableCard(
      emoji: '❤️‍🔥',
      quote: 'Yanmadan ısıtmak, aşkın sırrıdır.',
      category: 'Denge',
    ),
    ShareableCard(
      emoji: '🤝',
      quote: 'El ele değil, yan yana yürümek sevgidir.',
      category: 'Ortaklık',
    ),
    ShareableCard(
      emoji: '💔',
      quote: 'Kırık kalp, daha geniş sevebilir.',
      category: 'Şifa',
    ),
    ShareableCard(
      emoji: '🕊️',
      quote: 'Özgür bıraktığın döner, tuttuğun kaçar.',
      category: 'Özgürlük',
    ),
    ShareableCard(
      emoji: '🌺',
      quote: 'Çiçek sulanmadan açmaz, ilişki beslenme ister.',
      category: 'Bakım',
    ),
    ShareableCard(
      emoji: '🪢',
      quote: 'Düğümü çözmek, kesmekten zordur ama değerlidir.',
      category: 'Sabır',
    ),

    // KORKU & KARANLIK
    ShareableCard(
      emoji: '👁️',
      quote: 'Korku, görmek istemediğinin gölgesidir.',
      category: 'Korku',
    ),
    ShareableCard(
      emoji: '🕳️',
      quote: 'Karanlık delik değil, bilinmeyen kapıdır.',
      category: 'Bilinmeyen',
    ),
    ShareableCard(
      emoji: '🌫️',
      quote: 'Sis kalkar, yol görünür. Bekle.',
      category: 'Belirsizlik',
    ),
    ShareableCard(
      emoji: '🕸️',
      quote: 'Örümcek ağında mahsur olan, hareket edendir.',
      category: 'Sabır',
    ),
    ShareableCard(
      emoji: '🦇',
      quote: 'Karanlıkta görmek, ışıktan daha zordur ama öğrenilir.',
      category: 'Adaptasyon',
    ),
    ShareableCard(
      emoji: '👤',
      quote: 'Gölgenden kaçma, ona isim ver.',
      category: 'Yüzleşme',
    ),
    ShareableCard(
      emoji: '🌑',
      quote: 'Yeni ayın karanlığı, dolunayın hazırlığıdır.',
      category: 'Döngü',
    ),
    ShareableCard(
      emoji: '🗡️',
      quote: 'Korkularını kesme, onları anla.',
      category: 'Entegrasyon',
    ),
    ShareableCard(
      emoji: '🎃',
      quote: 'Korkunç olan, anlaşılmayandır.',
      category: 'Anlayış',
    ),
    ShareableCard(
      emoji: '💀',
      quote: 'Ölüm düşmanın değil, dönüşümün habercisi.',
      category: 'Geçiş',
    ),

    // ZAMAN & DÖNGÜLER
    ShareableCard(
      emoji: '⌛',
      quote: 'Kum tanesi kum tanesi, çöl olur.',
      category: 'Sabır',
    ),
    ShareableCard(
      emoji: '🔄',
      quote: 'Döngü kırılmaz, anlaşılır ve aşılır.',
      category: 'Döngü',
    ),
    ShareableCard(
      emoji: '📅',
      quote: 'Dün geçti, yarın yok, şimdi var.',
      category: 'Şimdi',
    ),
    ShareableCard(
      emoji: '🌗',
      quote: 'Yarı dolu, yarı boş - ikisi de sen.',
      category: 'Denge',
    ),
    ShareableCard(
      emoji: '🎡',
      quote: 'Dönme dolap: Bazen tepede, bazen dipte - ikisi de geçici.',
      category: 'Döngüsellik',
    ),
    ShareableCard(
      emoji: '🌱',
      quote: 'Tohum zamanında çatlat, mevsimi bekle.',
      category: 'Zamanlama',
    ),
    ShareableCard(
      emoji: '🍂',
      quote: 'Yaprak düşer ki ağaç yaşasın.',
      category: 'Bırakma',
    ),
    ShareableCard(
      emoji: '❄️',
      quote: 'Kış olmadan bahar bilinmez.',
      category: 'Kontrast',
    ),
    ShareableCard(
      emoji: '🌾',
      quote: 'Hasat sabırlı ekenin hakkıdır.',
      category: 'Emek',
    ),
    ShareableCard(
      emoji: '🌛',
      quote: 'Ay affetmez, sadece döner.',
      category: 'Döngü',
    ),

    // ÖZ-DEĞER & KİMLİK
    ShareableCard(
      emoji: '💎',
      quote: 'Elmas baskı altında oluşur, parlak doğmaz.',
      category: 'Değer',
    ),
    ShareableCard(
      emoji: '🪶',
      quote: 'Kuş tüyü kadar hafif, dağ kadar sağlam ol.',
      category: 'Denge',
    ),
    ShareableCard(
      emoji: '🎭',
      quote: 'Maske düşünce, gerçek yüz kalır.',
      category: 'Otantiklik',
    ),
    ShareableCard(
      emoji: '🏛️',
      quote: 'Tapınak içeride, dışarıda aramayı bırak.',
      category: 'İçsel',
    ),
    ShareableCard(
      emoji: '🪷',
      quote: 'Nilüfer çamurda doğar, gökte açar.',
      category: 'Yükseliş',
    ),
    ShareableCard(
      emoji: '🌟',
      quote: 'Yıldız olmak için karanlık gerek.',
      category: 'Parlaklık',
    ),
    ShareableCard(
      emoji: '🦚',
      quote: 'Tavus kuşu tüylerini değil, duruşunu sergiler.',
      category: 'Özgüven',
    ),
    ShareableCard(
      emoji: '🪻',
      quote: 'Çiçek başkası için açmaz, kendi için.',
      category: 'Öz-sevgi',
    ),
    ShareableCard(
      emoji: '🐚',
      quote: 'İnci, tahriş edilen istiridyenin eseridir.',
      category: 'Dönüşüm',
    ),
    ShareableCard(
      emoji: '🏆',
      quote: 'Kupa dışarıda, zafer içeride.',
      category: 'Başarı',
    ),

    // ASTROLOJİK
    ShareableCard(
      emoji: '☿',
      quote: 'Merkür retro: Geri değil, içeri git.',
      category: 'Retro',
    ),
    ShareableCard(
      emoji: '♀',
      quote: 'Venüs der ki: Güzellik bakanın gözündedir.',
      category: 'Güzellik',
    ),
    ShareableCard(
      emoji: '♂',
      quote: 'Mars der ki: Enerji yönlendirilmezse yakar.',
      category: 'Enerji',
    ),
    ShareableCard(
      emoji: '♃',
      quote: 'Jüpiter genişletir - neyi genişlettiğine dikkat et.',
      category: 'Büyüme',
    ),
    ShareableCard(
      emoji: '♄',
      quote: 'Satürn sıkıştırır ki özün ortaya çıksın.',
      category: 'Disiplin',
    ),
    ShareableCard(
      emoji: '♅',
      quote: 'Uranüs beklenmedik kapılar açar - cesaret et.',
      category: 'Sürpriz',
    ),
    ShareableCard(
      emoji: '♆',
      quote: 'Neptün sis verir ki sezgini kullan.',
      category: 'Sezgi',
    ),
    ShareableCard(
      emoji: '♇',
      quote: 'Plüton öldürür ki yeniden doğasın.',
      category: 'Dönüşüm',
    ),
    ShareableCard(
      emoji: '☊',
      quote: 'Kuzey Node: Korktuğun yönde git.',
      category: 'Kader',
    ),
    ShareableCard(
      emoji: '☋',
      quote: 'Güney Node: Bildiğini bırak, bilinmeyene adım at.',
      category: 'Geçmiş',
    ),
  ];

  /// Tüm alıntıları getir (orijinal + ek)
  static List<ShareableCard> get tumAlintilar {
    // Orijinal ShareableQuoteTemplates.quotes ile birleştir
    return [...GenisletilmisAlintilar.ekAlintilar];
  }

  /// Kategoriye göre filtrele
  static List<ShareableCard> kategoriyeGore(String kategori) {
    return tumAlintilar.where((a) => a.category == kategori).toList();
  }

  /// Rastgele alıntı
  static ShareableCard rastgele() {
    final all = tumAlintilar;
    return all[DateTime.now().millisecondsSinceEpoch % all.length];
  }
}
