/// Dream Symbols Database - 7 Boyutlu Rüya Sembol Ansiklopedisi
/// 50+ evrensel sembol, Jungian arketipler, astrolojik bağlantılar
library;

import '../models/dream_interpretation_models.dart';

// ════════════════════════════════════════════════════════════════
// SEMBOL VERİTABANI
// ════════════════════════════════════════════════════════════════

/// Ana sembol veritabanı
class DreamSymbolsDatabase {
  static const List<DreamSymbolData> allSymbols = [
    // ═══════════════════════════════════════════════════════════
    // SU & SIVILAR - Duygusal dünya
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'water',
      symbolTr: 'Su',
      emoji: '💧',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Duygusal derinlik ve bilinçaltı',
        'Arınma ve yenilenme',
        'Hayatın akışı ve değişim',
        'Feminen enerji ve sezgi',
      ],
      emotionVariants: {
        EmotionalTone.korku:
            'Bastırılmış duygular yüzeye çıkmak istiyor - dalga tehditkar geliyorsa kontrol kaybı korkusu',
        EmotionalTone.huzur:
            'Duygusal denge ve iç huzur - bilinçaltınla barışıksın',
        EmotionalTone.merak:
            'Keşfedilmemiş duygusal derinlikler - sezgisel kapasiten artıyor',
        EmotionalTone.donukluk: 'Duygusal uyuşukluk - hissetmekten kaçınma',
      },
      archetypes: ['Anne', 'Bilinçdışı', 'Transformasyon'],
      relatedSymbols: ['ocean', 'rain', 'river', 'flood'],
      shadowAspect:
          'Duygulara boğulma korkusu, kontrol kaybı, bastırılmış acılar',
      lightAspect: 'Duygusal zeka, sezgisel bilgelik, yaşam enerjisi',
    ),

    DreamSymbolData(
      symbol: 'ocean',
      symbolTr: 'Okyanus',
      emoji: '🌊',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Sonsuz bilinçdışı',
        'Kolektif bilinç',
        'Hayatın kökeni',
        'Sınırsız olasılıklar',
      ],
      emotionVariants: {
        EmotionalTone.korku:
            'Varoluşsal endişe - bilinmeyenin derinliği ürkütüyor',
        EmotionalTone.huzur: 'Evrenle bütünleşme - spiritüel birlik hissi',
        EmotionalTone.ozlem:
            'Kayıp bütünlüğe özlem - anne rahmine dönüş arzusu',
        EmotionalTone.heyecan: 'Keşfedilecek sonsuz potansiyel - yeni ufuklar',
      },
      archetypes: ['Büyük Anne', 'Kolektif Bilinçdışı', 'Kaos'],
      relatedSymbols: ['water', 'fish', 'ship', 'drowning'],
      shadowAspect: 'Ezici büyüklük, kimlik kaybı, kontrol edilemezlik',
      lightAspect: 'Sonsuz potansiyel, evrensel bağlantı, ruhsal genişlik',
    ),

    DreamSymbolData(
      symbol: 'rain',
      symbolTr: 'Yağmur',
      emoji: '🌧️',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Duygusal boşalma ve arınma',
        'Bereket ve bolluk',
        'Gözyaşları ve keder',
        'Yenilenme ve taze başlangıç',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Doğal akış - bırak gitsin, evren seni temizliyor',
        EmotionalTone.sucluluk: 'Bastırılmış gözyaşları - ağlamaya izin ver',
        EmotionalTone.ozlem: 'Nostalji - geçmişin kokusu',
        EmotionalTone.korku: 'Yaklaşan fırtına - duygu seli',
      },
      archetypes: ['Gökyüzü Tanrısı', 'Bereket', 'Arınma'],
      relatedSymbols: ['water', 'storm', 'umbrella', 'tears'],
      shadowAspect: 'Bastırılmış keder, duygusal baskı, melankoli',
      lightAspect: 'Duygusal özgürlük, doğal döngü, beslenme',
    ),

    DreamSymbolData(
      symbol: 'flood',
      symbolTr: 'Sel',
      emoji: '🌊',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Aşırı duygu yoğunluğu',
        'Kontrol kaybı',
        'Köklü değişim',
        'Eski yapıların yıkılması',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Duygusal tsunami - bastırdıkların patlamak üzere',
        EmotionalTone.heyecan:
            'Kaotik dönüşüm - eskinin yıkılması yeniyi getirir',
        EmotionalTone.donukluk: 'Şok - çok fazla geldi, dondum',
        EmotionalTone.ofke: 'Bastırılmış öfke taşıyor - sınırlar aşıldı',
      },
      archetypes: ['Kaos', 'Yeniden Doğuş', 'Tufan'],
      relatedSymbols: ['water', 'destruction', 'survival', 'ark'],
      shadowAspect: 'Kontrol kaybı, yok edici duygular, çaresizlik',
      lightAspect: 'Köklü dönüşüm, eski kalıpların temizlenmesi, yenilenme',
    ),

    // ═══════════════════════════════════════════════════════════
    // HAYVANLAR - İçgüdüsel yönler
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'snake',
      symbolTr: 'Yılan',
      emoji: '🐍',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Dönüşüm ve deri değiştirme',
        'Şifa ve bilgelik (Asklepios asası)',
        'Kundalini enerji ve cinsellik',
        'Gizli düşman veya ihanet',
      ],
      emotionVariants: {
        EmotionalTone.korku:
            'İhanet korkusu veya bastırılmış cinsellik - kim veya ne tehdit ediyor?',
        EmotionalTone.merak: 'Bilgelik arayışı - dönüşüm kapıda',
        EmotionalTone.heyecan:
            'Kundalini uyanışı - yaratıcı/cinsel enerji yükseliyor',
        EmotionalTone.ofke: 'Zehirli bir durum veya kişi - sınırları koru',
      },
      archetypes: ['Dönüştürücü', 'Bilge', 'Gölge'],
      relatedSymbols: ['transformation', 'healing', 'danger', 'wisdom'],
      shadowAspect: 'İhanet, zehir, gizli tehdit, bastırılmış cinsellik',
      lightAspect: 'Bilgelik, şifa, dönüşüm, yaşam gücü',
    ),

    DreamSymbolData(
      symbol: 'dog',
      symbolTr: 'Köpek',
      emoji: '🐕',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Sadakat ve koşulsuz sevgi',
        'İçgüdüler ve koruma',
        'Dostluk ve bağlılık',
        'Rehberlik (özellikle siyah köpek)',
      ],
      emotionVariants: {
        EmotionalTone.huzur:
            'Güvenilir dostluk - birileri seni koşulsuz seviyor',
        EmotionalTone.korku:
            'Saldırgan köpek: içgüdüsel tehdit, sadakatsizlik korkusu',
        EmotionalTone.ozlem: 'Kayıp bir bağlılık - eski dostluk özlemi',
        EmotionalTone.heyecan:
            'Yeni sadık bir bağ - güvenebileceğin biri geliyor',
      },
      archetypes: ['Koruyucu', 'Rehber', 'Sadık Dost'],
      relatedSymbols: ['loyalty', 'protection', 'instinct', 'guide'],
      shadowAspect: 'Kölelik, bağımlılık, kontrolsüz içgüdüler',
      lightAspect: 'Koşulsuz sevgi, sadakat, koruma, içgüdüsel bilgelik',
    ),

    DreamSymbolData(
      symbol: 'cat',
      symbolTr: 'Kedi',
      emoji: '🐱',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Bağımsızlık ve özgürlük',
        'Feminen gizem ve sezgi',
        'Gece ve gölge yönleri',
        'Dokuz can - dayanıklılık',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Gizemi çözme arzusu - sezgilerine güven',
        EmotionalTone.huzur: 'Özgür ruhun - kendi yolunu çiz',
        EmotionalTone.korku: 'Kara kedi: gölge feminen, kötü şans korkusu',
        EmotionalTone.ozlem: 'Kaybedilen bağımsızlık - kendi alanın nerede?',
      },
      archetypes: ['Gizemli Feminen', 'Bağımsız', 'Gece Varlığı'],
      relatedSymbols: ['independence', 'mystery', 'intuition', 'night'],
      shadowAspect: 'Soğukluk, erişilemezlik, kayıtsızlık',
      lightAspect: 'Bağımsızlık, sezgi, zarif güç, öz-yeterlilik',
    ),

    DreamSymbolData(
      symbol: 'bird',
      symbolTr: 'Kuş',
      emoji: '🐦',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Özgürlük ve ruh',
        'Yüksek bakış açısı',
        'Haberci - mesaj taşıyıcı',
        'Ruhsal yükseliş',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Ruhsal hafiflik - yüklerden kurtuluş',
        EmotionalTone.merak: 'Yeni perspektif - yukarıdan bak',
        EmotionalTone.ozlem: 'Özgürlük arzusu - kafeste mi hissediyorsun?',
        EmotionalTone.heyecan: 'Yaklaşan haber veya fırsat',
      },
      archetypes: ['Ruh', 'Haberci', 'Özgür Benlik'],
      relatedSymbols: ['freedom', 'flight', 'message', 'sky'],
      shadowAspect: 'Kaçış, gerçeklikten kopuş, tutunamamak',
      lightAspect: 'Özgürlük, ruhsal bakış, ilahi mesaj',
    ),

    DreamSymbolData(
      symbol: 'fish',
      symbolTr: 'Balık',
      emoji: '🐟',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Bilinçaltı içerikleri',
        'Bereket ve bolluk',
        'Spiritüel beslenme',
        'Gizli bilgi',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Bilinçaltından bir şey yüzeye çıkıyor',
        EmotionalTone.huzur: 'Ruhsal beslenme - sezgisel bilgelik',
        EmotionalTone.heyecan: 'Yaklaşan bereket - bol avlanma',
        EmotionalTone.korku: 'Bilinçaltının karanlık derinlikleri',
      },
      archetypes: ['Bilinçdışı İçerik', 'Bereket', 'Gizem'],
      relatedSymbols: ['water', 'ocean', 'abundance', 'unconscious'],
      shadowAspect: 'Ele avuca sığmazlık, kaygan duygular, derinlik korkusu',
      lightAspect: 'Spiritüel içgörü, bilinçdışı bilgelik, bereket',
    ),

    DreamSymbolData(
      symbol: 'spider',
      symbolTr: 'Örümcek',
      emoji: '🕷️',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Kader ağı - yaratıcılık',
        'Feminen yaratıcı güç',
        'Sabır ve strateji',
        'Tuzak ve manipülasyon',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Tuzağa düşme korkusu - kim ağ örüyor?',
        EmotionalTone.merak: 'Yaratıcı potansiyel - kendi ağını ör',
        EmotionalTone.donukluk: 'Ağda hapsolmuş - çıkış yolu bul',
        EmotionalTone.heyecan: 'Stratejik başarı - sabırla örgütleme',
      },
      archetypes: ['Dokuyucu', 'Kader', 'Karanlık Anne'],
      relatedSymbols: ['web', 'trap', 'creativity', 'patience'],
      shadowAspect: 'Manipülasyon, fobi, tuzak, boğucu anne',
      lightAspect: 'Yaratıcılık, kader dokuma, sabır, strateji',
    ),

    DreamSymbolData(
      symbol: 'horse',
      symbolTr: 'At',
      emoji: '🐎',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'Güç ve özgürlük',
        'İçgüdüsel enerji',
        'Yolculuk ve ilerleme',
        'Kontrol ve irade',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Güç ve özgürlük - dizginleri al',
        EmotionalTone.korku: 'Kontrolsüz içgüdüler - at şahlanıyor',
        EmotionalTone.huzur: 'İçgüdülerle uyum - doğal akış',
        EmotionalTone.ozlem: 'Kaybedilen özgürlük veya güç',
      },
      archetypes: ['İçgüdüsel Benlik', 'Güç', 'Özgürlük'],
      relatedSymbols: ['power', 'freedom', 'journey', 'instinct'],
      shadowAspect: 'Kontrolsüz güç, hayvansal içgüdüler, kaçış',
      lightAspect: 'Noble güç, özgür ruh, içgüdüsel bilgelik',
    ),

    DreamSymbolData(
      symbol: 'wolf',
      symbolTr: 'Kurt',
      emoji: '🐺',
      category: SymbolCategory.hayvan,
      universalMeanings: [
        'İçgüdü ve vahşi doğa',
        'Sadakat ve sürü',
        'Yalnız avcı',
        'Öğretmen ve rehber',
      ],
      emotionVariants: {
        EmotionalTone.korku:
            'Tehditkar vahşi doğa - içindeki kurt seni korkutuyor mu?',
        EmotionalTone.heyecan: 'Vahşi gücünü kucakla - özgürleş',
        EmotionalTone.ozlem: 'Ait olma arzusu - sürünü bul',
        EmotionalTone.huzur: 'Doğanla barış - içgüdülerin rehberin',
      },
      archetypes: ['Vahşi Benlik', 'Öğretmen', 'Yalnız Savaşçı'],
      relatedSymbols: ['pack', 'hunt', 'moon', 'wilderness'],
      shadowAspect: 'Yırtıcılık, tecrit, vahşet',
      lightAspect: 'İçgüdüsel bilgelik, sadakat, doğal güç',
    ),

    // ═══════════════════════════════════════════════════════════
    // MEKANLAR - İç dünya haritası
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'house',
      symbolTr: 'Ev',
      emoji: '🏠',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Benlik ve psişe',
        'Aile ve kökenler',
        'Güvenlik ve sığınak',
        'İç dünya yapısı',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Kendinle barışıksın - iç evin düzenli',
        EmotionalTone.korku: 'Harap ev: içsel çatışma, ihmal edilmiş yönler',
        EmotionalTone.merak: 'Yeni odalar: keşfedilmemiş potansiyel',
        EmotionalTone.ozlem: 'Çocukluk evi: köklere dönüş arzusu',
      },
      archetypes: ['Benlik', 'Anne/Yuva', 'İç Dünya'],
      relatedSymbols: ['room', 'door', 'window', 'basement', 'attic'],
      shadowAspect: 'İhmal edilmiş iç dünya, gizli odalar, çürüyen yapı',
      lightAspect: 'Bütünleşmiş benlik, güvenli iç mekan, ev hissi',
    ),

    DreamSymbolData(
      symbol: 'room',
      symbolTr: 'Oda',
      emoji: '🚪',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Psişenin bir bölümü',
        'Gizli yönler',
        'Sınırlar ve mahremiyet',
        'Potansiyel alanlar',
      ],
      emotionVariants: {
        EmotionalTone.merak:
            'Keşfedilmemiş oda: gizli yetenekler, bastırılmış potansiyel',
        EmotionalTone.korku:
            'Karanlık oda: yüzleşilmemiş gölge, bilinmeyen korku',
        EmotionalTone.huzur: 'Aydınlık oda: farkındalık ve kabul',
        EmotionalTone.sucluluk: 'Gizli oda: saklanan sırlar',
      },
      archetypes: ['Bilinç Bölümü', 'Sır', 'Potansiyel'],
      relatedSymbols: ['house', 'door', 'secret', 'discovery'],
      shadowAspect: 'Gizli yönler, bastırılmış içerikler, karanlık bölgeler',
      lightAspect: 'Keşif, potansiyel, mahrem alan, büyüme',
    ),

    DreamSymbolData(
      symbol: 'basement',
      symbolTr: 'Bodrum',
      emoji: '🔻',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Bilinçaltı derinlikleri',
        'Bastırılmış anılar',
        'Temel ve kökler',
        'Gizli güçler',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Karanlık bodrum: yüzleşilmemiş travmalar',
        EmotionalTone.merak: 'Antika keşfi: unutulmuş değerler',
        EmotionalTone.donukluk: 'Islak bodrum: bastırılmış duygular',
        EmotionalTone.heyecan: 'Hazine bulma: gizli potansiyel',
      },
      archetypes: ['Bilinçdışı', 'Temel', 'Gömülü Hazine'],
      relatedSymbols: ['house', 'underground', 'treasure', 'fear'],
      shadowAspect: 'Bastırılmış travmalar, yüzleşilmemiş geçmiş',
      lightAspect: 'Kök güç, gizli kaynaklar, temel değerler',
    ),

    DreamSymbolData(
      symbol: 'attic',
      symbolTr: 'Çatı Katı',
      emoji: '🔺',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Yüksek bilinç',
        'Geçmiş anılar',
        'Ruhsal bağlantı',
        'Unutulmuş hatıralar',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Keşfedilmemiş ruhsal alan',
        EmotionalTone.ozlem: 'Geçmişin hatıraları',
        EmotionalTone.huzur: 'Yüksek bakış açısı',
        EmotionalTone.korku: 'Hayaletlerle dolu: geçmişin gölgeleri',
      },
      archetypes: ['Üstbilinç', 'Anılar', 'Ruhsal Alan'],
      relatedSymbols: ['house', 'sky', 'memories', 'ancestors'],
      shadowAspect: 'Geçmişte takılma, eski kalıplar, hayaletler',
      lightAspect: 'Bilgelik, ruhsal yükseliş, değerli anılar',
    ),

    DreamSymbolData(
      symbol: 'forest',
      symbolTr: 'Orman',
      emoji: '🌲',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Bilinçdışının labirenti',
        'Kaybolma ve keşif',
        'Doğa ve içgüdü',
        'Dönüşüm yolculuğu',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Karanlık orman: yolunu kaybetme, kimlik krizi',
        EmotionalTone.huzur: 'Aydınlık orman: doğayla bütünleşme',
        EmotionalTone.merak: 'Keşfedilecek patikalar: iç yolculuk',
        EmotionalTone.heyecan: 'Macera başlıyor: dönüşüm kapıda',
      },
      archetypes: ['Bilinçdışı', 'Dönüşüm Mekanı', 'Doğa'],
      relatedSymbols: ['tree', 'path', 'darkness', 'animals'],
      shadowAspect: 'Kaybolma, tehlike, karanlık, yalnızlık',
      lightAspect: 'Doğal bilgelik, içsel yolculuk, dönüşüm',
    ),

    DreamSymbolData(
      symbol: 'school',
      symbolTr: 'Okul',
      emoji: '🏫',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Öğrenme ve gelişim',
        'Sınav ve değerlendirme',
        'Geçmiş deneyimler',
        'Otorite ve kurallar',
      ],
      emotionVariants: {
        EmotionalTone.korku:
            'Sınav kaygısı: değerlendirilme korkusu, yetersizlik',
        EmotionalTone.merak: 'Yeni dersler: hayat öğretiyor',
        EmotionalTone.sucluluk: 'Hazırlıksız yakalandın: erteleme, sorumluluk',
        EmotionalTone.ozlem: 'Eski okul: gençlik, masumiyet',
      },
      archetypes: ['Öğretmen', 'Sınav', 'Gelişim'],
      relatedSymbols: ['test', 'teacher', 'learning', 'youth'],
      shadowAspect: 'Başarısızlık korkusu, otorite kaygısı, yetersizlik',
      lightAspect: 'Sürekli gelişim, öğrenme kapasitesi, ustalık',
    ),

    DreamSymbolData(
      symbol: 'hospital',
      symbolTr: 'Hastane',
      emoji: '🏥',
      category: SymbolCategory.mekan,
      universalMeanings: [
        'Şifa ihtiyacı',
        'Acil müdahale gerektiren durum',
        'Bakım ve iyileşme',
        'Kırılganlık',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Sağlık kaygısı veya ölüm korkusu',
        EmotionalTone.huzur: 'Şifa yolunda: iyileşme başlıyor',
        EmotionalTone.merak: 'Neyin iyileşmesi gerekiyor?',
        EmotionalTone.sucluluk: 'İhmal edilmiş sağlık - kendine bak',
      },
      archetypes: ['Şifacı', 'Kırılganlık', 'Yeniden Doğuş'],
      relatedSymbols: ['healing', 'doctor', 'illness', 'care'],
      shadowAspect: 'Hastalık korkusu, kontrol kaybı, bağımlılık',
      lightAspect: 'Şifa, profesyonel destek, iyileşme',
    ),

    // ═══════════════════════════════════════════════════════════
    // EYLEMLER - Yaşam dinamikleri
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'flying',
      symbolTr: 'Uçmak',
      emoji: '🦅',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Özgürlük ve aşkınlık',
        'Yüksek bakış açısı',
        'Sınırlamaları aşma',
        'Spiritüel yükseliş',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Özgürleşme - sınırlarını aşıyorsun',
        EmotionalTone.huzur: 'Ruhsal uçuş - dünyevi kaygıların üstünde',
        EmotionalTone.korku:
            'Kontrolsüz uçuş: temelsiz hayaller, düşme korkusu',
        EmotionalTone.merak: 'Nereye uçuyorsun? - hedefini bul',
      },
      archetypes: ['Özgür Ruh', 'Aşkın Benlik', 'Kahraman'],
      relatedSymbols: ['bird', 'sky', 'freedom', 'falling'],
      shadowAspect: 'Kaçış, gerçeklikten kopma, temelsizlik',
      lightAspect: 'Gerçek özgürlük, spiritüel bakış, aşkınlık',
    ),

    DreamSymbolData(
      symbol: 'falling',
      symbolTr: 'Düşmek',
      emoji: '⬇️',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Kontrol kaybı',
        'Başarısızlık korkusu',
        'Güvensizlik',
        'Ego çöküşü',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Kontrol kaybetme korkusu - neyi bırakamıyorsun?',
        EmotionalTone.donukluk: 'Teslim olma - düşüşü kabul et',
        EmotionalTone.heyecan: 'Özgür düşüş: eski kalıplardan kurtuluş',
        EmotionalTone.sucluluk: 'Düşüşü hak etme hissi - affet kendini',
      },
      archetypes: ['Düşmüş Melek', 'Ego', 'Dönüşüm'],
      relatedSymbols: ['flying', 'ground', 'fear', 'letting-go'],
      shadowAspect: 'Başarısızlık, değersizlik, çöküş',
      lightAspect: 'Teslim olma, ego ölümü, yeniden doğuş',
    ),

    DreamSymbolData(
      symbol: 'chasing',
      symbolTr: 'Kovalanmak',
      emoji: '🏃',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Kaçınılan yönler',
        'Bastırılmış korkular',
        'Yüzleşilmemiş sorunlar',
        'Stres ve baskı',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Seni kovalayan ne? Yüzleşilmemiş gölge',
        EmotionalTone.ofke: 'Kaçtığın şeye öfke - dur ve yüzleş',
        EmotionalTone.donukluk: 'Kronik kaçınma - yoruldun',
        EmotionalTone.merak: 'Kovalayan kim? - gölgeni tanı',
      },
      archetypes: ['Gölge', 'Avcı', 'Kaçak'],
      relatedSymbols: ['running', 'monster', 'shadow', 'escape'],
      shadowAspect: 'Kaçınma, bastırma, yüzleşmeme',
      lightAspect: 'Farkındalık, entegrasyon, cesaret',
    ),

    DreamSymbolData(
      symbol: 'teeth-falling',
      symbolTr: 'Diş Dökülmesi',
      emoji: '🦷',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Güç ve imaj kaybı',
        'Yaşlanma korkusu',
        'Sözlerin gücü',
        'Güvensizlik',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'İmaj kaybı korkusu - nasıl göründüğün önemli mi?',
        EmotionalTone.sucluluk: 'Söylenmemiş sözler - ağzından ne çıkıyor?',
        EmotionalTone.donukluk: 'Güç kaybı - kendini savunamama',
        EmotionalTone.ozlem: 'Gençlik özlemi - değişimi kabul et',
      },
      archetypes: ['Persona', 'Güç', 'İletişim'],
      relatedSymbols: ['mouth', 'speech', 'image', 'aging'],
      shadowAspect: 'Güçsüzlük, çekicilik kaybı, ifade edememe',
      lightAspect: 'Otantik güç, içsel değer, özgür ifade',
    ),

    DreamSymbolData(
      symbol: 'naked',
      symbolTr: 'Çıplak Olmak',
      emoji: '😳',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Savunmasızlık ve kırılganlık',
        'Gerçek benliğin açığa çıkması',
        'Utanç ve ifşa',
        'Otantiklik',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'İfşa olma korkusu - gerçek sen kim?',
        EmotionalTone.sucluluk: 'Gizlenen bir şey - sırlar yoruyor',
        EmotionalTone.huzur: 'Kabul ve özgürlük - maskeleri attın',
        EmotionalTone.merak: 'Savunmasızlığın gücü - kırılganlık cesaret ister',
      },
      archetypes: ['Masum', 'Çıplak Gerçek', 'Kırılgan Benlik'],
      relatedSymbols: ['exposure', 'shame', 'truth', 'vulnerability'],
      shadowAspect: 'Utanç, yetersizlik, savunmasızlık',
      lightAspect: 'Otantiklik, kabullenme, özgürlük',
    ),

    DreamSymbolData(
      symbol: 'lost',
      symbolTr: 'Kaybolmak',
      emoji: '🧭',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Yön kaybı',
        'Kimlik krizi',
        'Yaşam yolunda belirsizlik',
        'Aidiyet arayışı',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Yolunu bulamama - hayatta nereye gidiyorsun?',
        EmotionalTone.merak: 'Keşif yolculuğu - kaybolmak bazen gerekli',
        EmotionalTone.ozlem: 'Eve dönüş arzusu - köklerini arıyorsun',
        EmotionalTone.donukluk: 'Pusula yok - yeni yön belirleme zamanı',
      },
      archetypes: ['Gezgin', 'Arayan', 'Kayıp Ruh'],
      relatedSymbols: ['path', 'map', 'home', 'direction'],
      shadowAspect: 'Yönsüzlük, anlamsızlık, terk edilmişlik',
      lightAspect: 'Keşif, yeni yollar, iç pusula',
    ),

    DreamSymbolData(
      symbol: 'driving',
      symbolTr: 'Araba Kullanmak',
      emoji: '🚗',
      category: SymbolCategory.eylem,
      universalMeanings: [
        'Hayat yolculuğu kontrolü',
        'Ego ve irade',
        'Hedeflere ilerleme',
        'Kişisel güç',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Kontroldesin - hayatını sen yönetiyorsun',
        EmotionalTone.korku: 'Fren tutmuyor: kontrol kaybı, çaresizlik',
        EmotionalTone.heyecan: 'Hız ve ilerleme - hedefe yaklaşıyorsun',
        EmotionalTone.donukluk: 'Arka koltukta: başkası mı yönetiyor?',
      },
      archetypes: ['Ego', 'Yolcu', 'Kontrol'],
      relatedSymbols: ['car', 'road', 'journey', 'control'],
      shadowAspect: 'Kontrolsüzlük, yanlış yön, kaza',
      lightAspect: 'Kişisel güç, doğru yön, başarılı ilerleme',
    ),

    // ═══════════════════════════════════════════════════════════
    // İNSANLAR - İlişkiler ve yansımalar
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'mother',
      symbolTr: 'Anne',
      emoji: '👩',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Şefkat ve koruma',
        'İç anne arketipi',
        'Besleme ve bakım',
        'Kökenler',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'İç anneyle barış - kendine şefkat göster',
        EmotionalTone.ozlem: 'Koşulsuz sevgi arzusu',
        EmotionalTone.ofke: 'Anne ile çözülmemiş meseleler',
        EmotionalTone.korku: 'Boğucu anne: bağımsızlık mücadelesi',
      },
      archetypes: ['Büyük Anne', 'Besleyici', 'Koruyucu'],
      relatedSymbols: ['home', 'nurture', 'origin', 'protection'],
      shadowAspect: 'Boğucu bakım, bağımlılık, aşırı koruma',
      lightAspect: 'Koşulsuz sevgi, beslenme, güvenlik',
    ),

    DreamSymbolData(
      symbol: 'father',
      symbolTr: 'Baba',
      emoji: '👨',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Otorite ve yapı',
        'Koruma ve rehberlik',
        'Disiplin',
        'Dış dünya',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'İç babayla barış - kendi otoriten ol',
        EmotionalTone.korku: 'Otorite korkusu veya onay arayışı',
        EmotionalTone.ofke: 'Çözülmemiş baba meseleleri',
        EmotionalTone.ozlem: 'Rehberlik ve koruma arzusu',
      },
      archetypes: ['Kral/Yaşlı Bilge', 'Otorite', 'Koruyucu'],
      relatedSymbols: ['authority', 'protection', 'structure', 'guidance'],
      shadowAspect: 'Tiran baba, yokluk, reddedilme',
      lightAspect: 'Bilge rehberlik, güçlü koruma, adil otorite',
    ),

    DreamSymbolData(
      symbol: 'child',
      symbolTr: 'Çocuk',
      emoji: '👶',
      category: SymbolCategory.insan,
      universalMeanings: [
        'İç çocuk',
        'Masumiyet ve potansiyel',
        'Yeni başlangıç',
        'Yaratıcılık',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'İç çocuğunla bağlantı - oyna ve yarat',
        EmotionalTone.korku: 'Kırılgan çocuk: iç çocuk tehlikede',
        EmotionalTone.ozlem: 'Kaybedilen masumiyet',
        EmotionalTone.heyecan: 'Yeni proje veya başlangıç - doğum',
      },
      archetypes: ['Puer/Puella', 'İç Çocuk', 'Yeni Başlangıç'],
      relatedSymbols: ['baby', 'birth', 'innocence', 'play'],
      shadowAspect: 'Yaralı iç çocuk, büyümeme, sorumsuzluk',
      lightAspect: 'Yaratıcılık, masumiyet, merak, potansiyel',
    ),

    DreamSymbolData(
      symbol: 'stranger',
      symbolTr: 'Yabancı',
      emoji: '👤',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Bilinmeyen benlik yönleri',
        'Gölge figürü',
        'Yeni olasılıklar',
        'Entegre edilmemiş parçalar',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Tanınmamış potansiyel - bu kim?',
        EmotionalTone.korku: 'Gölge figürü - bilinmeyen taraf',
        EmotionalTone.heyecan: 'Yeni bağlantı - entegrasyon fırsatı',
        EmotionalTone.donukluk: 'Yabancılaşmış benlik parçası',
      },
      archetypes: ['Gölge', 'Anima/Animus', 'Bilinmeyen'],
      relatedSymbols: ['shadow', 'unknown', 'self', 'other'],
      shadowAspect: 'Yabancılaşma, tehdit, bilinmeyen korku',
      lightAspect: 'Yeni yönler, potansiyel, entegrasyon',
    ),

    DreamSymbolData(
      symbol: 'ex-partner',
      symbolTr: 'Eski Sevgili',
      emoji: '💔',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Tamamlanmamış duygusal iş',
        'Bırakılmamış bağlar',
        'Geçmiş kalıplar',
        'Anima/Animus projeksiyonu',
      ],
      emotionVariants: {
        EmotionalTone.ozlem: 'Geçmiş bağ - bırakamadığın ne?',
        EmotionalTone.ofke: 'Çözülmemiş kırgınlık - affetme zamanı',
        EmotionalTone.huzur: 'Barış ve kapanış - ilerlemeye hazırsın',
        EmotionalTone.merak: 'Ne öğretiyordu sana?',
      },
      archetypes: ['Anima/Animus', 'Geçmiş', 'Ayna'],
      relatedSymbols: ['relationship', 'past', 'closure', 'lesson'],
      shadowAspect: 'Takıntı, bırakamama, geçmişte kalma',
      lightAspect: 'Dersler, büyüme, kapanış ve ilerleme',
    ),

    DreamSymbolData(
      symbol: 'deceased',
      symbolTr: 'Ölen Yakın',
      emoji: '👻',
      category: SymbolCategory.insan,
      universalMeanings: [
        'Atalarla bağlantı',
        'Tamamlanmamış vedalar',
        'İçselleştirilmiş figür',
        'Ruhsal mesaj',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Ruhsal bağlantı - mesaj alıyorsun',
        EmotionalTone.ozlem: 'Yas işlenmesi - özlem doğal',
        EmotionalTone.korku: 'Ölüm korkusu veya tamamlanmamış iş',
        EmotionalTone.heyecan: 'Rehberlik - yolunu aydınlatıyor',
      },
      archetypes: ['Ata Ruhu', 'Rehber', 'İçsel Figür'],
      relatedSymbols: ['death', 'ancestor', 'spirit', 'message'],
      shadowAspect: 'Çözülmemiş yas, suçluluk, korku',
      lightAspect: 'Spiritüel bağ, bilgelik, rehberlik',
    ),

    // ═══════════════════════════════════════════════════════════
    // DOĞA OLAYLARI - Kozmik güçler
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'fire',
      symbolTr: 'Ateş',
      emoji: '🔥',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Dönüşüm ve arınma',
        'Tutku ve öfke',
        'Yaratıcılık',
        'Yıkım ve yenilenme',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Kontrolsüz ateş: bastırılmış öfke, yıkıcı güç',
        EmotionalTone.heyecan: 'Tutku ateşi - yaratıcılık doruğunda',
        EmotionalTone.huzur: 'Sıcak alev: içsel ışık, şömine güvenliği',
        EmotionalTone.ofke: 'Öfke ateşi - sınırlar ihlal edildi',
      },
      archetypes: ['Dönüştürücü', 'Yaratıcı Güç', 'Prometheus'],
      relatedSymbols: ['destruction', 'passion', 'light', 'phoenix'],
      shadowAspect: 'Yıkıcı öfke, kontrolsüz tutku, yanık',
      lightAspect: 'Dönüşüm, arınma, yaratıcı ateş, illuminasyon',
    ),

    DreamSymbolData(
      symbol: 'earthquake',
      symbolTr: 'Deprem',
      emoji: '🌋',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Temellerin sarsılması',
        'Köklü değişim',
        'Güvenlik kaybı',
        'İç çatışma',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Güvenlik temelleri sarsılıyor - ne çöküyor?',
        EmotionalTone.donukluk: 'Şok - çok hızlı değişim',
        EmotionalTone.heyecan: 'Eski yapılar yıkılıyor - yeniden inşa zamanı',
        EmotionalTone.ofke: 'Bastırılmış güç patlıyor',
      },
      archetypes: ['Kaos', 'Dönüşüm', 'Temel'],
      relatedSymbols: ['ground', 'destruction', 'foundation', 'change'],
      shadowAspect: 'Çöküş, güvensizlik, kontrol kaybı',
      lightAspect: 'Köklü dönüşüm, yeni temeller, uyanış',
    ),

    DreamSymbolData(
      symbol: 'storm',
      symbolTr: 'Fırtına',
      emoji: '⛈️',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Duygusal çalkantı',
        'Arınma ve temizlik',
        'Güçlü değişim',
        'İç çatışma',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Yaklaşan kriz - hazırlan',
        EmotionalTone.heyecan: 'Temizleyici fırtına - eski gidecek',
        EmotionalTone.huzur: 'Fırtına sonrası - sakinlik geliyor',
        EmotionalTone.ofke: 'İçsel fırtına - duygular patlak veriyor',
      },
      archetypes: ['Kaos', 'Arınma', 'Değişim'],
      relatedSymbols: ['rain', 'wind', 'lightning', 'calm'],
      shadowAspect: 'Kaos, yıkım, kontrolsüz duygular',
      lightAspect: 'Arınma, yenilenme, fırtına sonrası berraklık',
    ),

    DreamSymbolData(
      symbol: 'moon',
      symbolTr: 'Ay',
      emoji: '🌙',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Bilinçdışı ve sezgi',
        'Feminen enerji',
        'Döngüler ve ritmler',
        'Gizem ve illüzyon',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Sezgisel bilgelik - içine dön',
        EmotionalTone.merak: 'Gizem çözülüyor - ay ışığında görülen',
        EmotionalTone.korku: 'Karanlık ay: gölge feminen, illüzyonlar',
        EmotionalTone.ozlem: 'Kadim bağlantı - ritmini bul',
      },
      archetypes: ['Feminen', 'Bilinçdışı', 'Döngüsel'],
      relatedSymbols: ['night', 'tide', 'intuition', 'cycle'],
      shadowAspect: 'İllüzyon, yanılsama, istikrarsızlık',
      lightAspect: 'Sezgi, döngüsel bilgelik, feminen güç',
    ),

    DreamSymbolData(
      symbol: 'sun',
      symbolTr: 'Güneş',
      emoji: '☀️',
      category: SymbolCategory.dogaOlayi,
      universalMeanings: [
        'Bilinç ve farkındalık',
        'Maskülen enerji',
        'Yaşam gücü',
        'Aydınlanma',
      ],
      emotionVariants: {
        EmotionalTone.huzur: 'Aydınlanma - gerçek görünüyor',
        EmotionalTone.heyecan: 'Enerji ve canlılık doruğunda',
        EmotionalTone.korku: 'Kavurucu güneş: aşırı maruz kalma, yanık',
        EmotionalTone.merak: 'Işık arıyorsun - yol aydınlanıyor',
      },
      archetypes: ['Maskülen', 'Kahraman', 'Bilinç'],
      relatedSymbols: ['light', 'day', 'gold', 'fire'],
      shadowAspect: 'Aşırı parlaklık, körlük, yakıcı ego',
      lightAspect: 'Aydınlanma, canlılık, bilinç ışığı',
    ),

    // ═══════════════════════════════════════════════════════════
    // NESNELER - Araçlar ve semboller
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'door',
      symbolTr: 'Kapı',
      emoji: '🚪',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Yeni fırsatlar',
        'Geçiş ve değişim',
        'Giriş ve çıkış',
        'Seçim',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Yeni kapı açılıyor - fırsat!',
        EmotionalTone.korku: 'Kapalı kapı: engellenmiş fırsat',
        EmotionalTone.merak: 'Kapının ardında ne var?',
        EmotionalTone.ozlem: 'Geçmiş kapısı - geri dönüş arzusu',
      },
      archetypes: ['Geçiş', 'Eşik', 'Seçim'],
      relatedSymbols: ['threshold', 'key', 'opportunity', 'choice'],
      shadowAspect: 'Kapalı kapılar, engellenme, tıkanıklık',
      lightAspect: 'Yeni başlangıçlar, fırsatlar, geçişler',
    ),

    DreamSymbolData(
      symbol: 'key',
      symbolTr: 'Anahtar',
      emoji: '🔑',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Çözüm ve erişim',
        'Gizli bilgi',
        'Güç ve kontrol',
        'Sırların açılması',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Çözümü buldun - kapı açılıyor',
        EmotionalTone.merak: 'Neyi açıyor bu anahtar?',
        EmotionalTone.korku: 'Kayıp anahtar: çözümsüzlük',
        EmotionalTone.huzur: 'Doğru anahtar - erişim sağlandı',
      },
      archetypes: ['Bilge', 'Bekçi', 'Çözüm'],
      relatedSymbols: ['door', 'lock', 'secret', 'access'],
      shadowAspect: 'Kayıp çözümler, kilitli sırlar',
      lightAspect: 'Bilgelik, erişim, çözüm bulma',
    ),

    DreamSymbolData(
      symbol: 'mirror',
      symbolTr: 'Ayna',
      emoji: '🪞',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Öz-farkındalık',
        'Gerçek benlik',
        'Yansıma ve projeksiyon',
        'İç gözlem',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Kim bakıyor sana? Gerçek sen mi?',
        EmotionalTone.korku: 'Tanımadığın yansıma - gölge yüzleşmesi',
        EmotionalTone.huzur: 'Kabul - kendini görüyorsun',
        EmotionalTone.sucluluk: 'Aynadan kaçma - kendine bak',
      },
      archetypes: ['Gerçek Benlik', 'Gölge', 'Farkındalık'],
      relatedSymbols: ['reflection', 'self', 'truth', 'image'],
      shadowAspect: 'Çarpık imaj, kendinden kaçma, illüzyon',
      lightAspect: 'Öz-farkındalık, dürüstlük, içsel gerçek',
    ),

    DreamSymbolData(
      symbol: 'phone',
      symbolTr: 'Telefon',
      emoji: '📱',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'İletişim ve bağlantı',
        'Mesaj alma/verme',
        'Uzaktakilerle bağ',
        'Haber beklentisi',
      ],
      emotionVariants: {
        EmotionalTone.merak: 'Kim arıyor? Bilinçaltından mesaj',
        EmotionalTone.korku:
            'Cevapsız çağrılar: kaçırılan fırsatlar, bağlantı kaybı',
        EmotionalTone.heyecan: 'Beklenen haber geliyor',
        EmotionalTone.ozlem: 'Uzaktaki biriyle bağlantı arzusu',
      },
      archetypes: ['Haberci', 'Bağlantı', 'İletişim'],
      relatedSymbols: ['message', 'communication', 'connection', 'news'],
      shadowAspect: 'İletişim kopukluğu, cevapsızlık, yalnızlık',
      lightAspect: 'Bağlantı, iletişim, senkronisite',
    ),

    DreamSymbolData(
      symbol: 'money',
      symbolTr: 'Para',
      emoji: '💰',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Değer ve öz-değer',
        'Güç ve kaynaklar',
        'Enerji değişimi',
        'Güvenlik',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Bolluk geliyor - değerini bil',
        EmotionalTone.korku: 'Kayıp para: öz-değer krizi, güvensizlik',
        EmotionalTone.sucluluk: 'Hak etmeme hissi',
        EmotionalTone.huzur: 'Maddi güvenlik - yeterlilik',
      },
      archetypes: ['Değer', 'Güç', 'Kaynak'],
      relatedSymbols: ['wealth', 'value', 'power', 'security'],
      shadowAspect: 'Açgözlülük, yetersizlik, değersizlik',
      lightAspect: 'Öz-değer, bolluk, kaynak zenginliği',
    ),

    DreamSymbolData(
      symbol: 'wedding',
      symbolTr: 'Düğün',
      emoji: '💒',
      category: SymbolCategory.nesne,
      universalMeanings: [
        'Birleşme ve bütünleşme',
        'Taahhüt ve bağlanma',
        'İç evlilik - anima/animus',
        'Yeni başlangıç',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'İçsel birleşme - bütünleşme zamanı',
        EmotionalTone.korku: 'Bağlanma korkusu veya yanlış seçim',
        EmotionalTone.huzur: 'Doğru birlik - uyum',
        EmotionalTone.sucluluk: 'Tamamlanmamış taahhütler',
      },
      archetypes: ['Kutsal Evlilik', 'Birlik', 'Anima/Animus'],
      relatedSymbols: ['marriage', 'union', 'commitment', 'integration'],
      shadowAspect: 'Kaybedilen özgürlük, yanlış birlik',
      lightAspect: 'Bütünleşme, kutsal birlik, olgunlaşma',
    ),

    // ═══════════════════════════════════════════════════════════
    // SOYUT DURUMLAR
    // ═══════════════════════════════════════════════════════════
    DreamSymbolData(
      symbol: 'death',
      symbolTr: 'Ölüm',
      emoji: '💀',
      category: SymbolCategory.soyut,
      universalMeanings: [
        'Dönüşüm ve son',
        'Eski benliğin ölümü',
        'Yeniden doğuş',
        'Köklü değişim',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Değişim korkusu - neyin ölmesi gerekiyor?',
        EmotionalTone.huzur: 'Barışçıl geçiş - eski gidiyor, yeni geliyor',
        EmotionalTone.sucluluk: 'Tamamlanmamış vedalar',
        EmotionalTone.donukluk: 'Kabul - döngünün parçası',
      },
      archetypes: ['Dönüşüm', 'Son/Başlangıç', 'Yeniden Doğuş'],
      relatedSymbols: ['rebirth', 'transformation', 'end', 'beginning'],
      shadowAspect: 'Ölüm korkusu, kayıp, yok olma',
      lightAspect: 'Dönüşüm, yenilenme, ölümsüz ruh',
    ),

    DreamSymbolData(
      symbol: 'pregnancy',
      symbolTr: 'Hamilelik',
      emoji: '🤰',
      category: SymbolCategory.soyut,
      universalMeanings: [
        'Yaratıcı potansiyel',
        'Yeni proje veya fikir',
        'Büyüme ve gelişim',
        'Beklenti',
      ],
      emotionVariants: {
        EmotionalTone.heyecan: 'Yeni bir şey doğuyor - yaratıcı hamilelik',
        EmotionalTone.korku: 'Hazır değilim - sorumluluk korkusu',
        EmotionalTone.merak: 'Ne doğacak? Potansiyel gelişiyor',
        EmotionalTone.huzur: 'Doğal süreç - zamanı bekle',
      },
      archetypes: ['Yaratıcı', 'Anne', 'Potansiyel'],
      relatedSymbols: ['birth', 'creation', 'growth', 'potential'],
      shadowAspect: 'İstenmeyen sorumluluk, korku, hazırlıksızlık',
      lightAspect: 'Yaratıcılık, yeni başlangıç, büyüme',
    ),

    DreamSymbolData(
      symbol: 'exam',
      symbolTr: 'Sınav',
      emoji: '📝',
      category: SymbolCategory.soyut,
      universalMeanings: [
        'Değerlendirme korkusu',
        'Performans kaygısı',
        'Hayat testi',
        'Hazırlık durumu',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'Yetersizlik korkusu - kendini değerlendiriyorsun',
        EmotionalTone.sucluluk: 'Hazırlıksız - ertelemenin bedeli',
        EmotionalTone.heyecan: 'Test zamanı - kendini kanıtla',
        EmotionalTone.huzur: 'Hazırsın - güven kendine',
      },
      archetypes: ['Yargıç', 'Sınav', 'Değerlendirici'],
      relatedSymbols: ['school', 'test', 'performance', 'judgment'],
      shadowAspect: 'Başarısızlık korkusu, mükemmeliyetçilik',
      lightAspect: 'Hazırlıklılık, yeterlilik, geçiş',
    ),

    DreamSymbolData(
      symbol: 'war',
      symbolTr: 'Savaş',
      emoji: '⚔️',
      category: SymbolCategory.soyut,
      universalMeanings: [
        'İç çatışma',
        'Karşıt güçler',
        'Mücadele ve rekabet',
        'Ego savaşları',
      ],
      emotionVariants: {
        EmotionalTone.korku: 'İç savaş - parçalanmış benlik',
        EmotionalTone.ofke: 'Savaşılması gereken bir şey',
        EmotionalTone.donukluk: 'Savaş yorgunluğu - barış zamanı',
        EmotionalTone.heyecan: 'Mücadele ruhu - kazan',
      },
      archetypes: ['Savaşçı', 'Çatışma', 'Dönüşüm'],
      relatedSymbols: ['conflict', 'battle', 'enemy', 'victory'],
      shadowAspect: 'Yıkıcı çatışma, düşmanlık, bölünme',
      lightAspect: 'Cesaret, mücadele, dönüştürücü çatışma',
    ),
  ];

  /// Sembol arama (Türkçe veya İngilizce)
  static DreamSymbolData? findSymbol(String query) {
    final lowerQuery = query.toLowerCase().trim();
    return allSymbols.cast<DreamSymbolData?>().firstWhere(
      (s) =>
          s!.symbol.toLowerCase() == lowerQuery ||
          s.symbolTr.toLowerCase() == lowerQuery,
      orElse: () => null,
    );
  }

  /// Kategoriye göre sembolleri getir
  static List<DreamSymbolData> getByCategory(SymbolCategory category) {
    return allSymbols.where((s) => s.category == category).toList();
  }

  /// En yaygın sembolleri getir (UI'da göstermek için)
  static List<DreamSymbolData> get commonSymbols => [
    findSymbol('water')!,
    findSymbol('snake')!,
    findSymbol('flying')!,
    findSymbol('falling')!,
    findSymbol('teeth-falling')!,
    findSymbol('house')!,
    findSymbol('chasing')!,
    findSymbol('death')!,
    findSymbol('naked')!,
    findSymbol('lost')!,
  ];

  /// Rüya metninden sembolleri tespit et
  static List<DreamSymbolData> detectSymbolsInText(String dreamText) {
    final text = dreamText.toLowerCase();
    final detected = <DreamSymbolData>[];

    // Türkçe keyword patterns
    final patterns = <String, List<String>>{
      'water': ['su ', 'suda', 'suya', 'suyu'],
      'ocean': ['deniz', 'okyanus'],
      'rain': ['yağmur', 'yağıyor'],
      'flood': ['sel', 'taşkın'],
      'snake': ['yılan', 'yilan', 'kobra'],
      'dog': ['köpek', 'it '],
      'cat': ['kedi'],
      'bird': ['kuş', 'kus'],
      'fish': ['balık', 'balik'],
      'spider': ['örümcek', 'orumcek'],
      'horse': ['at ', 'ata ', 'atı'],
      'wolf': ['kurt'],
      'house': ['ev ', 'evde', 'evim', 'oda'],
      'room': ['odada', 'odası'],
      'basement': ['bodrum', 'mahzen'],
      'attic': ['çatı', 'tavan arası'],
      'forest': ['orman', 'ağaçlar'],
      'school': ['okul', 'sınıf', 'ders'],
      'hospital': ['hastane', 'doktor'],
      'flying': ['uçuyordum', 'uçtum', 'uçmak', 'havada'],
      'falling': ['düştüm', 'düşüyordum', 'düşmek'],
      'chasing': ['kovalıyordu', 'kovalandım', 'kaçıyordum'],
      'teeth-falling': ['dişlerim', 'diş döküldü', 'dişler'],
      'naked': ['çıplak', 'üstüm açık'],
      'lost': ['kayboldum', 'yolumu bulamadım'],
      'driving': ['araba', 'sürüyordum', 'araç'],
      'mother': ['annem', 'anne'],
      'father': ['babam', 'baba'],
      'child': ['çocuk', 'bebek'],
      'stranger': ['tanımadığım biri', 'yabancı'],
      'ex-partner': ['eski sevgilim', 'manita', 'ex'],
      'deceased': ['ölen', 'vefat', 'rahmetli'],
      'fire': ['ateş', 'yangın', 'alev'],
      'earthquake': ['deprem', 'sarsıntı'],
      'storm': ['fırtına', 'kasırga'],
      'moon': ['ay ', 'dolunay', 'gece'],
      'sun': ['güneş', 'gündüz'],
      'door': ['kapı'],
      'key': ['anahtar'],
      'mirror': ['ayna'],
      'phone': ['telefon', 'çaldı'],
      'money': ['para', 'cüzdan'],
      'wedding': ['düğün', 'evlilik', 'nikah'],
      'death': ['ölüm', 'öldüm', 'öldü', 'cenaze'],
      'pregnancy': ['hamile', 'gebe', 'doğum'],
      'exam': ['sınav', 'test', 'imtihan'],
      'war': ['savaş', 'kavga', 'dövüş'],
    };

    for (final entry in patterns.entries) {
      for (final keyword in entry.value) {
        if (text.contains(keyword)) {
          final symbol = findSymbol(entry.key);
          if (symbol != null && !detected.contains(symbol)) {
            detected.add(symbol);
          }
          break;
        }
      }
    }

    return detected;
  }
}

// ════════════════════════════════════════════════════════════════
// ARKETİP VERİTABANI
// ════════════════════════════════════════════════════════════════

/// Jungian arketip verileri
class ArchetypeData {
  final String name;
  final String nameTr;
  final String emoji;
  final String description;
  final List<String> manifestations;
  final String lightSide;
  final String shadowSide;
  final String integrationPath;

  const ArchetypeData({
    required this.name,
    required this.nameTr,
    required this.emoji,
    required this.description,
    required this.manifestations,
    required this.lightSide,
    required this.shadowSide,
    required this.integrationPath,
  });
}

class ArchetypeDatabase {
  static const List<ArchetypeData> allArchetypes = [
    ArchetypeData(
      name: 'Shadow',
      nameTr: 'Gölge',
      emoji: '🌑',
      description:
          'Bastırılmış, reddedilmiş benlik yönleri. Kabul etmediğimiz her şey gölgemize düşer.',
      manifestations: [
        'Rüyada düşman veya tehdit',
        'Kovalayan korkunç figür',
        'Karanlık kişi veya yaratık',
        'Tanımadığımız ama rahatsız eden figür',
      ],
      lightSide: 'Entegre edildiğinde büyük güç ve bütünlük kaynağı',
      shadowSide:
          'Bastırıldığında projeksiyonlar, öfke patlamaları, self-sabotaj',
      integrationPath:
          'Gölgeyle yüzleşmek, bastırılan yönleri tanımak ve kabul etmek',
    ),
    ArchetypeData(
      name: 'Anima',
      nameTr: 'Anima',
      emoji: '🌸',
      description:
          'Erkeklerdeki içsel feminen prensip. Sezgi, duygu ve ilişki kapasitesi.',
      manifestations: [
        'Gizemli kadın figürü',
        'İlham perisi',
        'Büyücü kadın',
        'Tanrıça',
      ],
      lightSide: 'Yaratıcılık, sezgi, duygusal derinlik, ilham',
      shadowSide: 'Ruh hali dalgalanmaları, kapris, manipülasyon',
      integrationPath: 'Feminen yönleri tanımak, duygusal zekayı geliştirmek',
    ),
    ArchetypeData(
      name: 'Animus',
      nameTr: 'Animus',
      emoji: '⚔️',
      description:
          'Kadınlardaki içsel maskülen prensip. Mantık, irade ve eylem kapasitesi.',
      manifestations: [
        'Güçlü erkek figürü',
        'Bilge adam',
        'Kahraman',
        'Rehber',
      ],
      lightSide: 'Kararlılık, mantık, odaklanma, koruma',
      shadowSide: 'Katılık, zorbalık, duygusal soğukluk',
      integrationPath:
          'Maskülen gücü dengeli kullanmak, mantık ve sezgiyi birleştirmek',
    ),
    ArchetypeData(
      name: 'Persona',
      nameTr: 'Persona',
      emoji: '🎭',
      description:
          'Sosyal maske, dünyaya gösterdiğimiz yüz. Uyum sağlamak için geliştirilen kimlik.',
      manifestations: [
        'Maske takmak',
        'Kıyafet değiştirmek',
        'Başka biri olmak',
        'Sahne performansı',
      ],
      lightSide: 'Sosyal uyum, profesyonellik, esneklik',
      shadowSide: 'Sahte benlik, maskenin ardında kaybolma',
      integrationPath:
          'Maskeyi tanımak ama onunla özdeşleşmemek, otantik kalmak',
    ),
    ArchetypeData(
      name: 'Self',
      nameTr: 'Benlik',
      emoji: '☯️',
      description:
          'Bütünleşmiş psişe, bireyselleşme hedefi. Tüm karşıtların birliği.',
      manifestations: [
        'Mandala',
        'Bilge yaşlı figür',
        'Işık kaynağı',
        'Merkezdeki hazine',
        'Kutsal mekan',
      ],
      lightSide: 'Bütünlük, anlam, amaç, iç huzur',
      shadowSide: 'Ego şişmesi, tanrı kompleksi (sağlıksız özdeşleşme)',
      integrationPath: 'Bireyselleşme yolculuğu, tüm yönlerin dengelenmesi',
    ),
    ArchetypeData(
      name: 'Hero',
      nameTr: 'Kahraman',
      emoji: '🦸',
      description:
          'Zorlukları aşan, engelleri yenen güç. Ego\'nun gelişim potansiyeli.',
      manifestations: [
        'Ejderhayı öldürmek',
        'Canavarı yenmek',
        'Hazine bulmak',
        'Birini kurtarmak',
      ],
      lightSide: 'Cesaret, kararlılık, fedakarlık, başarı',
      shadowSide: 'Kibir, saldırganlık, tükenmişlik',
      integrationPath: 'Cesaret ve alçakgönüllülüğü dengelemek',
    ),
    ArchetypeData(
      name: 'Wise Old Man',
      nameTr: 'Bilge Yaşlı',
      emoji: '🧙',
      description:
          'İçsel bilgelik ve rehberlik figürü. Bilinçdışının rehberlik kapasitesi.',
      manifestations: [
        'Yaşlı bilge',
        'Öğretmen',
        'Büyücü',
        'Mentor',
        'Ata figürü',
      ],
      lightSide: 'Bilgelik, rehberlik, içgörü, sabır',
      shadowSide: 'Dogmatizm, manipülasyon, pasiflik',
      integrationPath: 'İçsel bilgeliğe güvenmek, deneyimden öğrenmek',
    ),
    ArchetypeData(
      name: 'Great Mother',
      nameTr: 'Büyük Anne',
      emoji: '🌍',
      description: 'Evrensel anne figürü. Besleyen ama aynı zamanda yutan güç.',
      manifestations: ['Toprak Ana', 'Doğa', 'Deniz', 'Mağara', 'Ev'],
      lightSide: 'Koşulsuz sevgi, beslenme, yaratıcılık, bereket',
      shadowSide: 'Boğuculuk, yutma, bağımlılık yaratma',
      integrationPath:
          'Beslenme ve bağımsızlığı dengelemek, kendi kendine yeterlik',
    ),
    ArchetypeData(
      name: 'Trickster',
      nameTr: 'Düzenbaz',
      emoji: '🃏',
      description:
          'Kuralları bozan, kaosla oynayan enerji. Değişim ve dönüşüm katalizörü.',
      manifestations: [
        'Soytarı',
        'Tilki',
        'Şakacı figür',
        'Beklenmedik olaylar',
      ],
      lightSide: 'Yaratıcılık, esneklik, kalıp kırma, mizah',
      shadowSide: 'Aldatma, sorumsuzluk, kaos',
      integrationPath: 'Oyunculuğu kabul etmek, esnekliği sorumlu kullanmak',
    ),
    ArchetypeData(
      name: 'Child',
      nameTr: 'Çocuk',
      emoji: '👶',
      description:
          'Masumiyet, potansiyel ve yenilik. Her şeyin mümkün olduğu başlangıç noktası.',
      manifestations: ['Bebek', 'Küçük çocuk', 'Yeni doğan', 'Oyun'],
      lightSide: 'Masumiyet, merak, spontanlık, yaratıcılık',
      shadowSide: 'Çocuksuluuk, sorumsuzluk, bağımlılık',
      integrationPath:
          'İç çocukla bağlantı kurmak, merakı korumak, olgunlaşmak',
    ),
  ];

  /// Arketip bul
  static ArchetypeData? findArchetype(String name) {
    final lowerName = name.toLowerCase();
    return allArchetypes.cast<ArchetypeData?>().firstWhere(
      (a) =>
          a!.name.toLowerCase() == lowerName ||
          a.nameTr.toLowerCase() == lowerName,
      orElse: () => null,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// VİRAL KART ŞABLONLARİ
// ════════════════════════════════════════════════════════════════

class ShareableQuoteTemplates {
  static const List<ShareableCard> quotes = [
    // Dönüşüm
    ShareableCard(
      emoji: '🦋',
      quote: 'Tırtıl uçamayacağını sanırken, kelebek oluyordu.',
      category: 'Dönüşüm',
    ),
    ShareableCard(
      emoji: '🌊',
      quote: 'Dalgalar bitmez, ama yüzmeyi öğrenirsin.',
      category: 'Dayanıklılık',
    ),
    ShareableCard(
      emoji: '🌙',
      quote: 'En karanlık gece bile sabahı doğurur.',
      category: 'Umut',
    ),
    ShareableCard(
      emoji: '🔥',
      quote: 'Küllerinden yükselen, ateşten korkmaz.',
      category: 'Yenilenme',
    ),
    ShareableCard(
      emoji: '🪞',
      quote: 'Ayna gerçeği gösterir, cesaretli olan bakar.',
      category: 'Farkındalık',
    ),

    // Bilgelik
    ShareableCard(
      emoji: '🦉',
      quote: 'Bilgelik acıdan doğar, sessizlikte büyür.',
      category: 'Bilgelik',
    ),
    ShareableCard(
      emoji: '🌳',
      quote: 'Kökleri derin olan, fırtınada eğilir ama kırılmaz.',
      category: 'Dayanıklılık',
    ),
    ShareableCard(
      emoji: '⭐',
      quote: 'Karanlık olmasa yıldızlar görünmezdi.',
      category: 'Perspektif',
    ),
    ShareableCard(
      emoji: '🗝️',
      quote: 'Aradığın anahtar, kaçtığın kapının ardında.',
      category: 'Yüzleşme',
    ),
    ShareableCard(
      emoji: '🌹',
      quote: 'Dikenler arasında açan gül, en güzel kokar.',
      category: 'Güzellik',
    ),

    // Gölge
    ShareableCard(
      emoji: '🌑',
      quote: 'Gölgenden kaçamazsın, ama onunla dans edebilirsin.',
      category: 'Gölge',
    ),
    ShareableCard(
      emoji: '🐍',
      quote: 'Yılan deri değiştirir, sen neden değiştirmeyesin?',
      category: 'Dönüşüm',
    ),
    ShareableCard(
      emoji: '🌊',
      quote: 'Bilinçaltı okyanus, ego yalnızca dalga.',
      category: 'Derinlik',
    ),
    ShareableCard(
      emoji: '💎',
      quote: 'En değerli taşlar, en derin madenlerde bulunur.',
      category: 'Keşif',
    ),
    ShareableCard(
      emoji: '🦅',
      quote: 'Yükselmek için önce düşmeyi öğren.',
      category: 'Yükseliş',
    ),

    // Aşk & İlişki
    ShareableCard(
      emoji: '💫',
      quote: 'Evrenin sana söylediği, rüyalarında fısıldanır.',
      category: 'Sezgi',
    ),
    ShareableCard(
      emoji: '🕯️',
      quote: 'İçindeki ışığı keşfet, dışarıda aramayı bırak.',
      category: 'İçsel Güç',
    ),
    ShareableCard(
      emoji: '🌸',
      quote: 'Her bitiş, açılmayı bekleyen bir tomurcuk.',
      category: 'Yeni Başlangıç',
    ),
    ShareableCard(
      emoji: '🔮',
      quote: 'Gelecek belirsiz, ama sen hazırsın.',
      category: 'Hazırlık',
    ),
    ShareableCard(
      emoji: '🏔️',
      quote: 'Zirveye varan, vadiden geçmeyi bilir.',
      category: 'Yolculuk',
    ),

    // Cesaret
    ShareableCard(
      emoji: '🦁',
      quote: 'Korkularına doğru yürü, onlar küçülecek.',
      category: 'Cesaret',
    ),
    ShareableCard(
      emoji: '⚡',
      quote: 'Fırtına geçici, senin gücün kalıcı.',
      category: 'Dayanıklılık',
    ),
    ShareableCard(
      emoji: '🌈',
      quote: 'Yağmurun ardından gökkuşağı, ağlamanın ardından anlam.',
      category: 'Umut',
    ),
    ShareableCard(
      emoji: '🧭',
      quote: 'Kaybolmak bazen yolu bulmanın başlangıcıdır.',
      category: 'Keşif',
    ),
    ShareableCard(
      emoji: '🎭',
      quote: 'Maskeleri çıkar, altındaki sen daha güçlü.',
      category: 'Otantiklik',
    ),

    // Döngüler
    ShareableCard(
      emoji: '🌓',
      quote: 'Ay gibi ol: dolu da güzel, hilal de.',
      category: 'Kabul',
    ),
    ShareableCard(
      emoji: '🍂',
      quote: 'Dökülen yaprak, toprağı besler.',
      category: 'Bırakma',
    ),
    ShareableCard(
      emoji: '🌱',
      quote: 'Tohum karanlıkta çatlar, ışığa uzanır.',
      category: 'Büyüme',
    ),
    ShareableCard(
      emoji: '🌀',
      quote: 'Spiral yükselir: aynı yere farklı gözlerle dönersin.',
      category: 'Evrim',
    ),
    ShareableCard(
      emoji: '⏳',
      quote: 'Zamanın sana söylediği, sabırla dinle.',
      category: 'Sabır',
    ),

    // Spiritüel
    ShareableCard(
      emoji: '✨',
      quote: 'Sen yıldız tozundan yapılmışsın, parlamanı engelleme.',
      category: 'Özdeğer',
    ),
    ShareableCard(
      emoji: '🙏',
      quote: 'Evrene güven, o seni hiç yarı yolda bırakmadı.',
      category: 'Güven',
    ),
    ShareableCard(
      emoji: '💫',
      quote: 'Rüyaların evrenin seninle konuşma şekli.',
      category: 'Bağlantı',
    ),
    ShareableCard(
      emoji: '🌟',
      quote: 'İçindeki ışık, bin güneş gücünde.',
      category: 'İçsel Güç',
    ),
    ShareableCard(
      emoji: '🕊️',
      quote: 'Özgürlük içeride başlar, dışarıda devam eder.',
      category: 'Özgürlük',
    ),

    // Uyarılar
    ShareableCard(
      emoji: '⚠️',
      quote: 'Bilinçaltının uyarısı: Dikkat et, mesaj geliyor.',
      category: 'Uyarı',
    ),
    ShareableCard(
      emoji: '🚪',
      quote: 'Bir kapı kapandığında, üç kapı açılır.',
      category: 'Fırsat',
    ),
    ShareableCard(
      emoji: '🎯',
      quote: 'Hedefini bilmeyen, her rüzgara kapılır.',
      category: 'Odak',
    ),
    ShareableCard(
      emoji: '💪',
      quote: 'Zayıflığını kabul eden, güçlenir.',
      category: 'Kabullenme',
    ),
    ShareableCard(
      emoji: '🔄',
      quote: 'Tekrar eden rüya, öğrenilmemiş derstir.',
      category: 'Döngü',
    ),

    // Astrololojik
    ShareableCard(
      emoji: '♄',
      quote: 'Satürn sıkıştırır, ama elmas yaratır.',
      category: 'Astroloji',
    ),
    ShareableCard(
      emoji: '♆',
      quote: 'Neptün sisinde gerçek, sezgiyle bulunur.',
      category: 'Astroloji',
    ),
    ShareableCard(
      emoji: '♇',
      quote: 'Plüton yıkar, ama yeniden doğurur.',
      category: 'Astroloji',
    ),
    ShareableCard(
      emoji: '☿',
      quote: 'Retro mesaj: Geçmişe bak, geleceği gör.',
      category: 'Astroloji',
    ),
    ShareableCard(
      emoji: '🌕',
      quote: 'Dolunay aydınlatır: Gör ve bırak.',
      category: 'Astroloji',
    ),
  ];

  /// Rastgele bir alıntı seç
  static ShareableCard getRandomQuote() {
    return quotes[(DateTime.now().millisecondsSinceEpoch % quotes.length)];
  }

  /// Kategoriye göre alıntıları getir
  static List<ShareableCard> getByCategory(String category) {
    return quotes.where((q) => q.category == category).toList();
  }

  /// Duygusal tona uygun alıntı seç
  static ShareableCard getQuoteForEmotion(EmotionalTone tone) {
    switch (tone) {
      case EmotionalTone.korku:
        return quotes.firstWhere((q) => q.category == 'Cesaret');
      case EmotionalTone.huzur:
        return quotes.firstWhere((q) => q.category == 'Kabul');
      case EmotionalTone.merak:
        return quotes.firstWhere((q) => q.category == 'Keşif');
      case EmotionalTone.sucluluk:
        return quotes.firstWhere((q) => q.category == 'Kabullenme');
      case EmotionalTone.ozlem:
        return quotes.firstWhere((q) => q.category == 'Umut');
      case EmotionalTone.heyecan:
        return quotes.firstWhere((q) => q.category == 'Yeni Başlangıç');
      case EmotionalTone.donukluk:
        return quotes.firstWhere((q) => q.category == 'Farkındalık');
      case EmotionalTone.ofke:
        return quotes.firstWhere((q) => q.category == 'Dönüşüm');
    }
  }
}
