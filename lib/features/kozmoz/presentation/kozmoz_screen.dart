import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart' as zodiac;
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Kozmoz - AI Astroloji Asistanı
/// Kullanıcının astroloji, burç, transit, numeroloji sorularını yanıtlar
class KozmozScreen extends ConsumerStatefulWidget {
  const KozmozScreen({super.key});

  @override
  ConsumerState<KozmozScreen> createState() => _KozmozScreenState();
}

class _KozmozScreenState extends ConsumerState<KozmozScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isTyping = false;
  late AnimationController _pulseController;

  // Önerilen sorular - kategorilere göre - MEGA GELİŞTİRİLMİŞ
  final List<Map<String, dynamic>> _suggestedQuestions = [
    // 🌟 GÜNLÜK & HAFTALIK YORUMLAR
    {
      'emoji': '🌅',
      'text':
          'Bugün hangi saatler benim için en şanslı ve enerjim en yüksek olacak?',
      'category': 'gunluk',
    },
    {
      'emoji': '⚡',
      'text':
          'Bugün dikkat etmem gereken tehlikeli saatler ve olası engeller neler?',
      'category': 'gunluk',
    },
    {
      'emoji': '🎯',
      'text': 'Bu hafta burçum için en önemli üç tavsiye nedir?',
      'category': 'gunluk',
    },
    {
      'emoji': '✨',
      'text':
          'Güneş, Ay ve yükselen burcuma göre bugünkü kozmik hava durumum ne?',
      'category': 'gunluk',
    },

    // 💕 AŞK & İLİŞKİLER
    {
      'emoji': '💘',
      'text':
          'Venüs ve Mars geçişlerine göre aşk hayatımda bu ay neler bekleniyor?',
      'category': 'ask',
    },
    {
      'emoji': '🔥',
      'text':
          'Doğum haritama göre ideal partnerim nasıl biri ve nerede tanışabilirim?',
      'category': 'ask',
    },
    {
      'emoji': '💔',
      'text':
          'İlişkimde yaşadığım zorlukların astrolojik kök nedenleri neler olabilir?',
      'category': 'ask',
    },
    {
      'emoji': '👫',
      'text':
          'Partnerimle synastry uyum analizimiz nasıl, güçlü ve zayıf noktalarımız neler?',
      'category': 'ask',
    },
    {
      'emoji': '💍',
      'text': 'Evlilik için en uygun astrolojik zamanlar bu yıl ne zaman?',
      'category': 'ask',
    },

    // 💼 KARİYER & PARA
    {
      'emoji': '📈',
      'text':
          'Doğum haritama göre en uygun kariyer yolları ve sektörler neler?',
      'category': 'kariyer',
    },
    {
      'emoji': '💰',
      'text':
          'Maddi bolluk ve finansal başarı için hangi dönemler benim için şanslı?',
      'category': 'kariyer',
    },
    {
      'emoji': '🚀',
      'text':
          'İş kurmak veya terfi almak için en uygun astrolojik pencere ne zaman?',
      'category': 'kariyer',
    },
    {
      'emoji': '🤝',
      'text': 'İş ortaklığı ve işbirliği için hangi burçlarla çalışmalıyım?',
      'category': 'kariyer',
    },

    // 🪐 TRANSİTLER & ZAMANLAMALAR
    {
      'emoji': '♄',
      'text':
          'Saturn return dönemim ne zaman ve bu büyük dönüşüme nasıl hazırlanmalıyım?',
      'category': 'transit',
    },
    {
      'emoji': '🌑',
      'text':
          'Merkür retrosu beni nasıl etkiliyor ve bu dönemde nelere dikkat etmeliyim?',
      'category': 'transit',
    },
    {
      'emoji': '🌕',
      'text': 'Bir sonraki dolunay burçumda mı ve hangi alanları tetikleyecek?',
      'category': 'transit',
    },
    {
      'emoji': '♃',
      'text':
          'Jüpiter transitim hangi evde ve bu dönem hangi konularda şanslıyım?',
      'category': 'transit',
    },
    {
      'emoji': '⏳',
      'text':
          'Bu yıl benim için kritik dönüm noktaları ve önemli tarihler neler?',
      'category': 'transit',
    },

    // 🗺️ DOĞUM HARİTASI DERİN ANALİZ
    {
      'emoji': '☀️',
      'text':
          'Güneş, Ay ve yükselen üçlümün kombinasyonu kişiliğimi nasıl şekillendiriyor?',
      'category': 'harita',
    },
    {
      'emoji': '🌙',
      'text': 'Ay düğümlerim ruhsal evrim yolculuğum hakkında ne söylüyor?',
      'category': 'harita',
    },
    {
      'emoji': '🏠',
      'text':
          'Doğum haritamdaki boş evler ve dolu evler yaşamımı nasıl etkiliyor?',
      'category': 'harita',
    },
    {
      'emoji': '⚔️',
      'text':
          'Haritamdaki zor açılar (kareler, karşıtlıklar) hangi yaşam derslerini getiriyor?',
      'category': 'harita',
    },
    {
      'emoji': '🎁',
      'text':
          'MC ve IC eksenime göre kariyer ve aile hayatım nasıl şekillenmeli?',
      'category': 'harita',
    },

    // 🔢 NUMEROLOJİ
    {
      'emoji': '1️⃣',
      'text': 'Yaşam yolu sayım, kaderimi ve hayat amacımı nasıl etkiliyor?',
      'category': 'numeroloji',
    },
    {
      'emoji': '🔮',
      'text': 'İsim numerolojim kişiliğim ve kaderim hakkında ne diyor?',
      'category': 'numeroloji',
    },
    {
      'emoji': '📅',
      'text':
          'Bu yıl kişisel yıl sayım kaç ve bu dönemde hangi temaları yaşayacağım?',
      'category': 'numeroloji',
    },
    {
      'emoji': '🎂',
      'text':
          'Doğum gününün sayısı güçlü yanlarım ve zayıf yanlarım hakkında ne anlatıyor?',
      'category': 'numeroloji',
    },

    // 🎴 TAROT & KEHâNET
    {
      'emoji': '🃏',
      'text':
          'Bugün için evrenin bana göndermek istediği en önemli tarot mesajı nedir?',
      'category': 'tarot',
    },
    {
      'emoji': '🌟',
      'text':
          'Şu anki durumum için geçmiş-şimdi-gelecek tarot açılımı yapabilir misin?',
      'category': 'tarot',
    },
    {
      'emoji': '❓',
      'text': 'Kafamdaki soruya evet/hayır tarot cevabı alabilir miyim?',
      'category': 'tarot',
    },

    // 🧘 SPİRİTÜEL GELİŞİM
    {
      'emoji': '🦋',
      'text':
          'Şu anki ruhsal uyanış ve bilinç genişlemesi sürecimde neredeyim?',
      'category': 'spiritüel',
    },
    {
      'emoji': '🧬',
      'text':
          'Karmik borçlarım ve geçmiş yaşam kalıntılarım bu hayatı nasıl etkiliyor?',
      'category': 'spiritüel',
    },
    {
      'emoji': '🌈',
      'text':
          'Çakra sistemim ve enerji bedenimin durumu nasıl, hangi çakralarım bloke?',
      'category': 'spiritüel',
    },
    {
      'emoji': '💎',
      'text':
          'Burcuma ve doğum haritama göre şifa taşlarım ve kristallerim neler olmalı?',
      'category': 'spiritüel',
    },
    {
      'emoji': '🕯️',
      'text': 'Bugünkü ay fazına uygun ritüel ve meditasyon önerilerin neler?',
      'category': 'spiritüel',
    },

    // 🔍 DERİN SORULAR
    {
      'emoji': '🎯',
      'text': 'Doğum haritama göre bu hayattaki gerçek amacım ve misyonum ne?',
      'category': 'derin',
    },
    {
      'emoji': '⚡',
      'text': 'Gizli yeteneklerim, aktive olmayı bekleyen potansiyelim nedir?',
      'category': 'derin',
    },
    {
      'emoji': '🌪️',
      'text':
          'Hayatımda döngüsel olarak tekrarlayan kalıplar ve bunların astrolojik açıklaması ne?',
      'category': 'derin',
    },
    {
      'emoji': '🔓',
      'text': 'Beni geride tutan blokajlar ve onların kozmik kökleri neler?',
      'category': 'derin',
    },

    // 🌙 RÜYA & BİLİNÇALTI (YENİ)
    {
      'emoji': '💭',
      'text':
          'Rüyalarım astrolojik olarak ne anlama geliyor? Bugün gördüğüm rüyayı yorumla.',
      'category': 'ruya',
    },
    {
      'emoji': '🌌',
      'text': 'Bilinçaltım bu dönemde hangi mesajları gönderiyor?',
      'category': 'ruya',
    },
    {
      'emoji': '🛏️',
      'text':
          'Uyku kalitem ve rüya döngülerim ay fazlarından nasıl etkileniyor?',
      'category': 'ruya',
    },
    {
      'emoji': '👁️‍🗨️',
      'text': 'Lüsid rüya görmek için en uygun kozmik zamanlar ne zaman?',
      'category': 'ruya',
    },

    // ༄ TANTRA & ENERJİ (YENİ)
    {
      'emoji': '🔥',
      'text':
          'Kundalini enerjimin şu anki durumu ve uyanış süreci hakkında ne söyleyebilirsin?',
      'category': 'tantra',
    },
    {
      'emoji': '💫',
      'text': 'Cinsel enerjimi yaratıcı ve ruhsal güce nasıl dönüştürebilirim?',
      'category': 'tantra',
    },
    {
      'emoji': '🧘',
      'text': 'Burcuma özel nefes çalışması ve meditasyon teknikleri neler?',
      'category': 'tantra',
    },
    {
      'emoji': '⚡',
      'text': 'Enerji bedenimde blokajlar var mı? Nasıl temizleyebilirim?',
      'category': 'tantra',
    },

    // 🌿 ŞIFA & SAĞLIK (YENİ)
    {
      'emoji': '🩺',
      'text':
          'Doğum haritama göre zayıf organlarım ve dikkat etmem gereken sağlık konuları neler?',
      'category': 'saglik',
    },
    {
      'emoji': '🍃',
      'text':
          'Burcuma uygun bitkisel şifa yöntemleri ve doğal tedaviler neler?',
      'category': 'saglik',
    },
    {
      'emoji': '🥗',
      'text':
          'Astrolojik beslenme: Burcuma göre hangi yiyecekler bana iyi geliyor?',
      'category': 'saglik',
    },
    {
      'emoji': '🧪',
      'text': 'Detoks ve arınma için en uygun ay fazları ve dönemler ne zaman?',
      'category': 'saglik',
    },

    // 🏠 EV & AİLE (YENİ)
    {
      'emoji': '🏡',
      'text':
          'Ev satın alma veya taşınma için en uygun astrolojik dönem ne zaman?',
      'category': 'ev',
    },
    {
      'emoji': '👨‍👩‍👧‍👦',
      'text':
          'Aile dinamiklerim ve anne-baba ilişkilerim astrolojik olarak nasıl açıklanıyor?',
      'category': 'ev',
    },
    {
      'emoji': '👶',
      'text': 'Çocuk sahibi olmak için en uygun kozmik zamanlar ne zaman?',
      'category': 'ev',
    },
    {
      'emoji': '🐕',
      'text':
          'Evcil hayvan sahiplenmek için uygun dönem ve burcuma uygun hayvan türleri neler?',
      'category': 'ev',
    },

    // ✈️ SEYAHAT & MACERA (YENİ)
    {
      'emoji': '🗺️',
      'text': 'Astrolojik coğrafya: Hangi şehir ve ülkeler benim için şanslı?',
      'category': 'seyahat',
    },
    {
      'emoji': '✈️',
      'text': 'Seyahat planlamak için en uygun ve en riskli dönemler ne zaman?',
      'category': 'seyahat',
    },
    {
      'emoji': '🏖️',
      'text': 'Tatil planlarken hangi destinasyonlar enerjime uygun?',
      'category': 'seyahat',
    },

    // 📚 EĞİTİM & ÖĞRENME (YENİ)
    {
      'emoji': '📖',
      'text': 'Hangi konuları öğrenmek için doğal yeteneğim var?',
      'category': 'egitim',
    },
    {
      'emoji': '🎓',
      'text':
          'Sınav, mülakatlar ve önemli sunumlar için en uygun tarihler neler?',
      'category': 'egitim',
    },
    {
      'emoji': '✍️',
      'text':
          'Yaratıcı yazarlık ve sanatsal ifade için en verimli dönemlerim ne zaman?',
      'category': 'egitim',
    },

    // 🌑 GÖLGE ÇALIŞMASI (YENİ)
    {
      'emoji': '🖤',
      'text': 'Gölge benliğim nedir ve onunla nasıl barışabilirim?',
      'category': 'golge',
    },
    {
      'emoji': '😈',
      'text': 'Korkularım ve bastırılmış duygularımın astrolojik kökeni ne?',
      'category': 'golge',
    },
    {
      'emoji': '🌑',
      'text': 'Karanlık ay dönemlerinde hangi gölge çalışmalarını yapmalıyım?',
      'category': 'golge',
    },
    {
      'emoji': '🪞',
      'text':
          'Projeksiyon kalıplarım: Başkalarında beni rahatsız eden şeyler aslında neyi gösteriyor?',
      'category': 'golge',
    },

    // 🌟 MANİFESTASYON (YENİ)
    {
      'emoji': '✨',
      'text': 'Manifestasyon için en güçlü kozmik pencereler bu ay ne zaman?',
      'category': 'manifestasyon',
    },
    {
      'emoji': '🎯',
      'text': 'Niyetlerimi güçlendirmek için hangi ay fazlarını kullanmalıyım?',
      'category': 'manifestasyon',
    },
    {
      'emoji': '📝',
      'text': 'Bolluk ve bereket çekmek için burcuma özel ritüeller neler?',
      'category': 'manifestasyon',
    },
    {
      'emoji': '🌈',
      'text': 'Vizyon panosu oluşturmak için en uygun astrolojik zaman ne?',
      'category': 'manifestasyon',
    },

    // 🔮 MİSTİK SORULAR (YENİ)
    {
      'emoji': '🌀',
      'text': 'Geçmiş yaşamlarım hakkında doğum haritam ne söylüyor?',
      'category': 'mistik',
    },
    {
      'emoji': '👼',
      'text': 'Koruyucu meleklerim ve ruhsal rehberlerim kimler?',
      'category': 'mistik',
    },
    {
      'emoji': '🌠',
      'text': 'Yıldız tohumları ve kozmik kökenlerim hakkında ne biliyorsun?',
      'category': 'mistik',
    },
    {
      'emoji': '🕸️',
      'text': 'Akashik kayıtlarım bu hayat hakkında ne diyor?',
      'category': 'mistik',
    },

    // 💎 KRİSTAL & TAŞ (YENİ)
    {
      'emoji': '💎',
      'text': 'Burcuma ve doğum haritama göre güç taşlarım neler?',
      'category': 'kristal',
    },
    {
      'emoji': '🔮',
      'text':
          'Bu dönem hangi kristalleri taşımalıyım ve nasıl aktive etmeliyim?',
      'category': 'kristal',
    },
    {
      'emoji': '💍',
      'text': 'Mücevher seçerken hangi taşlardan kaçınmalıyım?',
      'category': 'kristal',
    },

    // 🌿 RİTÜEL & TÖRENSELLİK (YENİ)
    {
      'emoji': '🕯️',
      'text': 'Dolunay ritüeli: Bu ay neyi bırakmalı, neyi kutlamalıyım?',
      'category': 'ritual',
    },
    {
      'emoji': '🌑',
      'text': 'Yeni ay niyeti: Bu döngüde hangi tohumları ekmeliyim?',
      'category': 'ritual',
    },
    {
      'emoji': '🌸',
      'text': 'Mevsimsel geçiş ritüelleri: Bu mevsimi nasıl karşılamalıyım?',
      'category': 'ritual',
    },
    {
      'emoji': '🔥',
      'text':
          'Enerji temizliği için en etkili ritüeller ve zamanlamalar neler?',
      'category': 'ritual',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _addWelcomeMessage() {
    final userProfile = ref.read(userProfileProvider);
    final sign = userProfile?.sunSign ?? zodiac.ZodiacSign.aries;
    final userName = userProfile?.name ?? 'Yolcu';

    setState(() {
      _messages.add(
        _ChatMessage(
          text:
              'Merhaba $userName! 🌟\n\n'
              'Ben Kozmoz İzi, senin kozmik rehberin. ${sign.nameTr} burcunun enerjisiyle '
              'astroloji, burç yorumları, transitler, numeroloji ve daha fazlası hakkında '
              'sorularını yanıtlamak için buradayım.\n\n'
              'Bana her şeyi sorabilirsin - günlük burç yorumundan, '
              'doğum haritası analizine, ilişki uyumundan, '
              'kozmik zamanlamaya kadar...\n\n'
              '✨ Hadi başlayalım! Ne öğrenmek istersin?\n\n'
              '⚠️ ${DisclaimerTexts.astrology}',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  void _sendMessage([String? quickMessage]) async {
    final text = quickMessage ?? _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        _ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // AI yanıtı oluştur
    await Future.delayed(
      const Duration(milliseconds: 800 + 400),
    ); // Simüle typing
    _generateResponse(text);
  }

  void _generateResponse(String userMessage) {
    final userProfile = ref.read(userProfileProvider);
    final sign = userProfile?.sunSign ?? zodiac.ZodiacSign.aries;
    final lowerMessage = userMessage.toLowerCase();

    String response;

    // Mesaj içeriğine göre yanıt üret - MEGA GENİŞLETİLMİŞ
    if (_containsAny(lowerMessage, [
      'bugün',
      'günlük',
      'gün nasıl',
      'bu gün',
    ])) {
      response = _getDailyResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'aşk',
      'sevgili',
      'ilişki',
      'partner',
      'evlilik',
      'flört',
    ])) {
      response = _getLoveResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'kariyer',
      'iş',
      'para',
      'maddi',
      'finans',
      'terfi',
    ])) {
      response = _getCareerResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'ay',
      'ay fazı',
      'dolunay',
      'yeniay',
      'lunar',
    ])) {
      response = _getMoonResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'saturn',
      'transit',
      'gezegen',
      'retro',
      'merkür',
    ])) {
      response = _getTransitResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'yükselen',
      'ascendant',
      'rising',
    ])) {
      response = _getRisingResponse(sign);
    } else if (_containsAny(lowerMessage, ['uyum', 'uyumlu', 'hangi burç'])) {
      response = _getCompatibilityResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'numeroloji',
      'sayı',
      'yaşam yolu',
    ])) {
      response = _getNumerologyResponse(sign);
    } else if (_containsAny(lowerMessage, ['tarot', 'kart', 'fal'])) {
      response = _getTarotResponse(sign);
    } else if (_containsAny(lowerMessage, ['aura', 'enerji beden'])) {
      response = _getAuraResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'ruhsal',
      'dönüşüm',
      'spiritüel',
      'uyanış',
    ])) {
      response = _getSpiritualResponse(sign);
    } else if (_containsAny(lowerMessage, ['hayat amacı', 'amaç', 'misyon'])) {
      response = _getLifePurposeResponse(sign);
    } else if (_containsAny(lowerMessage, ['yetenek', 'potansiyel', 'güçlü'])) {
      response = _getTalentResponse(sign);
      // YENİ KATEGORİLER - 10x GELİŞTİRME
    } else if (_containsAny(lowerMessage, [
      'rüya',
      'bilinçaltı',
      'uyku',
      'lüsid',
    ])) {
      response = _getDreamResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'tantra',
      'kundalini',
      'cinsel enerji',
      'nefes',
    ])) {
      response = _getTantraResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'sağlık',
      'hastalık',
      'organ',
      'beslenme',
      'detoks',
    ])) {
      response = _getHealthResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'ev',
      'taşınma',
      'aile',
      'çocuk',
      'evcil',
    ])) {
      response = _getHomeResponse(sign);
    } else if (_containsAny(lowerMessage, [
      'seyahat',
      'şehir',
      'ülke',
      'tatil',
      'destinasyon',
    ])) {
      response = _getTravelResponse(sign);
    } else if (_containsAny(lowerMessage, ['eğitim', 'öğrenme', 'sınav', 'mülakat', 'yazarlık'])) {
      response = _getEducationResponse(sign);
    } else if (_containsAny(lowerMessage, ['gölge', 'korku', 'karanlık', 'projeksiyon', 'bastır'])) {
      response = _getShadowResponse(sign);
    } else if (_containsAny(lowerMessage, ['manifestasyon', 'niyet', 'bolluk', 'çekim', 'vizyon'])) {
      response = _getManifestationResponse(sign);
    } else if (_containsAny(lowerMessage, ['geçmiş yaşam', 'melek', 'rehber', 'akashik', 'yıldız tohum'])) {
      response = _getMysticResponse(sign);
    } else if (_containsAny(lowerMessage, ['kristal', 'taş', 'mücevher', 'ametist', 'kuvars'])) {
      response = _getCrystalResponse(sign);
    } else if (_containsAny(lowerMessage, ['ritüel', 'tören', 'mevsim', 'temizlik', 'arın'])) {
      response = _getRitualResponse(sign);
    } else if (_containsAny(lowerMessage, ['çakra', 'bloke', 'enerji merkezi'])) {
      response = _getChakraResponse(sign);
    } else if (_containsAny(lowerMessage, ['merhaba', 'selam', 'hey', 'nasılsın'])) {
      response = _getGreetingResponse(sign);
    } else {
      response = _getGeneralResponse(sign, userMessage);
    }

    setState(() {
      _isTyping = false;
      _messages.add(
        _ChatMessage(text: response, isUser: false, timestamp: DateTime.now()),
      );
    });

    _scrollToBottom();
  }

  bool _containsAny(String text, List<String> keywords) {
    return keywords.any((keyword) => text.contains(keyword));
  }

  // ═══════════════════════════════════════════════════════════════
  // MEGA GELİŞTİRİLMİŞ YANIT GENERATÖRLERİ - 5000x DETAYLI
  // ═══════════════════════════════════════════════════════════════

  String _getDailyResponse(zodiac.ZodiacSign sign) {
    final now = DateTime.now();
    final moonSign = _getRandomMoonSign();
    final luckyHours = _getLuckyHours(sign);
    final dangerHours = _getDangerHours(sign);
    final element = sign.element;

    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} GÜNLÜK KOZMİK RAPOR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 ${now.day}.${now.month}.${now.year} | Ay: $moonSign Burcunda

🌅 SABAH ENERJİSİ (06:00 - 12:00)
${_getMorningEnergy(sign)}

☀️ ÖĞLE ENERJİSİ (12:00 - 18:00)
${_getAfternoonEnergy(sign)}

🌙 AKŞAM ENERJİSİ (18:00 - 24:00)
${_getEveningEnergy(sign)}

⭐ ŞANS SAATLERİN
$luckyHours
Bu saatlerde önemli görüşmeler, iş teklifleri ve yeni başlangıçlar için ideal.

⚠️ DİKKATLİ OLMASI GEREKEN SAATLER
$dangerHours
Bu saatlerde büyük kararlardan, tartışmalardan ve riskli yatırımlardan kaçın.

🎯 BUGÜNÜN 3 ALTIN TAVSİYESİ
${_getDailyAdvice(sign)}

💫 GÜNÜN AFİRMASYONU
"${_getDailyAffirmation(sign)}"

🔮 KOZMİK NOT
${element.nameTr} elementi olarak bugün ${_getElementDailyNote(element)}. Evrenin sana gönderdiği işaretlere açık ol - belki bir şarkı, bir kitap sayfası veya bir yabancının sözleri önemli mesajlar taşıyabilir.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ Unutma: Her gün yeni bir başlangıç fırsatıdır!''';
  }

  String _getLoveResponse(zodiac.ZodiacSign sign) {
    final venusSign = _getRandomMoonSign();
    final marsSign = _getRandomMoonSign();

    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} AŞK & İLİŞKİ ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💕 VENÜS POZİSYONU: $venusSign Burcunda
♂️ MARS POZİSYONU: $marsSign Burcunda

❤️ AŞK ENERJİN ŞU AN
${_getDetailedLoveEnergy(sign)}

🔥 SEVGİ DİLİN
${_getLoveLanguage(sign)}

💘 İDEAL PARTNER PROFİLİN
${_getIdealPartner(sign)}

👫 EN UYUMLU BURÇLARIN
━━━━━━━━━━━━━━━━━━━━
🟢 MÜKEMMEL UYUM (90-100%)
${_getPerfectMatches(sign)}

🟡 İYİ UYUM (70-89%)
${_getGoodMatches(sign)}

🟠 ORTA UYUM (50-69%)
${_getMediumMatches(sign)}

🔴 ZORLAYICI UYUM (30-49%)
${_getChallengingMatches(sign)}

💔 İLİŞKİDE DİKKAT ETMELERİN
${_getRelationshipWarnings(sign)}

🌹 BU DÖNEM AŞK İÇİN
${_getCurrentLovePeriod(sign)}

✨ AŞK RİTÜELİ ÖNERİSİ
${_getLoveRitual(sign)}

🔮 KOZMİK AŞK TAVSİYESİ
${_getLoveAdvice(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💝 Gerçek aşk, önce kendinle başlar!''';
  }

  String _getCareerResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} KARİYER & FİNANS ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💼 DOĞAL YETENEKLERİN
${_getDetailedCareerTalents(sign)}

🏆 EN UYGUN KARİYER YOLLARI
${_getBestCareerPaths(sign)}

📊 SEKTÖR ÖNERİLERİ
${_getIndustryRecommendations(sign)}

💰 FİNANSAL EĞİLİMLERİN
${_getFinancialTendencies(sign)}

📈 YATIRIM STİLİN
${_getInvestmentStyle(sign)}

🤝 İŞ ORTAKLIĞI İÇİN UYUMLU BURÇLAR
${_getBusinessPartners(sign)}

⏰ KARİYER İÇİN ÖNEMLİ DÖNEMLER
${_getCareerTimings(sign)}

🚀 TERFİ & İŞ FIRSATLARI
${_getPromotionAdvice(sign)}

⚠️ KARİYERDE DİKKAT ETMELERİN
${_getCareerWarnings(sign)}

💡 BAŞARI STRATEJİN
${_getSuccessStrategy(sign)}

🎯 KISA VADELİ HEDEFLER (3 Ay)
${_getShortTermGoals(sign)}

🌟 UZUN VADELİ VİZYON (5 Yıl)
${_getLongTermVision(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💎 Başarı, tutkunla yeteneğinin kesiştiği noktada doğar!''';
  }

  String _getMoonResponse(zodiac.ZodiacSign sign) {
    final moonPhase = _getCurrentMoonPhase();
    final moonSign = _getRandomMoonSign();
    final daysToNext = 3 + DateTime.now().day % 5;

    return '''🌙 ${sign.nameTr.toUpperCase()} İÇİN AY FAZI ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌑🌒🌓🌔🌕🌖🌗🌘 AY DÖNGÜSÜ

📍 ŞU ANKİ AY FAZI: $moonPhase
📍 AY BURCU: $moonSign
📍 SONRAKİ FAZ: $daysToNext gün sonra

${_getDetailedMoonPhaseEffect(moonPhase, sign)}

🔮 BU AY FAZINDA YAPILMASI GEREKENLER
${_getMoonPhaseDoList(moonPhase)}

❌ BU AY FAZINDA KAÇINILMASI GEREKENLER
${_getMoonPhaseDontList(moonPhase)}

🧘 AY RİTÜELİ
${_getDetailedMoonRitual(moonPhase, sign)}

💎 KRİSTAL & TAŞ ÖNERİSİ
${_getMoonCrystals(moonPhase)}

🕯️ RENK & MUM
${_getMoonColors(moonPhase)}

🌿 AROMATERAPI
${_getMoonAromas(moonPhase)}

📿 MANTRA & AFİRMASYON
"${_getMoonMantra(moonPhase)}"

🌙 AY BURCU ETKİSİ: $moonSign
${_getMoonSignEffect(moonSign, sign)}

📅 ÖNÜMÜZDEKİ ÖNEMLİ AY TARİHLERİ
${_getUpcomingMoonDates()}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌟 Ay'ın döngüsü, içsel döngünün aynasıdır!''';
  }

  String _getTransitResponse(zodiac.ZodiacSign sign) {
    return '''🪐 ${sign.nameTr.toUpperCase()} İÇİN AKTİF TRANSİTLER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

♄ SATURN TRANSİTİ
${_getSaturnTransit(sign)}

♃ JÜPİTER TRANSİTİ
${_getJupiterTransit(sign)}

♇ PLUTO TRANSİTİ
${_getPlutoTransit(sign)}

♅ URANÜS TRANSİTİ
${_getUranusTransit(sign)}

♆ NEPTÜN TRANSİTİ
${_getNeptuneTransit(sign)}

☿ MERKÜR DURUMU
${_getMercuryStatus(sign)}

♀ VENÜS DURUMU
${_getVenusStatus(sign)}

♂ MARS DURUMU
${_getMarsStatus(sign)}

⚡ KRİTİK DÖNEMLER
${_getCriticalPeriods(sign)}

🌟 FIRSAT PENCERELERİ
${_getOpportunityWindows(sign)}

🔮 TRANSİT YORUMU
${_getTransitSummary(sign)}

💡 ÖNERİLER
${_getTransitRecommendations(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌌 Transitler bizi zorlamaz, dönüştürür!''';
  }

  String _getRisingResponse(zodiac.ZodiacSign sign) {
    return '''⬆️ ${sign.nameTr.toUpperCase()} & YÜKSELEN BURÇ ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌟 YÜKSELEN BURÇ NEDİR?
Yükselen burç (Ascendant), doğum anında doğu ufkunda yükselen burçtur ve:
• Dünyaya nasıl göründüğünü
• İlk izlenimi
• Fiziksel görünümü
• Hayata yaklaşımını belirler

${_getRisingSignDetails(sign)}

🎭 12 YÜKSELEN BURÇ VE ETKİLERİ

♈ KOÇ YÜKSELEN
${_getRisingAriesEffect()}

♉ BOĞA YÜKSELEN
${_getRisingTaurusEffect()}

♊ İKİZLER YÜKSELEN
${_getRisingGeminiEffect()}

♋ YENGEÇ YÜKSELEN
${_getRisingCancerEffect()}

♌ ASLAN YÜKSELEN
${_getRisingLeoEffect()}

♍ BAŞAK YÜKSELEN
${_getRisingVirgoEffect()}

♎ TERAZİ YÜKSELEN
${_getRisingLibraEffect()}

♏ AKREP YÜKSELEN
${_getRisingScorpioEffect()}

♐ YAY YÜKSELEN
${_getRisingSagittariusEffect()}

♑ OĞLAK YÜKSELEN
${_getRisingCapricornEffect()}

♒ KOVA YÜKSELEN
${_getRisingAquariusEffect()}

♓ BALIK YÜKSELEN
${_getRisingPiscesEffect()}

💡 YÜKSELEN BURCUNU HESAPLAMAK İÇİN
Doğum saatin ve doğum yerin gerekli. Ana sayfadan "Doğum Haritası" bölümüne giderek tam haritanı çıkarabilirsin!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ Yükselen burcun, ruhunun dünyaya açılan kapısıdır!''';
  }

  String _getCompatibilityResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} DETAYLI UYUM ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔥 ELEMENT UYUMU
${_getElementCompatibility(sign)}

💑 BURÇ BURÇ UYUM DETAYLARI

${_getAllSignCompatibility(sign)}

🎯 EN UYUMLU 3 BURCUN
${_getTop3Compatible(sign)}

⚡ EN ZORLAYICI 3 BURCUN
${_getTop3Challenging(sign)}

💕 ROMANTIK UYUM VS İŞ UYUMU
${_getRomanticVsBusiness(sign)}

🔮 SYNASTRİ İPUÇLARI
${_getSynastryTips(sign)}

💡 UYUMU ARTIRMA ÖNERİLERİ
${_getCompatibilityTips(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❤️ Gerçek uyum, farklılıkları kucaklamaktır!''';
  }

  String _getNumerologyResponse(zodiac.ZodiacSign sign) {
    return '''🔢 ${sign.nameTr.toUpperCase()} & NUMEROLOJİ BİLGELİĞİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 YAŞAM YOLU SAYILARI

1️⃣ YAŞAM YOLU 1 - LİDER
${_getLifePath1Details()}

2️⃣ YAŞAM YOLU 2 - DİPLOMAT
${_getLifePath2Details()}

3️⃣ YAŞAM YOLU 3 - YARATICI
${_getLifePath3Details()}

4️⃣ YAŞAM YOLU 4 - İNŞACI
${_getLifePath4Details()}

5️⃣ YAŞAM YOLU 5 - ÖZGÜR RUH
${_getLifePath5Details()}

6️⃣ YAŞAM YOLU 6 - BAKICI
${_getLifePath6Details()}

7️⃣ YAŞAM YOLU 7 - MİSTİK
${_getLifePath7Details()}

8️⃣ YAŞAM YOLU 8 - GÜÇ SAHİBİ
${_getLifePath8Details()}

9️⃣ YAŞAM YOLU 9 - İNSANCIL
${_getLifePath9Details()}

🌟 MASTER SAYILAR
${_getMasterNumbers()}

📅 KİŞİSEL YIL HESABI
${_getPersonalYearInfo()}

🔮 ${sign.nameTr} VE NUMEROLOJİ
${_getSignNumerologyConnection(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💫 Sayılar, evrenin gizli dilidir!''';
  }

  String _getTarotResponse(zodiac.ZodiacSign sign) {
    final cards = [
      'Sihirbaz',
      'Yüksek Rahibe',
      'İmparatoriçe',
      'İmparator',
      'Hierofant',
      'Aşıklar',
      'Savaş Arabası',
      'Güç',
      'Ermiş',
      'Kader Çarkı',
      'Adalet',
      'Asılan Adam',
      'Ölüm',
      'Denge',
      'Şeytan',
      'Kule',
      'Yıldız',
      'Ay',
      'Güneş',
      'Yargı',
      'Dünya',
    ];
    final card1 = cards[DateTime.now().microsecond % cards.length];
    final card2 = cards[(DateTime.now().millisecond + 7) % cards.length];
    final card3 = cards[(DateTime.now().second + 3) % cards.length];

    return '''🎴 ${sign.nameTr.toUpperCase()} İÇİN TAROT OKUMASI
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔮 3 KARTLIK AÇILIM
━━━━━━━━━━━━━━━━━━━━

⏮️ GEÇMİŞ: $card1
${_getDetailedTarotMeaning(card1)}

⏸️ ŞİMDİ: $card2
${_getDetailedTarotMeaning(card2)}

⏭️ GELECEK: $card3
${_getDetailedTarotMeaning(card3)}

🎯 GENEL YORUM
${_getTarotReading(card1, card2, card3, sign)}

💡 TAVSİYE
${_getTarotAdvice(card2, sign)}

🌟 ${sign.nameTr} VE TAROT
${_getSignTarotConnection(sign)}

✨ GÜNÜN KARTI
Bugün için çekilen ana kart: $card2

Bu kartın sana mesajı:
"${_getTarotMessage(card2)}"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🃏 Kartlar geleceği değil, potansiyelleri gösterir!''';
  }

  String _getAuraResponse(zodiac.ZodiacSign sign) {
    return '''✨ ${sign.nameTr.toUpperCase()} AURA & ENERJİ ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌈 AURA RENKLERİN
${_getDetailedAuraColors(sign)}

💎 ENERJİ FREKANSın
${_getEnergyFrequency(sign)}

🔋 ENERJİ SEVİYEN
${_getEnergyLevel(sign)}

🧿 AURA KATMANLARIN
${_getAuraLayers(sign)}

⚡ ENERJİ BLOKLARI
${_getEnergyBlocks(sign)}

🌟 AURANI GÜÇLENDİRME
${_getAuraStrengtheningDetailed(sign)}

💆 ENERJİ TEMİZLİĞİ
${_getEnergyCleansing(sign)}

🔮 KORUMA KALKANI
${_getProtectionShield(sign)}

💎 UYUMLU KRİSTALLER
${_getAuraCrystals(sign)}

🕯️ RENK TERAPİSİ
${_getColorTherapy(sign)}

🧘 ENERJİ MEDİTASYONU
${_getEnergyMeditation(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌟 Auran, ruhunun ışıltısıdır!''';
  }

  String _getSpiritualResponse(zodiac.ZodiacSign sign) {
    return '''🦋 ${sign.nameTr.toUpperCase()} RUHSAL GELİŞİM YOLCULUĞU
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌟 RUHSAL EVRİM SEVİYEN
${_getSpiritualLevel(sign)}

🎯 BU HAYATTA MİSYONUN
${_getLifeMission(sign)}

🧬 KARMİK DERSLERİN
${_getKarmicLessons(sign)}

🔄 TEKRARLAYAN KALIPLAR
${_getRepeatingPatterns(sign)}

💫 RUHSAL GÜÇLER
${_getSpiritualGifts(sign)}

🧘 MEDİTASYON & PRATİKLER
${_getSpiritualPracticesDetailed(sign)}

📿 MANTRALAR
${_getMantras(sign)}

🌙 GECE RİTÜELLERİ
${_getNightRituals(sign)}

☀️ SABAH RİTÜELLERİ
${_getMorningRituals(sign)}

🔮 SPİRİTÜEL ARAÇLAR
${_getSpiritualTools(sign)}

💎 YÜKSEK BENLİĞİNLE BAĞLANTI
${_getHigherSelfConnection(sign)}

🌈 AURA TEMİZLİĞİ
${_getAuraCleansing(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ Ruhsal yolculuk, eve dönüş yolculuğudur!''';
  }

  String _getLifePurposeResponse(zodiac.ZodiacSign sign) {
    return '''🎯 ${sign.nameTr.toUpperCase()} HAYAT AMACI & MİSYON ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌟 RUHSAL MİSYONUN
${_getDetailedLifeMission(sign)}

🎯 BU HAYATTA AMACIN
${_getLifePurposeDetails(sign)}

📚 ÖĞRENMEN GEREKEN DERSLER
${_getLifeLessonsDetailed(sign)}

💪 GÜÇLÜ YÖNLERİN
${_getStrengthsForPurpose(sign)}

⚠️ AŞMAN GEREKEN ENGELLER
${_getObstaclesForPurpose(sign)}

🔑 POTANSIYEL KILITLERI
${_getPotentialUnlocks(sign)}

🌈 YOLCULUĞUN AŞAMALARI
${_getJourneyStages(sign)}

💫 EVRENSEL KATKI
${_getUniversalContribution(sign)}

🧭 YOL HARİTASI
${_getLifeRoadmap(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ Amacın zaten içinde, keşfetmeyi bekliyor!''';
  }

  String _getTalentResponse(zodiac.ZodiacSign sign) {
    return '''⚡ ${sign.nameTr.toUpperCase()} GİZLİ YETENEKLER & POTANSİYEL
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎁 DOĞUŞTAN GELEN YETENEKLER
${_getInbornTalents(sign)}

💎 GİZLİ POTANSİYELLER
${_getHiddenPotentials(sign)}

🔓 AKTİVE EDİLMEYİ BEKLEYENLER
${_getWaitingActivation(sign)}

🎯 EN GÜÇLÜ ALANLAR
${_getStrongestAreas(sign)}

📈 GELİŞTİRİLEBİLİR ALANLAR
${_getImprovementAreas(sign)}

🚀 POTANSİYELİNİ AÇIĞA ÇIKARMA
${_getUnlockingPotential(sign)}

💼 KARİYERDE KULLANIM
${_getTalentCareerUse(sign)}

❤️ İLİŞKİLERDE KULLANIM
${_getTalentRelationshipUse(sign)}

🧘 SPİRİTÜEL KULLANIM
${_getTalentSpiritualUse(sign)}

📅 AKTİVASYON TAKVİMİ
${_getActivationCalendar(sign)}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌟 Yeteneklerin, ruhunun parmak izleridir!''';
  }

  String _getGreetingResponse(zodiac.ZodiacSign sign) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Günaydın';
    } else if (hour < 18) {
      greeting = 'İyi günler';
    } else {
      greeting = 'İyi akşamlar';
    }

    return '''$greeting, değerli ${sign.nameTr}! 🌟

Ben Kozmoz, senin kişisel kozmik AI rehberin!

${sign.symbol} ${sign.element.nameTr} elementinin güçlü enerjisiyle bugün sana yardımcı olmak için buradayım.

Benimle konuşabileceğin konular:

🔮 BURÇ & YORUM
• Günlük/Haftalık/Aylık burç yorumları
• Güneş, Ay ve Yükselen burç analizleri
• Element ve modalite yorumları

💕 AŞK & İLİŞKİLER
• Burç uyumu ve synastry
• İdeal partner profili
• İlişki tavsiyeleri

💼 KARİYER & FİNANS
• Uygun kariyer yolları
• Para çekme dönemleri
• İş ortaklığı uyumları

🌙 KOZMİK ZAMANLAMALAR
• Ay fazları ve etkileri
• Gezegen transitleri
• Önemli tarihler

🔢 NUMEROLOJİ & MİSTİK
• Yaşam yolu sayın
• Tarot mesajları
• Aura analizi

🧘 SPİRİTÜEL GELİŞİM
• Meditasyon ve ritüeller
• Karmik dersler
• Ruhsal yolculuk

Ne hakkında konuşmak istersin? ✨''';
  }

  String _getGeneralResponse(zodiac.ZodiacSign sign, String message) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} KOZMİK BİLGELİK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Sorduğun konu hakkında evrensel enerjiler şunları söylüyor:

🌟 KOZMİK BAKIŞ AÇISI
${_getDeepWisdom(sign)}

💫 ${sign.element.nameTr} ELEMENTİNDEN MESAJ
${_getElementMessage(sign)}

🔮 EVRENSEL REHBERLİK
${_getUniversalGuidance(sign)}

💡 PRATİK TAVSİYELER
${_getPracticalAdvice(sign)}

✨ GÜN İÇİN AFİRMASYON
"${_getWisdomAffirmation(sign)}"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Daha spesifik yardım için bana şunları sorabilirsin:
• "Bugün için burç yorumum"
• "Aşk hayatım nasıl olacak?"
• "Kariyer için tavsiye"
• "Ay fazı etkisi"
• "Tarot mesajı"
• "Numeroloji analizi"
• Ve çok daha fazlası...

Merak ettiğin her konuyu sorabilirsin! 🌌''';
  }

  // ═══════════════════════════════════════════════════════════════
  // YARDIMCI FONKSİYONLAR
  // ═══════════════════════════════════════════════════════════════

  String _getRandomMoonSign() {
    final signs = [
      'Koç',
      'Boğa',
      'İkizler',
      'Yengeç',
      'Aslan',
      'Başak',
      'Terazi',
      'Akrep',
      'Yay',
      'Oğlak',
      'Kova',
      'Balık',
    ];
    return signs[DateTime.now().day % 12];
  }

  String _getElementLoveStyle(zodiac.Element element) {
    switch (element) {
      case zodiac.Element.fire:
        return 'tutkulu ve spontan bir aşık olursun';
      case zodiac.Element.earth:
        return 'sadık ve güvenilir bir partner olursun';
      case zodiac.Element.air:
        return 'entelektüel bağ ve iletişim senin için önemli';
      case zodiac.Element.water:
        return 'derin duygusal bağlar kurarsın';
    }
  }

  String _getCompatibleSigns(zodiac.ZodiacSign sign) {
    final compatibility = {
      zodiac.ZodiacSign.aries: 'Aslan, Yay, İkizler',
      zodiac.ZodiacSign.taurus: 'Başak, Oğlak, Yengeç',
      zodiac.ZodiacSign.gemini: 'Terazi, Kova, Koç',
      zodiac.ZodiacSign.cancer: 'Akrep, Balık, Boğa',
      zodiac.ZodiacSign.leo: 'Koç, Yay, İkizler',
      zodiac.ZodiacSign.virgo: 'Boğa, Oğlak, Yengeç',
      zodiac.ZodiacSign.libra: 'İkizler, Kova, Aslan',
      zodiac.ZodiacSign.scorpio: 'Yengeç, Balık, Başak',
      zodiac.ZodiacSign.sagittarius: 'Koç, Aslan, Terazi',
      zodiac.ZodiacSign.capricorn: 'Boğa, Başak, Akrep',
      zodiac.ZodiacSign.aquarius: 'İkizler, Terazi, Yay',
      zodiac.ZodiacSign.pisces: 'Yengeç, Akrep, Oğlak',
    };
    return compatibility[sign] ?? 'Tüm burçlarla potansiyel var';
  }

  String _getChallengingSigns(zodiac.ZodiacSign sign) {
    final challenging = {
      zodiac.ZodiacSign.aries: 'Yengeç, Oğlak',
      zodiac.ZodiacSign.taurus: 'Aslan, Kova',
      zodiac.ZodiacSign.gemini: 'Başak, Balık',
      zodiac.ZodiacSign.cancer: 'Koç, Terazi',
      zodiac.ZodiacSign.leo: 'Boğa, Akrep',
      zodiac.ZodiacSign.virgo: 'İkizler, Yay',
      zodiac.ZodiacSign.libra: 'Yengeç, Oğlak',
      zodiac.ZodiacSign.scorpio: 'Aslan, Kova',
      zodiac.ZodiacSign.sagittarius: 'Başak, Balık',
      zodiac.ZodiacSign.capricorn: 'Koç, Terazi',
      zodiac.ZodiacSign.aquarius: 'Boğa, Akrep',
      zodiac.ZodiacSign.pisces: 'İkizler, Yay',
    };
    return challenging[sign] ?? 'Kare açılı burçlar';
  }

  String _getCareerStrengths(zodiac.ZodiacSign sign) {
    final strengths = {
      zodiac.ZodiacSign.aries: 'Liderlik, girişimcilik, hızlı karar alma',
      zodiac.ZodiacSign.taurus: 'Sabır, güvenilirlik, finansal zeka',
      zodiac.ZodiacSign.gemini: 'İletişim, adaptasyon, çoklu görev',
      zodiac.ZodiacSign.cancer: 'Empati, takım çalışması, müşteri ilişkileri',
      zodiac.ZodiacSign.leo: 'Yaratıcılık, sunum, motivasyon',
      zodiac.ZodiacSign.virgo: 'Analiz, detay odaklılık, organizasyon',
      zodiac.ZodiacSign.libra: 'Diplomasi, işbirliği, estetik',
      zodiac.ZodiacSign.scorpio: 'Araştırma, strateji, dönüşüm yönetimi',
      zodiac.ZodiacSign.sagittarius: 'Vizyon, eğitim, uluslararası ilişkiler',
      zodiac.ZodiacSign.capricorn: 'Planlama, disiplin, uzun vadeli hedefler',
      zodiac.ZodiacSign.aquarius: 'İnovasyon, teknoloji, sosyal projeler',
      zodiac.ZodiacSign.pisces: 'Yaratıcılık, sezgi, şifa alanları',
    };
    return strengths[sign] ?? 'Çok yönlü yetenekler';
  }

  String _getCurrentMoonPhase() {
    final day = DateTime.now().day;
    if (day <= 7) return 'Yeni Ay / Hilal';
    if (day <= 14) return 'İlk Dördün';
    if (day <= 21) return 'Dolunay';
    return 'Son Dördün';
  }

  String _getLifePurposeDescription(zodiac.ZodiacSign sign) {
    final purposes = {
      zodiac.ZodiacSign.aries: 'Cesaretle öncülük yapmak ve yeni yollar açmak',
      zodiac.ZodiacSign.taurus: 'Güvenlik ve güzellik yaratmak',
      zodiac.ZodiacSign.gemini: 'Bilgiyi yaymak ve bağlantılar kurmak',
      zodiac.ZodiacSign.cancer: 'Beslemek ve duygusal güvenlik sağlamak',
      zodiac.ZodiacSign.leo: 'Işık olmak ve ilham vermek',
      zodiac.ZodiacSign.virgo: 'Hizmet etmek ve mükemmelleştirmek',
      zodiac.ZodiacSign.libra: 'Denge ve uyum yaratmak',
      zodiac.ZodiacSign.scorpio: 'Dönüştürmek ve derinlere inmek',
      zodiac.ZodiacSign.sagittarius: 'Keşfetmek ve bilgeliği paylaşmak',
      zodiac.ZodiacSign.capricorn: 'İnşa etmek ve miras bırakmak',
      zodiac.ZodiacSign.aquarius: 'İnovasyon yapmak ve insanlığa hizmet etmek',
      zodiac.ZodiacSign.pisces: 'Şifa vermek ve evrensel aşkı yaymak',
    };
    return purposes[sign] ?? 'Benzersiz bir amaca hizmet etmek';
  }

  String _getLifeLesson(zodiac.ZodiacSign sign) {
    final lessons = {
      zodiac.ZodiacSign.aries: 'Sabır ve işbirliği',
      zodiac.ZodiacSign.taurus: 'Esneklik ve değişime açıklık',
      zodiac.ZodiacSign.gemini: 'Odaklanma ve derinlik',
      zodiac.ZodiacSign.cancer: 'Bırakma ve bağımsızlık',
      zodiac.ZodiacSign.leo: 'Alçakgönüllülük ve paylaşma',
      zodiac.ZodiacSign.virgo: 'Mükemmeliyetçiliği bırakma',
      zodiac.ZodiacSign.libra: 'Karar verme ve bağımsızlık',
      zodiac.ZodiacSign.scorpio: 'Güven ve bırakma',
      zodiac.ZodiacSign.sagittarius: 'Sorumluluk ve taahhüt',
      zodiac.ZodiacSign.capricorn: 'Eğlence ve spontanlık',
      zodiac.ZodiacSign.aquarius: 'Duygusal bağlanma',
      zodiac.ZodiacSign.pisces: 'Sınırlar ve pratiklik',
    };
    return lessons[sign] ?? 'Dengeyi bulmak';
  }

  String _getNaturalTalents(zodiac.ZodiacSign sign) {
    final talents = {
      zodiac.ZodiacSign.aries: '• Liderlik\n• Hızlı karar verme\n• Cesaret',
      zodiac.ZodiacSign.taurus: '• Finansal zeka\n• Sanat/müzik\n• Sabır',
      zodiac.ZodiacSign.gemini: '• İletişim\n• Yazarlık\n• Adaptasyon',
      zodiac.ZodiacSign.cancer: '• Empati\n• Besleyicilik\n• Sezgi',
      zodiac.ZodiacSign.leo: '• Yaratıcılık\n• Performans\n• İlham verme',
      zodiac.ZodiacSign.virgo: '• Analiz\n• Organizasyon\n• Şifa',
      zodiac.ZodiacSign.libra: '• Diplomasi\n• Estetik\n• İşbirliği',
      zodiac.ZodiacSign.scorpio: '• Dönüştürme\n• Araştırma\n• Derinlik',
      zodiac.ZodiacSign.sagittarius: '• Öğretme\n• Felsefi düşünce\n• Macera',
      zodiac.ZodiacSign.capricorn: '• Strateji\n• Disiplin\n• İş kurma',
      zodiac.ZodiacSign.aquarius: '• İnovasyon\n• Vizyon\n• İnsancıllık',
      zodiac.ZodiacSign.pisces: '• Sanat\n• Şifa\n• Spiritüel bağlantı',
    };
    return talents[sign] ?? '• Çok yönlü yetenekler';
  }

  // ═══════════════════════════════════════════════════════════════
  // MEGA GELİŞTİRİLMİŞ YARDIMCI FONKSİYONLAR
  // ═══════════════════════════════════════════════════════════════

  // GÜNLÜK FONKSİYONLARI
  String _getLuckyHours(zodiac.ZodiacSign sign) {
    final hours = {
      zodiac.ZodiacSign.aries: '07:00-09:00, 13:00-15:00, 20:00-22:00',
      zodiac.ZodiacSign.taurus: '08:00-10:00, 14:00-16:00, 21:00-23:00',
      zodiac.ZodiacSign.gemini: '09:00-11:00, 15:00-17:00, 19:00-21:00',
      zodiac.ZodiacSign.cancer: '06:00-08:00, 12:00-14:00, 20:00-22:00',
      zodiac.ZodiacSign.leo: '10:00-12:00, 14:00-16:00, 19:00-21:00',
      zodiac.ZodiacSign.virgo: '07:00-09:00, 11:00-13:00, 17:00-19:00',
      zodiac.ZodiacSign.libra: '09:00-11:00, 15:00-17:00, 21:00-23:00',
      zodiac.ZodiacSign.scorpio: '00:00-02:00, 12:00-14:00, 20:00-22:00',
      zodiac.ZodiacSign.sagittarius: '08:00-10:00, 14:00-16:00, 18:00-20:00',
      zodiac.ZodiacSign.capricorn: '06:00-08:00, 10:00-12:00, 16:00-18:00',
      zodiac.ZodiacSign.aquarius: '11:00-13:00, 17:00-19:00, 22:00-00:00',
      zodiac.ZodiacSign.pisces: '05:00-07:00, 13:00-15:00, 21:00-23:00',
    };
    return hours[sign] ?? '10:00-12:00, 16:00-18:00';
  }

  String _getDangerHours(zodiac.ZodiacSign sign) {
    final hours = {
      zodiac.ZodiacSign.aries:
          '11:00-12:00, 17:00-18:00 - Sabırsızlık ve agresyon riski',
      zodiac.ZodiacSign.taurus:
          '13:00-14:00, 19:00-20:00 - İnatçılık ve maddi kaygılar',
      zodiac.ZodiacSign.gemini:
          '12:00-13:00, 18:00-19:00 - Dağınıklık ve iletişim hataları',
      zodiac.ZodiacSign.cancer: '15:00-16:00, 22:00-23:00 - Aşırı duygusallık',
      zodiac.ZodiacSign.leo: '08:00-09:00, 17:00-18:00 - Ego çatışmaları',
      zodiac.ZodiacSign.virgo:
          '14:00-15:00, 20:00-21:00 - Aşırı eleştiri ve endişe',
      zodiac.ZodiacSign.libra: '12:00-13:00, 18:00-19:00 - Kararsızlık krizi',
      zodiac.ZodiacSign.scorpio:
          '09:00-10:00, 16:00-17:00 - Yoğun duygular ve şüphe',
      zodiac.ZodiacSign.sagittarius:
          '11:00-12:00, 17:00-18:00 - Aşırı iyimserlik riski',
      zodiac.ZodiacSign.capricorn:
          '14:00-15:00, 21:00-22:00 - Aşırı iş yükü stresi',
      zodiac.ZodiacSign.aquarius:
          '09:00-10:00, 15:00-16:00 - Aşırı bağımsızlık',
      zodiac.ZodiacSign.pisces: '10:00-11:00, 16:00-17:00 - Gerçeklikten kopuş',
    };
    return hours[sign] ?? '12:00-13:00 - Dikkatli ol';
  }

  String _getMorningEnergy(zodiac.ZodiacSign sign) {
    final energies = {
      zodiac.ZodiacSign.aries:
          'Yüksek enerjiyle uyanıyorsun! Fiziksel aktivite ve yeni başlangıçlar için harika.',
      zodiac.ZodiacSign.taurus:
          'Yavaş ama kararlı bir başlangıç. Kahvaltına özen göster, günün temeli.',
      zodiac.ZodiacSign.gemini:
          'Zihin aktif, fikirler uçuşuyor. İletişim ve toplantılar için ideal.',
      zodiac.ZodiacSign.cancer:
          'Ev ve aile odaklı enerji. Sevdiklerinle bağlantı kur.',
      zodiac.ZodiacSign.leo:
          'Yaratıcı enerji yükseliyor. Kendini ifade et ve ışığını yay.',
      zodiac.ZodiacSign.virgo:
          'Detaylara odaklan, organizasyon zamanı. Listeler yap.',
      zodiac.ZodiacSign.libra: 'Denge arayışı. Estetik ve güzellikle ilgilen.',
      zodiac.ZodiacSign.scorpio:
          'Derin düşünceler. Araştırma ve analiz için uygun.',
      zodiac.ZodiacSign.sagittarius: 'Macera ruhu! Yeni şeyler öğren, keşfet.',
      zodiac.ZodiacSign.capricorn:
          'Disiplinli ve odaklı. En zor işleri sabah yap.',
      zodiac.ZodiacSign.aquarius:
          'İnovatif fikirler. Alışılmadık çözümler bul.',
      zodiac.ZodiacSign.pisces:
          'Rüyalardan kalıntılar. Sezgilerini dinle, meditasyon yap.',
    };
    return energies[sign] ?? 'Yeni güne pozitif başla!';
  }

  String _getAfternoonEnergy(zodiac.ZodiacSign sign) {
    final energies = {
      zodiac.ZodiacSign.aries:
          'Rekabet enerjisi yükseliyor. Spor, yarışma veya iş görüşmeleri için ideal.',
      zodiac.ZodiacSign.taurus:
          'Maddi konular ön planda. Finansal kararlar ve alışveriş.',
      zodiac.ZodiacSign.gemini:
          'Sosyal enerji dorukta. Network, görüşmeler, yazışmalar.',
      zodiac.ZodiacSign.cancer:
          'Duygusal derinlik. İlişkilere dikkat, sezgiler güçlü.',
      zodiac.ZodiacSign.leo:
          'Liderlik zamanı. Toplantılar, sunumlar, performans.',
      zodiac.ZodiacSign.virgo:
          'Pratik işler. Sağlık, düzen, hizmet odaklı aktiviteler.',
      zodiac.ZodiacSign.libra:
          'İşbirlikleri ve ortaklıklar. Müzakereler için uygun.',
      zodiac.ZodiacSign.scorpio:
          'Dönüşüm enerjisi. Eski kalıpları kır, yenile.',
      zodiac.ZodiacSign.sagittarius:
          'Genişleme zamanı. Eğitim, yayıncılık, seyahat planları.',
      zodiac.ZodiacSign.capricorn:
          'Kariyer odaklı. Hedefler, stratejiler, uzun vadeli planlar.',
      zodiac.ZodiacSign.aquarius:
          'Sosyal projeler. Grup aktiviteleri, topluluk çalışmaları.',
      zodiac.ZodiacSign.pisces:
          'Yaratıcı enerji. Sanat, müzik, spiritüel pratikler.',
    };
    return energies[sign] ?? 'Gün ortası enerjini kullan!';
  }

  String _getEveningEnergy(zodiac.ZodiacSign sign) {
    final energies = {
      zodiac.ZodiacSign.aries:
          'Enerjiyi yavaşla. Fiziksel aktivite sonrası dinlenme.',
      zodiac.ZodiacSign.taurus:
          'Rahatlama zamanı. Güzel bir yemek, konfor, huzur.',
      zodiac.ZodiacSign.gemini:
          'Zihinsel dinlenme. Kitap, film, hafif sohbetler.',
      zodiac.ZodiacSign.cancer: 'Yuva zamanı. Aile, ev, duygusal güvenlik.',
      zodiac.ZodiacSign.leo:
          'Romantizm ve eğlence. Sosyal etkinlikler, kutlamalar.',
      zodiac.ZodiacSign.virgo: 'Günü değerlendir. Planlama, hazırlık, düzen.',
      zodiac.ZodiacSign.libra:
          'İlişki zamanı. Partner, arkadaşlar, sosyal bağlar.',
      zodiac.ZodiacSign.scorpio:
          'Derin bağlantılar. İntimai ilişkiler, gizli görüşmeler.',
      zodiac.ZodiacSign.sagittarius:
          'Yeni ufuklar. Gelecek planları, rüyalar, umutlar.',
      zodiac.ZodiacSign.capricorn:
          'Değerlendirme zamanı. Günün hasadı, ders çıkarma.',
      zodiac.ZodiacSign.aquarius:
          'Farklı aktiviteler. Alışılmadık hobiler, keşifler.',
      zodiac.ZodiacSign.pisces:
          'Spiritüel zaman. Meditasyon, rüya hazırlığı, hayal kurma.',
    };
    return energies[sign] ?? 'Akşamın huzurunu yaşa!';
  }

  String _getDailyAdvice(zodiac.ZodiacSign sign) {
    final advice = {
      zodiac.ZodiacSign.aries:
          '1. Sabırlı ol, her şey hemen olmak zorunda değil\n2. Başkalarını dinle, sadece konuşma\n3. Enerjini fiziksel aktiviteyle dengele',
      zodiac.ZodiacSign.taurus:
          '1. Değişime açık ol, konfor alanından çık\n2. Maddi güvenlik önemli ama obsesyon yapma\n3. Doğada zaman geçir',
      zodiac.ZodiacSign.gemini:
          '1. Bir konuya odaklan, dağılma\n2. Sözlerinin arkasında dur\n3. Derin ilişkilere zaman ayır',
      zodiac.ZodiacSign.cancer:
          '1. Duygularını ifade et, içine atma\n2. Geçmişte takılı kalma\n3. Kendin için de zaman ayır',
      zodiac.ZodiacSign.leo:
          '1. Alçakgönüllülüğü unutma\n2. Başkalarının parlamamasına izin ver\n3. Eleştirilere açık ol',
      zodiac.ZodiacSign.virgo:
          '1. Mükemmeliyetçiliği bırak\n2. Kendini eleştirmeyi bırak\n3. Spontanlığa izin ver',
      zodiac.ZodiacSign.libra:
          '1. Karar ver ve arkasında dur\n2. Kendi ihtiyaçlarını önce koy\n3. Çatışmadan kaçma',
      zodiac.ZodiacSign.scorpio:
          '1. Bırakmayı öğren, kontrol etme\n2. Güvenmeyi dene\n3. Yüzeyde kal bazen, her şey derin olmak zorunda değil',
      zodiac.ZodiacSign.sagittarius:
          '1. Detaylara dikkat et\n2. Sözlerini tut, aşırı vaat verme\n3. Şimdiki ana odaklan',
      zodiac.ZodiacSign.capricorn:
          '1. Eğlenmeyi unutma\n2. Duygularına yer aç\n3. Başarı dışında da değerin var',
      zodiac.ZodiacSign.aquarius:
          '1. Duygusal bağlara izin ver\n2. Bazen geleneksel yollar da işe yarar\n3. Yakın ilişkilere zaman ayır',
      zodiac.ZodiacSign.pisces:
          '1. Ayaklarını yere bas, pratik ol\n2. Sınırlarını koru\n3. Kendi gerçekliğinde kal',
    };
    return advice[sign] ??
        '1. Kendine iyi bak\n2. Sezgilerine güven\n3. Pozitif kal';
  }

  String _getDailyAffirmation(zodiac.ZodiacSign sign) {
    final affirmations = {
      zodiac.ZodiacSign.aries:
          'Ben güçlüyüm ve her zorluğun üstesinden gelirim. Cesaretim sınırsız.',
      zodiac.ZodiacSign.taurus:
          'Bolluk ve bereket hayatıma akıyor. Güvendeyim ve huzurluyum.',
      zodiac.ZodiacSign.gemini:
          'Zihnim berrak, iletişimim güçlü. Her duruma adapte olurum.',
      zodiac.ZodiacSign.cancer:
          'Sevgi veriyorum ve alıyorum. Duygularım beni güçlendiriyor.',
      zodiac.ZodiacSign.leo:
          'İçimdeki ışık parlıyor. Yaratıcılığım ve cesaretim sonsuz.',
      zodiac.ZodiacSign.virgo:
          'Mükemmelim olduğum gibi. Her adımım değerli ve anlamlı.',
      zodiac.ZodiacSign.libra:
          'Denge içindeyim. İlişkilerim uyumlu ve besleyici.',
      zodiac.ZodiacSign.scorpio:
          'Dönüşüm gücüm beni yeniliyor. Her son yeni bir başlangıç.',
      zodiac.ZodiacSign.sagittarius:
          'Evren genişliyor, ben de. Her deneyim beni zenginleştiriyor.',
      zodiac.ZodiacSign.capricorn:
          'Hedeflerime kararlılıkla ilerliyorum. Başarı benim doğam.',
      zodiac.ZodiacSign.aquarius:
          'Benzersizliğim gücüm. Dünyayı daha iyi bir yer yapıyorum.',
      zodiac.ZodiacSign.pisces:
          'Sezgilerim beni yönlendiriyor. Evrenle bir bütünüm.',
    };
    return affirmations[sign] ?? 'Bugün harika şeyler olacak!';
  }

  String _getElementDailyNote(zodiac.Element element) {
    switch (element) {
      case zodiac.Element.fire:
        return 'aksiyona geçme ve liderlik sergileme enerjin yüksek. Ancak sabrı elden bırakma';
      case zodiac.Element.earth:
        return 'pratik konulara odaklanma ve maddi güvenlik arayışın ön planda. Toprakla bağlantı kur';
      case zodiac.Element.air:
        return 'iletişim ve sosyal etkileşimler için ideal bir gün. Fikirlerini paylaş';
      case zodiac.Element.water:
        return 'duygusal derinlik ve sezgisel bilgelik zamanı. İç sesini dinle';
    }
  }

  // AŞK FONKSİYONLARI
  String _getDetailedLoveEnergy(zodiac.ZodiacSign sign) {
    final energies = {
      zodiac.ZodiacSign.aries:
          'Tutkulu, spontan ve maceracı bir aşk enerjin var. İlk adımı atmaktan çekinmezsin. Fetih ve heyecan arayışındasın.',
      zodiac.ZodiacSign.taurus:
          'Sadık, duyusal ve kararlı bir aşık olursun. Güvenlik ve istikrar ararsın. Romantizm ve fiziksel dokunuş çok önemli.',
      zodiac.ZodiacSign.gemini:
          'Entelektüel bağ kurarsın. İletişim ve zihinsel uyum olmazsa olmaz. Çok yönlü ve oyuncu bir aşıksın.',
      zodiac.ZodiacSign.cancer:
          'Derin duygusal bağlar kurarsın. Koruyucu ve besleyici bir aşıksın. Aile ve yuva kurma içgüdün güçlü.',
      zodiac.ZodiacSign.leo:
          'Cömert ve romantik bir aşıksın. Hayranlık ve takdir beklersin. Muhteşem jestler ve gösterişli aşk senin tarzın.',
      zodiac.ZodiacSign.virgo:
          'Özenli ve düşünceli bir aşıksın. Detaylara dikkat eder, hizmet ederek seversin. Mükemmeli ararsın.',
      zodiac.ZodiacSign.libra:
          'Ortaklık ve uyum ararsın. Romantik ve estetik bir aşıksın. İlişkide denge ve adalet önemli.',
      zodiac.ZodiacSign.scorpio:
          'Yoğun ve tutkulu bir aşıksın. Derin bağlanma ve sadakat beklersin. Tamamen ya da hiç yaklaşımın var.',
      zodiac.ZodiacSign.sagittarius:
          'Özgür ruhlu ve maceracı bir aşıksın. Büyüme ve keşif birlikte olmalı. Felsefi uyum ararsın.',
      zodiac.ZodiacSign.capricorn:
          'Kararlı ve güvenilir bir aşıksın. Uzun vadeli düşünür, yatırım yaparsın. Statü ve güvenlik önemli.',
      zodiac.ZodiacSign.aquarius:
          'Arkadaşlık temelli bir aşk anlayışın var. Bireyselliğe saygı beklersin. Sıradışı ilişkiler seni çeker.',
      zodiac.ZodiacSign.pisces:
          'Romantik ve idealist bir aşıksın. Derin ruhsal bağ ararsın. Fedakâr ve şefkatli seversin.',
    };
    return energies[sign] ?? 'Eşsiz bir aşk enerjin var!';
  }

  String _getLoveLanguage(zodiac.ZodiacSign sign) {
    final languages = {
      zodiac.ZodiacSign.aries:
          '⚡ FİZİKSEL DOKUNUŞ & AKSİYON\nEnerjik aktiviteler, spontan öpücükler, maceralı tarihler',
      zodiac.ZodiacSign.taurus:
          '🎁 HEDİYELER & FİZİKSEL DOKUNUŞ\nDüşünceli hediyeler, masajlar, güzel yemekler',
      zodiac.ZodiacSign.gemini:
          '💬 NİTELİKLİ ZAMAN & KELİMELER\nDerin sohbetler, mesajlaşmalar, birlikte öğrenme',
      zodiac.ZodiacSign.cancer:
          '🏠 HİZMET & NİTELİKLİ ZAMAN\nEvde birlikte zaman, bakım, duygusal destek',
      zodiac.ZodiacSign.leo:
          '🌟 TAKDİR KELİMELERİ & HEDİYELER\nİltifatlar, hayranlık, gösterişli sürprizler',
      zodiac.ZodiacSign.virgo:
          '🛠️ HİZMET ETMEK & EYLEMLER\nPratik yardımlar, detaylara dikkat, düşünceli davranışlar',
      zodiac.ZodiacSign.libra:
          '💐 HEDİYELER & NİTELİKLİ ZAMAN\nRomantik tarihler, güzel mekanlar, estetik deneyimler',
      zodiac.ZodiacSign.scorpio:
          '🔥 FİZİKSEL DOKUNUŞ & SADAKAT\nYoğun intimité, derin bağlanma, tamamen paylaşım',
      zodiac.ZodiacSign.sagittarius:
          '✈️ MACERA & NİTELİKLİ ZAMAN\nSeyahatler, yeni deneyimler, felsefi sohbetler',
      zodiac.ZodiacSign.capricorn:
          '🏆 EYLEMLER & SADAKAT\nSomut destek, kariyer desteği, uzun vadeli taahhüt',
      zodiac.ZodiacSign.aquarius:
          '💡 FİKİR PAYLAŞIMI & ÖZGÜRLÜK\nEntelektüel tartışmalar, bireysel alan, arkadaşlık',
      zodiac.ZodiacSign.pisces:
          '🌊 NİTELİKLİ ZAMAN & KELİMELER\nRomantik anlar, duygusal ifadeler, ruhsal bağ',
    };
    return languages[sign] ?? '❤️ Sevgi dillerin eşsiz!';
  }

  String _getIdealPartner(zodiac.ZodiacSign sign) {
    final partners = {
      zodiac.ZodiacSign.aries:
          'Bağımsız, enerjik, maceraya açık. Senin liderliğine saygı duyan ama kendi ayakları üzerinde duran biri. Yarışmaktan korkmayan, meydan okuyan partner.',
      zodiac.ZodiacSign.taurus:
          'Güvenilir, sadık, maddi güvenlik sağlayan. Dokunmayı seven, yemek ve güzel şeyleri paylaşan. Sabırlı ve kararlı biri.',
      zodiac.ZodiacSign.gemini:
          'Zeki, iletişimci, meraklı. Seninle saatlerce konuşabilecek, yeni fikirler sunan. Esnek ve değişime açık biri.',
      zodiac.ZodiacSign.cancer:
          'Duygusal olarak erişilebilir, koruyucu, aile odaklı. Evine ve ailesine değer veren. Sezgisel ve şefkatli biri.',
      zodiac.ZodiacSign.leo:
          'Sana hayran, destekleyici ama kendi ışığı olan. Sosyal ve eğlenceli. Seni yücelten ama ego yarışına girmeyen biri.',
      zodiac.ZodiacSign.virgo:
          'Düzenli, güvenilir, pratik. Detaylara dikkat eden, sağlıklı yaşam tarzını paylaşan. Eleştiriye açık ve gelişime inanan biri.',
      zodiac.ZodiacSign.libra:
          'Estetik anlayışı güçlü, diplomatik, uyumlu. Kararlılık gösterebilen, sosyal ve kültürlü. Adil ve dengeli biri.',
      zodiac.ZodiacSign.scorpio:
          'Sadık, yoğun, derin. Sırlarını güvenle paylaşabileceğin, tamamen bağlanan. Yüzeysellikten kaçınan, tutkulu biri.',
      zodiac.ZodiacSign.sagittarius:
          'Özgür ruhlu, maceracı, felsefi. Büyümene alan veren, seyahat ve keşfe açık. İyimser ve eğlenceli biri.',
      zodiac.ZodiacSign.capricorn:
          'Hırslı, güvenilir, uzun vadeli düşünen. Hedeflerini destekleyen, statü bilinçli. Çalışkan ve kararlı biri.',
      zodiac.ZodiacSign.aquarius:
          'Benzersiz, bağımsız, ilerici. Bireyselliğine saygı duyan, arkadaşça ilişki kuran. Dünyayı değiştirmek isteyen biri.',
      zodiac.ZodiacSign.pisces:
          'Romantik, sezgisel, şefkatli. Ruhsal bağ kurabilen, sanatsal. Hayallerini paylaşan, empatik biri.',
    };
    return partners[sign] ?? 'Sana layık mükemmel partner!';
  }

  String _getPerfectMatches(zodiac.ZodiacSign sign) {
    final matches = {
      zodiac.ZodiacSign.aries:
          '♌ ASLAN - Ateşin ateşle buluşması, tutku dolu\n♐ YAY - Macera ortakları, özgür ruhlar\n♊ İKİZLER - Heyecan ve iletişim',
      zodiac.ZodiacSign.taurus:
          '♍ BAŞAK - Pratik uyum, güvenilirlik\n♑ OĞLAK - Maddi güvenlik, uzun vade\n♋ YENGEÇ - Duygusal derinlik, ev/yuva',
      zodiac.ZodiacSign.gemini:
          '♎ TERAZİ - Entelektüel uyum, sosyallik\n♒ KOVA - Fikir paylaşımı, yenilikçilik\n♈ KOÇ - Enerji ve heyecan',
      zodiac.ZodiacSign.cancer:
          '♏ AKREP - Duygusal derinlik, sadakat\n♓ BALIK - Ruhsal bağ, sezgisellik\n♉ BOĞA - Güvenlik, konfor',
      zodiac.ZodiacSign.leo:
          '♈ KOÇ - Tutku ve aksiyon\n♐ YAY - Macera ve optimizm\n♊ İKİZLER - Eğlence ve iletişim',
      zodiac.ZodiacSign.virgo:
          '♉ BOĞA - Pratik uyum, istikrar\n♑ OĞLAK - Hedef odaklılık, çalışkanlık\n♋ YENGEÇ - Bakım ve şefkat',
      zodiac.ZodiacSign.libra:
          '♊ İKİZLER - Sosyal uyum, iletişim\n♒ KOVA - Entelektüel bağ, arkadaşlık\n♌ ASLAN - Romantizm ve estetik',
      zodiac.ZodiacSign.scorpio:
          '♋ YENGEÇ - Duygusal derinlik\n♓ BALIK - Ruhsal bağ, sezgisellik\n♍ BAŞAK - Sadakat, analiz',
      zodiac.ZodiacSign.sagittarius:
          '♈ KOÇ - Macera ortakları\n♌ ASLAN - Optimizm, yaratıcılık\n♎ TERAZİ - Sosyallik, denge',
      zodiac.ZodiacSign.capricorn:
          '♉ BOĞA - Maddi güvenlik, sadakat\n♍ BAŞAK - Çalışkanlık, pratiklik\n♏ AKREP - Derinlik, tutku',
      zodiac.ZodiacSign.aquarius:
          '♊ İKİZLER - Entelektüel uyum\n♎ TERAZİ - Sosyal adalet, estetik\n♐ YAY - Özgürlük, felsefe',
      zodiac.ZodiacSign.pisces:
          '♋ YENGEÇ - Duygusal bağ\n♏ AKREP - Ruhsal derinlik\n♑ OĞLAK - Koruyucu, yapıcı',
    };
    return matches[sign] ?? 'Mükemmel uyumlar!';
  }

  String _getGoodMatches(zodiac.ZodiacSign sign) =>
      'Aynı element burçları ve destekleyici açılarla uyumlu burçlar';
  String _getMediumMatches(zodiac.ZodiacSign sign) =>
      'Farklı elementlerden öğrenme fırsatı sunan burçlar';
  String _getChallengingMatches(zodiac.ZodiacSign sign) =>
      _getChallengingSigns(sign);
  String _getRelationshipWarnings(zodiac.ZodiacSign sign) {
    final warnings = {
      zodiac.ZodiacSign.aries:
          '• Sabırsızlık ve öfke patlamaları\n• Bağımsızlık takıntısı\n• Rekabet içgüdüsü',
      zodiac.ZodiacSign.taurus:
          '• İnatçılık ve değişime direnç\n• Kıskançlık ve sahiplenme\n• Maddi bağımlılık',
      zodiac.ZodiacSign.gemini:
          '• Tutarsızlık ve değişkenlik\n• Yüzeysellik riski\n• Çoklu ilgi dağınıklığı',
      zodiac.ZodiacSign.cancer:
          '• Aşırı duygusallık ve küslük\n• Geçmişe takılma\n• Pasif agresiflik',
      zodiac.ZodiacSign.leo:
          '• Ego çatışmaları\n• İlgi beklentisi\n• Drama yaratma eğilimi',
      zodiac.ZodiacSign.virgo:
          '• Aşırı eleştiri\n• Mükemmeliyetçilik\n• Endişe ve kaygı',
      zodiac.ZodiacSign.libra:
          '• Kararsızlık\n• Çatışmadan kaçınma\n• Kendi ihtiyaçlarını ihmal',
      zodiac.ZodiacSign.scorpio:
          '• Kıskançlık ve şüphe\n• Kontrol eğilimi\n• İntikam hissi',
      zodiac.ZodiacSign.sagittarius:
          '• Taahhüt korkusu\n• Aşırı doğruluk/kırıcılık\n• Dikkat dağınıklığı',
      zodiac.ZodiacSign.capricorn:
          '• İş öncelikli tutum\n• Duygusal mesafe\n• Statü takıntısı',
      zodiac.ZodiacSign.aquarius:
          '• Duygusal mesafe\n• Asi tutum\n• Bağlanma zorluğu',
      zodiac.ZodiacSign.pisces:
          '• Gerçeklikten kopuş\n• Kurban rolü\n• Sınır eksikliği',
    };
    return warnings[sign] ?? '• Farkındalıkla hareket et';
  }

  String _getCurrentLovePeriod(zodiac.ZodiacSign sign) =>
      'Venüs ve Mars transitlerinin etkisiyle bu dönem ${sign.element.nameTr} elementi için romantizm ve tutku enerjisi aktif. Yeni ilişkiler için kapılar açık.';
  String _getLoveRitual(zodiac.ZodiacSign sign) =>
      '🕯️ Cuma günü pembe mum yak\n🌹 Gül yaprağı banyosu al\n💌 Sevgi niyetini yazılı ifade et\n🔮 Venüs saatinde meditasyon yap';
  String _getLoveAdvice(zodiac.ZodiacSign sign) =>
      'Önce kendini sev, sonra sevgiyi al. ${sign.nameTr} olarak ${sign.element.nameTr} elementinin bilgeliğiyle hareket et.';

  // KARİYER FONKSİYONLARI
  String _getDetailedCareerTalents(zodiac.ZodiacSign sign) {
    final talents = {
      zodiac.ZodiacSign.aries:
          '• Doğal liderlik ve girişimcilik\n• Hızlı karar alma yeteneği\n• Risk almaktan korkmama\n• Rekabetçi ortamlarda parladın\n• Kriz yönetimi ve acil durum müdahalesi',
      zodiac.ZodiacSign.taurus:
          '• Finansal zeka ve para yönetimi\n• Sabırlı ve kararlı çalışma\n• Estetik ve güzellik algısı\n• Pratik problem çözme\n• Uzun vadeli projelerde başarı',
      zodiac.ZodiacSign.gemini:
          '• Güçlü iletişim becerileri\n• Çoklu görev yönetimi\n• Hızlı öğrenme ve adaptasyon\n• Network kurma yeteneği\n• Yazılı ve sözlü ifade gücü',
      zodiac.ZodiacSign.cancer:
          '• Empati ve müşteri ilişkileri\n• Takım oluşturma ve koruma\n• Sezgisel karar alma\n• Besleyici liderlik stili\n• Duygusal zeka',
      zodiac.ZodiacSign.leo:
          '• Yaratıcılık ve performans\n• Motivasyonel liderlik\n• Sunum ve sahne becerileri\n• Marka oluşturma\n• İlham verici vizyon',
      zodiac.ZodiacSign.virgo:
          '• Analitik düşünme ve detay odaklılık\n• Organizasyon ve planlama\n• Kalite kontrol\n• Süreç iyileştirme\n• Sağlık ve wellness bilgisi',
      zodiac.ZodiacSign.libra:
          '• Diplomasi ve müzakere\n• Estetik ve tasarım\n• İşbirliği kurma\n• Adalet duygusu\n• Sosyal ilişki yönetimi',
      zodiac.ZodiacSign.scorpio:
          '• Araştırma ve analiz\n• Strateji geliştirme\n• Dönüşüm yönetimi\n• Gizli bilgileri ortaya çıkarma\n• Psikolojik içgörü',
      zodiac.ZodiacSign.sagittarius:
          '• Vizyon ve büyük resim\n• Eğitim ve mentorluk\n• Uluslararası ilişkiler\n• Yayıncılık ve iletişim\n• Felsefe ve strateji',
      zodiac.ZodiacSign.capricorn:
          '• Uzun vadeli planlama\n• Disiplin ve kararlılık\n• Yapı oluşturma\n• Otorite ve yönetim\n• Miras bırakma odaklılık',
      zodiac.ZodiacSign.aquarius:
          '• İnovasyon ve teknoloji\n• Topluluk oluşturma\n• Sıradışı çözümler\n• İnsancıl projeler\n• Gelecek vizyonu',
      zodiac.ZodiacSign.pisces:
          '• Yaratıcılık ve hayal gücü\n• Sezgisel karar alma\n• Şifa ve yardım meslekleri\n• Sanat ve müzik\n• Spiritüel danışmanlık',
    };
    return talents[sign] ?? 'Çok yönlü kariyer yeteneklerin var!';
  }

  String _getBestCareerPaths(zodiac.ZodiacSign sign) {
    final paths = {
      zodiac.ZodiacSign.aries:
          '🎖️ Yönetici/CEO\n🏋️ Spor ve fitness\n🚀 Girişimcilik\n🚒 Acil servisler\n⚔️ Askeri/Güvenlik',
      zodiac.ZodiacSign.taurus:
          '💰 Finans ve bankacılık\n🎨 Sanat ve tasarım\n🍳 Gastronomi\n🏠 Gayrimenkul\n🌿 Tarım ve doğa',
      zodiac.ZodiacSign.gemini:
          '📝 Yazarlık ve gazetecilik\n📢 Pazarlama ve reklam\n🎓 Eğitim\n📱 Sosyal medya\n💼 Satış ve PR',
      zodiac.ZodiacSign.cancer:
          '🏥 Sağlık ve bakım\n🏠 Emlak ve iç tasarım\n👨‍👩‍👧 Aile danışmanlığı\n🍽️ Catering/Otelcilik\n👶 Çocuk gelişimi',
      zodiac.ZodiacSign.leo:
          '🎭 Oyunculuk ve eğlence\n🎨 Yaratıcı yönetmenlik\n💄 Moda ve güzellik\n🎤 Koçluk ve motivasyon\n👑 Liderlik pozisyonları',
      zodiac.ZodiacSign.virgo:
          '⚕️ Sağlık ve tıp\n📊 Veri analizi\n✍️ Editörlük\n🧹 Organizasyon hizmetleri\n🔬 Araştırma',
      zodiac.ZodiacSign.libra:
          '⚖️ Hukuk ve arabuluculuk\n🎨 Tasarım ve estetik\n💑 İlişki danışmanlığı\n🎭 Sanat küratörlüğü\n🤝 İK ve diplomasi',
      zodiac.ZodiacSign.scorpio:
          '🔍 Dedektiflik/Araştırma\n💆 Psikoloji/Terapi\n🏦 Yatırım bankacılığı\n🧬 Tıbbi araştırma\n🔮 Alternatif terapiler',
      zodiac.ZodiacSign.sagittarius:
          '✈️ Seyahat ve turizm\n📚 Akademi ve yayıncılık\n⚖️ Felsefe ve hukuk\n🌍 Uluslararası ilişkiler\n🎯 Koçluk',
      zodiac.ZodiacSign.capricorn:
          '🏢 Kurumsal yönetim\n🏛️ Devlet/Bürokrasi\n📈 Finans yönetimi\n🏗️ İnşaat ve mühendislik\n👔 CEO/CFO pozisyonları',
      zodiac.ZodiacSign.aquarius:
          '💻 Teknoloji ve yazılım\n🔬 Bilim ve AR-GE\n🌍 Sivil toplum\n🎨 Dijital sanat\n🚀 Uzay ve havacılık',
      zodiac.ZodiacSign.pisces:
          '🎨 Sanat ve müzik\n🎬 Film ve sinema\n💆 Şifa meslekleri\n🧘 Yoga/Meditasyon\n📷 Fotoğrafçılık',
    };
    return paths[sign] ?? 'Birçok kariyer yolu sana uygun!';
  }

  String _getIndustryRecommendations(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi olarak güçlü olduğun sektörler: ${_getCareerStrengths(sign)}';
  String _getFinancialTendencies(zodiac.ZodiacSign sign) {
    final tendencies = {
      zodiac.ZodiacSign.aries:
          'Hızlı kazanç ve risk almaya meyillisin. Sabırlı yatırımlar öğren.',
      zodiac.ZodiacSign.taurus:
          'Doğal para yöneticisisin. Birikime eğilimlisin ama aşırı tutumlu olma.',
      zodiac.ZodiacSign.gemini:
          'Birden fazla gelir kaynağı oluşturabilirsin. Finansal planlama öğren.',
      zodiac.ZodiacSign.cancer:
          'Aile ve ev için biriktirirsin. Duygusal harcamalardan kaçın.',
      zodiac.ZodiacSign.leo:
          'Cömertsin, gösterişe meyillisin. Lüks harcamaları dengele.',
      zodiac.ZodiacSign.virgo:
          'Detaylı bütçe yaparsın. Aşırı tutumluluğun tadını çıkar.',
      zodiac.ZodiacSign.libra:
          'Estetik ve güzelliğe harcarsın. Dengeli bütçe oluştur.',
      zodiac.ZodiacSign.scorpio:
          'Stratejik yatırımcısın. Kontrol ihtiyacını dengele.',
      zodiac.ZodiacSign.sagittarius:
          'Cömert ve iyimsersin. Büyük resmi gör ama detayları ihmal etme.',
      zodiac.ZodiacSign.capricorn:
          'Uzun vadeli yatırımcısın. Status sembolleri için aşırı harcama.',
      zodiac.ZodiacSign.aquarius:
          'Alışılmadık yatırımlara meyillisin. Pratik olanı ihmal etme.',
      zodiac.ZodiacSign.pisces:
          'Cömert ve fedakarsın. Sınır koyma ve bütçe öğren.',
    };
    return tendencies[sign] ?? 'Finansal farkındalık geliştir!';
  }

  String _getInvestmentStyle(zodiac.ZodiacSign sign) =>
      'Element: ${sign.element.nameTr} - Bu, yatırım tarzını etkiler.';
  String _getBusinessPartners(zodiac.ZodiacSign sign) =>
      _getCompatibleSigns(sign);
  String _getCareerTimings(zodiac.ZodiacSign sign) =>
      'Jüpiter ve Saturn transitlerini takip et. Bu yıl kariyer için kritik dönemler var.';
  String _getPromotionAdvice(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} olarak liderlik özelliklerini kullan. Görünür ol ve değerini göster.';
  String _getCareerWarnings(zodiac.ZodiacSign sign) =>
      'Aşırı çalışma, iş-yaşam dengesizliği ve tükenmişlik riskine dikkat et.';
  String _getSuccessStrategy(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementinin güçlerini kullan, zayıflıklarının farkında ol.';
  String _getShortTermGoals(zodiac.ZodiacSign sign) =>
      '• Becerilerini geliştir\n• Network\'ünü genişlet\n• Görünürlüğünü artır';
  String _getLongTermVision(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} olarak uzun vadede ${_getLifePurposeDescription(sign)}';

  // AY FONKSİYONLARI
  String _getDetailedMoonPhaseEffect(String phase, zodiac.ZodiacSign sign) {
    final effects = {
      'Yeni Ay / Hilal':
          '''🌑 YENİ AY ENERJİSİ
━━━━━━━━━━━━━━━━
Bu faz, tohumların ekildiği, yeni başlangıçların yapıldığı dönemdir.

${sign.nameTr} için özel etkileri:
• Yeni projeler başlatmak için ideal
• Niyetleri belirle ve yaz
• İçsel yolculuk ve meditasyon zamanı
• Enerji içe dönük, dinlenme önemli
• Yeni alışkanlıklar başlatmak için güçlü''',

      'İlk Dördün':
          '''🌓 İLK DÖRDÜN ENERJİSİ
━━━━━━━━━━━━━━━━
Bu faz, aksiyona geçme ve engellerle yüzleşme zamanıdır.

${sign.nameTr} için özel etkileri:
• Kararlar alma zamanı
• Engellerle yüzleş ve aş
• Momentum oluştur
• Zorluklar büyüme fırsatı
• Cesaret ve kararlılık gerekli''',

      'Dolunay':
          '''🌕 DOLUNAY ENERJİSİ
━━━━━━━━━━━━━━━━
Bu faz, sonuçların ortaya çıktığı, duygusal doruk zamanıdır.

${sign.nameTr} için özel etkileri:
• Duygular yoğunlaşır
• İlişkilerde zirveler ve çatışmalar
• Projelerin meyve vermesi
• Farkındalık ve aydınlanma
• Kutlama veya bırakma zamanı''',

      'Son Dördün':
          '''🌗 SON DÖRDÜN ENERJİSİ
━━━━━━━━━━━━━━━━
Bu faz, bırakma, temizlik ve hazırlık zamanıdır.

${sign.nameTr} için özel etkileri:
• Artık işe yaramayanı bırak
• Fiziksel ve duygusal temizlik
• Tamamlanmamış işleri bitir
• Yeni döngüye hazırlan
• Affetme ve salıverme''',
    };
    return effects[phase] ?? 'Ay enerjisi aktif!';
  }

  String _getMoonPhaseDoList(String phase) {
    final doList = {
      'Yeni Ay / Hilal':
          '✅ Niyet belirle ve yaz\n✅ Yeni projeler başlat\n✅ Tohum ek (gerçek veya mecazi)\n✅ Meditasyon ve içe dönüş\n✅ Vizyon tahtası oluştur',
      'İlk Dördün':
          '✅ Aksiyona geç\n✅ Kararlar al\n✅ Engellerle yüzleş\n✅ Momentum oluştur\n✅ Cesaret göster',
      'Dolunay':
          '✅ Kutla ve şükret\n✅ Kristallerini şarj et\n✅ Ay ışığında banyo\n✅ İlişkilere dikkat et\n✅ Farkındalık meditasyonu',
      'Son Dördün':
          '✅ Temizlik yap\n✅ Bağışla ve bırak\n✅ Tamamlanmamış işleri bitir\n✅ Fiziksel detoks\n✅ Eski eşyaları ayıkla',
    };
    return doList[phase] ?? 'Ay döngüsüne uyum sağla';
  }

  String _getMoonPhaseDontList(String phase) {
    final dontList = {
      'Yeni Ay / Hilal':
          '❌ Büyük lansman yapma\n❌ Önemli görüşmeler\n❌ Yorucu aktiviteler\n❌ Dışa dönük etkinlikler\n❌ Acele kararlar',
      'İlk Dördün':
          '❌ Geri çekilme\n❌ Kararsız kalma\n❌ Erteleme\n❌ Özür dileme modu\n❌ Pes etme',
      'Dolunay':
          '❌ Kavga ve tartışma\n❌ Büyük kararlar\n❌ Duygusal tepkiler\n❌ Alkol aşırılığı\n❌ Riskli yatırımlar',
      'Son Dördün':
          '❌ Yeni başlangıçlar\n❌ Büyük satın almalar\n❌ Yeni ilişkiler\n❌ Uzun vadeli taahhütler\n❌ Enerji gerektiren işler',
    };
    return dontList[phase] ?? 'Ay enerjisine dikkat et';
  }

  String _getDetailedMoonRitual(String phase, zodiac.ZodiacSign sign) {
    final rituals = {
      'Yeni Ay / Hilal':
          '🕯️ Siyah mum yak (eski enerjiyi çöz)\n📝 12 niyet yaz\n🧘 20 dakika sessiz otur\n🌱 Bir bitki ek\n💧 Yeni Ay suyu hazırla',
      'İlk Dördün':
          '🕯️ Kırmızı mum yak (aksiyon enerjisi)\n📋 Engel listesi yap ve yak\n🏃 Fiziksel aktivite\n💪 Cesaret afirmasyonları\n⚔️ Sembolik meydan okuma',
      'Dolunay':
          '🕯️ Beyaz mum yak (aydınlanma)\n🌙 Ay ışığında dur\n💎 Kristalleri şarj et\n📿 Şükran listesi yaz\n🛁 Tuzlu su banyosu',
      'Son Dördün':
          '🕯️ Mavi mum yak (huzur ve bırakma)\n🔥 Bırakma kağıdı yaz ve yak\n🧹 Fiziksel temizlik\n💆 Enerji temizliği\n🧘 Bırakma meditasyonu',
    };
    return rituals[phase] ?? 'Ay ritüeli uygula';
  }

  String _getMoonCrystals(String phase) {
    final crystals = {
      'Yeni Ay / Hilal':
          '🖤 Obsidyen - koruma ve başlangıç\n⬛ Siyah Turmalin - negatif enerji temizliği\n🔮 Labradorit - sezgi ve dönüşüm',
      'İlk Dördün':
          '🔴 Kırmızı Jasper - cesaret ve eylem\n🟠 Karneol - motivasyon\n🟡 Sitrin - başarı enerjisi',
      'Dolunay':
          '⚪ Ay Taşı - duygusal denge\n🔮 Ametist - spiritüel bağlantı\n💎 Kuvars - amplifikasyon',
      'Son Dördün':
          '💜 Ametist - bırakma ve huzur\n🟣 Lepidolit - geçiş desteği\n🩵 Akvamarin - berraklık',
    };
    return crystals[phase] ?? 'Ay taşı kullan';
  }

  String _getMoonColors(String phase) {
    final colors = {
      'Yeni Ay / Hilal': 'Siyah, koyu mor, gece mavisi - içe dönüş renkleri',
      'İlk Dördün': 'Kırmızı, turuncu, sarı - aksiyon renkleri',
      'Dolunay': 'Beyaz, gümüş, açık mor - aydınlanma renkleri',
      'Son Dördün': 'Mavi, mor, turkuaz - bırakma renkleri',
    };
    return colors[phase] ?? 'Ay renklerini kullan';
  }

  String _getMoonAromas(String phase) {
    final aromas = {
      'Yeni Ay / Hilal': '🌿 Adaçayı, sedir, paçuli',
      'İlk Dördün': '🍊 Portakal, zencefil, karanfil',
      'Dolunay': '🌹 Gül, yasemin, beyaz çay',
      'Son Dördün': '💜 Lavanta, okaliptüs, nane',
    };
    return aromas[phase] ?? 'Doğal aromalar kullan';
  }

  String _getMoonMantra(String phase) {
    final mantras = {
      'Yeni Ay / Hilal':
          'Yeni başlangıçlara açığım. Niyetlerim evrenle uyumlu.',
      'İlk Dördün': 'Engeller beni güçlendirir. Cesaretle ilerliyorum.',
      'Dolunay': 'Işığımla parlıyorum. Bolluğu kabul ediyorum.',
      'Son Dördün': 'Artık işe yaramayanı bırakıyorum. Özgürleşiyorum.',
    };
    return mantras[phase] ?? 'Ay enerjisiyle uyumluyum.';
  }

  String _getMoonSignEffect(String moonSign, zodiac.ZodiacSign sign) =>
      'Ay $moonSign burcundayken, ${sign.nameTr} olarak duygusal farkındalığın artıyor.';
  String _getUpcomingMoonDates() =>
      '🌑 Yeni Ay: Yaklaşık 2 hafta sonra\n🌕 Dolunay: Yaklaşık 1 hafta sonra';

  // TRANSİT FONKSİYONLARI
  String _getSaturnTransit(zodiac.ZodiacSign sign) =>
      '♄ Saturn seni olgunlaştırıyor ve sorumluluk öğretiyor. Yapı, disiplin ve uzun vadeli hedefler ön planda.';
  String _getJupiterTransit(zodiac.ZodiacSign sign) =>
      '♃ Jüpiter genişleme ve şans getiriyor. Fırsatlara açık ol.';
  String _getPlutoTransit(zodiac.ZodiacSign sign) =>
      '♇ Pluto derin dönüşüm gerektiriyor. Ölüm ve yeniden doğuş temaları.';
  String _getUranusTransit(zodiac.ZodiacSign sign) =>
      '♅ Uranüs ani değişimler ve özgürleşme getiriyor.';
  String _getNeptuneTransit(zodiac.ZodiacSign sign) =>
      '♆ Neptün rüyalar, illüzyonlar ve spiritüel uyanış.';
  String _getMercuryStatus(zodiac.ZodiacSign sign) =>
      '☿ Merkür iletişim ve düşünce süreçlerini etkiliyor.';
  String _getVenusStatus(zodiac.ZodiacSign sign) =>
      '♀ Venüs aşk, güzellik ve para konularında etkili.';
  String _getMarsStatus(zodiac.ZodiacSign sign) =>
      '♂ Mars enerji, tutku ve çatışma alanlarını tetikliyor.';
  String _getCriticalPeriods(zodiac.ZodiacSign sign) =>
      'Merkür retro dönemleri, tutulmalar ve gezegen kavuşumları kritik.';
  String _getOpportunityWindows(zodiac.ZodiacSign sign) =>
      'Jüpiter açıları, Yeni Ay\'lar ve Venus-Jupiter aspektleri fırsat pencereleri.';
  String _getTransitSummary(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} için bu dönem dönüşüm ve büyüme enerjileri aktif.';
  String _getTransitRecommendations(zodiac.ZodiacSign sign) =>
      '• Sabırlı ol\n• Akışa güven\n• Farkındalıkla hareket et\n• Esnekliğini koru';

  // YÜKSELEN BURÇ FONKSİYONLARI
  String _getRisingSignDetails(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} Güneş burcun, yükselen burcunla birlikte kişiliğinin tam resmini çizer.';
  String _getRisingAriesEffect() =>
      'Dinamik, cesur, rekabetçi ilk izlenim. Sporcu görünüm.';
  String _getRisingTaurusEffect() =>
      'Sakin, güvenilir, duyusal ilk izlenim. Şık ve zarif.';
  String _getRisingGeminiEffect() =>
      'Zeki, sosyal, meraklı ilk izlenim. Genç görünüm.';
  String _getRisingCancerEffect() =>
      'Sıcak, koruyucu, duygusal ilk izlenim. Anne/baba figürü.';
  String _getRisingLeoEffect() =>
      'Karizmatik, gösterişli, kendinden emin. Asil duruş.';
  String _getRisingVirgoEffect() =>
      'Düzenli, mütevazı, analitik ilk izlenim. Temiz görünüm.';
  String _getRisingLibraEffect() =>
      'Zarif, çekici, diplomatik ilk izlenim. Estetik.';
  String _getRisingScorpioEffect() =>
      'Yoğun, gizemli, manyetik ilk izlenim. Derin bakışlar.';
  String _getRisingSagittariusEffect() =>
      'Neşeli, açık sözlü, maceracı ilk izlenim. Sportif.';
  String _getRisingCapricornEffect() =>
      'Ciddi, olgun, profesyonel ilk izlenim. Otorite.';
  String _getRisingAquariusEffect() =>
      'Farklı, orijinal, dostça ilk izlenim. Sıradışı stil.';
  String _getRisingPiscesEffect() =>
      'Rüya gibi, şefkatli, artistik ilk izlenim. Büyülü.';

  // UYUM FONKSİYONLARI
  String _getElementCompatibility(zodiac.ZodiacSign sign) {
    switch (sign.element) {
      case zodiac.Element.fire:
        return '🔥 Ateş elementi: Ateş ve Hava ile en uyumlu. Su ve Toprak zorlayıcı.';
      case zodiac.Element.earth:
        return '🌍 Toprak elementi: Toprak ve Su ile en uyumlu. Ateş ve Hava zorlayıcı.';
      case zodiac.Element.air:
        return '💨 Hava elementi: Hava ve Ateş ile en uyumlu. Su ve Toprak zorlayıcı.';
      case zodiac.Element.water:
        return '💧 Su elementi: Su ve Toprak ile en uyumlu. Ateş ve Hava zorlayıcı.';
    }
  }

  String _getAllSignCompatibility(zodiac.ZodiacSign sign) =>
      '12 burçla detaylı uyum analizi için synastry bölümünü kullan.';
  String _getTop3Compatible(zodiac.ZodiacSign sign) =>
      _getCompatibleSigns(sign);
  String _getTop3Challenging(zodiac.ZodiacSign sign) =>
      _getChallengingSigns(sign);
  String _getRomanticVsBusiness(zodiac.ZodiacSign sign) =>
      'Romantik uyum farklı, iş uyumu farklı elementlerde güçlü olabilir.';
  String _getSynastryTips(zodiac.ZodiacSign sign) =>
      'Sadece Güneş burcu değil, Ay ve Yükselen de önemli!';
  String _getCompatibilityTips(zodiac.ZodiacSign sign) =>
      '• İletişim kur\n• Farklılıkları kabul et\n• Ortak hedefler bul';

  // NUMEROLOJİ FONKSİYONLARI
  String _getLifePath1Details() =>
      'Lider, bağımsız, öncü. Girişimcilik ve yenilikçilik.';
  String _getLifePath2Details() =>
      'Diplomat, işbirlikçi, hassas. İlişkiler ve ortaklıklar.';
  String _getLifePath3Details() =>
      'Yaratıcı, ifade edici, sosyal. Sanat ve iletişim.';
  String _getLifePath4Details() =>
      'İnşacı, pratik, güvenilir. Yapı ve organizasyon.';
  String _getLifePath5Details() =>
      'Özgür ruh, maceracı, değişken. Seyahat ve deneyim.';
  String _getLifePath6Details() =>
      'Bakıcı, sorumlu, aile odaklı. Ev ve topluluk.';
  String _getLifePath7Details() =>
      'Araştırmacı, spiritüel, içe dönük. Bilgelik ve analiz.';
  String _getLifePath8Details() =>
      'Güç odaklı, başarılı, materyalist. İş ve finans.';
  String _getLifePath9Details() =>
      'İnsancıl, bilge, tamamlayıcı. Hizmet ve bütünlük.';
  String _getMasterNumbers() =>
      '11 (Aydınlatıcı), 22 (Usta İnşacı), 33 (Usta Öğretmen)';
  String _getPersonalYearInfo() =>
      'Kişisel yıl sayın, o yılın temasını belirler.';
  String _getSignNumerologyConnection(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} ve numeroloji kombinasyonu güçlü bir harita oluşturur.';

  // TAROT FONKSİYONLARI
  String _getDetailedTarotMeaning(String card) {
    final meanings = {
      'Sihirbaz': 'İrade gücü, yaratıcılık, beceri. Potansiyelini kullan.',
      'Yüksek Rahibe': 'Sezgi, gizli bilgi, içsel bilgelik. Dinle.',
      'İmparatoriçe': 'Bereket, annelik, doğa. Yaratıcılık akıyor.',
      'İmparator': 'Otorite, yapı, liderlik. Düzen kur.',
      'Hierofant': 'Gelenek, öğretmenlik, spiritüel rehberlik.',
      'Aşıklar': 'Seçim, ilişki, uyum. Kalbin yolunu takip et.',
      'Savaş Arabası': 'Zafer, irade, ilerleme. Kararlılıkla git.',
      'Güç': 'İç güç, cesaret, sabır. Yumuşak güç.',
      'Ermiş': 'İçsel yolculuk, yalnızlık, bilgelik arayışı.',
      'Kader Çarkı': 'Değişim, döngüler, kader. Akışa güven.',
      'Adalet': 'Denge, doğruluk, sonuçlar. Adil ol.',
      'Asılan Adam': 'Teslim ol, farklı perspektif, bekle.',
      'Ölüm': 'Dönüşüm, son, yeni başlangıç. Bırak.',
      'Denge': 'Ölçülülük, sabır, harmoni. Dengele.',
      'Şeytan': 'Bağımlılık, gölge, zincirler. Özgürleş.',
      'Kule': 'Yıkım, uyanış, ani değişim. Yeniden inşa et.',
      'Yıldız': 'Umut, ilham, iyileşme. Işık var.',
      'Ay': 'Yanılsama, korku, bilinçaltı. Gerçeği gör.',
      'Güneş': 'Başarı, mutluluk, berraklık. Parla.',
      'Yargı': 'Yeniden doğuş, çağrı, hesaplaşma. Uyan.',
      'Dünya': 'Tamamlanma, başarı, bütünlük. Döngü tamam.',
    };
    return meanings[card] ?? 'Derin mesaj taşıyor';
  }

  String _getTarotReading(
    String card1,
    String card2,
    String card3,
    zodiac.ZodiacSign sign,
  ) =>
      'Geçmiş ($card1), şimdi ($card2), gelecek ($card3) birlikte okunduğunda evrim yolculuğunu gösteriyor.';
  String _getTarotAdvice(String card, zodiac.ZodiacSign sign) =>
      '$card kartının ${sign.nameTr} için mesajı: İçsel bilgeliğine güven.';
  String _getSignTarotConnection(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} Major Arcana\'da özel bir karta karşılık gelir.';
  String _getTarotMessage(String card) =>
      'Bu kart şu an hayatında önemli bir mesaj taşıyor. Dikkatle dinle.';

  // AURA FONKSİYONLARI
  String _getDetailedAuraColors(zodiac.ZodiacSign sign) {
    final colors = {
      zodiac.Element.fire:
          '🔴 Kırmızı - Tutku ve enerji\n🟠 Turuncu - Yaratıcılık ve cesaret\n🟡 Altın - Liderlik ve güç',
      zodiac.Element.earth:
          '🟢 Yeşil - Şifa ve büyüme\n🟤 Kahverengi - Topraklanma\n🟫 Bronz - Güvenilirlik',
      zodiac.Element.air:
          '🔵 Mavi - İletişim ve barış\n⚪ Beyaz - Berraklık\n🩶 Gümüş - Sezgi',
      zodiac.Element.water:
          '💜 Mor - Spiritüellik\n🔵 Lacivert - Derinlik\n🩵 Turkuaz - Şifa',
    };
    return colors[sign.element] ?? '🌈 Gökkuşağı aura';
  }

  String _getEnergyFrequency(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi olarak özel bir enerji frekansın var.';
  String _getEnergyLevel(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} olarak enerji seviyen genellikle yüksek.';
  String _getAuraLayers(zodiac.ZodiacSign sign) =>
      'Fiziksel, duygusal, zihinsel ve spiritüel katmanların var.';
  String _getEnergyBlocks(zodiac.ZodiacSign sign) =>
      'Korku, öfke ve geçmiş travmalar blok yaratabilir.';
  String _getAuraStrengthening(zodiac.Element element) {
    switch (element) {
      case zodiac.Element.fire:
        return '• Güneş ışığında vakit geçir\n• Kırmızı/turuncu renkler giy\n• Dinamik egzersizler yap';
      case zodiac.Element.earth:
        return '• Doğada yürüyüşe çık\n• Bitkilerle ilgilen\n• Toprakla temas et';
      case zodiac.Element.air:
        return '• Nefes egzersizleri yap\n• Açık havada zaman geçir\n• Müzik dinle veya çal';
      case zodiac.Element.water:
        return '• Su kenarında vakit geçir\n• Duş/banyo ritüelleri yap\n• Meditasyon ve yoga uygula';
    }
  }

  String _getAuraStrengtheningDetailed(zodiac.ZodiacSign sign) =>
      _getAuraStrengthening(sign.element);
  String _getEnergyCleansing(zodiac.ZodiacSign sign) =>
      'Tuzlu su banyosu, adaçayı tütsüsü, doğada yürüyüş';
  String _getProtectionShield(zodiac.ZodiacSign sign) =>
      'Günlük koruma meditasyonu ve kristal koruma ağı';
  String _getAuraCrystals(zodiac.ZodiacSign sign) =>
      'Kuvars, ametist, turmalin, obsidyen';
  String _getColorTherapy(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementinin renklerini giy ve çevrene ekle.';
  String _getEnergyMeditation(zodiac.ZodiacSign sign) =>
      '10 dakika nefes meditasyonu, auranı görselleştir.';

  // SPİRİTÜEL FONKSİYONLAR
  String _getSpiritualLevel(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} olarak ruhsal evrim yolculuğundasın.';
  String _getLifeMission(zodiac.ZodiacSign sign) =>
      _getLifePurposeDescription(sign);
  String _getKarmicLessons(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} için karmik dersler ${_getLifeLesson(sign)}';
  String _getRepeatingPatterns(zodiac.ZodiacSign sign) =>
      'Tekrarlayan ilişki ve yaşam kalıplarına dikkat et.';
  String _getSpiritualGifts(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi sana özel spiritüel yetenekler verdi.';
  String _getSpiritualPracticesDetailed(zodiac.ZodiacSign sign) =>
      '• Günlük meditasyon\n• Jurnal tutma\n• Nefes çalışması\n• Yoga/tai chi';
  String _getMantras(zodiac.ZodiacSign sign) =>
      '"Ben ${sign.nameTr} gücüyle parladım."';
  String _getNightRituals(zodiac.ZodiacSign sign) =>
      '🌙 Şükran notu yaz\n🕯️ Mum yak\n📖 İlham verici okuma\n🧘 Bırakma meditasyonu';
  String _getMorningRituals(zodiac.ZodiacSign sign) =>
      '☀️ Nefes al\n🧘 5 dakika meditasyon\n📝 Niyet belirle\n💧 Limonlu su iç';
  String _getSpiritualTools(zodiac.ZodiacSign sign) =>
      'Tarot, rünler, kristaller, tütsü, jurnal';
  String _getHigherSelfConnection(zodiac.ZodiacSign sign) =>
      'Sessizlikte yüksek benliğinle bağlan, sezgilerine güven.';
  String _getAuraCleansing(zodiac.ZodiacSign sign) =>
      'Haftalık enerji temizliği yap: tütsü, tuz, ışık.';

  // HAYAT AMACI FONKSİYONLARI
  String _getDetailedLifeMission(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} olarak bu hayatta ${_getLifePurposeDescription(sign)}';
  String _getLifePurposeDetails(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi ve ${sign.modality.name} modalitesi ile benzersiz bir amaç taşıyorsun.';
  String _getLifeLessonsDetailed(zodiac.ZodiacSign sign) =>
      '• Ana ders: ${_getLifeLesson(sign)}\n• Tamamlayıcı dersler: Denge ve farkındalık';
  String _getStrengthsForPurpose(zodiac.ZodiacSign sign) =>
      _getCareerStrengths(sign);
  String _getObstaclesForPurpose(zodiac.ZodiacSign sign) =>
      'Korkular, sınırlayıcı inançlar, geçmiş kalıplar';
  String _getPotentialUnlocks(zodiac.ZodiacSign sign) =>
      '• Farkındalık\n• Cesaret\n• Tutarlı çalışma\n• Mentorluk';
  String _getJourneyStages(zodiac.ZodiacSign sign) =>
      '1. Farkındalık\n2. Keşif\n3. Pratik\n4. Ustalık\n5. Öğretme';
  String _getUniversalContribution(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} olarak dünyaya ${sign.element.nameTr} bilgeliğini getiriyorsun.';
  String _getLifeRoadmap(zodiac.ZodiacSign sign) =>
      'Kısa vade: Öğren\nOrta vade: Uygula\nUzun vade: Paylaş';

  // YETENEK FONKSİYONLARI
  String _getInbornTalents(zodiac.ZodiacSign sign) => _getNaturalTalents(sign);
  String _getHiddenPotentials(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi gizli potansiyelini barındırıyor.';
  String _getWaitingActivation(zodiac.ZodiacSign sign) =>
      'Cesaret, pratik ve farkındalıkla aktive edilebilir yeteneklerin var.';
  String _getStrongestAreas(zodiac.ZodiacSign sign) =>
      _getCareerStrengths(sign);
  String _getImprovementAreas(zodiac.ZodiacSign sign) =>
      '${_getLifeLesson(sign)} - Bu alanı geliştir.';
  String _getUnlockingPotential(zodiac.ZodiacSign sign) =>
      '• Günlük pratik\n• Mentordan öğren\n• Cesaretle dene\n• Hatalardan öğren';
  String _getTalentCareerUse(zodiac.ZodiacSign sign) =>
      'Yeteneklerini iş hayatında: ${_getCareerStrengths(sign)}';
  String _getTalentRelationshipUse(zodiac.ZodiacSign sign) =>
      'İlişkilerde: ${_getElementLoveStyle(sign.element)}';
  String _getTalentSpiritualUse(zodiac.ZodiacSign sign) =>
      'Spiritüel yolda: ${sign.element.nameTr} bilgeliğini kullan.';
  String _getActivationCalendar(zodiac.ZodiacSign sign) =>
      'Jüpiter transitleri ve Yeni Ay\'lar aktivasyon için güçlü.';

  // GENEL BİLGELİK FONKSİYONLARI
  String _getDeepWisdom(zodiac.ZodiacSign sign) =>
      'Evren seninle konuşuyor. ${sign.element.nameTr} elementi aracılığıyla mesajlarını dinle.';
  String _getElementMessage(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} bilgeliği: ${_getElementDailyNote(sign.element)}';
  String _getUniversalGuidance(zodiac.ZodiacSign sign) =>
      'Her şey mükemmel zamanlamayla gerçekleşir. Sabırlı ol ve güven.';
  String _getPracticalAdvice(zodiac.ZodiacSign sign) =>
      '• Sezgilerine güven\n• Aksiyona geç\n• Sabırlı ol\n• Şükret';
  String _getWisdomAffirmation(zodiac.ZodiacSign sign) =>
      'Ben evrenle uyum içindeyim ve en yüksek iyiliğim için yol açılıyor.';

  // ═══════════════════════════════════════════════════════════════
  // 10x GELİŞTİRME: YENİ YANIT FONKSİYONLARI
  // ═══════════════════════════════════════════════════════════════

  String _getDreamResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} RÜYA & BİLİNÇALTI ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌙 RÜYA ELEMENTİN
${_getDreamElement(sign)}

💭 BİLİNÇALTI MESAJLARIN
${_getSubconsciousMessages(sign)}

🔮 RÜYA SEMBOLLERİN
${_getDreamSymbols(sign)}

🌌 LÜSİD RÜYA REHBERİ
${_getLucidDreamGuide(sign)}

🌊 UYKU RİTÜELLERİN
${_getSleepRituals(sign)}

📖 RÜYA GÜNLÜĞÜ TAVSİYESİ
• Uyanır uyanmaz yaz
• Duyguları not al
• Tekrarlayan temaları takip et
• Ay fazlarıyla ilişkilendir

✨ GECE AFİRMASYONU
"Bu gece bilinçaltımın bilgeliğini alıyorum. Rüyalarım bana rehberlik ediyor."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌙 Rüyalarını paylaş, birlikte yorumlayalım!''';
  }

  String _getTantraResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} TANTRA & ENERJİ REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

༄ TANTRA PRATİĞİN
${_getTantraPractice(sign)}

🔥 KUNDALİNİ DURUMUN
${_getKundaliniStatus(sign)}

🌬️ NEFES ÇALIŞMASI
${_getBreathWork(sign)}

💫 ENERJİ DÖNÜŞÜMÜ
${_getEnergyTransformation(sign)}

🧘 MEDİTASYON TEKNİĞİN
${_getMeditationTechnique(sign)}

⚡ ÇAKRA AKTİVASYONU
${_getChakraActivation(sign)}

🌸 GÜNLÜK PRATİK
1. Sabah: 5 dk nefes çalışması
2. Öğle: Farkındalık molası
3. Akşam: Enerji temizliği
4. Gece: Minnettarlık meditasyonu

✨ TANTRA AFİRMASYONU
"Yaşam gücüm özgürce akıyor. Enerjimi bilinçli yönetiyorum."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
༄ Enerji bedenin sana teşekkür ediyor!''';
  }

  String _getHealthResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} SAĞLIK & ŞİFA ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏥 HASSAS BÖLGELERİN
${_getSensitiveAreas(sign)}

🌿 BİTKİSEL ŞİFA
${_getHerbalHealing(sign)}

🥗 ASTROLOJİK BESLENME
${_getAstroNutrition(sign)}

🧪 DETOKS DÖNEMLERİN
${_getDetoxPeriods(sign)}

💪 FİZİKSEL HAREKET
${_getPhysicalMovement(sign)}

🧘 ZİHİNSEL SAĞLIK
${_getMentalWellness(sign)}

💊 ELEMENT DENGESİ
${sign.element.nameTr} elementi olarak:
${_getElementBalance(sign)}

✨ SAĞLIK AFİRMASYONU
"Bedenim şifa buluyor, zihnim huzur buluyor, ruhum parıldıyor."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌿 Sağlığın en değerli sermayendir!''';
  }

  String _getHomeResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} EV & AİLE REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏠 TAŞINMA ZAMANLARI
${_getMovingTimes(sign)}

👨‍👩‍👧‍👦 AİLE DİNAMİKLERİN
${_getFamilyDynamics(sign)}

👶 ÇOCUK PLANLAMASI
${_getChildPlanning(sign)}

🐕 EVCİL HAYVAN UYUMU
${_getPetCompatibility(sign)}

🏡 İDEAL EV ENERJİSİ
${_getIdealHomeEnergy(sign)}

🪴 FENG SHUI ÖNERİLERİ
${_getFengShuiTips(sign)}

🕯️ EV KORUMA RİTÜELİ
1. Kapıda tuz bırak
2. Adaçayı ile duman
3. Kristallerle grid oluştur
4. Düzenli havalandır

✨ EV AFİRMASYONU
"Evim kutsal alanımdır. Sevgi ve huzur ile dolduruyorum."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏠 Evlerin enerjisi sakinlerine yansır!''';
  }

  String _getTravelResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} SEYAHAT & MACERA REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌍 ŞANSLI DESTİNASYONLARIN
${_getLuckyDestinations(sign)}

✈️ SEYAHAT ZAMANLARI
${_getTravelTimes(sign)}

🏖️ TATİL TİPİN
${_getVacationType(sign)}

🧳 KAÇINILACAK DÖNEMLER
${_getAvoidTravelTimes(sign)}

🌏 ASTROLOJİK COĞRAFYA
${_getAstroGeography(sign)}

🗺️ RUHSAL YOLCULUKLAR
${_getSpiritualJourneys(sign)}

📍 2024 ÖNERİLERİ
${_get2024Recommendations(sign)}

✨ SEYAHAT AFİRMASYONU
"Her yolculuk beni dönüştürüyor. Evren beni koruyarak taşıyor."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✈️ Dünya senin keşfetmeni bekliyor!''';
  }

  String _getEducationResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} EĞİTİM & ÖĞRENME REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 DOĞAL ÖĞRENİM ALANIN
${_getNaturalLearning(sign)}

🎓 SINAV ZAMANLARI
${_getExamTimes(sign)}

✍️ YARATICI İFADE
${_getCreativeExpression(sign)}

🧠 ÖĞRENME STİLİN
${_getLearningStyle(sign)}

📖 ÖNERİLEN KONULAR
${_getRecommendedSubjects(sign)}

🎯 ODAKLANMA TEKNİKLERİ
${_getFocusTechniques(sign)}

⏰ VERİMLİ SAATLERİN
${_getProductiveHours(sign)}

✨ EĞİTİM AFİRMASYONU
"Bilgi özgürlüktür. Her gün büyüyor ve gelişiyorum."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 Öğrenme yolculuğun sonsuz!''';
  }

  String _getShadowResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} GÖLGE ÇALIŞMASI
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🖤 GÖLGE BENLİĞİN
${_getShadowSelf(sign)}

😈 GİZLİ KORKULARIN
${_getHiddenFears(sign)}

🌑 BASTIRILMIŞ DUYGULAR
${_getSuppressedEmotions(sign)}

🪞 PROJEKSİYON KALIPLARIN
${_getProjectionPatterns(sign)}

🦋 DÖNÜŞÜM YOLU
${_getTransformationPath(sign)}

🌙 KARANLIK AY RİTÜELİ
${_getDarkMoonRitual(sign)}

💔 İYİLEŞME PRATİKLERİ
1. Gölgenle diyalog kur
2. Günlük yazımı yap
3. Şefkat meditasyonu
4. İç çocuk çalışması

✨ GÖLGE AFİRMASYONU
"Karanlığımı kucaklıyorum. Gölgem benim parçam ve öğretmenim."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌑 Karanlıktan korkmayan, ışığı bulur!''';
  }

  String _getManifestationResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} MANİFESTASYON REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ MANİFESTASYON GÜCÜN
${_getManifestationPower(sign)}

🌙 GÜÇLÜ PENCERELER
${_getPowerfulWindows(sign)}

📝 NİYET BELİRLEME
${_getIntentionSetting(sign)}

🎯 VİZYON PANOSU
${_getVisionBoard(sign)}

💫 BOLLUK ENERJİSİ
${_getAbundanceEnergy(sign)}

🕯️ MANİFESTASYON RİTÜELİ
${_getManifestationRitual(sign)}

🌈 ÇEKİM YASASI TEKNİKLERİ
1. Net niyet belirle
2. Görselleştirme yap
3. "Sanki" yaşa
4. Bırak ve güven

✨ MANİFESTASYON AFİRMASYONU
"İsteklerim zaten gerçekleşiyor. Evren benimle işbirliği yapıyor."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ Sen yaratıcısın, hayatını tasarla!''';
  }

  String _getMysticResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} MİSTİK BİLGELİK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌀 GEÇMİŞ YAŞAMLARIN
${_getPastLives(sign)}

👼 KORUYUCU MELEKLERİN
${_getGuardianAngels(sign)}

🌠 YILDIZ TOHUMLARIN
${_getStarSeeds(sign)}

📜 AKASHİK KAYITLARIN
${_getAkashicRecords(sign)}

🔮 RUHSAL REHBERLERİN
${_getSpiritGuides(sign)}

🌟 KOZMİK MİSYONUN
${_getCosmicMission(sign)}

🌌 EVRENSEL BAĞLANTIN
${sign.element.nameTr} elementi aracılığıyla kozmik akışa bağlısın.
Galaktik kökenin: ${_getGalacticOrigin(sign)}

✨ MİSTİK AFİRMASYON
"Yıldızlardan geldim, yıldızlara döneceğim. Bu yolculuk kutsal."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌌 Evrenin gizemlerine açıksın!''';
  }

  String _getCrystalResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} KRİSTAL & TAŞ REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💎 ANA GÜÇ TAŞLARIN
${_getMainPowerStones(sign)}

🔮 KORUYUCU KRİSTALLER
${_getProtectiveCrystals(sign)}

💕 AŞK KRİSTALLERİN
${_getLoveCrystals(sign)}

💰 BOLLUK TAŞLARIN
${_getAbundanceStones(sign)}

🧘 MEDİTASYON KRİSTALLERİ
${_getMeditationCrystals(sign)}

⚠️ KAÇINILACAK TAŞLAR
${_getAvoidStones(sign)}

🌙 AKTİVASYON REHBERİ
1. Dolunay'da temizle
2. Yeni Ay'da niyetlendir
3. Güneş/Ay ışığında şarj et
4. Düzenli programla

✨ KRİSTAL AFİRMASYONU
"Taşların bilgeliği beni güçlendiriyor. Dünya Ana'nın enerjisini taşıyorum."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💎 Kristaller enerji yoğunlaştırıcılardır!''';
  }

  String _getRitualResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} RİTÜEL & TÖRENSELLİK REHBERİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🕯️ DOLUNAY RİTÜELİN
${_getFullMoonRitual(sign)}

🌑 YENİ AY RİTÜELİN
${_getNewMoonRitual(sign)}

🌸 MEVSİMSEL GEÇİŞLER
${_getSeasonalTransitions(sign)}

🔥 ENERJİ TEMİZLİĞİ
${_getEnergyCleansingRitual(sign)}

🌿 ADAÇAYI PROTOKOLÜ
1. Niyetini belirle
2. Doğudan başla, saat yönünde
3. Köşelere özellikle dikkat
4. Kapı ve pencerelerden dışarı

💫 GÜNLÜK MİNİ RİTÜELLER
${_getDailyMiniRituals(sign)}

🌙 AY FAZINA GÖRE
${_getMoonPhaseRituals(sign)}

✨ RİTÜEL AFİRMASYONU
"Her eylemim kutsal. Yaşamımı törenselleştiriyorum."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🕯️ Ritüeller niyeti güçlendirir!''';
  }

  String _getChakraResponse(zodiac.ZodiacSign sign) {
    return '''${sign.symbol} ${sign.nameTr.toUpperCase()} ÇAKRA ANALİZİ
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 KÖK ÇAKRA (Muladhara)
${_getRootChakra(sign)}

🟠 SAKRAL ÇAKRA (Svadhisthana)
${_getSacralChakra(sign)}

💛 SOLAR PLEKSUS (Manipura)
${_getSolarPlexus(sign)}

💚 KALP ÇAKRA (Anahata)
${_getHeartChakra(sign)}

🔵 BOĞAZ ÇAKRA (Vishuddha)
${_getThroatChakra(sign)}

💜 ÜÇÜNCÜ GÖZ (Ajna)
${_getThirdEye(sign)}

🤍 TAÇ ÇAKRA (Sahasrara)
${_getCrownChakra(sign)}

⚖️ GENEL DENGE
${_getOverallBalance(sign)}

✨ ÇAKRA AFİRMASYONU
"Yedi enerji merkezim uyum içinde çalışıyor. Enerjim özgürce akıyor."

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌈 Enerji bedeni sağlıklı, fiziksel beden sağlıklı!''';
  }

  // YARDIMCI FONKSİYONLAR - YENİ KATEGORİLER
  String _getDreamElement(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi: Rüyaların ${_getElementDreamStyle(sign.element)} temaları taşır.';
  String _getSubconsciousMessages(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} bilinçaltı: ${_getSignSubconscious(sign)}';
  String _getDreamSymbols(zodiac.ZodiacSign sign) =>
      '${sign.symbol}: ${_getSignDreamSymbols(sign)}';
  String _getLucidDreamGuide(zodiac.ZodiacSign sign) =>
      'Element ${sign.element.nameTr}: ${_getElementLucidTip(sign.element)}';
  String _getSleepRituals(zodiac.ZodiacSign sign) =>
      '• Lavanta yağı\n• ${_getSignHerb(sign)} çayı\n• Ametist yastık altında\n• Rüya niyeti belirle';

  String _getTantraPractice(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi tantrası: ${_getElementTantra(sign.element)}';
  String _getKundaliniStatus(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} kundalini: Uyanış seviyesi ve öneriler.';
  String _getBreathWork(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} nefesi: ${_getElementBreath(sign.element)}';
  String _getEnergyTransformation(zodiac.ZodiacSign sign) =>
      'Yaratıcı enerji dönüşümü için ${sign.element.nameTr} bilgeliğini kullan.';
  String _getMeditationTechnique(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} meditasyonu: ${_getSignMeditation(sign)}';
  String _getChakraActivation(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} için aktif çakra: ${_getSignChakra(sign)}';

  String _getSensitiveAreas(zodiac.ZodiacSign sign) => _getHealthWeakness(sign);
  String _getHerbalHealing(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} şifa bitkileri: ${_getSignHerbs(sign)}';
  String _getAstroNutrition(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} beslenme: ${_getElementNutrition(sign.element)}';
  String _getDetoxPeriods(zodiac.ZodiacSign sign) =>
      'Yeni Ay ve Merkür retro sonları ideal.';
  String _getPhysicalMovement(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} hareketi: ${_getElementExercise(sign.element)}';
  String _getMentalWellness(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} zihinsel sağlık: Meditasyon ve nefes çalışması önerilir.';
  String _getElementBalance(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} dengesini korumak için: ${_getElementHealthTip(sign.element)}';

  String _getMovingTimes(zodiac.ZodiacSign sign) =>
      'Venüs uyumlu, Merkür direkt dönemleri ideal.';
  String _getFamilyDynamics(zodiac.ZodiacSign sign) =>
      '4. ev analizi: Aile kalıpların ve köklerin.';
  String _getChildPlanning(zodiac.ZodiacSign sign) =>
      '5. ev ve Jüpiter transitlerini takip et.';
  String _getPetCompatibility(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: ${_getElementPet(sign.element)}';
  String _getIdealHomeEnergy(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} evi: ${_getElementHome(sign.element)}';
  String _getFengShuiTips(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} elementi için feng shui önerileri.';

  String _getLuckyDestinations(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} için: ${_getSignDestinations(sign)}';
  String _getTravelTimes(zodiac.ZodiacSign sign) =>
      'Jüpiter ve 9. ev transitlerinde seyahat güçlü.';
  String _getVacationType(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: ${_getElementVacation(sign.element)}';
  String _getAvoidTravelTimes(zodiac.ZodiacSign sign) =>
      'Merkür retro ve Mars karesi dönemlerinde dikkat.';
  String _getAstroGeography(zodiac.ZodiacSign sign) =>
      'Astrokartografi: Senin için güçlü enerji çizgileri.';
  String _getSpiritualJourneys(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} ruhsal yolculuk: Kutsal mekanlar ve hac.';
  String _get2024Recommendations(zodiac.ZodiacSign sign) =>
      'Jüpiter\'in etkisiyle bu yıl seyahat enerjisi güçlü.';

  String _getNaturalLearning(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} öğrenimi: ${_getElementLearning(sign.element)}';
  String _getExamTimes(zodiac.ZodiacSign sign) =>
      'Merkür uyumlu, Ay Başak/İkizler dönemleri.';
  String _getCreativeExpression(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} yaratıcılık: ${_getSignCreativity(sign)}';
  String _getLearningStyle(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: ${_getElementLearningStyle(sign.element)}';
  String _getRecommendedSubjects(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} için: ${_getSignSubjects(sign)}';
  String _getFocusTechniques(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: Meditasyon, Pomodoro, doğa molası.';
  String _getProductiveHours(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: ${_getElementProductiveTime(sign.element)}';

  String _getShadowSelf(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} gölgesi: ${_getSignShadow(sign)}';
  String _getHiddenFears(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} korkuları: ${_getSignFears(sign)}';
  String _getSuppressedEmotions(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} bastırılmış: ${_getElementSuppressed(sign.element)}';
  String _getProjectionPatterns(zodiac.ZodiacSign sign) =>
      '7. ev karşıtı: ${_getOppositeSign(sign)} özellikleri.';
  String _getTransformationPath(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} dönüşümü: Kabul, anlama, entegrasyon.';
  String _getDarkMoonRitual(zodiac.ZodiacSign sign) =>
      'Balzamik Ay: Bırakma, affetme, temizlik.';

  String _getManifestationPower(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: ${_getElementManifesting(sign.element)}';
  String _getPowerfulWindows(zodiac.ZodiacSign sign) =>
      'Yeni Ay ${sign.nameTr}\'da, Jüpiter uyumları.';
  String _getIntentionSetting(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} niyeti: ${_getElementIntention(sign.element)}';
  String _getVisionBoard(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} vizyonu: Görselleştirme ve yazılı niyet.';
  String _getAbundanceEnergy(zodiac.ZodiacSign sign) =>
      '2. ve 8. ev enerjisi: Maddi ve ruhsal bolluk.';
  String _getManifestationRitual(zodiac.ZodiacSign sign) =>
      'Yeni Ay ritüeli + kristal grid + yazılı niyet.';

  String _getPastLives(zodiac.ZodiacSign sign) =>
      'Güney Ay Düğümü ve 12. ev: Geçmiş yaşam izleri.';
  String _getGuardianAngels(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} koruyucusu: ${_getSignAngel(sign)}';
  String _getStarSeeds(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: Galaktik bağlantılar.';
  String _getAkashicRecords(zodiac.ZodiacSign sign) =>
      'Ruh sözleşmesi ve yaşam derslerin.';
  String _getSpiritGuides(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} rehberleri: ${_getElementGuides(sign.element)}';
  String _getCosmicMission(zodiac.ZodiacSign sign) =>
      'Kuzey Ay Düğümü: Ruhsal evrim yönün.';
  String _getGalacticOrigin(zodiac.ZodiacSign sign) =>
      '${sign.nameTr} yıldız sistemi: ${_getSignConstellation(sign)}';

  String _getMainPowerStones(zodiac.ZodiacSign sign) =>
      '${sign.nameTr}: ${_getSignMainStones(sign)}';
  String _getProtectiveCrystals(zodiac.ZodiacSign sign) =>
      'Siyah turmalin, obsidiyen, hematit.';
  String _getLoveCrystals(zodiac.ZodiacSign sign) =>
      'Gül kuvarsı, rodokrozit, kunzit.';
  String _getAbundanceStones(zodiac.ZodiacSign sign) =>
      'Sitrin, yeşil aventurin, pirrit.';
  String _getMeditationCrystals(zodiac.ZodiacSign sign) =>
      'Ametist, labradorit, selenite.';
  String _getAvoidStones(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr} için: ${_getElementAvoidStones(sign.element)}';

  String _getFullMoonRitual(zodiac.ZodiacSign sign) =>
      'Bırakma, tamamlama, kutlama, minnettarlık.';
  String _getNewMoonRitual(zodiac.ZodiacSign sign) =>
      'Niyet belirleme, tohum ekme, yeni başlangıçlar.';
  String _getSeasonalTransitions(zodiac.ZodiacSign sign) =>
      'Ekinoks ve gündönümü ritüelleri.';
  String _getEnergyCleansingRitual(zodiac.ZodiacSign sign) =>
      'Adaçayı, palo santo, tuz banyosu.';
  String _getDailyMiniRituals(zodiac.ZodiacSign sign) =>
      '• Sabah niyeti\n• Öğle şükür\n• Akşam yansıma\n• Gece affetme';
  String _getMoonPhaseRituals(zodiac.ZodiacSign sign) =>
      'Her ay fazının kendi ritüel enerjisi var.';

  String _getRootChakra(zodiac.ZodiacSign sign) =>
      'Güvenlik, topraklama, temel ihtiyaçlar.';
  String _getSacralChakra(zodiac.ZodiacSign sign) =>
      'Yaratıcılık, duygular, cinsellik.';
  String _getSolarPlexus(zodiac.ZodiacSign sign) => 'Güç, irade, özgüven.';
  String _getHeartChakra(zodiac.ZodiacSign sign) => 'Sevgi, şefkat, bağlantı.';
  String _getThroatChakra(zodiac.ZodiacSign sign) =>
      'İletişim, ifade, doğruluk.';
  String _getThirdEye(zodiac.ZodiacSign sign) => 'Sezgi, vizyon, bilgelik.';
  String _getCrownChakra(zodiac.ZodiacSign sign) =>
      'Ruhsal bağlantı, aydınlanma.';
  String _getOverallBalance(zodiac.ZodiacSign sign) =>
      '${sign.element.nameTr}: ${_getElementChakraBalance(sign.element)}';

  // Element bazlı yardımcı fonksiyonlar
  String _getElementDreamStyle(zodiac.Element e) => e == zodiac.Element.fire
      ? 'aksiyon, savaş, liderlik'
      : e == zodiac.Element.earth
      ? 'doğa, ev, maddi'
      : e == zodiac.Element.air
      ? 'uçuş, iletişim, seyahat'
      : 'su, duygular, sezgiler';
  String _getElementLucidTip(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Enerji yüksekken, geceyarısı öncesi'
      : e == zodiac.Element.earth
      ? 'Dolunay gecelerinde'
      : e == zodiac.Element.air
      ? 'Rüzgarlı gecelerde'
      : 'Yeni Ay döneminde';
  String _getElementTantra(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Nefes ateşi, enerji hareketi'
      : e == zodiac.Element.earth
      ? 'Duyusal farkındalık, topraklama'
      : e == zodiac.Element.air
      ? 'Pranayama, nefes kontrolü'
      : 'Duygusal akış, su meditasyonu';
  String _getElementBreath(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Kapalı Burun (Bhastrika)'
      : e == zodiac.Element.earth
      ? '4-7-8 Nefesi'
      : e == zodiac.Element.air
      ? 'Alternatif Burun'
      : 'Okyanus Nefesi (Ujjayi)';
  String _getElementNutrition(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Baharatlı, protein zengin'
      : e == zodiac.Element.earth
      ? 'Kök sebzeler, tahıllar'
      : e == zodiac.Element.air
      ? 'Hafif, çiğ yiyecekler'
      : 'Sulak meyveler, deniz ürünleri';
  String _getElementExercise(zodiac.Element e) => e == zodiac.Element.fire
      ? 'HIIT, boks, koşu'
      : e == zodiac.Element.earth
      ? 'Yoga, yürüyüş, ağırlık'
      : e == zodiac.Element.air
      ? 'Dans, zumba, bisiklet'
      : 'Yüzme, su aerobiği';
  String _getElementHealthTip(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Dinlenmeyi ihmal etme'
      : e == zodiac.Element.earth
      ? 'Hareketsizliğe dikkat'
      : e == zodiac.Element.air
      ? 'Sinir sistemi için mola'
      : 'Sınır koyma öğren';
  String _getElementPet(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Köpek, at'
      : e == zodiac.Element.earth
      ? 'Kedi, tavşan'
      : e == zodiac.Element.air
      ? 'Kuş, papağan'
      : 'Balık, kaplumbağa';
  String _getElementHome(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Güneşli, enerjik, açık renkler'
      : e == zodiac.Element.earth
      ? 'Doğal, toprak tonları, bitkiler'
      : e == zodiac.Element.air
      ? 'Minimalist, havadar, açık'
      : 'Su öğeleri, maviler, akıcı';
  String _getElementVacation(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Macera, safari, dağ tırmanışı'
      : e == zodiac.Element.earth
      ? 'Spa, şarap turları, doğa'
      : e == zodiac.Element.air
      ? 'Şehir turları, festivaller'
      : 'Deniz, göl, retreat';
  String _getElementLearning(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Pratik, el yapımı, spor'
      : e == zodiac.Element.earth
      ? 'Sistematik, adım adım'
      : e == zodiac.Element.air
      ? 'Teorik, tartışma, sosyal'
      : 'Sezgisel, sanatsal, duygusal';
  String _getElementLearningStyle(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Kinestetik öğrenci'
      : e == zodiac.Element.earth
      ? 'Görsel öğrenci'
      : e == zodiac.Element.air
      ? 'İşitsel öğrenci'
      : 'Sezgisel öğrenci';
  String _getElementProductiveTime(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Sabah 6-10, öğlen 12-14'
      : e == zodiac.Element.earth
      ? 'Sabah 8-12, akşam 16-18'
      : e == zodiac.Element.air
      ? 'Öğle 10-14, gece 20-22'
      : 'Gece yarısı, erken sabah';
  String _getElementSuppressed(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Korku, güvensizlik'
      : e == zodiac.Element.earth
      ? 'Spontanlık, risk alma'
      : e == zodiac.Element.air
      ? 'Derin duygular, bağlanma'
      : 'Öfke, sınır koyma';
  String _getElementManifesting(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Aksiyon odaklı, hızlı'
      : e == zodiac.Element.earth
      ? 'Somut, sabırlı, uzun vadeli'
      : e == zodiac.Element.air
      ? 'Vizyon, iletişim, bağlantı'
      : 'Sezgisel, duygusal, akış';
  String _getElementIntention(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Cesaret, liderlik, başarı'
      : e == zodiac.Element.earth
      ? 'Güvenlik, bolluk, istikrar'
      : e == zodiac.Element.air
      ? 'İletişim, öğrenme, seyahat'
      : 'Sevgi, şifa, ruhsal büyüme';
  String _getElementGuides(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Savaşçı, kahraman arketipleri'
      : e == zodiac.Element.earth
      ? 'Doğa ruhları, toprak melekleri'
      : e == zodiac.Element.air
      ? 'Elçi melekler, bilgelik varlıkları'
      : 'Su perileri, şifa melekleri';
  String _getElementAvoidStones(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Çok sakinleştirici taşlar'
      : e == zodiac.Element.earth
      ? 'Çok enerji veren taşlar'
      : e == zodiac.Element.air
      ? 'Çok topraklayıcı taşlar'
      : 'Çok ateşli taşlar';
  String _getElementChakraBalance(zodiac.Element e) => e == zodiac.Element.fire
      ? 'Solar pleksus ve kök çakra güçlü'
      : e == zodiac.Element.earth
      ? 'Kök ve sakral çakra dominant'
      : e == zodiac.Element.air
      ? 'Boğaz ve üçüncü göz aktif'
      : 'Kalp ve taç çakra hassas';

  // Burç bazlı yardımcı fonksiyonlar
  String _getSignSubconscious(zodiac.ZodiacSign s) =>
      'İçsel korkular ve arzular.';
  String _getSignDreamSymbols(zodiac.ZodiacSign s) =>
      'Burç sembollerinin rüya yorumu.';
  String _getSignHerb(zodiac.ZodiacSign s) => s == zodiac.ZodiacSign.aries
      ? 'Zencefil'
      : s == zodiac.ZodiacSign.taurus
      ? 'Papatya'
      : 'Lavanta';
  String _getSignMeditation(zodiac.ZodiacSign s) =>
      '${s.element.nameTr} elementi meditasyonu.';
  String _getSignChakra(zodiac.ZodiacSign s) =>
      '${s.element.nameTr} elementi çakrası.';
  String _getSignHerbs(zodiac.ZodiacSign s) =>
      'Burca özel şifalı bitkiler listesi.';
  String _getSignDestinations(zodiac.ZodiacSign s) =>
      'Astrolojik coğrafya önerileri.';
  String _getSignCreativity(zodiac.ZodiacSign s) => 'Yaratıcı ifade kanalları.';
  String _getSignSubjects(zodiac.ZodiacSign s) => 'Doğal yatkınlık alanları.';
  String _getSignShadow(zodiac.ZodiacSign s) => 'Gölge yönleri ve dönüşüm.';
  String _getSignFears(zodiac.ZodiacSign s) => 'Bilinçaltı korkular.';
  String _getOppositeSign(zodiac.ZodiacSign s) => s == zodiac.ZodiacSign.aries
      ? 'Terazi'
      : s == zodiac.ZodiacSign.taurus
      ? 'Akrep'
      : 'Karşıt burç';
  String _getSignAngel(zodiac.ZodiacSign s) => 'Koruyucu melek ismi.';
  String _getSignConstellation(zodiac.ZodiacSign s) =>
      '${s.nameTr} takımyıldızı.';
  String _getSignMainStones(zodiac.ZodiacSign s) => 'Ana güç taşları listesi.';
  String _getHealthWeakness(zodiac.ZodiacSign s) =>
      'Sağlık açısından hassas bölgeler.';

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════
  // UI BUILD METHODLARı
  // ═══════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildChatArea()),
              if (_messages.length <= 1) _buildSuggestedQuestions(),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.nebulaPurple.withOpacity(0.5), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(
                        0xFF9D4EDD,
                      ).withOpacity(0.5 + _pulseController.value * 0.3),
                      AppColors.nebulaPurple.withOpacity(0.3),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF9D4EDD,
                      ).withOpacity(0.4 * _pulseController.value),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Text('🌌', style: TextStyle(fontSize: 24)),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFFFF6B9D),
                      Color(0xFF9D4EDD),
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'Kozmoz İzi',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Kozmik AI Asistanın',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showFeaturesSheet(context),
            icon: const Icon(Icons.apps_rounded, color: AppColors.starGold),
            tooltip: 'Tüm Çözümlemeler',
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildChatArea() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isTyping) {
          return _buildTypingIndicator();
        }
        return _buildMessageBubble(_messages[index], index);
      },
    );
  }

  Widget _buildMessageBubble(_ChatMessage message, int index) {
    final isUser = message.isUser;

    return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF9D4EDD).withOpacity(0.5),
                        AppColors.nebulaPurple.withOpacity(0.3),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('🌌', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isUser
                          ? [
                              AppColors.cosmicPurple.withOpacity(0.4),
                              AppColors.nebulaPurple.withOpacity(0.3),
                            ]
                          : [
                              const Color(0xFF9D4EDD).withOpacity(0.2),
                              const Color(0xFF1A1A2E).withOpacity(0.8),
                            ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isUser ? 18 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 18),
                    ),
                    border: Border.all(
                      color: isUser
                          ? AppColors.cosmicPurple.withOpacity(0.3)
                          : const Color(0xFF9D4EDD).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              if (isUser) const SizedBox(width: 8),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideX(begin: isUser ? 0.2 : -0.2, end: 0, duration: 300.ms);
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF9D4EDD).withOpacity(0.5),
                  AppColors.nebulaPurple.withOpacity(0.3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Text('🌌', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF9D4EDD).withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF9D4EDD).withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: const Text('✨', style: TextStyle(fontSize: 14)),
                    )
                    .animate(onComplete: (c) => c.repeat())
                    .fadeIn(duration: 400.ms, delay: (200 * index).ms)
                    .then()
                    .fadeOut(duration: 400.ms, delay: 400.ms);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedQuestions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡 Önerilen Sorular:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _suggestedQuestions.length,
              itemBuilder: (context, index) {
                final q = _suggestedQuestions[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () => _sendMessage(q['text']),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF9D4EDD).withOpacity(0.2),
                            AppColors.cosmicPurple.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF9D4EDD).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            q['emoji'],
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              q['text'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [AppColors.nebulaPurple.withOpacity(0.5), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF9D4EDD).withOpacity(0.15),
                    const Color(0xFF1A1A2E).withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF9D4EDD).withOpacity(0.3),
                ),
              ),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) {
                  if (event.isKeyPressed(LogicalKeyboardKey.enter) &&
                      !event.isShiftPressed) {
                    _sendMessage();
                  }
                },
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  maxLines: 5,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    hintText: 'Kozmoz\'a sor... (Enter ile gönder)',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.6),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
                onTap: () => _sendMessage(),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9D4EDD), Color(0xFFFF6B9D)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF9D4EDD).withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              )
              .animate(onComplete: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 1500.ms,
              ),
        ],
      ),
    );
  }

  void _showFeaturesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _FeaturesSheet(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CHAT MESSAGE MODEL
// ═══════════════════════════════════════════════════════════════

class _ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  _ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

// ═══════════════════════════════════════════════════════════════
// FEATURES SHEET - Tüm özelliklere hızlı erişim
// ═══════════════════════════════════════════════════════════════

class _FeaturesSheet extends StatelessWidget {
  final List<Map<String, dynamic>> _features = [
    {'emoji': '⭐', 'name': 'Burç Yorumları', 'route': Routes.horoscope},
    {'emoji': '🗺️', 'name': 'Doğum Haritası', 'route': Routes.birthChart},
    {'emoji': '💕', 'name': 'Burç Uyumu', 'route': Routes.compatibility},
    {'emoji': '🪐', 'name': 'Transitler', 'route': Routes.transits},
    {'emoji': '🔢', 'name': 'Numeroloji', 'route': Routes.numerology},
    {'emoji': '🎴', 'name': 'Tarot', 'route': Routes.tarot},
    {'emoji': '🌙', 'name': 'Rüya İzi', 'route': Routes.dreamInterpretation},
    {'emoji': '✨', 'name': 'Aura Analizi', 'route': Routes.aura},
    {'emoji': '🔮', 'name': 'Çakra Analizi', 'route': Routes.chakraAnalysis},
    {'emoji': '📅', 'name': 'Zamanlama', 'route': Routes.timing},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.nebulaPurple, const Color(0xFF0D0D1A)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text('🚀', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  'Hızlı Erişim',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _features.length,
              itemBuilder: (context, index) {
                final feature = _features[index];
                return InkWell(
                  onTap: () {
                    context.pop();
                    context.push(feature['route']);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF9D4EDD).withOpacity(0.2),
                          AppColors.cosmicPurple.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF9D4EDD).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          feature['emoji'],
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          feature['name'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
