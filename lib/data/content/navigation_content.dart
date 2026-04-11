/// Navigation Content Library for Venus One
/// Back-Button-Free, Engagement-First Navigation System
/// Every page ends with 4 mandatory exploration sections
library;

// ============================================================
// NAVIGATION SECTION MODELS
// ============================================================

class NavigationCard {
  final String title;
  final String description;
  final String route;
  final String? emoji;

  const NavigationCard({
    required this.title,
    required this.description,
    required this.route,
    this.emoji,
  });
}

class PageNavigation {
  final String pageRoute;
  final String pageType;
  final List<NavigationCard> alsoViewed; // "Bunu Okuyanlar Şuna da Baktı"
  final List<NavigationCard> goDeeper; // "Bir Adım Daha Derinleş"
  final List<NavigationCard> keepExploring; // "Keşfetmeye Devam Et"
  final List<NavigationCard> continueWithoutBack; // "Geri Dönmeden Devam Et"

  const PageNavigation({
    required this.pageRoute,
    required this.pageType,
    required this.alsoViewed,
    required this.goDeeper,
    required this.keepExploring,
    required this.continueWithoutBack,
  });
}

// ============================================================
// SECTION TITLES (GLOBAL)
// ============================================================

class NavigationSectionTitles {
  static const String alsoViewed = 'Bunu Okuyanlar Şuna da Baktı';
  static const String goDeeper = 'Bir Adım Daha Derinleş';
  static const String keepExploring = 'Keşfetmeye Devam Et';
  static const String continueWithoutBack = 'Geri Dönmeden Devam Et';
}

// ============================================================
// PAGE 1: HOMEPAGE (/)
// ============================================================

class HomepageNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/',
    pageType: 'homepage',
    alsoViewed: [
      NavigationCard(
        title: 'Bugünün Kozmik Enerjisi',
        description:
            'Gökyüzü bugün ne fısıldıyor? Günlük burç yorumlarına göz at.',
        route: '/horoscope',
        emoji: '🌟',
      ),
      NavigationCard(
        title: 'Doğum Haritam Ne Söylüyor?',
        description: 'Kozmik parmak izini keşfet — ücretsiz hesapla.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Partnerimle Uyumlu muyuz?',
        description: 'İki haritanın dansını gör.',
        route: '/compatibility',
        emoji: '💑',
      ),
      NavigationCard(
        title: 'Şu Anki Transitler',
        description: 'Gökyüzündeki hareketler seni nasıl etkiliyor?',
        route: '/transits',
        emoji: '🪐',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Rüyanı Anlat, Birlikte Keşfedelim',
        description: 'Bu gece ne gördün? Sembolik bir yolculuğa çıkalım.',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Kozmik Rehberlik Al',
        description: 'İçindeki soruyu sor, yıldızlar yanıt versin.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Tarot ile İçgörü',
        description: 'Bilinçaltının aynasına bak — günlük kart çek.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: 'Sayılarının Sırrı',
        description: 'Doğum tarihin ve ismin ne anlatıyor?',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Enerji Alanın',
        description: 'Auranın renkleri ve chakra dengen.',
        route: '/aura',
        emoji: '🌈',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Kozmoz Keşif',
        description: 'Tüm özellikler tek yerde',
        route: '/kozmoz',
        emoji: '✨',
      ),
      NavigationCard(
        title: 'Astroloji Sözlüğü',
        description: 'Terimleri öğren',
        route: '/glossary',
        emoji: '📖',
      ),
      NavigationCard(
        title: 'Premium Özellikler',
        description: 'Gelişmiş astroloji araçları',
        route: '/premium',
        emoji: '👑',
      ),
    ],
  );
}

// ============================================================
// PAGE 2: HOROSCOPE HUB (/horoscope)
// ============================================================

class HoroscopeHubNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/horoscope',
    pageType: 'hub',
    alsoViewed: [
      NavigationCard(
        title: 'En Çok Okunan: Akrep',
        description: 'Gizemli sular bugün ne diyor?',
        route: '/horoscope/scorpio',
        emoji: '♏',
      ),
      NavigationCard(
        title: 'Yükselen Trend: Kova',
        description: 'Değişimin rüzgarları esiyor.',
        route: '/horoscope/aquarius',
        emoji: '♒',
      ),
      NavigationCard(
        title: 'Haftalık Genel Bakış',
        description: 'Bu hafta tüm burçları neler bekliyor?',
        route: '/horoscope/weekly',
        emoji: '📅',
      ),
      NavigationCard(
        title: 'Aylık Derinlik',
        description: 'Ayın büyük teması ne?',
        route: '/horoscope/monthly',
        emoji: '🌕',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Bu Gece Rüyanda Ne Gördün?',
        description: 'Burç enerjin rüyalarına nasıl yansıyor?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Günlük Kozmik Mesajın',
        description: 'Bugün evren sana ne söylemek istiyor?',
        route: '/kozmoz',
        emoji: '💫',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Doğum Haritanı Hesapla',
        description: 'Güneş burcunun ötesini gör.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'İlişki Uyumu',
        description: 'Sen ve o — kozmik dans nasıl?',
        route: '/compatibility',
        emoji: '💕',
      ),
      NavigationCard(
        title: 'Günlük Tarot',
        description: 'Kartlar bugün ne diyor?',
        route: '/tarot',
        emoji: '🃏',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Kozmoz Hub',
        description: 'Tüm özellikler',
        route: '/kozmoz',
        emoji: '✨',
      ),
      NavigationCard(
        title: 'Astroloji Sözlüğü',
        description: 'Kavramları öğren',
        route: '/glossary',
        emoji: '📖',
      ),
    ],
  );
}

// ============================================================
// PAGES 3-14: ZODIAC SIGN PAGES
// ============================================================

class ZodiacSignNavigation {
  static PageNavigation getNavigationForSign(String sign) {
    final signData = _zodiacData[sign];
    if (signData == null) return _defaultSignNavigation(sign);

    return PageNavigation(
      pageRoute: '/horoscope/$sign',
      pageType: 'zodiac_sign',
      alsoViewed: [
        NavigationCard(
          title: '${signData['compatibleSign1']} ile Uyumun',
          description: 'Bu ikili nasıl dans ediyor?',
          route: '/compatibility',
          emoji: signData['compatibleEmoji1'],
        ),
        NavigationCard(
          title: '${signData['elementBuddy1']} Burcu',
          description: 'Aynı element, farklı enerji.',
          route: '/horoscope/${signData['elementBuddyRoute1']}',
          emoji: signData['elementBuddyEmoji1'],
        ),
        NavigationCard(
          title: '${signData['elementBuddy2']} Burcu',
          description: 'Kardeş element enerjisi.',
          route: '/horoscope/${signData['elementBuddyRoute2']}',
          emoji: signData['elementBuddyEmoji2'],
        ),
        NavigationCard(
          title: 'Haftalık ${signData['name']} Yorumu',
          description: 'Bu hafta seni neler bekliyor?',
          route: '/horoscope/weekly',
          emoji: '📅',
        ),
      ],
      goDeeper: [
        NavigationCard(
          title: '${signData['name']} Rüyaları',
          description: 'Bu burçta insanlar en çok hangi rüyaları görür?',
          route: '/dream-interpretation',
          emoji: '🌙',
        ),
        NavigationCard(
          title: 'Bugün Sana Özel Mesaj',
          description: 'Kozmik rehberlik al.',
          route: '/kozmoz',
          emoji: '✨',
        ),
      ],
      keepExploring: [
        NavigationCard(
          title: 'Doğum Haritanı Gör',
          description: '${signData['name']} Güneşinin ötesinde ne var?',
          route: '/birth-chart',
          emoji: '🗺️',
        ),
        NavigationCard(
          title: '${signData['ruler']} Transiti',
          description: 'Yönetici gezegenin şu an nerede?',
          route: '/transits',
          emoji: '🪐',
        ),
        NavigationCard(
          title: 'Tarot Çek',
          description: '${signData['name']} enerjisiyle uyumlu bir okuma.',
          route: '/tarot',
          emoji: '🃏',
        ),
      ],
      continueWithoutBack: [
        NavigationCard(
          title: 'Tüm Burçlar',
          description: '12 burcu gez',
          route: '/horoscope',
          emoji: '♈',
        ),
        NavigationCard(
          title: 'Ana Sayfa',
          description: 'Başa dön',
          route: '/',
          emoji: '🏠',
        ),
        NavigationCard(
          title: 'Burç Uyumu',
          description: 'İkili analiz',
          route: '/compatibility',
          emoji: '💕',
        ),
      ],
    );
  }

  static const Map<String, Map<String, dynamic>> _zodiacData = {
    'aries': {
      'name': 'Koç',
      'ruler': 'Mars',
      'compatibleSign1': 'Aslan',
      'compatibleEmoji1': '♌',
      'elementBuddy1': 'Aslan',
      'elementBuddyRoute1': 'leo',
      'elementBuddyEmoji1': '♌',
      'elementBuddy2': 'Yay',
      'elementBuddyRoute2': 'sagittarius',
      'elementBuddyEmoji2': '♐',
    },
    'taurus': {
      'name': 'Boğa',
      'ruler': 'Venüs',
      'compatibleSign1': 'Başak',
      'compatibleEmoji1': '♍',
      'elementBuddy1': 'Başak',
      'elementBuddyRoute1': 'virgo',
      'elementBuddyEmoji1': '♍',
      'elementBuddy2': 'Oğlak',
      'elementBuddyRoute2': 'capricorn',
      'elementBuddyEmoji2': '♑',
    },
    'gemini': {
      'name': 'İkizler',
      'ruler': 'Merkür',
      'compatibleSign1': 'Terazi',
      'compatibleEmoji1': '♎',
      'elementBuddy1': 'Terazi',
      'elementBuddyRoute1': 'libra',
      'elementBuddyEmoji1': '♎',
      'elementBuddy2': 'Kova',
      'elementBuddyRoute2': 'aquarius',
      'elementBuddyEmoji2': '♒',
    },
    'cancer': {
      'name': 'Yengeç',
      'ruler': 'Ay',
      'compatibleSign1': 'Akrep',
      'compatibleEmoji1': '♏',
      'elementBuddy1': 'Akrep',
      'elementBuddyRoute1': 'scorpio',
      'elementBuddyEmoji1': '♏',
      'elementBuddy2': 'Balık',
      'elementBuddyRoute2': 'pisces',
      'elementBuddyEmoji2': '♓',
    },
    'leo': {
      'name': 'Aslan',
      'ruler': 'Güneş',
      'compatibleSign1': 'Koç',
      'compatibleEmoji1': '♈',
      'elementBuddy1': 'Koç',
      'elementBuddyRoute1': 'aries',
      'elementBuddyEmoji1': '♈',
      'elementBuddy2': 'Yay',
      'elementBuddyRoute2': 'sagittarius',
      'elementBuddyEmoji2': '♐',
    },
    'virgo': {
      'name': 'Başak',
      'ruler': 'Merkür',
      'compatibleSign1': 'Boğa',
      'compatibleEmoji1': '♉',
      'elementBuddy1': 'Boğa',
      'elementBuddyRoute1': 'taurus',
      'elementBuddyEmoji1': '♉',
      'elementBuddy2': 'Oğlak',
      'elementBuddyRoute2': 'capricorn',
      'elementBuddyEmoji2': '♑',
    },
    'libra': {
      'name': 'Terazi',
      'ruler': 'Venüs',
      'compatibleSign1': 'İkizler',
      'compatibleEmoji1': '♊',
      'elementBuddy1': 'İkizler',
      'elementBuddyRoute1': 'gemini',
      'elementBuddyEmoji1': '♊',
      'elementBuddy2': 'Kova',
      'elementBuddyRoute2': 'aquarius',
      'elementBuddyEmoji2': '♒',
    },
    'scorpio': {
      'name': 'Akrep',
      'ruler': 'Pluto',
      'compatibleSign1': 'Yengeç',
      'compatibleEmoji1': '♋',
      'elementBuddy1': 'Yengeç',
      'elementBuddyRoute1': 'cancer',
      'elementBuddyEmoji1': '♋',
      'elementBuddy2': 'Balık',
      'elementBuddyRoute2': 'pisces',
      'elementBuddyEmoji2': '♓',
    },
    'sagittarius': {
      'name': 'Yay',
      'ruler': 'Jüpiter',
      'compatibleSign1': 'Koç',
      'compatibleEmoji1': '♈',
      'elementBuddy1': 'Koç',
      'elementBuddyRoute1': 'aries',
      'elementBuddyEmoji1': '♈',
      'elementBuddy2': 'Aslan',
      'elementBuddyRoute2': 'leo',
      'elementBuddyEmoji2': '♌',
    },
    'capricorn': {
      'name': 'Oğlak',
      'ruler': 'Satürn',
      'compatibleSign1': 'Boğa',
      'compatibleEmoji1': '♉',
      'elementBuddy1': 'Boğa',
      'elementBuddyRoute1': 'taurus',
      'elementBuddyEmoji1': '♉',
      'elementBuddy2': 'Başak',
      'elementBuddyRoute2': 'virgo',
      'elementBuddyEmoji2': '♍',
    },
    'aquarius': {
      'name': 'Kova',
      'ruler': 'Uranüs',
      'compatibleSign1': 'İkizler',
      'compatibleEmoji1': '♊',
      'elementBuddy1': 'İkizler',
      'elementBuddyRoute1': 'gemini',
      'elementBuddyEmoji1': '♊',
      'elementBuddy2': 'Terazi',
      'elementBuddyRoute2': 'libra',
      'elementBuddyEmoji2': '♎',
    },
    'pisces': {
      'name': 'Balık',
      'ruler': 'Neptün',
      'compatibleSign1': 'Yengeç',
      'compatibleEmoji1': '♋',
      'elementBuddy1': 'Yengeç',
      'elementBuddyRoute1': 'cancer',
      'elementBuddyEmoji1': '♋',
      'elementBuddy2': 'Akrep',
      'elementBuddyRoute2': 'scorpio',
      'elementBuddyEmoji2': '♏',
    },
  };

  static PageNavigation _defaultSignNavigation(String sign) {
    return PageNavigation(
      pageRoute: '/horoscope/$sign',
      pageType: 'zodiac_sign',
      alsoViewed: const [],
      goDeeper: const [],
      keepExploring: const [],
      continueWithoutBack: const [],
    );
  }
}

// ============================================================
// PAGE 15: BIRTH CHART (/birth-chart)
// ============================================================

class BirthChartNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/birth-chart',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Şu Anki Transitler',
        description: 'Haritanı bugünün gökyüzüyle karşılaştır.',
        route: '/transits',
        emoji: '🪐',
      ),
      NavigationCard(
        title: 'Synastry Analizi',
        description: 'Haritanı bir başkasıyla birleştir.',
        route: '/synastry',
        emoji: '💑',
      ),
      NavigationCard(
        title: 'Solar Return',
        description: 'Bu yılın haritası nasıl?',
        route: '/solar-return',
        emoji: '🎂',
      ),
      NavigationCard(
        title: 'Progresyonlar',
        description: 'İçsel evrimini takip et.',
        route: '/progressions',
        emoji: '📈',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Haritanla Bağlantılı Rüyalar',
        description: 'Gezegenler rüyalarına nasıl yansıyor?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Kişisel Kozmik Mesaj',
        description: 'Haritana özel rehberlik.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Vedik Harita',
        description: 'Hint astrolojisi perspektifi.',
        route: '/vedic-chart',
        emoji: '🕉️',
      ),
      NavigationCard(
        title: 'Drakonik Harita',
        description: 'Ruhsal kökenin.',
        route: '/draconic-chart',
        emoji: '🐉',
      ),
      NavigationCard(
        title: 'Asteroidler',
        description: 'Chiron, Lilith ve diğerleri.',
        route: '/asteroids',
        emoji: '☄️',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Burçlar',
        description: 'Burç sayfaları',
        route: '/horoscope',
        emoji: '♈',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Astroloji Sözlüğü',
        description: 'Terimleri öğren',
        route: '/glossary',
        emoji: '📖',
      ),
    ],
  );
}

// ============================================================
// PAGE 16: TAROT (/tarot)
// ============================================================

class TarotNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/tarot',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Numeroloji',
        description: 'Sayıların gizemi — benzer bir yolculuk.',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Günlük Burç Yorumu',
        description: 'Tarotla birlikte oku.',
        route: '/horoscope',
        emoji: '⭐',
      ),
      NavigationCard(
        title: 'Kabala',
        description: 'Tarot ve Hayat Ağacı bağlantısı.',
        route: '/kabbalah',
        emoji: '🌳',
      ),
      NavigationCard(
        title: 'Aura Okuma',
        description: 'Enerji alanını keşfet.',
        route: '/aura',
        emoji: '🌈',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Rüyandaki Sembolleri Çöz',
        description: 'Kartlar ve rüyalar benzer bir dil konuşur.',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Kozmik Rehberlik',
        description: 'Kartların ötesinde bir mesaj.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Doğum Haritası',
        description: 'Kozmik kimliğin.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Chakra Analizi',
        description: 'Enerji merkezlerin.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
      NavigationCard(
        title: 'Ay Ritüelleri',
        description: 'Tarotla birlikte ritüel.',
        route: '/moon-rituals',
        emoji: '🌕',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer keşif yolları',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Astroloji Sözlüğü',
        description: 'Tarot terimleri',
        route: '/glossary',
        emoji: '📖',
      ),
    ],
  );
}

// ============================================================
// PAGE 17: NUMEROLOGY (/numerology)
// ============================================================

class NumerologyNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/numerology',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Kabala Sayıları',
        description: 'Sayıların mistik kökeni.',
        route: '/kabbalah',
        emoji: '🌳',
      ),
      NavigationCard(
        title: 'Doğum Haritası',
        description: 'Astrolojik perspektif.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Tarot',
        description: 'Kartlardaki sayılar.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: 'İlişki Uyumu',
        description: 'Sayısal uyum analizi.',
        route: '/compatibility',
        emoji: '💑',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Sayılarla Rüya Yorumu',
        description: 'Rüyandaki sayılar ne anlatıyor?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Kişisel Yıl Mesajı',
        description: 'Bu yılın sayısal enerjisi.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Günlük Burç',
        description: 'Sayılarla birlikte oku.',
        route: '/horoscope',
        emoji: '⭐',
      ),
      NavigationCard(
        title: 'Aura Renkleri',
        description: 'Enerji alanın.',
        route: '/aura',
        emoji: '🌈',
      ),
      NavigationCard(
        title: 'Chakra Dengesi',
        description: 'Sayılar ve chakralar.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer sistemler',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Sayı Anlamları',
        description: '1-9 ve master sayılar',
        route: '/glossary',
        emoji: '🔢',
      ),
    ],
  );
}

// ============================================================
// PAGE 18: COMPATIBILITY (/compatibility)
// ============================================================

class CompatibilityNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/compatibility',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Synastry Derinliği',
        description: 'Haritaları detaylı karşılaştır.',
        route: '/synastry',
        emoji: '🔍',
      ),
      NavigationCard(
        title: 'Kompozit Harita',
        description: 'İlişkinin kendi haritası.',
        route: '/composite-chart',
        emoji: '💞',
      ),
      NavigationCard(
        title: 'Aşk Burcu Yorumu',
        description: 'Haftalık aşk enerjisi',
        route: '/horoscope/love',
        emoji: '💕',
      ),
      NavigationCard(
        title: 'Venüs ve Mars',
        description: 'Aşk gezegenlerini incele.',
        route: '/birth-chart',
        emoji: '🪐',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'İlişki Rüyaları',
        description: 'Partnerinle ilgili rüyalar ne anlatıyor?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'İlişki Rehberliği',
        description: 'Kozmik perspektif.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Aşk Tarot\'u',
        description: 'İlişki için kart çek.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: 'Sayısal Uyum',
        description: 'İsimlerle numeroloji.',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Venüs Transiti',
        description: 'Aşk gezegeni nerede?',
        route: '/transits',
        emoji: '💖',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Burçlar',
        description: 'Burç sayfaları',
        route: '/horoscope',
        emoji: '♈',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Ünlü Çiftler',
        description: 'Ünlülerin uyumu',
        route: '/celebrities',
        emoji: '🌟',
      ),
    ],
  );
}

// ============================================================
// PAGE 19: AURA (/aura)
// ============================================================

class AuraNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/aura',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Chakra Analizi',
        description: 'Enerji merkezlerini keşfet.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
      NavigationCard(
        title: 'Ay Ritüelleri',
        description: 'Enerji temizliği pratikleri.',
        route: '/moon-rituals',
        emoji: '🌕',
      ),
      NavigationCard(
        title: 'Doğum Haritası',
        description: 'Kozmik enerji haritası.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Tarot',
        description: 'Enerji okuma yolu.',
        route: '/tarot',
        emoji: '🃏',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Enerji Rüyaları',
        description: 'Renkler ve ışık rüyalarının anlamı.',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Günlük Enerji Mesajı',
        description: 'Bugünün enerji akışı.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Numeroloji',
        description: 'Sayısal titreşimler.',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Kabala',
        description: 'Sefirot enerjileri.',
        route: '/kabbalah',
        emoji: '🌳',
      ),
      NavigationCard(
        title: 'Günlük Burç',
        description: 'Kozmik enerji.',
        route: '/horoscope',
        emoji: '⭐',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer keşif yolları',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Renk Anlamları',
        description: 'Aura renkleri sözlüğü',
        route: '/glossary',
        emoji: '🌈',
      ),
    ],
  );
}

// ============================================================
// PAGE 20: KABBALAH (/kabbalah)
// ============================================================

class KabbalahNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/kabbalah',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Tarot ve Patikalar',
        description: '22 Major Arcana, 22 patika.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: 'Numeroloji',
        description: 'Gematria ve sayılar.',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Astroloji Bağlantısı',
        description: 'Sefirot ve gezegenler.',
        route: '/birth-chart',
        emoji: '🪐',
      ),
      NavigationCard(
        title: 'Chakra Sistemi',
        description: 'Doğu ve Batı enerji haritaları.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Mistik Rüyalar',
        description: 'Ruhani semboller ve rüyalar.',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Sefirot Meditasyonu',
        description: 'Hayat Ağacında yolculuk.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Aura Okuma',
        description: 'Enerji alanı.',
        route: '/aura',
        emoji: '🌈',
      ),
      NavigationCard(
        title: 'Ay Ritüelleri',
        description: 'Spiritüel pratikler.',
        route: '/moon-rituals',
        emoji: '🌕',
      ),
      NavigationCard(
        title: 'Günlük Burç',
        description: 'Kozmik perspektif.',
        route: '/horoscope',
        emoji: '⭐',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer sistemler',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Sefirot Sözlüğü',
        description: '10 sefirah anlamları',
        route: '/glossary',
        emoji: '🌳',
      ),
    ],
  );
}

// ============================================================
// PAGE 21: TRANSITS (/transits)
// ============================================================

class TransitsNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/transits',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Doğum Haritam',
        description: 'Transitler haritama nasıl etkiliyor?',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Solar Return',
        description: 'Bu yılın haritası.',
        route: '/solar-return',
        emoji: '🎂',
      ),
      NavigationCard(
        title: 'Progresyonlar',
        description: 'İçsel evrim takibi.',
        route: '/progressions',
        emoji: '📈',
      ),
      NavigationCard(
        title: 'Satürn Dönüşü',
        description: '29 yaş krizi.',
        route: '/saturn-return',
        emoji: '🪐',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Transit Döneminde Rüyalar',
        description: 'Yoğun transitlerde rüyalar ne anlatır?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Kişisel Transit Rehberliği',
        description: 'Bu dönem için özel mesaj.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Günlük Burç',
        description: 'Bugünün enerjisi.',
        route: '/horoscope',
        emoji: '⭐',
      ),
      NavigationCard(
        title: 'Electional Astroloji',
        description: 'Uygun zamanları seç.',
        route: '/timing',
        emoji: '📅',
      ),
      NavigationCard(
        title: 'Retrograd Takvimi',
        description: 'Merkür retrosu ne zaman?',
        route: '/transit-calendar',
        emoji: '↩️',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Doğum Haritam',
        description: 'Kozmik kimliğin',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Gezegen Sözlüğü',
        description: 'Transit anlamları',
        route: '/glossary',
        emoji: '📖',
      ),
    ],
  );
}

// ============================================================
// ADDITIONAL PAGES NAVIGATION
// ============================================================

class DreamInterpretationNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/dream-interpretation',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Ay Fazları ve Rüyalar',
        description: 'Ayın döngüsü rüyaları nasıl etkiler?',
        route: '/moon-rituals',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Burç ve Rüya Kalıpları',
        description: 'Burcun rüyalarına nasıl yansıyor?',
        route: '/horoscope',
        emoji: '⭐',
      ),
      NavigationCard(
        title: 'Bilinçaltı ve Tarot',
        description: 'Rüyalar ve kartlar benzer dil konuşur.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: '12. Ev ve Rüyalar',
        description: 'Natal haritanda rüya evi.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Kozmik Mesajın',
        description: 'Rüyanın ötesinde rehberlik.',
        route: '/kozmoz',
        emoji: '✨',
      ),
      NavigationCard(
        title: 'Başka Bir Rüya Anlat',
        description: 'Yeni bir yolculuğa başla.',
        route: '/dream-interpretation',
        emoji: '🔮',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Chakra ve Rüyalar',
        description: 'Enerji merkezleri ve bilinçaltı.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
      NavigationCard(
        title: 'Aura Okuma',
        description: 'Enerji alanın.',
        route: '/aura',
        emoji: '🌈',
      ),
      NavigationCard(
        title: 'Neptün Transiti',
        description: 'Rüya gezegeni nerede?',
        route: '/transits',
        emoji: '🪐',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer keşif yolları',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Sembol Sözlüğü',
        description: 'Rüya sembolleri',
        route: '/glossary',
        emoji: '📖',
      ),
    ],
  );
}

class KozmozNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/kozmoz',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Günlük Burç Yorumu',
        description: 'Bugünün kozmik enerjisi.',
        route: '/horoscope',
        emoji: '⭐',
      ),
      NavigationCard(
        title: 'Günlük Tarot',
        description: 'Kartların mesajı.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: 'Ay Fazı',
        description: 'Ayın bugünkü etkisi.',
        route: '/moon-rituals',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Transitler',
        description: 'Gökyüzü bugün.',
        route: '/transits',
        emoji: '🪐',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Rüyanı Anlat',
        description: 'Kozmik mesajın rüyalara nasıl yansıyor?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Kozmik Keşif',
        description: 'Daha fazla içgörü al.',
        route: '/kesif/ruhsal-donusum',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Doğum Haritam',
        description: 'Kozmik kimliğim.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
      NavigationCard(
        title: 'Numeroloji',
        description: 'Sayıların bilgeliği.',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Chakra Dengesi',
        description: 'Enerji merkezlerim.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Premium Özellikler',
        description: 'Gelişmiş astroloji',
        route: '/premium',
        emoji: '👑',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Astroloji Sözlüğü',
        description: 'Kavramları öğren',
        route: '/glossary',
        emoji: '📖',
      ),
    ],
  );
}

class ChakraNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/chakra-analysis',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Aura Renkleri',
        description: 'Enerji alanın ve chakralar.',
        route: '/aura',
        emoji: '🌈',
      ),
      NavigationCard(
        title: 'Ay Ritüelleri',
        description: 'Chakra dengeleme pratikleri.',
        route: '/moon-rituals',
        emoji: '🌕',
      ),
      NavigationCard(
        title: 'Kabala Sefirotları',
        description: 'Doğu-Batı enerji haritaları.',
        route: '/kabbalah',
        emoji: '🌳',
      ),
      NavigationCard(
        title: 'Doğum Haritası',
        description: 'Gezegenler ve chakralar.',
        route: '/birth-chart',
        emoji: '🗺️',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Chakra ve Rüyalar',
        description: 'Enerji blokajları rüyalara nasıl yansır?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Enerji Rehberliği',
        description: 'Chakralarına özel mesaj.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Tarot',
        description: 'Enerji okuma.',
        route: '/tarot',
        emoji: '🃏',
      ),
      NavigationCard(
        title: 'Numeroloji',
        description: 'Sayısal titreşimler.',
        route: '/numerology',
        emoji: '🔢',
      ),
      NavigationCard(
        title: 'Günlük Burç',
        description: 'Kozmik enerji.',
        route: '/horoscope',
        emoji: '⭐',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer sistemler',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: '7 Chakra Rehberi',
        description: 'Detaylı açıklamalar',
        route: '/glossary',
        emoji: '🧘',
      ),
    ],
  );
}

class MoonRitualsNavigation {
  static const navigation = PageNavigation(
    pageRoute: '/moon-rituals',
    pageType: 'tool',
    alsoViewed: [
      NavigationCard(
        title: 'Ay Takvimi',
        description: 'Yeniay ve dolunay tarihleri.',
        route: '/timing',
        emoji: '📅',
      ),
      NavigationCard(
        title: 'Chakra Dengeleme',
        description: 'Ritüellerle enerji çalışması.',
        route: '/chakra-analysis',
        emoji: '🧘',
      ),
      NavigationCard(
        title: 'Aura Temizliği',
        description: 'Enerji alanını arındır.',
        route: '/aura',
        emoji: '🌈',
      ),
      NavigationCard(
        title: 'Tarot Ritüeli',
        description: 'Kart çekme meditasyonu.',
        route: '/tarot',
        emoji: '🃏',
      ),
    ],
    goDeeper: [
      NavigationCard(
        title: 'Ritüel Sonrası Rüyalar',
        description: 'Ritüeller rüyaları nasıl etkiler?',
        route: '/dream-interpretation',
        emoji: '🌙',
      ),
      NavigationCard(
        title: 'Niyet Rehberliği',
        description: 'Bu ay için kozmik mesaj.',
        route: '/kozmoz',
        emoji: '✨',
      ),
    ],
    keepExploring: [
      NavigationCard(
        title: 'Günlük Burç',
        description: 'Bugünün enerjisi.',
        route: '/horoscope',
        emoji: '⭐',
      ),
      NavigationCard(
        title: 'Transitler',
        description: 'Ay ve gezegen konumları.',
        route: '/transits',
        emoji: '🪐',
      ),
      NavigationCard(
        title: 'Kabala Meditasyonu',
        description: 'Sefirot yolculuğu.',
        route: '/kabbalah',
        emoji: '🌳',
      ),
    ],
    continueWithoutBack: [
      NavigationCard(
        title: 'Tüm Çözümlemeler',
        description: 'Diğer pratikler',
        route: '/kozmoz',
        emoji: '🧰',
      ),
      NavigationCard(
        title: 'Ana Sayfa',
        description: 'Başa dön',
        route: '/',
        emoji: '🏠',
      ),
      NavigationCard(
        title: 'Ritüel Rehberi',
        description: 'Adım adım talimatlar',
        route: '/daily-rituals',
        emoji: '📖',
      ),
    ],
  );
}

// ============================================================
// NAVIGATION SERVICE
// ============================================================

class NavigationService {
  static PageNavigation getNavigationForRoute(String route) {
    // Normalize route
    final normalizedRoute = route
        .replaceAll(RegExp(r'^/+|/+$'), '')
        .toLowerCase();

    // Check for zodiac sign pages
    if (normalizedRoute.startsWith('horoscope/')) {
      final sign = normalizedRoute.split('/').last;
      return ZodiacSignNavigation.getNavigationForSign(sign);
    }

    // Map routes to navigation
    switch (normalizedRoute) {
      case '':
      case 'home':
        return HomepageNavigation.navigation;
      case 'horoscope':
        return HoroscopeHubNavigation.navigation;
      case 'birth-chart':
        return BirthChartNavigation.navigation;
      case 'tarot':
        return TarotNavigation.navigation;
      case 'numerology':
        return NumerologyNavigation.navigation;
      case 'compatibility':
        return CompatibilityNavigation.navigation;
      case 'aura':
        return AuraNavigation.navigation;
      case 'kabbalah':
        return KabbalahNavigation.navigation;
      case 'transits':
        return TransitsNavigation.navigation;
      case 'dream-interpretation':
        return DreamInterpretationNavigation.navigation;
      case 'kozmoz':
        return KozmozNavigation.navigation;
      case 'chakra-analysis':
        return ChakraNavigation.navigation;
      case 'moon-rituals':
        return MoonRitualsNavigation.navigation;
      default:
        return _defaultNavigation(normalizedRoute);
    }
  }

  static PageNavigation _defaultNavigation(String route) {
    return PageNavigation(
      pageRoute: '/$route',
      pageType: 'default',
      alsoViewed: const [
        NavigationCard(
          title: 'Günlük Burç Yorumu',
          description: 'Bugünün enerjisi.',
          route: '/horoscope',
          emoji: '⭐',
        ),
        NavigationCard(
          title: 'Doğum Haritası',
          description: 'Kozmik kimliğin.',
          route: '/birth-chart',
          emoji: '🗺️',
        ),
        NavigationCard(
          title: 'Tarot',
          description: 'Günlük kart.',
          route: '/tarot',
          emoji: '🃏',
        ),
      ],
      goDeeper: const [
        NavigationCard(
          title: 'Rüyanı Anlat',
          description: 'Bilinçaltınla konuş.',
          route: '/dream-interpretation',
          emoji: '🌙',
        ),
        NavigationCard(
          title: 'Kozmik Rehberlik',
          description: 'Kişisel mesaj al.',
          route: '/kozmoz',
          emoji: '✨',
        ),
      ],
      keepExploring: const [
        NavigationCard(
          title: 'Numeroloji',
          description: 'Sayıların sırrı.',
          route: '/numerology',
          emoji: '🔢',
        ),
        NavigationCard(
          title: 'Aura',
          description: 'Enerji alanın.',
          route: '/aura',
          emoji: '🌈',
        ),
        NavigationCard(
          title: 'Ritüeller',
          description: 'Ay pratikleri.',
          route: '/moon-rituals',
          emoji: '🌕',
        ),
      ],
      continueWithoutBack: const [
        NavigationCard(
          title: 'Tüm Burçlar',
          description: '12 burç',
          route: '/horoscope',
          emoji: '♈',
        ),
        NavigationCard(
          title: 'Ana Sayfa',
          description: 'Başa dön',
          route: '/',
          emoji: '🏠',
        ),
        NavigationCard(
          title: 'Sözlük',
          description: 'Terimler',
          route: '/glossary',
          emoji: '📖',
        ),
      ],
    );
  }
}
