import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/models/zodiac_sign.dart' as zodiac;
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/interpretive_text.dart';

/// Kozmik Keşif - Genel Şablon Ekranı
/// Her bir keşif içeriği için özelleştirilmiş ekran
class CosmicDiscoveryScreen extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final Color primaryColor;
  final CosmicDiscoveryType type;

  const CosmicDiscoveryScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.primaryColor,
    required this.type,
  });

  @override
  ConsumerState<CosmicDiscoveryScreen> createState() =>
      _CosmicDiscoveryScreenState();
}

class _CosmicDiscoveryScreenState extends ConsumerState<CosmicDiscoveryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _isRevealed = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final sign = userProfile?.sunSign ?? zodiac.ZodiacSign.aries;
    final userName = userProfile?.name ?? 'Gezgin';

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Hero Section
                      _buildHeroSection(context, sign, userName),
                      const SizedBox(height: 24),

                      // Reveal Button or Content
                      if (!_isRevealed)
                        _buildRevealButton(context)
                      else
                        _buildContent(context, sign, userName),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Flexible(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            widget.primaryColor,
                            Colors.white,
                            widget.primaryColor,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Share Button
          GestureDetector(
            onTap: () => _shareContent(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.primaryColor.withOpacity(0.3),
                    widget.primaryColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: widget.primaryColor.withOpacity(0.5)),
              ),
              child: const Icon(
                Icons.share_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.primaryColor.withOpacity(0.3),
            widget.primaryColor.withOpacity(0.1),
            Colors.black.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: widget.primaryColor.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Emoji ve Burç
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 50)),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      sign.color.withOpacity(0.4),
                      sign.color.withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: sign.color, width: 2),
                ),
                child: Text(
                  sign.symbol,
                  style: TextStyle(fontSize: 36, color: sign.color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Başlık
          Text(
            '$userName, ${widget.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: widget.primaryColor, blurRadius: 10)],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${sign.nameTr} Burcu Analizi',
            style: TextStyle(
              fontSize: 16,
              color: sign.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevealButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isRevealed = true);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.primaryColor, widget.primaryColor.withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: widget.primaryColor.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Keşfet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final content = _getContent(sign, userName);

    return Column(
      children: [
        // Ana İçerik Kartı
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.primaryColor.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ana Mesaj
              AutoGlossaryText(
                text: content['mainMessage'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.6,
                ),
                maxHighlights: 5,
              ),
              const SizedBox(height: 24),

              // Detaylar
              if (content['details'] != null) ...[
                _buildDetailSection(
                  'Detaylı Analiz',
                  content['details']!,
                  Icons.psychology,
                ),
                const SizedBox(height: 16),
              ],

              // Tavsiyeler
              if (content['advice'] != null) ...[
                _buildDetailSection(
                  'Tavsiyeler',
                  content['advice']!,
                  Icons.lightbulb_outline,
                ),
                const SizedBox(height: 16),
              ],

              // Uyarılar
              if (content['warning'] != null) ...[
                _buildWarningSection(content['warning']!),
              ],
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Paylaş Butonu
        _buildShareCard(context, content),
      ],
    );
  }

  Widget _buildDetailSection(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: widget.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: widget.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AutoGlossaryText(
            text: content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.5,
            ),
            maxHighlights: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildWarningSection(String warning) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AutoGlossaryText(
              text: warning,
              style: TextStyle(
                color: Colors.amber.shade100,
                fontSize: 13,
                height: 1.4,
              ),
              maxHighlights: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareCard(BuildContext context, Map<String, String> content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE91E63).withOpacity(0.2),
            const Color(0xFFFF5722).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE91E63).withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.camera_alt, color: Color(0xFFE91E63), size: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Bu keşfi Instagram\'da paylaş!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _shareContent(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Paylaş',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareContent(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Paylaşım özelliği yakında!'),
        backgroundColor: widget.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Map<String, String> _getContent(zodiac.ZodiacSign sign, String userName) {
    return CosmicDiscoveryContent.getContent(widget.type, sign, userName);
  }
}

/// Kozmik Keşif Türleri
enum CosmicDiscoveryType {
  // Günlük Enerjiler
  dailySummary,
  moonEnergy,
  moonRituals, // Ay Ritüelleri - distinct from moonEnergy
  loveEnergy,
  abundanceEnergy,

  // Ruhsal Dönüşüm
  spiritualTransformation,
  lifePurpose,
  subconsciousPatterns,
  karmaLessons,
  soulContract,
  innerPower,

  // Kişilik Analizleri
  shadowSelf,
  leadershipStyle,
  heartbreak,
  redFlags,
  greenFlags,
  flirtStyle,

  // Mistik Keşifler
  tarotCard,
  auraColor,
  crystalGuide, // Kristal Rehberi - distinct from auraColor
  chakraBalance,
  lifeNumber,
  kabbalaPath,

  // Zaman & Döngüler
  saturnLessons,
  birthdayEnergy,
  eclipseEffect,
  transitFlow,

  // İlişki Analizleri
  compatibilityAnalysis,
  soulMate,
  relationshipKarma,
  celebrityTwin,
}

/// Kozmik Keşif İçerik Sağlayıcı
class CosmicDiscoveryContent {
  static Map<String, String> getContent(
    CosmicDiscoveryType type,
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    switch (type) {
      case CosmicDiscoveryType.shadowSelf:
        return _getShadowSelfContent(sign, userName);
      case CosmicDiscoveryType.redFlags:
        return _getRedFlagsContent(sign, userName);
      case CosmicDiscoveryType.greenFlags:
        return _getGreenFlagsContent(sign, userName);
      case CosmicDiscoveryType.lifePurpose:
        return _getLifePurposeContent(sign, userName);
      case CosmicDiscoveryType.karmaLessons:
        return _getKarmaLessonsContent(sign, userName);
      case CosmicDiscoveryType.soulContract:
        return _getSoulContractContent(sign, userName);
      case CosmicDiscoveryType.innerPower:
        return _getInnerPowerContent(sign, userName);
      case CosmicDiscoveryType.flirtStyle:
        return _getFlirtStyleContent(sign, userName);
      case CosmicDiscoveryType.leadershipStyle:
        return _getLeadershipStyleContent(sign, userName);
      case CosmicDiscoveryType.heartbreak:
        return _getHeartbreakContent(sign, userName);
      case CosmicDiscoveryType.soulMate:
        return _getSoulMateContent(sign, userName);
      case CosmicDiscoveryType.spiritualTransformation:
        return _getSpiritualTransformationContent(sign, userName);
      case CosmicDiscoveryType.subconsciousPatterns:
        return _getSubconsciousPatternsContent(sign, userName);
      case CosmicDiscoveryType.dailySummary:
        return _getDailySummaryContent(sign, userName);
      case CosmicDiscoveryType.moonEnergy:
        return _getMoonEnergyContent(sign, userName);
      case CosmicDiscoveryType.moonRituals:
        return _getMoonRitualsContent(sign, userName);
      case CosmicDiscoveryType.loveEnergy:
        return _getLoveEnergyContent(sign, userName);
      case CosmicDiscoveryType.abundanceEnergy:
        return _getAbundanceEnergyContent(sign, userName);
      case CosmicDiscoveryType.tarotCard:
        return _getTarotCardContent(sign, userName);
      case CosmicDiscoveryType.auraColor:
        return _getAuraColorContent(sign, userName);
      case CosmicDiscoveryType.crystalGuide:
        return _getCrystalGuideContent(sign, userName);
      case CosmicDiscoveryType.chakraBalance:
        return _getChakraBalanceContent(sign, userName);
      case CosmicDiscoveryType.lifeNumber:
        return _getLifeNumberContent(sign, userName);
      case CosmicDiscoveryType.kabbalaPath:
        return _getKabbalaPathContent(sign, userName);
      case CosmicDiscoveryType.saturnLessons:
        return _getSaturnLessonsContent(sign, userName);
      case CosmicDiscoveryType.birthdayEnergy:
        return _getBirthdayEnergyContent(sign, userName);
      case CosmicDiscoveryType.eclipseEffect:
        return _getEclipseEffectContent(sign, userName);
      case CosmicDiscoveryType.transitFlow:
        return _getTransitFlowContent(sign, userName);
      case CosmicDiscoveryType.compatibilityAnalysis:
        return _getCompatibilityAnalysisContent(sign, userName);
      case CosmicDiscoveryType.relationshipKarma:
        return _getRelationshipKarmaContent(sign, userName);
      case CosmicDiscoveryType.celebrityTwin:
        return _getCelebrityTwinContent(sign, userName);
    }
  }

  static Map<String, String> _getShadowSelfContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final shadows = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, senin gölge benliğin sabırsızlık ve öfke kontrolü ile ilgili. Koç burcu olarak hızlı hareket etme isteğin bazen seni dürtüsel kararlara sürükleyebilir. Gölgen, başkalarını geride bırakma korkusundan besleniyor.',
        'details':
            'Gölge Koç: Aşırı rekabetçilik, başkalarının fikirlerini dinlememe, "ben bilirim" tutumu, sabırsızlıktan kaynaklanan yarım bırakılmış projeler. Öfke patlamaları ve sonra pişmanlık döngüsü.',
        'advice':
            'Gölgenle yüzleşmek için: Bir şey yapmadan önce 10 saniye bekle. Başkalarının da haklı olabileceğini kabul et. Rekabeti iş birliğine dönüştür.',
        'warning':
            'Dikkat: Gölgeni bastırmak onu güçlendirir. Onu kabul et ve dönüştür.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, senin gölge benliğin inatçılık ve maddi bağımlılık ile ilgili. Boğa burcu olarak güvenlik arayışın bazen seni değişime dirençli yapabilir. Gölgen, kaybetme korkusundan besleniyor.',
        'details':
            'Gölge Boğa: Aşırı sahiplenme, değişime direnç, konfor alanında sıkışıp kalma, maddi güvenliği duygusal güvenliğin önüne koyma. Tembellik ve erteleme eğilimi.',
        'advice':
            'Gölgenle yüzleşmek için: Küçük değişikliklerle başla. "Sahip olduklarım ben değilim" mantrası. Bazen kayıp, kazançtır.',
        'warning': 'Dikkat: Aşırı güvenlik arayışı seni hayattan kopabilir.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, senin gölge benliğin tutarsızlık ve yüzeysellik ile ilgili. İkizler burcu olarak merakın bazen seni dağıtabilir. Gölgen, derinleşme korkusundan besleniyor.',
        'details':
            'Gölge İkizler: Sözünde durmama, ilgi dağınıklığı, dedikodu yapma eğilimi, duygusal derinlikten kaçınma. İki yüzlülük algısı yaratma.',
        'advice':
            'Gölgenle yüzleşmek için: Bir konuya odaklan ve derinleş. Verdiğin sözleri yaz ve takip et. Sessizliğin gücünü keşfet.',
        'warning': 'Dikkat: Sürekli kaçış, hiçbir yere varmamana neden olur.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, senin gölge benliğin aşırı hassasiyet ve manipülasyon ile ilgili. Yengeç burcu olarak koruyuculuğun bazen boğucu olabilir. Gölgen, reddedilme korkusundan besleniyor.',
        'details':
            'Gölge Yengeç: Duygusal manipülasyon, geçmişe takılıp kalma, pasif agresif davranışlar, "kurban" rolü oynama. Aşırı korumacılık ve kontrol.',
        'advice':
            'Gölgenle yüzleşmek için: Duygularını doğrudan ifade et. Geçmişi bırak, şimdiyi yaşa. Sevdiklerini özgür bırak.',
        'warning': 'Dikkat: Kabuğuna çekilmek problemi çözmez, sadece erteler.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, senin gölge benliğin ego ve onay bağımlılığı ile ilgili. Aslan burcu olarak parıldama isteğin bazen başkalarını gölgede bırakabilir. Gölgen, görünmez olma korkusundan besleniyor.',
        'details':
            'Gölge Aslan: Aşırı ego, sürekli ilgi beklentisi, eleştiriyi kaldıramama, başkalarının başarısını kıskanma. Drama yaratma eğilimi.',
        'advice':
            'Gölgenle yüzleşmek için: Başkalarını öv ve onların parlamasına izin ver. Kendi değerini içsel kaynaklardan bul. Tevazu pratiği yap.',
        'warning': 'Dikkat: Dışarıdan onay, içerideki boşluğu doldurmaz.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, senin gölge benliğin mükemmeliyetçilik ve eleştiri ile ilgili. Başak burcu olarak detaycılığın bazen felç edici olabilir. Gölgen, yetersizlik korkusundan besleniyor.',
        'details':
            'Gölge Başak: Aşırı eleştiri (kendine ve başkalarına), hiçbir şeyin yeterli olmadığı hissi, kaygı ve endişe, "paralysis by analysis". Başkalarını küçümseme.',
        'advice':
            'Gölgenle yüzleşmek için: "Yeterince iyi" kavramını öğren. Hataları öğrenme fırsatı olarak gör. Kendine şefkat göster.',
        'warning':
            'Dikkat: Mükemmellik arayışı, hiçbir şey yapmamakla sonuçlanabilir.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, senin gölge benliğin kararsızlık ve çatışmadan kaçınma ile ilgili. Terazi burcu olarak uyum arayışın bazen seni kendi ihtiyaçlarından uzaklaştırabilir. Gölgen, yalnız kalma korkusundan besleniyor.',
        'details':
            'Gölge Terazi: Herkesi memnun etme çabası, kendi fikrini söyleyememe, pasif agresiflik, yüzeysel ilişkiler. Kararlarını başkalarına bırakma.',
        'advice':
            'Gölgenle yüzleşmek için: "Hayır" demeyi öğren. Kendi fikrini savun. Sağlıklı çatışma kaçınılmazdır ve gereklidir.',
        'warning':
            'Dikkat: Herkesi mutlu etmeye çalışmak, en çok kendini mutsuz eder.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, senin gölge benliğin kontrol ve intikam ile ilgili. Akrep burcu olarak yoğunluğun bazen zehirli olabilir. Gölgen, güç kaybetme korkusundan besleniyor.',
        'details':
            'Gölge Akrep: Aşırı kıskançlık ve sahiplenme, manipülasyon, intikam düşünceleri, güvensizlik. Gizlilik takıntısı ve paranoya.',
        'advice':
            'Gölgenle yüzleşmek için: Kontrolü bırakmayı öğren. Affetmenin gücünü keşfet. Güven inşa etmek için açıl.',
        'warning': 'Dikkat: İntikam seni karşındakinden çok kendini yakar.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, senin gölge benliğin sorumsuzluk ve taahhütten kaçınma ile ilgili. Yay burcu olarak özgürlük aşkın bazen kaçış olabilir. Gölgen, sıkışıp kalma korkusundan besleniyor.',
        'details':
            'Gölge Yay: Taahhüt fobisi, aşırı iyimserlikle gerçeklerden kaçış, sözünde durmama, sorumluluktan kaçınma. Düşüncesiz sözler.',
        'advice':
            'Gölgenle yüzleşmek için: Özgürlük ve bağlılığın bir arada olabileceğini öğren. Sözlerinin etkisini düşün. Kaçmak yerine yüzleş.',
        'warning':
            'Dikkat: Sürekli kaçış, hiçbir yere ait olmamakla sonuçlanır.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, senin gölge benliğin iş bağımlılığı ve duygusal mesafe ile ilgili. Oğlak burcu olarak hırsın bazen seni insanlıktan uzaklaştırabilir. Gölgen, başarısızlık korkusundan besleniyor.',
        'details':
            'Gölge Oğlak: Workaholism, duygusal soğukluk, statü takıntısı, başkalarını araç olarak görme. Pesimizm ve umutsuzluk.',
        'advice':
            'Gölgenle yüzleşmek için: İş-yaşam dengesi kur. Duygularını ifade et. Başarı tanımını genişlet.',
        'warning': 'Dikkat: Zirveye ulaştığında yanında kimse olmayabilir.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, senin gölge benliğin duygusal mesafe ve üstünlük kompleksi ile ilgili. Kova burcu olarak farklılığın bazen yalnızlığa dönüşebilir. Gölgen, sıradan olma korkusundan besleniyor.',
        'details':
            'Gölge Kova: Duygusal kopukluk, "ben herkesin ötesindeyim" tutumu, empati eksikliği, yakın ilişkilerden kaçınma. Asi pose.',
        'advice':
            'Gölgenle yüzleşmek için: Farklı olmak için farklı olma. Duygusal bağlantı kur. İnsanlığın bir parçası olduğunu hatırla.',
        'warning':
            'Dikkat: Herkesin ötesinde olmak, hiç kimseyle birlikte olmamak demek.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, senin gölge benliğin kaçış ve kurban zihniyeti ile ilgili. Balık burcu olarak hassasiyetin bazen seni gerçeklikten koparabilir. Gölgen, acı çekme korkusundan besleniyor.',
        'details':
            'Gölge Balık: Bağımlılık eğilimleri (madde, ilişki, fantezi), kurban rolü, sınır koyamama, gerçeklikten kaçış. Aldatıcı olma veya aldanma.',
        'advice':
            'Gölgenle yüzleşmek için: Sağlıklı sınırlar koy. Kaçış yerine yüzleşmeyi seç. Hayal ile gerçeği ayır.',
        'warning':
            'Dikkat: Gerçeklikten sürekli kaçış, daha büyük acılara yol açar.',
      },
    };

    return shadows[sign] ??
        {
          'mainMessage': 'Gölge benliğin keşfediliyor...',
          'details': 'Detaylar yükleniyor...',
          'advice': 'Tavsiyeler hazırlanıyor...',
        };
  }

  static Map<String, String> _getRedFlagsContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final redFlags = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Koç burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Sabırsızlık ve ani öfke patlamaları\n🚩 Başkalarının fikirlerini dinlemeden karar verme\n🚩 "Benim yolum ya da hiç" tutumu\n🚩 Hızlı sıkılma ve yarım bırakma\n🚩 Ego çatışmalarında geri adım atmama\n🚩 Düşünmeden hareket etme',
        'advice':
            'Bunları fark ettiğinde: Dur, nefes al, 10\'a kadar say. Başkalarının da haklı olabileceğini düşün.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Boğa burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Aşırı inatçılık ve değişime direnç\n🚩 Sahiplenicilik ve kıskançlık\n🚩 Maddi güvenliği her şeyin önüne koyma\n🚩 Konfor alanından çıkmayı reddetme\n🚩 Tembellik ve erteleme\n🚩 İntikamcı olabilme',
        'advice':
            'Bunları fark ettiğinde: Değişimin büyüme olduğunu hatırla. Sahip oldukların seni tanımlamaz.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! İkizler burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Tutarsızlık ve sözünde durmama\n🚩 Dedikodu yapma eğilimi\n🚩 Yüzeysellik ve derinleşememe\n🚩 İki yüzlülük algısı\n🚩 Sürekli dikkat dağınıklığı\n🚩 Duygusal bağlanmaktan kaçınma',
        'advice':
            'Bunları fark ettiğinde: Bir konuya odaklan. Verdiğin sözleri not al ve tut.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Yengeç burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Duygusal manipülasyon\n🚩 Pasif agresif davranışlar\n🚩 Geçmişe takılıp kalma\n🚩 Aşırı hassasiyet ve alınganlık\n🚩 Kabuğuna çekilme ve iletişimi kesme\n🚩 Suçluluk duygusu yaratma',
        'advice':
            'Bunları fark ettiğinde: Duygularını doğrudan ifade et. Geçmiş geçmişte kaldı.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Aslan burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Aşırı ego ve kendini beğenmişlik\n🚩 Sürekli ilgi ve övgü beklentisi\n🚩 Eleştiriyi hiç kaldıramama\n🚩 Drama yaratma\n🚩 Başkalarının parlamasını kıskanma\n🚩 Her şeyin merkezinde olma isteği',
        'advice':
            'Bunları fark ettiğinde: Başkalarını da öv. Alçakgönüllülük krallığı zayıflatmaz, güçlendirir.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Başak burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Aşırı eleştiri (kendine ve başkalarına)\n🚩 Mükemmeliyetçilik takıntısı\n🚩 Küçük detaylara takılıp büyük resmi kaçırma\n🚩 Sürekli kaygı ve endişe\n🚩 Başkalarını küçümseme\n🚩 Hiçbir şeyin yeterli olmaması',
        'advice':
            'Bunları fark ettiğinde: "Yeterince iyi" yeterlidir. Kendine şefkat göster.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Terazi burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Aşırı kararsızlık\n🚩 Herkesi memnun etme çabası\n🚩 Çatışmadan kaçınma\n🚩 Kendi fikrini söyleyememe\n🚩 Yüzeysel ilişkiler kurma\n🚩 Pasif agresif davranışlar',
        'advice':
            'Bunları fark ettiğinde: Kendi sesini bul. Hayır demek sevgi kaybı değildir.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Akrep burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Aşırı kıskançlık ve sahiplenme\n🚩 İntikam düşünceleri\n🚩 Manipülasyon\n🚩 Güvensizlik ve paranoya\n🚩 Her şeyi kontrol etme isteği\n🚩 Affetmekte zorlanma',
        'advice':
            'Bunları fark ettiğinde: Kontrolü bırak. Affetmek güçsüzlük değil, güçtür.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Yay burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Taahhüt fobisi\n🚩 Sorumsuzluk\n🚩 Düşüncesiz ve kırıcı sözler\n🚩 Vaatlerini tutmama\n🚩 Gerçeklerden kaçış\n🚩 Sürekli "daha iyi bir şey var" düşüncesi',
        'advice':
            'Bunları fark ettiğinde: Sözlerinin ağırlığını hisset. Bazen en büyük macera, kalmaktır.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Oğlak burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 İş bağımlılığı\n🚩 Duygusal soğukluk ve mesafe\n🚩 Statü takıntısı\n🚩 İnsanları araç olarak görme\n🚩 Aşırı pesimizm\n🚩 Hayatı sadece başarıyla ölçme',
        'advice':
            'Bunları fark ettiğinde: İlişkiler de yatırımdır. Başarı, sevdiklerinle paylaşılmazsa boştur.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Kova burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Duygusal kopukluk\n🚩 Üstünlük kompleksi\n🚩 Empati eksikliği\n🚩 Yakın ilişkilerden kaçınma\n🚩 "Kimse beni anlamıyor" tutumu\n🚩 Sırf farklı olmak için farklı olma',
        'advice':
            'Bunları fark ettiğinde: Farklı olmak seni daha iyi yapmaz. Bağlantı kurmak güçtür.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, işte senin Red Flag\'lerin! Balık burcu olarak bu davranışların farkında olmak önemli.',
        'details':
            '🚩 Kurban zihniyeti\n🚩 Gerçeklikten kaçış\n🚩 Bağımlılık eğilimleri\n🚩 Sınır koyamama\n🚩 Aşırı fedakarlık ve sonra şikayet\n🚩 Hayal ile gerçeği karıştırma',
        'advice':
            'Bunları fark ettiğinde: Sınırlar sevginin düşmanı değil, koruyucusudur.',
      },
    };

    return redFlags[sign] ?? {'mainMessage': 'İçerik yükleniyor...'};
  }

  static Map<String, String> _getGreenFlagsContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final greenFlags = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Koç burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Cesaret ve girişimcilik\n💚 Liderlik yeteneği\n💚 Dürüstlük ve açık sözlülük\n💚 Enerji ve coşku\n💚 Koruyuculuk\n💚 Hayata atılma cesareti',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Cesaretini başkalarına ilham vermek için kullan.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Boğa burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Sadakat ve güvenilirlik\n💚 Sabır ve kararlılık\n💚 Pratik zeka\n💚 Duyusal zevkleri takdir etme\n💚 Finansal akıl\n💚 Sakin ve topraklanmış enerji',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Sadakatin en değerli hediyedir.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! İkizler burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Zeka ve merak\n💚 İletişim yeteneği\n💚 Uyum sağlama\n💚 Eğlenceli ve espritüel\n💚 Çok yönlülük\n💚 Sosyal beceriler',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. İletişim gücünle köprüler kur.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Yengeç burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Şefkat ve empati\n💚 Koruyuculuk\n💚 Duygusal zeka\n💚 Sezgisel güç\n💚 Yuva kurma yeteneği\n💚 Sadakat',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Şefkatin dünyayı değiştirir.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Aslan burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Cömertlik\n💚 Yaratıcılık\n💚 Sıcaklık ve neşe\n💚 Liderlik\n💚 Sadakat\n💚 İlham verme yeteneği',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Parıldaman başkalarını da aydınlatır.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Başak burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Yardımseverlik\n💚 Güvenilirlik\n💚 Analitik zeka\n💚 Pratik çözümler\n💚 Detaylara dikkat\n💚 Alçakgönüllülük',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Hizmet etme ruhun en saf sevgi biçimi.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Terazi burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Diplomasi ve adalet duygusu\n💚 Estetik anlayış\n💚 Uyum sağlama\n💚 Romantizm\n💚 İş birliği yeteneği\n💚 Naziklik',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Barışçıl doğan dünyayı iyileştirir.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Akrep burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Derin sadakat\n💚 Tutku ve yoğunluk\n💚 Sezgisel güç\n💚 Dönüşüm kapasitesi\n💚 Koruyuculuk\n💚 Cesaret',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Yoğunluğun en derin bağları kurar.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Yay burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 İyimserlik\n💚 Macera ruhu\n💚 Dürüstlük\n💚 Felsefi derinlik\n💚 Cömertlik\n💚 Eğlenceli enerji',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. İyimserliğin başkalarına umut verir.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Oğlak burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Güvenilirlik\n💚 Sorumluluk\n💚 Azim ve kararlılık\n💚 Pratik zeka\n💚 Koruyuculuk\n💚 Uzun vadeli düşünme',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Kararlılığın dağları bile yerinden oynatır.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Kova burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Özgünlük\n💚 İnsancıllık\n💚 Yenilikçilik\n💚 Bağımsız düşünce\n💚 Arkadaşlık değeri\n💚 Vizyonerlik',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Benzersiz bakış açın dünyayı değiştirir.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, işte senin Green Flag\'lerin! Balık burcu olarak bu harika özelliklerinle gurur duy.',
        'details':
            '💚 Empati ve şefkat\n💚 Yaratıcılık\n💚 Sezgisel güç\n💚 Romantizm\n💚 Fedakarlık\n💚 Spiritüel derinlik',
        'advice':
            'Bu özelliklerin seni benzersiz kılıyor. Empatın dünyayı iyileştirir.',
      },
    };

    return greenFlags[sign] ?? {'mainMessage': 'İçerik yükleniyor...'};
  }

  static Map<String, String> _getLifePurposeContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final purposes = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, senin hayat amacın yeni yollar açmak ve cesaretle liderlik etmek. Koç burcu olarak öncü olmak için doğdun.',
        'details':
            'Hayat Misyonun: İnsanlara cesareti öğretmek, yeni başlangıçlar yapmak, korkuları yenmek için ilham vermek. Sen bir ateşleyicisin - durgun enerjileri harekete geçirirsin.',
        'advice':
            'Amacını yaşamak için: Korkularınla yüzleş, risk al, başkalarına cesaret ver. Liderlik pozisyonlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, senin hayat amacın güzellik yaratmak ve güvenli temeller kurmak. Boğa burcu olarak bolluk getirmek için doğdun.',
        'details':
            'Hayat Misyonun: Maddi ve manevi bolluk yaratmak, güzelliği dünyaya getirmek, güvenli alanlar inşa etmek. Sen bir inşacısın - kalıcı değerler yaratırsın.',
        'advice':
            'Amacını yaşamak için: Güzel şeyler yarat, değer üret, başkalarına güvenlik his ettir. Doğayla bağlantında kalarak en iyi halinle parla.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, senin hayat amacın bilgiyi yaymak ve bağlantılar kurmak. İkizler burcu olarak iletişim için doğdun.',
        'details':
            'Hayat Misyonun: Fikirleri paylaşmak, insanları birbirine bağlamak, merakı uyandırmak. Sen bir elçisin - bilgiyi taşır ve dönüştürürsün.',
        'advice':
            'Amacını yaşamak için: Öğren ve öğret, köprüler kur, fikirleri yay. İletişim alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, senin hayat amacın beslemek ve duygusal güvenlik sağlamak. Yengeç burcu olarak şefkat için doğdun.',
        'details':
            'Hayat Misyonun: Duygusal destek vermek, güvenli alanlar yaratmak, besleme ve iyileştirme. Sen bir bakıcısın - ruhları iyileştirirsin.',
        'advice':
            'Amacını yaşamak için: Şefkatini paylaş, yuva kur, başkalarını koru. Bakım veren rollerde en iyi halinle parla.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, senin hayat amacın parlamak ve başkalarına ilham vermek. Aslan burcu olarak yaratıcılık için doğdun.',
        'details':
            'Hayat Misyonun: Yaratıcı ifade, ilham verme, cömertlik ve neşe yayma. Sen bir güneşsin - etrafındakileri aydınlatırsın.',
        'advice':
            'Amacını yaşamak için: Yarat, ilham ver, cömert ol. Sahne önü ve yaratıcı alanlarda en iyi halinle parla.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, senin hayat amacın hizmet etmek ve mükemmelleştirmek. Başak burcu olarak iyileştirme için doğdun.',
        'details':
            'Hayat Misyonun: Pratik yollarla yardım etmek, sistemleri iyileştirmek, şifa getirmek. Sen bir iyileştiricisin - her şeyi daha iyi hale getirirsin.',
        'advice':
            'Amacını yaşamak için: Hizmet et, düzeni kur, şifa sun. Sağlık ve organizasyon alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, senin hayat amacın denge ve güzellik yaratmak. Terazi burcu olarak uyum için doğdun.',
        'details':
            'Hayat Misyonun: Adalet sağlamak, güzellik yaratmak, barış getirmek. Sen bir arabulucusun - zıtlıkları dengelersin.',
        'advice':
            'Amacını yaşamak için: Köprüler kur, güzellik yarat, adalet sağla. Sanat ve diplomasi alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, senin hayat amacın dönüştürmek ve derinlere inmek. Akrep burcu olarak şifa için doğdun.',
        'details':
            'Hayat Misyonun: Dönüşümü kolaylaştırmak, gizli gerçekleri ortaya çıkarmak, derin şifa. Sen bir simyacısın - kurşunu altına çevirirsin.',
        'advice':
            'Amacını yaşamak için: Derinlere dal, dönüştür, şifa sun. Psikoloji ve araştırma alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, senin hayat amacın keşfetmek ve bilgelik paylaşmak. Yay burcu olarak öğretmek için doğdun.',
        'details':
            'Hayat Misyonun: Ufukları genişletmek, bilgelik aramak ve paylaşmak, özgürlük ruhunu yaymak. Sen bir öğretmensin - hayatın anlamını ararsın.',
        'advice':
            'Amacını yaşamak için: Keşfet, öğret, ilham ver. Eğitim ve seyahat alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, senin hayat amacın inşa etmek ve miras bırakmak. Oğlak burcu olarak başarmak için doğdun.',
        'details':
            'Hayat Misyonun: Kalıcı yapılar kurmak, sorumluluk almak, miras bırakmak. Sen bir mimarsın - nesillere kalacak eserler yaratırsın.',
        'advice':
            'Amacını yaşamak için: Hedefler koy, inşa et, miras bırak. İş ve yönetim alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, senin hayat amacın yenilik getirmek ve insanlığa hizmet etmek. Kova burcu olarak devrim için doğdun.',
        'details':
            'Hayat Misyonun: Yeni fikirler getirmek, sosyal değişim yaratmak, geleceği şekillendirmek. Sen bir vizyonersin - yarını bugün görürsün.',
        'advice':
            'Amacını yaşamak için: Yenile, birleştir, değiştir. Teknoloji ve sosyal alanlarında en iyi halinle parla.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, senin hayat amacın ruhani bağlantı kurmak ve şefkat yaymak. Balık burcu olarak iyileştirmek için doğdun.',
        'details':
            'Hayat Misyonun: Spiritüel bağlantı sağlamak, sanatla ifade etmek, koşulsuz sevgiyi yaymak. Sen bir mistiksin - görünmeyeni görürsün.',
        'advice':
            'Amacını yaşamak için: Bağlan, yarat, şifa sun. Sanat ve spiritüel alanlarda en iyi halinle parla.',
      },
    };

    return purposes[sign] ?? {'mainMessage': 'İçerik yükleniyor...'};
  }

  static Map<String, String> _getKarmaLessonsContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, ${sign.nameTr} burcu olarak karma derslerini öğrenme zamanı geldi. Güney Düğümü geçmiş yaşam alışkanlıklarını, Satürn ise bu hayattaki sınavlarını temsil eder. Bu hayatta üzerinde çalışman gereken temalar var.',
      'details':
          '🔄 Karma Döngün:\nKarma derslerin burç elementine ve yönetici gezegenine bağlı olarak belirlenir. ${sign.element.nameTr} elementi olarak ${_getKarmaByElement(sign.element)} öğrenmen gerekiyor.\n\n📚 Ruh Sözleşmendeki Dersler:\n• Satürn\'ün evindeki dersler: Sorumluluk ve olgunlaşma\n• Kiron\'un gösterdiği yaralar: Şifa potansiyeli\n• Kuzey Düğümü: Ruhsal evrim yönün\n\n⏳ Karma Takvimi:\nSatürn dönüşü (yaklaşık 29 yaş) ve Kiron dönüşü (yaklaşık 50 yaş) büyük karma hesaplaşma dönemleridir.',
      'advice':
          'Her karşılaştığın zorluk bir karma dersidir. Onu tanı, kabul et ve dönüştür. Transit haritanı takip ederek aktif karma dönemlerini önceden bilebilirsin.',
      'warning':
          'Dikkat: Aynı dersler tekrar tekrar önüne geliyorsa, henüz öğrenmediğin anlamına gelir. Kaçmak yerine yüzleş.',
    };
  }

  static String _getKarmaByElement(zodiac.Element element) {
    switch (element) {
      case zodiac.Element.fire:
        return 'sabır, alçakgönüllülük ve başkalarını düşünme';
      case zodiac.Element.earth:
        return 'bırakma, güvenme ve değişime açık olma';
      case zodiac.Element.air:
        return 'derinleşme, tutarlılık ve duygusal bağlanma';
      case zodiac.Element.water:
        return 'sınır koyma, gerçekçilik ve duygusal bağımsızlık';
    }
  }

  static Map<String, String> _getSoulContractContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, bu dünyaya gelmeden önce ruhun bir sözleşme yaptı. ${sign.nameTr} burcu olarak doğum haritandaki Kuzey Düğümü, Satürn ve 12. ev bu sözleşmenin izlerini taşıyor.',
      'details':
          '📜 Ruh Sözleşmenin Ana Maddeleri:\n\nRuh sözleşmen, yaşam amacını, karma derslerini ve bu hayatta karşılaşacağın temel deneyimleri içerir. ${sign.nameTr} olarak ${_getSoulContractTheme(sign)} üzerine çalışmak için geldin.\n\n🌟 Sözleşme Detayları:\n• Yaşam Amacı: Kuzey Düğümü\'nün gösterdiği yön\n• Geçmiş Yaşam Mirası: Güney Düğümü ve 12. ev\n• Şifa Görevi: Kiron\'un konumu\n• Olgunlaşma Alanları: Satürn\'ün evi\n\n🔗 Ruh Bağlantıları:\nHayatına giren önemli kişiler de ruh sözleşmenin parçası. Sinastri haritasındaki Ay Düğümleri bağlantıları, karmik ruh bağlarını gösterir.',
      'advice':
          'Ruh sözleşmeni hatırlamak için: Meditasyon yap, rüyalarına dikkat et, tekrarlayan temaları gözlemle. Doğum haritandaki 12. ev ve Neptün konumu, bilinçaltı hafızana erişim kapılarını gösterir.',
      'warning':
          'Ruh sözleşmesi değiştirilemez değildir. Özgür iradenle her an yeni seçimler yapabilirsin.',
    };
  }

  static String _getSoulContractTheme(zodiac.ZodiacSign sign) {
    final themes = {
      zodiac.ZodiacSign.aries: 'cesaret ve liderlik',
      zodiac.ZodiacSign.taurus: 'değer ve bolluk',
      zodiac.ZodiacSign.gemini: 'iletişim ve öğrenme',
      zodiac.ZodiacSign.cancer: 'şefkat ve aile',
      zodiac.ZodiacSign.leo: 'yaratıcılık ve kendini ifade',
      zodiac.ZodiacSign.virgo: 'hizmet ve iyileştirme',
      zodiac.ZodiacSign.libra: 'ilişkiler ve denge',
      zodiac.ZodiacSign.scorpio: 'dönüşüm ve güç',
      zodiac.ZodiacSign.sagittarius: 'özgürlük ve bilgelik',
      zodiac.ZodiacSign.capricorn: 'başarı ve miras',
      zodiac.ZodiacSign.aquarius: 'yenilik ve insanlık',
      zodiac.ZodiacSign.pisces: 'spiritüalite ve şifa',
    };
    return themes[sign] ?? 'evrensel denge';
  }

  static Map<String, String> _getInnerPowerContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, içindeki güç fark ettiğinden çok daha büyük. ${sign.nameTr} burcu olarak benzersiz süper güçlerin var.',
      'details':
          'Süper Güçlerin:\n⚡ ${_getSuperPower1(sign)}\n⚡ ${_getSuperPower2(sign)}\n⚡ ${_getSuperPower3(sign)}',
      'advice':
          'İçsel gücünü aktive etmek için: Güçlü yönlerine odaklan, onları bilinçli kullan, her gün pratik yap.',
    };
  }

  static String _getSuperPower1(zodiac.ZodiacSign sign) {
    final powers = {
      zodiac.ZodiacSign.aries: 'Cesaret Kalkanı - Hiçbir şeyden korkmama',
      zodiac.ZodiacSign.taurus: 'Bolluk Mıknatısı - Maddi bereket çekme',
      zodiac.ZodiacSign.gemini: 'Zihin Okuma - İletişimde üstünlük',
      zodiac.ZodiacSign.cancer: 'Empati Gücü - Duyguları hissetme',
      zodiac.ZodiacSign.leo: 'Karizmatik Aura - Doğal çekim gücü',
      zodiac.ZodiacSign.virgo: 'Detay Görüşü - Hiçbir şeyi kaçırmama',
      zodiac.ZodiacSign.libra: 'Uyum Yaratma - Her ortama uyum sağlama',
      zodiac.ZodiacSign.scorpio: 'Dönüşüm Gücü - Karanlıktan güç alma',
      zodiac.ZodiacSign.sagittarius: 'Şans Yıldızı - Doğal şanslı olma',
      zodiac.ZodiacSign.capricorn: 'Azim Duvarı - Asla pes etmeme',
      zodiac.ZodiacSign.aquarius: 'Vizyon Gözü - Geleceği görme',
      zodiac.ZodiacSign.pisces: 'Ruhsal Bağlantı - Evrenle iletişim',
    };
    return powers[sign] ?? 'Evrensel Güç';
  }

  static String _getSuperPower2(zodiac.ZodiacSign sign) {
    final powers = {
      zodiac.ZodiacSign.aries: 'Hız Patlaması - Ani aksiyon alma',
      zodiac.ZodiacSign.taurus: 'Sakinlik Kalesi - Strese dayanıklılık',
      zodiac.ZodiacSign.gemini: 'Adaptasyon - Her duruma uyum',
      zodiac.ZodiacSign.cancer: 'Şifa Enerjisi - Başkalarını iyileştirme',
      zodiac.ZodiacSign.leo: 'İlham Verme - Başkalarını motive etme',
      zodiac.ZodiacSign.virgo: 'Problem Çözme - Her soruna çözüm bulma',
      zodiac.ZodiacSign.libra: 'Diplomasi - Çatışmaları çözme',
      zodiac.ZodiacSign.scorpio: 'Sezgi Radarı - Yalan algılama',
      zodiac.ZodiacSign.sagittarius: 'Özgürlük Arayışı - Sınırları aşma',
      zodiac.ZodiacSign.capricorn: 'Stratejik Zeka - Uzun vadeli planlama',
      zodiac.ZodiacSign.aquarius: 'Yenilikçilik - Benzersiz fikirler üretme',
      zodiac.ZodiacSign.pisces: 'Yaratıcı Deha - Sanatsal yetenek',
    };
    return powers[sign] ?? 'Gizli Potansiyel';
  }

  static String _getSuperPower3(zodiac.ZodiacSign sign) {
    final powers = {
      zodiac.ZodiacSign.aries: 'Koruyucu İçgüdü - Sevdiklerini savunma',
      zodiac.ZodiacSign.taurus: 'Dokunuş Büyüsü - Duyusal şifa',
      zodiac.ZodiacSign.gemini: 'Bilgi Deposu - Her konuda bilgi',
      zodiac.ZodiacSign.cancer: 'Sezgisel Rehberlik - Doğru yolu hissetme',
      zodiac.ZodiacSign.leo: 'Cömertlik Kalbi - Sınırsız verme',
      zodiac.ZodiacSign.virgo: 'Mükemmelleştirme - Her şeyi iyileştirme',
      zodiac.ZodiacSign.libra: 'Estetik Göz - Güzelliği görme ve yaratma',
      zodiac.ZodiacSign.scorpio: 'Yeniden Doğuş - Her düşüşten güçlü kalkma',
      zodiac.ZodiacSign.sagittarius:
          'Bilgelik Arayışı - Hayatın anlamını bulma',
      zodiac.ZodiacSign.capricorn: 'Miras Yaratma - Kalıcı eserler bırakma',
      zodiac.ZodiacSign.aquarius: 'Topluluk Kurma - İnsanları birleştirme',
      zodiac.ZodiacSign.pisces: 'Rüya İzi - Bilinçaltı mesajları anlama',
    };
    return powers[sign] ?? 'Keşfedilmemiş Potansiyel';
  }

  static Map<String, String> _getFlirtStyleContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final styles = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, senin flört stilin cesur ve doğrudan! Koç burcu olarak ilk adımı atmaktan çekinmezsin.',
        'details':
            '💋 Flört Taktiğin: Doğrudan yaklaşım\n💋 Çekicilik Silahın: Cesaret ve enerji\n💋 Kırmızı Çizgin: Oyun oynamak\n💋 İlgini Çeken: Meydan okuma\n💋 Flört Motton: "Risk almadan kazanılmaz"',
        'advice':
            'Flörtte başarı için: Hızını biraz düşür, gizemini koru, ama cesaretinden vazgeçme.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, senin flört stilin duyusal ve sabırlı! Boğa burcu olarak romantizmi seversin.',
        'details':
            '💋 Flört Taktiğin: Yavaş ve duyusal yaklaşım\n💋 Çekicilik Silahın: Seksapel ve güvenilirlik\n💋 Kırmızı Çizgin: Acecilik\n💋 İlgini Çeken: Güzellik ve kalite\n💋 Flört Motton: "Sabır her şeyin anahtarı"',
        'advice':
            'Flörtte başarı için: Duyularını kullan, romantik ortamlar yarat, acele etme.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, senin flört stilin zeki ve eğlenceli! İkizler burcu olarak sohbetle baştan çıkarırsın.',
        'details':
            '💋 Flört Taktiğin: Zekice sohbet\n💋 Çekicilik Silahın: Espri ve zeka\n💋 Kırmızı Çizgin: Sıkıcılık\n💋 İlgini Çeken: Entelektüel uyarılma\n💋 Flört Motton: "Güldürebildiğin herkes senindir"',
        'advice':
            'Flörtte başarı için: Konuşmayı dengele, dinle de, biraz gizemli ol.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, senin flört stilin romantik ve duygusal! Yengeç burcu olarak kalbinle baştan çıkarırsın.',
        'details':
            '💋 Flört Taktiğin: Duygusal bağ kurma\n💋 Çekicilik Silahın: Şefkat ve ilgi\n💋 Kırmızı Çizgin: Duygusuzluk\n💋 İlgini Çeken: Güvenlik hissi\n💋 Flört Motton: "Kalbe giden yol şefkatten geçer"',
        'advice':
            'Flörtte başarı için: Sınırlarını koru, çok çabuk bağlanma, biraz gizem bırak.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, senin flört stilin gösterişli ve çekici! Aslan burcu olarak sahneyi kaplarsın.',
        'details':
            '💋 Flört Taktiğin: Dikkat çekme\n💋 Çekicilik Silahın: Karizma ve özgüven\n💋 Kırmızı Çizgin: Görmezden gelinmek\n💋 İlgini Çeken: Takdir ve hayranlık\n💋 Flört Motton: "Parla ki seni bulsunlar"',
        'advice':
            'Flörtte başarı için: Partnerine de parlaması için alan ver, alçakgönüllülük ekle.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, senin flört stilin ince ve düşünceli! Başak burcu olarak detaylarla etkilersin.',
        'details':
            '💋 Flört Taktiğin: Yardımseverlik ve dikkat\n💋 Çekicilik Silahın: Zeka ve zarafet\n💋 Kırmızı Çizgin: Kabalık\n💋 İlgini Çeken: Temizlik ve düzen\n💋 Flört Motton: "Şeytan detaylarda gizli"',
        'advice':
            'Flörtte başarı için: Mükemmeliyetçiliği bırak, spontan ol, kendini biraz daha göster.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, senin flört stilin zarif ve romantik! Terazi burcu olarak doğal bir çekicisin.',
        'details':
            '💋 Flört Taktiğin: Çekicilik ve uyum\n💋 Çekicilik Silahın: Güzellik ve diplomasi\n💋 Kırmızı Çizgin: Kabalık ve kavga\n💋 İlgini Çeken: Estetik ve uyum\n💋 Flört Motton: "Güzellik her kapıyı açar"',
        'advice':
            'Flörtte başarı için: Kendi sesini bul, her şeye evet deme, kararsızlığı aş.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, senin flört stilin yoğun ve manyetik! Akrep burcu olarak hipnotize edersin.',
        'details':
            '💋 Flört Taktiğin: Derin bakış ve gizem\n💋 Çekicilik Silahın: Yoğunluk ve tutku\n💋 Kırmızı Çizgin: Yüzeysellik\n💋 İlgini Çeken: Derinlik ve sadakat\n💋 Flört Motton: "Gözlerinle baştan çıkar"',
        'advice':
            'Flörtte başarı için: Yoğunluğunu dozla, biraz hafiflik kat, güven inşa et.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, senin flört stilin maceraperest ve eğlenceli! Yay burcu olarak özgürlükle baştan çıkarırsın.',
        'details':
            '💋 Flört Taktiğin: Macera ve eğlence\n💋 Çekicilik Silahın: İyimserlik ve spontanlık\n💋 Kırmızı Çizgin: Sıkıcılık ve kısıtlama\n💋 İlgini Çeken: Özgür ruhlar\n💋 Flört Motton: "Hayat bir macera, gel birlikte keşfedelim"',
        'advice':
            'Flörtte başarı için: Biraz daha bağlan, sözlerini tut, macera dışında da var ol.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, senin flört stilin ciddi ve kararlı! Oğlak burcu olarak güvenilirlikle etkilersin.',
        'details':
            '💋 Flört Taktiğin: Ciddi niyetler\n💋 Çekicilik Silahın: Başarı ve kararlılık\n💋 Kırmızı Çizgin: Sorumsuzluk\n💋 İlgini Çeken: Hırs ve hedef\n💋 Flört Motton: "Ciddi niyetler ciddi ilişkiler getirir"',
        'advice':
            'Flörtte başarı için: Biraz gevşe, eğlenceye yer aç, duygularını göster.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, senin flört stilin farklı ve beklenmedik! Kova burcu olarak benzersizliğinle çekersin.',
        'details':
            '💋 Flört Taktiğin: Arkadaşlık temelli\n💋 Çekicilik Silahın: Orijinallik ve zeka\n💋 Kırmızı Çizgin: Sıradanlık\n💋 İlgini Çeken: Benzersiz ruhlar\n💋 Flört Motton: "Normal olmak sıkıcı"',
        'advice':
            'Flörtte başarı için: Duygusal mesafeyi azalt, bağlanmaktan korkma.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, senin flört stilin romantik ve hayalperest! Balık burcu olarak rüyalarla baştan çıkarırsın.',
        'details':
            '💋 Flört Taktiğin: Romantizm ve hayal\n💋 Çekicilik Silahın: Empati ve hassasiyet\n💋 Kırmızı Çizgin: Kabalık ve duygusuzluk\n💋 İlgini Çeken: Romantik ve sanatsal ruhlar\n💋 Flört Motton: "Aşk bir rüya, gel birlikte görelim"',
        'advice':
            'Flörtte başarı için: Ayaklarını yere bas, sınırlarını koru, gerçekçi ol.',
      },
    };

    return styles[sign] ?? {'mainMessage': 'İçerik yükleniyor...'};
  }

  static Map<String, String> _getLeadershipStyleContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, ${sign.nameTr} burcu olarak senin liderlik stilin benzersiz ve güçlü.',
      'details':
          'Liderlik Tarzın: ${_getLeadershipType(sign)}\n\nGüçlü Yönlerin: ${_getLeadershipStrength(sign)}\n\nGeliştirmen Gereken: ${_getLeadershipWeakness(sign)}',
      'advice':
          'Liderlik kapasiteni artırmak için: ${_getLeadershipAdvice(sign)}',
    };
  }

  static String _getLeadershipType(zodiac.ZodiacSign sign) {
    final types = {
      zodiac.ZodiacSign.aries: 'Öncü Lider - İlk adımı atan, cesur ve korkusuz',
      zodiac.ZodiacSign.taurus:
          'İstikrarlı Lider - Güvenilir, sabırlı ve kararlı',
      zodiac.ZodiacSign.gemini:
          'İletişimci Lider - Bilgiyi yayan, bağlantı kuran',
      zodiac.ZodiacSign.cancer: 'Koruyucu Lider - Besleyen, koruyan, aile gibi',
      zodiac.ZodiacSign.leo:
          'Karizmatik Lider - İlham veren, motive eden, parlayan',
      zodiac.ZodiacSign.virgo:
          'Analitik Lider - Detaycı, verimli, mükemmeliyetçi',
      zodiac.ZodiacSign.libra: 'Diplomatik Lider - Adil, dengeli, birleştirici',
      zodiac.ZodiacSign.scorpio:
          'Stratejik Lider - Güçlü, kararlı, dönüştürücü',
      zodiac.ZodiacSign.sagittarius:
          'Vizyoner Lider - İlham veren, özgürlükçü, felsefeci',
      zodiac.ZodiacSign.capricorn:
          'Otoriter Lider - Disiplinli, hedef odaklı, başarılı',
      zodiac.ZodiacSign.aquarius:
          'Yenilikçi Lider - Farklı düşünen, devrimci, insancıl',
      zodiac.ZodiacSign.pisces:
          'Sezgisel Lider - Empatik, yaratıcı, ilham veren',
    };
    return types[sign] ?? 'Benzersiz Lider';
  }

  static String _getLeadershipStrength(zodiac.ZodiacSign sign) {
    final strengths = {
      zodiac.ZodiacSign.aries: 'Cesaret, hız, inisiyatif alma',
      zodiac.ZodiacSign.taurus: 'Sabır, güvenilirlik, kararlılık',
      zodiac.ZodiacSign.gemini: 'İletişim, esneklik, çok yönlülük',
      zodiac.ZodiacSign.cancer: 'Empati, koruyuculuk, sadakat',
      zodiac.ZodiacSign.leo: 'Karizma, motivasyon, cömertlik',
      zodiac.ZodiacSign.virgo: 'Organizasyon, verimlilik, detay odaklılık',
      zodiac.ZodiacSign.libra: 'Diplomasi, adalet, uyum sağlama',
      zodiac.ZodiacSign.scorpio: 'Strateji, kararlılık, dönüşüm gücü',
      zodiac.ZodiacSign.sagittarius: 'Vizyon, iyimserlik, ilham verme',
      zodiac.ZodiacSign.capricorn: 'Disiplin, hedef odaklılık, azim',
      zodiac.ZodiacSign.aquarius: 'Yenilikçilik, bağımsız düşünce, insancıllık',
      zodiac.ZodiacSign.pisces: 'Sezgi, yaratıcılık, şefkat',
    };
    return strengths[sign] ?? 'Benzersiz güçler';
  }

  static String _getLeadershipWeakness(zodiac.ZodiacSign sign) {
    final weaknesses = {
      zodiac.ZodiacSign.aries: 'Sabırsızlık, başkalarını dinlememe',
      zodiac.ZodiacSign.taurus: 'İnatçılık, değişime direnç',
      zodiac.ZodiacSign.gemini: 'Tutarsızlık, dikkat dağınıklığı',
      zodiac.ZodiacSign.cancer: 'Aşırı duygusallık, taraflılık',
      zodiac.ZodiacSign.leo: 'Ego, eleştiriye kapalılık',
      zodiac.ZodiacSign.virgo: 'Aşırı eleştiri, mükemmeliyetçilik',
      zodiac.ZodiacSign.libra: 'Kararsızlık, çatışmadan kaçınma',
      zodiac.ZodiacSign.scorpio: 'Güvensizlik, kontrol ihtiyacı',
      zodiac.ZodiacSign.sagittarius: 'Taahhüt eksikliği, düşüncesizlik',
      zodiac.ZodiacSign.capricorn: 'Katılık, duygusal mesafe',
      zodiac.ZodiacSign.aquarius: 'Duygusal kopukluk, inatçılık',
      zodiac.ZodiacSign.pisces: 'Gerçekçilik eksikliği, sınır koyamama',
    };
    return weaknesses[sign] ?? 'Gelişim alanları';
  }

  static String _getLeadershipAdvice(zodiac.ZodiacSign sign) {
    final advice = {
      zodiac.ZodiacSign.aries: 'Başkalarını dinlemeyi öğren, takımı dahil et',
      zodiac.ZodiacSign.taurus: 'Değişime açık ol, esnekliği dene',
      zodiac.ZodiacSign.gemini: 'Bir konuya odaklan, tutarlı ol',
      zodiac.ZodiacSign.cancer:
          'Objektif olmayı öğren, profesyonel sınırlar koy',
      zodiac.ZodiacSign.leo: 'Başkalarına sahne ver, eleştiriyi dinle',
      zodiac.ZodiacSign.virgo: 'Büyük resmi gör, mükemmeliyetçiliği bırak',
      zodiac.ZodiacSign.libra: 'Karar ver ve arkasında dur, çatışmadan korkma',
      zodiac.ZodiacSign.scorpio: 'Güvenmeyi öğren, kontrolü bırak',
      zodiac.ZodiacSign.sagittarius: 'Detaylara dikkat et, taahhütlerini tut',
      zodiac.ZodiacSign.capricorn: 'İnsan ilişkilerine yatırım yap, esne',
      zodiac.ZodiacSign.aquarius: 'Duygusal bağlantı kur, takımı dinle',
      zodiac.ZodiacSign.pisces: 'Pratik ol, net sınırlar koy',
    };
    return advice[sign] ?? 'Kendini geliştirmeye devam et';
  }

  static Map<String, String> _getHeartbreakContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, ${sign.nameTr} burcu olarak senin kalp kırıklığı deneyimin benzersiz. İşte kalp yaraların ve onları iyileştirme yolun.',
      'details':
          'Kalp Kıran Şey: ${_getHeartbreakTrigger(sign)}\n\nKalp Kırıklığında Tepkin: ${_getHeartbreakReaction(sign)}\n\nİyileşme Sürecin: ${_getHealingProcess(sign)}',
      'advice': 'Kalp kırıklığından çıkmak için: ${_getHeartbreakAdvice(sign)}',
      'warning':
          'Dikkat: Yaralarını görmezden gelmek onları büyütür. Acını hisset, ama orada kalma.',
    };
  }

  static String _getHeartbreakTrigger(zodiac.ZodiacSign sign) {
    final triggers = {
      zodiac.ZodiacSign.aries: 'Reddedilmek, ikinci plana atılmak',
      zodiac.ZodiacSign.taurus: 'İhanet, güvenin kırılması',
      zodiac.ZodiacSign.gemini: 'Sıkıcı olmak, entelektüel bağın kopması',
      zodiac.ZodiacSign.cancer: 'Duygusal ihmal, güvensizlik hissi',
      zodiac.ZodiacSign.leo: 'Takdir edilmemek, görmezden gelinmek',
      zodiac.ZodiacSign.virgo: 'Kusurlarının vurgulanması, eleştirilmek',
      zodiac.ZodiacSign.libra: 'Adaletsizlik, çirkin ayrılıklar',
      zodiac.ZodiacSign.scorpio: 'İhanet, yalan söylenmesi',
      zodiac.ZodiacSign.sagittarius: 'Kısıtlanmak, özgürlüğün elinden alınması',
      zodiac.ZodiacSign.capricorn: 'Başarısızlık hissi, saygısızlık',
      zodiac.ZodiacSign.aquarius: 'Anlaşılmamak, sıradanlaştırılmak',
      zodiac.ZodiacSign.pisces: 'Rüyaların yıkılması, duygusal soğukluk',
    };
    return triggers[sign] ?? 'Derin duygusal yaralar';
  }

  static String _getHeartbreakReaction(zodiac.ZodiacSign sign) {
    final reactions = {
      zodiac.ZodiacSign.aries: 'Öfke patlaması, hemen yeni birine yönelme',
      zodiac.ZodiacSign.taurus: 'Kapanma, inatla tutunma veya tamamen kesme',
      zodiac.ZodiacSign.gemini: 'Meşgul olma, duygulardan kaçınma, konuşma',
      zodiac.ZodiacSign.cancer: 'Kabuğuna çekilme, geçmişe takılma',
      zodiac.ZodiacSign.leo: 'Ego yarası, kanıtlama çabası',
      zodiac.ZodiacSign.virgo: 'Kendini suçlama, analiz etme',
      zodiac.ZodiacSign.libra:
          'Herkese danışma, kararsızlık, yalnızlık korkusu',
      zodiac.ZodiacSign.scorpio: 'Derin acı, intikam düşünceleri',
      zodiac.ZodiacSign.sagittarius: 'Kaçış, seyahat, yeni maceralar',
      zodiac.ZodiacSign.capricorn: 'İşe gömülme, duygularını bastırma',
      zodiac.ZodiacSign.aquarius: 'Duygusal mesafe, rasyonalize etme',
      zodiac.ZodiacSign.pisces: 'Depresyon, kaçış, fantezilere sığınma',
    };
    return reactions[sign] ?? 'Duygusal tepkiler';
  }

  static String _getHealingProcess(zodiac.ZodiacSign sign) {
    final healing = {
      zodiac.ZodiacSign.aries: 'Fiziksel aktivite, yeni projeler',
      zodiac.ZodiacSign.taurus: 'Zaman, konfor, doğa',
      zodiac.ZodiacSign.gemini: 'Sosyalleşme, yeni deneyimler',
      zodiac.ZodiacSign.cancer: 'Aile ve yakın arkadaşlar, yuva konforu',
      zodiac.ZodiacSign.leo: 'Yaratıcılık, takdir edilme',
      zodiac.ZodiacSign.virgo: 'Düzen kurma, kendine bakım',
      zodiac.ZodiacSign.libra: 'Güzellik, sanat, yeni bağlantılar',
      zodiac.ZodiacSign.scorpio: 'Derin dönüşüm, terapi',
      zodiac.ZodiacSign.sagittarius: 'Seyahat, yeni felsefeler, özgürlük',
      zodiac.ZodiacSign.capricorn: 'Başarı, hedefler, zaman',
      zodiac.ZodiacSign.aquarius: 'Dostlar, sosyal aktivizm, bağımsızlık',
      zodiac.ZodiacSign.pisces: 'Sanat, müzik, spiritüel pratikler',
    };
    return healing[sign] ?? 'Zaman ve şefkat';
  }

  static String _getHeartbreakAdvice(zodiac.ZodiacSign sign) {
    final advice = {
      zodiac.ZodiacSign.aries:
          'Öfkeni spor ile at, ama yeni ilişkiye aceleyle atılma',
      zodiac.ZodiacSign.taurus: 'Kendine zaman ver, konfor bul ama kapanma',
      zodiac.ZodiacSign.gemini: 'Konuş ama duyguları da hisset, kaçma',
      zodiac.ZodiacSign.cancer: 'Destek al ama geçmişte takılma',
      zodiac.ZodiacSign.leo: 'Kendini sev, başkalarından onay bekleme',
      zodiac.ZodiacSign.virgo:
          'Kendini suçlamayı bırak, mükemmel olman gerekmiyor',
      zodiac.ZodiacSign.libra: 'Yalnızlıkla barış, kendi başına olmayı öğren',
      zodiac.ZodiacSign.scorpio: 'İntikamı bırak, affetmeyi öğren',
      zodiac.ZodiacSign.sagittarius: 'Kaçmak yerine yüzleş, acıyı hisset',
      zodiac.ZodiacSign.capricorn: 'Duygularına izin ver, her şey iş değil',
      zodiac.ZodiacSign.aquarius:
          'Duygularını inkâr etme, bağlanmak zayıflık değil',
      zodiac.ZodiacSign.pisces:
          'Gerçekçi ol, fantezilere kaçma, sınırlarını koru',
    };
    return advice[sign] ?? 'Kendine şefkat göster ve zaman ver';
  }

  static Map<String, String> _getSoulMateContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, ${sign.nameTr} burcu olarak ruh eşin hakkında merak ettiğin her şey burada.',
      'details':
          'Ruh Eşin Nasıl Biri?\n${_getSoulMateDescription(sign)}\n\nEn Uyumlu Burçlar: ${_getSoulMateCompatible(sign)}\n\nNerede Karşılaşabilirsin: ${_getSoulMateMeetingPlace(sign)}',
      'advice': 'Ruh eşini çekmek için: ${_getSoulMateAdvice(sign)}',
    };
  }

  static String _getSoulMateDescription(zodiac.ZodiacSign sign) {
    final descriptions = {
      zodiac.ZodiacSign.aries:
          'Enerjik, cesur, meydan okumayı seven biri. Seninle yarışacak ama aynı zamanda destekleyecek.',
      zodiac.ZodiacSign.taurus:
          'Güvenilir, sadık, güzelliği seven biri. Seninle konforlu bir yuva kuracak.',
      zodiac.ZodiacSign.gemini:
          'Zeki, konuşkan, meraklı biri. Seninle hiç sıkılmayacak ve entelektüel olarak eşleşecek.',
      zodiac.ZodiacSign.cancer:
          'Şefkatli, koruyucu, aile odaklı biri. Seninle duygusal derinlik paylaşacak.',
      zodiac.ZodiacSign.leo:
          'Kendine güvenen, cömert, seni takdir eden biri. Seninle sahneyi paylaşacak.',
      zodiac.ZodiacSign.virgo:
          'Zeki, düzenli, yardımsever biri. Seninle mükemmel bir ortaklık kuracak.',
      zodiac.ZodiacSign.libra:
          'Zarif, romantik, adil biri. Seninle uyumlu ve güzel bir ilişki yaşayacak.',
      zodiac.ZodiacSign.scorpio:
          'Derin, tutkulu, sadık biri. Seninle yoğun ve dönüştürücü bir bağ kuracak.',
      zodiac.ZodiacSign.sagittarius:
          'Maceraperest, özgür ruhlu, felsefi biri. Seninle dünyayı keşfedecek.',
      zodiac.ZodiacSign.capricorn:
          'Hırslı, güvenilir, hedef odaklı biri. Seninle başarıya birlikte yürüyecek.',
      zodiac.ZodiacSign.aquarius:
          'Benzersiz, bağımsız, vizyoner biri. Seninle dünyayı değiştirecek.',
      zodiac.ZodiacSign.pisces:
          'Romantik, sezgisel, sanatsal biri. Seninle ruhsal bir bağ kuracak.',
    };
    return descriptions[sign] ?? 'Seni tamamlayacak özel biri';
  }

  static String _getSoulMateCompatible(zodiac.ZodiacSign sign) {
    final compatible = {
      zodiac.ZodiacSign.aries: 'Aslan, Yay, İkizler, Terazi',
      zodiac.ZodiacSign.taurus: 'Başak, Oğlak, Yengeç, Balık',
      zodiac.ZodiacSign.gemini: 'Terazi, Kova, Koç, Aslan',
      zodiac.ZodiacSign.cancer: 'Akrep, Balık, Boğa, Başak',
      zodiac.ZodiacSign.leo: 'Yay, Koç, İkizler, Terazi',
      zodiac.ZodiacSign.virgo: 'Oğlak, Boğa, Yengeç, Akrep',
      zodiac.ZodiacSign.libra: 'Kova, İkizler, Aslan, Yay',
      zodiac.ZodiacSign.scorpio: 'Balık, Yengeç, Başak, Oğlak',
      zodiac.ZodiacSign.sagittarius: 'Koç, Aslan, Terazi, Kova',
      zodiac.ZodiacSign.capricorn: 'Boğa, Başak, Akrep, Balık',
      zodiac.ZodiacSign.aquarius: 'İkizler, Terazi, Yay, Koç',
      zodiac.ZodiacSign.pisces: 'Yengeç, Akrep, Boğa, Oğlak',
    };
    return compatible[sign] ?? 'Tüm burçlarla potansiyel var';
  }

  static String _getSoulMateMeetingPlace(zodiac.ZodiacSign sign) {
    final places = {
      zodiac.ZodiacSign.aries:
          'Spor salonları, outdoor aktiviteler, rekabetçi etkinlikler',
      zodiac.ZodiacSign.taurus:
          'Sanat galerileri, güzel restoranlar, doğa yürüyüşleri',
      zodiac.ZodiacSign.gemini:
          'Kitap kulüpleri, sosyal etkinlikler, konferanslar',
      zodiac.ZodiacSign.cancer:
          'Aile toplantıları, ev partileri, yardım etkinlikleri',
      zodiac.ZodiacSign.leo: 'Tiyatrolar, partiler, yaratıcı etkinlikler',
      zodiac.ZodiacSign.virgo:
          'Yoga stüdyoları, sağlık merkezleri, iş ortamları',
      zodiac.ZodiacSign.libra: 'Sanat etkinlikleri, düğünler, sosyal kulüpler',
      zodiac.ZodiacSign.scorpio:
          'Gece hayatı, gizem etkinlikleri, psikoloji seminerleri',
      zodiac.ZodiacSign.sagittarius:
          'Seyahat, felsefe dersleri, açık hava festivalleri',
      zodiac.ZodiacSign.capricorn:
          'İş networking etkinlikleri, profesyonel toplantılar',
      zodiac.ZodiacSign.aquarius:
          'Teknoloji etkinlikleri, sosyal aktivizm, farklı topluluklar',
      zodiac.ZodiacSign.pisces:
          'Sanat galerileri, meditasyon merkezleri, müzik etkinlikleri',
    };
    return places[sign] ?? 'Beklenmedik yerlerde';
  }

  static String _getSoulMateAdvice(zodiac.ZodiacSign sign) {
    final advice = {
      zodiac.ZodiacSign.aries: 'Sabırlı ol, her şey hemen olmak zorunda değil',
      zodiac.ZodiacSign.taurus: 'Değişime açık ol, konfor alanından çık',
      zodiac.ZodiacSign.gemini: 'Bir ilişkiye odaklan, derinleş',
      zodiac.ZodiacSign.cancer: 'Kabuğundan çık, sosyalleş',
      zodiac.ZodiacSign.leo: 'Başkalarına da parlamaları için alan ver',
      zodiac.ZodiacSign.virgo: 'Mükemmeliyetçiliği bırak, kusurları kabul et',
      zodiac.ZodiacSign.libra: 'Kendi değerini bil, onay arama',
      zodiac.ZodiacSign.scorpio: 'Güvenmeyi öğren, kontrolü bırak',
      zodiac.ZodiacSign.sagittarius:
          'Bağlanmaktan korkma, özgürlük ilişkide de var',
      zodiac.ZodiacSign.capricorn: 'İşe değil, ilişkiye de zaman ayır',
      zodiac.ZodiacSign.aquarius: 'Duygusal bağ kur, mesafeyi azalt',
      zodiac.ZodiacSign.pisces: 'Gerçekçi ol, fanteziden çık',
    };
    return advice[sign] ?? 'Kendini sev, doğru kişi gelecek';
  }

  static Map<String, String> _getSpiritualTransformationContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, ${sign.nameTr} burcu olarak ruhsal dönüşüm yolculuğun Pluto\'nun derin enerjisiyle başlıyor. Her burç, gölge benliğiyle yüzleşerek aydınlanmaya doğru ilerler. Senin dönüşüm yolculuğun ${sign.element.nameTr} elementinin bilgeliğiyle şekilleniyor.',
      'details':
          '🦋 Dönüşüm Teması: ${_getTransformationTheme(sign)}\n\n🌑 Bırakman Gereken Gölge Yönlerin: ${_getWhatToRelease(sign)}\n\n✨ Kabul Etmen Gereken Işık Yönlerin: ${_getWhatToAccept(sign)}\n\n🔮 Ruhsal Evrim Yolun: ${sign.nameTr} burcunun Kuzey Düğümü yönü, senin karma derslerini ve yaşam amacını işaret ediyor. Bu dönüşüm, iç çocuğunun şifasıyla başlar ve bireyselleşme süreciyle tamamlanır.',
      'advice':
          'Dönüşümü kolaylaştırmak için: ${_getTransformationAdvice(sign)} Meditasyon, çakra dengeleme ve bilinçaltı kalıplarını fark etme bu süreçte en güçlü araçların olacak.',
      'warning':
          'Dikkat: Ruhsal dönüşüm lineer değildir. Bazen geri adım atmak, ilerlemek için gereklidir. Kendine şefkat göster.',
    };
  }

  static String _getTransformationTheme(zodiac.ZodiacSign sign) {
    final themes = {
      zodiac.ZodiacSign.aries: 'Öfkeden bilgeliğe, savaşçıdan barışçıya',
      zodiac.ZodiacSign.taurus: 'Sahiplenmeden bırakmaya, korkudan güvene',
      zodiac.ZodiacSign.gemini:
          'Yüzeysellikten derinliğe, dağınıklıktan odaklanmaya',
      zodiac.ZodiacSign.cancer:
          'Geçmişten şimdiye, korumacılıktan özgürleştirmeye',
      zodiac.ZodiacSign.leo: 'Egodan alçakgönüllülüğe, almaktan vermeye',
      zodiac.ZodiacSign.virgo:
          'Eleştiriden kabullenmeye, mükemmeliyetten bütünlüğe',
      zodiac.ZodiacSign.libra:
          'Bağımlılıktan bağımsızlığa, kaçıştan yüzleşmeye',
      zodiac.ZodiacSign.scorpio: 'Kontrolden teslimiyete, yıkımdan yaratıma',
      zodiac.ZodiacSign.sagittarius: 'Kaçıştan kalışa, arayıştan buluşa',
      zodiac.ZodiacSign.capricorn: 'Başarıdan anlama, katılıktan esnekliğe',
      zodiac.ZodiacSign.aquarius:
          'Yabancılaşmadan bağlanmaya, mesafeden yakınlığa',
      zodiac.ZodiacSign.pisces: 'Fanteziden gerçeğe, kayboluştan bulunuşa',
    };
    return themes[sign] ?? 'Eski benden yeni bene';
  }

  static String _getWhatToRelease(zodiac.ZodiacSign sign) {
    final releases = {
      zodiac.ZodiacSign.aries: 'Sabırsızlık, öfke, kontrolsüz dürtüler',
      zodiac.ZodiacSign.taurus: 'İnatçılık, maddi bağımlılık, değişim korkusu',
      zodiac.ZodiacSign.gemini: 'Tutarsızlık, yüzeysellik, kaçış mekanizmaları',
      zodiac.ZodiacSign.cancer:
          'Geçmiş yaralar, aşırı hassasiyet, koruma duvarları',
      zodiac.ZodiacSign.leo: 'Ego, onay bağımlılığı, drama',
      zodiac.ZodiacSign.virgo: 'Mükemmeliyetçilik, aşırı eleştiri, kaygı',
      zodiac.ZodiacSign.libra:
          'Kararsızlık, başkalarını memnun etme, kendi sesini kaybetme',
      zodiac.ZodiacSign.scorpio: 'İntikam, kıskançlık, kontrol ihtiyacı',
      zodiac.ZodiacSign.sagittarius: 'Taahhüt korkusu, sorumsuzluk, kaçış',
      zodiac.ZodiacSign.capricorn:
          'Workaholism, duygusal baskılama, statü takıntısı',
      zodiac.ZodiacSign.aquarius:
          'Duygusal mesafe, üstünlük kompleksi, bağlanma korkusu',
      zodiac.ZodiacSign.pisces: 'Kurban zihniyeti, kaçış, sınırsızlık',
    };
    return releases[sign] ?? 'Eski kalıplar ve korkular';
  }

  static String _getWhatToAccept(zodiac.ZodiacSign sign) {
    final accepts = {
      zodiac.ZodiacSign.aries: 'Sabır, iş birliği, kırılganlık',
      zodiac.ZodiacSign.taurus: 'Değişim, belirsizlik, bırakma',
      zodiac.ZodiacSign.gemini: 'Derinlik, tutarlılık, duygusal bağlanma',
      zodiac.ZodiacSign.cancer: 'Şimdiki an, sağlıklı mesafe, bağımsızlık',
      zodiac.ZodiacSign.leo: 'Alçakgönüllülük, paylaşma, içsel değer',
      zodiac.ZodiacSign.virgo: 'Kusur, "yeterince iyi", spontanlık',
      zodiac.ZodiacSign.libra: 'Çatışma, kendi sesi, yalnızlık',
      zodiac.ZodiacSign.scorpio: 'Güven, affetme, kontrol kaybı',
      zodiac.ZodiacSign.sagittarius: 'Bağlılık, sorumluluk, yerleşiklik',
      zodiac.ZodiacSign.capricorn: 'Duygular, ilişkiler, esneklik',
      zodiac.ZodiacSign.aquarius: 'Yakınlık, duygusal bağ, sıradanlık',
      zodiac.ZodiacSign.pisces: 'Gerçeklik, sınırlar, sorumluluk',
    };
    return accepts[sign] ?? 'Yeni bilgelik ve farkındalık';
  }

  static String _getTransformationAdvice(zodiac.ZodiacSign sign) {
    final advice = {
      zodiac.ZodiacSign.aries: 'Meditasyon, nefes çalışması, sabır pratiği',
      zodiac.ZodiacSign.taurus:
          'Değişim ritüelleri, bırakma törenleri, güven çalışması',
      zodiac.ZodiacSign.gemini:
          'Odaklanma meditasyonu, journaling, derin sohbetler',
      zodiac.ZodiacSign.cancer:
          'İç çocuk çalışması, geçmiş bırakma, şimdiki an farkındalığı',
      zodiac.ZodiacSign.leo: 'Gölge çalışması, hizmet, içsel değer keşfi',
      zodiac.ZodiacSign.virgo:
          'Kendine şefkat, kusuru kutlama, spontan deneyimler',
      zodiac.ZodiacSign.libra:
          'Solo aktiviteler, kendi sesini bulma, sağlıklı çatışma',
      zodiac.ZodiacSign.scorpio:
          'Affetme pratiği, güven inşası, kontrol bırakma',
      zodiac.ZodiacSign.sagittarius:
          'Yerleşiklik pratiği, taahhüt deneyimleri, derinleşme',
      zodiac.ZodiacSign.capricorn: 'Duygu farkındalığı, ilişki yatırımı, oyun',
      zodiac.ZodiacSign.aquarius: 'Yakınlık pratiği, duygusal ifade, bağlanma',
      zodiac.ZodiacSign.pisces: 'Topraklama, sınır koyma, gerçeklik kontrolü',
    };
    return advice[sign] ?? 'Meditasyon, farkındalık ve içsel çalışma';
  }

  static Map<String, String> _getSubconsciousPatternsContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, bilinçaltındaki kalıplar hayatını şekillendiriyor. ${sign.nameTr} burcu olarak bunları keşfetme zamanı.',
      'details':
          'Bilinçaltı Kalıpların:\n\n🧠 ${_getPattern1(sign)}\n🧠 ${_getPattern2(sign)}\n🧠 ${_getPattern3(sign)}',
      'advice':
          'Bu kalıpları dönüştürmek için: Farkındalık, gözlem ve bilinçli seçimler. Kalıpları fark ettiğinde, onları değiştirme gücün artar.',
      'warning':
          'Dikkat: Kalıplar görünmez olduğunda güçlüdür. Onları görmek, dönüşümün ilk adımıdır.',
    };
  }

  static String _getPattern1(zodiac.ZodiacSign sign) {
    final patterns = {
      zodiac.ZodiacSign.aries:
          '"Ben her zaman mücadele etmeliyim" - Hayatı sürekli savaş olarak görme',
      zodiac.ZodiacSign.taurus:
          '"Değişim tehlikelidir" - Güvenlik için her şeyi aynı tutma ihtiyacı',
      zodiac.ZodiacSign.gemini:
          '"Eğer durursam sıkılırım" - Sürekli meşgul olma zorunluluğu',
      zodiac.ZodiacSign.cancer:
          '"Sevdiklerimi korumam lazım" - Aşırı koruyuculuk ve kontrol',
      zodiac.ZodiacSign.leo:
          '"Görünmez olursam değersizim" - Sürekli onay arayışı',
      zodiac.ZodiacSign.virgo:
          '"Her şey mükemmel olmalı" - Kusur kabullenememe',
      zodiac.ZodiacSign.libra:
          '"Herkes mutlu olmalı" - Kendi ihtiyaçlarını görmezden gelme',
      zodiac.ZodiacSign.scorpio:
          '"İnsanlara güvenilmez" - Sürekli tetikte olma',
      zodiac.ZodiacSign.sagittarius:
          '"Bağlanırsam hapsolurrum" - Özgürlük takıntısı',
      zodiac.ZodiacSign.capricorn:
          '"Başarısız olursam değersizim" - Performans bağımlılığı',
      zodiac.ZodiacSign.aquarius:
          '"Farklı olmak zorundayım" - Ait olamama inancı',
      zodiac.ZodiacSign.pisces:
          '"Gerçeklik çok acı verici" - Kaçış mekanizmaları',
    };
    return patterns[sign] ?? 'Bilinçaltı kalıp';
  }

  static String _getPattern2(zodiac.ZodiacSign sign) {
    final patterns = {
      zodiac.ZodiacSign.aries:
          '"Ben her zaman güçlü olmalıyım" - Kırılganlığı reddetetme',
      zodiac.ZodiacSign.taurus:
          '"Sahip olduklarım beni tanımlar" - Maddi bağımlılık',
      zodiac.ZodiacSign.gemini:
          '"Derinleşirsem kaybolursam" - Yüzeyselliğe sığınma',
      zodiac.ZodiacSign.cancer:
          '"Geçmişim şimdimi belirler" - Geçmişe takılı kalma',
      zodiac.ZodiacSign.leo:
          '"İlgi almazsam sevilimsizim" - Dikkat bağımlılığı',
      zodiac.ZodiacSign.virgo:
          '"Kendimi geliştirmeliyim" - Hiçbir zaman yeterli olmama',
      zodiac.ZodiacSign.libra:
          '"Çatışma ilişkiyi bitirir" - Uyumsuzluk korkusu',
      zodiac.ZodiacSign.scorpio:
          '"Acı çekmek gücün bedeli" - Yoğunluk bağımlılığı',
      zodiac.ZodiacSign.sagittarius:
          '"Her şeyin bir anlamı olmalı" - Anlam arayışı takıntısı',
      zodiac.ZodiacSign.capricorn:
          '"Duygular zayıflıktır" - Duygusal baskılama',
      zodiac.ZodiacSign.aquarius: '"Kimse beni anlamaz" - Yalnızlık inancı',
      zodiac.ZodiacSign.pisces: '"Ben kurbanım" - Sorumluluktan kaçış',
    };
    return patterns[sign] ?? 'Gizli inanç';
  }

  static String _getPattern3(zodiac.ZodiacSign sign) {
    final patterns = {
      zodiac.ZodiacSign.aries:
          '"Yardım istemek zayıflıktır" - Bağımsızlık takıntısı',
      zodiac.ZodiacSign.taurus: '"Rahatım tehdit altında" - Güvensizlik hissi',
      zodiac.ZodiacSign.gemini:
          '"Bir konuya bağlı kalamam" - Tutarsızlık döngüsü',
      zodiac.ZodiacSign.cancer: '"Ailem olmadan yapamam" - Bağımlılık kalıbı',
      zodiac.ZodiacSign.leo: '"Hep en iyi ben olmalıyım" - Rekabet takıntısı',
      zodiac.ZodiacSign.virgo: '"Detaylar her şeydir" - Büyük resmi kaçırma',
      zodiac.ZodiacSign.libra:
          '"Kararlarım yanlış olabilir" - Karar verme korkusu',
      zodiac.ZodiacSign.scorpio: '"Sırlarım beni korur" - Aşırı gizlilik',
      zodiac.ZodiacSign.sagittarius:
          '"En iyisi hep başka yerde" - Memnuniyetsizlik döngüsü',
      zodiac.ZodiacSign.capricorn: '"Dinlenmek tembeliktir" - İş bağımlılığı',
      zodiac.ZodiacSign.aquarius:
          '"Duygusal olmak primitif" - Duyguları reddetme',
      zodiac.ZodiacSign.pisces: '"Sınırlar sevgisizlik" - Sınır koyamama',
    };
    return patterns[sign] ?? 'Gizli program';
  }

  // ═══════════════════════════════════════════════════════════
  // GÜNLÜK ENERJİLER
  // ═══════════════════════════════════════════════════════════

  static Map<String, String> _getDailySummaryContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final summaries = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, bugün enerjin yüksek ve aksiyona hazırsın! Koç burcu olarak gün boyunca cesur adımlar atabilirsin.',
        'details':
            '🌅 Sabah Enerjisi: Dinamik başlangıç\n☀️ Öğle Enerjisi: Liderlik fırsatları\n🌙 Akşam Enerjisi: Dinlenme ve yeniden şarj\n\nBugünün Rengi: Kırmızı\nBugünün Sayısı: 1\nBugünün Kristali: Kırmızı Jasper',
        'advice':
            'Sabırlı ol, her şeyi hemen yapmaya çalışma. Enerjini akıllıca dağıt.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, bugün istikrar ve güzellik günü! Boğa burcu olarak duyularını tatmin edecek deneyimler seni bekliyor.',
        'details':
            '🌅 Sabah Enerjisi: Sakin ve topraklanmış\n☀️ Öğle Enerjisi: Verimli çalışma zamanı\n🌙 Akşam Enerjisi: Konfor ve keyif\n\nBugünün Rengi: Yeşil\nBugünün Sayısı: 6\nBugünün Kristali: Yeşim',
        'advice': 'Değişime direnme, bugün yeni bir şey denemeye açık ol.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, bugün iletişim ve öğrenme günü! İkizler burcu olarak yeni bağlantılar kurabilirsin.',
        'details':
            '🌅 Sabah Enerjisi: Meraklı ve hareketli\n☀️ Öğle Enerjisi: Sosyal etkileşimler\n🌙 Akşam Enerjisi: Düşünme ve analiz\n\nBugünün Rengi: Sarı\nBugünün Sayısı: 5\nBugünün Kristali: Sitrin',
        'advice': 'Bir konuya odaklan, dağılma. Derinleşme zamanı.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, bugün duygusal derinlik günü! Yengeç burcu olarak sezgilerin güçlü çalışıyor.',
        'details':
            '🌅 Sabah Enerjisi: Hassas ve sezgisel\n☀️ Öğle Enerjisi: Aile ve yuva odaklı\n🌙 Akşam Enerjisi: Dinlendirici ve huzurlu\n\nBugünün Rengi: Gümüş\nBugünün Sayısı: 2\nBugünün Kristali: Ay Taşı',
        'advice': 'Geçmişe takılma, şimdiki anın güzelliğini gör.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, bugün parıldama günü! Aslan burcu olarak tüm dikkatler üzerinde olacak.',
        'details':
            '🌅 Sabah Enerjisi: Karizmatik ve enerjik\n☀️ Öğle Enerjisi: Yaratıcı ifade zamanı\n🌙 Akşam Enerjisi: Sosyal ve eğlenceli\n\nBugünün Rengi: Altın\nBugünün Sayısı: 1\nBugünün Kristali: Kaplan Gözü',
        'advice': 'Başkalarına da parlamaları için alan ver.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, bugün verimlilik günü! Başak burcu olarak detaylara hakimsin.',
        'details':
            '🌅 Sabah Enerjisi: Organize ve planlı\n☀️ Öğle Enerjisi: Verimli iş saatleri\n🌙 Akşam Enerjisi: Kendine bakım zamanı\n\nBugünün Rengi: Lacivert\nBugünün Sayısı: 5\nBugünün Kristali: Amazonit',
        'advice': 'Mükemmeliyetçiliği bırak, "yeterince iyi" yeterli.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, bugün denge ve güzellik günü! Terazi burcu olarak uyum arayışındasın.',
        'details':
            '🌅 Sabah Enerjisi: Harmonik ve zarif\n☀️ Öğle Enerjisi: İlişki odaklı\n🌙 Akşam Enerjisi: Romantik ve sanatsal\n\nBugünün Rengi: Pembe\nBugünün Sayısı: 6\nBugünün Kristali: Gül Kuvars',
        'advice': 'Kendi sesini bul, herkesi memnun etmeye çalışma.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, bugün dönüşüm günü! Akrep burcu olarak derin içgörüler alabilirsin.',
        'details':
            '🌅 Sabah Enerjisi: Yoğun ve odaklanmış\n☀️ Öğle Enerjisi: Araştırma ve keşif\n🌙 Akşam Enerjisi: Derin ve mistik\n\nBugünün Rengi: Bordo\nBugünün Sayısı: 9\nBugünün Kristali: Obsidyen',
        'advice': 'Kontrolü biraz bırak, akışa güven.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, bugün macera günü! Yay burcu olarak özgürlük ve keşif seni çağırıyor.',
        'details':
            '🌅 Sabah Enerjisi: İyimser ve maceraperest\n☀️ Öğle Enerjisi: Öğrenme ve genişleme\n🌙 Akşam Enerjisi: Felsefi ve derin\n\nBugünün Rengi: Mor\nBugünün Sayısı: 3\nBugünün Kristali: Turkuaz',
        'advice': 'Sorumluluklarını ihmal etme, denge kur.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, bugün başarı günü! Oğlak burcu olarak hedeflerine yaklaşıyorsun.',
        'details':
            '🌅 Sabah Enerjisi: Kararlı ve disiplinli\n☀️ Öğle Enerjisi: Verimli çalışma\n🌙 Akşam Enerjisi: Huzurlu dinlenme\n\nBugünün Rengi: Siyah\nBugünün Sayısı: 8\nBugünün Kristali: Oniks',
        'advice': 'Sadece işe değil, ilişkilere de zaman ayır.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, bugün yenilik günü! Kova burcu olarak farklı fikirler üretebilirsin.',
        'details':
            '🌅 Sabah Enerjisi: Yaratıcı ve orijinal\n☀️ Öğle Enerjisi: Sosyal ve topluluk odaklı\n🌙 Akşam Enerjisi: Vizyoner düşünceler\n\nBugünün Rengi: Elektrik mavisi\nBugünün Sayısı: 4\nBugünün Kristali: Ametist',
        'advice': 'Duygusal bağlantılarını ihmal etme.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, bugün ruhani günü! Balık burcu olarak sezgilerin zirve yapıyor.',
        'details':
            '🌅 Sabah Enerjisi: Rüya gibi ve hassas\n☀️ Öğle Enerjisi: Yaratıcı ve sanatsal\n🌙 Akşam Enerjisi: Spiritüel ve derin\n\nBugünün Rengi: Deniz mavisi\nBugünün Sayısı: 7\nBugünün Kristali: Akuamarin',
        'advice': 'Ayaklarını yere bas, hayal ile gerçeği ayır.',
      },
    };
    return summaries[sign] ?? {'mainMessage': 'Günlük özet yükleniyor...'};
  }

  static Map<String, String> _getMoonEnergyContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, Ay enerjisi ${sign.nameTr} burcunu derinden etkiliyor. Duygusal dünyanda önemli hareketler var.',
      'details':
          'Ay\'ın ${sign.element} elementi üzerindeki etkisi:\n\n🌑 Yeni Ay: Yeni başlangıçlar için ideal\n🌓 İlk Dördün: Aksiyon zamanı\n🌕 Dolunay: Duygusal zirve\n🌗 Son Dördün: Bırakma ve temizlik\n\n${_getMoonAdvice(sign)}',
      'advice': 'Ay döngüsünü takip et, duygusal akışınla uyumlu hareket et.',
      'warning': 'Dolunay dönemlerinde duygusal tepkilerine dikkat et.',
    };
  }

  static String _getMoonAdvice(zodiac.ZodiacSign sign) {
    final advice = {
      zodiac.ZodiacSign.aries:
          'Ateş elementi olarak Ay enerjisi seni dürtüsel yapabilir. Düşün, sonra hareket et.',
      zodiac.ZodiacSign.taurus:
          'Ay\'ın yükselmesi burcun olarak duygusal güvenlik önemli. Konfor alanında kal.',
      zodiac.ZodiacSign.gemini:
          'Hava elementi olarak Ay enerjisi zihinsel kargaşa yaratabilir. Meditasyon yap.',
      zodiac.ZodiacSign.cancer:
          'Ay\'ın yönettiği burç olarak Ay döngülerinden çok etkilenirsin. Öz bakıma önem ver.',
      zodiac.ZodiacSign.leo:
          'Ateş elementi olarak Ay enerjisi dramayı artırabilir. Ego\'yu dengele.',
      zodiac.ZodiacSign.virgo:
          'Toprak elementi olarak Ay enerjisi kaygıyı artırabilir. Topraklanma yap.',
      zodiac.ZodiacSign.libra:
          'Hava elementi olarak Ay enerjisi kararsızlığı artırabilir. İçsel sesini dinle.',
      zodiac.ZodiacSign.scorpio:
          'Su elementi olarak Ay enerjisi yoğunluğu artırır. Duyguları dönüştür.',
      zodiac.ZodiacSign.sagittarius:
          'Ateş elementi olarak Ay enerjisi kaçış isteği yaratabilir. Yerinde kal.',
      zodiac.ZodiacSign.capricorn:
          'Ay\'ın düşüş burcunda olarak duygularla barışman önemli.',
      zodiac.ZodiacSign.aquarius:
          'Hava elementi olarak Ay enerjisi duygusal mesafeyi artırabilir. Bağlan.',
      zodiac.ZodiacSign.pisces:
          'Su elementi olarak Ay enerjisi sezgileri güçlendirir. Sınırlarını koru.',
    };
    return advice[sign] ?? 'Ay enerjisini dengele.';
  }

  static Map<String, String> _getMoonRitualsContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, Ay ritüelleri ${sign.nameTr} burcunun duygusal döngüsünü destekler.',
      'details':
          'Ay Fazlarına Göre Ritüeller:\n\n🌑 Yeni Ay Ritüeli:\n• Niyet belirleme\n• Mum yakma\n• Dilek yazma\n\n🌕 Dolunay Ritüeli:\n• Bırakma meditasyonu\n• Ay banyosu\n• Şükran listesi\n\n🌙 ${sign.element} Elementi için özel:\n${_getMoonRitualAdvice(sign)}',
      'advice': 'Her Ay fazında 10 dakika sessiz meditasyon yap.',
      'warning': 'Ay tutulmalarında ritüel yapmaktan kaçın.',
    };
  }

  static String _getMoonRitualAdvice(zodiac.ZodiacSign sign) {
    final rituals = {
      zodiac.ZodiacSign.aries: 'Ateş ritüeli: Mum yakarak niyetini güçlendir.',
      zodiac.ZodiacSign.taurus: 'Toprak ritüeli: Doğada çıplak ayakla yürü.',
      zodiac.ZodiacSign.gemini: 'Hava ritüeli: Rüzgara dileklerini fısılda.',
      zodiac.ZodiacSign.cancer: 'Su ritüeli: Ay ışığında banyo yap.',
      zodiac.ZodiacSign.leo: 'Ateş ritüeli: Güneş doğarken niyet kur.',
      zodiac.ZodiacSign.virgo: 'Toprak ritüeli: Bitki dikme meditasyonu.',
      zodiac.ZodiacSign.libra: 'Hava ritüeli: Tütsü yakarak denge kur.',
      zodiac.ZodiacSign.scorpio: 'Su ritüeli: Temizleyici banyo al.',
      zodiac.ZodiacSign.sagittarius: 'Ateş ritüeli: Ateş başında meditasyon.',
      zodiac.ZodiacSign.capricorn: 'Toprak ritüeli: Kristal çalışması yap.',
      zodiac.ZodiacSign.aquarius: 'Hava ritüeli: Nefes çalışması yap.',
      zodiac.ZodiacSign.pisces: 'Su ritüeli: Ay suyu hazırla.',
    };
    return rituals[sign] ?? 'Elementinle uyumlu ritüel seç.';
  }

  static Map<String, String> _getCrystalGuideContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final crystals = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, Koç burcunun şifa kristalleri enerji ve cesaret taşıyor.',
        'details':
            '💎 Ana Kristalin: Karnelyan\n🔮 Destek Kristalleri:\n• Kırmızı Jasper - cesaret\n• Sitrin - enerji\n• Hematit - topraklama\n\n✨ Kullanım:\n• Sağ cepte taşı\n• Meditasyonda göğüste tut\n• Dolunayda arındır',
        'advice': 'Karnelyan göbek çakrasını aktive eder.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, Boğa burcunun şifa kristalleri bolluk ve huzur getiriyor.',
        'details':
            '💎 Ana Kristalin: Rodonit\n🔮 Destek Kristalleri:\n• Yeşil Aventurin - bolluk\n• Gül Kuvars - sevgi\n• Lapis Lazuli - bilgelik\n\n✨ Kullanım:\n• Yastık altında tut\n• Cüzdanda taşı\n• Yeni ayda şarj et',
        'advice': 'Rodonit kalp çakrasını dengeliyor.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, İkizler burcunun şifa kristalleri iletişim ve odaklanma sağlıyor.',
        'details':
            '💎 Ana Kristalin: Akvamarin\n🔮 Destek Kristalleri:\n• Agat - denge\n• Kaplan Gözü - odak\n• Florit - zihinsel berraklık\n\n✨ Kullanım:\n• Boğaz çakrasında tut\n• Çalışma masasında bulundur\n• Akarsuda arındır',
        'advice': 'Akvamarin iletişimi güçlendiriyor.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, Yengeç burcunun şifa kristalleri duygusal koruma sağlıyor.',
        'details':
            '💎 Ana Kristalin: Ay Taşı\n🔮 Destek Kristalleri:\n• Sedefli İnci - sezgi\n• Opal - duygusal denge\n• Rodonit - şefkat\n\n✨ Kullanım:\n• Kalp üzerinde tut\n• Dolunayda şarj et\n• Suyla arındır',
        'advice': 'Ay Taşı sezgileri güçlendiriyor.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, Aslan burcunun şifa kristalleri parlaklık ve özgüven veriyor.',
        'details':
            '💎 Ana Kristalin: Güneş Taşı\n🔮 Destek Kristalleri:\n• Kaplan Gözü - güç\n• Sitrin - neşe\n• Kehribar - enerji\n\n✨ Kullanım:\n• Güneş ışığında şarj et\n• Göğüs üzerinde tut\n• Solar pleksus çakrasına yerleştir',
        'advice': 'Güneş Taşı özgüveni artırıyor.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, Başak burcunun şifa kristalleri berraklık ve şifa getiriyor.',
        'details':
            '💎 Ana Kristalin: Amazonit\n🔮 Destek Kristalleri:\n• Yeşil Turmalin - detoks\n• Ametist - sakinlik\n• Florit - odak\n\n✨ Kullanım:\n• Boğazda veya göğüste tut\n• Doğada şarj et\n• Tuzla arındır',
        'advice': 'Amazonit kaygıyı azaltıyor.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, Terazi burcunun şifa kristalleri denge ve uyum sağlıyor.',
        'details':
            '💎 Ana Kristalin: Lepidolit\n🔮 Destek Kristalleri:\n• Gül Kuvars - sevgi\n• Turkuaz - iletişim\n• Akuamarin - huzur\n\n✨ Kullanım:\n• İki elde tut\n• Kalp çakrasına yerleştir\n• Ay ışığında şarj et',
        'advice': 'Lepidolit duygusal dengeyi destekliyor.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, Akrep burcunun şifa kristalleri dönüşüm ve koruma sağlıyor.',
        'details':
            '💎 Ana Kristalin: Obsidiyen\n🔮 Destek Kristalleri:\n• Labradorit - dönüşüm\n• Kırmızı Garnet - tutku\n• Malakit - koruma\n\n✨ Kullanım:\n• Kök çakrasına yerleştir\n• Meditasyonda kullan\n• Akarsuda arındır',
        'advice': 'Obsidiyen gölge çalışmasını destekliyor.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, Yay burcunun şifa kristalleri genişleme ve şans getiriyor.',
        'details':
            '💎 Ana Kristalin: Turkuaz\n🔮 Destek Kristalleri:\n• Sodalit - bilgelik\n• Ametist - ruhsallık\n• Sitrin - bolluk\n\n✨ Kullanım:\n• Boğaz çakrasına yerleştir\n• Seyahatte yanında taşı\n• Güneşte şarj et',
        'advice': 'Turkuaz koruma ve şans getiriyor.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, Oğlak burcunun şifa kristalleri disiplin ve başarı destekliyor.',
        'details':
            '💎 Ana Kristalin: Oniks\n🔮 Destek Kristalleri:\n• Yeşil Turmalin - bolluk\n• Garnet - motivasyon\n• Dumanlı Kuvars - topraklama\n\n✨ Kullanım:\n• Kök çakrasına yerleştir\n• Ofiste bulundur\n• Toprağa gömerek arındır',
        'advice': 'Oniks odaklanma ve kararlılık veriyor.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, Kova burcunun şifa kristalleri yenilik ve özgürlük destekliyor.',
        'details':
            '💎 Ana Kristalin: Ametist\n🔮 Destek Kristalleri:\n• Labradorit - sezgi\n• Akuamarin - iletişim\n• Florit - zihinsel berraklık\n\n✨ Kullanım:\n• Taç çakrasına yerleştir\n• Meditasyonda kullan\n• Ay ışığında şarj et',
        'advice': 'Ametist üst çakraları aktive ediyor.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, Balık burcunun şifa kristalleri sezgi ve ruhsal bağlantı sağlıyor.',
        'details':
            '💎 Ana Kristalin: Ay Taşı\n🔮 Destek Kristalleri:\n• Akuamarin - duygusal şifa\n• Ametist - ruhsal bağlantı\n• Florit - koruma\n\n✨ Kullanım:\n• Üçüncü göze yerleştir\n• Suyla arındır\n• Dolunayda şarj et',
        'advice': 'Ay Taşı psişik yetenekleri açıyor.',
      },
    };
    return crystals[sign] ?? {'mainMessage': 'Kristal bilgin yükleniyor...'};
  }

  static Map<String, String> _getLoveEnergyContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final loveEnergies = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, aşk enerjin bugün ateşli ve tutkulu! Koç burcu olarak ilk adımı atmaktan çekinmiyorsun.',
        'details':
            '💕 Aşk Titreşimin: Cesur ve doğrudan\n💫 Çekim Gücün: Enerji ve coşku\n🌹 Romantik Havanın: Maceraperest\n\n🎯 Bugün aşkta: İlk adımı at, risk al\n⚠️ Dikkat: Sabırsızlık ilişkiyi yorabilir',
        'advice': 'Partnerine alan ver, her şeyi kontrol etmeye çalışma.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, aşk enerjin bugün duyusal ve derin! Boğa burcu olarak sadakatle seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Sadık ve tutkulu\n💫 Çekim Gücün: Güvenilirlik\n🌹 Romantik Havanın: Duyusal ve romantik\n\n🎯 Bugün aşkta: Romantik ortamlar yarat\n⚠️ Dikkat: Kıskançlık dengeyi bozabilir',
        'advice': 'Sahiplenicilikten kaçın, güven inşa et.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, aşk enerjin bugün eğlenceli ve meraklı! İkizler burcu olarak iletişimle baştan çıkarırsın.',
        'details':
            '💕 Aşk Titreşimin: Entelektüel ve eğlenceli\n💫 Çekim Gücün: Zeka ve espri\n🌹 Romantik Havanın: Hafif ve oyuncu\n\n🎯 Bugün aşkta: Sohbet et, dinle\n⚠️ Dikkat: Tutarsızlık güveni zedeler',
        'advice': 'Sözlerini tut, derinleşmeye izin ver.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, aşk enerjin bugün duygusal ve şefkatli! Yengeç burcu olarak kalbinle seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Derin ve koruyucu\n💫 Çekim Gücün: Şefkat ve empati\n🌹 Romantik Havanın: Duygusal ve yumuşak\n\n🎯 Bugün aşkta: Duygularını ifade et\n⚠️ Dikkat: Aşırı hassasiyet yaralar',
        'advice': 'Kabuğundan çık, kırılganlığını göster.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, aşk enerjin bugün görkemli ve sıcak! Aslan burcu olarak cömertçe seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Cömert ve tutkulu\n💫 Çekim Gücün: Karizma ve sıcaklık\n🌹 Romantik Havanın: Görkemli ve drama dolu\n\n🎯 Bugün aşkta: Partnerini takdir et\n⚠️ Dikkat: Ego çatışması riski',
        'advice': 'Partnerine de sahne ver, dinle.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, aşk enerjin bugün düşünceli ve hizmet odaklı! Başak burcu olarak eylemlerle seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Nazik ve yardımsever\n💫 Çekim Gücün: Güvenilirlik ve dikkat\n🌹 Romantik Havanın: Düşünceli ve pratik\n\n🎯 Bugün aşkta: Küçük jestler yap\n⚠️ Dikkat: Eleştiri ilişkiyi soğutur',
        'advice': 'Kusurları kabul et, mükemmeliyetçiliği bırak.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, aşk enerjin bugün romantik ve zarif! Terazi burcu olarak uyumla seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Romantik ve diplomatik\n💫 Çekim Gücün: Çekicilik ve zarafet\n🌹 Romantik Havanın: Estetik ve uyumlu\n\n🎯 Bugün aşkta: Romantik anlar yarat\n⚠️ Dikkat: Kararsızlık yorabilir',
        'advice': 'Kendi ihtiyaçlarını da söyle, her şeye evet deme.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, aşk enerjin bugün yoğun ve manyetik! Akrep burcu olarak derinden seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Tutkulu ve yoğun\n💫 Çekim Gücün: Manyetizma ve gizem\n🌹 Romantik Havanın: Derin ve dönüştürücü\n\n🎯 Bugün aşkta: Duygusal derinlik ara\n⚠️ Dikkat: Kıskançlık zehirleyebilir',
        'advice': 'Güvenmeyi öğren, kontrolü bırak.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, aşk enerjin bugün maceraperest ve özgür! Yay burcu olarak eğlenerek seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Maceraperest ve neşeli\n💫 Çekim Gücün: İyimserlik ve eğlence\n🌹 Romantik Havanın: Spontan ve özgür\n\n🎯 Bugün aşkta: Birlikte maceraya çık\n⚠️ Dikkat: Taahhüt korkusu uzaklaştırır',
        'advice': 'Bağlanmaktan korkma, özgürlük ilişkide de var.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, aşk enerjin bugün ciddi ve sadık! Oğlak burcu olarak kararlılıkla seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Sadık ve kararlı\n💫 Çekim Gücün: Güvenilirlik ve başarı\n🌹 Romantik Havanın: Geleneksel ve derin\n\n🎯 Bugün aşkta: Uzun vadeli plan yap\n⚠️ Dikkat: Duygusal mesafe soğutur',
        'advice': 'Duygularını göster, her şey iş olmasın.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, aşk enerjin bugün benzersiz ve entelektüel! Kova burcu olarak farklı seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Özgün ve arkadaşça\n💫 Çekim Gücün: Orijinallik ve zeka\n🌹 Romantik Havanın: Sıra dışı ve özgür\n\n🎯 Bugün aşkta: Arkadaşlık temelli bağlan\n⚠️ Dikkat: Duygusal mesafe yaralar',
        'advice': 'Yakınlaşmaktan korkma, duygusal ol.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, aşk enerjin bugün romantik ve rüya gibi! Balık burcu olarak koşulsuz seviyorsun.',
        'details':
            '💕 Aşk Titreşimin: Romantik ve fedakar\n💫 Çekim Gücün: Empati ve hassasiyet\n🌹 Romantik Havanın: Masalsı ve derin\n\n🎯 Bugün aşkta: Ruhsal bağ kur\n⚠️ Dikkat: İdealizasyon hayal kırıklığı yaratır',
        'advice': 'Ayakların yerde kalsın, sınırlarını koru.',
      },
    };
    return loveEnergies[sign] ?? {'mainMessage': 'Aşk enerjin yükleniyor...'};
  }

  static Map<String, String> _getAbundanceEnergyContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final abundances = {
      zodiac.ZodiacSign.aries: {
        'mainMessage':
            '$userName, bolluk enerjin bugün aksiyonla geliyor! Koç burcu olarak fırsatları yakalama kapasiten yüksek.',
        'details':
            '💰 Bolluk Kanalın: Cesaret ve girişimcilik\n✨ Bereket Alanın: Yeni başlangıçlar\n🍀 Şans Faktörün: İlk adımı atmak\n\n🎯 Bolluk İçin: Risk al, fırsat kovala\n🔮 Engelin: Sabırsızlık ve yarım bırakma',
        'advice': 'Bolluk sabır ister, hemen sonuç bekleme.',
      },
      zodiac.ZodiacSign.taurus: {
        'mainMessage':
            '$userName, bolluk enerjin bugün güçlü! Boğa burcu olarak maddi dünya senin alanın.',
        'details':
            '💰 Bolluk Kanalın: İstikrar ve sabır\n✨ Bereket Alanın: Uzun vadeli yatırımlar\n🍀 Şans Faktörün: Kararlılık\n\n🎯 Bolluk İçin: Güvenli yatırımlar yap\n🔮 Engelin: Aşırı tutumculuk',
        'advice':
            'Bolluğu sadece maddi olarak görme, duygusal zenginliği de kucakla.',
      },
      zodiac.ZodiacSign.gemini: {
        'mainMessage':
            '$userName, bolluk enerjin bugün iletişimden geliyor! İkizler burcu olarak bağlantılar bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: İletişim ve ağ kurma\n✨ Bereket Alanın: Fikirler ve projeler\n🍀 Şans Faktörün: Doğru kişilerle tanışmak\n\n🎯 Bolluk İçin: Network\'ünü genişlet\n🔮 Engelin: Odak kaybı',
        'advice': 'Bir projeye odaklan ve bitir.',
      },
      zodiac.ZodiacSign.cancer: {
        'mainMessage':
            '$userName, bolluk enerjin bugün ev ve aileden geliyor! Yengeç burcu olarak güvenli temellerden büyürsün.',
        'details':
            '💰 Bolluk Kanalın: Aile ve yuva\n✨ Bereket Alanın: Gayrimenkul, ev işleri\n🍀 Şans Faktörün: Duygusal güvenlik\n\n🎯 Bolluk İçin: Yuvana yatırım yap\n🔮 Engelin: Güvensizlik duygusu',
        'advice': 'Duygusal bolluğu da kabul et, her şey para değil.',
      },
      zodiac.ZodiacSign.leo: {
        'mainMessage':
            '$userName, bolluk enerjin bugün yaratıcılıktan geliyor! Aslan burcu olarak sahne senin alanın.',
        'details':
            '💰 Bolluk Kanalın: Yaratıcılık ve performans\n✨ Bereket Alanın: Sanat, eğlence, çocuklar\n🍀 Şans Faktörün: Kendini ifade etmek\n\n🎯 Bolluk İçin: Yeteneklerini sergile\n🔮 Engelin: Ego ve kibir',
        'advice': 'Cömertlik bolluğu çeker, paylaş.',
      },
      zodiac.ZodiacSign.virgo: {
        'mainMessage':
            '$userName, bolluk enerjin bugün hizmetten geliyor! Başak burcu olarak pratik çözümler bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: Hizmet ve detaycılık\n✨ Bereket Alanın: Sağlık, organizasyon\n🍀 Şans Faktörün: Verimlilik\n\n🎯 Bolluk İçin: Değer yarat, hizmet et\n🔮 Engelin: Aşırı eleştiri',
        'advice': 'Değerini bil, hizmetinin karşılığını al.',
      },
      zodiac.ZodiacSign.libra: {
        'mainMessage':
            '$userName, bolluk enerjin bugün ilişkilerden geliyor! Terazi burcu olarak ortaklıklar bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: İlişkiler ve ortaklıklar\n✨ Bereket Alanın: Sanat, hukuk, diplomasi\n🍀 Şans Faktörün: Doğru ortaklar\n\n🎯 Bolluk İçin: Win-win ortaklıklar kur\n🔮 Engelin: Bağımlılık',
        'advice': 'Kendi bolluk kapasiteni de geliştir.',
      },
      zodiac.ZodiacSign.scorpio: {
        'mainMessage':
            '$userName, bolluk enerjin bugün dönüşümden geliyor! Akrep burcu olarak derin kazılar bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: Dönüşüm ve yatırım\n✨ Bereket Alanın: Miras, ortak kaynaklar\n🍀 Şans Faktörün: Derinlemesine araştırma\n\n🎯 Bolluk İçin: Dönüşümü kucakla\n🔮 Engelin: Kontrol takıntısı',
        'advice': 'Bırak ki gelsin, kontrol bolluğu engeller.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'mainMessage':
            '$userName, bolluk enerjin bugün genişlemeden geliyor! Yay burcu olarak ufukların bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: Eğitim ve seyahat\n✨ Bereket Alanın: Yayıncılık, felsefe\n🍀 Şans Faktörün: İyimserlik ve inanç\n\n🎯 Bolluk İçin: Öğren ve öğret\n🔮 Engelin: Aşırı risk alma',
        'advice': 'İyimserliğin bereketini çeker, ama plan da yap.',
      },
      zodiac.ZodiacSign.capricorn: {
        'mainMessage':
            '$userName, bolluk enerjin bugün çalışkanlıktan geliyor! Oğlak burcu olarak azmin bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: Kariyer ve statü\n✨ Bereket Alanın: Yönetim, yapı kurma\n🍀 Şans Faktörün: Disiplin ve azim\n\n🎯 Bolluk İçin: Uzun vadeli hedefler koy\n🔮 Engelin: Workaholism',
        'advice': 'Bolluk sadece para değil, yaşam kalitesi de önemli.',
      },
      zodiac.ZodiacSign.aquarius: {
        'mainMessage':
            '$userName, bolluk enerjin bugün yenilikten geliyor! Kova burcu olarak farklı fikirler bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: Yenilik ve teknoloji\n✨ Bereket Alanın: Topluluk, insancıllık\n🍀 Şans Faktörün: Orijinal fikirler\n\n🎯 Bolluk İçin: Farklı düşün, farklı yap\n🔮 Engelin: Pratiklik eksikliği',
        'advice': 'Fikirlerini somutlaştır, sadece düşünme yap.',
      },
      zodiac.ZodiacSign.pisces: {
        'mainMessage':
            '$userName, bolluk enerjin bugün sezgilerden geliyor! Balık burcu olarak yaratıcılık bereketini artırıyor.',
        'details':
            '💰 Bolluk Kanalın: Yaratıcılık ve spiritüalite\n✨ Bereket Alanın: Sanat, şifa, müzik\n🍀 Şans Faktörün: Sezgisel rehberlik\n\n🎯 Bolluk İçin: Sezgilerini takip et\n🔮 Engelin: Gerçeklikten kopuş',
        'advice': 'Hayallerini somut adımlarla destekle.',
      },
    };
    return abundances[sign] ?? {'mainMessage': 'Bolluk enerjin yükleniyor...'};
  }

  // ═══════════════════════════════════════════════════════════
  // MİSTİK KEŞİFLER
  // ═══════════════════════════════════════════════════════════

  static Map<String, String> _getTarotCardContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final tarotCards = {
      zodiac.ZodiacSign.aries: {
        'card': 'İmparator',
        'meaning': 'Güç, otorite, yapı kurma',
        'advice': 'Liderlik kapasiteni kullan ama diktatör olma.',
      },
      zodiac.ZodiacSign.taurus: {
        'card': 'İmparatoriçe',
        'meaning': 'Bereket, doğurganlık, duyusal zevkler',
        'advice': 'Bolluğu kucakla, güzelliği yarat.',
      },
      zodiac.ZodiacSign.gemini: {
        'card': 'Aşıklar',
        'meaning': 'Seçimler, ikililik, iletişim',
        'advice': 'Kalbinle seç, ama aklını da dinle.',
      },
      zodiac.ZodiacSign.cancer: {
        'card': 'Savaş Arabası',
        'meaning': 'Zafer, irade gücü, ilerleme',
        'advice': 'Duygularını kontrol et, hedefe odaklan.',
      },
      zodiac.ZodiacSign.leo: {
        'card': 'Güç',
        'meaning': 'Cesaret, içsel güç, karizma',
        'advice': 'Gerçek güç içeriden gelir, ego değil.',
      },
      zodiac.ZodiacSign.virgo: {
        'card': 'Ermiş',
        'meaning': 'İçe bakış, analiz, bilgelik',
        'advice': 'Cevaplar içinde, sessizlikte ara.',
      },
      zodiac.ZodiacSign.libra: {
        'card': 'Adalet',
        'meaning': 'Denge, doğruluk, karar',
        'advice': 'Adil ol, denge kur, karar ver.',
      },
      zodiac.ZodiacSign.scorpio: {
        'card': 'Ölüm',
        'meaning': 'Dönüşüm, sonlanma, yeniden doğuş',
        'advice': 'Eski bitmeden yeni başlamaz, bırak.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'card': 'Denge',
        'meaning': 'Ölçülülük, sabır, uyum',
        'advice': 'Her şeyin bir dengesi var, sabırlı ol.',
      },
      zodiac.ZodiacSign.capricorn: {
        'card': 'Şeytan',
        'meaning': 'Bağımlılıklar, gölge, madde',
        'advice': 'Bağımlılıklarını tanı ve dönüştür.',
      },
      zodiac.ZodiacSign.aquarius: {
        'card': 'Yıldız',
        'meaning': 'Umut, ilham, vizyon',
        'advice': 'Yıldızın parıldıyor, umudunu koru.',
      },
      zodiac.ZodiacSign.pisces: {
        'card': 'Ay',
        'meaning': 'Sezgi, rüyalar, bilinçaltı',
        'advice': 'Sezgilerine güven, rüyalarını takip et.',
      },
    };

    final cardData =
        tarotCards[sign] ??
        {
          'card': 'Dünya',
          'meaning': 'Tamamlanma',
          'advice': 'Döngü tamamlanıyor.',
        };

    return {
      'mainMessage':
          '$userName, senin Tarot kartın: ${cardData['card']}! ${sign.nameTr} burcu olarak bu kart senin ruhsal yolculuğunu temsil ediyor.',
      'details':
          '🎴 Kartın: ${cardData['card']}\n\n✨ Anlamı: ${cardData['meaning']}\n\n🔮 Bu Kart Sana Ne Söylüyor:\n${cardData['card']} kartı, yaşam amacın ve mevcut dönemin hakkında derin mesajlar taşıyor. Bu kart, ${sign.element} elementinin enerjisiyle birleşiyor.',
      'advice': cardData['advice']!,
    };
  }

  static Map<String, String> _getAuraColorContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final auraColors = {
      zodiac.ZodiacSign.aries: {
        'color': 'Kırmızı',
        'meaning': 'Enerji, tutku, cesaret',
        'chakra': 'Kök Çakra',
      },
      zodiac.ZodiacSign.taurus: {
        'color': 'Yeşil',
        'meaning': 'Şifa, bolluk, doğa',
        'chakra': 'Kalp Çakra',
      },
      zodiac.ZodiacSign.gemini: {
        'color': 'Sarı',
        'meaning': 'Zeka, iletişim, neşe',
        'chakra': 'Solar Pleksus',
      },
      zodiac.ZodiacSign.cancer: {
        'color': 'Gümüş',
        'meaning': 'Sezgi, duygusal derinlik, şefkat',
        'chakra': 'Sakral Çakra',
      },
      zodiac.ZodiacSign.leo: {
        'color': 'Altın',
        'meaning': 'Yaratıcılık, güç, parlaklık',
        'chakra': 'Solar Pleksus',
      },
      zodiac.ZodiacSign.virgo: {
        'color': 'Lacivert',
        'meaning': 'Analiz, hizmet, iyileştirme',
        'chakra': 'Üçüncü Göz',
      },
      zodiac.ZodiacSign.libra: {
        'color': 'Pembe',
        'meaning': 'Aşk, uyum, güzellik',
        'chakra': 'Kalp Çakra',
      },
      zodiac.ZodiacSign.scorpio: {
        'color': 'Bordo',
        'meaning': 'Dönüşüm, güç, gizem',
        'chakra': 'Sakral Çakra',
      },
      zodiac.ZodiacSign.sagittarius: {
        'color': 'Mor',
        'meaning': 'Bilgelik, spiritüalite, genişleme',
        'chakra': 'Taç Çakra',
      },
      zodiac.ZodiacSign.capricorn: {
        'color': 'Kahverengi',
        'meaning': 'Topraklama, stabilite, pratiklik',
        'chakra': 'Kök Çakra',
      },
      zodiac.ZodiacSign.aquarius: {
        'color': 'Elektrik Mavisi',
        'meaning': 'Yenilik, özgürlük, vizyon',
        'chakra': 'Boğaz Çakra',
      },
      zodiac.ZodiacSign.pisces: {
        'color': 'Deniz Mavisi',
        'meaning': 'Ruhsallık, şifa, sezgi',
        'chakra': 'Üçüncü Göz',
      },
    };

    final auraData =
        auraColors[sign] ??
        {'color': 'Beyaz', 'meaning': 'Saflık', 'chakra': 'Taç Çakra'};

    return {
      'mainMessage':
          '$userName, senin aura rengin: ${auraData['color']}! Bu renk ${sign.nameTr} burcunun enerji imzasını taşıyor.',
      'details':
          '🌈 Aura Rengin: ${auraData['color']}\n\n✨ Anlamı: ${auraData['meaning']}\n\n🔮 Bağlı Çakra: ${auraData['chakra']}\n\n💫 Bu renk, ruh halin ve enerji seviyenle değişebilir. Meditasyon ve farkındalık pratiği auranı güçlendirir.',
      'advice':
          'Auranı temizlemek için: Doğada vakit geçir, meditasyon yap, olumsuz enerjilerden uzak dur.',
    };
  }

  static Map<String, String> _getChakraBalanceContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final chakraBalance = {
      zodiac.ZodiacSign.aries: {
        'dominant': 'Kök Çakra',
        'weak': 'Kalp Çakra',
        'balance': 'Şefkati cesaretinle birleştir.',
      },
      zodiac.ZodiacSign.taurus: {
        'dominant': 'Sakral Çakra',
        'weak': 'Boğaz Çakra',
        'balance': 'İhtiyaçlarını ifade et.',
      },
      zodiac.ZodiacSign.gemini: {
        'dominant': 'Boğaz Çakra',
        'weak': 'Kök Çakra',
        'balance': 'Topraklan, yerleş.',
      },
      zodiac.ZodiacSign.cancer: {
        'dominant': 'Sakral Çakra',
        'weak': 'Solar Pleksus',
        'balance': 'Kendi gücünü bul.',
      },
      zodiac.ZodiacSign.leo: {
        'dominant': 'Solar Pleksus',
        'weak': 'Üçüncü Göz',
        'balance': 'Sezgilerini dinle.',
      },
      zodiac.ZodiacSign.virgo: {
        'dominant': 'Üçüncü Göz',
        'weak': 'Sakral Çakra',
        'balance': 'Duyguları hisset.',
      },
      zodiac.ZodiacSign.libra: {
        'dominant': 'Kalp Çakra',
        'weak': 'Solar Pleksus',
        'balance': 'Kendi gücünü sahiplen.',
      },
      zodiac.ZodiacSign.scorpio: {
        'dominant': 'Sakral Çakra',
        'weak': 'Taç Çakra',
        'balance': 'Ruhsal bağlantı kur.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'dominant': 'Taç Çakra',
        'weak': 'Kök Çakra',
        'balance': 'Ayaklarını yere bas.',
      },
      zodiac.ZodiacSign.capricorn: {
        'dominant': 'Kök Çakra',
        'weak': 'Kalp Çakra',
        'balance': 'Sevgiyi kabul et.',
      },
      zodiac.ZodiacSign.aquarius: {
        'dominant': 'Üçüncü Göz',
        'weak': 'Sakral Çakra',
        'balance': 'Duygusal bağlan.',
      },
      zodiac.ZodiacSign.pisces: {
        'dominant': 'Taç Çakra',
        'weak': 'Kök Çakra',
        'balance': 'Topraklan.',
      },
    };

    final chakraData =
        chakraBalance[sign] ??
        {'dominant': 'Kalp', 'weak': 'Kök', 'balance': 'Dengele.'};

    return {
      'mainMessage':
          '$userName, çakra dengen hakkında bilgi! ${sign.nameTr} burcu olarak enerji merkezlerin benzersiz bir desen oluşturuyor.',
      'details':
          '💪 Güçlü Çakran: ${chakraData['dominant']}\nBu çakra doğal olarak aktif ve güçlü.\n\n⚠️ Zayıf Çakran: ${chakraData['weak']}\nBu çakra üzerinde çalışman gerekiyor.\n\n⚖️ Denge İçin:\n${chakraData['balance']}',
      'advice':
          'Her gün 5 dakika çakra meditasyonu yap. Zayıf çakranı güçlendiren renkler giy, o alanla ilgili aktiviteler yap.',
    };
  }

  static Map<String, String> _getLifeNumberContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final lifeNumbers = {
      zodiac.ZodiacSign.aries: {
        'number': '1',
        'meaning': 'Liderlik, bağımsızlık, öncülük',
        'path': 'Kendi yolunu çiz.',
      },
      zodiac.ZodiacSign.taurus: {
        'number': '6',
        'meaning': 'Aile, sorumluluk, uyum',
        'path': 'Güzellik ve sevgi yarat.',
      },
      zodiac.ZodiacSign.gemini: {
        'number': '5',
        'meaning': 'Değişim, özgürlük, macera',
        'path': 'Çeşitliliği kucakla.',
      },
      zodiac.ZodiacSign.cancer: {
        'number': '2',
        'meaning': 'İş birliği, denge, hassasiyet',
        'path': 'Başkalarıyla birlikte çalış.',
      },
      zodiac.ZodiacSign.leo: {
        'number': '1',
        'meaning': 'Yaratıcılık, ifade, liderlik',
        'path': 'Parla ve ilham ver.',
      },
      zodiac.ZodiacSign.virgo: {
        'number': '5',
        'meaning': 'Analiz, hizmet, mükemmellik',
        'path': 'Detaylarda değer bul.',
      },
      zodiac.ZodiacSign.libra: {
        'number': '6',
        'meaning': 'Uyum, güzellik, ilişkiler',
        'path': 'Denge ve barış getir.',
      },
      zodiac.ZodiacSign.scorpio: {
        'number': '9',
        'meaning': 'Dönüşüm, şifa, evrensel aşk',
        'path': 'Karanlıktan ışığa dönüştür.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'number': '3',
        'meaning': 'İfade, iyimserlik, genişleme',
        'path': 'Bilgeliği paylaş.',
      },
      zodiac.ZodiacSign.capricorn: {
        'number': '8',
        'meaning': 'Başarı, güç, materyal denge',
        'path': 'Kalıcı değerler inşa et.',
      },
      zodiac.ZodiacSign.aquarius: {
        'number': '4',
        'meaning': 'Yapı, yenilik, topluluk',
        'path': 'İnsanlık için çalış.',
      },
      zodiac.ZodiacSign.pisces: {
        'number': '7',
        'meaning': 'Spiritüalite, içe bakış, gizem',
        'path': 'Ruhsal derinliği keşfet.',
      },
    };

    final numberData =
        lifeNumbers[sign] ??
        {'number': '1', 'meaning': 'Liderlik', 'path': 'Öncülük yap.'};

    return {
      'mainMessage':
          '$userName, senin yaşam sayın: ${numberData['number']}! ${sign.nameTr} burcunun numerolojik enerjisi bu sayıyla rezonans yapıyor.',
      'details':
          '🔢 Yaşam Sayın: ${numberData['number']}\n\n✨ Anlamı: ${numberData['meaning']}\n\n🛤️ Yaşam Yolun: ${numberData['path']}\n\n💫 Bu sayı, hayat amacın ve ruhsal görevinle ilgili ipuçları veriyor.',
      'advice':
          'Yaşam sayını günlük hayatında kullan: Önemli tarihlerde, kararlarında bu sayının enerjisini hatırla.',
    };
  }

  static Map<String, String> _getKabbalaPathContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final kabbalaPaths = {
      zodiac.ZodiacSign.aries: {
        'path': 'Hod - Netzach',
        'sefira': 'Gevurah (Güç)',
        'lesson': 'Güç ile şefkati dengele.',
      },
      zodiac.ZodiacSign.taurus: {
        'path': 'Netzach - Malkuth',
        'sefira': 'Netzach (Zafer)',
        'lesson': 'Bolluğu madde ötesinde gör.',
      },
      zodiac.ZodiacSign.gemini: {
        'path': 'Tiferet - Binah',
        'sefira': 'Hod (Görkem)',
        'lesson': 'Bilgiyi bilgeliğe dönüştür.',
      },
      zodiac.ZodiacSign.cancer: {
        'path': 'Binah - Chesed',
        'sefira': 'Yesod (Temel)',
        'lesson': 'Duygusal temelleri güçlendir.',
      },
      zodiac.ZodiacSign.leo: {
        'path': 'Chesed - Gevurah',
        'sefira': 'Tiferet (Güzellik)',
        'lesson': 'Cömertlik ve disiplini birleştir.',
      },
      zodiac.ZodiacSign.virgo: {
        'path': 'Tiferet - Hod',
        'sefira': 'Hod (Görkem)',
        'lesson': 'Hizmet ile alçakgönüllülük.',
      },
      zodiac.ZodiacSign.libra: {
        'path': 'Netzach - Hod',
        'sefira': 'Tiferet (Güzellik)',
        'lesson': 'Karşıtlıkları dengele.',
      },
      zodiac.ZodiacSign.scorpio: {
        'path': 'Hod - Yesod',
        'sefira': 'Gevurah (Güç)',
        'lesson': 'Dönüşümün gücünü kullan.',
      },
      zodiac.ZodiacSign.sagittarius: {
        'path': 'Tiferet - Yesod',
        'sefira': 'Chesed (Merhamet)',
        'lesson': 'Bilgeliği cömertçe paylaş.',
      },
      zodiac.ZodiacSign.capricorn: {
        'path': 'Hod - Malkuth',
        'sefira': 'Binah (Anlayış)',
        'lesson': 'Yapı ile anlayışı birleştir.',
      },
      zodiac.ZodiacSign.aquarius: {
        'path': 'Chokmah - Binah',
        'sefira': 'Chokmah (Bilgelik)',
        'lesson': 'İlham ve yapı arasında köprü ol.',
      },
      zodiac.ZodiacSign.pisces: {
        'path': 'Kether - Tiferet',
        'sefira': 'Malkuth (Krallık)',
        'lesson': 'Ruhsal ile maddi olanı birleştir.',
      },
    };

    final kabbalaData =
        kabbalaPaths[sign] ??
        {'path': 'Tiferet', 'sefira': 'Tiferet', 'lesson': 'Denge.'};

    return {
      'mainMessage':
          '$userName, Kabala yolculuğunda senin yerin benzersiz! ${sign.nameTr} burcu olarak Hayat Ağacı\'nda özel bir enerjin var.',
      'details':
          '🌳 Kabala Yolun: ${kabbalaData['path']}\n\n✡️ Bağlı Sefira: ${kabbalaData['sefira']}\n\n📜 Ruhsal Dersin: ${kabbalaData['lesson']}\n\n🔮 Hayat Ağacı\'ndaki bu konum, ruhsal gelişimin için ipuçları veriyor.',
      'advice':
          'Kabala çalışması için: Sefirot meditasyonu yap, Hayat Ağacı\'nı incele, ruhsal öğretmenlere danış.',
    };
  }

  // ═══════════════════════════════════════════════════════════
  // ZAMAN & DÖNGÜLER
  // ═══════════════════════════════════════════════════════════

  static Map<String, String> _getSaturnLessonsContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final saturnLessons = {
      zodiac.ZodiacSign.aries: {
        'lesson': 'Sabır ve Disiplin',
        'challenge': 'Dürtüselliği dizginleme',
        'gift': 'Gerçek liderlik',
      },
      zodiac.ZodiacSign.taurus: {
        'lesson': 'Değişim ve Bırakma',
        'challenge': 'Maddi bağımlılıktan kurtulma',
        'gift': 'Gerçek güvenlik',
      },
      zodiac.ZodiacSign.gemini: {
        'lesson': 'Odaklanma ve Derinlik',
        'challenge': 'Tutarlılık geliştirme',
        'gift': 'Gerçek bilgelik',
      },
      zodiac.ZodiacSign.cancer: {
        'lesson': 'Bağımsızlık ve Sınırlar',
        'challenge': 'Duygusal bağımlılıktan kurtulma',
        'gift': 'Gerçek güç',
      },
      zodiac.ZodiacSign.leo: {
        'lesson': 'Alçakgönüllülük',
        'challenge': 'Ego\'yu dizginleme',
        'gift': 'Gerçek karizma',
      },
      zodiac.ZodiacSign.virgo: {
        'lesson': 'Kabul ve Kusur',
        'challenge': 'Mükemmeliyetçiliği bırakma',
        'gift': 'Gerçek şifa',
      },
      zodiac.ZodiacSign.libra: {
        'lesson': 'Karar ve Bağımsızlık',
        'challenge': 'Kendi ayakları üzerinde durma',
        'gift': 'Gerçek denge',
      },
      zodiac.ZodiacSign.scorpio: {
        'lesson': 'Güven ve Affetme',
        'challenge': 'Kontrolü bırakma',
        'gift': 'Gerçek dönüşüm',
      },
      zodiac.ZodiacSign.sagittarius: {
        'lesson': 'Sorumluluk ve Taahhüt',
        'challenge': 'Yerleşme ve bağlanma',
        'gift': 'Gerçek özgürlük',
      },
      zodiac.ZodiacSign.capricorn: {
        'lesson': 'Duyguları Kabul',
        'challenge': 'Katılıktan kurtulma',
        'gift': 'Gerçek başarı',
      },
      zodiac.ZodiacSign.aquarius: {
        'lesson': 'Bağlanma ve Yakınlık',
        'challenge': 'Duygusal mesafeyi azaltma',
        'gift': 'Gerçek topluluk',
      },
      zodiac.ZodiacSign.pisces: {
        'lesson': 'Gerçekçilik ve Sınırlar',
        'challenge': 'Kaçıştan yüzleşmeye',
        'gift': 'Gerçek spiritüalite',
      },
    };

    final lessonData =
        saturnLessons[sign] ??
        {'lesson': 'Olgunlaşma', 'challenge': 'Büyüme', 'gift': 'Bilgelik'};

    return {
      'mainMessage':
          '$userName, Saturn derslerin hayatını şekillendiriyor! ${sign.nameTr} burcu olarak bu zorluklar seni olgunlaştırıyor.',
      'details':
          '🪐 Saturn Dersin: ${lessonData['lesson']}\n\n⚡ Zorluğun: ${lessonData['challenge']}\n\n🎁 Hediye (Ustalaştığında): ${lessonData['gift']}\n\n⏰ Saturn Dönüşü: 28-30 yaşlarında ve sonra her 29 yılda bir bu dersler yoğunlaşır.',
      'advice':
          'Saturn derslerinden kaçma, onları kucakla. Zorluklar ustalaşınca hediyelere dönüşür.',
      'warning':
          'Saturn derslerini görmezden gelmek, aynı problemlerin tekrar tekrar önüne gelmesine neden olur.',
    };
  }

  static Map<String, String> _getBirthdayEnergyContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, doğum günün kozmik bir yeniden doğuş! ${sign.nameTr} burcu olarak bu özel gün evrensel enerjilerle şarj oluyor.',
      'details':
          '🎂 Doğum Günü Enerjin:\n\n☀️ Solar Dönüş: Güneş doğduğun dereceye geri dönüyor.\n🌟 Yeni Başlangıç: Kişisel yılın başlıyor.\n✨ Manifestasyon Gücü: En güçlü olduğun gün.\n\n🔮 ${sign.nameTr} Doğum Günü Özel:\n${_getBirthdaySpecial(sign)}',
      'advice':
          'Doğum gününde: Niyet belirle, minnettar ol, kendini kutla. Bu gün senin kişisel yeni yılın.',
    };
  }

  static String _getBirthdaySpecial(zodiac.ZodiacSign sign) {
    final specials = {
      zodiac.ZodiacSign.aries:
          'Yeni projeler başlat, cesaretini kutla, risk al.',
      zodiac.ZodiacSign.taurus:
          'Kendinle güzel vakit geçir, duyularını şımartı, doğada ol.',
      zodiac.ZodiacSign.gemini: 'Sosyalleş, iletişim kur, yeni şeyler öğren.',
      zodiac.ZodiacSign.cancer:
          'Ailenle ol, yuvanı kutsa, duygusal bağları güçlendir.',
      zodiac.ZodiacSign.leo: 'Görkemli kutla, yaratıcılığını ifade et, parla.',
      zodiac.ZodiacSign.virgo:
          'Kendine bakım yap, organize ol, minnettarlık yaz.',
      zodiac.ZodiacSign.libra:
          'Güzellikle çevrelen, ilişkileri kutla, uyum ara.',
      zodiac.ZodiacSign.scorpio: 'Derin düşün, dönüşümü kucakla, gizemi kutla.',
      zodiac.ZodiacSign.sagittarius: 'Maceraya çık, öğren, ufkunu genişlet.',
      zodiac.ZodiacSign.capricorn:
          'Hedeflerini belirle, başarını kutla, plan yap.',
      zodiac.ZodiacSign.aquarius:
          'Farklı ol, toplulukla kutla, vizyonunu paylaş.',
      zodiac.ZodiacSign.pisces:
          'Ruhsal pratik yap, sanatla meşgul ol, rüyalarını takip et.',
    };
    return specials[sign] ?? 'Kendini kutla!';
  }

  static Map<String, String> _getEclipseEffectContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, tutulmalar hayatını derinden etkiliyor! ${sign.nameTr} burcu olarak bu kozmik olaylar önemli dönüm noktaları yaratıyor.',
      'details':
          '🌑 Güneş Tutulması: Yeni başlangıçlar, kader kapıları\n🌕 Ay Tutulması: Sonlanmalar, duygusal serbest bırakma\n\n${sign.nameTr} ve Tutulmalar:\n${_getEclipseImpact(sign)}\n\n⏰ Tutulma sezonu yılda 2 kez gelir ve etkileri 6 ay sürebilir.',
      'advice':
          'Tutulma dönemlerinde: Büyük kararları ertele, akışa güven, değişimleri kucakla.',
      'warning': 'Tutulmalar kaotik olabilir. Esnek ol, direnme.',
    };
  }

  static String _getEclipseImpact(zodiac.ZodiacSign sign) {
    final impacts = {
      zodiac.ZodiacSign.aries:
          'Kimlik ve benlik konularında büyük dönüşümler. Kim olduğunu yeniden tanımlıyorsun.',
      zodiac.ZodiacSign.taurus:
          'Değerler ve maddi dünyanda değişimler. Neyin gerçekten önemli olduğunu keşfediyorsun.',
      zodiac.ZodiacSign.gemini:
          'İletişim ve öğrenme alanında dönüşüm. Yeni bilgiler hayatını değiştiriyor.',
      zodiac.ZodiacSign.cancer:
          'Ev ve aile konularında önemli değişiklikler. Köklerin yeniden şekilleniyor.',
      zodiac.ZodiacSign.leo:
          'Yaratıcılık ve kendini ifade alanında dönüşüm. Yeni bir sahne seni bekliyor.',
      zodiac.ZodiacSign.virgo:
          'Sağlık ve günlük rutinlerde değişim. Yeni alışkanlıklar ediniyorsun.',
      zodiac.ZodiacSign.libra:
          'İlişkiler ve ortaklıklarda büyük dönüşüm. Kim seninle yürüyecek netleşiyor.',
      zodiac.ZodiacSign.scorpio:
          'Derin dönüşüm ve yeniden doğuş. Ölüm ve yeniden doğuş teması güçlü.',
      zodiac.ZodiacSign.sagittarius:
          'Felsefe ve uzak yerler alanında değişim. Dünya görüşün genişliyor.',
      zodiac.ZodiacSign.capricorn:
          'Kariyer ve toplumsal rol alanında dönüşüm. Yeni bir statü seni bekliyor.',
      zodiac.ZodiacSign.aquarius:
          'Dostluklar ve topluluk alanında değişim. Yeni bir kabile buluyorsun.',
      zodiac.ZodiacSign.pisces:
          'Spiritüalite ve bilinçaltı alanında dönüşüm. Ruhsal uyanış yaşıyorsun.',
    };
    return impacts[sign] ?? 'Büyük dönüşümler seni bekliyor.';
  }

  static Map<String, String> _getTransitFlowContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, transit akışı hayatının ritmiyle dans ediyor! ${sign.nameTr} burcu olarak gezegensel geçişler seni etkiliyor.',
      'details':
          '🪐 Transit Nedir?\nGezegenler gökyüzünde hareket ederken doğum haritanla etkileşime girer.\n\n${sign.nameTr} İçin Önemli Transitler:\n${_getImportantTransits(sign)}\n\n⏰ Hızlı transitler (Ay, Güneş, Merkür) günlük etki yapar.\n🌟 Yavaş transitler (Saturn, Jupiter) yıllarca sürer.',
      'advice':
          'Transit akışını takip et: Retrolar sırasında dikkatli ol, olumlu transitlerde harekete geç.',
    };
  }

  static String _getImportantTransits(zodiac.ZodiacSign sign) {
    final transits = {
      zodiac.ZodiacSign.aries:
          '• Mars transitlerini takip et - enerji ve aksiyon zamanlaması\n• Jupiter ${sign.nameTr}\'a geçtiğinde şans kapıları açılır',
      zodiac.ZodiacSign.taurus:
          '• Venüs transitlerini takip et - aşk ve para zamanlaması\n• Uranüs etkisi değişim getiriyor',
      zodiac.ZodiacSign.gemini:
          '• Merkür transitlerini takip et - iletişim ve seyahat zamanlaması\n• Merkür retro seni daha çok etkiler',
      zodiac.ZodiacSign.cancer:
          '• Ay transitlerini takip et - duygusal döngüler\n• Dolunay ve yeni ay senin için önemli',
      zodiac.ZodiacSign.leo:
          '• Güneş transitlerini takip et - enerji ve vitalite döngüsü\n• Solar yılın doğum gününde başlar',
      zodiac.ZodiacSign.virgo:
          '• Merkür transitlerini takip et - zihinsel netlik döngüsü\n• Detaylara dikkat gereken zamanlar',
      zodiac.ZodiacSign.libra:
          '• Venüs transitlerini takip et - ilişki ve güzellik döngüsü\n• Venüs retro ilişkileri sorgulat',
      zodiac.ZodiacSign.scorpio:
          '• Pluto transitlerini takip et - derin dönüşüm döngüsü\n• Mars transitleri enerji veriyor',
      zodiac.ZodiacSign.sagittarius:
          '• Jupiter transitlerini takip et - şans ve genişleme döngüsü\n• En şanslı dönemlerin',
      zodiac.ZodiacSign.capricorn:
          '• Saturn transitlerini takip et - yapı ve sorumluluk döngüsü\n• Saturn dönüşleri önemli',
      zodiac.ZodiacSign.aquarius:
          '• Uranüs transitlerini takip et - yenilik ve değişim döngüsü\n• Beklenmedik değişimler',
      zodiac.ZodiacSign.pisces:
          '• Neptün transitlerini takip et - spiritüalite ve hayal döngüsü\n• Jupiter şans getiriyor',
    };
    return transits[sign] ?? 'Gezegen transitlerini takip et.';
  }

  // ═══════════════════════════════════════════════════════════
  // İLİŞKİ ANALİZLERİ
  // ═══════════════════════════════════════════════════════════

  static Map<String, String> _getCompatibilityAnalysisContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, uyum analizi ${sign.nameTr} burcunun ilişkilerdeki potansiyelini gösteriyor!',
      'details':
          '💕 En Uyumlu Burçlar:\n${_getMostCompatible(sign)}\n\n⚡ Zorlu Burçlar:\n${_getChallenging(sign)}\n\n🔮 ${sign.nameTr} İlişkilerde:\n${_getRelationshipStyle(sign)}',
      'advice':
          'Burç uyumu önemli ama tek faktör değil. Doğum haritalarının tamamı karşılaştırılmalı.',
    };
  }

  static String _getMostCompatible(zodiac.ZodiacSign sign) {
    final compatible = {
      zodiac.ZodiacSign.aries:
          '• Aslan: Ateşli tutku, karşılıklı hayranlık\n• Yay: Macera ortakları\n• İkizler: Eğlenceli dinamik',
      zodiac.ZodiacSign.taurus:
          '• Başak: Pratik uyum\n• Oğlak: Aynı değerler\n• Yengeç: Derin duygusal bağ',
      zodiac.ZodiacSign.gemini:
          '• Terazi: Entelektüel uyum\n• Kova: Zihinsel bağlantı\n• Koç: Heyecanlı dinamik',
      zodiac.ZodiacSign.cancer:
          '• Akrep: Duygusal derinlik\n• Balık: Ruhsal bağ\n• Boğa: Güvenli liman',
      zodiac.ZodiacSign.leo:
          '• Koç: Ateşli tutku\n• Yay: Neşeli ortaklık\n• Terazi: Zarif çift',
      zodiac.ZodiacSign.virgo:
          '• Boğa: Güvenilir bağ\n• Oğlak: Amaç birliği\n• Yengeç: Karşılıklı bakım',
      zodiac.ZodiacSign.libra:
          '• İkizler: Zihinsel uyum\n• Kova: Sosyal çift\n• Aslan: Görkemli aşk',
      zodiac.ZodiacSign.scorpio:
          '• Yengeç: Duygusal derinlik\n• Balık: Mistik bağ\n• Oğlak: Kararlı ortaklık',
      zodiac.ZodiacSign.sagittarius:
          '• Koç: Macera dolu\n• Aslan: Neşeli tutku\n• Kova: Özgür ruhlar',
      zodiac.ZodiacSign.capricorn:
          '• Boğa: Güvenilir temel\n• Başak: Amaç birliği\n• Akrep: Derin bağ',
      zodiac.ZodiacSign.aquarius:
          '• İkizler: Zihinsel dans\n• Terazi: Sosyal uyum\n• Yay: Özgür ruhlar',
      zodiac.ZodiacSign.pisces:
          '• Yengeç: Duygusal cennet\n• Akrep: Mistik bağ\n• Boğa: Topraklanmış aşk',
    };
    return compatible[sign] ?? 'Tüm burçlarla potansiyel var.';
  }

  static String _getChallenging(zodiac.ZodiacSign sign) {
    final challenging = {
      zodiac.ZodiacSign.aries:
          '• Yengeç: Farklı hızlar\n• Oğlak: Otorite çatışması',
      zodiac.ZodiacSign.taurus:
          '• Kova: Farklı değerler\n• Aslan: İnatçılık yarışı',
      zodiac.ZodiacSign.gemini:
          '• Başak: Eleştiri sorunu\n• Balık: İletişim zorluğu',
      zodiac.ZodiacSign.cancer:
          '• Koç: Hassasiyet çatışması\n• Terazi: Duygusal farklılık',
      zodiac.ZodiacSign.leo: '• Akrep: Güç savaşı\n• Boğa: İnatçılık çatışması',
      zodiac.ZodiacSign.virgo:
          '• Yay: Detay vs büyük resim\n• İkizler: Tutarsızlık sorunu',
      zodiac.ZodiacSign.libra:
          '• Yengeç: Duygusal farklılık\n• Oğlak: Katılık çatışması',
      zodiac.ZodiacSign.scorpio:
          '• Aslan: Ego çatışması\n• Kova: Duygusal mesafe',
      zodiac.ZodiacSign.sagittarius:
          '• Başak: Spontan vs planlı\n• Balık: Gerçekçilik farkı',
      zodiac.ZodiacSign.capricorn:
          '• Koç: Sabır çatışması\n• Terazi: Kararsızlık sorunu',
      zodiac.ZodiacSign.aquarius:
          '• Boğa: Değişim vs stabilite\n• Akrep: Kontrol çatışması',
      zodiac.ZodiacSign.pisces:
          '• İkizler: İletişim tarzı\n• Yay: Gerçekçilik farkı',
    };
    return challenging[sign] ?? 'Her ilişki çalışma gerektirir.';
  }

  static String _getRelationshipStyle(zodiac.ZodiacSign sign) {
    final styles = {
      zodiac.ZodiacSign.aries:
          'Tutkulu, dinamik, heyecanlı ama bazen baskın olabilir.',
      zodiac.ZodiacSign.taurus:
          'Sadık, duyusal, güvenilir ama sahiplenici olabilir.',
      zodiac.ZodiacSign.gemini:
          'Eğlenceli, meraklı, iletişimci ama tutarsız olabilir.',
      zodiac.ZodiacSign.cancer:
          'Şefkatli, koruyucu, duygusal ama yapışkan olabilir.',
      zodiac.ZodiacSign.leo:
          'Cömert, romantik, sıcak ama dikkat isteyen olabilir.',
      zodiac.ZodiacSign.virgo:
          'Yardımsever, düşünceli, sadık ama eleştirel olabilir.',
      zodiac.ZodiacSign.libra: 'Romantik, uyumlu, zarif ama kararsız olabilir.',
      zodiac.ZodiacSign.scorpio: 'Yoğun, tutkulu, sadık ama kıskanç olabilir.',
      zodiac.ZodiacSign.sagittarius:
          'Maceraperest, eğlenceli, dürüst ama kaçan olabilir.',
      zodiac.ZodiacSign.capricorn:
          'Güvenilir, kararlı, sadık ama mesafeli olabilir.',
      zodiac.ZodiacSign.aquarius: 'Özgün, arkadaşça, özgür ama uzak olabilir.',
      zodiac.ZodiacSign.pisces:
          'Romantik, empatik, fedakar ama kaçan olabilir.',
    };
    return styles[sign] ?? 'Benzersiz bir ilişki tarzın var.';
  }

  static Map<String, String> _getRelationshipKarmaContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    return {
      'mainMessage':
          '$userName, ilişkilerdeki karma kalıpların geçmişten bugüne seni etkiliyor. ${sign.nameTr} burcu olarak öğrenmen gereken dersler var.',
      'details':
          '♾️ Karma Kalıbın:\n${_getKarmaPattern(sign)}\n\n🔄 Tekrarlayan Tema:\n${_getRepeatingTheme(sign)}\n\n🌟 İyileştirme Yolu:\n${_getHealingPath(sign)}',
      'advice':
          'Karma kalıplarını kırmak için: Farkındalık geliştir, farklı seçimler yap, geçmişi affet.',
      'warning': 'Aynı tip insanları çekiyorsan, kendi enerji frekansına bak.',
    };
  }

  static String _getKarmaPattern(zodiac.ZodiacSign sign) {
    final patterns = {
      zodiac.ZodiacSign.aries:
          'Bağımsızlık vs bağlanma çatışması. Geçmiş yaşamlarda savaşçı enerjisi.',
      zodiac.ZodiacSign.taurus:
          'Sahiplenme ve kaybetme korkusu. Maddi güvenlik karması.',
      zodiac.ZodiacSign.gemini:
          'İletişim karması. Sözlerin gücü ve tutarsızlık dersleri.',
      zodiac.ZodiacSign.cancer:
          'Aile karması. Anne-çocuk dinamikleri ve korumacılık.',
      zodiac.ZodiacSign.leo:
          'Ego ve alçakgönüllülük karması. Krallık ve hizmet dengesi.',
      zodiac.ZodiacSign.virgo:
          'Mükemmeliyetçilik karması. Hizmet ve değer görme dengesi.',
      zodiac.ZodiacSign.libra:
          'İlişki karması. Bağımlılık ve bağımsızlık dersleri.',
      zodiac.ZodiacSign.scorpio:
          'Güç ve kontrol karması. İhanet ve güven dersleri.',
      zodiac.ZodiacSign.sagittarius:
          'Özgürlük karması. Taahhüt ve sorumluluk dersleri.',
      zodiac.ZodiacSign.capricorn:
          'Başarı karması. İş ve ilişki dengesi dersleri.',
      zodiac.ZodiacSign.aquarius:
          'Bağlanma karması. Bireysellik ve topluluk dersleri.',
      zodiac.ZodiacSign.pisces:
          'Kurban karması. Sınırlar ve fedakarlık dersleri.',
    };
    return patterns[sign] ?? 'Karma kalıplar temizleniyor.';
  }

  static String _getRepeatingTheme(zodiac.ZodiacSign sign) {
    final themes = {
      zodiac.ZodiacSign.aries:
          'Benzer otoritelerle çatışma, terk edilme veya terk etme.',
      zodiac.ZodiacSign.taurus:
          'Maddi güvensizlik yaratan ilişkiler, kaybetme korkusu.',
      zodiac.ZodiacSign.gemini: 'İletişim kopuklukları, yanlış anlaşılmalar.',
      zodiac.ZodiacSign.cancer:
          'Bakım veren/alan dinamikleri, duygusal bağımlılık.',
      zodiac.ZodiacSign.leo: 'Onay arayışı, görmezden gelinme hissi.',
      zodiac.ZodiacSign.virgo:
          'Eleştirilme, değersizlik hissi, mükemmeliyetçilik.',
      zodiac.ZodiacSign.libra: 'Dengesiz ilişkiler, tek taraflı fedakarlık.',
      zodiac.ZodiacSign.scorpio:
          'İhanet, güven kırılması, yoğun-toksik ilişkiler.',
      zodiac.ZodiacSign.sagittarius: 'Kaçış, taahhütten kaçınma, sıkılma.',
      zodiac.ZodiacSign.capricorn: 'İşe gömülme, duygusal uzaklık, kontrol.',
      zodiac.ZodiacSign.aquarius:
          'Duygusal mesafe, anlaşılmamak, yabancılaşma.',
      zodiac.ZodiacSign.pisces: 'Kurtarıcı/kurban dinamiği, sınır ihlalleri.',
    };
    return themes[sign] ?? 'Tekrarlayan temalar netleşiyor.';
  }

  static String _getHealingPath(zodiac.ZodiacSign sign) {
    final paths = {
      zodiac.ZodiacSign.aries:
          'Bağımsızlık ve bağlanmanın bir arada olabileceğini öğren.',
      zodiac.ZodiacSign.taurus: 'Gerçek güvenliğin içeriden geldiğini keşfet.',
      zodiac.ZodiacSign.gemini: 'Sözlerinin gücünü anla, tutarlılık geliştir.',
      zodiac.ZodiacSign.cancer: 'Sağlıklı sınırlarla sevmeyi öğren.',
      zodiac.ZodiacSign.leo:
          'İçsel değerini keşfet, onay bağımlılığından kurtul.',
      zodiac.ZodiacSign.virgo: 'Kusursuzluğun var olmadığını kabul et.',
      zodiac.ZodiacSign.libra: 'Kendi ayakların üzerinde durmayı öğren.',
      zodiac.ZodiacSign.scorpio: 'Güvenmeyi ve affetmeyi öğren.',
      zodiac.ZodiacSign.sagittarius: 'Kalmanın da bir macera olduğunu keşfet.',
      zodiac.ZodiacSign.capricorn:
          'İlişkilerin de yatırım gerektirdiğini anla.',
      zodiac.ZodiacSign.aquarius: 'Yakınlığın özgürlüğü engellemediğini gör.',
      zodiac.ZodiacSign.pisces: 'Sınırların sevginin düşmanı olmadığını öğren.',
    };
    return paths[sign] ?? 'İyileşme yolculuğuna devam et.';
  }

  static Map<String, String> _getCelebrityTwinContent(
    zodiac.ZodiacSign sign,
    String userName,
  ) {
    final celebrities = {
      zodiac.ZodiacSign.aries: {
        'names': 'Lady Gaga, Robert Downey Jr., Emma Watson',
        'trait': 'Cesaret ve liderlik',
      },
      zodiac.ZodiacSign.taurus: {
        'names': 'Adele, George Clooney, Gigi Hadid',
        'trait': 'Kararlılık ve güzellik',
      },
      zodiac.ZodiacSign.gemini: {
        'names': 'Angelina Jolie, Johnny Depp, Kendall Jenner',
        'trait': 'Çok yönlülük ve çekicilik',
      },
      zodiac.ZodiacSign.cancer: {
        'names': 'Selena Gomez, Tom Hanks, Ariana Grande',
        'trait': 'Duygusal derinlik',
      },
      zodiac.ZodiacSign.leo: {
        'names': 'Jennifer Lopez, Barack Obama, Kylie Jenner',
        'trait': 'Karizma ve liderlik',
      },
      zodiac.ZodiacSign.virgo: {
        'names': 'Beyoncé, Keanu Reeves, Zendaya',
        'trait': 'Mükemmeliyetçilik ve çalışkanlık',
      },
      zodiac.ZodiacSign.libra: {
        'names': 'Kim Kardashian, Will Smith, Bella Hadid',
        'trait': 'Estetik ve diplomasi',
      },
      zodiac.ZodiacSign.scorpio: {
        'names': 'Leonardo DiCaprio, Ryan Gosling, Katy Perry',
        'trait': 'Yoğunluk ve manyetizma',
      },
      zodiac.ZodiacSign.sagittarius: {
        'names': 'Taylor Swift, Brad Pitt, Miley Cyrus',
        'trait': 'Özgürlük ve iyimserlik',
      },
      zodiac.ZodiacSign.capricorn: {
        'names': 'Michelle Obama, Timothée Chalamet, Kate Middleton',
        'trait': 'Disiplin ve başarı',
      },
      zodiac.ZodiacSign.aquarius: {
        'names': 'Oprah Winfrey, Harry Styles, Jennifer Aniston',
        'trait': 'Özgünlük ve vizyonerlik',
      },
      zodiac.ZodiacSign.pisces: {
        'names': 'Rihanna, Justin Bieber, Olivia Rodrigo',
        'trait': 'Yaratıcılık ve sezgi',
      },
    };

    final celebData =
        celebrities[sign] ??
        {'names': 'Benzersiz ünlüler', 'trait': 'Benzersiz özellikler'};

    return {
      'mainMessage':
          '$userName, senin ünlü ikizlerin var! ${sign.nameTr} burcu olarak bu ünlülerle ortak özellikler taşıyorsun.',
      'details':
          '⭐ Ünlü İkizlerin:\n${celebData['names']}\n\n✨ Ortak Özellik:\n${celebData['trait']}\n\n🎭 Bu ünlüler seninle aynı güneş burcunu paylaşıyor. Benzer enerjiler, benzer yetenekler, benzer zorluklar.',
      'advice':
          'Ünlü ikizlerinden ilham al ama kendi benzersiz yolunu çiz. Sen de bir yıldızsın!',
    };
  }
}

// _CosmicBackgroundPainter removed - using CosmicBackground widget instead
