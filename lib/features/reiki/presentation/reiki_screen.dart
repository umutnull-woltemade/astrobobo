import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Reiki Screen - Evrensel Yaşam Enerjisi Şifası
/// Enerji kanallarını açma ve şifa pratiği
class ReikiScreen extends StatefulWidget {
  const ReikiScreen({super.key});

  @override
  State<ReikiScreen> createState() => _ReikiScreenState();
}

class _ReikiScreenState extends State<ReikiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isDark),
              _buildTabBar(isDark),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPrinciplesTab(isDark),
                    _buildChakrasTab(isDark),
                    _buildPracticeTab(isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🙏', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        Text(
                          'Reiki',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textDark,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Evrensel Yaşam Enerjisi',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFFF7043).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: const Color(0xFFFF7043).withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              'Reiki, Japonca "evrensel yaşam enerjisi" anlamına gelir. Ellerin üzerinden akan bu enerji, bedenin doğal şifa mekanizmalarını aktive eder ve enerji bloklarını çözer. Stres azaltma, rahatlama ve bütünsel iyileşme sağlar.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isDark ? Colors.white70 : AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildTabBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: isDark ? const Color(0xFFFF7043) : const Color(0xFFE64A19),
        unselectedLabelColor: isDark ? Colors.white60 : AppColors.textLight,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: isDark
              ? const Color(0xFFFF7043).withValues(alpha: 0.2)
              : const Color(0xFFE64A19).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'İlkeler'),
          Tab(text: 'Çakralar'),
          Tab(text: 'Pratik'),
        ],
      ),
    );
  }

  Widget _buildPrinciplesTab(bool isDark) {
    final principles = [
      _ReikiPrinciple(
        japanese: 'Kyo dake wa',
        turkish: 'Sadece bugün için',
        description:
            'Şimdiki ana odaklan. Geçmiş gitmiştir, gelecek henüz gelmedi. Sadece bugün kontrol edebilirsin.',
        icon: '☀️',
        color: const Color(0xFFFFD700),
      ),
      _ReikiPrinciple(
        japanese: 'Ikaru na',
        turkish: 'Kızma',
        description:
            'Öfke enerjini tüketir ve sağlığına zarar verir. Duygularını kabul et ama bırak gitsinler.',
        icon: '🔥',
        color: const Color(0xFFFF5722),
      ),
      _ReikiPrinciple(
        japanese: 'Shinpai suna',
        turkish: 'Endişelenme',
        description:
            'Endişe, olmamış şeylere enerji vermektir. Güven ve teslimiyetle yaşa.',
        icon: '🌊',
        color: const Color(0xFF2196F3),
      ),
      _ReikiPrinciple(
        japanese: 'Kansha shite',
        turkish: 'Minnettar ol',
        description:
            'Şükran, en yüksek titreşimlerden biridir. Her şeyde bir nimet bul.',
        icon: '💚',
        color: const Color(0xFF4CAF50),
      ),
      _ReikiPrinciple(
        japanese: 'Gyo wo hageme',
        turkish: 'İşini dürüstçe yap',
        description:
            'Ne iş yaparsan yap, bütünlük ve özveriyle yap. Hayatına anlam kat.',
        icon: '⭐',
        color: const Color(0xFF9C27B0),
      ),
      _ReikiPrinciple(
        japanese: 'Hito ni shinsetsu ni',
        turkish: 'Herkese nazik ol',
        description:
            'Şefkat ve nezaket evrensel şifa enerjileridir. Kendin dahil herkese nazik ol.',
        icon: '💕',
        color: const Color(0xFFE91E63),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(
                        0xFFFF7043,
                      ).withValues(alpha: isDark ? 0.2 : 0.1),
                      const Color(
                        0xFFFFD700,
                      ).withValues(alpha: isDark ? 0.1 : 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                ),
                child: Column(
                  children: [
                    const Text('五戒', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 8),
                    Text(
                      'Gokai - Beş İlke',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mikao Usui\'nin öğretileri',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white60 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms)
              .scale(begin: const Offset(0.95, 0.95)),
          const SizedBox(height: AppConstants.spacingLg),
          ...principles.asMap().entries.map((entry) {
            return _buildPrincipleCard(entry.value, isDark)
                .animate(delay: (100 * entry.key).ms)
                .fadeIn(duration: 400.ms)
                .slideX(begin: 0.05);
          }),
          const SizedBox(height: AppConstants.spacingXl),
          const PageFooterWithDisclaimer(
            brandText: 'Reiki — Venus One',
            disclaimerText: DisclaimerTexts.astrology,
          ),
        ],
      ),
    );
  }

  Widget _buildChakrasTab(bool isDark) {
    final chakras = [
      _ChakraInfo(
        name: 'Kök Çakra',
        sanskrit: 'Muladhara',
        location: 'Omurga tabanı',
        color: const Color(0xFFE53935),
        icon: '🔴',
        attributes: ['Güvenlik', 'Topraklama', 'Hayatta kalma'],
        reikiPosition: 'Elleri kalça kemiklerinin üzerine koy',
      ),
      _ChakraInfo(
        name: 'Sakral Çakra',
        sanskrit: 'Svadhisthana',
        location: 'Göbek altı',
        color: const Color(0xFFFF9800),
        icon: '🟠',
        attributes: ['Yaratıcılık', 'Cinsellik', 'Duygular'],
        reikiPosition: 'Elleri göbek altına koy',
      ),
      _ChakraInfo(
        name: 'Güneş Sinir Ağı',
        sanskrit: 'Manipura',
        location: 'Mide bölgesi',
        color: const Color(0xFFFFEB3B),
        icon: '🟡',
        attributes: ['Özgüven', 'İrade gücü', 'Kişisel güç'],
        reikiPosition: 'Elleri mide bölgesine koy',
      ),
      _ChakraInfo(
        name: 'Kalp Çakra',
        sanskrit: 'Anahata',
        location: 'Göğüs ortası',
        color: const Color(0xFF4CAF50),
        icon: '💚',
        attributes: ['Sevgi', 'Şefkat', 'Affetme'],
        reikiPosition: 'Elleri göğsün ortasına koy',
      ),
      _ChakraInfo(
        name: 'Boğaz Çakra',
        sanskrit: 'Vishuddha',
        location: 'Boğaz',
        color: const Color(0xFF03A9F4),
        icon: '🔵',
        attributes: ['İletişim', 'Kendini ifade', 'Gerçek'],
        reikiPosition: 'Elleri boğazın iki yanına koy',
      ),
      _ChakraInfo(
        name: 'Üçüncü Göz',
        sanskrit: 'Ajna',
        location: 'Kaşlar arası',
        color: const Color(0xFF3F51B5),
        icon: '🟣',
        attributes: ['Sezgi', 'İç görü', 'Bilgelik'],
        reikiPosition: 'Elleri alına koy',
      ),
      _ChakraInfo(
        name: 'Taç Çakra',
        sanskrit: 'Sahasrara',
        location: 'Baş tepesi',
        color: const Color(0xFF9C27B0),
        icon: '👑',
        attributes: ['Ruhsal bağlantı', 'Aydınlanma', 'Birlik'],
        reikiPosition: 'Elleri başın tepesine koy',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      itemCount: chakras.length,
      itemBuilder: (context, index) {
        return _buildChakraCard(
          chakras[index],
          isDark,
        ).animate(delay: (80 * index).ms).fadeIn(duration: 400.ms);
      },
    );
  }

  Widget _buildPracticeTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPracticeSection(
            title: 'Öz-Reiki Pratiği',
            icon: '🙌',
            steps: [
              'Rahat bir pozisyonda otur veya uzan',
              'Gözlerini kapat ve birkaç derin nefes al',
              'Niyetini belirle: "Şifa enerjisine açılıyorum"',
              'Ellerini başının tepesine koy (3-5 dk)',
              'Ellerini gözlerinin üzerine koy (3-5 dk)',
              'Ellerini boğazına koy (3-5 dk)',
              'Ellerini kalbinin üzerine koy (3-5 dk)',
              'Ellerini güneş sinir ağına koy (3-5 dk)',
              'Ellerini göbek altına koy (3-5 dk)',
              'Minnetle bitir',
            ],
            color: const Color(0xFFFF7043),
            isDark: isDark,
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPracticeSection(
            title: 'Günlük Enerji Temizliği',
            icon: '🌊',
            steps: [
              'Sabah uyandığında ellerini ov',
              'Ellerinin ısındığını ve enerjinin aktığını hisset',
              'Ellerini auranın etrafında gezdirerek enerji alanını temizle',
              'Negatif enerjiyi yere bırak',
              'Pozitif niyetlerle güne başla',
            ],
            color: const Color(0xFF2196F3),
            isDark: isDark,
          ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingLg),
          _buildPracticeSection(
            title: 'Uzaktan Reiki',
            icon: '🌍',
            steps: [
              'Şifa göndereceğin kişiden izin al (zihinsel olarak)',
              'Kişiyi veya durumu gözünde canlandır',
              'Hon Sha Ze Sho Nen sembolünü çiz (varsa)',
              'Sevgi ve şifa niyetini gönder',
              'Enerjinin ulaştığını hisset',
              'Minnetle bitir',
            ],
            color: const Color(0xFF9C27B0),
            isDark: isDark,
          ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: AppConstants.spacingLg),
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Reiki uyumlanması için bir Reiki ustasıyla çalışmanız önerilir. Bu pratikler, uyumlanmış olmasanız da enerji farkındalığı geliştirmenize yardımcı olabilir.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: isDark ? Colors.white70 : AppColors.textLight,
                    ),
                  ),
                ),
              ],
            ),
          ).animate(delay: 300.ms).fadeIn(duration: 500.ms),
          const SizedBox(height: AppConstants.spacingXl),
        ],
      ),
    );
  }

  Widget _buildPrincipleCard(_ReikiPrinciple principle, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            principle.color.withValues(alpha: isDark ? 0.15 : 0.08),
            principle.color.withValues(alpha: isDark ? 0.08 : 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: principle.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(principle.icon, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      principle.japanese,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: principle.color,
                      ),
                    ),
                    Text(
                      principle.turkish,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            principle.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white70 : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChakraCard(_ChakraInfo chakra, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: chakra.color.withValues(alpha: 0.3)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingSm,
        ),
        childrenPadding: const EdgeInsets.only(
          left: AppConstants.spacingLg,
          right: AppConstants.spacingLg,
          bottom: AppConstants.spacingLg,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: chakra.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Center(
            child: Text(chakra.icon, style: const TextStyle(fontSize: 22)),
          ),
        ),
        title: Text(
          chakra.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isDark ? Colors.white : AppColors.textDark,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              chakra.sanskrit,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: chakra.color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '• ${chakra.location}',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white60 : AppColors.textLight,
              ),
            ),
          ],
        ),
        children: [
          // Attributes
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chakra.attributes.map((attr) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: chakra.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  attr,
                  style: TextStyle(
                    fontSize: 12,
                    color: chakra.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          // Reiki position
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: chakra.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Row(
              children: [
                const Text('🙌', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reiki Pozisyonu',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: chakra.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chakra.reikiPosition,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeSection({
    required String title,
    required String icon,
    required List<String> steps,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: isDark ? 0.15 : 0.08),
            color.withValues(alpha: isDark ? 0.08 : 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...steps.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: isDark ? Colors.white : AppColors.textDark,
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
}

class _ReikiPrinciple {
  final String japanese;
  final String turkish;
  final String description;
  final String icon;
  final Color color;

  _ReikiPrinciple({
    required this.japanese,
    required this.turkish,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _ChakraInfo {
  final String name;
  final String sanskrit;
  final String location;
  final Color color;
  final String icon;
  final List<String> attributes;
  final String reikiPosition;

  _ChakraInfo({
    required this.name,
    required this.sanskrit,
    required this.location,
    required this.color,
    required this.icon,
    required this.attributes,
    required this.reikiPosition,
  });
}
