import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/content/tantra_content.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/entertainment_disclaimer.dart';

/// Tantra Screen - Mindfulness & Connection Practices
/// Safe, non-explicit, wellness-focused content
class TantraScreen extends StatefulWidget {
  const TantraScreen({super.key});

  @override
  State<TantraScreen> createState() => _TantraScreenState();
}

class _TantraScreenState extends State<TantraScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TantraTheme? _selectedTheme;

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
                    _buildDailyTab(isDark),
                    _buildExploreTab(isDark),
                    _buildQuestionsTab(isDark),
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
                        const Text('🕯️', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        Text(
                          'Tantra',
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
                      'Farkındalık & Bağlanma Pratiği',
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
          // Description section
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : AppColors.tantraWarm.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppColors.tantraGold.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              'Tantra, bedensel farkındalık, bilinçli nefes ve duygusal bağlanma yoluyla içsel dengeyi keşfetme sanatıdır. Bu pratikler, kendinle ve sevdiklerinle daha derin bir bağ kurmanı sağlar.',
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
        labelColor: isDark ? AppColors.tantraWarm : AppColors.tantraCrimson,
        unselectedLabelColor: isDark ? Colors.white60 : AppColors.textLight,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: isDark
              ? AppColors.tantraWarm.withValues(alpha: 0.2)
              : AppColors.tantraCrimson.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Günlük'),
          Tab(text: 'Keşfet'),
          Tab(text: 'Sorular'),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DAILY TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildDailyTab(bool isDark) {
    final dailyModule = TantraContent.getDailyModule();
    final recommended = TantraContent.getRecommendedForTime();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily module card
          _buildDailyModuleCard(
            dailyModule,
            isDark,
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),

          const SizedBox(height: AppConstants.spacingXl),

          // Time-based recommendations
          Text(
            'Şu An İçin Önerilen',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...recommended.asMap().entries.map((entry) {
            return _buildModuleCard(entry.value, isDark)
                .animate(delay: (100 * entry.key).ms)
                .fadeIn(duration: 400.ms)
                .slideX(begin: 0.1);
          }),
          const SizedBox(height: AppConstants.spacingXl),
          // Entertainment Disclaimer
          const PageFooterWithDisclaimer(
            brandText: 'Tantra — Venus One',
            disclaimerText: DisclaimerTexts.astrology,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyModuleCard(TantraModule module, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.tantraWarm.withValues(alpha: 0.3),
                  AppColors.tantraCrimson.withValues(alpha: 0.2),
                ]
              : [
                  AppColors.tantraWarm.withValues(alpha: 0.15),
                  AppColors.tantraCrimson.withValues(alpha: 0.1),
                ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.tantraGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.tantraGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('✨', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(
                      'Günün Pratiği',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.tantraGold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(module.theme.icon, style: const TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Title
          Text(
            module.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),

          // Core insight
          Text(
            module.coreInsight,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: isDark ? AppColors.tantraGold : AppColors.tantraCrimson,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Reflection
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('💭', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      'Düşün',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  module.reflection,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : AppColors.textDark,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Practice
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.tantraCrimson.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppColors.tantraCrimson.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('🧘', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      'Pratik',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.tantraCrimson,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.tantraCrimson.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${module.durationMinutes} dk',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tantraCrimson,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  module.practice,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : AppColors.textDark,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // EXPLORE TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildExploreTab(bool isDark) {
    final modules = _selectedTheme != null
        ? TantraContent.getByTheme(_selectedTheme!)
        : TantraContent.getAllModules();

    return Column(
      children: [
        // Theme filter
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingLg,
            ),
            children: [
              _buildThemeChip(null, 'Tümü', '📚', isDark),
              ...TantraTheme.values.map(
                (theme) =>
                    _buildThemeChip(theme, theme.nameTr, theme.icon, isDark),
              ),
            ],
          ),
        ),

        // Theme description (when a theme is selected)
        if (_selectedTheme != null) ...[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingLg,
            ),
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.tantraWarm.withValues(alpha: isDark ? 0.2 : 0.1),
                  AppColors.tantraCrimson.withValues(
                    alpha: isDark ? 0.15 : 0.08,
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppColors.tantraGold.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Text(
                  _selectedTheme!.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedTheme!.nameTr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.tantraGold
                              : AppColors.tantraCrimson,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedTheme!.description,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: isDark ? Colors.white70 : AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1),
          const SizedBox(height: AppConstants.spacingMd),
        ],

        // Modules list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              return _buildModuleCard(
                modules[index],
                isDark,
              ).animate(delay: (50 * index).ms).fadeIn(duration: 300.ms);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildThemeChip(
    TantraTheme? theme,
    String label,
    String icon,
    bool isDark,
  ) {
    final isSelected = _selectedTheme == theme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text(icon), const SizedBox(width: 4), Text(label)],
        ),
        onSelected: (_) {
          setState(() {
            _selectedTheme = theme;
          });
        },
        selectedColor: AppColors.tantraCrimson.withValues(alpha: 0.3),
        backgroundColor: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildModuleCard(TantraModule module, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
        ),
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
            color: AppColors.tantraWarm.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              module.theme.icon,
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
        title: Text(
          module.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isDark ? Colors.white : AppColors.textDark,
          ),
        ),
        subtitle: Text(
          module.coreInsight,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white60 : AppColors.textLight,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.tantraCrimson.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${module.durationMinutes} dk',
                style: TextStyle(fontSize: 11, color: AppColors.tantraCrimson),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.expand_more,
              color: isDark ? Colors.white60 : AppColors.textLight,
            ),
          ],
        ),
        children: [
          // Reflection
          _buildSectionBox(
            icon: '💭',
            title: 'Düşün',
            content: module.reflection,
            isDark: isDark,
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Practice
          _buildSectionBox(
            icon: '🧘',
            title: 'Pratik',
            content: module.practice,
            isDark: isDark,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionBox({
    required String icon,
    required String title,
    required String content,
    required bool isDark,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.tantraCrimson.withValues(alpha: 0.1)
            : (isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.grey.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: highlight
            ? Border.all(color: AppColors.tantraCrimson.withValues(alpha: 0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: highlight
                      ? AppColors.tantraCrimson
                      : (isDark ? Colors.white70 : AppColors.textLight),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white : AppColors.textDark,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // QUESTIONS TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildQuestionsTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      children: [
        ...TantraQuestionPurpose.values.map((purpose) {
          final questions = TantraContent.getByPurpose(purpose);
          return _buildQuestionSection(purpose, questions, isDark);
        }),
      ],
    );
  }

  Widget _buildQuestionSection(
    TantraQuestionPurpose purpose,
    List<TantraQuestion> questions,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Purpose header with description
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          margin: const EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : AppColors.tantraWarm.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(
              color: isDark
                  ? AppColors.tantraGold.withValues(alpha: 0.2)
                  : AppColors.tantraCrimson.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Text(purpose.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purpose.nameTr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.tantraGold
                            : AppColors.tantraCrimson,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      purpose.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : AppColors.textLight,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ...questions.take(5).map((q) => _buildQuestionCard(q, isDark)),
        const SizedBox(height: AppConstants.spacingMd),
      ],
    );
  }

  Widget _buildQuestionCard(TantraQuestion question, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Text('💫', style: TextStyle(fontSize: 18)),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : AppColors.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
