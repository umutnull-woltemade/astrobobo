/// Dream Interpretation Models - 7 Boyutlu Rüya Yorumlama Sistemi
/// Kadim bilgelik + Jungian arketipler + Astrolojik zamanlama
library;

// ════════════════════════════════════════════════════════════════
// TEMEL ENUMlar
// ════════════════════════════════════════════════════════════════

/// Sembol kategorileri
enum SymbolCategory {
  nesne('Nesne', '📦'),
  insan('İnsan', '👤'),
  hayvan('Hayvan', '🐾'),
  mekan('Mekân', '🏠'),
  eylem('Eylem', '🏃'),
  dogaOlayi('Doğa Olayı', '🌪️'),
  soyut('Soyut Durum', '💭');

  final String label;
  final String emoji;
  const SymbolCategory(this.label, this.emoji);
}

/// Duygusal tonlar
enum EmotionalTone {
  korku('Korku', '😨', 'Bilinçaltının alarm sistemi aktif'),
  huzur('Huzur', '😌', 'İçsel denge ve kabul'),
  merak('Merak', '🤔', 'Keşif ve öğrenme arzusu'),
  sucluluk('Suçluluk', '😔', 'Tamamlanmamış duygusal iş'),
  ozlem('Özlem', '💭', 'Geçmişe veya olasılıklara bağlantı'),
  heyecan('Heyecan', '🤩', 'Yeni başlangıçlara hazırlık'),
  donukluk('Donukluk', '😶', 'Duygusal koruma mekanizması'),
  ofke('Öfke', '😤', 'Bastırılmış güç ve sınır ihlali');

  final String label;
  final String emoji;
  final String hint;
  const EmotionalTone(this.label, this.emoji, this.hint);
}

/// Rüyadaki roller
enum DreamRole {
  izleyici('İzleyici', '👁️', 'Olaylara müdahale edemiyor'),
  kahraman('Aktif Kahraman', '🦸', 'Olayları yönlendiriyor'),
  kacan('Kaçan', '🏃', 'Tehditten uzaklaşıyor'),
  arayan('Arayan', '🔍', 'Bir şeyi/birini bulamıyor'),
  saklanan('Saklanan', '🙈', 'Görünmek istemiyor'),
  kurtarici('Kurtarıcı', '🛡️', 'Başkasını koruyuyor'),
  kurban('Kurban', '😰', 'Kontrol kaybı yaşıyor');

  final String label;
  final String emoji;
  final String description;
  const DreamRole(this.label, this.emoji, this.description);
}

/// Zaman katmanları
enum TimeLayer {
  gecmis('Geçmiş', '⏪', 'Tamamlanmamış duygusal iş'),
  simdi('Şimdi', '⏺️', 'Güncel yaşam stresi veya fırsatı'),
  gelecek('Gelecek', '⏩', 'Bilinçaltının sezdiği değişim'),
  dongusel('Döngüsel', '🔄', 'Tekrar eden kalıp, kırılması gereken zincir');

  final String label;
  final String emoji;
  final String meaning;
  const TimeLayer(this.label, this.emoji, this.meaning);
}

/// Ay fazları
enum MoonPhase {
  yeniay('Yeniay', '🌑', 'Tohum mesajı, yeni niyet'),
  hilal('Hilal', '🌒', 'Büyüme potansiyeli, cesaret'),
  ilkDordun('İlk Dördün', '🌓', 'Karar noktası, iki yol'),
  dolunay('Dolunay', '🌕', 'Farkındalık doruğu'),
  sonDordun('Son Dördün', '🌗', 'Bırakma zamanı'),
  karanlikAy('Karanlık Ay', '🌘', 'En kadim mesajlar');

  final String label;
  final String emoji;
  final String meaning;
  const MoonPhase(this.label, this.emoji, this.meaning);
}

// ════════════════════════════════════════════════════════════════
// SEMBOL VERİTABANI
// ════════════════════════════════════════════════════════════════

/// Rüya sembolü verisi
class DreamSymbolData {
  final String symbol;
  final String symbolTr;
  final String emoji;
  final SymbolCategory category;
  final List<String> universalMeanings;
  final Map<EmotionalTone, String> emotionVariants;
  final List<String> archetypes;
  final List<String> relatedSymbols;
  final String shadowAspect;
  final String lightAspect;

  const DreamSymbolData({
    required this.symbol,
    required this.symbolTr,
    required this.emoji,
    required this.category,
    required this.universalMeanings,
    required this.emotionVariants,
    required this.archetypes,
    required this.relatedSymbols,
    required this.shadowAspect,
    required this.lightAspect,
  });
}

// ════════════════════════════════════════════════════════════════
// YORUM KATMANLARI
// ════════════════════════════════════════════════════════════════

/// Sembol yorumu
class SymbolInterpretation {
  final String symbol;
  final String symbolEmoji;
  final String universalMeaning;
  final String personalContext;
  final String shadowAspect;
  final String lightAspect;
  final List<String> relatedSymbols;

  const SymbolInterpretation({
    required this.symbol,
    required this.symbolEmoji,
    required this.universalMeaning,
    required this.personalContext,
    required this.shadowAspect,
    required this.lightAspect,
    this.relatedSymbols = const [],
  });

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'symbolEmoji': symbolEmoji,
    'universalMeaning': universalMeaning,
    'personalContext': personalContext,
    'shadowAspect': shadowAspect,
    'lightAspect': lightAspect,
    'relatedSymbols': relatedSymbols,
  };

  factory SymbolInterpretation.fromJson(Map<String, dynamic> json) =>
      SymbolInterpretation(
        symbol: json['symbol'],
        symbolEmoji: json['symbolEmoji'],
        universalMeaning: json['universalMeaning'],
        personalContext: json['personalContext'],
        shadowAspect: json['shadowAspect'],
        lightAspect: json['lightAspect'],
        relatedSymbols: List<String>.from(json['relatedSymbols'] ?? []),
      );
}

/// Duygusal okuma
class EmotionalReading {
  final EmotionalTone dominantEmotion;
  final String surfaceMessage;
  final String deeperMeaning;
  final String shadowQuestion;
  final String integrationPath;

  const EmotionalReading({
    required this.dominantEmotion,
    required this.surfaceMessage,
    required this.deeperMeaning,
    required this.shadowQuestion,
    required this.integrationPath,
  });

  Map<String, dynamic> toJson() => {
    'dominantEmotion': dominantEmotion.name,
    'surfaceMessage': surfaceMessage,
    'deeperMeaning': deeperMeaning,
    'shadowQuestion': shadowQuestion,
    'integrationPath': integrationPath,
  };

  factory EmotionalReading.fromJson(Map<String, dynamic> json) =>
      EmotionalReading(
        dominantEmotion: EmotionalTone.values.firstWhere(
          (e) => e.name == json['dominantEmotion'],
        ),
        surfaceMessage: json['surfaceMessage'],
        deeperMeaning: json['deeperMeaning'],
        shadowQuestion: json['shadowQuestion'],
        integrationPath: json['integrationPath'],
      );
}

/// Astrolojik zamanlama
class AstroTiming {
  final MoonPhase moonPhase;
  final String? moonSign;
  final String? relevantTransit;
  final String timingMessage;
  final String whyNow;
  final bool isRetrograde;

  const AstroTiming({
    required this.moonPhase,
    this.moonSign,
    this.relevantTransit,
    required this.timingMessage,
    required this.whyNow,
    this.isRetrograde = false,
  });

  Map<String, dynamic> toJson() => {
    'moonPhase': moonPhase.name,
    'moonSign': moonSign,
    'relevantTransit': relevantTransit,
    'timingMessage': timingMessage,
    'whyNow': whyNow,
    'isRetrograde': isRetrograde,
  };

  factory AstroTiming.fromJson(Map<String, dynamic> json) => AstroTiming(
    moonPhase: MoonPhase.values.firstWhere((e) => e.name == json['moonPhase']),
    moonSign: json['moonSign'],
    relevantTransit: json['relevantTransit'],
    timingMessage: json['timingMessage'],
    whyNow: json['whyNow'],
    isRetrograde: json['isRetrograde'] ?? false,
  );
}

/// Işık/Gölge okuması
class LightShadowReading {
  final String lightMessage;
  final String shadowMessage;
  final String integrationPath;
  final String archetype;

  const LightShadowReading({
    required this.lightMessage,
    required this.shadowMessage,
    required this.integrationPath,
    required this.archetype,
  });

  Map<String, dynamic> toJson() => {
    'lightMessage': lightMessage,
    'shadowMessage': shadowMessage,
    'integrationPath': integrationPath,
    'archetype': archetype,
  };

  factory LightShadowReading.fromJson(Map<String, dynamic> json) =>
      LightShadowReading(
        lightMessage: json['lightMessage'],
        shadowMessage: json['shadowMessage'],
        integrationPath: json['integrationPath'],
        archetype: json['archetype'],
      );
}

/// Pratik rehberlik
class PracticalGuidance {
  final String todayAction;
  final String reflectionQuestion;
  final String weeklyFocus;
  final String avoidance;

  const PracticalGuidance({
    required this.todayAction,
    required this.reflectionQuestion,
    required this.weeklyFocus,
    required this.avoidance,
  });

  Map<String, dynamic> toJson() => {
    'todayAction': todayAction,
    'reflectionQuestion': reflectionQuestion,
    'weeklyFocus': weeklyFocus,
    'avoidance': avoidance,
  };

  factory PracticalGuidance.fromJson(Map<String, dynamic> json) =>
      PracticalGuidance(
        todayAction: json['todayAction'],
        reflectionQuestion: json['reflectionQuestion'],
        weeklyFocus: json['weeklyFocus'],
        avoidance: json['avoidance'],
      );
}

/// Paylaşılabilir kart
class ShareableCard {
  final String emoji;
  final String quote;
  final String category;

  const ShareableCard({
    required this.emoji,
    required this.quote,
    required this.category,
  });

  String get fullShareText => '$emoji "$quote" — Rüya Yorumu | venusone.com';

  Map<String, dynamic> toJson() => {
    'emoji': emoji,
    'quote': quote,
    'category': category,
  };

  factory ShareableCard.fromJson(Map<String, dynamic> json) => ShareableCard(
    emoji: json['emoji'],
    quote: json['quote'],
    category: json['category'],
  );
}

/// Keşif linki
class DreamExplorationLink {
  final String title;
  final String description;
  final String route;
  final String emoji;
  final String category;

  const DreamExplorationLink({
    required this.title,
    required this.description,
    required this.route,
    required this.emoji,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'route': route,
    'emoji': emoji,
    'category': category,
  };

  factory DreamExplorationLink.fromJson(Map<String, dynamic> json) =>
      DreamExplorationLink(
        title: json['title'],
        description: json['description'],
        route: json['route'],
        emoji: json['emoji'],
        category: json['category'],
      );
}

// ════════════════════════════════════════════════════════════════
// TAM RÜYA YORUMU
// ════════════════════════════════════════════════════════════════

/// Tam rüya yorumu modeli
class FullDreamInterpretation {
  final String dreamId;
  final String oderId;
  final String dreamText;
  final DateTime interpretedAt;

  // 1. Kadim Giriş
  final String ancientIntro;

  // 2. Ana Mesaj
  final String coreMessage;

  // 3. Sembol Analizi
  final List<SymbolInterpretation> symbols;

  // 4. Arketip Bağlantısı
  final String archetypeConnection;
  final String archetypeName;

  // 5. Duygusal Okuma
  final EmotionalReading emotionalReading;

  // 6. Astrolojik Zamanlama
  final AstroTiming astroTiming;

  // 7. Işık/Gölge
  final LightShadowReading lightShadow;

  // 8. Pratik Rehberlik
  final PracticalGuidance guidance;

  // 9. Fısıldayan Cümle
  final String whisperQuote;

  // 10. Viral Kart
  final ShareableCard shareCard;

  // 11. Keşfet Linkleri
  final List<DreamExplorationLink> explorationLinks;

  // Meta
  final DreamRole? userRole;
  final TimeLayer? timeLayer;
  final bool isRecurring;
  final int? recurringCount;

  // Yeni: Gelişmiş analiz alanları
  final String? recurringPattern; // Tekrarlayan rüya kalıbı adı
  final String? nightmareType; // Kâbus tipi (varsa)
  final String? lucidPotential; // Lucid rüya potansiyeli

  const FullDreamInterpretation({
    required this.dreamId,
    required this.oderId,
    required this.dreamText,
    required this.interpretedAt,
    required this.ancientIntro,
    required this.coreMessage,
    required this.symbols,
    required this.archetypeConnection,
    required this.archetypeName,
    required this.emotionalReading,
    required this.astroTiming,
    required this.lightShadow,
    required this.guidance,
    required this.whisperQuote,
    required this.shareCard,
    required this.explorationLinks,
    this.userRole,
    this.timeLayer,
    this.isRecurring = false,
    this.recurringCount,
    this.recurringPattern,
    this.nightmareType,
    this.lucidPotential,
  });

  Map<String, dynamic> toJson() => {
    'dreamId': dreamId,
    'userId': oderId,
    'dreamText': dreamText,
    'interpretedAt': interpretedAt.toIso8601String(),
    'ancientIntro': ancientIntro,
    'coreMessage': coreMessage,
    'symbols': symbols.map((s) => s.toJson()).toList(),
    'archetypeConnection': archetypeConnection,
    'archetypeName': archetypeName,
    'emotionalReading': emotionalReading.toJson(),
    'astroTiming': astroTiming.toJson(),
    'lightShadow': lightShadow.toJson(),
    'guidance': guidance.toJson(),
    'whisperQuote': whisperQuote,
    'shareCard': shareCard.toJson(),
    'explorationLinks': explorationLinks.map((l) => l.toJson()).toList(),
    'userRole': userRole?.name,
    'timeLayer': timeLayer?.name,
    'isRecurring': isRecurring,
    'recurringCount': recurringCount,
    'recurringPattern': recurringPattern,
    'nightmareType': nightmareType,
    'lucidPotential': lucidPotential,
  };

  factory FullDreamInterpretation.fromJson(Map<String, dynamic> json) =>
      FullDreamInterpretation(
        dreamId: json['dreamId'],
        oderId: json['userId'],
        dreamText: json['dreamText'],
        interpretedAt: DateTime.parse(json['interpretedAt']),
        ancientIntro: json['ancientIntro'],
        coreMessage: json['coreMessage'],
        symbols: (json['symbols'] as List)
            .map((s) => SymbolInterpretation.fromJson(s))
            .toList(),
        archetypeConnection: json['archetypeConnection'],
        archetypeName: json['archetypeName'],
        emotionalReading: EmotionalReading.fromJson(json['emotionalReading']),
        astroTiming: AstroTiming.fromJson(json['astroTiming']),
        lightShadow: LightShadowReading.fromJson(json['lightShadow']),
        guidance: PracticalGuidance.fromJson(json['guidance']),
        whisperQuote: json['whisperQuote'],
        shareCard: ShareableCard.fromJson(json['shareCard']),
        explorationLinks: (json['explorationLinks'] as List)
            .map((l) => DreamExplorationLink.fromJson(l))
            .toList(),
        userRole: json['userRole'] != null
            ? DreamRole.values.firstWhere((e) => e.name == json['userRole'])
            : null,
        timeLayer: json['timeLayer'] != null
            ? TimeLayer.values.firstWhere((e) => e.name == json['timeLayer'])
            : null,
        isRecurring: json['isRecurring'] ?? false,
        recurringCount: json['recurringCount'],
        recurringPattern: json['recurringPattern'],
        nightmareType: json['nightmareType'],
        lucidPotential: json['lucidPotential'],
      );
}

// ════════════════════════════════════════════════════════════════
// KULLANICI GİRİŞİ
// ════════════════════════════════════════════════════════════════

/// Kullanıcının rüya girişi
class DreamInput {
  final String dreamDescription;
  final List<String>? mainSymbols;
  final EmotionalTone? dominantEmotion;
  final String? wakingFeeling;
  final bool isRecurring;
  final int? recurringCount;
  final DateTime? birthDate;
  final String? currentLifeSituation;
  final DreamRole? perceivedRole;

  const DreamInput({
    required this.dreamDescription,
    this.mainSymbols,
    this.dominantEmotion,
    this.wakingFeeling,
    this.isRecurring = false,
    this.recurringCount,
    this.birthDate,
    this.currentLifeSituation,
    this.perceivedRole,
  });

  Map<String, dynamic> toJson() => {
    'dreamDescription': dreamDescription,
    'mainSymbols': mainSymbols,
    'dominantEmotion': dominantEmotion?.name,
    'wakingFeeling': wakingFeeling,
    'isRecurring': isRecurring,
    'recurringCount': recurringCount,
    'birthDate': birthDate?.toIso8601String(),
    'currentLifeSituation': currentLifeSituation,
    'perceivedRole': perceivedRole?.name,
  };
}

// ════════════════════════════════════════════════════════════════
// TEKRAR EDEN RÜYA ANALİZİ
// ════════════════════════════════════════════════════════════════

/// Tekrar eden rüya analizi
class RecurringDreamAnalysis {
  final String patternTitle;
  final String patternDescription;
  final String cycleMessage;
  final String breakingPoint;
  final String actionRequired;
  final int occurrenceCount;
  final List<String> commonSymbols;
  final String evolutionNote;

  const RecurringDreamAnalysis({
    required this.patternTitle,
    required this.patternDescription,
    required this.cycleMessage,
    required this.breakingPoint,
    required this.actionRequired,
    required this.occurrenceCount,
    required this.commonSymbols,
    required this.evolutionNote,
  });
}

// ════════════════════════════════════════════════════════════════
// KÂBUS DÖNÜŞÜM ANALİZİ
// ════════════════════════════════════════════════════════════════

/// Kâbus dönüşüm analizi (korkunç ama dönüştürücü rüyalar)
class NightmareTransformation {
  final String fearSource;
  final String shadowElement;
  final String transformationMessage;
  final String integrationPath;
  final String empowermentNote;
  final String safetyReminder;

  const NightmareTransformation({
    required this.fearSource,
    required this.shadowElement,
    required this.transformationMessage,
    required this.integrationPath,
    required this.empowermentNote,
    required this.safetyReminder,
  });
}
