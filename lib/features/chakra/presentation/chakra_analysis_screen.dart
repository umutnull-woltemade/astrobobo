import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/next_blocks.dart';
import '../../../shared/widgets/kadim_not_card.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Chakra Analysis Screen - Personalized chakra reading based on natal chart
class ChakraAnalysisScreen extends ConsumerStatefulWidget {
  const ChakraAnalysisScreen({super.key});

  @override
  ConsumerState<ChakraAnalysisScreen> createState() =>
      _ChakraAnalysisScreenState();
}

class _ChakraAnalysisScreenState extends ConsumerState<ChakraAnalysisScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ChakraAnalysisData? _analysisData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAnalysis();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAnalysis() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final userProfile = ref.read(userProfileProvider);
    final sunSign = userProfile?.sunSign ?? ZodiacSign.aries;

    setState(() {
      _analysisData = ChakraAnalysisService.generate(sunSign);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context),
              if (_isLoading)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: AppColors.starGold,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Chakra enerjin analiz ediliyor...',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildChakraVisualization(context),
                      _buildTabBar(context),
                      _buildTabContent(context),
                      const SizedBox(height: AppConstants.spacingLg),
                      // Kadim Not - Chakra bilgeliği
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingLg,
                        ),
                        child: KadimNotCard(
                          title: 'Enerji Döngüsü',
                          content:
                              'Chakralar yalnızca enerji merkezleri değil, bilinç kapılarıdır. Her chakra, fiziksel bedenle ruhsal beden arasında bir köprüdür. Onları dengelemek, sadece sağlık değil - içsel uyanışın anahtarıdır.',
                          category: KadimCategory.chakra,
                          source: 'Tantrik Bilgelik',
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Next Blocks - keşfetmeye devam et
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingLg,
                        ),
                        child: const NextBlocks(currentPage: 'chakra'),
                      ),
                      const SizedBox(height: AppConstants.spacingXl),
                      // Entertainment Disclaimer
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingLg,
                        ),
                        child: PageFooterWithDisclaimer(
                          brandText: 'Chakra — Venus One',
                          disclaimerText: DisclaimerTexts.chakra,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingLg),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.starGold,
              const Color(0xFFFFE082),
              AppColors.starGold,
            ],
          ).createShader(bounds),
          child: const Text(
            'Chakra Analizi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.cosmicPurple.withValues(alpha: 0.3),
                Colors.transparent,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.self_improvement,
              size: 60,
              color: AppColors.starGold.withValues(alpha: 0.2),
            ),
          ),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildChakraVisualization(BuildContext context) {
    if (_analysisData == null) return const SizedBox.shrink();

    return Container(
      height: 420,
      margin: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF1A1A2E), const Color(0xFF16213E)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cosmicPurple.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cosmicPurple.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow
          Container(
            width: 250,
            height: 380,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.cosmicPurple.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Spine line
          Positioned(
            child: Container(
              width: 6,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.cosmicPurple,
                    const Color(0xFF3F51B5),
                    const Color(0xFF03A9F4),
                    const Color(0xFF4CAF50),
                    const Color(0xFFFFEB3B),
                    const Color(0xFFFF9800),
                    const Color(0xFFE53935),
                  ],
                ),
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 700.ms).slideY(begin: -0.2),
          ),
          // Chakra points
          ...List.generate(7, (index) {
            final chakra = _analysisData!.chakras[6 - index];
            final yPosition = 30.0 + (index * 50);
            return Positioned(
              top: yPosition,
              child: _buildChakraPoint(context, chakra)
                  .animate(delay: Duration(milliseconds: index * 100))
                  .fadeIn()
                  .scale(begin: const Offset(0.5, 0.5)),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildChakraPoint(BuildContext context, ChakraData chakra) {
    final size = 32 + (chakra.balance * 18);

    return GestureDetector(
      onTap: () => _showChakraDetail(context, chakra),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chakra name
          SizedBox(
            width: 110,
            child: Text(
              chakra.nameTr,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Chakra orb
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [chakra.color, chakra.color.withValues(alpha: 0.7)],
              ),
              boxShadow: [
                BoxShadow(
                  color: chakra.color.withValues(alpha: 0.6),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${(chakra.balance * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Status indicator
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:
                  (chakra.balance > 0.7
                          ? Colors.green
                          : chakra.balance < 0.4
                          ? Colors.red
                          : Colors.orange)
                      .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  chakra.balance > 0.7
                      ? Icons.arrow_upward
                      : chakra.balance < 0.4
                      ? Icons.arrow_downward
                      : Icons.remove,
                  color: chakra.balance > 0.7
                      ? Colors.green
                      : chakra.balance < 0.4
                      ? Colors.red
                      : Colors.orange,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  chakra.balance > 0.7
                      ? 'Aktif'
                      : chakra.balance < 0.4
                      ? 'Bloklu'
                      : 'Dengeli',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChakraDetail(BuildContext context, ChakraData chakra) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF1A1A2E), const Color(0xFF0D0D1A)],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(
            color: chakra.color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with chakra orb
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                chakra.color,
                                chakra.color.withValues(alpha: 0.7),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: chakra.color.withValues(alpha: 0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              chakra.symbol,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chakra.nameTr,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                chakra.sanskritName,
                                style: TextStyle(
                                  color: chakra.color,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Balance indicator
                    _buildBalanceIndicator(context, chakra),
                    const SizedBox(height: 24),

                    // Description
                    _buildDetailSection(
                      context,
                      icon: Icons.info_outline,
                      title: 'Hakkında',
                      content: chakra.description,
                    ),

                    // Physical connection
                    _buildDetailSection(
                      context,
                      icon: Icons.favorite_outline,
                      title: 'Fiziksel Bağlantılar',
                      content: chakra.physicalConnection,
                    ),

                    // Emotional aspects
                    _buildDetailSection(
                      context,
                      icon: Icons.psychology_outlined,
                      title: 'Duygusal Yönler',
                      content: chakra.emotionalAspects,
                    ),

                    // Healing suggestions
                    _buildHealingSuggestions(context, chakra),

                    // Affirmation
                    _buildAffirmationCard(context, chakra),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceIndicator(BuildContext context, ChakraData chakra) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: chakra.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: chakra.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Denge Durumu',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
              ),
              Text(
                '${(chakra.balance * 100).toInt()}%',
                style: TextStyle(
                  color: chakra.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: chakra.balance,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(chakra.color),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            chakra.balanceMessage,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.starGold, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealingSuggestions(BuildContext context, ChakraData chakra) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.spa_outlined, color: Colors.green.shade400, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Dengeleme Onerileri',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...chakra.healingSuggestions.map(
            (suggestion) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: chakra.color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      suggestion,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Crystals
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chakra.crystals
                .map(
                  (crystal) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: chakra.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: chakra.color.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      crystal,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAffirmationCard(BuildContext context, ChakraData chakra) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            chakra.color.withValues(alpha: 0.25),
            chakra.color.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: chakra.color.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: chakra.color, size: 28),
          const SizedBox(height: 8),
          Text(
            chakra.affirmation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: AppColors.cosmicPurple.withValues(alpha: 0.3),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.cosmicPurple, AppColors.mysticBlue],
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Çakra Haritası'),
          Tab(text: 'Meditasyon'),
          Tab(text: 'Günlük'),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    if (_analysisData == null) return const SizedBox.shrink();

    return SizedBox(
      height: 520,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(context),
          _buildMeditationTab(context),
          _buildDailyTab(context),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.starGold, const Color(0xFFFFE082)],
            ).createShader(bounds),
            child: Text(
              'Chakra Profilin',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _analysisData!.overallAnalysis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // Strongest chakra
          _buildChakraHighlight(
            context,
            title: 'En Güçlü Çakran',
            chakra: _analysisData!.strongestChakra,
            color: Colors.green,
          ),
          const SizedBox(height: 16),

          // Needs attention
          _buildChakraHighlight(
            context,
            title: 'Dikkat Gerektiren',
            chakra: _analysisData!.needsAttention,
            color: Colors.orange,
          ),
          const SizedBox(height: 24),

          // Tips
          Text(
            'Genel Oneriler',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ..._analysisData!.generalTips.map(
            (tip) => _buildTipCard(context, tip),
          ),
        ],
      ),
    );
  }

  Widget _buildChakraHighlight(
    BuildContext context, {
    required String title,
    required ChakraData chakra,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [chakra.color, chakra.color.withValues(alpha: 0.7)],
              ),
              boxShadow: [
                BoxShadow(
                  color: chakra.color.withValues(alpha: 0.4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                chakra.symbol,
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                Text(
                  chakra.nameTr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${(chakra.balance * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(color: AppColors.starGold.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: AppColors.starGold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.starGold, const Color(0xFFFFE082)],
            ).createShader(bounds),
            child: Text(
              'Chakra Meditasyonlari',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._analysisData!.meditations.map(
            (meditation) => _buildMeditationCard(context, meditation),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard(
    BuildContext context,
    ChakraMeditation meditation,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF1A1A2E), const Color(0xFF16213E)],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: meditation.chakra.color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  meditation.chakra.color.withValues(alpha: 0.3),
                  meditation.chakra.color.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        meditation.chakra.color,
                        meditation.chakra.color.withValues(alpha: 0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: meditation.chakra.color.withValues(alpha: 0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      meditation.chakra.symbol,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meditation.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${meditation.duration} dakika',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: meditation.chakra.color.withValues(alpha: 0.5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.play_circle_fill,
                      color: meditation.chakra.color,
                      size: 45,
                    ),
                    onPressed: () {
                      // Start meditation
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Text(
              meditation.description,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.starGold, const Color(0xFFFFE082)],
            ).createShader(bounds),
            child: Text(
              'Bugunun Chakra Enerjisi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _analysisData!.dailyFocus.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // Focus chakra
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _analysisData!.dailyFocus.focusChakra.color.withValues(
                    alpha: 0.25,
                  ),
                  _analysisData!.dailyFocus.focusChakra.color.withValues(
                    alpha: 0.1,
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: _analysisData!.dailyFocus.focusChakra.color.withValues(
                  alpha: 0.4,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _analysisData!.dailyFocus.focusChakra.color,
                        _analysisData!.dailyFocus.focusChakra.color.withValues(
                          alpha: 0.7,
                        ),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _analysisData!.dailyFocus.focusChakra.color
                            .withValues(alpha: 0.5),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _analysisData!.dailyFocus.focusChakra.symbol,
                      style: const TextStyle(fontSize: 36, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bugun ${_analysisData!.dailyFocus.focusChakra.nameTr} Chakrana Odaklan',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _analysisData!.dailyFocus.focusReason,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Daily activities
          Text(
            'Onerilen Aktiviteler',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ..._analysisData!.dailyFocus.activities.map(
            (activity) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                border: Border.all(
                  color: _analysisData!.dailyFocus.focusChakra.color.withValues(
                    alpha: 0.2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getActivityIcon(activity),
                    color: _analysisData!.dailyFocus.focusChakra.color,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      activity,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
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

  IconData _getActivityIcon(String activity) {
    if (activity.toLowerCase().contains('meditasyon'))
      return Icons.self_improvement;
    if (activity.toLowerCase().contains('yoga')) return Icons.sports_gymnastics;
    if (activity.toLowerCase().contains('nefes')) return Icons.air;
    if (activity.toLowerCase().contains('yuru')) return Icons.directions_walk;
    if (activity.toLowerCase().contains('su')) return Icons.water_drop;
    if (activity.toLowerCase().contains('yaz')) return Icons.edit_note;
    return Icons.circle_outlined;
  }
}

// ============== Data Models ==============

class ChakraAnalysisData {
  final List<ChakraData> chakras;
  final ChakraData strongestChakra;
  final ChakraData needsAttention;
  final String overallAnalysis;
  final List<String> generalTips;
  final List<ChakraMeditation> meditations;
  final DailyChakraFocus dailyFocus;

  ChakraAnalysisData({
    required this.chakras,
    required this.strongestChakra,
    required this.needsAttention,
    required this.overallAnalysis,
    required this.generalTips,
    required this.meditations,
    required this.dailyFocus,
  });
}

class ChakraData {
  final String name;
  final String nameTr;
  final String sanskritName;
  final String symbol;
  final Color color;
  final double balance;
  final String description;
  final String physicalConnection;
  final String emotionalAspects;
  final String balanceMessage;
  final List<String> healingSuggestions;
  final List<String> crystals;
  final String affirmation;

  ChakraData({
    required this.name,
    required this.nameTr,
    required this.sanskritName,
    required this.symbol,
    required this.color,
    required this.balance,
    required this.description,
    required this.physicalConnection,
    required this.emotionalAspects,
    required this.balanceMessage,
    required this.healingSuggestions,
    required this.crystals,
    required this.affirmation,
  });
}

class ChakraMeditation {
  final ChakraData chakra;
  final String title;
  final String description;
  final int duration;

  ChakraMeditation({
    required this.chakra,
    required this.title,
    required this.description,
    required this.duration,
  });
}

class DailyChakraFocus {
  final ChakraData focusChakra;
  final String description;
  final String focusReason;
  final List<String> activities;

  DailyChakraFocus({
    required this.focusChakra,
    required this.description,
    required this.focusReason,
    required this.activities,
  });
}

// ============== Service ==============

class ChakraAnalysisService {
  static ChakraAnalysisData generate(ZodiacSign sign) {
    final chakras = _generateChakras(sign);
    final strongest = chakras.reduce((a, b) => a.balance > b.balance ? a : b);
    final weakest = chakras.reduce((a, b) => a.balance < b.balance ? a : b);

    return ChakraAnalysisData(
      chakras: chakras,
      strongestChakra: strongest,
      needsAttention: weakest,
      overallAnalysis: _getOverallAnalysis(sign, strongest, weakest),
      generalTips: _getGeneralTips(sign),
      meditations: _getMeditations(chakras),
      dailyFocus: _getDailyFocus(chakras),
    );
  }

  static List<ChakraData> _generateChakras(ZodiacSign sign) {
    // Base balances influenced by zodiac element
    final element = _getElement(sign);
    final baseBalances = _getElementBalances(element);

    return [
      ChakraData(
        name: 'Root',
        nameTr: 'Kök Çakrası',
        sanskritName: 'Muladhara',
        symbol: 'LAM',
        color: const Color(0xFFE53935),
        balance: baseBalances[0],
        description:
            'Muladhara - "Kök Destek" - 4 yapraklı kırmızı lotus olarak sembolize edilir. '
            'Omurganın tabanında yer alan bu çakra, hayatta kalma içgüdüleri, güvenlik, '
            'topraklanma ve maddi dünya ile bağlantını temsil eder. Toprak elementi ile ilişkilidir. '
            'Atalarından gelen enerji burada saklanır. Dengeli olduğunda güvenli ve istikrarlı hissedersin.',
        physicalConnection: 'Bacaklar, ayaklar, kemikler, bağışıklık sistemi',
        emotionalAspects: 'Güvenlik hissi, istikrar, temel ihtiyaçlar',
        balanceMessage: baseBalances[0] > 0.7
            ? 'Güçlü bir temele sahipsin, kendini güvenli hissediyorsun.'
            : baseBalances[0] < 0.4
            ? 'Topraklanmaya ihtiyacın var. Doğada zaman geçir.'
            : 'Dengeleniyor - düzenli pratikle güçlendir.',
        healingSuggestions: [
          'Çıplak ayakla yerde yürü',
          'Kırmızı renkli yiyecekler tüket',
          'Ağaç sarılma meditasyonu yap',
        ],
        crystals: ['Kırmızı Jasper', 'Siyah Turmalin', 'Hematit'],
        affirmation: 'Ben güvendeyim. Evren beni koruyor ve destekliyor.',
      ),
      ChakraData(
        name: 'Sacral',
        nameTr: 'Sakral Çakrası',
        sanskritName: 'Svadhisthana',
        symbol: 'VAM',
        color: const Color(0xFFFF9800),
        balance: baseBalances[1],
        description:
            'Sakral chakra, yaratıcılık, duygular, cinsellik ve zevk alma kapasitesi ile bağlantılıdır.',
        physicalConnection: 'Üreme organları, böbrekler, alt sırt',
        emotionalAspects: 'Duygusal akış, tutku, yaratıcılık',
        balanceMessage: baseBalances[1] > 0.7
            ? 'Yaratıcı enerjin akıyor, duygularınla barışıksın.'
            : baseBalances[1] < 0.4
            ? 'Duygularını ifade etmekte zorluk yaşıyorsun.'
            : 'Yaratıcı projelerle bu enerjiyi canlandır.',
        healingSuggestions: [
          'Dans et veya bedenini özgürce hareket ettir',
          'Turuncu renkli yiyecekler tüket',
          'Suyla temas kur - yüzme, banyo',
        ],
        crystals: ['Karneol', 'Turuncu Kalsit', 'Ay Taşı'],
        affirmation: 'Duygularım özgürce akıyor. Yaratıcılığımı kucaklıyorum.',
      ),
      ChakraData(
        name: 'Solar Plexus',
        nameTr: 'Güneş Ağı Çakrası',
        sanskritName: 'Manipura',
        symbol: 'RAM',
        color: const Color(0xFFFFEB3B),
        balance: baseBalances[2],
        description:
            'Güneş ağı chakrası, kişisel güç, özgüven, irade gücü ve kimlik duygusu ile ilişkilidir.',
        physicalConnection: 'Sindirim sistemi, mide, karaciğer',
        emotionalAspects: 'Özgüven, kişisel güç, karar verme',
        balanceMessage: baseBalances[2] > 0.7
            ? 'Güçlü bir benlik algına sahipsin.'
            : baseBalances[2] < 0.4
            ? 'Özgüvenini yeniden inşa etmen gerekiyor.'
            : 'Hedeflerine odaklanarak güçlen.',
        healingSuggestions: [
          'Güneş ışığında zaman geçir',
          'Karın bölgesini güçlendiren egzersizler yap',
          'Sarı renkli besinler tüket',
        ],
        crystals: ['Sitrin', 'Kaplan Gözü', 'Sarı Jasper'],
        affirmation: 'Ben güçlüyüm. Hayatım üzerinde tam kontrole sahibim.',
      ),
      ChakraData(
        name: 'Heart',
        nameTr: 'Kalp Çakrası',
        sanskritName: 'Anahata',
        symbol: 'YAM',
        color: const Color(0xFF4CAF50),
        balance: baseBalances[3],
        description:
            'Anahata - "Vurulamayan Ses" - 12 yapraklı yeşil lotus olarak sembolize edilir. '
            'Kalp çakrası, sevgi, şefkat, affetme ve koşulsuz kabul enerjisidir. '
            'Fiziksel ve ruhsal bedeni birleştiren köprüdür. Hava elementi ile bağlantılıdır. '
            'Dengeli olduğunda evrensel sevgiyi deneyimler, tüm canlılara şefkat duyarsın.',
        physicalConnection: 'Kalp, akciğer, göğüs, kollar, eller',
        emotionalAspects: 'Koşulsuz sevgi, empati, bağışlama',
        balanceMessage: baseBalances[3] > 0.7
            ? 'Kalbin sevgiyle dolu, ilişkilerinde uyumlusun.'
            : baseBalances[3] < 0.4
            ? 'Kendine ve başkalarına şefkat göster.'
            : 'Affetme pratikleriyle kalbini aç.',
        healingSuggestions: [
          'Minnettarlık günlüğü tut',
          'Yeşil renkli sebzeler tüket',
          'Sevdiklerinle kaliteli zaman geçir',
        ],
        crystals: ['Gül Kuvars', 'Yeşil Aventurin', 'Zümrüt'],
        affirmation: 'Kalbim sevgiyle dolu. Vermek ve almak için açığım.',
      ),
      ChakraData(
        name: 'Throat',
        nameTr: 'Boğaz Çakrası',
        sanskritName: 'Vishuddha',
        symbol: 'HAM',
        color: const Color(0xFF03A9F4),
        balance: baseBalances[4],
        description:
            'Boğaz chakrası, iletişim, öz-ifade, doğruluk ve yaratıcı ses ile ilişkilidir.',
        physicalConnection: 'Boğaz, tiroid, boyun, kulaklar',
        emotionalAspects: 'İletişim, öz-ifade, doğruluk',
        balanceMessage: baseBalances[4] > 0.7
            ? 'Kendini rahatça ifade edebiliyorsun.'
            : baseBalances[4] < 0.4
            ? 'Sesini duyurmakta zorluk yaşıyorsun.'
            : 'Günlük yazma pratikleriyle güçlen.',
        healingSuggestions: [
          'Şarkı söyle veya mantra oku',
          'Duygularını yazmaya başla',
          'Mavi renkli çayı iç (kelebek bezelye)',
        ],
        crystals: ['Akuamarin', 'Lapis Lazuli', 'Mavi Kantaşı'],
        affirmation: 'Sesim değerli. Gerçeğimi sevgiyle paylaşıyorum.',
      ),
      ChakraData(
        name: 'Third Eye',
        nameTr: 'Üçüncü Göz Çakrası',
        sanskritName: 'Ajna',
        symbol: 'OM',
        color: const Color(0xFF3F51B5),
        balance: baseBalances[5],
        description:
            'Üçüncü göz chakrası, sezgi, iç görüş, hayal gücü ve ruhsal farkındalık ile bağlantılıdır.',
        physicalConnection: 'Beyin, gözler, hipofiz bezi',
        emotionalAspects: 'Sezgi, iç bilgelik, vizyon',
        balanceMessage: baseBalances[5] > 0.7
            ? 'Sezgilerin güçlü, iç sesinle bağdaşsın.'
            : baseBalances[5] < 0.4
            ? 'Sezgilerini dinlemeyi öğren.'
            : 'Meditasyonla iç görüşünü geliştir.',
        healingSuggestions: [
          'Gece gökyüzünü seyret',
          'Rüya günlüğü tut',
          'Sezgisel yazma pratiği yap',
        ],
        crystals: ['Ametist', 'Labradorit', 'Sodalit'],
        affirmation:
            'Sezgilerime güveniyorum. İç bilgeliğim beni yönlendiriyor.',
      ),
      ChakraData(
        name: 'Crown',
        nameTr: 'Taç Çakrası',
        sanskritName: 'Sahasrara',
        symbol: 'AUM',
        color: const Color(0xFF9C27B0),
        balance: baseBalances[6],
        description:
            'Taç chakrası, ruhani bağlantı, aydınlanma, evrensel bilinç ve yaşam amacı ile ilişkilidir.',
        physicalConnection: 'Beyin, sinir sistemi, epifiz bezi',
        emotionalAspects: 'Ruhani bağlantı, anlam arayışı, birlik',
        balanceMessage: baseBalances[6] > 0.7
            ? 'Evrenle derin bir bağlantın var.'
            : baseBalances[6] < 0.4
            ? 'Ruhani pratiklerle bağlantını güçlendir.'
            : 'Sessizlik ve meditasyonla aç.',
        healingSuggestions: [
          'Sessizlikte zaman geçir',
          'Farkındalık meditasyonu yap',
          'Doğada yalnız kal',
        ],
        crystals: ['Berrak Kuvars', 'Ametist', 'Selenit'],
        affirmation: 'Evrenle birim. İlahi rehberliğe açığım.',
      ),
    ];
  }

  static String _getElement(ZodiacSign sign) {
    switch (sign) {
      case ZodiacSign.aries:
      case ZodiacSign.leo:
      case ZodiacSign.sagittarius:
        return 'fire';
      case ZodiacSign.taurus:
      case ZodiacSign.virgo:
      case ZodiacSign.capricorn:
        return 'earth';
      case ZodiacSign.gemini:
      case ZodiacSign.libra:
      case ZodiacSign.aquarius:
        return 'air';
      case ZodiacSign.cancer:
      case ZodiacSign.scorpio:
      case ZodiacSign.pisces:
        return 'water';
    }
  }

  static List<double> _getElementBalances(String element) {
    switch (element) {
      case 'fire':
        return [0.75, 0.65, 0.85, 0.55, 0.70, 0.50, 0.60];
      case 'earth':
        return [0.90, 0.50, 0.70, 0.60, 0.55, 0.45, 0.40];
      case 'air':
        return [0.50, 0.60, 0.65, 0.70, 0.85, 0.80, 0.75];
      case 'water':
        return [0.55, 0.80, 0.45, 0.85, 0.60, 0.75, 0.70];
      default:
        return [0.60, 0.60, 0.60, 0.60, 0.60, 0.60, 0.60];
    }
  }

  static String _getOverallAnalysis(
    ZodiacSign sign,
    ChakraData strongest,
    ChakraData weakest,
  ) {
    return '''${sign.nameTr} burcu olarak, enerji sistemin ${strongest.nameTr} bölgesinde özellikle güçlü. Bu, ${strongest.emotionalAspects.toLowerCase()} konularında doğal bir yeteneğe sahip olduğun anlamına gelir.

Ancak ${weakest.nameTr} bölgesine daha fazla dikkat göstermen faydalı olacaktır. Bu chakrayı dengelemek için önerilen pratikleri günlük rutinine ekleyebilirsin.

Genel olarak, chakra sistemin harmonik bir şekilde çalışıyor. Düzenli meditasyon ve farkındalık pratikleri ile bu dengeyi koruyabilirsin.''';
  }

  static List<String> _getGeneralTips(ZodiacSign sign) {
    return [
      'Her gün en az 10 dakika meditasyon yap',
      'Doğada zaman geçirerek topraklan',
      'Renkli ve dengeli beslen',
      'Düzenli fiziksel aktivite yap',
      'Duygularını günlüğe yaz',
    ];
  }

  static List<ChakraMeditation> _getMeditations(List<ChakraData> chakras) {
    return [
      ChakraMeditation(
        chakra: chakras[0],
        title: 'Topraklanma Meditasyonu',
        description:
            'Ayaklarından yeryüzüne uzanan kökler hayal et. Güvenlik ve istikrar hisset.',
        duration: 10,
      ),
      ChakraMeditation(
        chakra: chakras[3],
        title: 'Kalp Açma Meditasyonu',
        description:
            'Kalbinde yeşil bir ışık hayal et. Her nefeste bu ışık büyüsün.',
        duration: 15,
      ),
      ChakraMeditation(
        chakra: chakras[5],
        title: 'Üçüncü Göz Aktivasyonu',
        description:
            'Kaşların arasındaki noktaya odaklan. Mor bir ışık görebildiğini hayal et.',
        duration: 12,
      ),
    ];
  }

  static DailyChakraFocus _getDailyFocus(List<ChakraData> chakras) {
    final dayOfWeek = DateTime.now().weekday;
    final focusIndex = dayOfWeek % 7;
    final focusChakra = chakras[focusIndex];

    return DailyChakraFocus(
      focusChakra: focusChakra,
      description:
          'Bugün ${focusChakra.nameTr} enerjisi ön planda. Bu enerjiyle uyumlu aktiviteler yaparak gününü daha verimli geçirebilirsin.',
      focusReason:
          'Haftanın bu günü ${focusChakra.name} enerjisine karşılık geliyor.',
      activities: [
        focusChakra.healingSuggestions[0],
        '${focusChakra.nameTr} için 5 dakikalık meditasyon yap',
        '${focusChakra.crystals[0]} taşını yanında taşı',
        'Gün içinde olumlamayı 3 kez tekrarla',
      ],
    );
  }
}
