/// Dream Interpretation Service - 7 Boyutlu Rüya Yorumlama Motoru
/// AI destekli kadim bilgelik + Jungian analiz + Astrolojik zamanlama
library;

import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/dream_interpretation_models.dart';
import '../content/dream_symbols_database.dart';
import '../content/dream_content_expanded.dart';
import '../content/dream_advanced_content.dart';
import 'dream_memory_service.dart';

/// Ana rüya yorumlama servisi
class DreamInterpretationService {
  final DreamMemoryService? memoryService;

  DreamInterpretationService({this.memoryService});

  /// Tam 7 boyutlu rüya yorumu oluştur (AI çıktısından)
  FullDreamInterpretation parseAIResponse(
    String dreamText,
    Map<String, dynamic> aiResponse,
    MoonPhase currentMoonPhase, {
    String? userId,
  }) {
    return FullDreamInterpretation(
      dreamId: const Uuid().v4(),
      oderId: userId ?? 'anonymous',
      dreamText: dreamText,
      interpretedAt: DateTime.now(),
      ancientIntro: aiResponse['ancientIntro'] ?? _generateKadimGiris(),
      coreMessage: aiResponse['coreMessage'] ?? '',
      symbols: (aiResponse['symbols'] as List? ?? [])
          .map((s) => SymbolInterpretation.fromJson(s))
          .toList(),
      archetypeConnection: aiResponse['archetypeConnection'] ?? '',
      archetypeName: aiResponse['archetypeName'] ?? 'Gölge',
      emotionalReading: aiResponse['emotionalReading'] != null
          ? EmotionalReading.fromJson(aiResponse['emotionalReading'])
          : _defaultEmotionalReading(),
      astroTiming: AstroTiming(
        moonPhase: currentMoonPhase,
        moonSign: aiResponse['moonSign'],
        relevantTransit: aiResponse['relevantTransit'],
        timingMessage:
            aiResponse['timingMessage'] ??
            _getMoonPhaseMessage(currentMoonPhase),
        whyNow:
            aiResponse['whyNow'] ??
            'Bu rüya tam da şu an geldi çünkü evren sana bir mesaj gönderiyor.',
        isRetrograde: aiResponse['isRetrograde'] ?? false,
      ),
      lightShadow: aiResponse['lightShadow'] != null
          ? LightShadowReading.fromJson(aiResponse['lightShadow'])
          : _defaultLightShadow(),
      guidance: aiResponse['guidance'] != null
          ? PracticalGuidance.fromJson(aiResponse['guidance'])
          : _defaultGuidance(),
      whisperQuote: aiResponse['whisperQuote'] ?? _generateWhisperQuote(),
      shareCard: aiResponse['shareCard'] != null
          ? ShareableCard.fromJson(aiResponse['shareCard'])
          : ShareableQuoteTemplates.getRandomQuote(),
      explorationLinks: _generateExplorationLinks(
        (aiResponse['symbols'] as List? ?? [])
            .map((s) => s['symbol'] as String)
            .toList(),
      ),
      userRole: _parseRole(aiResponse['userRole']),
      timeLayer: _parseTimeLayer(aiResponse['timeLayer']),
      isRecurring: aiResponse['isRecurring'] ?? false,
      recurringCount: aiResponse['recurringCount'],
    );
  }

  /// Hızlı sembol tabanlı yorum (AI olmadan, yerel veritabanından)
  FullDreamInterpretation generateLocalInterpretation(
    DreamInput input,
    MoonPhase currentMoonPhase, {
    String? userId,
  }) {
    // Sembolleri tespit et
    final detectedSymbols = DreamSymbolsDatabase.detectSymbolsInText(
      input.dreamDescription,
    );

    // Dominant duyguyı belirle
    final dominantEmotion = input.dominantEmotion ?? EmotionalTone.merak;

    // Her sembol için yorum oluştur
    final symbolInterpretations = detectedSymbols.map((symbolData) {
      return SymbolInterpretation(
        symbol: symbolData.symbolTr,
        symbolEmoji: symbolData.emoji,
        universalMeaning: symbolData.universalMeanings.first,
        personalContext:
            symbolData.emotionVariants[dominantEmotion] ??
            symbolData.universalMeanings.first,
        shadowAspect: symbolData.shadowAspect,
        lightAspect: symbolData.lightAspect,
        relatedSymbols: symbolData.relatedSymbols,
      );
    }).toList();

    // Arketip bağlantısı
    final archetype = _detectDominantArchetype(
      detectedSymbols,
      dominantEmotion,
    );
    final archetypeData = ArchetypeDatabase.findArchetype(archetype);

    // Zaman katmanı
    final timeLayer = input.isRecurring
        ? TimeLayer.dongusel
        : _inferTimeLayer(input);

    // Rol
    final role = input.perceivedRole ?? _inferRole(input.dreamDescription);

    return FullDreamInterpretation(
      dreamId: const Uuid().v4(),
      oderId: userId ?? 'anonymous',
      dreamText: input.dreamDescription,
      interpretedAt: DateTime.now(),
      ancientIntro: _generateKadimGiris(
        moonPhase: currentMoonPhase,
        emotion: dominantEmotion,
        symbolCategory: detectedSymbols.isNotEmpty
            ? detectedSymbols.first.category
            : null,
      ),
      coreMessage: _generateCoreMessage(
        detectedSymbols,
        dominantEmotion,
        timeLayer,
        currentMoonPhase,
      ),
      symbols: symbolInterpretations,
      archetypeConnection:
          archetypeData?.description ??
          'Bilinçaltının derinliklerinden bir figür beliriyor.',
      archetypeName: archetypeData?.nameTr ?? archetype,
      emotionalReading: EmotionalReading(
        dominantEmotion: dominantEmotion,
        surfaceMessage: _getSurfaceMessage(dominantEmotion),
        deeperMeaning: _getDeeperMeaning(dominantEmotion),
        shadowQuestion: _getShadowQuestion(dominantEmotion),
        integrationPath: _getIntegrationPath(dominantEmotion),
      ),
      astroTiming: AstroTiming(
        moonPhase: currentMoonPhase,
        timingMessage: _getMoonPhaseMessage(currentMoonPhase),
        whyNow: _getWhyNowMessage(currentMoonPhase, timeLayer),
      ),
      lightShadow: LightShadowReading(
        lightMessage: _generateLightMessage(detectedSymbols),
        shadowMessage: _generateShadowMessage(detectedSymbols),
        integrationPath: _generateIntegrationPath(archetype),
        archetype: archetype,
      ),
      guidance: PracticalGuidance(
        todayAction: _generateTodayAction(detectedSymbols, dominantEmotion),
        reflectionQuestion: _generateReflectionQuestion(detectedSymbols),
        weeklyFocus: _generateWeeklyFocus(archetype, currentMoonPhase),
        avoidance: _generateAvoidance(dominantEmotion),
      ),
      whisperQuote: _generateWhisperQuote(),
      shareCard: ShareableQuoteTemplates.getQuoteForEmotion(dominantEmotion),
      explorationLinks: _generateExplorationLinks(
        detectedSymbols.map((s) => s.symbol).toList(),
      ),
      userRole: role,
      timeLayer: timeLayer,
      isRecurring: input.isRecurring,
      recurringCount: input.recurringCount,
      recurringPattern: input.isRecurring
          ? RecurringDreamAnalyzer.detectPattern(input.dreamDescription)?.title
          : null,
      nightmareType: _detectNightmare(input.dreamDescription),
      lucidPotential: _calculateLucidPotential(
        dominantEmotion,
        currentMoonPhase,
      ),
    );
  }

  /// Kâbus tipi tespit et
  String? _detectNightmare(String dreamText) {
    final nightmare = NightmareTransformationService.detectNightmareType(
      dreamText,
    );
    return nightmare?.title;
  }

  /// Lucid potansiyeli hesapla
  String _calculateLucidPotential(EmotionalTone emotion, MoonPhase phase) {
    // Dolunay en yüksek potansiyel
    int score = 0;

    switch (phase) {
      case MoonPhase.dolunay:
        score += 3;
        break;
      case MoonPhase.ilkDordun:
        score += 2;
        break;
      case MoonPhase.hilal:
      case MoonPhase.sonDordun:
        score += 1;
        break;
      default:
        break;
    }

    // Merak ve heyecan lucid'i artırır
    if (emotion == EmotionalTone.merak || emotion == EmotionalTone.heyecan) {
      score += 2;
    } else if (emotion == EmotionalTone.huzur) {
      score += 1;
    }

    if (score >= 4) return 'Çok Yüksek';
    if (score >= 3) return 'Yüksek';
    if (score >= 2) return 'Orta';
    return 'Düşük';
  }

  // ═══════════════════════════════════════════════════════════════
  // AI PROMPT GENERATOR
  // ═══════════════════════════════════════════════════════════════

  /// AI için detaylı prompt oluştur
  String generateAIPrompt(DreamInput input, MoonPhase moonPhase) {
    final detectedSymbols = DreamSymbolsDatabase.detectSymbolsInText(
      input.dreamDescription,
    );

    return '''
SEN: Kadim rüya bilgeliğinin modern yorumcusu. Jung, Campbell ve Sufizm'in derinliğini taşıyan bir oraküllsün. Rüyaları 7 boyutta analiz eder, şiirsel ama derin içgörüler sunarsın.

KULLANICI RÜYASI:
"${input.dreamDescription}"

ALGILANAN DUYGUSAL TON: ${input.dominantEmotion?.label ?? 'Belirtilmedi'}
UYANDIKTAN SONRAKİ HİS: ${input.wakingFeeling ?? 'Belirtilmedi'}
TEKRARLAYAN MI: ${input.isRecurring ? 'Evet (${input.recurringCount ?? '?'} kez)' : 'Hayır'}
AY FAZI: ${moonPhase.label} ${moonPhase.emoji}
TESPİT EDİLEN SEMBOLLER: ${detectedSymbols.map((s) => '${s.emoji} ${s.symbolTr}').join(', ')}

7 BOYUTLU ANALİZ FORMATI:

1. KADİM GİRİŞ (3-4 cümle, mitolojik/şiirsel):
Rüyanın evrensel bağlamını anlat. "Kadim bilgeler derler ki..." veya "Binlerce yıldır rüya okuyucuları..." gibi başla.

2. ANA MESAJ (2-3 cümle):
Bu rüya tek bir cümleyle ne söylüyor? Doğrudan ve güçlü.

3. SEMBOL ANALİZİ (her sembol için):
- Evrensel anlam
- Bu rüyadaki kişisel bağlam
- Gölge yönü
- Işık yönü

4. ARKETİP BAĞLANTISI:
Hangi Jungian arketip aktif? (Gölge, Anima/Animus, Bilge Yaşlı, Kahraman, vs.)
Bu arketipin şu anki mesajı ne?

5. DUYGUSAL OKUMA:
- Yüzey mesajı (ilk his)
- Derin anlam (altta yatan)
- Gölge sorusu (sormaktan kaçınılan)
- Entegrasyon yolu

6. ASTROLOJİK ZAMANLAMA:
- Bu rüya NEDEN şimdi geldi?
- Ay fazı bağlantısı
- Kozmik zamanlama mesajı

7. IŞIK/GÖLGE:
- Işık mesajı (olumlu potansiyel)
- Gölge mesajı (farkındalık gerektiren)
- Entegrasyon yolu

8. PRATİK REHBERLİK:
- Bugün ne yap?
- Bu hafta neye odaklan?
- Neden kaçın?
- Yansıtma sorusu

9. FISILDAYAN CÜMLE:
Tek bir aforizma. Paylaşılabilir. Hafızada kalıcı.

10. VİRAL KART:
Emoji + 10-15 kelimelik etkileyici alıntı

KURALLAR:
- ASLA tıbbi/psikolojik teşhis koyma
- Ezotetik ama bilimsel görünme
- Her yorumu kişiselleştir
- Şiirsel ama pratik ol
- Türkçe zengin, akıcı, derin

JSON FORMATI:
{
  "ancientIntro": "...",
  "coreMessage": "...",
  "symbols": [
    {
      "symbol": "...",
      "symbolEmoji": "...",
      "universalMeaning": "...",
      "personalContext": "...",
      "shadowAspect": "...",
      "lightAspect": "..."
    }
  ],
  "archetypeName": "...",
  "archetypeConnection": "...",
  "emotionalReading": {
    "dominantEmotion": "korku|huzur|merak|sucluluk|ozlem|heyecan|donukluk|ofke",
    "surfaceMessage": "...",
    "deeperMeaning": "...",
    "shadowQuestion": "...",
    "integrationPath": "..."
  },
  "timingMessage": "...",
  "whyNow": "...",
  "lightShadow": {
    "lightMessage": "...",
    "shadowMessage": "...",
    "integrationPath": "...",
    "archetype": "..."
  },
  "guidance": {
    "todayAction": "...",
    "reflectionQuestion": "...",
    "weeklyFocus": "...",
    "avoidance": "..."
  },
  "whisperQuote": "...",
  "shareCard": {
    "emoji": "...",
    "quote": "...",
    "category": "..."
  },
  "userRole": "izleyici|kahraman|kacan|arayan|saklanan|kurtarici|kurban",
  "timeLayer": "gecmis|simdi|gelecek|dongusel"
}
''';
  }

  // ═══════════════════════════════════════════════════════════════
  // YARDIMCI FONKSİYONLAR
  // ═══════════════════════════════════════════════════════════════

  String _generateKadimGiris({
    MoonPhase? moonPhase,
    SymbolCategory? symbolCategory,
    EmotionalTone? emotion,
  }) {
    // KadimGirisTemplates.rastgeleSecim kullan
    return KadimGirisTemplates.rastgeleSecim(
      ayFazi: moonPhase,
      kategori: symbolCategory,
      duygu: emotion,
    );
  }

  String _generateCoreMessage(
    List<DreamSymbolData> symbols,
    EmotionalTone emotion,
    TimeLayer timeLayer,
    MoonPhase moonPhase,
  ) {
    if (symbols.isEmpty) {
      return 'Bilinçaltın seninle simgesiz, doğrudan konuşuyor. Bu rüyanın özünde bir duygu mesajı var.';
    }

    final mainSymbol = symbols.first;
    final timeMessage = _getTimeLayerMessage(timeLayer);
    final emotionMessage = emotion.hint;

    return '${mainSymbol.emoji} ${mainSymbol.symbolTr} sembolü bilinçaltının ana mesajcısı. '
        '$timeMessage $emotionMessage ${moonPhase.meaning}';
  }

  String _getTimeLayerMessage(TimeLayer layer) {
    switch (layer) {
      case TimeLayer.gecmis:
        return 'Bu rüya geçmişten tamamlanmamış bir iş taşıyor.';
      case TimeLayer.simdi:
        return 'Bu rüya şu anki yaşamındaki bir durumu yansıtıyor.';
      case TimeLayer.gelecek:
        return 'Bu rüya yaklaşan bir değişimin habercisi.';
      case TimeLayer.dongusel:
        return 'Bu tekrarlayan örüntü, kırılması gereken bir döngüye işaret ediyor.';
    }
  }

  String _getMoonPhaseMessage(MoonPhase phase) {
    // Gelişmiş ay fazı detaylarını kullan
    final phaseKey = _getMoonPhaseKey(phase);
    final phaseDetail = AstroRuyaKorelasyonlari.ayFaziDetay[phaseKey];

    if (phaseDetail != null) {
      return '${phaseDetail.emoji} ${phaseDetail.phase}: ${phaseDetail.dreamQuality}. '
          '${phaseDetail.ritualAdvice}';
    }

    // Fallback
    switch (phase) {
      case MoonPhase.yeniay:
        return 'Yeniay fazında gelen bu rüya, yeni bir niyet tohumu taşıyor. Bugün bir dilek tut.';
      case MoonPhase.hilal:
        return 'Hilal Ay döneminde gelen rüyalar büyüme potansiyelini gösterir. Cesaretle ilerle.';
      case MoonPhase.ilkDordun:
        return 'İlk Dördün\'de gelen bu rüya bir karar noktasına işaret ediyor. İki yol arasındasın.';
      case MoonPhase.dolunay:
        return 'Dolunay\'da gelen rüyalar farkındalık doruk noktasıdır. Gördüklerini kabul et.';
      case MoonPhase.sonDordun:
        return 'Son Dördün fazında gelen bu rüya bırakma zamanını gösteriyor. Neyi bırakman gerekiyor?';
      case MoonPhase.karanlikAy:
        return 'Karanlık Ay\'da gelen rüyalar en kadim mesajları taşır. Derin dinle.';
    }
  }

  String _getMoonPhaseKey(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.yeniay:
        return 'yeniay';
      case MoonPhase.hilal:
        return 'hilal';
      case MoonPhase.ilkDordun:
        return 'ilkDordun';
      case MoonPhase.dolunay:
        return 'dolunay';
      case MoonPhase.sonDordun:
        return 'sonDordun';
      case MoonPhase.karanlikAy:
        return 'karanlikAy';
    }
  }

  String _getWhyNowMessage(MoonPhase phase, TimeLayer layer) {
    final phaseContext = phase.meaning;
    final layerContext = layer.meaning;
    return 'Bu rüya tam da şu an geldi çünkü $phaseContext ve $layerContext '
        'Evren, bu mesajı senin için mükemmel zamanda gönderdi.';
  }

  String _detectDominantArchetype(
    List<DreamSymbolData> symbols,
    EmotionalTone emotion,
  ) {
    // Sembol arketiplerini say
    final archetypeCounts = <String, int>{};
    for (final symbol in symbols) {
      for (final archetype in symbol.archetypes) {
        archetypeCounts[archetype] = (archetypeCounts[archetype] ?? 0) + 1;
      }
    }

    // Duygu bazlı ağırlık ekle
    if (emotion == EmotionalTone.korku) {
      archetypeCounts['Gölge'] = (archetypeCounts['Gölge'] ?? 0) + 2;
    } else if (emotion == EmotionalTone.ozlem) {
      archetypeCounts['Anima'] = (archetypeCounts['Anima'] ?? 0) + 2;
      archetypeCounts['Animus'] = (archetypeCounts['Animus'] ?? 0) + 2;
    } else if (emotion == EmotionalTone.heyecan) {
      archetypeCounts['Kahraman'] = (archetypeCounts['Kahraman'] ?? 0) + 2;
    }

    if (archetypeCounts.isEmpty) return 'Gölge';

    return archetypeCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  TimeLayer _inferTimeLayer(DreamInput input) {
    final text = input.dreamDescription.toLowerCase();

    if (text.contains('çocukluğumda') ||
        text.contains('eskiden') ||
        text.contains('eski evim') ||
        text.contains('annem') ||
        text.contains('babam')) {
      return TimeLayer.gecmis;
    }

    if (text.contains('yarın') ||
        text.contains('gelecekte') ||
        text.contains('olacak')) {
      return TimeLayer.gelecek;
    }

    if (input.isRecurring) {
      return TimeLayer.dongusel;
    }

    return TimeLayer.simdi;
  }

  DreamRole _inferRole(String dreamText) {
    final text = dreamText.toLowerCase();

    if (text.contains('kaçıyordum') ||
        text.contains('kovalıyordu') ||
        text.contains('kaçtım')) {
      return DreamRole.kacan;
    }

    if (text.contains('izliyordum') ||
        text.contains('seyrediyordum') ||
        text.contains('gözlemliyordum')) {
      return DreamRole.izleyici;
    }

    if (text.contains('arıyordum') ||
        text.contains('bulamadım') ||
        text.contains('kayboldum')) {
      return DreamRole.arayan;
    }

    if (text.contains('kurtardım') || text.contains('yardım ettim')) {
      return DreamRole.kurtarici;
    }

    if (text.contains('saklanıyordum') || text.contains('gizleniyordum')) {
      return DreamRole.saklanan;
    }

    return DreamRole.kahraman;
  }

  // Duygusal okuma yardımcıları
  String _getSurfaceMessage(EmotionalTone tone) {
    final messages = {
      EmotionalTone.korku:
          'Yüzeyde bir alarm çalıyor - dikkatini çeken bir tehdit var.',
      EmotionalTone.huzur: 'İç dünyanda bir denge hissediyorsun - bu değerli.',
      EmotionalTone.merak:
          'Keşfetme dürtüsü aktif - sorular cevaplardan daha önemli.',
      EmotionalTone.sucluluk:
          'Bir şey yanlış hissettiriyor - ama gerçekten öyle mi?',
      EmotionalTone.ozlem: 'Kalbinde bir boşluk var - doldurulması gereken.',
      EmotionalTone.heyecan: 'Enerji yükseliyor - yeni bir şey kapıda.',
      EmotionalTone.donukluk:
          'Duygular geçici olarak susturulmuş - koruma mekanizması.',
      EmotionalTone.ofke: 'Sınırlar zorlanmış - güç geri alınmak istiyor.',
    };
    return messages[tone]!;
  }

  String _getDeeperMeaning(EmotionalTone tone) {
    final messages = {
      EmotionalTone.korku:
          'Korkunun altında genellikle sevgi vardır. Neyi kaybetmekten korkuyorsun?',
      EmotionalTone.huzur:
          'Bu huzur, çatışmanın çözüldüğüne işaret. Hangi iç savaş sona erdi?',
      EmotionalTone.merak:
          'Merak, ruhun büyüme çağrısıdır. Bilinmeyene açılmaya hazırsın.',
      EmotionalTone.sucluluk:
          'Suçluluk bazen başkalarının sesini içselleştirmektir. Bu ses kimin?',
      EmotionalTone.ozlem:
          'Özlem, kaybedilen bütünlüğe dönüş arzusudur. Ne zaman bütün hissettin?',
      EmotionalTone.heyecan:
          'Heyecan, yaşam enerjisinin doruğudur. Bu enerjiyi nereye yönlendireceksin?',
      EmotionalTone.donukluk:
          'Donukluk, çok fazla hissetmekten korumadır. Neyi hissetmekten kaçınıyorsun?',
      EmotionalTone.ofke:
          'Öfke, bastırılmış gücün sesidir. Gücünü nerede geri istiyorsun?',
    };
    return messages[tone]!;
  }

  String _getShadowQuestion(EmotionalTone tone) {
    final questions = {
      EmotionalTone.korku: 'Korktuğun şey gerçekleşse ne olurdu?',
      EmotionalTone.huzur: 'Bu huzuru sabote eden düşünce hangisi?',
      EmotionalTone.merak: 'Cevabını bulmaktan korktuğun soru ne?',
      EmotionalTone.sucluluk: 'Kendini affetsen ne değişirdi?',
      EmotionalTone.ozlem:
          'Özlediğin şey geri gelse, onu kabul edebilir misin?',
      EmotionalTone.heyecan: 'Bu heyecan sönse ne kalır?',
      EmotionalTone.donukluk: 'Hissetseydin ne hissederdin?',
      EmotionalTone.ofke: 'Öfkenin altında hangi acı var?',
    };
    return questions[tone]!;
  }

  String _getIntegrationPath(EmotionalTone tone) {
    final paths = {
      EmotionalTone.korku:
          'Korkuyla yüzleş, ama nazik ol. Korktuğun şeye küçük adımlarla yaklaş.',
      EmotionalTone.huzur:
          'Bu huzuru hatırla ve günlük hayatına taşı. Meditasyonla pekiştir.',
      EmotionalTone.merak:
          'Sorularını yaz, cevapları aramak yerine sorularla yaşamayı öğren.',
      EmotionalTone.sucluluk:
          'Suçluluğu incele: gerçek mi, öğrenilmiş mi? Kendine mektup yaz.',
      EmotionalTone.ozlem:
          'Özlemi onurlandır ama şimdide kal. Kaybı kabul, geleceğe kapı açar.',
      EmotionalTone.heyecan: 'Heyecanı eyleme dönüştür. Bugün bir adım at.',
      EmotionalTone.donukluk:
          'Bedenine dön. Hareket et, nefes al, yavaş yavaş hisset.',
      EmotionalTone.ofke:
          'Öfkeyi sağlıklı ifade et: spor, yazı, yaratıcılık. Ama birini incitme.',
    };
    return paths[tone]!;
  }

  // Işık/Gölge mesajları
  String _generateLightMessage(List<DreamSymbolData> symbols) {
    if (symbols.isEmpty) {
      return 'Bu rüya, iç dünyanın temiz ve aydınlık bir alanından geliyor.';
    }
    final lightAspects = symbols.map((s) => s.lightAspect).take(2).join(' ');
    return 'Işık yönü: $lightAspects Bu potansiyeli kucakla.';
  }

  String _generateShadowMessage(List<DreamSymbolData> symbols) {
    if (symbols.isEmpty) {
      return 'Gölge her zaman vardır, ama bu rüyada nazikçe bekliyor.';
    }
    final shadowAspects = symbols.map((s) => s.shadowAspect).take(2).join(' ');
    return 'Gölge uyarısı: $shadowAspects Farkında ol, ama korkma.';
  }

  String _generateIntegrationPath(String archetype) {
    final paths = {
      'Gölge': 'Gölgeyle dost ol. Reddettiğin yönlerini tanı ve kabul et.',
      'Anima': 'İçindeki feminen bilgeliği onurlandır. Sezgine güven.',
      'Animus': 'İçindeki maskülen gücü dengeli kullan. Kararlı ama nazik ol.',
      'Kahraman': 'Cesaretin değerli ama alçakgönüllülüğü unutma.',
      'Bilge Yaşlı': 'Bilgeliğini paylaş ama öğrenmeye açık kal.',
      'Büyük Anne': 'Besleme kapasiteni hem kendine hem başkalarına yönelt.',
      'Düzenbaz': 'Oyunculuğunu yıkıcı değil yaratıcı kullan.',
      'Çocuk': 'İç çocuğunla bağlantını koru, merakını besle.',
    };
    return paths[archetype] ??
        'Bu arketipi tanı ve günlük hayatına entegre et.';
  }

  // Pratik rehberlik
  String _generateTodayAction(
    List<DreamSymbolData> symbols,
    EmotionalTone emotion,
  ) {
    if (emotion == EmotionalTone.korku) {
      return 'Bugün korktuğun bir şeye küçük bir adım at.';
    }
    if (emotion == EmotionalTone.ozlem) {
      return 'Bugün özlediğin kişiye/duruma dair bir anı yaz.';
    }
    if (symbols.isNotEmpty) {
      return 'Bugün ${symbols.first.symbolTr} sembolü hakkında 5 dakika düşün.';
    }
    return 'Bugün bu rüyayı bir günlüğe yaz ve duygularını kaydet.';
  }

  String _generateReflectionQuestion(List<DreamSymbolData> symbols) {
    if (symbols.isEmpty) {
      return 'Bu rüya bana ne söylemeye çalışıyor?';
    }
    return '${symbols.first.symbolTr} sembolü hayatımda neyi temsil ediyor?';
  }

  String _generateWeeklyFocus(String archetype, MoonPhase phase) {
    return 'Bu hafta $archetype arketipinin mesajına odaklan. ${phase.label} enerjisini kullan.';
  }

  String _generateAvoidance(EmotionalTone emotion) {
    final avoidances = {
      EmotionalTone.korku:
          'Bu hafta korkudan kaçmak için yapılan impulsif kararlardan kaçın.',
      EmotionalTone.huzur: 'Huzuru bozmak isteyenlerden nazikçe mesafe koy.',
      EmotionalTone.merak: 'Cevapsız sorulara tahammülsüzlükten kaçın.',
      EmotionalTone.sucluluk: 'Kendini aşırı yargılamaktan kaçın.',
      EmotionalTone.ozlem: 'Geçmişte takılıp kalmaktan kaçın.',
      EmotionalTone.heyecan: 'Enerjini dağıtmaktan kaçın, odaklan.',
      EmotionalTone.donukluk: 'Hissizliği normalleştirmekten kaçın.',
      EmotionalTone.ofke: 'Öfkeyi başkalarına yansıtmaktan kaçın.',
    };
    return avoidances[emotion]!;
  }

  String _generateWhisperQuote() {
    final quotes = [
      'Gece senin için konuştu, gündüz sen konuş.',
      'Rüya hatırlayan, ruhunu dinlemeye başlamıştır.',
      'Her sembol bir anahtar, her duygu bir kapı.',
      'Bilinçaltı yalan söylemez, sadece şifreyle konuşur.',
      'Gölgenden kaçamazsın, ama onunla dans edebilirsin.',
      'Kadim bilgelik fısıldar, sessizlikte duyan işitir.',
    ];
    return quotes[Random().nextInt(quotes.length)];
  }

  List<DreamExplorationLink> _generateExplorationLinks(List<String> symbols) {
    final links = <DreamExplorationLink>[
      const DreamExplorationLink(
        title: 'Doğum Haritanı Keşfet',
        description: 'Rüyandaki sembollerin natal haritanla bağlantısını gör',
        route: '/birth-chart',
        emoji: '🗺️',
        category: 'Astroloji',
      ),
      const DreamExplorationLink(
        title: 'Ay Takvimine Bak',
        description: 'Rüyanın geldiği ay fazının anlamını öğren',
        route: '/moon-rituals',
        emoji: '🌙',
        category: 'Ay',
      ),
      const DreamExplorationLink(
        title: 'Transitlerini İncele',
        description: 'Şu anki gezegen geçişlerinin rüyana etkisi',
        route: '/transits',
        emoji: '🪐',
        category: 'Astroloji',
      ),
      const DreamExplorationLink(
        title: 'Tarot Çek',
        description: 'Rüyanın mesajını tarot ile derinleştir',
        route: '/tarot',
        emoji: '🃏',
        category: 'Kehanet',
      ),
    ];

    // Sembollere göre özel linkler ekle
    if (symbols.contains('water') || symbols.contains('ocean')) {
      links.add(
        const DreamExplorationLink(
          title: 'Neptün Transiti',
          description: 'Su sembolleri Neptün enerjisiyle bağlantılı',
          route: '/transits',
          emoji: '🌊',
          category: 'Astroloji',
        ),
      );
    }

    if (symbols.contains('death') || symbols.contains('transformation')) {
      links.add(
        const DreamExplorationLink(
          title: 'Plüton Analizi',
          description: 'Dönüşüm sembolleri Plüton ile resonansa girer',
          route: '/transits',
          emoji: '♇',
          category: 'Astroloji',
        ),
      );
    }

    return links.take(4).toList();
  }

  // Yardımcı parserlar
  DreamRole? _parseRole(String? role) {
    if (role == null) return null;
    try {
      return DreamRole.values.firstWhere((r) => r.name == role);
    } catch (_) {
      return null;
    }
  }

  TimeLayer? _parseTimeLayer(String? layer) {
    if (layer == null) return null;
    try {
      return TimeLayer.values.firstWhere((t) => t.name == layer);
    } catch (_) {
      return null;
    }
  }

  EmotionalReading _defaultEmotionalReading() {
    return const EmotionalReading(
      dominantEmotion: EmotionalTone.merak,
      surfaceMessage: 'Bilinçaltın seninle konuşmak istiyor.',
      deeperMeaning: 'Bu rüya derinlerde bir mesaj taşıyor.',
      shadowQuestion: 'Görmekten kaçındığın ne?',
      integrationPath: 'Rüyanı günlüğe yaz ve sembollerini araştır.',
    );
  }

  LightShadowReading _defaultLightShadow() {
    return const LightShadowReading(
      lightMessage: 'Bu rüya içinde bir hediye saklıyor.',
      shadowMessage: 'Farkındalık gerektiren bir alan var.',
      integrationPath: 'Işık ve gölgeyi dengede tut.',
      archetype: 'Benlik',
    );
  }

  PracticalGuidance _defaultGuidance() {
    return const PracticalGuidance(
      todayAction: 'Bu rüyayı bir günlüğe yaz.',
      reflectionQuestion: 'Bu rüya hayatımdaki hangi durumu yansıtıyor?',
      weeklyFocus: 'Rüya sembollerine dikkat et.',
      avoidance: 'Rüyayı görmezden gelmekten kaçın.',
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// AY FAZI HESAPLAMA
// ═══════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════
// BURÇ-BAZLI RÜYA ANALİZİ
// ═══════════════════════════════════════════════════════════════

/// Burç bazlı rüya içgörüleri
class ZodiacDreamInsights {
  /// Burca özel rüya analizi
  static ZodiacDreamProfile? getProfile(String zodiacSign) {
    final normalizedSign = zodiacSign.toLowerCase().trim();
    return AstroRuyaKorelasyonlari.burcRuyaProfili[normalizedSign];
  }

  /// Burca özel rüya tavsiyesi
  static String getDreamAdvice(String zodiacSign) {
    final profile = getProfile(zodiacSign);
    return profile?.dreamAdvice ?? 'Rüyalarına dikkat et, mesajlar var.';
  }

  /// Burca özel lucid eğilimi
  static String getLucidTendency(String zodiacSign) {
    final profile = getProfile(zodiacSign);
    return profile?.lucidTendency ?? 'Orta';
  }

  /// Burca özel şifa sembolleri
  static List<String> getHealingSymbols(String zodiacSign) {
    final profile = getProfile(zodiacSign);
    return profile?.healingSymbols ?? [];
  }

  /// Burca özel yaygın temalar
  static List<String> getCommonThemes(String zodiacSign) {
    final profile = getProfile(zodiacSign);
    return profile?.commonThemes ?? [];
  }

  /// Burca özel kâbus temaları
  static List<String> getNightmareThemes(String zodiacSign) {
    final profile = getProfile(zodiacSign);
    return profile?.nightmareThemes ?? [];
  }
}

// ═══════════════════════════════════════════════════════════════
// LUCID RÜYA REHBERİ SERVİSİ
// ═══════════════════════════════════════════════════════════════

/// Lucid rüya teknikleri ve tavsiyeleri
class LucidDreamService {
  /// Zorluk seviyesine göre teknik öner
  static List<LucidTechnique> getTechniquesForLevel(String level) {
    return LucidRuyaRehberi.teknikler
        .where((t) => t.difficulty == level)
        .toList();
  }

  /// Başlangıç için önerilen teknik
  static LucidTechnique get beginnerTechnique {
    return LucidRuyaRehberi.teknikler.first; // Reality Check
  }

  /// Rastgele lucid aktivite öner
  static String getRandomActivity() {
    final activities = LucidRuyaRehberi.lucidAktiviteler;
    return activities[Random().nextInt(activities.length)];
  }

  /// Stabilizasyon teknikleri
  static List<String> get stabilizationTechniques {
    return LucidRuyaRehberi.stabilizasyonTeknikleri;
  }

  /// Sorun için çözüm bul
  static String? getSolutionForProblem(String problem) {
    return LucidRuyaRehberi.sorunCozumleri[problem];
  }

  /// Tüm sorun-çözüm çiftleri
  static Map<String, String> get allProblems {
    return LucidRuyaRehberi.sorunCozumleri;
  }
}

// ═══════════════════════════════════════════════════════════════
// TEKRARLAYAN RÜYA ANALİZİ
// ═══════════════════════════════════════════════════════════════

/// Tekrarlayan rüya kalıplarını analiz et
class RecurringDreamAnalyzer {
  /// Rüya metninden kalıp tespit et
  static RecurringDreamPattern? detectPattern(String dreamText) {
    final text = dreamText.toLowerCase();

    for (final pattern in TekrarlayanRuyaKaliplari.kaliplar) {
      for (final keyword in pattern.commonSymbols) {
        if (text.contains(keyword.toLowerCase())) {
          return pattern;
        }
      }
    }

    return null;
  }

  /// Tüm olası kalıpları kontrol et ve eşleşenleri döndür
  static List<RecurringDreamPattern> detectAllPatterns(String dreamText) {
    final text = dreamText.toLowerCase();
    final matchedPatterns = <RecurringDreamPattern>[];

    for (final pattern in TekrarlayanRuyaKaliplari.kaliplar) {
      for (final keyword in pattern.commonSymbols) {
        if (text.contains(keyword.toLowerCase())) {
          matchedPatterns.add(pattern);
          break;
        }
      }
    }

    return matchedPatterns;
  }

  /// Kalıp için kırma yöntemi öner
  static String getBreakingAdvice(RecurringDreamPattern pattern) {
    return pattern.breakingAdvice;
  }
}

// ═══════════════════════════════════════════════════════════════
// KÂBUS DÖNÜŞÜM SERVİSİ
// ═══════════════════════════════════════════════════════════════

/// Kâbusları şifa fırsatına dönüştürme
class NightmareTransformationService {
  /// Kâbus tipini tespit et
  static NightmareGuide? detectNightmareType(String dreamText) {
    final text = dreamText.toLowerCase();

    for (final nightmare in KabusDonusumRehberi.rehberler) {
      if (text.contains(nightmare.nightmareType.toLowerCase()) ||
          text.contains(nightmare.title.toLowerCase())) {
        return nightmare;
      }
    }

    return null;
  }

  /// Dönüşüm affirmasyonu
  static String getTransformationMessage(NightmareGuide nightmare) {
    return nightmare.transformationMessage;
  }

  /// Entegrasyon adımları
  static List<String> getIntegrationSteps(NightmareGuide nightmare) {
    return nightmare.integrationSteps;
  }

  /// Güçlendirme notu
  static String getEmpowermentNote(NightmareGuide nightmare) {
    return nightmare.empowermentNote;
  }
}

// ═══════════════════════════════════════════════════════════════
// RÜYA RİTÜELİ SERVİSİ
// ═══════════════════════════════════════════════════════════════

/// Rüya ritüelleri yönetimi
class DreamRitualService {
  /// Uyku öncesi ritüeller
  static List<DreamRitual> get preSleepRituals {
    return RuyaRituelleri.uykuOncesi;
  }

  /// Sabah ritüelleri
  static List<DreamRitual> get morningRituals {
    return RuyaRituelleri.sabah;
  }

  /// Haftalık ritüeller
  static List<DreamRitual> get weeklyRituals {
    return RuyaRituelleri.haftalik;
  }

  /// Ay fazına göre ritüel öner
  static List<String> getRitualsForMoonPhase(MoonPhase phase) {
    final phaseKey = _getPhaseKey(phase);
    return RuyaRituelleri.ayFaziRituelleri[phaseKey] ?? [];
  }

  static String _getPhaseKey(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.yeniay:
        return 'yeniay';
      case MoonPhase.hilal:
        return 'hilal';
      case MoonPhase.ilkDordun:
        return 'ilkDordun';
      case MoonPhase.dolunay:
        return 'dolunay';
      case MoonPhase.sonDordun:
        return 'sonDordun';
      case MoonPhase.karanlikAy:
        return 'karanlikAy';
    }
  }

  /// İhtiyaca göre ritüel öner
  static DreamRitual? suggestRitual(String need) {
    final allRituals = [
      ...preSleepRituals,
      ...morningRituals,
      ...weeklyRituals,
    ];
    final normalizedNeed = need.toLowerCase();

    for (final ritual in allRituals) {
      if (ritual.bestFor.toLowerCase().contains(normalizedNeed)) {
        return ritual;
      }
    }

    return null;
  }
}

// ═══════════════════════════════════════════════════════════════
// GEZEGENSEl ETKİ ANALİZİ
// ═══════════════════════════════════════════════════════════════

/// Gezegen transitlerinin rüyalara etkisi
class PlanetaryDreamInfluenceService {
  /// Gezegen etkisi bilgisi al
  static PlanetaryDreamInfluence? getPlanetInfluence(String planet) {
    return AstroRuyaKorelasyonlari.gezegenEtkileri.firstWhere(
      (p) => p.planet.toLowerCase() == planet.toLowerCase(),
      orElse: () => AstroRuyaKorelasyonlari.gezegenEtkileri.first,
    );
  }

  /// Neptün aktifken (rüyalar yoğun)
  static PlanetaryDreamInfluence get neptuneInfluence {
    return AstroRuyaKorelasyonlari.gezegenEtkileri.firstWhere(
      (p) => p.planet == 'Neptün',
    );
  }

  /// Ay burç etkisi
  static String getMoonSignEffect(String moonSign) {
    final moonInfluence = AstroRuyaKorelasyonlari.gezegenEtkileri.firstWhere(
      (p) => p.planet == 'Ay',
    );
    return moonInfluence.signInfluences[moonSign] ?? 'Genel ay enerjisi aktif.';
  }

  /// Retro döneminde rüya notları
  static String getRetroGradeNotes(String planet) {
    final influence = getPlanetInfluence(planet);
    if (influence != null && influence.signInfluences.containsKey('Retro')) {
      return influence.signInfluences['Retro']!;
    }
    return '$planet retro döneminde rüyalar daha yoğun ve geçmişe dönük olabilir.';
  }
}

// ═══════════════════════════════════════════════════════════════
// HIZLI SEMBOL ARAMA
// ═══════════════════════════════════════════════════════════════

/// Hızlı sembol sözlüğü erişimi
class QuickSymbolLookup {
  /// Sembol anlamı ara
  static String? lookup(String symbol) {
    return HizliSembolSozlugu.bul(symbol);
  }

  /// Tüm sembolleri alfabetik getir
  static List<MapEntry<String, String>> get allSymbols {
    return HizliSembolSozlugu.alfabetik;
  }

  /// Sembol mevcut mu kontrol et
  static bool hasSymbol(String symbol) {
    return HizliSembolSozlugu.bul(symbol) != null;
  }
}

// ═══════════════════════════════════════════════════════════════
// AY FAZI HESAPLAMA
// ═══════════════════════════════════════════════════════════════

/// Ay fazı hesaplama yardımcısı
class MoonPhaseCalculator {
  /// Verilen tarih için ay fazını hesapla
  static MoonPhase calculate(DateTime date) {
    // Basit ay fazı hesabı (synodic month = 29.53 gün)
    // Referans: 6 Ocak 2000 yeniay
    final reference = DateTime(2000, 1, 6);
    final daysSinceReference = date.difference(reference).inDays;
    final synodicMonth = 29.53;
    final dayInCycle = (daysSinceReference % synodicMonth);

    if (dayInCycle < 1.85) {
      return MoonPhase.yeniay;
    } else if (dayInCycle < 7.38) {
      return MoonPhase.hilal;
    } else if (dayInCycle < 11.07) {
      return MoonPhase.ilkDordun;
    } else if (dayInCycle < 14.76) {
      return MoonPhase.dolunay;
    } else if (dayInCycle < 22.14) {
      return MoonPhase.sonDordun;
    } else {
      return MoonPhase.karanlikAy;
    }
  }

  /// Bugünün ay fazı
  static MoonPhase get today => calculate(DateTime.now());
}
