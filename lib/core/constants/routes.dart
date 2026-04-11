class Routes {
  Routes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String horoscope = '/horoscope';
  static const String horoscopeDetail = '/horoscope/:sign';
  static const String compatibility = '/compatibility';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String birthChart = '/birth-chart';
  static const String numerology = '/numerology';
  static const String kabbalah = '/kabbalah';
  static const String tarot = '/tarot';
  static const String majorArcanaDetail = '/tarot/major/:number';
  static const String aura = '/aura';
  static const String transits = '/transits';
  static const String premium = '/premium';
  static const String shareSummary = '/share';
  static const String cosmicShare = '/cosmic-share';

  // Extended Horoscopes
  static const String weeklyHoroscope = '/horoscope/weekly';
  static const String weeklyHoroscopeDetail = '/horoscope/weekly/:sign';
  static const String monthlyHoroscope = '/horoscope/monthly';
  static const String monthlyHoroscopeDetail = '/horoscope/monthly/:sign';
  static const String yearlyHoroscope = '/horoscope/yearly';
  static const String yearlyHoroscopeDetail = '/horoscope/yearly/:sign';
  static const String loveHoroscope = '/horoscope/love';
  static const String loveHoroscopeDetail = '/horoscope/love/:sign';
  static const String eclipseCalendar = '/eclipse-calendar';

  // Advanced Astrology
  static const String compositeChart = '/composite-chart';
  static const String vedicChart = '/vedic-chart';
  static const String progressions = '/progressions';
  static const String saturnReturn = '/saturn-return';
  static const String solarReturn = '/solar-return';
  static const String synastry = '/synastry';
  static const String yearAhead = '/year-ahead';
  static const String timing = '/timing';

  // Premium Features
  static const String astroCartography = '/astro-cartography';
  static const String electional = '/electional';
  static const String draconicChart = '/draconic-chart';
  static const String asteroids = '/asteroids';
  static const String localSpace = '/local-space';

  // Reference & Content
  static const String glossary = '/glossary';
  static const String gardeningMoon = '/gardening-moon';
  static const String celebrities = '/celebrities';
  static const String articles = '/articles';

  // New Features
  static const String transitCalendar = '/transit-calendar';
  static const String voidOfCourse = '/void-of-course';

  // ════════════════════════════════════════════════════════════════
  // NUMEROLOGY - Kadim Sayı Bilgeliği (60+ İçerik)
  // ════════════════════════════════════════════════════════════════

  // Life Path Numbers (1-9)
  static const String lifePathDetail = '/numerology/life-path/:number';
  static const String lifePath1 = '/numerology/life-path/1';
  static const String lifePath2 = '/numerology/life-path/2';
  static const String lifePath3 = '/numerology/life-path/3';
  static const String lifePath4 = '/numerology/life-path/4';
  static const String lifePath5 = '/numerology/life-path/5';
  static const String lifePath6 = '/numerology/life-path/6';
  static const String lifePath7 = '/numerology/life-path/7';
  static const String lifePath8 = '/numerology/life-path/8';
  static const String lifePath9 = '/numerology/life-path/9';

  // Master Numbers
  static const String masterNumber = '/numerology/master/:number';
  static const String master11 = '/numerology/master/11';
  static const String master22 = '/numerology/master/22';
  static const String master33 = '/numerology/master/33';

  // Personal Year
  static const String personalYearDetail = '/numerology/personal-year/:number';
  static const String personalYear1 = '/numerology/personal-year/1';
  static const String personalYear2 = '/numerology/personal-year/2';
  static const String personalYear3 = '/numerology/personal-year/3';
  static const String personalYear4 = '/numerology/personal-year/4';
  static const String personalYear5 = '/numerology/personal-year/5';
  static const String personalYear6 = '/numerology/personal-year/6';
  static const String personalYear7 = '/numerology/personal-year/7';
  static const String personalYear8 = '/numerology/personal-year/8';
  static const String personalYear9 = '/numerology/personal-year/9';

  // Additional Numerology Content
  static const String birthdayNumber = '/numerology/birthday';
  static const String destinyNumber = '/numerology/destiny';
  static const String soulUrge = '/numerology/soul-urge';
  static const String personalityNumber = '/numerology/personality';
  static const String karmicDebt = '/numerology/karmic-debt';
  static const String missingNumbers = '/numerology/missing-numbers';
  static const String numerologyCompatibility = '/numerology/compatibility';

  // Spiritual & Wellness
  static const String dailyRituals = '/daily-rituals';
  static const String chakraAnalysis = '/chakra-analysis';
  static const String crystalGuide = '/crystal-guide';
  static const String moonRituals = '/moon-rituals';
  static const String dreamInterpretation = '/dream-interpretation';
  static const String dreamGlossary = '/dream-glossary';
  static const String dreamShare = '/dream-share';
  static const String tantra = '/tantra';
  static const String thetaHealing = '/theta-healing';
  static const String reiki = '/reiki';

  // ════════════════════════════════════════════════════════════════
  // RÜYA İZİ - AI-First Canonical Sayfalar
  // ════════════════════════════════════════════════════════════════
  static const String dreamFalling = '/ruya/dusmek';
  static const String dreamWater = '/ruya/su-gormek';
  static const String dreamRecurring = '/ruya/tekrar-eden';
  static const String dreamRunning = '/ruya/kacmak';
  static const String dreamLosing = '/ruya/birini-kaybetmek';
  static const String dreamFlying = '/ruya/ucmak';
  static const String dreamDarkness = '/ruya/karanlik';
  static const String dreamPast = '/ruya/gecmisten-biri';
  static const String dreamSearching = '/ruya/bir-sey-aramak';
  static const String dreamVoiceless = '/ruya/ses-cikaramamak';
  static const String dreamLost = '/ruya/kaybolmak';
  static const String dreamUnableToFly = '/ruya/ucamamak';

  // ════════════════════════════════════════════════════════════════
  // KOZMİK - Günlük Tema
  // ════════════════════════════════════════════════════════════════
  static const String cosmicToday = '/kozmik/bugunku-tema';
  static const String cosmicEnergy = '/kozmik/bugunku-enerji';
  static const String cosmicEmotion = '/kozmik/one-cikan-duygu';

  // ════════════════════════════════════════════════════════════════
  // TANTRA - Mikro Ritüeller
  // ════════════════════════════════════════════════════════════════
  static const String tantraMicroRitual = '/tantra/mikro-rituel';
  static const String tantraBreath = '/tantra/nefes-farkindalik';
  static const String tantraIntention = '/tantra/niyet-ritueli';

  // Kozmik Ruhsal Araclari - Header'da
  static const String kozmikIletisim =
      '/kozmik-iletisim'; // Chatbot - Ruya yorumlama sohbeti
  static const String ruyaDongusu =
      '/ruya-dongusu'; // Dream Oracle - 7 boyutlu form

  // Profile Management
  static const String savedProfiles = '/saved-profiles';
  static const String comparison = '/comparison';

  // Kozmoz - Tüm özellikler ekranı
  static const String kozmoz = '/kozmoz';

  // Tüm Çözümlemeler - Ana katalog sayfası
  static const String allServices = '/tum-cozumlemeler';

  // ════════════════════════════════════════════════════════════════
  // KOZMİK KEŞİF - Viral & Felsefi İçerikler (Özel Ekranlar)
  // ════════════════════════════════════════════════════════════════

  // Günlük Enerjiler
  static const String dailySummary = '/kesif/gunun-ozeti';
  static const String moonEnergy = '/kesif/ay-enerjisi';
  static const String loveEnergy = '/kesif/ask-enerjisi';
  static const String abundanceEnergy = '/kesif/bolluk-enerjisi';

  // Ruhsal Dönüşüm & Hayat Amacı
  static const String spiritualTransformation = '/kesif/ruhsal-donusum';
  static const String lifePurpose = '/kesif/hayat-amacin';
  static const String subconsciousPatterns = '/kesif/bilincalti-kaliplarin';
  static const String karmaLessons = '/kesif/karma-derslerin';
  static const String soulContract = '/kesif/ruh-sozlesmen';
  static const String innerPower = '/kesif/icsel-gucun';

  // Kişilik Analizleri
  static const String shadowSelf = '/kesif/golge-benligin';
  static const String leadershipStyle = '/kesif/liderlik-stilin';
  static const String heartbreak = '/kesif/kalp-yaran';
  static const String redFlags = '/kesif/red-flaglerin';
  static const String greenFlags = '/kesif/green-flaglerin';
  static const String flirtStyle = '/kesif/flort-stilin';

  // Mistik Keşifler
  static const String tarotCard = '/kesif/tarot-kartin';
  static const String auraColor = '/kesif/aura-rengin';
  static const String chakraBalance = '/kesif/cakra-dengen';
  static const String lifeNumber = '/kesif/yasam-sayin';
  static const String kabbalaPath = '/kesif/kabala-yolun';

  // Zaman & Döngüler
  static const String saturnLessons = '/kesif/saturn-derslerin';
  static const String birthdayEnergy = '/kesif/dogum-gunu-enerjin';
  static const String eclipseEffect = '/kesif/tutulma-etkisi';
  static const String transitFlow = '/kesif/transit-akisi';

  // İlişki Analizleri
  static const String compatibilityAnalysis = '/kesif/uyum-analizi';
  static const String soulMate = '/kesif/ruh-esin';
  static const String relationshipKarma = '/kesif/iliski-karman';
  static const String celebrityTwin = '/kesif/unlu-ikizin';

  // ════════════════════════════════════════════════════════════════
  // ADMIN SYSTEM - PIN Protected Dashboard
  // ════════════════════════════════════════════════════════════════
  static const String adminLogin = '/admin/login';
  static const String admin = '/admin';
}
