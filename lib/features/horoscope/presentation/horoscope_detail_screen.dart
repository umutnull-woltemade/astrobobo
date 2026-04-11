import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/models/extended_horoscope.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/extended_horoscope_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/ad_banner_widget.dart';
import '../../../shared/widgets/interpretive_text.dart';
import '../../../shared/widgets/constellation_widget.dart';
import '../../../shared/widgets/page_bottom_navigation.dart';
import '../../../shared/widgets/breadcrumb_navigation.dart';
import '../../../shared/widgets/faq_section.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/energy_bar.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

class HoroscopeDetailScreen extends ConsumerStatefulWidget {
  final String signName;

  const HoroscopeDetailScreen({super.key, required this.signName});

  @override
  ConsumerState<HoroscopeDetailScreen> createState() =>
      _HoroscopeDetailScreenState();
}

class _HoroscopeDetailScreenState extends ConsumerState<HoroscopeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ZodiacSign _sign;
  // Cache expensive computations
  late WeeklyHoroscope _weeklyHoroscope;
  late MonthlyHoroscope _monthlyHoroscope;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _sign = ZodiacSign.values.firstWhere(
      (s) => s.name.toLowerCase() == widget.signName.toLowerCase(),
      orElse: () => ZodiacSign.aries,
    );
    // Generate horoscopes once during initialization
    _weeklyHoroscope = ExtendedHoroscopeService.generateWeeklyHoroscope(
      _sign,
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
    );
    _monthlyHoroscope = ExtendedHoroscopeService.generateMonthlyHoroscope(
      _sign,
      DateTime.now().month,
      DateTime.now().year,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horoscope = ref.watch(dailyHoroscopeProvider(_sign));

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, _sign),
              // Tab Bar
              _buildTabBar(context),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Daily Tab
                    _buildDailyContent(context, horoscope, _sign),
                    // Weekly Tab
                    _buildWeeklyContent(context, _weeklyHoroscope, _sign),
                    // Monthly Tab
                    _buildMonthlyContent(context, _monthlyHoroscope, _sign),
                    // Sign Info Tab
                    _buildSignInfoContent(context, _sign),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: _sign.color.withAlpha(60),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        labelColor: _sign.color,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Günlük'),
          Tab(text: 'Haftalık'),
          Tab(text: 'Aylık'),
          Tab(text: 'Burç'),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 300.ms);
  }

  Widget _buildDailyContent(
    BuildContext context,
    dynamic horoscope,
    ZodiacSign sign,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI-QUOTABLE: İlk 3 Bullet (Kısa Cevap)
          _buildQuotableBullets(context, sign, horoscope),
          const SizedBox(height: AppConstants.spacingLg),
          // Date and luck
          _buildDateSection(context, horoscope.luckRating),
          const SizedBox(height: AppConstants.spacingMd),
          // Daily Energy Bar
          DailyEnergyCard.fromLuckRating(
            horoscope.luckRating,
            accentColor: sign.color,
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Main horoscope
          _buildMainHoroscope(context, horoscope.summary, sign),
          const SizedBox(height: AppConstants.spacingXl),
          // Categories
          _buildCategoryCard(
            context,
            'Aşk & İlişkiler',
            Icons.favorite,
            horoscope.loveAdvice,
            AppColors.fireElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Kariyer & Finans',
            Icons.work,
            horoscope.careerAdvice,
            AppColors.earthElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Sağlık & İyilik',
            Icons.spa,
            horoscope.healthAdvice,
            AppColors.airElement,
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Quick facts
          _buildQuickFacts(
            context,
            horoscope.mood,
            horoscope.luckyColor,
            horoscope.luckyNumber,
            sign,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // Kadim Not - Astroloji bilgeliği
          KadimNotCard(
            title: 'Göksel Senkronizasyon',
            content:
                'Kozmik enerjiler rastgele hareket etmez. Bugün ${sign.nameTr} burcuna gelen titreşimler, evrenin senin için hazırladığı bir mesajdır. Bu mesajı almak için önce durmalı, sonra dinlemelisin.',
            category: KadimCategory.astrology,
            source: 'Hermetik Öğreti',
            compact: true,
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // Ad Banner
          const InlineAdBanner(),
          const SizedBox(height: AppConstants.spacingXl),
          // Next Blocks - Sonraki öneriler
          const NextBlocks(currentPage: 'horoscope_detail'),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation
          PageBottomNavigation(
            currentRoute: '/horoscope/${_sign.name.toLowerCase()}',
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // AI-QUOTABLE: Footer with Disclaimer
          const PageFooterWithDisclaimer(
            brandText: 'Astroloji — Venus One',
            disclaimerText: DisclaimerTexts.astrology,
          ),
          const SizedBox(height: AppConstants.spacingMd),
        ],
      ),
    );
  }

  /// AI-QUOTABLE: İlk 3 bullet - direkt cevap
  Widget _buildQuotableBullets(
    BuildContext context,
    ZodiacSign sign,
    dynamic horoscope,
  ) {
    final bullets = _getQuotableBullets(sign, horoscope);
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: sign.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: sign.color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Burç Çözümlemelerin',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: sign.color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...bullets.map(
            (bullet) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 7),
                    decoration: BoxDecoration(
                      color: sign.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AutoGlossaryText(
                      text: bullet,
                      enableHighlighting: true,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  List<String> _getQuotableBullets(ZodiacSign sign, dynamic horoscope) {
    // Generate 3 AI-quotable bullets based on sign and horoscope
    final Map<ZodiacSign, List<String>> signBullets = {
      ZodiacSign.aries: [
        'Bugün enerjin yüksek, inisiyatif almak için uygun.',
        'Sabırsızlık tuzağına düşmemeye dikkat et.',
        'Akşam saatlerinde önemli bir haber gelebilir.',
      ],
      ZodiacSign.taurus: [
        'Bugün maddi konularda netlik kazanabilirsin.',
        'Rutinlerine sadık kal, değişiklik şimdilik bekleyebilir.',
        'Sevdiklerinle kaliteli zaman geçirmek için ideal bir gün.',
      ],
      ZodiacSign.gemini: [
        'İletişim becerilerin bugün ön planda.',
        'Ertelediğin konuşmaları yapmak için uygun.',
        'Zihnin hızlı çalışıyor, notlar almayı unutma.',
      ],
      ZodiacSign.cancer: [
        'Duygusal olarak hassas bir gün geçirebilirsin.',
        'Ev ve aile konuları ön plana çıkıyor.',
        'Sezgilerine güven, seni doğru yönlendirecekler.',
      ],
      ZodiacSign.leo: [
        'Bugün dikkat çekmek için ekstra çaba harcamana gerek yok.',
        'Yaratıcı projeler için ilham alabilirsin.',
        'Liderlik vasıfların takdir görecek.',
      ],
      ZodiacSign.virgo: [
        'Detaylara odaklanman gereken bir gün.',
        'Sağlık rutinlerini gözden geçirmek için uygun.',
        'Eleştirel bakış açını yapıcı tutmaya dikkat et.',
      ],
      ZodiacSign.libra: [
        'İlişkilerde denge arayışın bugün öne çıkıyor.',
        'Estetik kararlar almak için uygun bir gün.',
        'Ortaklık konularında ilerleme kaydedebilirsin.',
      ],
      ZodiacSign.scorpio: [
        'Bugün derin düşüncelere dalabilirsin.',
        'Gizli kalmış bir konu gün yüzüne çıkabilir.',
        'Dönüşüm enerjisi güçlü, eski kalıpları bırakmak için uygun.',
      ],
      ZodiacSign.sagittarius: [
        'Macera ruhu bugün canlanıyor.',
        'Yeni bir şey öğrenmek için harika bir gün.',
        'Uzak yerlerden haberler gelebilir.',
      ],
      ZodiacSign.capricorn: [
        'Kariyer hedeflerin için somut adımlar atabilirsin.',
        'Disiplinli yaklaşımın bugün meyvelerini verecek.',
        'Uzun vadeli planlar yapmak için uygun.',
      ],
      ZodiacSign.aquarius: [
        'Özgün fikirlerinle fark yaratabilirsin.',
        'Grup aktiviteleri ve arkadaşlıklar ön planda.',
        'Teknoloji ile ilgili konularda şans senden yana.',
      ],
      ZodiacSign.pisces: [
        'Sezgilerin bugün özellikle güçlü.',
        'Sanatsal ve spiritüel aktiviteler için ideal.',
        'Rüyalarına dikkat et, önemli mesajlar taşıyabilirler.',
      ],
    };
    return signBullets[sign] ??
        [
          'Bugün kozmik enerjiler seninle.',
          'İç sesine kulak ver.',
          'Yeni fırsatlar kapıda.',
        ];
  }

  Widget _buildWeeklyContent(
    BuildContext context,
    WeeklyHoroscope horoscope,
    ZodiacSign sign,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week range
          _buildWeekHeader(context, horoscope),
          const SizedBox(height: AppConstants.spacingXl),
          // Overview
          _buildWeeklyOverview(context, horoscope.overview, sign),
          const SizedBox(height: AppConstants.spacingMd),
          // Categories
          _buildCategoryCard(
            context,
            'Aşk & İlişkiler',
            Icons.favorite,
            horoscope.loveWeek,
            AppColors.fireElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Kariyer & Finans',
            Icons.work,
            horoscope.careerWeek,
            AppColors.earthElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Sağlık & Enerji',
            Icons.spa,
            horoscope.healthWeek,
            AppColors.airElement,
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Key Dates
          _buildKeyDatesStringSection(context, horoscope.keyDates, sign),
          const SizedBox(height: AppConstants.spacingMd),
          // Affirmation
          _buildAffirmationCard(context, horoscope.weeklyAffirmation, sign),
          const SizedBox(height: AppConstants.spacingLg),
          const InlineAdBanner(),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation (compact)
          PageBottomNavigationCompact(
            currentRoute: '/horoscope/${sign.name.toLowerCase()}',
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyContent(
    BuildContext context,
    MonthlyHoroscope horoscope,
    ZodiacSign sign,
  ) {
    final months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month header
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: sign.color.withAlpha(20),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: sign.color),
                    const SizedBox(width: AppConstants.spacingSm),
                    Text(
                      '${months[horoscope.month - 1]} ${horoscope.year}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: sign.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < horoscope.overallRating
                          ? Icons.star
                          : Icons.star_border,
                      size: 16,
                      color: AppColors.starGold,
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Overview
          _buildWeeklyOverview(context, horoscope.overview, sign),
          const SizedBox(height: AppConstants.spacingMd),
          // Lucky Days
          _buildLuckyDaysSection(context, horoscope.luckyDays, sign),
          const SizedBox(height: AppConstants.spacingMd),
          // Categories
          _buildCategoryCard(
            context,
            'Aşk & İlişkiler',
            Icons.favorite,
            horoscope.loveMonth,
            AppColors.fireElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Kariyer & Finans',
            Icons.work,
            horoscope.careerMonth,
            AppColors.earthElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Sağlık & Enerji',
            Icons.spa,
            horoscope.healthMonth,
            AppColors.airElement,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildCategoryCard(
            context,
            'Ruhsal Rehberlik',
            Icons.auto_awesome,
            horoscope.spiritualGuidance,
            AppColors.auroraStart,
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Key Transits
          _buildKeyTransitsSection(context, horoscope.keyTransits, sign),
          const SizedBox(height: AppConstants.spacingMd),
          // Monthly Mantra
          _buildAffirmationCard(context, horoscope.monthlyMantra, sign),
          const SizedBox(height: AppConstants.spacingLg),
          const InlineAdBanner(),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation (compact)
          PageBottomNavigationCompact(
            currentRoute: '/horoscope/${sign.name.toLowerCase()}',
          ),
        ],
      ),
    );
  }

  Widget _buildSignInfoContent(BuildContext context, ZodiacSign sign) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb Navigation
          BreadcrumbNavigation.zodiacSign(sign.nameTr, sign.symbol),
          const SizedBox(height: AppConstants.spacingMd),
          _buildSignInfo(context, sign),
          const SizedBox(height: AppConstants.spacingLg),
          // Deep Interpretation Card
          DeepInterpretationCard(
            title: '${sign.nameTr} Burcunun Derinliği',
            summary: _getSignSummary(sign),
            deepInterpretation: _getSignDeepInterpretation(sign),
            icon: Icons.auto_stories,
            accentColor: sign.color,
            relatedTerms: [
              sign.nameTr,
              sign.element.nameTr,
              sign.modality.nameTr,
              sign.rulingPlanet,
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // FAQ Section for this zodiac sign
          FaqSection.zodiacSign(sign.nameTr),
          const SizedBox(height: AppConstants.spacingLg),
          const InlineAdBanner(),
          const SizedBox(height: AppConstants.spacingXl),
          // Back-Button-Free Navigation
          PageBottomNavigation(
            currentRoute: '/horoscope/${sign.name.toLowerCase()}',
          ),
        ],
      ),
    );
  }

  String _getSignSummary(ZodiacSign sign) {
    final summaries = {
      ZodiacSign.aries:
          '[[Koç]] burcu, [[Zodyak]]\'ın ilk işaretidir ve [[Kardinal]] [[Ateş]] enerjisini taşır. [[Mars]] tarafından yönetilir ve aksiyona, liderliğe ve yeni başlangıçlara yönelik güçlü bir dürtüye sahiptir.',
      ZodiacSign.taurus:
          '[[Boğa]] burcu, [[Sabit]] [[Toprak]] enerjisiyle istikrar ve güvenliği temsil eder. [[Venüs]] yönetiminde, güzellik, değer ve maddi konfor temel motivasyonlardır.',
      ZodiacSign.gemini:
          '[[İkizler]] burcu, [[Değişken]] [[Hava]] enerjisiyle iletişim ve zekâyı temsil eder. [[Merkür]] yönetiminde, öğrenme ve bilgi paylaşımı hayati öneme sahiptir.',
      ZodiacSign.cancer:
          '[[Yengeç]] burcu, [[Kardinal]] [[Su]] enerjisiyle duygusal derinliği ve koruyuculuğu temsil eder. [[Ay]] yönetiminde, ev ve aile en önemli temalardır.',
      ZodiacSign.leo:
          '[[Aslan]] burcu, [[Sabit]] [[Ateş]] enerjisiyle yaratıcılığı ve özgür iradeyi temsil eder. [[Güneş]] yönetiminde, kendini ifade etme ve parlamak doğal eğiliminizdir.',
      ZodiacSign.virgo:
          '[[Başak]] burcu, [[Değişken]] [[Toprak]] enerjisiyle analiz ve hizmeti temsil eder. [[Merkür]] yönetiminde, detaylar ve mükemmellik önemlidir.',
      ZodiacSign.libra:
          '[[Terazi]] burcu, [[Kardinal]] [[Hava]] enerjisiyle denge ve ilişkileri temsil eder. [[Venüs]] yönetiminde, uyum ve estetik temel değerlerdir.',
      ZodiacSign.scorpio:
          '[[Akrep]] burcu, [[Sabit]] [[Su]] enerjisiyle dönüşüm ve yoğunluğu temsil eder. [[Pluto]] yönetiminde, derinlik ve güç temaları ön plandadır.',
      ZodiacSign.sagittarius:
          '[[Yay]] burcu, [[Değişken]] [[Ateş]] enerjisiyle macera ve felsefeyi temsil eder. [[Jüpiter]] yönetiminde, genişleme ve anlam arayışı doğal halinizdir.',
      ZodiacSign.capricorn:
          '[[Oğlak]] burcu, [[Kardinal]] [[Toprak]] enerjisiyle başarı ve disiplini temsil eder. [[Satürn]] yönetiminde, yapı ve sorumluluk temel değerleridir.',
      ZodiacSign.aquarius:
          '[[Kova]] burcu, [[Sabit]] [[Hava]] enerjisiyle yenilik ve insanlığı temsil eder. [[Uranüs]] yönetiminde, özgürlük ve ilerleme en önemli temalardır.',
      ZodiacSign.pisces:
          '[[Balık]] burcu, [[Değişken]] [[Su]] enerjisiyle spiritüalite ve sezgiyi temsil eder. [[Neptün]] yönetiminde, hayal gücü ve empati güçlü yanlarınızdır.',
    };
    return summaries[sign] ?? 'Bu burç hakkında detaylı bilgi yükleniyor...';
  }

  String _getSignDeepInterpretation(ZodiacSign sign) {
    final interpretations = {
      ZodiacSign.aries:
          '''[[Koç]] burcu, [[Zodyak]] çemberinin başlangıç noktasında yer alır ve "Ben varım" ilkesini temsil eder. [[İlkbahar ekinoksu]] ile başlayan bu dönem, doğadaki yeniden doğuş ve büyüme enerjisini yansıtır.

[[Mars]] gezegeninin yönetiminde, Koçlar aksiyona yöneliktir. [[1. Ev]] ile doğal ilişkileri, kimlik, fiziksel görünüm ve dünyaya nasıl yaklaşıldığını belirler. [[Ateş]] elementi cesaret ve tutkuyu, [[Kardinal]] nitelik ise liderlik ve inisiyatifi sağlar.

Evrimsel astrolojide, Koç [[Ruhsal yolculuk]]un başlangıcını temsil eder. Ego'nun gelişimi ve bireyselleşme sürecinin ilk adımlarını atar. [[Gölge]] yönleri ise sabırsızlık ve düşünmeden hareket etme eğilimidir.

Koç burcundaki gezegenler genellikle hızlı, direkt ve rekabetçi bir enerji sergiler. [[Mars]] [[Retro]]sü dönemlerinde, bu enerjiyi içsel motivasyona yönlendirmek faydalıdır.''',

      ZodiacSign.taurus:
          '''[[Boğa]] burcu, [[Zodyak]]'ın ikinci işaretidir ve "Ben sahip olurum" ilkesini temsil eder. [[Toprak]] elementinin en istikrarlı formu olan Boğa, değerleri ve kaynakları yönetir.

[[Venüs]] gezegeninin yönetiminde, Boğalar duyusal deneyimlere ve güzelliğe derin bir takdir gösterir. [[2. Ev]] ile doğal ilişkileri, öz-değer, maddi kaynaklar ve yetenekleri kapsar.

[[Sabit]] niteliği, Boğa'ya dayanıklılık ve kararlılık verir. Bir kere başlanan projeler tamamlanana kadar devam eder. Ancak bu aynı zamanda [[Gölge]] yönü olan inatçılığa da yol açabilir.

Boğa burcundaki gezegenler yavaş ama kararlı bir enerji sergiler. [[Venüs]] geçişleri, özellikle Boğa ve [[Terazi]] burçları için önemli dönemleri işaret eder.''',

      ZodiacSign.gemini:
          '''[[İkizler]] burcu, "Ben düşünürüm" ilkesini temsil eder ve [[Zodyak]]'ın ilk [[Hava]] işaretidir. [[Merkür]] yönetiminde, zihinsel çeviklik ve iletişim yetenekleri güçlüdür.

[[3. Ev]] ile doğal ilişkileri, yakın çevre, kardeşler, kısa yolculuklar ve temel iletişimi kapsar. [[Değişken]] niteliği, uyum sağlama ve esneklik yeteneği verir.

İkizler'in [[Dualite]] sembolizmi - ikiz kardeşler - zihnin iki yönünü temsil eder: rasyonel ve sezgisel. Bu enerji bazen dağınıklık olarak algılansa da aslında çoklu bakış açılarını görme yeteneğidir.

[[Merkür Retro]]su dönemleri İkizler için özellikle önemlidir. Bu zamanlar iç gözlem ve geçmişe bakış için değerlidir. [[Gölge]] yönü ise yüzeysellik ve kararsızlıktır.''',

      ZodiacSign.cancer:
          '''[[Yengeç]] burcu, [[Zodyak]]'ın dördüncü işaretidir ve [[Su]] elementinin [[Kardinal]] formunu temsil eder. "Ben hissederim" ilkesiyle duygusal zekâ ve sezgiyi somutlaştırır.

[[Ay]] yönetiminde, Yengeçler duygusal derinlik ve koruyucu içgüdüler sergiler. [[4. Ev]] ile doğal ilişkileri, ev, aile kökleri, iç dünya ve duygusal güvenliği kapsar.

[[Anne arketipi]] Yengeç ile güçlü bir şekilde rezonans eder. Besleyici enerji ve bakım yeteneği doğal olarak gelişmiştir. [[Ay fazları]] Yengeç burçluları için özellikle etkilidir.

[[Gölge]] yönleri ise aşırı koruyuculuk, duygusal manipülasyon ve geçmişe takılı kalma eğilimleridir. [[Duygusal sınırlar]] koymayı öğrenmek evrimsel görevdir.''',

      ZodiacSign.leo:
          '''[[Aslan]] burcu, [[Zodyak]]'ın beşinci işaretidir ve [[Ateş]] elementinin [[Sabit]] formunu temsil eder. "Ben yaratırım" ilkesiyle öz-ifade ve yaratıcılık merkezdedir.

[[Güneş]] bu burcun yöneticisidir ve "evindedir" - en güçlü hali. [[5. Ev]] ile doğal ilişkileri yaratıcılık, romantizm, çocuklar ve eğlenceyi kapsar. [[Kalp çakrası]] Aslan ile güçlü bir şekilde bağlantılıdır.

Aslan'ın dramaya ve sahneye olan çekimi, ruhsal bir ihtiyaçtan kaynaklanır: görülmek ve değerli hissetmek. Bu bir ego meselesi değil, [[Güneş]]'in doğal ifadesidir.

[[Gölge]] yönleri ise kibirlilik, aşırı gurur ve başkalarının ışığını görmezden gelme eğilimidir. Alçakgönüllülük ve paylaşma, evrimsel yolculukta geliştirilecek niteliklerdir.''',

      ZodiacSign.virgo:
          '''[[Başak]] burcu, [[Zodyak]]'ın altıncı işaretidir ve [[Toprak]] elementinin [[Değişken]] formunu temsil eder. "Ben analiz ederim" ilkesiyle hizmet ve mükemmellik arayışı merkezdedir.

[[Merkür]] yönetiminde, Başak analitik zekâ ve detay odaklılık sergiler. [[6. Ev]] ile doğal ilişkileri, sağlık, günlük rutinler, hizmet ve iş ortamını kapsar.

Başak'ın mükemmeliyetçilik eğilimi, aslında [[Kutsal hizmet]] kavramından gelir - işini en iyi şekilde yapma arzusu. [[Şifacılık]] yetenekleri genellikle güçlüdür.

[[Gölge]] yönleri ise aşırı eleştirel olma, endişe ve kendini aşağılamadır. Özünü kabul etme ve kusursuzluk baskısından kurtulma evrimsel görevdir.''',

      ZodiacSign.libra:
          '''[[Terazi]] burcu, [[Zodyak]]'ın yedinci işaretidir ve [[Hava]] elementinin [[Kardinal]] formunu temsil eder. "Ben dengelerim" ilkesiyle ilişki ve uyum merkezdedir.

[[Venüs]] yönetiminde, Terazi estetik duyarlılık ve sosyal zerafet sergiler. [[7. Ev]] ile doğal ilişkileri, ortaklıklar, evlilik ve "öteki" kavramını kapsar.

Terazi'nin denge arayışı, aslında [[Kozmik adalet]] kavramından gelir. [[Projeksiyon]] mekanizmasını anlamak bu burç için önemlidir - başkalarında gördüklerimiz bize aittir.

[[Güneş]] bu burçta "düşüştedir" - bireysellik temaları zorlayıcı olabilir. [[Gölge]] yönleri ise kararsızlık, pasif-agresif davranışlar ve çatışmadan kaçınma. Öz-kimlik geliştirme evrimsel görevdir.''',

      ZodiacSign.scorpio:
          '''[[Akrep]] burcu, [[Zodyak]]'ın sekizinci işaretidir ve [[Su]] elementinin [[Sabit]] formunu temsil eder. "Ben dönüştürürüm" ilkesiyle derinlik ve güç merkezdedir.

[[Pluto]] (modern) ve [[Mars]] (geleneksel) yönetiminde, Akrep yoğun duygusal derinlik ve penetratif zekâ sergiler. [[8. Ev]] ile doğal ilişkileri, paylaşılan kaynaklar, cinsellik, ölüm-yeniden doğuş ve psikolojik dönüşümü kapsar.

Akrep'in yoğunluğu, aslında [[Ruhsal simya]] - kurşunu altına çevirme arzusundan gelir. [[Kundalini]] enerjisi bu burçla güçlü bir şekilde ilişkilidir.

[[Gölge]] yönleri ise kıskançlık, obsesyon, intikam ve kontrol ihtiyacıdır. Bırakma ve güvenme, evrimsel yolculukta en önemli derslerdir.''',

      ZodiacSign.sagittarius:
          '''[[Yay]] burcu, [[Zodyak]]'ın dokuzuncu işaretidir ve [[Ateş]] elementinin [[Değişken]] formunu temsil eder. "Ben keşfederim" ilkesiyle özgürlük ve anlam arayışı merkezdedir.

[[Jüpiter]] yönetiminde, Yay iyimserlik, cömertlik ve genişleme enerjisi sergiler. [[9. Ev]] ile doğal ilişkileri, uzun yolculuklar, yüksek öğrenim, felsefe ve inanç sistemlerini kapsar.

Yay'ın okçu sembolizmi - ok ve yay - hedeflere yönelik vizyonu ve yüksek idealleri temsil eder. [[Centaur]] mitolojisi, insan ve hayvan doğasının birleşmesini simgeler.

[[Gölge]] yönleri ise aşırı iyimserlik, dağınıklık, sorumsuzluk ve vaatleri tutamama. Derinleşme ve taahhüt, evrimsel görevlerdir.''',

      ZodiacSign.capricorn:
          '''[[Oğlak]] burcu, [[Zodyak]]'ın onuncu işaretidir ve [[Toprak]] elementinin [[Kardinal]] formunu temsil eder. "Ben başarırım" ilkesiyle disiplin ve sorumluluk merkezdedir.

[[Satürn]] yönetiminde, Oğlak yapı, zaman ve olgunluk temaları ile çalışır. [[10. Ev]] ile doğal ilişkileri, kariyer, toplumsal statü, itibar ve [[Baba arketipi]]ni kapsar.

Oğlak'ın dağ keçisi sembolizmi, zorlu zirvelere tırmanma ve hedefe ulaşma kararlılığını temsil eder. Zaman bu burcun müttefikidir - yaş ile bilgelik ve başarı artar.

[[Satürn Dönüşü]] (yaklaşık her 29 yılda bir) Oğlaklar için özellikle anlamlıdır. [[Gölge]] yönleri ise katılık, pesimizm ve aşırı ciddiyet. Neşe ve esneklik, evrimsel görevlerdir.''',

      ZodiacSign.aquarius:
          '''[[Kova]] burcu, [[Zodyak]]'ın onbirinci işaretidir ve [[Hava]] elementinin [[Sabit]] formunu temsil eder. "Ben bilirim" ilkesiyle yenilik ve insanlık merkezdedir.

[[Uranüs]] (modern) ve [[Satürn]] (geleneksel) yönetiminde, Kova devrimci fikirler ve toplumsal bilinç ile çalışır. [[11. Ev]] ile doğal ilişkileri, gruplar, dostluklar, umutlar ve insani idealleri kapsar.

Kova'nın su taşıyıcısı sembolizmi, bilgeliğin insanlığa dağıtılmasını temsil eder. [[Kolektif bilinç]] ve geleceğe yönelik vizyon bu burçla güçlü bir şekilde ilişkilidir.

[[Gölge]] yönleri ise duygusal mesafe, aşırı entelektüalizm ve "herkes için" düşünürken bireyleri ihmal etme. Duygusal yakınlık, evrimsel görevdir.''',

      ZodiacSign.pisces:
          '''[[Balık]] burcu, [[Zodyak]]'ın onikinci ve son işaretidir ve [[Su]] elementinin [[Değişken]] formunu temsil eder. "Ben inanırım" ilkesiyle spiritüalite ve transendans merkezdedir.

[[Neptün]] (modern) ve [[Jüpiter]] (geleneksel) yönetiminde, Balık mistisizm, empati ve kozmik bilinç ile çalışır. [[12. Ev]] ile doğal ilişkileri, bilinçdışı, spiritüel pratikler, inziva ve [[Karmik]] temalar kapsar.

Balık'ın iki balık sembolizmi - zıt yönlere yüzen - maddi ve spiritüel dünyalar arasındaki gerilimi temsil eder. [[Kolektif bilinçaltı]]'na doğrudan erişim bu burcun armağanıdır.

[[Gölge]] yönleri ise kaçış eğilimleri (bağımlılık), sınır yokluğu ve kurban zihniyeti. Sağlıklı sınırlar ve gerçeklikle bağlantı evrimsel görevlerdir.''',
    };
    return interpretations[sign] ?? 'Burç yorumu yükleniyor...';
  }

  Widget _buildWeekHeader(BuildContext context, WeeklyHoroscope horoscope) {
    final weekEnd = horoscope.weekStart.add(const Duration(days: 6));
    final format = DateFormat('d MMM', 'tr');

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: _sign.color.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.date_range, color: _sign.color),
              const SizedBox(width: AppConstants.spacingSm),
              Text(
                '${format.format(horoscope.weekStart)} - ${format.format(weekEnd)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _sign.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < horoscope.overallRating
                    ? Icons.star
                    : Icons.star_border,
                size: 16,
                color: AppColors.starGold,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyDatesStringSection(
    BuildContext context,
    List<String> keyDates,
    ZodiacSign sign,
  ) {
    if (keyDates.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event_note, color: sign.color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Önemli Günler',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: sign.color),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...keyDates.take(3).map((keyDate) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: sign.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  Expanded(
                    child: Text(
                      keyDate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverview(
    BuildContext context,
    String overview,
    ZodiacSign sign,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [sign.color.withAlpha(15), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: sign.color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: sign.color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Kozmik Enerjin',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: sign.color),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            overview,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLuckyDaysSection(
    BuildContext context,
    List<String> luckyDays,
    ZodiacSign sign,
  ) {
    if (luckyDays.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.starGold.withAlpha(20),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.starGold.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: AppColors.starGold, size: 20),
              const SizedBox(width: 8),
              Text(
                'Şanslı Günler',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: luckyDays.map((day) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withAlpha(30),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  day,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.starGold),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyTransitsSection(
    BuildContext context,
    String keyTransits,
    ZodiacSign sign,
  ) {
    if (keyTransits.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withAlpha(30),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.route, color: sign.color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Önemli Transitler',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: sign.color),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            keyTransits,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAffirmationCard(
    BuildContext context,
    String affirmation,
    ZodiacSign sign,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [sign.color.withAlpha(30), AppColors.starGold.withAlpha(20)],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: sign.color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: sign.color, size: 28),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            affirmation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Haftanın Olumlaması',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ZodiacSign sign) {
    // AI-QUOTABLE HEADER - Soru formatı
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingLg,
        vertical: AppConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [sign.color.withValues(alpha: 0.25), Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Back button row
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppColors.textPrimary,
                onPressed: () => context.pop(),
                visualDensity: VisualDensity.compact,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.share),
                color: AppColors.textPrimary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Bu özellik yakında eklenecek ✨'),
                      backgroundColor: AppColors.starGold,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),
          // Symbol + Question H1
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sign.color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: sign.color.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ConstellationWidget(
                  sign: sign,
                  size: 36,
                  color: sign.color,
                  showGlow: true,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // H1 - Soru formatı (AI-quotable)
                    Text(
                      '${sign.nameTr} burcu bugün nasıl?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Brand tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: sign.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Astroloji',
                        style: TextStyle(
                          fontSize: 11,
                          color: sign.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(BuildContext context, int luckRating) {
    final today = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d').format(today);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Günün Yorumu',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              dateStr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Şans Oranı',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < luckRating ? Icons.star : Icons.star_border,
                  size: 18,
                  color: AppColors.starGold,
                );
              }),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }

  Widget _buildMainHoroscope(
    BuildContext context,
    String summary,
    ZodiacSign sign,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [sign.color.withValues(alpha: 0.15), AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: sign.color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: sign.color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Günün Kozmik Enerjin',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: sign.color),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              height: 1.8,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    String content,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          AutoGlossaryText(
            text: content,
            enableHighlighting: true,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildQuickFacts(
    BuildContext context,
    String mood,
    String luckyColor,
    String luckyNumber,
    ZodiacSign sign,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Günün Kozmik İpuçları',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Row(
            children: [
              Expanded(
                child: _QuickFactItem(
                  icon: Icons.mood,
                  label: 'Ruh Hali',
                  value: mood,
                  color: sign.color,
                ),
              ),
              Expanded(
                child: _QuickFactItem(
                  icon: Icons.palette,
                  label: 'Şanslı Renk',
                  value: luckyColor,
                  color: sign.color,
                ),
              ),
              Expanded(
                child: _QuickFactItem(
                  icon: Icons.tag,
                  label: 'Şanslı Sayı',
                  value: luckyNumber,
                  color: sign.color,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 400.ms);
  }

  Widget _buildSignInfo(BuildContext context, ZodiacSign sign) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${sign.nameTr} Burcu Sırları',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: sign.color),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            sign.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoTag(
                label: sign.element.name,
                icon: null,
                color: sign.element.color,
              ),
              _InfoTag(
                label: sign.modality.name,
                icon: null,
                color: sign.color,
              ),
              _InfoTag(
                label: 'Yönetici: ${sign.rulingPlanetTr}',
                icon: null,
                color: AppColors.starGold,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            'Ruhsal İmza',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sign.traits.map((trait) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: sign.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trait,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: sign.color),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 400.ms);
  }
}

class _QuickFactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _QuickFactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _InfoTag extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;

  const _InfoTag({required this.label, this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
