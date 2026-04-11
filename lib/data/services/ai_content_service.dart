import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/zodiac_sign.dart';
import '../content/cosmic_messages_content.dart';
import 'analytics_service.dart';

/// AI-powered content generation service
/// Supports OpenAI, Anthropic, or falls back to local generation
class AiContentService {
  static const String _openAiBaseUrl = 'https://api.openai.com/v1';
  static const String _anthropicBaseUrl = 'https://api.anthropic.com/v1';

  // API keys - loaded from secure storage or environment
  String? _openAiApiKey;
  String? _anthropicApiKey;

  // Analytics
  AnalyticsService? _analytics;

  // Cache for generated content
  final Map<String, _CachedContent> _cache = {};
  static const Duration _cacheDuration = Duration(hours: 1);

  // Singleton pattern
  static final AiContentService _instance = AiContentService._internal();
  factory AiContentService() => _instance;
  AiContentService._internal();

  /// Initialize with API keys from secure storage
  Future<void> initialize({AnalyticsService? analytics}) async {
    _analytics = analytics;

    try {
      final prefs = await SharedPreferences.getInstance();
      _openAiApiKey = prefs.getString('openai_api_key');
      _anthropicApiKey = prefs.getString('anthropic_api_key');

      // You can also load from environment in debug mode
      // _openAiApiKey ??= const String.fromEnvironment('OPENAI_API_KEY');
      // _anthropicApiKey ??= const String.fromEnvironment('ANTHROPIC_API_KEY');

      if (kDebugMode) {
        debugPrint(
          'AiContentService: Initialized (AI available: $isAiAvailable)',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AiContentService: Initialization error - $e');
      }
    }
  }

  /// Set API keys programmatically (for settings screen)
  Future<void> setApiKeys({String? openAiKey, String? anthropicKey}) async {
    _openAiApiKey = openAiKey;
    _anthropicApiKey = anthropicKey;

    final prefs = await SharedPreferences.getInstance();
    if (openAiKey != null) {
      await prefs.setString('openai_api_key', openAiKey);
    } else {
      await prefs.remove('openai_api_key');
    }

    if (anthropicKey != null) {
      await prefs.setString('anthropic_api_key', anthropicKey);
    } else {
      await prefs.remove('anthropic_api_key');
    }
  }

  /// Check if AI is available
  bool get isAiAvailable =>
      (_openAiApiKey?.isNotEmpty ?? false) ||
      (_anthropicApiKey?.isNotEmpty ?? false);

  /// Generate personalized daily horoscope
  Future<PersonalizedHoroscope> generatePersonalizedHoroscope({
    required ZodiacSign sunSign,
    ZodiacSign? moonSign,
    ZodiacSign? risingSign,
    DateTime? birthDate,
    String? currentMoonPhase,
  }) async {
    final cacheKey = 'horoscope_${sunSign.name}_${DateTime.now().day}';

    // Check cache first
    if (_cache.containsKey(cacheKey) && !_cache[cacheKey]!.isExpired) {
      return _cache[cacheKey]!.content as PersonalizedHoroscope;
    }

    // Try AI generation first
    if (isAiAvailable) {
      try {
        final prompt = _buildHoroscopePrompt(
          sunSign: sunSign,
          moonSign: moonSign,
          risingSign: risingSign,
          birthDate: birthDate,
          currentMoonPhase: currentMoonPhase,
        );

        final response = await _generateWithAi(prompt);
        if (response != null) {
          final horoscope = _parseHoroscopeResponse(response, sunSign);
          _cache[cacheKey] = _CachedContent(horoscope);
          _analytics?.logEvent('ai_horoscope_generated', {
            'sign': sunSign.name,
          });
          return horoscope;
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('AiContentService: AI generation failed - $e');
        }
        _analytics?.logError('ai_generation', e.toString());
      }
    }

    // Fallback to local generation
    final localHoroscope = _generateLocalHoroscope(
      sunSign: sunSign,
      moonSign: moonSign,
      risingSign: risingSign,
    );
    _cache[cacheKey] = _CachedContent(localHoroscope);
    return localHoroscope;
  }

  /// Generate personalized cosmic message
  Future<String> generateCosmicMessage({
    required ZodiacSign sign,
    String? userName,
    String? mood,
  }) async {
    if (isAiAvailable && userName != null) {
      try {
        final prompt =
            '''
Kullanici icin kisa, ilham verici bir kozmik mesaj yaz.
Isim: $userName
Burc: ${sign.nameTr}
${mood != null ? 'Ruh hali: $mood' : ''}

Mesaj 2-3 cumle olsun, mistik ve motive edici bir tonda yaz.
Turkce yaz, emoji kullanma.
''';

        final response = await _generateWithAi(prompt);
        if (response != null && response.isNotEmpty) {
          _analytics?.logEvent('ai_cosmic_message_generated', {
            'sign': sign.name,
          });
          return response;
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('AiContentService: Cosmic message generation failed - $e');
        }
      }
    }

    return CosmicMessagesContent.getDailyCosmicMessage(sign);
  }

  /// Generate personalized advice for specific area
  Future<String> generatePersonalizedAdvice({
    required ZodiacSign sign,
    required AdviceArea area,
    String? context,
  }) async {
    if (isAiAvailable) {
      try {
        final areaName = _getAreaName(area);
        final prompt =
            '''
${sign.nameTr} burcu icin $areaName konusunda kisa bir tavsiye yaz.
${context != null ? 'Baglam: $context' : ''}

2-3 cumle olsun, pozitif ve destekleyici bir tonda.
Turkce yaz, astrolojik kavramlari basit tut.
''';

        final response = await _generateWithAi(prompt);
        if (response != null && response.isNotEmpty) {
          _analytics?.logEvent('ai_advice_generated', {
            'sign': sign.name,
            'area': area.name,
          });
          return response;
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('AiContentService: Advice generation failed - $e');
        }
      }
    }

    return _getLocalAdvice(sign, area);
  }

  /// Generate daily affirmation
  Future<String> generateAffirmation({
    required ZodiacSign sign,
    String? focus,
  }) async {
    if (isAiAvailable) {
      try {
        final prompt =
            '''
${sign.nameTr} burcu icin guclu bir gunluk olumlamac yaz.
${focus != null ? 'Odak: $focus' : ''}

"Bugun..." ile baslasin, kisa ve guclu olsun (1 cumle).
Turkce yaz.
''';

        final response = await _generateWithAi(prompt);
        if (response != null && response.isNotEmpty) {
          return response;
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('AiContentService: Affirmation generation failed - $e');
        }
      }
    }

    return CosmicMessagesContent.getMorningAffirmation(sign);
  }

  /// Clear cached content
  void clearCache() {
    _cache.clear();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DREAM INTERPRETATION - APEX DREAM INTELLIGENCE ENGINE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Start dream interpretation session - Step 1: Acknowledge symbol
  Future<DreamInterpretationSession> startDreamInterpretation({
    required String dreamDescription,
    ZodiacSign? userSign,
  }) async {
    // Extract main symbol from dream
    final symbol = _extractDreamSymbol(dreamDescription);

    // Generate context questions based on symbol
    final questions = _generateContextQuestions(symbol, dreamDescription);

    // Create session
    final session = DreamInterpretationSession(
      dreamSymbol: symbol,
      contextQuestions: questions,
      state: DreamConversationState.awaitingContext,
    );

    _analytics?.logEvent('dream_interpretation_started', {
      'symbol': symbol,
      'has_sign': userSign != null ? 'true' : 'false',
    });

    return session;
  }

  /// Get acknowledgment message for the dream symbol
  String getDreamAcknowledgment(String symbol) {
    final acknowledgments =
        _dreamSymbolAcknowledgments[symbol.toLowerCase()] ??
        'Bu sembol ruyalarinda onemli bir mesaj tasiyor olabilir.';
    return acknowledgments;
  }

  /// Interpret dream with context - Step 3 & 4: Conditional interpretation
  Future<DreamInterpretationSession> interpretDream({
    required DreamInterpretationSession session,
    required Map<String, String> contextAnswers,
    ZodiacSign? userSign,
  }) async {
    // Update session with answers
    var updatedSession = session.copyWith(contextAnswers: contextAnswers);

    String interpretation;

    if (isAiAvailable) {
      try {
        final prompt = _buildDreamInterpretationPrompt(
          symbol: session.dreamSymbol,
          contextAnswers: contextAnswers,
          userSign: userSign,
        );

        final response = await _generateWithAi(prompt);
        if (response != null && response.isNotEmpty) {
          // APEX FAIL CONDITION CHECK - Validate AI response
          if (_validateDreamInterpretation(response)) {
            interpretation = response;
            _analytics?.logEvent('dream_ai_interpreted', {
              'symbol': session.dreamSymbol,
              'has_sign': userSign != null ? 'true' : 'false',
            });
          } else {
            // AI response failed validation, use local fallback
            if (kDebugMode) {
              debugPrint(
                'Dream interpretation AI response failed APEX validation',
              );
            }
            interpretation = _generateLocalDreamInterpretation(
              symbol: session.dreamSymbol,
              contextAnswers: contextAnswers,
              userSign: userSign,
            );
            _analytics?.logEvent('dream_ai_validation_failed', {
              'symbol': session.dreamSymbol,
            });
          }
        } else {
          interpretation = _generateLocalDreamInterpretation(
            symbol: session.dreamSymbol,
            contextAnswers: contextAnswers,
            userSign: userSign,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Dream interpretation AI failed: $e');
        }
        interpretation = _generateLocalDreamInterpretation(
          symbol: session.dreamSymbol,
          contextAnswers: contextAnswers,
          userSign: userSign,
        );
      }
    } else {
      interpretation = _generateLocalDreamInterpretation(
        symbol: session.dreamSymbol,
        contextAnswers: contextAnswers,
        userSign: userSign,
      );
    }

    return updatedSession.copyWith(
      interpretation: interpretation,
      state: DreamConversationState.interpreted,
    );
  }

  /// APEX FAIL CONDITIONS - Validate dream interpretation
  /// Returns false if interpretation violates core APEX rules
  bool _validateDreamInterpretation(String interpretation) {
    final lowerInterpretation = interpretation.toLowerCase();
    final firstParagraph = interpretation.split('\n').first.toLowerCase();

    // FAIL CONDITION 1: Starts with zodiac/astrology
    final zodiacStarters = [
      'burc',
      'burç',
      'koc',
      'koç',
      'boga',
      'boğa',
      'ikizler',
      'yengec',
      'yengeç',
      'aslan',
      'basak',
      'başak',
      'terazi',
      'akrep',
      'yay',
      'oglak',
      'oğlak',
      'kova',
      'balik',
      'balık',
      'astroloji',
      'zodyak',
      'gezegen',
      'mars',
      'venus',
      'merkur',
      'merkür',
      'jupiter',
      'saturn',
      'satürn',
      'neptun',
      'neptün',
      'uranüs',
      'pluto',
      'pluton',
    ];

    for (final starter in zodiacStarters) {
      if (firstParagraph.contains(starter)) {
        if (kDebugMode) {
          debugPrint(
            'APEX FAIL: Interpretation starts with zodiac term: $starter',
          );
        }
        return false;
      }
    }

    // FAIL CONDITION 2: Sounds like horoscope text
    final horoscopePhrases = [
      'bugunun enerjisi',
      'günün enerjisi',
      'yildizlar sana',
      'yıldızlar sana',
      'kozmik enerji',
      'evren sana',
      'gezegenlerin etkileri',
      'astrolojik acidan',
      'astrolojik açıdan',
    ];

    for (final phrase in horoscopePhrases) {
      if (firstParagraph.contains(phrase)) {
        if (kDebugMode) {
          debugPrint(
            'APEX FAIL: Interpretation sounds like horoscope: $phrase',
          );
        }
        return false;
      }
    }

    // FAIL CONDITION 3: Contains definitive/certain language (should use possibility language)
    final certaintyPhrases = [
      'kesinlikle',
      'mutlaka',
      'su anlama gelir',
      'şu anlama gelir',
      'demek ki',
      'olmali',
      'olmalı',
      'yapman gerekir',
      'yapmalısın',
    ];

    int certaintyCount = 0;
    for (final phrase in certaintyPhrases) {
      if (lowerInterpretation.contains(phrase)) {
        certaintyCount++;
      }
    }
    // Allow max 1 certainty phrase
    if (certaintyCount > 1) {
      if (kDebugMode) {
        debugPrint(
          'APEX FAIL: Too much certainty language ($certaintyCount instances)',
        );
      }
      return false;
    }

    // FAIL CONDITION 4: Too short (less than 300 characters = likely generic)
    if (interpretation.length < 300) {
      if (kDebugMode) {
        debugPrint(
          'APEX FAIL: Interpretation too short (${interpretation.length} chars)',
        );
      }
      return false;
    }

    // FAIL CONDITION 5: Contains advice/commands (should be reflective)
    final advicePhrases = [
      'sunu yap',
      'şunu yap',
      'bunu yap',
      'yapmalisin',
      'yapmalısın',
      'git ve',
      'hemen',
      'derhal',
    ];

    for (final phrase in advicePhrases) {
      if (lowerInterpretation.contains(phrase)) {
        if (kDebugMode) {
          debugPrint('APEX FAIL: Contains direct advice: $phrase');
        }
        return false;
      }
    }

    return true;
  }

  /// Extract main symbol from dream description
  String _extractDreamSymbol(String dreamDescription) {
    final lowerDesc = dreamDescription.toLowerCase();

    // Common dream symbols in Turkish
    final symbols = {
      'yilan': ['yilan', 'yılan', 'kobra', 'boa', 'engerek'],
      'su': [
        'su',
        'deniz',
        'okyanus',
        'göl',
        'gol',
        'nehir',
        'irmak',
        'sel',
        'bogulma',
        'boğulma',
      ],
      'ucmak': [
        'ucmak',
        'uçmak',
        'ucuyorum',
        'uçuyorum',
        'havada',
        'gokyuzu',
        'gökyüzü',
      ],
      'dusmek': [
        'dusmek',
        'düşmek',
        'dusuyorum',
        'düşüyorum',
        'yuksekten',
        'yüksekten',
      ],
      'dis': [
        'dis',
        'diş',
        'disler',
        'dişler',
        'dis dokulmesi',
        'diş dökülmesi',
      ],
      'olum': [
        'olum',
        'ölüm',
        'olu',
        'ölü',
        'cenaze',
        'mezar',
        'oluyorum',
        'ölüyorum',
      ],
      'kovalanmak': [
        'kovalanmak',
        'kovaliyor',
        'kovalıyor',
        'kaciyorum',
        'kaçıyorum',
        'kacmak',
        'kaçmak',
      ],
      'bebek': ['bebek', 'cocuk', 'çocuk', 'hamile', 'dogum', 'doğum'],
      'ev': ['ev', 'oda', 'bina', 'apartman', 'kapi', 'kapı', 'pencere'],
      'araba': ['araba', 'arac', 'araç', 'surmek', 'sürmek', 'kaza', 'trafik'],
      'kopek': [
        'kopek',
        'köpek',
        'it',
        'havliyor',
        'havlıyor',
        'isiriyor',
        'ısırıyor',
      ],
      'kedi': ['kedi', 'miyavliyor', 'miyavlıyor', 'tirmaladi', 'tırmaladı'],
      'para': ['para', 'altin', 'altın', 'zenginlik', 'piyango', 'bulmak'],
      'sinav': [
        'sinav',
        'sınav',
        'okul',
        'test',
        'basarisizlik',
        'başarısızlık',
      ],
      'ciplaklık': ['ciplak', 'çıplak', 'utanc', 'utanç', 'mahcup'],
      'kaybolmak': [
        'kaybolmak',
        'kayip',
        'kayıp',
        'bulamiyorum',
        'bulamıyorum',
        'yolumu',
      ],
      'ates': [
        'ates',
        'ateş',
        'yangin',
        'yangın',
        'alev',
        'yaniyor',
        'yanıyor',
      ],
      'kan': ['kan', 'kanama', 'yarali', 'yaralı', 'yara'],
      'gelin': ['gelin', 'dugun', 'düğün', 'evlilik', 'nikah'],
      'hastalik': ['hasta', 'hastalik', 'hastalık', 'doktor', 'hastane'],
    };

    for (final entry in symbols.entries) {
      for (final keyword in entry.value) {
        if (lowerDesc.contains(keyword)) {
          return entry.key;
        }
      }
    }

    // If no specific symbol found, return generic
    return 'genel';
  }

  /// Generate context questions based on dream symbol
  List<String> _generateContextQuestions(
    String symbol,
    String dreamDescription,
  ) {
    final questions =
        _dreamContextQuestions[symbol] ??
        [
          'Ruyada nasil bir duygu hissettin?',
          'Ortam nasil gorunuyordu?',
          'Ruyada baska kimler vardi?',
        ];

    // Return max 3 questions
    return questions.take(3).toList();
  }

  /// Build AI prompt for dream interpretation - APEX MASTER STRUCTURE
  String _buildDreamInterpretationPrompt({
    required String symbol,
    required Map<String, String> contextAnswers,
    ZodiacSign? userSign,
  }) {
    final contextText = contextAnswers.entries
        .map((e) => '- ${e.key}\n  Cevap: ${e.value}')
        .join('\n\n');

    return '''
ROL: Elite Dream Intelligence Architect ve Symbolic Psychologist.

YAPMA:
- Burc/astroloji ile BASLAMAK
- Bagnam olmadan yorum yapmak
- Tavsiye veya ongoruler vermek
- Ruya sozlukleri veya kliseler kullanmak
- Mistik veya genel gececer seyler soylemek
- Kesin ifadeler kullanmak

YAP:
- Sembollerden basla
- Kosullu (EGER/OLABILIR/ISARET EDEBILIR) yorumla
- Ruyaciyi merkeze al
- Surecsel yaklasim benimse (mesaj degil, sürec)

RUYA SEMBOLU: $symbol

KULLANICIDAN ALINAN BAGLAM:
$contextText

═══════════════════════════════════════════════════════════════
ZORUNLU 8 BOLUMLU YORUM YAPISI (Bu sirayla yaz):
═══════════════════════════════════════════════════════════════

1) RUYA YENIDEN OLUSTURMA
   - Ruyayi tarafsiz ve doğru bir sekilde ozetle (1-2 cumle)

2) DUYGUSAL AGIRLIK MERKEZI
   - Duygusal agirligin nerede yogunlastigini belirt
   - Ornegin: "Ruyada en yogun nokta... gibi gorunuyor"

3) SEMBOL DINAMIKLERI
   - Sembollerin nasıl etkilestigini analiz et
   - Hareket, gerilim, yakinlik

4) RUYACI POZISYONU
   - Gozlemci / katilimci / kacan / yuozlesen
   - "Ruyada sen... pozisyonundaydin"

5) ORUNTU VE ZAMANLAMA
   - Bu ruya: baslangic / gecis / cozumsuz mu?
   - Tek basina mi yoksa seri icinde mi?

6) YASAM-DUNYA REZONANSI
   - Uyanik hayattaki olasi yansimalar (sadece hipotez)
   - "Bu ruya, gercek hayatinda... ile rezonans yapiyor olabilir"

7) ENTEGRASYON ODAGI
   - Ruyanin ruyacıdan FARK ETMESINI istedigi sey
   - "Bu ruya senden... fark etmeni istiyor olabilir"

8) YANSITICI SORULAR (maksimum 3)
   - Ruyaciyi dusunmeye davet eden sorular
   - Tavsiye degil, soru formunda

═══════════════════════════════════════════════════════════════

${userSign != null ? '''
ASTROLOJIK NOT (SADECE EN SONDA, OPSIYONEL):
Kullanicinin burcu: ${userSign.nameTr}
- Astroloji sadece RENK KATAR, anlam vermez
- Yorum ZATEN tamalandiktan sonra, eger istersen kisa bir not ekle
- Format: "Eger istersen, ${userSign.nameTr} enerjisi acisindan bu ruya... olarak da okunabilir."
''' : ''}

CIKTI KURALLARI:
- Dogal Turkce
- Sakin, topraklanmis, insan tonu
- Olasilik dili (olabilir, cagristirabilir, isaret edebilir)
- Kisa paragraflar
- Emoji YOK
- Mistik klise YOK
- Her ruyaya uyan genel yorum YOK
''';
  }

  /// Generate local dream interpretation (fallback) - APEX 8-PART MASTER STRUCTURE
  String _generateLocalDreamInterpretation({
    required String symbol,
    required Map<String, String> contextAnswers,
    ZodiacSign? userSign,
  }) {
    final interpretations = _localDreamInterpretations[symbol];
    if (interpretations == null) {
      return _getGenericDreamInterpretation(contextAnswers, userSign);
    }

    final buffer = StringBuffer();

    // Analyze context answers for conditional interpretation
    final allAnswers = contextAnswers.values.join(' ').toLowerCase();
    final emotionType = _detectEmotionType(allAnswers);
    final positionType = _detectDreamerPosition(allAnswers);

    // 1) RUYA YENIDEN OLUSTURMA
    buffer.writeln('RUYANIN OZETI');
    buffer.writeln(
      interpretations['reconstruction'] ??
          'Bu ruyada $symbol sembolu merkezi bir rol oynuyor.',
    );
    buffer.writeln();

    // 2) DUYGUSAL AGIRLIK MERKEZI
    buffer.writeln('DUYGUSAL AGIRLIK');
    if (emotionType == 'fearful') {
      buffer.writeln(
        interpretations['emotionalCenter_fear'] ??
            'Ruyada duygusal agirlik korku veya gerilim etrfinda toplanmis gorunuyor.',
      );
    } else if (emotionType == 'peaceful') {
      buffer.writeln(
        interpretations['emotionalCenter_peace'] ??
            'Ruyada duygusal agirlik huzur ve kabul etrafinda toplanmis gorunuyor.',
      );
    } else if (emotionType == 'curious') {
      buffer.writeln(
        interpretations['emotionalCenter_curiosity'] ??
            'Ruyada duygusal agirlik merak ve kesif etrafinda toplanmis gorunuyor.',
      );
    } else {
      buffer.writeln(
        interpretations['emotionalCenter_neutral'] ??
            'Ruyada duygusal ton belirsiz veya karisik gorunuyor.',
      );
    }
    buffer.writeln();

    // 3) SEMBOL DINAMIKLERI
    buffer.writeln('SEMBOL DINAMIGI');
    buffer.writeln(
      interpretations['symbolDynamics'] ??
          'Bu sembol, ic dunya ile dis dunya arasindaki bir dinamigi temsil ediyor olabilir.',
    );
    buffer.writeln();

    // 4) RUYACI POZISYONU
    buffer.writeln('SENIN POZISYONUN');
    if (positionType == 'observer') {
      buffer.writeln(
        interpretations['position_observer'] ??
            'Ruyada gozlemci pozisyonundaydin - olaylari disaridan izliyordun.',
      );
    } else if (positionType == 'participant') {
      buffer.writeln(
        interpretations['position_participant'] ??
            'Ruyada aktif katilimci pozisyonundaydin - olaylara dahildin.',
      );
    } else if (positionType == 'escaping') {
      buffer.writeln(
        interpretations['position_escaping'] ??
            'Ruyada kacan pozisyonundaydin - bir seyden uzaklasiyordun.',
      );
    } else if (positionType == 'confronting') {
      buffer.writeln(
        interpretations['position_confronting'] ??
            'Ruyada yuzlesen pozisyonundaydin - bir seyle karsi karsiyaydin.',
      );
    } else {
      buffer.writeln(
        interpretations['position_neutral'] ??
            'Ruyada pozisyonun belirsiz veya degisen bir yapida.',
      );
    }
    buffer.writeln();

    // 5) ORUNTU VE ZAMANLAMA
    buffer.writeln('ORUNTU VE ZAMANLAMA');
    buffer.writeln(
      interpretations['timing'] ??
          'Bu ruya, bir gecis donemini veya islenmekte olan bir sureci yansıtıyor olabilir.',
    );
    buffer.writeln();

    // 6) YASAM-DUNYA REZONANSI (Conditional)
    buffer.writeln('OLASI YASAM YANSIMASI');
    if (emotionType == 'fearful') {
      buffer.writeln(
        interpretations['lifeResonance_fear'] ??
            'Bu ruya, gercek hayatinda kontrol kaybi veya belirsizlikle ilgili bir durumla rezonans yapiyor olabilir.',
      );
    } else if (emotionType == 'peaceful') {
      buffer.writeln(
        interpretations['lifeResonance_peace'] ??
            'Bu ruya, hayatinda bir kabul veya birakma sureciyle rezonans yapiyor olabilir.',
      );
    } else {
      buffer.writeln(
        interpretations['lifeResonance_neutral'] ??
            'Bu ruya, hayatinda dikkat bekleyen bir alanla rezonans yapiyor olabilir.',
      );
    }
    buffer.writeln();

    // 7) ENTEGRASYON ODAGI
    buffer.writeln('ENTEGRASYON ODAGI');
    buffer.writeln(
      interpretations['integration'] ??
          'Bu ruya, senden bir seyi fark etmeni veya kabul etmeni istiyor olabilir.',
    );
    buffer.writeln();

    // 8) YANSITICI SORULAR
    buffer.writeln('YANSITICI SORULAR');
    final questions =
        interpretations['questions']?.split('|') ??
        [
          'Bu sembol senin icin kisisel olarak ne ifade ediyor?',
          'Son zamanlarda benzer duygular yasadigin bir durum var mi?',
          'Ruyadaki bu enerjiyi nerede hissediyorsun?',
        ];
    for (final q in questions.take(3)) {
      buffer.writeln('- $q');
    }

    // Optional astrological note - ONLY AT THE END
    if (userSign != null) {
      buffer.writeln();
      buffer.writeln('---');
      buffer.writeln(_getAstrologicalDreamNote(symbol, userSign));
    }

    return buffer.toString().trim();
  }

  /// Detect emotion type from context answers
  String _detectEmotionType(String allAnswers) {
    if (allAnswers.contains('korku') ||
        allAnswers.contains('endise') ||
        allAnswers.contains('panik') ||
        allAnswers.contains('korkutucu') ||
        allAnswers.contains('tehdit')) {
      return 'fearful';
    } else if (allAnswers.contains('huzur') ||
        allAnswers.contains('sakin') ||
        allAnswers.contains('rahat') ||
        allAnswers.contains('ozgur')) {
      return 'peaceful';
    } else if (allAnswers.contains('merak') ||
        allAnswers.contains('ilginc') ||
        allAnswers.contains('saskin')) {
      return 'curious';
    }
    return 'neutral';
  }

  /// Detect dreamer position from context answers
  String _detectDreamerPosition(String allAnswers) {
    if (allAnswers.contains('izliyordum') ||
        allAnswers.contains('gozlem') ||
        allAnswers.contains('disaridan')) {
      return 'observer';
    } else if (allAnswers.contains('kaciyordum') ||
        allAnswers.contains('kacti') ||
        allAnswers.contains('uzaklasiyordum')) {
      return 'escaping';
    } else if (allAnswers.contains('yuzles') ||
        allAnswers.contains('karsi') ||
        allAnswers.contains('durdum')) {
      return 'confronting';
    } else if (allAnswers.contains('icinde') ||
        allAnswers.contains('yapiyordum') ||
        allAnswers.contains('suruyordum')) {
      return 'participant';
    }
    return 'neutral';
  }

  String _getGenericDreamInterpretation(
    Map<String, String> contextAnswers,
    ZodiacSign? userSign,
  ) {
    final allAnswers = contextAnswers.values.join(' ').toLowerCase();
    final emotionType = _detectEmotionType(allAnswers);

    final buffer = StringBuffer();

    buffer.writeln('RUYANIN OZETI');
    buffer.writeln('Bu ruyada onemli bir sembol veya deneyim var.');
    buffer.writeln();

    buffer.writeln('DUYGUSAL AGIRLIK');
    if (emotionType == 'fearful') {
      buffer.writeln('Ruyada duygusal ton gergin veya endiseli gorunuyor.');
    } else if (emotionType == 'peaceful') {
      buffer.writeln('Ruyada duygusal ton huzurlu ve kabul edici gorunuyor.');
    } else {
      buffer.writeln('Ruyada duygusal ton belirsiz veya karisik gorunuyor.');
    }
    buffer.writeln();

    buffer.writeln('SEMBOL DINAMIGI');
    buffer.writeln(
      'Her ruya sembolu kisisel anlam tasir. Onemli olan, bu sembolun senin icin ne ifade ettigini kesfetmektir.',
    );
    buffer.writeln();

    buffer.writeln('OLASI YASAM YANSIMASI');
    buffer.writeln(
      'Bu ruya, su anki hayat doneminde dikkat etmen gereken bir konuya isaret ediyor olabilir.',
    );
    buffer.writeln();

    buffer.writeln('ENTEGRASYON ODAGI');
    buffer.writeln(
      'Ruyada hissettigin duygular, gercek hayattaki bir duruma nasil tepki verdigini gosteriyor olabilir.',
    );
    buffer.writeln();

    buffer.writeln('YANSITICI SORULAR');
    buffer.writeln('- Bu sembol senin icin kisisel olarak ne ifade ediyor?');
    buffer.writeln(
      '- Son zamanlarda benzer duygular yasadigin bir durum var mi?',
    );
    buffer.writeln('- Ruyadaki bu enerjiyi nerede hissediyorsun?');

    if (userSign != null) {
      buffer.writeln();
      buffer.writeln('---');
      buffer.writeln(
        'Eger istersen, bu ruyanin ${userSign.nameTr} enerjisi acisindan nasil okunabilecegini konusabiliriz.',
      );
    }

    return buffer.toString().trim();
  }

  String _getAstrologicalDreamNote(String symbol, ZodiacSign sign) {
    final notes = {
      'yilan': {
        ZodiacSign.scorpio:
            'Akrep burcu olarak yilan sembolu, dogal donusum gucunle derin bir rezonans tasir.',
        ZodiacSign.aries:
            'Koc burcunun atesli enerjisi, bu semboldeki meydan okuma yonunu guclendiriyor olabilir.',
      },
      'su': {
        ZodiacSign.pisces:
            'Balik burcu olarak su elementi seninle dogal bir bag kurar. Sezgilerin bu ruya hakkinda sana daha fazlasini soyluyor olabilir.',
        ZodiacSign.cancer:
            'Yengec burcu olarak duygusal derinlik ve su elementi sana cok tanidik gelebilir.',
        ZodiacSign.scorpio:
            'Akrep burcunun derin sulari, bu ruyanin bilincdisi katmanlarini kesfetmene yardimci olabilir.',
      },
      'ates': {
        ZodiacSign.aries:
            'Koc burcunun ates elementi, bu semboldeki enerji ve donusum temalarini guclendiriyor.',
        ZodiacSign.leo:
            'Aslan burcu olarak ates elementi seninle dogal bir bag kurar.',
        ZodiacSign.sagittarius:
            'Yay burcunun ates enerjisi, bu ruyadaki ozgurluk ve donusum temalarini destekliyor olabilir.',
      },
    };

    final symbolNotes = notes[symbol];
    if (symbolNotes != null && symbolNotes.containsKey(sign)) {
      return 'Astrolojik not: ${symbolNotes[sign]}';
    }

    return 'Eger istersen, bu ruyanin ${sign.nameTr} burcuyla olan baglantisini daha detayli inceleyebiliriz.';
  }

  // Dream symbol acknowledgments
  static final Map<String, String> _dreamSymbolAcknowledgments = {
    'yilan':
        'Yilan, ruyalarin en guclu ve cok katmanli sembollerinden biridir. Donusum, sifa, gizli bilgi veya ic tehditler gibi pek cok anlam tasiyabilir.',
    'su':
        'Su, ruyalarda duygusal durumu ve bilincdisini temsil eden evrensel bir semboldur. Suyun hali - durgun, dalgali, temiz veya bulanik - onemli ipuclari tasir.',
    'ucmak':
        'Ucmak, ruyalarda ozgurluk, yuksek hedefler veya gerceklikten kacis gibi temalari isaret edebilen guclu bir deneyimdir.',
    'dusmek':
        'Dusme ruyalari, kontrol kaybetme, guvensizilik veya buyuk bir degisim oncesi hissedilen korkulari yansitabilir.',
    'dis':
        'Dis ruyalari, kayip, degisim, gorunum kaygilari veya iletisim sorunlariyla iliskili olabilir.',
    'olum':
        'Olum ruyalari cogunlukla literal degildir. Donusum, bir donemim sonu veya buyuk bir degisimi simgeleyebilir.',
    'kovalanmak':
        'Kovalanma ruyalari, kacilmaya calisilan duygular, sorumluluklar veya korkulari temsil edebilir.',
    'bebek':
        'Bebek ruyalari, yeni baslangiclari, yaraticilik projelerini veya ic cocugunuzla baglantinizi simgeleyebilir.',
    'ev':
        'Ev, ruyalarda benlik ve ic dunyanin bir yansimasi olarak gorulur. Evin durumu ve odalari farkli yasam alanlarini temsil edebilir.',
    'araba':
        'Araba ruyalari, hayat yolculugunda kontrol, yon ve ilerleme temalarini isaret eder.',
    'kopek':
        'Kopek, sadakat, dostluk veya icgudusel yanlarimizi temsil edebilir. Kopegin davranisi onemli ipuclari tasir.',
    'kedi':
        'Kedi, bagimsizlik, sezgi ve gizemle iliskilidir. Feminen enerji ve ic bilgeligi de simgeleyebilir.',
    'para':
        'Para ruyalari, deger, ozsaygi ve kaynaklara erisim temalarini yansitabilir.',
    'sinav':
        'Sinav ruyalari, performans kaygisi, degerlendirilme korkusu veya yasam testleri hakkinda olabilir.',
    'ciplaklık':
        'Cipkallik ruyalari, savunmasizlik, autentik benligin ifasi veya maskelerden arinma ile iliskilidir.',
    'kaybolmak':
        'Kaybolma ruyalari, hayatta yon kaybetme, kimlik arayisi veya belirsizlik hislerini yansitabilir.',
    'ates':
        'Ates, tutku, ofke, donusum veya arinmayi temsil edebilir. Yanginin kontrollu veya kontrolsuz olmasi onemlidir.',
    'kan':
        'Kan, yasam enerjisi, duygusal yaralar veya aile baglariyla iliskili temaları işaret edebilir.',
    'gelin':
        'Gelin/dugun ruyalari, birlesme, taahhut veya hayatin yeni bir evresine gecisi simgeleyebilir.',
    'hastalik':
        'Hastalik ruyalari, duygusal veya ruhsal dengesizliklere, dikkat edilmesi gereken alanlara isaret edebilir.',
    'genel':
        'Her ruya sembolu kisisel anlam tasir. Onemli olan, bu sembolun senin icin ne ifade ettigini kesfetmektir.',
  };

  // Context questions for each symbol - APEX SYMBOL-SPECIFIC QUESTION SETS
  static final Map<String, List<String>> _dreamContextQuestions = {
    // YILAN - Snake
    'yilan': [
      'Yilan sana dogru mu geliyordu, sadece orada mi duruyordu, yoksa uzaklasiyordu mu?',
      'Hakim duygu neydi? (korku, gerilim, merak, sakinlik)',
      'Ortam kapali miydi (oda/ev) yoksa acik miydi (doga)?',
    ],
    // DUSMEK - Falling
    'dusmek': [
      'Dusus kontrol kaybetme mi yoksa birakma gibi mi hissettirdi?',
      'Yere carptin mi yoksa ortada uyandın mi?',
      'Dusus yuksek miydi yoksa kisa mi?',
    ],
    // KOVALANMAK - Chase
    'kovalanmak': [
      'Seni kovalayan kimdi veya neydi? (net mi, belirsiz mi)',
      'Kacabildin mi yoksa saklanabildin mi?',
      'Hakim duygu neydi? (korku, panik, ofke)',
    ],
    // OLUM - Death
    'olum': [
      'Kim oluyordu ruyada? (sen mi, baskasi mi)',
      'Olum siddetli miydi yoksa huzurlu mu?',
      'Sonrasinda ne hissettin? (rahatlama, korku, bossluk)',
    ],
    // ATES - Fire
    'ates': [
      'Ates kontrollu muydu yoksa yayiliyor muydu?',
      'Isitici miydi yoksa yakici mi?',
      'Gozlemci miydin yoksa mudahale mi ediyordun?',
    ],
    // SU - Water
    'su': [
      'Su nasil gorunuyordu? (temiz, bulanik, dalgali, durgun)',
      'Suyun icinde miydin, disinda mi?',
      'Su hareket halinde miydi yoksa durgun mu?',
    ],
    // UCMAK - Flying
    'ucmak': [
      'Ucmak nasil hissettirdi? (korkutucu, ozgurlestirici)',
      'Kontrol sende miydi yoksa ruzgara mi kapildin?',
      'Ne kadar yuksekte ucuyordun?',
    ],
    // DIS - Teeth
    'dis': [
      'Disler nasil dokuluyordu? (kendilinden, darbe ile, parcalanarak)',
      'Bunu goren veya fark eden baskasi var miydi?',
      'Dokulme sirasinda ne hissettin?',
    ],
    // BEBEK - Baby
    'bebek': [
      'Bebek senin mi yoksa baskasinin miydi?',
      'Bebege nasil davraniyordun? (koruyucu, endiseli, ilgisiz)',
      'Bebegin durumu nasıldi? (mutlu, agliyor, hasta)',
    ],
    // EV - House
    'ev': [
      'Tanidik bir ev miydi yoksa tanimadigin bir yer mi?',
      'Evin hangi bolumundeydin? (oturma odasi, bodrum, cati arasi, koridor)',
      'Ev bakimli miydi yoksa harap mi?',
    ],
    // ARABA - Car
    'araba': [
      'Arabayi sen mi suruyordun?',
      'Arac kontrol altinda miydi?',
      'Nereye gidiyordunuz? (belli bir yer, belirsiz)',
    ],
    // KOPEK - Dog
    'kopek': [
      'Kopek dost canlisi miydi yoksa tehditkar mi?',
      'Tanidik bir kopek miydi?',
      'Kopek sana ne yapiyordu? (havlama, isirma, oynama, takip)',
    ],
    // KEDI - Cat
    'kedi': [
      'Kedi sana yakin miydi yoksa uzakta mi?',
      'Nasil bir tavri vardi? (sevecen, mesafeli, tehditkar)',
      'Kedi ne yapiyordu?',
    ],
    // PARA - Money
    'para': [
      'Para buldun mu, kaybettin mi, yoksa sadece gordun mu?',
      'Ne kadar para vardi? (cok, az, belirsiz)',
      'Parayla ne yaptin veya ne olmasi bekleniyordu?',
    ],
    // SINAV - Exam
    'sinav': [
      'Sinava hazir miydin yoksa habersiz mi yakalandin?',
      'Sorulari cevaplayabildin mi?',
      'Baskasi da sinava giriyor muydu?',
    ],
    // CIPLAKLIK - Nudity
    'ciplaklık': [
      'Ciplakligini baskasi fark etti mi?',
      'Ne hissettin? (utanc, rahatlık, korkku)',
      'Ortamda baska insanlar var miydi?',
    ],
    // KAYBOLMAK - Being Lost
    'kaybolmak': [
      'Tanidik bir yerde mi kaybolddun, yoksa tanimadigin bir yerde mi?',
      'Birisini mi ariyordun, yoksa bir yere mi ulassmaya calisiyordun?',
      'Yol sorabildİn mi veya yardim bulabildin mi?',
    ],
    // KAN - Blood
    'kan': [
      'Kan senden mi akiyordu, baskasından mi?',
      'Bir yara var miydi?',
      'Kan miktari cok muydu, az mi?',
    ],
    // HASTALIK - Illness
    'hastalik': [
      'Sen mi hastaydın, baskasi mi?',
      'Hastalik ciddi miydi yoksa hafif mi?',
      'Tedavi var miydi, iyılesme umudu var miydi?',
    ],
    // GELIN/DUGUN - Wedding
    'gelin': [
      'Dugun senin mi yoksa baskasinin mi?',
      'Mutlu bir toren miydi, yoksa bir sorun mu vardi?',
      'Damadi/gelini tanıyor muydun?',
    ],
    // GENEL - Generic
    'genel': [
      'Ruyada en cok dikkatini ceken sey neydi?',
      'Hakim duygu neydi? (korku, merak, huzur, gerilim)',
      'Ruyadan uyandiginda ne hissettin?',
    ],
  };

  // Local dream interpretations - APEX 8-PART MASTER STRUCTURE
  static final Map<String, Map<String, String>> _localDreamInterpretations = {
    'yilan': {
      'reconstruction': 'Bu ruyada yilan sembolu merkezi bir rol oynuyor.',
      'emotionalCenter_fear':
          'Duygusal agirlik korku ve gerilim etrafinda toplanmis gorunuyor. Yilan, hayatinda tehdit olarak algiladigin bir seyi temsil ediyor olabilir.',
      'emotionalCenter_peace':
          'Duygusal agirlik sakinlik ve kabul etrafinda toplanmis. Yilan burada sifa veya donusum enerjisi tasiyor olabilir.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik merak etrafinda. Yilan, kesfedilmeyi bekleyen gizli bir bilgiyi temsil ediyor olabilir.',
      'emotionalCenter_neutral':
          'Duygusal ton belirsiz. Yilan sembolu, henuz tanimlanmamis bir degisim surecine isaret ediyor olabilir.',
      'symbolDynamics':
          'Yilan, donusum ve yenilenmenin evrensel semboludur. Hareket sekli - sana dogru, uzaga, durgun - onemli ipuclari tasir. Yaklasiyor ise yuzlesme, uzaklasiyorsa kacis temasini isaret edebilir.',
      'position_observer':
          'Gozlemci pozisyonundaydin - bu, durumu disaridan degerlendidigini gosteriyor olabilir.',
      'position_participant':
          'Aktif katilimci pozisyonundaydin - bu donusum sureci seni dogrudan ilgilendiriyor.',
      'position_escaping':
          'Kacan pozisyonundaydin - bu, yuzlesmekten kacindigin bir durumu yansıtıyor olabilir.',
      'position_confronting':
          'Yuzlesen pozisyonundaydin - bu, bir seyle hesaplasma surecinde olduğunu gosteriyor.',
      'position_neutral':
          'Pozisyonun belirsizdi - bu, duruma karsi henuz net bir tutum gelistirmedigini gosteriyor olabilir.',
      'timing':
          'Yilan ruyalari genellikle buyuk degisim ve donusum donemlerinde ortaya cikar. Bu, bir gecis surecinin baslangici, ortasi veya sonu olabilir.',
      'lifeResonance_fear':
          'Bu ruya, hayatinda bastirilan bir korku veya kacinilan bir gercekle rezonans yapiyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, hayatinda dogal bir donusum surecinin saglikli ilerledigini yansıtıyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, hayatinda farkinda olmadan islenmekte olan bir temaya isaret ediyor olabilir.',
      'integration':
          'Bu ruya, senden donusumu kabul etmeni ve degisimden kaçmamani istiyor olabilir. Yilan, eski kabugu birakmanin yeni buyumeye alan actigini hatırlatiyor.',
      'questions':
          'Hayatinda simdi sonlanmakta olan ne var?|Hangi korku veya gercekle yuzlesmekten kaciniyorsun?|Bu sembolu gorduğunde ilk aklina gelen kisi veya durum ne?',
    },
    'su': {
      'reconstruction': 'Bu ruyada su elementi merkezi bir rol oynuyor.',
      'emotionalCenter_fear':
          'Duygusal agirlik korku etrafinda toplanmis - bogulma, kontrolsuz akis veya karanlik sular gibi temalar duygusal bunalmisi yansıtıyor olabilir.',
      'emotionalCenter_peace':
          'Duygusal agirlik huzur etrafinda - berrak ve sakin sular, ic huzur ve duygusal netliği yansıtıyor olabilir.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik merak etrafinda - suyun derinliklerine bakmak, ic dünyanı kesfetmeye hazır olduğunu gosteriyor.',
      'emotionalCenter_neutral':
          'Duygusal ton karisik - su hem sakinlestirici hem de tehditkar olabilir, bu ikiliği incele.',
      'symbolDynamics':
          'Su, bilincdisi ve duyguların evrensel semboludur. Durumu - temiz/bulanik, durgun/dalgali - onemli ipuclari tasir. Suyun icinde olmak ve disinda olmak arasindaki fark buyuktur.',
      'position_observer':
          'Suyu disaridan izliyordun - duygularinı mesafeli bir yerden degerlendiriyorsun.',
      'position_participant':
          'Suyun icindeydin - duygularina tamamen dalmiş durumdasin.',
      'position_escaping':
          'Sudan kaciyordun - duygusal yükten uzaklasmaya calisiyor olabilirsin.',
      'position_confronting':
          'Suyla yuzlesiyordun - duygusal derinlige inmeye hazirsin.',
      'position_neutral':
          'Pozisyonun degisken - duygularinla iliskin henuz netlesmiyor olabilir.',
      'timing':
          'Su ruyalari genellikle duygusal gecis donemlerinde ortaya cikar. Bir duygunun islenmesi veya serbest birakilmasi surecinde olabilirsin.',
      'lifeResonance_fear':
          'Bu ruya, hayatinda duygusal olarak bunaldigin veya kontrol edemediğin bir durumu yansıtıyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, duygusal netlik ve ic huzur doneminin basladigini yansıtıyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, islenmesi gereken duygusal bir temaya dikkat cekiyor olabilir.',
      'integration':
          'Bu ruya, duygularina dikkat etmeni ve onlari akmasina izin vermeni istiyor olabilir. Suyun dogasi akmaktır - tutmak yerine birak.',
      'questions':
          'Hayatinda su anda hangi duygu en yogun?|Duygularini ifade etmekte zorlandigin bir alan var mi?|Su elementi seninle nasil konusuyor?',
    },
    'ucmak': {
      'reconstruction': 'Bu ruyada ucma deneyimi merkezi bir rol oynuyor.',
      'emotionalCenter_fear':
          'Duygusal agirlik korku etrafinda - yukseklik korkusu veya dusme endisesi, kontrol kaybetme korkusunu yansıtıyor olabilir.',
      'emotionalCenter_peace':
          'Duygusal agirlik ozgurluk etrafinda - keyifli ucus, potansiyelini kullandiğinin ve dogru yolda ilerlediğinin isareti olabilir.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik merak etrafinda - yeni bakis açilari ve olasılıklara açık olduğunu gosteriyor.',
      'emotionalCenter_neutral':
          'Duygusal ton karisik - ucmak hem ozgurlestirici hem de korkutucu olabilir.',
      'symbolDynamics':
          'Ucmak, sinirlari asma ve ozgurluk arzusunun semboludur. Kontrol sende mi degil mi - bu cok onemli. Yukseklik ve ucus sekli de anlam tasir.',
      'position_observer':
          'Disaridan izliyordun - ozgurlugu veya potansiyeli mesafeli bir yerden degerlendiriyorsun.',
      'position_participant':
          'Aktif olarak ucuyordun - potansiyelinle dogrudan temas halindesin.',
      'position_escaping':
          'Ucarak kaciyordun - bir seyden uzaklasmak istiyorsun.',
      'position_confronting':
          'Ucarak yuzlesiyordun - engellerle karsi karsiya gelmeye hazirsın.',
      'position_neutral':
          'Pozisyonun belirsizdi - ozgurlugunle iliskin henuz netlesmiyor.',
      'timing':
          'Ucma ruyalari genellikle sınırları zorlama veya yeni ufuklara acılma donemlerinde ortaya çıkar.',
      'lifeResonance_fear':
          'Bu ruya, basarinin getirdigi sorumluluktan veya yukselmekten duydugun endiseyi yansıtıyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, hayatinda gerceklestirdigin bir ozgurluk veya yukselis donemini yansıtıyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, potansiyelinle ilgili kesfedilmemis bir alana isaret ediyor olabilir.',
      'integration':
          'Bu ruya, potansiyelinin sinirsiz oldugunu hatırlatiyor. Ama ayaklarini yere basan pratik adimlarla hayallerini dengelemen gerekebilir.',
      'questions':
          'Hayatinda hangi sinirları asmak istiyorsun?|Basari veya yukselme seni endiselendirir mi?|Ozgur hissettigin anlar ne zaman?',
    },
    'dusmek': {
      'reconstruction': 'Bu ruyada dusme deneyimi merkezi bir rol oynuyor.',
      'emotionalCenter_fear':
          'Duygusal agirlik korku ve panik etrafinda - kontrol kaybi veya guvensizlik hissini yogun yasiyorsun.',
      'emotionalCenter_peace':
          'Duygusal agirlik teslimiyet etrafinda - dusus huzurlu hissediyorsa, birakma ve surece guvenme cagrisı olabilir.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik merak etrafinda - dususe merakla yaklasıyorsan, degisime açık oldugunu gosteriyor.',
      'emotionalCenter_neutral':
          'Duygusal ton belirsiz - dusus hem korku hem de birakma iceriyor olabilir.',
      'symbolDynamics':
          'Dusme, kontrol kaybi ve guvensizliğin evrensel semboludur. Dusmeden once ne oldu, yere carptin mi, bu detaylar onemli.',
      'position_observer':
          'Disaridan izliyordun - kontrol kaybini mesafeli değerlendiriyorsun.',
      'position_participant':
          'Dusen sendin - bu durum seni dogrudan etkiliyor.',
      'position_escaping':
          'Dusus bir kacis gibi hissettirdi - bir seyden uzaklasma istegi olabilir.',
      'position_confronting':
          'Dususe teslim oldun - surece guvenmeyi ogreniyorsun.',
      'position_neutral':
          'Pozisyonun belirsizdi - kontrolle iliskin henuz netlesmiyor.',
      'timing':
          'Dusme ruyalari genellikle buyuk belirsizlik veya degisim donemlerinde ortaya cikar.',
      'lifeResonance_fear':
          'Bu ruya, hayatinda zemin ayaklarinin altindan kayiyor gibi hissettiğin bir durumu yansıtıyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, birakma ve teslim olma surecini yansıtıyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, kontrol ve guvenlik temalarına dikkat cekiyor olabilir.',
      'integration':
          'Bu ruya, tutundugun seyleri gözden gecirmeni istiyor olabilir. Bazen birakmak, ileri gitmek icin gereklidir.',
      'questions':
          'Hayatinda kontrolu kaybettigini hissettigin bir alan var mi?|Neyi tutuyorsun ve birakamiyorsun?|Dusus sana ne ogretiyor?',
    },
    'kovalanmak': {
      'reconstruction': 'Bu ruyada kovalanma deneyimi merkezi bir rol oynuyor.',
      'emotionalCenter_fear':
          'Duygusal agirlik korku ve panik etrafinda - kacinilan bir sey seni takip ediyor.',
      'emotionalCenter_peace':
          'Duygusal agirlik merak etrafinda - kovalayani anlamaya calisiyorsun.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik kesif etrafinda - kovalayan aslinda ne istiyor?',
      'emotionalCenter_neutral':
          'Duygusal ton karisik - hem korku hem merak var.',
      'symbolDynamics':
          'Kovalanmak, kacilan duygular, sorumluluklar veya gercekleri temsil eder. Kovalayan kim/ne oldugu cok onemli.',
      'position_observer':
          'Disaridan izliyordun - kacis mekanizmani degerlendiriyorsun.',
      'position_participant':
          'Kacan sendin - bir seyden aktif olarak uzaklasıyorsun.',
      'position_escaping': 'Kacıyordun - yuzlesmekten kaciniyorsun.',
      'position_confronting': 'Donup yuzlestin - cesaret gosteriyorsun.',
      'position_neutral':
          'Pozisyonun degisti - kacinma ve yuzlesme arasinda gidip geliyorsun.',
      'timing':
          'Kovalanma ruyalari genellikle kacinılan bir konu giderek acil hale geldiginde ortaya cikar.',
      'lifeResonance_fear':
          'Bu ruya, hayatinda kacmaya calistigin bir sorumluluk, duygu veya gercegi yansıtıyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, kovalayani anlamaya ve entegre etmeye basladiğini gosteriyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, yuzlesmemen gereken bir alana dikkat cekiyor olabilir.',
      'integration':
          'Bu ruya, don ve sor: Ne istiyorsun? Cogu zaman kactigimiz sey, en cok ihtiyacımız olan ders.',
      'questions':
          'Hayatinda neden kaciyorsun?|Kovalayan sana tanidik geliyor mu?|Dursan ve donsen ne olurdu?',
    },
    'olum': {
      'reconstruction': 'Bu ruyada olum temasi merkezi bir rol oynuyor.',
      'emotionalCenter_fear':
          'Duygusal agirlik korku ve kaygi etrafinda - kayip veya son korkusunu yansıtıyor olabilir.',
      'emotionalCenter_peace':
          'Duygusal agirlik kabul etrafinda - donusumu ve bitisin dogalligini kabul ediyorsun.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik merak etrafinda - olumun otesinde ne var sorusu seni cezbediyor.',
      'emotionalCenter_neutral':
          'Duygusal ton karısik - hem korku hem kabul var.',
      'symbolDynamics':
          'Olum ruyalari nadiren literal. Donusum, bir doneminin sonu, buyuk degisimi temsil eder. Kim oldugu cok onemli - sen mi, baskasi mi?',
      'position_observer':
          'Disaridan izliyordun - donusumu mesafeli degerlendiriyorsun.',
      'position_participant':
          'Sen oluyordun - buyuk bir ic degisim yasiyorsun.',
      'position_escaping':
          'Olumden kaciyordun - degisime direnc gosteriyorsun.',
      'position_confronting':
          'Olumle yuzlesiyordun - donusumu kabul ediyorsun.',
      'position_neutral':
          'Pozisyonun belirsizdi - degisime karsi tutumun henuz netlesmiyor.',
      'timing':
          'Olum ruyalari genellikle hayatin buyuk gecis noktalarinda - iliskilerin sonu, kariyer degisimleri, kimlik donusumleri - ortaya cikar.',
      'lifeResonance_fear':
          'Bu ruya, hayatinda biten veya olmesi gereken bir seyin korkusunu yansıtıyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, bir seyin dogal olarak sona erdigini ve bunun iyi oldugunu yansıtıyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, hayatinda donusum bekleyen bir alana isaret ediyor olabilir.',
      'integration':
          'Bu ruya, eski kimligin, aliṣkanlıgın veya yasam biciminin olmesinin yeni bir baslangiça yer actığını hatirlatıyor.',
      'questions':
          'Hayatinda simdi ne bitiyor veya bitmesi gerekiyor?|Neyi birakmaktan korkuyorsun?|Donusumu engelleyen ne?',
    },
    'genel': {
      'reconstruction': 'Bu ruyada onemli bir sembol veya deneyim var.',
      'emotionalCenter_fear':
          'Duygusal agirlik gerginlik veya endise etrafinda toplanmis gorunuyor.',
      'emotionalCenter_peace':
          'Duygusal agirlik huzur ve kabul etrafinda toplanmis gorunuyor.',
      'emotionalCenter_curiosity':
          'Duygusal agirlik merak ve kesif etrafinda toplanmis gorunuyor.',
      'emotionalCenter_neutral':
          'Duygusal ton belirsiz veya karisik gorunuyor.',
      'symbolDynamics':
          'Her sembol kisisel anlam tasir. Bu sembolin sana ozel ne ifade ettigini kesfetmek onemli.',
      'position_observer':
          'Gozlemci pozisyonundaydin - olaylari disaridan degerlendiriyorsun.',
      'position_participant': 'Katilimci pozisyonundaydin - olaylara dahilsin.',
      'position_escaping':
          'Kacan pozisyonundaydin - bir seyden uzaklasiyorsun.',
      'position_confronting':
          'Yuzlesen pozisyonundaydin - bir seyle karsi karsiyasin.',
      'position_neutral':
          'Pozisyonun belirsiz - duruma karsi tutumun henuz netlesmiyor.',
      'timing':
          'Bu ruya, yasam yolculugunda belirli bir noktaya isaret ediyor olabilir.',
      'lifeResonance_fear':
          'Bu ruya, hayatinda dikkat edilmesi gereken bir kaygi veya endiseyi yansıtıyor olabilir.',
      'lifeResonance_peace':
          'Bu ruya, ic huzur ve uyum donemini yansıtıyor olabilir.',
      'lifeResonance_neutral':
          'Bu ruya, hayatinda kesfedilmeyi bekleyen bir alana isaret ediyor olabilir.',
      'integration':
          'Bu ruya, dikkatini belirli bir alana cekmeye calisiyor olabilir.',
      'questions':
          'Bu sembol senin icin kisisel olarak ne ifade ediyor?|Son zamanlarda benzer duygular yasadigin bir durum var mi?|Ruyadaki bu enerjiyi nerede hissediyorsun?',
    },
  };

  /// Private: Build horoscope prompt
  String _buildHoroscopePrompt({
    required ZodiacSign sunSign,
    ZodiacSign? moonSign,
    ZodiacSign? risingSign,
    DateTime? birthDate,
    String? currentMoonPhase,
  }) {
    return '''
Bir astroloji uzmani olarak gunluk burc yorumu yaz.

Gunes Burcu: ${sunSign.nameTr}
${moonSign != null ? 'Ay Burcu: ${moonSign.nameTr}' : ''}
${risingSign != null ? 'Yukselen Burc: ${risingSign.nameTr}' : ''}
${currentMoonPhase != null ? 'Guncel Ay Fazi: $currentMoonPhase' : ''}
Tarih: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}

Su formatta JSON dondur:
{
  "summary": "Genel gunluk ozet (3-4 cumle)",
  "loveAdvice": "Ask ve iliskiler tavsiyesi (2-3 cumle)",
  "careerAdvice": "Kariyer ve para tavsiyesi (2-3 cumle)",
  "healthAdvice": "Saglik ve enerji tavsiyesi (2-3 cumle)",
  "luckyNumber": "1-99 arasi sansli sayi",
  "luckyColor": "Turkce renk adi",
  "mood": "Gunun enerjisi (tek kelime)"
}

Turkce yaz, mistik ve destekleyici bir ton kullan.
''';
  }

  /// Private: Generate content with AI
  Future<String?> _generateWithAi(String prompt) async {
    // Try OpenAI first
    if (_openAiApiKey != null && _openAiApiKey!.isNotEmpty) {
      try {
        final response = await http
            .post(
              Uri.parse('$_openAiBaseUrl/chat/completions'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $_openAiApiKey',
              },
              body: jsonEncode({
                'model': 'gpt-4o-mini',
                'messages': [
                  {
                    'role': 'system',
                    'content':
                        'Sen deneyimli bir Turk astrologusun. Mistik, ilham verici ve destekleyici bir tonda yaziyorsun.',
                  },
                  {'role': 'user', 'content': prompt},
                ],
                'max_tokens': 500,
                'temperature': 0.8,
              }),
            )
            .timeout(const Duration(seconds: 30));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['choices'][0]['message']['content'];
        } else if (kDebugMode) {
          debugPrint(
            'OpenAI API error: ${response.statusCode} - ${response.body}',
          );
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('OpenAI request failed: $e');
        }
      }
    }

    // Try Anthropic
    if (_anthropicApiKey != null && _anthropicApiKey!.isNotEmpty) {
      try {
        final response = await http
            .post(
              Uri.parse('$_anthropicBaseUrl/messages'),
              headers: {
                'Content-Type': 'application/json',
                'x-api-key': _anthropicApiKey!,
                'anthropic-version': '2023-06-01',
              },
              body: jsonEncode({
                'model': 'claude-3-haiku-20240307',
                'max_tokens': 500,
                'messages': [
                  {'role': 'user', 'content': prompt},
                ],
                'system':
                    'Sen deneyimli bir Turk astrologusun. Mistik, ilham verici ve destekleyici bir tonda yaziyorsun.',
              }),
            )
            .timeout(const Duration(seconds: 30));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['content'][0]['text'];
        } else if (kDebugMode) {
          debugPrint(
            'Anthropic API error: ${response.statusCode} - ${response.body}',
          );
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Anthropic request failed: $e');
        }
      }
    }

    return null;
  }

  /// Private: Parse horoscope JSON response
  PersonalizedHoroscope _parseHoroscopeResponse(
    String response,
    ZodiacSign sign,
  ) {
    try {
      // Extract JSON from response if wrapped in markdown
      var jsonStr = response;
      if (response.contains('```json')) {
        jsonStr = response.split('```json')[1].split('```')[0].trim();
      } else if (response.contains('```')) {
        jsonStr = response.split('```')[1].split('```')[0].trim();
      }

      final data = jsonDecode(jsonStr);
      return PersonalizedHoroscope(
        sign: sign,
        summary: data['summary'] ?? '',
        loveAdvice: data['loveAdvice'] ?? '',
        careerAdvice: data['careerAdvice'] ?? '',
        healthAdvice: data['healthAdvice'] ?? '',
        luckyNumber: data['luckyNumber']?.toString() ?? '7',
        luckyColor: data['luckyColor'] ?? 'Altin',
        mood: data['mood'] ?? 'Dengeli',
        isAiGenerated: true,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to parse AI response: $e');
      }
      return _generateLocalHoroscope(sunSign: sign);
    }
  }

  /// Private: Generate local horoscope
  PersonalizedHoroscope _generateLocalHoroscope({
    required ZodiacSign sunSign,
    ZodiacSign? moonSign,
    ZodiacSign? risingSign,
  }) {
    final random = Random(DateTime.now().day + sunSign.index);

    final summaries = _localSummaries[sunSign] ?? _defaultSummaries;
    final loveAdvices = _localLoveAdvice[sunSign] ?? _defaultLoveAdvice;
    final careerAdvices = _localCareerAdvice[sunSign] ?? _defaultCareerAdvice;
    final healthAdvices = _localHealthAdvice[sunSign] ?? _defaultHealthAdvice;

    return PersonalizedHoroscope(
      sign: sunSign,
      summary: summaries[random.nextInt(summaries.length)],
      loveAdvice: loveAdvices[random.nextInt(loveAdvices.length)],
      careerAdvice: careerAdvices[random.nextInt(careerAdvices.length)],
      healthAdvice: healthAdvices[random.nextInt(healthAdvices.length)],
      luckyNumber: (random.nextInt(99) + 1).toString(),
      luckyColor: _luckyColors[random.nextInt(_luckyColors.length)],
      mood: _moods[random.nextInt(_moods.length)],
      isAiGenerated: false,
    );
  }

  String _getAreaName(AdviceArea area) {
    switch (area) {
      case AdviceArea.love:
        return 'ask ve iliskiler';
      case AdviceArea.career:
        return 'kariyer ve is';
      case AdviceArea.health:
        return 'saglik ve enerji';
      case AdviceArea.money:
        return 'para ve bolluk';
      case AdviceArea.spiritual:
        return 'spirituel gelisim';
    }
  }

  String _getLocalAdvice(ZodiacSign sign, AdviceArea area) {
    final random = Random(DateTime.now().day + sign.index + area.index);

    switch (area) {
      case AdviceArea.love:
        final advices = _localLoveAdvice[sign] ?? _defaultLoveAdvice;
        return advices[random.nextInt(advices.length)];
      case AdviceArea.career:
        final advices = _localCareerAdvice[sign] ?? _defaultCareerAdvice;
        return advices[random.nextInt(advices.length)];
      case AdviceArea.health:
        final advices = _localHealthAdvice[sign] ?? _defaultHealthAdvice;
        return advices[random.nextInt(advices.length)];
      case AdviceArea.money:
        return 'Bolluk enerjisi bugun seninle. Bilincli harcamalar ve yeni gelir firsatlari icin gozlerini ac.';
      case AdviceArea.spiritual:
        return CosmicMessagesContent.getDailyCosmicMessage(sign);
    }
  }

  // Local content data
  static final List<String> _luckyColors = [
    'Altin',
    'Mor',
    'Mavi',
    'Yesil',
    'Kirmizi',
    'Pembe',
    'Turuncu',
    'Gumus',
    'Turkuaz',
    'Lavanta',
    'Sampanya',
  ];

  static final List<String> _moods = [
    'Enerjik',
    'Huzurlu',
    'Yaratici',
    'Tutkulu',
    'Dengeli',
    'Ilham Dolu',
    'Kararli',
    'Romantik',
    'Guclu',
    'Sezgisel',
  ];

  static final List<String> _defaultSummaries = [
    'Bugun kozmik enerjiler senin lehine calisiyor. Firsatlari degerlendir, kalbinin sesini dinle.',
    'Yildizlar pozitif degisimlere isaret ediyor. Beklenmedik surprizlere hazir ol.',
    'Evrensel enerji bugun sana guc veriyor. Hedeflerine odaklan, basari yakin.',
  ];

  static final List<String> _defaultLoveAdvice = [
    'Kalbini ac, ask kapida bekliyor. Iliskilerde durustluk en buyuk gucun.',
    'Romantik enerjiler guclu. Sevdiklerinle kaliteli zaman gecir.',
    'Duygusal baglar derinlesiyor. Kendini ifade etmekten cekinme.',
  ];

  static final List<String> _defaultCareerAdvice = [
    'Kariyer firsatlari beliriyor. Yeni projeler icin mukemmel zamanlama.',
    'Profesyonel gelisim icin kapilar aciliyor. Yeteneklerini sergile.',
    'Is hayatinda pozitif gelismeler. Sabirla bekle, emeklerin karsilik bulacak.',
  ];

  static final List<String> _defaultHealthAdvice = [
    'Enerjin yuksek, dengeni koru. Hareket et, saglikli beslen.',
    'Ic huzurunu bul. Meditasyon ve nefes calismalari faydali olacak.',
    'Bedenini dinle, ihtiyaclarina kulak ver. Dinlenme de onemli.',
  ];

  // Sign-specific local content (abbreviated for brevity - full content preserved)
  static final Map<ZodiacSign, List<String>> _localSummaries = {
    ZodiacSign.aries: [
      'Ates enerjin bugun doruklarda. Liderlik yetenegini goster, cesaretinle ileri atil.',
      'Mars gucunu destekliyor. Yeni baslangiclar icin mukemmel bir gun.',
      'Savasci ruhun uyaniyor. Hedeflerine kararlilikla ilerle.',
    ],
    ZodiacSign.taurus: [
      'Toprak enerjisi seni besliyor. Maddi konularda sans yildizin parliyor.',
      'Venus guzelligini ve cekiciligini artiriyor. Askta ve iste basari seni bekliyor.',
      'Sabir ve kararliligim meyvelerini toplayacaksin. Guven, devam et.',
    ],
    ZodiacSign.gemini: [
      'Zihinsel cevikligin bugun super guc. Iletisimde parliyorsun.',
      'Merkur dusuncelerini keskinlestiriyor. Yeni fikirler, yeni baglantilar.',
      'Sosyal enerjin yuksek. Network kur, firsatlar kapida.',
    ],
    ZodiacSign.cancer: [
      'Ay isigi ruhunu aydinlatiyor. Sezgilerin cok guclu, dinle.',
      'Duygusal zekan bugun rehberin. Kalbinin sesini takip et.',
      'Aile ve yuva konulari one cikiyor. Sevdiklerine zaman ayir.',
    ],
    ZodiacSign.leo: [
      'Gunes enerjin maksimumda. Parla, sahneye cik, ilgi odagi ol.',
      'Yaraticiligin volkanik. Sanatsal projeler icin mukemmel gun.',
      'Kraliyet enerjin hissediliyor. Liderlik pozisyonlari seni bekliyor.',
    ],
    ZodiacSign.virgo: [
      'Analitik zekan bugun lazer gibi. Detaylarda sihir gizli.',
      'Organizasyon yetenegin on planda. Duzen kur, verimlilik artacak.',
      'Saglik ve wellness konulari one cikiyor. Kendine iyi bak.',
    ],
    ZodiacSign.libra: [
      'Denge ve uyum enerjisi guclu. Iliskilerde harmoni zamani.',
      'Venus guzelligini ve diplomasi yetenegini artiriyor.',
      'Estetik duyarliligim dorukta. Guzellik yarat, guzellik cek.',
    ],
    ZodiacSign.scorpio: [
      'Donusum enerjisi yogun. Derinlere dal, hazineleri bul.',
      'Sezgilerin bugun cok keskin. Gizli gercekler ortaya cikiyor.',
      'Tutku ve guc birlesiyor. Istedigin her seyi cekme kapasiten var.',
    ],
    ZodiacSign.sagittarius: [
      'Macera ruhu uyaniyor. Yeni ufuklar, yeni deneyimler seni bekliyor.',
      'Jupiter sansini genisletiyor. Firsatlar yagmur gibi yagiyor.',
      'Felsefi derinlik gunu. Hayatin anlamini sorgula, bilgelik bul.',
    ],
    ZodiacSign.capricorn: [
      'Kariyer enerjin zirve yapiyor. Profesyonel basarilar kapida.',
      'Saturn disiplin ve yapi veriyor. Hedeflerine kararlilikla ilerle.',
      'Uzun vadeli planlar icin mukemmel gun. Temelleri saglam at.',
    ],
    ZodiacSign.aquarius: [
      'Yenilikci enerjin bugun dorukta. Sira disi fikirler, devrimci cozumler.',
      'Uranus beklenmedik firsatlar getiriyor. Degisime acik ol.',
      'Topluluk enerjisi guclu. Insanliga hizmet zamani.',
    ],
    ZodiacSign.pisces: [
      'Spirituel baglantin bugun cok guclu. Evrenle bir ol.',
      'Neptun yaraticiligin ve sezgilerini besliyor. Sanatin aksin.',
      'Ruyalar ve hayal gucu on planda. Ic dunyaina kulak ver.',
    ],
  };

  static final Map<ZodiacSign, List<String>> _localLoveAdvice = {
    ZodiacSign.aries: [
      'Tutkulu enerjin ask hayatini atesliyor. Beklenmedik romantik anlar seni bekliyor.',
      'Iliskide inisiyatif al. Cesur adimlar romantik surprizler getirecek.',
    ],
    ZodiacSign.taurus: [
      'Duyusal zevkler ve romantik aksam yemekleri icin ideal gun.',
      'Sadakat ve guven iliskini guclendiriyor. Sevgini somut goster.',
    ],
    ZodiacSign.gemini: [
      'Iletisim askin anahtari. Derin sohbetler baglari kuvvetlendiriyor.',
      'Flort enerjin yuksek. Yeni tanisikliklar heyecan verici olabilir.',
    ],
    ZodiacSign.cancer: [
      'Duygusal derinlik iliskini besliyor. Kalbini ac, sevgiyi kabul et.',
      'Yuva kurma icgudun guclu. Partner ile gelecek planlari yap.',
    ],
    ZodiacSign.leo: [
      'Romantik jestler ve dikkat cekici anlar seni bekliyor.',
      'Askta drama ve tutku var. Kalbini takip et, cesur ol.',
    ],
    ZodiacSign.virgo: [
      'Kucuk detaylar buyuk anlamlar tasiyor. Pratik sevgi goster.',
      'Iliskide duzen ve rutin faydali. Saglikli sinirlar koy.',
    ],
    ZodiacSign.libra: [
      'Romantik uyum mukemmel. Iliskilerde denge ve harmoni zamani.',
      'Estetik randevular ve guzel anlar seni bekliyor.',
    ],
    ZodiacSign.scorpio: [
      'Yogun tutkular ve derin baglantilar gunu. Guven insa et.',
      'Cinsel ve duygusal birliktelik gucleniyor. Donusum zamani.',
    ],
    ZodiacSign.sagittarius: [
      'Macera dolu romantizm seni bekliyor. Yeni yerler, yeni deneyimler.',
      'Entelektuel bag fiziksel cekimi artiriyor. Birlikte ogren.',
    ],
    ZodiacSign.capricorn: [
      'Ciddi iliskiler ve uzun vadeli planlar icin mukemmel zaman.',
      'Sadakat ve bagliligin karsilik buluyor. Guven insa ediliyor.',
    ],
    ZodiacSign.aquarius: [
      'Sira disi romantik deneyimler seni bekliyor. Ozgun ol.',
      'Arkadaslik temelli ask gucleniyor. Entellektuel bag onemli.',
    ],
    ZodiacSign.pisces: [
      'Ruhani ask baglari derinlesiyor. Ruh esi enerjisi yogun.',
      'Romantik ruyalar gercege donusuyor. Sezgilerine guven.',
    ],
  };

  static final Map<ZodiacSign, List<String>> _localCareerAdvice = {
    ZodiacSign.aries: [
      'Liderlik pozisyonlari parliyor. Girisimci projeler baslat.',
      'Rekabet avantajin var. Cesaretle ileri atil, kazanacaksin.',
    ],
    ZodiacSign.taurus: [
      'Finansal firsatlar beliriyor. Yatirimlar icin uygun zaman.',
      'Sabirli calisman meyvesini veriyor. Bolluk akiyor.',
    ],
    ZodiacSign.gemini: [
      'Iletisim ve network projeleri one cikiyor. Baglantilari kullan.',
      'Cok yonlu yeteneklerin talep goruyor. Kendini pazarla.',
    ],
    ZodiacSign.cancer: [
      'Ev tabanli isler ve duygusal zeka gerektiren roller parliyor.',
      'Takim calismasi ve destek rolleri icin mukemmel gun.',
    ],
    ZodiacSign.leo: [
      'Yaratici projeler ve sahne onu roller icin ideal zaman.',
      'Liderlik ve yoneticilik firsatlari kapida. Parla!',
    ],
    ZodiacSign.virgo: [
      'Detay odakli islerde basari potansiyeli yuksek. Analiz yetenegini kullan.',
      'Organizasyon projeleri parliyor. Sistemler kur, verimlilik artir.',
    ],
    ZodiacSign.libra: [
      'Ortakliklar ve diplomasi alaninda firsatlar var.',
      'Is birligi projeleri bereketli. Kopruler kur.',
    ],
    ZodiacSign.scorpio: [
      'Arastirma ve donusum projeleri one cikiyor.',
      'Gizli firsatlari kesfet. Derin analiz avantaj sagliyor.',
    ],
    ZodiacSign.sagittarius: [
      'Uluslararasi baglantilar ve egitim alaninda gelismeler var.',
      'Genisleme firsatlari. Yeni pazarlar, yeni ufuklar.',
    ],
    ZodiacSign.capricorn: [
      'Kariyer zirvesine tirmanis hizlaniyor. Disiplin meyvesini veriyor.',
      'Yoneticilik ve otorite pozisyonlari icin mukemmel zaman.',
    ],
    ZodiacSign.aquarius: [
      'Teknoloji ve yenilik projeleri parliyor. Icat et, yenile.',
      'Sira disi fikirlerin deger kazaniyor. Vizyoner ol.',
    ],
    ZodiacSign.pisces: [
      'Yaratici ve spirituel alanlarda kariyer firsatlari var.',
      'Sezgisel kararlar dogru sonuclar getiriyor. Ic sesini dinle.',
    ],
  };

  static final Map<ZodiacSign, List<String>> _localHealthAdvice = {
    ZodiacSign.aries: [
      'Fiziksel aktivite enerjini dengele. Yogun sporlar faydali.',
      'Sabirsizligini yatistir. Nefes calismalari ve meditasyon onerilir.',
    ],
    ZodiacSign.taurus: [
      'Duyusal keyiflerle kendini simart. Spa ve masaj sifa verir.',
      'Beslenmeye dikkat et. Dogal, topraklanmis yiyecekler sec.',
    ],
    ZodiacSign.gemini: [
      'Zihinsel detoks zamani. Bilgi bombardimanindan uzaklas.',
      'Hareket et! Yuruyus ve hafif egzersizler faydali.',
    ],
    ZodiacSign.cancer: [
      'Duygusal arinma gunu. Gozyaslari sifa verir.',
      'Su terapisi ve deniz tuzu banyolari onerilir.',
    ],
    ZodiacSign.leo: [
      'Kalp sagligina dikkat. Kardiyovaskuler egzersizler faydali.',
      'Yaratici ifade enerjini dengeler. Dans et, ozgurce hareket et.',
    ],
    ZodiacSign.virgo: [
      'Detoks ve arinma rituelleri sifa verir.',
      'Mukemmeliyetciligi birak, stresi azalt. Dinlen.',
    ],
    ZodiacSign.libra: [
      'Denge calismalari onemli. Yoga ve pilates onerilir.',
      'Guzellik rituelleri ruhunu besliyor. Kendine zaman ayir.',
    ],
    ZodiacSign.scorpio: [
      'Derin donusum ve sifa calismalari faydali.',
      'Golge calismasi ve meditasyon gucunu artirir.',
    ],
    ZodiacSign.sagittarius: [
      'Hareket ve macera sart! Dogada vakit gecir.',
      'Kalca ve bacak sagligina dikkat. Stretching onemli.',
    ],
    ZodiacSign.capricorn: [
      'Kemik ve eklem sagligina dikkat et.',
      'Dinlenme ve rejenerasyon zamani. Asiri calismaktan kacin.',
    ],
    ZodiacSign.aquarius: [
      'Sinir sistemi dengelemesi gerekli. Teknolojiden uzaklas.',
      'Sosyal aktiviteler ruh sagligini destekler.',
    ],
    ZodiacSign.pisces: [
      'Su elementleriyle sifa bul. Yuzme ve banyo rituelleri onerilir.',
      'Ruya calismasi ve uyku kalitesine dikkat et.',
    ],
  };
}

/// Personalized horoscope model
class PersonalizedHoroscope {
  final ZodiacSign sign;
  final String summary;
  final String loveAdvice;
  final String careerAdvice;
  final String healthAdvice;
  final String luckyNumber;
  final String luckyColor;
  final String mood;
  final bool isAiGenerated;

  PersonalizedHoroscope({
    required this.sign,
    required this.summary,
    required this.loveAdvice,
    required this.careerAdvice,
    required this.healthAdvice,
    required this.luckyNumber,
    required this.luckyColor,
    required this.mood,
    this.isAiGenerated = false,
  });
}

/// Advice areas
enum AdviceArea { love, career, health, money, spiritual }

/// Dream interpretation conversation state
enum DreamConversationState {
  initial, // User just shared a dream
  awaitingContext, // Waiting for context answers
  interpreted, // Interpretation provided
}

/// Dream interpretation session
class DreamInterpretationSession {
  final String dreamSymbol;
  final List<String> contextQuestions;
  final Map<String, String> contextAnswers;
  final String? interpretation;
  final DreamConversationState state;
  final DateTime createdAt;

  DreamInterpretationSession({
    required this.dreamSymbol,
    this.contextQuestions = const [],
    this.contextAnswers = const {},
    this.interpretation,
    this.state = DreamConversationState.initial,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  DreamInterpretationSession copyWith({
    String? dreamSymbol,
    List<String>? contextQuestions,
    Map<String, String>? contextAnswers,
    String? interpretation,
    DreamConversationState? state,
  }) {
    return DreamInterpretationSession(
      dreamSymbol: dreamSymbol ?? this.dreamSymbol,
      contextQuestions: contextQuestions ?? this.contextQuestions,
      contextAnswers: contextAnswers ?? this.contextAnswers,
      interpretation: interpretation ?? this.interpretation,
      state: state ?? this.state,
      createdAt: createdAt,
    );
  }
}

/// Cache helper class
class _CachedContent {
  final dynamic content;
  final DateTime createdAt;

  _CachedContent(this.content) : createdAt = DateTime.now();

  bool get isExpired =>
      DateTime.now().difference(createdAt) > AiContentService._cacheDuration;
}

/// AI Content Service Provider
final aiContentServiceProvider = Provider<AiContentService>((ref) {
  final analytics = ref.watch(analyticsServiceProvider);
  final service = AiContentService();
  service.initialize(analytics: analytics);
  return service;
});
