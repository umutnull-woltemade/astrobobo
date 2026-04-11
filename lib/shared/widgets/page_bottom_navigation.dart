import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../data/content/navigation_content.dart';

/// Page Bottom Navigation Widget
/// Implements the "Back-Button-Free Navigation System"
/// Every page ends with 4 mandatory exploration sections:
/// 1. "Bunu Okuyanlar Şuna da Baktı" - Social proof navigation
/// 2. "Bir Adım Daha Derinleş" - Deeper experience (dreams/kozmoz)
/// 3. "Keşfetmeye Devam Et" - Cross-category exploration
/// 4. "Geri Dönmeden Devam Et" - Hub links (replace back button)
class PageBottomNavigation extends StatelessWidget {
  final String currentRoute;
  final PageNavigation? customNavigation;

  const PageBottomNavigation({
    super.key,
    required this.currentRoute,
    this.customNavigation,
  });

  @override
  Widget build(BuildContext context) {
    final navigation =
        customNavigation ??
        NavigationService.getNavigationForRoute(currentRoute);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  Colors.transparent,
                  AppColors.deepSpace.withOpacity(0.3),
                  AppColors.deepSpace.withOpacity(0.6),
                ]
              : [
                  Colors.transparent,
                  AppColors.lightBackground.withOpacity(0.5),
                  AppColors.lightBackground,
                ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          // Section 1: Bunu Okuyanlar Şuna da Baktı
          if (navigation.alsoViewed.isNotEmpty)
            _NavigationSection(
              title: NavigationSectionTitles.alsoViewed,
              subtitle: 'Merak edenler bunlara da göz attı',
              cards: navigation.alsoViewed,
              sectionIndex: 0,
            ),
          // Section 2: Bir Adım Daha Derinleş
          if (navigation.goDeeper.isNotEmpty)
            _NavigationSection(
              title: NavigationSectionTitles.goDeeper,
              subtitle: 'İç dünyanla bağlan',
              cards: navigation.goDeeper,
              sectionIndex: 1,
              isHighlighted: true,
            ),
          // Section 3: Keşfetmeye Devam Et
          if (navigation.keepExploring.isNotEmpty)
            _NavigationSection(
              title: NavigationSectionTitles.keepExploring,
              subtitle: 'Farklı bakış açıları',
              cards: navigation.keepExploring,
              sectionIndex: 2,
            ),
          // Section 4: Geri Dönmeden Devam Et
          if (navigation.continueWithoutBack.isNotEmpty)
            _QuickLinksSection(
              title: NavigationSectionTitles.continueWithoutBack,
              cards: navigation.continueWithoutBack,
              sectionIndex: 3,
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Navigation Section with horizontal scrolling cards
class _NavigationSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<NavigationCard> cards;
  final int sectionIndex;
  final bool isHighlighted;

  const _NavigationSection({
    required this.title,
    required this.subtitle,
    required this.cards,
    required this.sectionIndex,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isHighlighted)
                          Container(
                            width: 4,
                            height: 24,
                            margin: const EdgeInsetsDirectional.only(end: 12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.auroraStart,
                                  AppColors.auroraEnd,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? (isHighlighted
                                        ? AppColors.starGold
                                        : AppColors.textPrimary)
                                  : (isHighlighted
                                        ? AppColors.lightStarGold
                                        : AppColors.lightTextPrimary),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: isHighlighted ? 16 : 0,
                      ),
                      child: Text(
                        subtitle,
                        style: GoogleFonts.raleway(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textSecondary.withOpacity(0.7)
                              : AppColors.lightTextSecondary.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Horizontal Scrolling Cards
              SizedBox(
                height: 145,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12),
                          child: _NavigationCardWidget(
                            card: cards[index],
                            isHighlighted: isHighlighted,
                          ),
                        )
                        .animate(delay: Duration(milliseconds: 50 * index))
                        .fadeIn(duration: 400.ms)
                        .slideX(begin: 0.1, curve: Curves.easeOut);
                  },
                ),
              ),
            ],
          ),
        )
        .animate(delay: Duration(milliseconds: 100 * sectionIndex))
        .fadeIn(duration: 500.ms);
  }
}

/// Navigation Card Widget
class _NavigationCardWidget extends StatelessWidget {
  final NavigationCard card;
  final bool isHighlighted;

  const _NavigationCardWidget({required this.card, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push(card.route),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isHighlighted
                      ? [
                          AppColors.auroraStart.withOpacity(0.15),
                          AppColors.auroraEnd.withOpacity(0.1),
                        ]
                      : [
                          AppColors.surfaceLight.withOpacity(0.5),
                          AppColors.surfaceDark.withOpacity(0.3),
                        ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isHighlighted
                      ? [
                          AppColors.lightAuroraStart.withOpacity(0.1),
                          AppColors.lightAuroraEnd.withOpacity(0.05),
                        ]
                      : [AppColors.lightCard, AppColors.lightSurfaceVariant],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? (isHighlighted
                      ? AppColors.auroraStart.withOpacity(0.3)
                      : AppColors.textMuted.withOpacity(0.1))
                : (isHighlighted
                      ? AppColors.lightAuroraStart.withOpacity(0.3)
                      : AppColors.lightTextMuted.withOpacity(0.15)),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
            if (isHighlighted)
              BoxShadow(
                color: AppColors.auroraStart.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: -5,
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji
            if (card.emoji != null)
              Text(card.emoji!, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            // Title
            Text(
              card.title,
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Description
            Expanded(
              child: Text(
                card.description,
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondary.withOpacity(0.8)
                      : AppColors.lightTextSecondary,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Quick Links Section - Compact horizontal chips for "Geri Dönmeden Devam Et"
class _QuickLinksSection extends StatelessWidget {
  final String title;
  final List<NavigationCard> cards;
  final int sectionIndex;

  const _QuickLinksSection({
    required this.title,
    required this.cards,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        isDark
                            ? AppColors.textMuted.withOpacity(0.2)
                            : AppColors.lightTextMuted.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title,
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textSecondary
                        : AppColors.lightTextSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Horizontal Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: cards.asMap().entries.map((entry) {
                    final index = entry.key;
                    final card = entry.value;
                    return Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: _QuickLinkChip(card: card),
                        )
                        .animate(delay: Duration(milliseconds: 50 * index))
                        .fadeIn(duration: 300.ms)
                        .scale(begin: const Offset(0.95, 0.95));
                  }).toList(),
                ),
              ),
            ],
          ),
        )
        .animate(delay: Duration(milliseconds: 100 * sectionIndex))
        .fadeIn(duration: 500.ms);
  }
}

/// Quick Link Chip - Compact navigation button
class _QuickLinkChip extends StatelessWidget {
  final NavigationCard card;

  const _QuickLinkChip({required this.card});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push(card.route),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceLight.withOpacity(0.3)
                : AppColors.lightSurfaceVariant,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? AppColors.textMuted.withOpacity(0.15)
                  : AppColors.lightTextMuted.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (card.emoji != null) ...[
                Text(card.emoji!, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
              ],
              Text(
                card.title,
                style: GoogleFonts.raleway(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact version for pages with less space
class PageBottomNavigationCompact extends StatelessWidget {
  final String currentRoute;

  const PageBottomNavigationCompact({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final navigation = NavigationService.getNavigationForRoute(currentRoute);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Combine all cards into quick links
    final allCards = [
      ...navigation.goDeeper,
      ...navigation.keepExploring.take(2),
      ...navigation.continueWithoutBack,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [Colors.transparent, AppColors.deepSpace.withOpacity(0.5)]
              : [Colors.transparent, AppColors.lightBackground],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Keşfetmeye Devam Et',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: allCards.map((card) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: _QuickLinkChip(card: card),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
