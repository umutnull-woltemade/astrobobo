import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Premium Upsell Widget Types
enum PremiumUpsellType {
  banner, // Full-width banner
  card, // Floating card
  inline, // Inline text link
  modal, // Modal popup
  subtle, // Subtle hint
}

/// Premium Upsell Widget
/// Contextual premium feature promotion
class PremiumUpsell extends StatelessWidget {
  final PremiumUpsellType type;
  final String title;
  final String description;
  final String ctaText;
  final List<String>? features;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool dismissible;

  const PremiumUpsell({
    super.key,
    this.type = PremiumUpsellType.card,
    this.title = 'Premium ile Daha Fazlasını Keşfet',
    this.description =
        'Sınırsız harita, detaylı raporlar ve kişiselleştirilmiş içerikler',
    this.ctaText = 'Premium\'a Geç',
    this.features,
    this.icon,
    this.onTap,
    this.dismissible = false,
  });

  /// Factory for birth chart upsell
  factory PremiumUpsell.birthChart() {
    return const PremiumUpsell(
      type: PremiumUpsellType.card,
      title: 'Detaylı Harita Analizi',
      description: 'Tüm gezegen yorumları, ev analizleri ve aspect detayları',
      ctaText: 'Premium ile Aç',
      icon: Icons.auto_graph,
      features: [
        'Tüm gezegen yorumları',
        'Ev yerleşimi analizleri',
        'Aspect pattern\'ler',
        'PDF rapor indirme',
      ],
    );
  }

  /// Factory for transit report upsell
  factory PremiumUpsell.transits() {
    return const PremiumUpsell(
      type: PremiumUpsellType.card,
      title: 'Kişisel Transit Raporları',
      description: 'Transitler doğum haritanıza nasıl etkiliyor?',
      ctaText: 'Premium ile Gör',
      icon: Icons.timeline,
      features: [
        'Kişisel transit etkileri',
        'Kritik tarih uyarıları',
        'Retrograd raporları',
        'Aylık transit özeti',
      ],
    );
  }

  /// Factory for compatibility upsell
  factory PremiumUpsell.compatibility() {
    return const PremiumUpsell(
      type: PremiumUpsellType.card,
      title: 'Detaylı Uyum Raporu',
      description: 'İlişkinizin tüm boyutlarını keşfedin',
      ctaText: 'Premium ile Analiz Et',
      icon: Icons.favorite,
      features: [
        'Synastry aspect detayları',
        'Kompozit harita analizi',
        'Güçlü ve zayıf yönler',
        'İlişki dinamikleri raporu',
      ],
    );
  }

  /// Factory for subtle inline upsell
  factory PremiumUpsell.subtle(String featureName) {
    return PremiumUpsell(
      type: PremiumUpsellType.subtle,
      title: featureName,
      description: 'Premium özellik',
      ctaText: 'Premium',
    );
  }

  /// Factory for banner upsell
  factory PremiumUpsell.banner() {
    return const PremiumUpsell(
      type: PremiumUpsellType.banner,
      title: 'Kozmik Yolculuğunuzu Derinleştirin',
      description:
          'Premium ile sınırsız erişim ve kişiselleştirilmiş rehberlik',
      ctaText: 'Hemen Başla',
      icon: Icons.auto_awesome,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case PremiumUpsellType.banner:
        return _buildBanner(context);
      case PremiumUpsellType.card:
        return _buildCard(context);
      case PremiumUpsellType.inline:
        return _buildInline(context);
      case PremiumUpsellType.subtle:
        return _buildSubtle(context);
      case PremiumUpsellType.modal:
        return _buildCard(
          context,
        ); // Modal uses same UI, different presentation
    }
  }

  Widget _buildBanner(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMd,
            vertical: AppConstants.spacingLg,
          ),
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.auroraStart.withOpacity(isDark ? 0.3 : 0.15),
                AppColors.auroraEnd.withOpacity(isDark ? 0.2 : 0.1),
                AppColors.starGold.withOpacity(isDark ? 0.15 : 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.starGold.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.auroraStart.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.starGold, AppColors.auroraStart],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon ?? Icons.auto_awesome,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.starGold,
                                    AppColors.auroraStart,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'PREMIUM',
                                style: GoogleFonts.raleway(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          title,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              _buildCtaButton(context),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, curve: Curves.easeOut);
  }

  Widget _buildCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMd,
        vertical: AppConstants.spacingMd,
      ),
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.surfaceLight.withOpacity(0.1),
                  AppColors.surfaceDark.withOpacity(0.5),
                ]
              : [AppColors.lightCard, AppColors.lightSurfaceVariant],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.starGold.withOpacity(0.2)
              : AppColors.lightStarGold.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.starGold.withOpacity(0.15)
                      : AppColors.lightStarGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon ?? Icons.workspace_premium,
                  color: isDark ? AppColors.starGold : AppColors.lightStarGold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.starGold, AppColors.auroraStart],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'PRO',
                  style: GoogleFonts.raleway(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.4,
            ),
          ),
          // Features list
          if (features != null && features!.isNotEmpty) ...[
            const SizedBox(height: 14),
            ...features!.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.raleway(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textSecondary.withOpacity(0.9)
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          _buildCtaButton(context, compact: true),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.98, 0.98));
  }

  Widget _buildInline(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap ?? () => context.push('/premium'),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.starGold.withOpacity(0.1)
              : AppColors.lightStarGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark
                ? AppColors.starGold.withOpacity(0.2)
                : AppColors.lightStarGold.withOpacity(0.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 14,
              color: isDark ? AppColors.starGold : AppColors.lightStarGold,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.raleway(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.starGold : AppColors.lightStarGold,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              size: 10,
              color: isDark ? AppColors.starGold : AppColors.lightStarGold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap ?? () => context.push('/premium'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.workspace_premium,
            size: 12,
            color: isDark
                ? AppColors.starGold.withOpacity(0.7)
                : AppColors.lightStarGold.withOpacity(0.8),
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: GoogleFonts.raleway(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.starGold.withOpacity(0.7)
                  : AppColors.lightStarGold.withOpacity(0.8),
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaButton(BuildContext context, {bool compact = false}) {
    return GestureDetector(
      onTap: onTap ?? () => context.push('/premium'),
      child: Container(
        width: compact ? null : double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 20 : 24,
          vertical: compact ? 10 : 14,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.starGold, AppColors.auroraStart],
          ),
          borderRadius: BorderRadius.circular(compact ? 10 : 12),
          boxShadow: [
            BoxShadow(
              color: AppColors.starGold.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: compact ? 16 : 18,
            ),
            const SizedBox(width: 8),
            Text(
              ctaText,
              style: GoogleFonts.raleway(
                fontSize: compact ? 13 : 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Show premium upsell modal
Future<void> showPremiumUpsellModal(
  BuildContext context, {
  String? title,
  String? description,
  List<String>? features,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.lightBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.textMuted.withOpacity(0.3)
                      : AppColors.lightTextMuted.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              PremiumUpsell(
                type: PremiumUpsellType.card,
                title: title ?? 'Premium ile Daha Fazlasını Keşfet',
                description:
                    description ??
                    'Sınırsız erişim, detaylı raporlar ve kişiselleştirilmiş içerikler',
                features:
                    features ??
                    const [
                      'Sınırsız doğum haritası',
                      'Detaylı transit raporları',
                      'PDF rapor indirme',
                      'Reklamsız deneyim',
                    ],
                onTap: () {
                  Navigator.pop(context);
                  context.push('/premium');
                },
              ),
              const SizedBox(height: AppConstants.spacingMd),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Şimdilik Değil',
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
