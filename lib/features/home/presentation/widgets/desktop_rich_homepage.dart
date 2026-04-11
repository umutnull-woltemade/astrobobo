import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/zodiac_sign.dart';
import '../../../../data/providers/app_providers.dart';
import '../../../../data/services/moon_service.dart';
import '../../../../shared/widgets/cosmic_background.dart';
import '../../../../shared/widgets/page_bottom_navigation.dart';

/// DESKTOP RICH HOMEPAGE
///
/// DESIGN GOALS:
/// - Visual, immersive, cinematic experience
/// - Heavy animations, parallax effects, glows
/// - Full cosmic background with nebula
/// - Interactive zodiac wheel
/// - Multi-column layout for large screens
/// - Premium feel with glass morphism
///
/// TARGET: Desktop/Tablet (>768px width)
class DesktopRichHomepage extends ConsumerWidget {
  const DesktopRichHomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    // Guard: Redirect to onboarding if no valid profile
    if (userProfile == null ||
        userProfile.name == null ||
        userProfile.name!.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go(Routes.onboarding);
        }
      });
      return const Scaffold(
        backgroundColor: Color(0xFF0D0D1A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFFD700)),
        ),
      );
    }

    final sign = userProfile.sunSign;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  // ══════════════════════════════════════════════════════
                  // HEADER - Premium glass morphism header
                  // ══════════════════════════════════════════════════════
                  _DesktopHeader(
                    userName: userProfile.name ?? '',
                    sign: sign,
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),

                  const SizedBox(height: 16),

                  // ══════════════════════════════════════════════════════
                  // QUICK DISCOVERY BAR - Lightweight tool access
                  // ══════════════════════════════════════════════════════
                  const _QuickDiscoveryBar().animate().fadeIn(
                    duration: 400.ms,
                    delay: 100.ms,
                  ),

                  const SizedBox(height: 24),

                  // ══════════════════════════════════════════════════════
                  // HERO SECTION - Large cosmic card with daily message
                  // ══════════════════════════════════════════════════════
                  _HeroSection(sign: sign)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 40),

                  // ══════════════════════════════════════════════════════
                  // MOON PHASE - Interactive moon widget
                  // ══════════════════════════════════════════════════════
                  _MoonPhaseSection().animate().fadeIn(
                    duration: 500.ms,
                    delay: 400.ms,
                  ),

                  const SizedBox(height: 40),

                  // ══════════════════════════════════════════════════════
                  // QUICK ACTIONS GRID - Premium cards
                  // ══════════════════════════════════════════════════════
                  _QuickActionsGrid().animate().fadeIn(
                    duration: 500.ms,
                    delay: 500.ms,
                  ),

                  const SizedBox(height: 40),

                  // ══════════════════════════════════════════════════════
                  // ZODIAC WHEEL - Interactive zodiac selector
                  // ══════════════════════════════════════════════════════
                  _ZodiacWheelSection(currentSign: sign)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 40),

                  // ══════════════════════════════════════════════════════
                  // DISCOVERY SECTION - Featured tools
                  // ══════════════════════════════════════════════════════
                  _DiscoverySection().animate().fadeIn(
                    duration: 500.ms,
                    delay: 700.ms,
                  ),

                  const SizedBox(height: 32),

                  // ══════════════════════════════════════════════════════
                  // EV SİSTEMİ SECTION - Astrolojik Evler
                  // ══════════════════════════════════════════════════════
                  _HouseSystemSection().animate().fadeIn(
                    duration: 500.ms,
                    delay: 800.ms,
                  ),

                  const SizedBox(height: 32),

                  // Bottom navigation
                  const PageBottomNavigation(currentRoute: '/'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// QUICK DISCOVERY BAR - Lightweight horizontal tool strip
// ═══════════════════════════════════════════════════════════════════════════

class _QuickDiscoveryBar extends StatelessWidget {
  const _QuickDiscoveryBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.03),
            Colors.white.withOpacity(0.01),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QuickDiscoveryItem(
              icon: '⭐',
              label: 'Burç Yorumu',
              route: Routes.horoscope,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🗺️',
              label: 'Doğum Haritası',
              route: Routes.birthChart,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🧠',
              label: 'Theta Healing',
              route: Routes.thetaHealing,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🌍',
              label: 'Astrokartografi',
              route: Routes.astroCartography,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🙏',
              label: 'Reiki',
              route: Routes.reiki,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🔮',
              label: 'Tarot',
              route: Routes.tarot,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🔢',
              label: 'Numeroloji',
              route: Routes.numerology,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '💜',
              label: 'Çakra',
              route: Routes.chakraAnalysis,
            ),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(icon: '✨', label: 'Aura', route: Routes.aura),
            const SizedBox(width: 24),
            _QuickDiscoveryItem(
              icon: '🕯️',
              label: 'Tantra',
              route: Routes.tantra,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickDiscoveryItem extends StatefulWidget {
  final String icon;
  final String label;
  final String route;

  const _QuickDiscoveryItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  State<_QuickDiscoveryItem> createState() => _QuickDiscoveryItemState();
}

class _QuickDiscoveryItemState extends State<_QuickDiscoveryItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.push(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.starGold.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? AppColors.starGold
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DESKTOP HEADER - Glass morphism with premium feel
// ═══════════════════════════════════════════════════════════════════════════

class _DesktopHeader extends StatelessWidget {
  final String userName;
  final ZodiacSign sign;

  const _DesktopHeader({required this.userName, required this.sign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          // ═══════════════════════════════════════════════════════════════
          // LOGO + AI TOOLS - Birbirine bağlı görünüm
          // ═══════════════════════════════════════════════════════════════
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Venus One Logo
                _VenusOneLogo(),

                // Bağlantı çizgisi 1
                Container(
                  width: 20,
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.starGold.withOpacity(0.8),
                        const Color(0xFF9D4EDD).withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.starGold.withOpacity(0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),

                // Rüya İzi Button
                _DreamHeaderButton(
                  onTap: () => context.push(Routes.dreamInterpretation),
                ),

                // Bağlantı çizgisi 2
                Container(
                  width: 20,
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF5C6BC0).withOpacity(0.6),
                        const Color(0xFF6A1B9A).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5C6BC0).withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),

                // Kozmoz Button - En sağda
                _KozmozHeaderButton(onTap: () => context.push(Routes.kozmoz)),
              ],
            ),
          ),

          const Spacer(),

          // User greeting with sign
          Row(
            children: [
              Text(
                sign.symbol,
                style: const TextStyle(fontSize: 28, color: AppColors.starGold),
              ),
              const SizedBox(width: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merhaba, $userName',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      sign.nameTr,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Action buttons
          _HeaderIconButton(
            icon: Icons.search_rounded,
            onTap: () => context.push(Routes.allServices),
          ),
          const SizedBox(width: 8),
          _HeaderIconButton(
            icon: Icons.person_add_rounded,
            onTap: () => context.push(Routes.savedProfiles),
          ),
          const SizedBox(width: 8),
          _HeaderIconButton(
            icon: Icons.settings_rounded,
            onTap: () => context.push(Routes.settings),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: AppColors.textSecondary, size: 20),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// HERO SECTION - Large cosmic card with daily message
// ═══════════════════════════════════════════════════════════════════════════

class _HeroSection extends StatelessWidget {
  final ZodiacSign sign;

  const _HeroSection({required this.sign});

  @override
  Widget build(BuildContext context) {
    final headline = _getCosmicHeadline(sign);
    final message = _getCosmicMessage(sign);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.auroraStart.withOpacity(0.2),
            AppColors.auroraEnd.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.auroraStart.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.auroraStart.withOpacity(0.1),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Text content
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Today's date badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.starGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.starGold.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    _getTodayString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.starGold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Cosmic headline
                Text(
                  headline,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 16),

                // Message
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary.withOpacity(0.9),
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 28),

                // CTA Button
                ElevatedButton(
                  onPressed: () => context.push(Routes.cosmicShare),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.starGold,
                    foregroundColor: AppColors.deepSpace,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Kozmik Mesajını Al',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.auto_awesome, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Right side - Animated zodiac symbol
          Expanded(
            flex: 2,
            child: Center(child: _AnimatedZodiacSymbol(sign: sign)),
          ),
        ],
      ),
    );
  }

  String _getTodayString() {
    final now = DateTime.now();
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
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  String _getCosmicHeadline(ZodiacSign sign) {
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    final headlines = <String>[
      'Kozmik enerjiler senin yanında.',
      'Evren sana gülümsüyor.',
      'Bugün dönüşüm günün.',
      'Yıldızlar seni selamlıyor.',
      'Göksel güçler seninle.',
    ];
    return headlines[(dayOfYear + sign.index) % headlines.length];
  }

  String _getCosmicMessage(ZodiacSign sign) {
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    final messages = <String>[
      'Bugün içsel gücünü keşfetmek için mükemmel bir gün. Sezgilerine güven ve kalbinin sesini dinle.',
      'Evrenin enerjisi seninle akıyor. Bu fırsatı değerlendir ve hayallerine bir adım daha yaklaş.',
      'Kozmik rüzgarlar değişim getiriyor. Yeni başlangıçlara hazır ol ve geçmişi bırak.',
    ];
    return messages[(dayOfYear + sign.index) % messages.length];
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ANIMATED ZODIAC SYMBOL - Glowing, rotating effect
// ═══════════════════════════════════════════════════════════════════════════

class _AnimatedZodiacSymbol extends StatefulWidget {
  final ZodiacSign sign;

  const _AnimatedZodiacSymbol({required this.sign});

  @override
  State<_AnimatedZodiacSymbol> createState() => _AnimatedZodiacSymbolState();
}

class _AnimatedZodiacSymbolState extends State<_AnimatedZodiacSymbol>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                widget.sign.color.withOpacity(0.3),
                widget.sign.color.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.sign.color.withOpacity(0.3),
                blurRadius: 60,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating ring
              Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.sign.color.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              // Counter-rotating inner ring
              Transform.rotate(
                angle: -_controller.value * 2 * math.pi * 0.5,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.starGold.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
              ),
              // Symbol
              Text(
                widget.sign.symbol,
                style: TextStyle(
                  fontSize: 72,
                  color: widget.sign.color,
                  shadows: [
                    Shadow(
                      color: widget.sign.color.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MOON PHASE SECTION - Interactive moon widget
// ═══════════════════════════════════════════════════════════════════════════

class _MoonPhaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moonPhase = MoonService.getCurrentPhase(DateTime.now());
    final moonSign = MoonService.getCurrentMoonSign(DateTime.now());

    return GestureDetector(
      onTap: () => context.push(Routes.timing),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Moon icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.moonSilver.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  moonPhase.emoji,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),

            const SizedBox(width: 24),

            // Moon info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    moonPhase.nameTr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ay ${moonSign.nameTr} burcunda',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Mercury retrograde badge if active
            if (MoonService.isPlanetRetrograde('mercury'))
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.error,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Merkür Geri',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// QUICK ACTIONS GRID - Premium animated cards
// ═══════════════════════════════════════════════════════════════════════════

class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            (constraints.maxWidth - 48) / 4; // 4 columns with gaps

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _QuickActionCard(
              icon: Icons.wb_sunny_rounded,
              title: 'Günlük',
              subtitle: 'Burç Yorumu',
              color: AppColors.celestialGold,
              route: Routes.horoscope,
              width: cardWidth,
            ),
            _QuickActionCard(
              icon: Icons.calendar_month_rounded,
              title: 'Haftalık',
              subtitle: 'Yorum',
              color: AppColors.auroraStart,
              route: Routes.weeklyHoroscope,
              width: cardWidth,
            ),
            _QuickActionCard(
              icon: Icons.auto_awesome_rounded,
              title: 'Kozmik',
              subtitle: 'Paylaşım',
              color: AppColors.starGold,
              route: Routes.cosmicShare,
              width: cardWidth,
              isHighlighted: true,
            ),
            _QuickActionCard(
              icon: Icons.style_rounded,
              title: 'Tarot',
              subtitle: 'Falı',
              color: AppColors.mystic,
              route: Routes.tarot,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }
}

class _QuickActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String route;
  final double width;
  final bool isHighlighted;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.route,
    required this.width,
    this.isHighlighted = false,
  });

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.push(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.isHighlighted
                    ? widget.color.withOpacity(_isHovered ? 0.3 : 0.2)
                    : Colors.white.withOpacity(_isHovered ? 0.08 : 0.05),
                widget.isHighlighted
                    ? widget.color.withOpacity(_isHovered ? 0.15 : 0.1)
                    : Colors.white.withOpacity(_isHovered ? 0.04 : 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isHighlighted
                  ? widget.color.withOpacity(0.4)
                  : Colors.white.withOpacity(_isHovered ? 0.2 : 0.1),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0, -4, 0)
              : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.color, size: 24),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ZODIAC WHEEL SECTION - Interactive zodiac selector
// ═══════════════════════════════════════════════════════════════════════════

class _ZodiacWheelSection extends StatelessWidget {
  final ZodiacSign currentSign;

  const _ZodiacWheelSection({required this.currentSign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tüm Burçlar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '12 burcu keşfet ve günlük yorumlarını oku',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),

          // Zodiac grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ZodiacSign.values.map((sign) {
              final isCurrentSign = sign == currentSign;
              return _ZodiacChip(sign: sign, isSelected: isCurrentSign);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ZodiacChip extends StatefulWidget {
  final ZodiacSign sign;
  final bool isSelected;

  const _ZodiacChip({required this.sign, required this.isSelected});

  @override
  State<_ZodiacChip> createState() => _ZodiacChipState();
}

class _ZodiacChipState extends State<_ZodiacChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () =>
            context.push('/horoscope/${widget.sign.name.toLowerCase()}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.isSelected || _isHovered
                ? LinearGradient(
                    colors: [
                      widget.sign.color.withOpacity(0.3),
                      widget.sign.color.withOpacity(0.15),
                    ],
                  )
                : null,
            color: widget.isSelected || _isHovered
                ? null
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected
                  ? widget.sign.color.withOpacity(0.5)
                  : Colors.white.withOpacity(_isHovered ? 0.2 : 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.sign.symbol,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.isSelected || _isHovered
                      ? widget.sign.color
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.sign.nameTr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: widget.isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: widget.isSelected || _isHovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DISCOVERY SECTION - Featured tools
// ═══════════════════════════════════════════════════════════════════════════

class _DiscoverySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFFF6B9D),
                    Color(0xFF9D4EDD),
                  ],
                ).createShader(bounds),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Keşfet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'TÜM ÖZELLİKLER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ═══════════════════════════════════════════════════════════════
          // BURÇ & YORUMLAR
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '⭐ Burç Yorumları',
            color: const Color(0xFFFFD700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.wb_sunny_rounded,
                title: 'Günlük Yorum',
                color: const Color(0xFFFFD700),
                route: Routes.horoscope,
              ),
              _DiscoveryCard(
                icon: Icons.calendar_view_week_rounded,
                title: 'Haftalık Yorum',
                color: const Color(0xFFFF9800),
                route: Routes.weeklyHoroscope,
              ),
              _DiscoveryCard(
                icon: Icons.calendar_month_rounded,
                title: 'Aylık Yorum',
                color: const Color(0xFFFF5722),
                route: Routes.monthlyHoroscope,
              ),
              _DiscoveryCard(
                icon: Icons.calendar_today_rounded,
                title: 'Yıllık Yorum',
                color: const Color(0xFFF44336),
                route: Routes.yearlyHoroscope,
              ),
              _DiscoveryCard(
                icon: Icons.favorite_rounded,
                title: 'Aşk Yorumu',
                color: const Color(0xFFE91E63),
                route: Routes.loveHoroscope,
              ),
              _DiscoveryCard(
                icon: Icons.people_rounded,
                title: 'Burç Uyumu',
                color: const Color(0xFFFF4081),
                route: Routes.compatibility,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // DOĞUM HARİTASI & ANALİZLER
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🌌 Doğum Haritası & Analizler',
            color: const Color(0xFF9C27B0),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.pie_chart_rounded,
                title: 'Doğum Haritası',
                color: const Color(0xFF9C27B0),
                route: Routes.birthChart,
              ),
              _DiscoveryCard(
                icon: Icons.compare_arrows_rounded,
                title: 'Synastry',
                color: const Color(0xFFE91E63),
                route: Routes.synastry,
              ),
              _DiscoveryCard(
                icon: Icons.group_rounded,
                title: 'Composite',
                color: const Color(0xFFFF4081),
                route: Routes.compositeChart,
              ),
              _DiscoveryCard(
                icon: Icons.auto_graph_rounded,
                title: 'Vedic Harita',
                color: const Color(0xFFFF9800),
                route: Routes.vedicChart,
              ),
              _DiscoveryCard(
                icon: Icons.timeline_rounded,
                title: 'Progressions',
                color: const Color(0xFF3F51B5),
                route: Routes.progressions,
              ),
              _DiscoveryCard(
                icon: Icons.all_inclusive_rounded,
                title: 'Draconic',
                color: const Color(0xFF673AB7),
                route: Routes.draconicChart,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // ZAMAN & TRANSİTLER
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '⏰ Zaman & Transitler',
            color: const Color(0xFF2196F3),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.compare_arrows_rounded,
                title: 'Transitler',
                color: const Color(0xFF2196F3),
                route: Routes.transits,
              ),
              _DiscoveryCard(
                icon: Icons.access_time_rounded,
                title: 'Zamanlama',
                color: const Color(0xFF00BCD4),
                route: Routes.timing,
              ),
              _DiscoveryCard(
                icon: Icons.cake_rounded,
                title: 'Solar Return',
                color: const Color(0xFFFF9800),
                route: Routes.solarReturn,
              ),
              _DiscoveryCard(
                icon: Icons.loop_rounded,
                title: 'Saturn Dönüşü',
                color: const Color(0xFF607D8B),
                route: Routes.saturnReturn,
              ),
              _DiscoveryCard(
                icon: Icons.calendar_view_month_rounded,
                title: 'Yıllık Öngörü',
                color: const Color(0xFF4CAF50),
                route: Routes.yearAhead,
              ),
              _DiscoveryCard(
                icon: Icons.do_not_disturb_rounded,
                title: 'Void of Course',
                color: const Color(0xFF9E9E9E),
                route: Routes.voidOfCourse,
              ),
              _DiscoveryCard(
                icon: Icons.dark_mode_rounded,
                title: 'Tutulma Takvimi',
                color: const Color(0xFF37474F),
                route: Routes.eclipseCalendar,
              ),
              _DiscoveryCard(
                icon: Icons.event_note_rounded,
                title: 'Transit Takvimi',
                color: const Color(0xFF00ACC1),
                route: Routes.transitCalendar,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // NUMEROLOJİ & MİSTİK ARAÇLAR
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🔢 Numeroloji & Mistik Araçlar',
            color: const Color(0xFF7C4DFF),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.numbers_rounded,
                title: 'Numeroloji',
                color: const Color(0xFF7C4DFF),
                route: Routes.numerology,
              ),
              _DiscoveryCard(
                icon: Icons.style_rounded,
                title: 'Tarot',
                color: const Color(0xFF9C27B0),
                route: Routes.tarot,
              ),
              _DiscoveryCard(
                icon: Icons.account_tree_rounded,
                title: 'Kabala',
                color: const Color(0xFF4CAF50),
                route: Routes.kabbalah,
              ),
              _DiscoveryCard(
                icon: Icons.brightness_7_rounded,
                title: 'Aura',
                color: const Color(0xFFAB47BC),
                route: Routes.aura,
              ),
              _DiscoveryCard(
                icon: Icons.blur_circular_rounded,
                title: 'Chakra',
                color: const Color(0xFFFF5722),
                route: Routes.chakraAnalysis,
              ),
              _DiscoveryCard(
                icon: Icons.diamond_rounded,
                title: 'Kristal Rehberi',
                color: const Color(0xFF00BCD4),
                route: Routes.crystalGuide,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // RUHSAL & WELLNESS
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🧘 Ruhsal & Wellness',
            color: const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.spa_rounded,
                title: 'Günlük Ritüeller',
                color: const Color(0xFF4CAF50),
                route: Routes.dailyRituals,
              ),
              _DiscoveryCard(
                icon: Icons.nightlight_rounded,
                title: 'Ay Ritüelleri',
                color: const Color(0xFFC0C0C0),
                route: Routes.moonRituals,
              ),
              _DiscoveryCard(
                icon: Icons.grass_rounded,
                title: 'Ay Bahçeciliği',
                color: const Color(0xFF8BC34A),
                route: Routes.gardeningMoon,
              ),
              _DiscoveryCard(
                icon: Icons.psychology_rounded,
                title: 'Theta Healing',
                color: const Color(0xFF7C4DFF),
                route: Routes.thetaHealing,
              ),
              _DiscoveryCard(
                icon: Icons.self_improvement_rounded,
                title: 'Reiki',
                color: const Color(0xFFFF7043),
                route: Routes.reiki,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // İLERİ SEVİYE ASTROLOJİ
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🔮 İleri Seviye Astroloji',
            color: const Color(0xFFFFD700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.public_rounded,
                title: 'Dünya Haritası',
                color: const Color(0xFFFFD700),
                route: Routes.astroCartography,
              ),
              _DiscoveryCard(
                icon: Icons.event_available_rounded,
                title: 'Electional',
                color: const Color(0xFFFF9800),
                route: Routes.electional,
              ),
              _DiscoveryCard(
                icon: Icons.star_rounded,
                title: 'Asteroidler',
                color: const Color(0xFF9E9E9E),
                route: Routes.asteroids,
              ),
              _DiscoveryCard(
                icon: Icons.location_on_rounded,
                title: 'Local Space',
                color: const Color(0xFF795548),
                route: Routes.localSpace,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // REFERANS & İÇERİK
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '📚 Referans & İçerik',
            color: const Color(0xFF607D8B),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.menu_book_rounded,
                title: 'Sözlük',
                color: const Color(0xFF607D8B),
                route: Routes.glossary,
              ),
              _DiscoveryCard(
                icon: Icons.stars_rounded,
                title: 'Ünlüler',
                color: const Color(0xFFFFB74D),
                route: Routes.celebrities,
              ),
              _DiscoveryCard(
                icon: Icons.article_rounded,
                title: 'Makaleler',
                color: const Color(0xFF78909C),
                route: Routes.articles,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // RÜYA YORUMLARI
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🌙 Rüya Yorumları',
            color: const Color(0xFF5C6BC0),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.nights_stay_rounded,
                title: 'Rüya İzi',
                color: const Color(0xFF5C6BC0),
                route: Routes.dreamInterpretation,
              ),
              _DiscoveryCard(
                icon: Icons.auto_stories_rounded,
                title: 'Rüya Sözlüğü',
                color: const Color(0xFF7C4DFF),
                route: Routes.dreamGlossary,
              ),
              _DiscoveryCard(
                icon: Icons.share_rounded,
                title: 'Rüya Paylaş',
                color: const Color(0xFF9575CD),
                route: Routes.dreamShare,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // TÜM ÇÖZÜMLEMELER - Ana Katalog Butonu
          // ═══════════════════════════════════════════════════════════════
          _AllServicesButton(),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // KİŞİLİK ANALİZLERİ
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🎭 Kişilik Analizleri',
            color: const Color(0xFFFF4081),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.contrast_rounded,
                title: 'Gölge Benliğin',
                color: const Color(0xFF37474F),
                route: Routes.shadowSelf,
              ),
              _DiscoveryCard(
                icon: Icons.leaderboard_rounded,
                title: 'Liderlik Stilin',
                color: const Color(0xFFFF9800),
                route: Routes.leadershipStyle,
              ),
              _DiscoveryCard(
                icon: Icons.heart_broken_rounded,
                title: 'Kalp Yaran',
                color: const Color(0xFFE91E63),
                route: Routes.heartbreak,
              ),
              _DiscoveryCard(
                icon: Icons.flag_rounded,
                title: 'Red Flaglerin',
                color: const Color(0xFFF44336),
                route: Routes.redFlags,
              ),
              _DiscoveryCard(
                icon: Icons.verified_rounded,
                title: 'Green Flaglerin',
                color: const Color(0xFF4CAF50),
                route: Routes.greenFlags,
              ),
              _DiscoveryCard(
                icon: Icons.local_fire_department_rounded,
                title: 'Flört Stilin',
                color: const Color(0xFFFF6B9D),
                route: Routes.flirtStyle,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // MİSTİK KEŞİFLER
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🔮 Mistik Keşifler',
            color: const Color(0xFF9D4EDD),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.style_rounded,
                title: 'Tarot Kartın',
                color: const Color(0xFF9C27B0),
                route: Routes.tarotCard,
              ),
              _DiscoveryCard(
                icon: Icons.lens_blur_rounded,
                title: 'Aura Rengin',
                color: const Color(0xFFAB47BC),
                route: Routes.auraColor,
              ),
              _DiscoveryCard(
                icon: Icons.radio_button_checked_rounded,
                title: 'Çakra Dengen',
                color: const Color(0xFFFF5722),
                route: Routes.chakraBalance,
              ),
              _DiscoveryCard(
                icon: Icons.tag_rounded,
                title: 'Yaşam Sayın',
                color: const Color(0xFF7C4DFF),
                route: Routes.lifeNumber,
              ),
              _DiscoveryCard(
                icon: Icons.account_tree_rounded,
                title: 'Kabala Yolun',
                color: const Color(0xFF4CAF50),
                route: Routes.kabbalaPath,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // İLİŞKİ ANALİZLERİ
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '💕 İlişki Analizleri',
            color: const Color(0xFFE91E63),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.favorite_border_rounded,
                title: 'Uyum Analizi',
                color: const Color(0xFFE91E63),
                route: Routes.compatibilityAnalysis,
              ),
              _DiscoveryCard(
                icon: Icons.favorite_rounded,
                title: 'Ruh Eşin',
                color: const Color(0xFFFF4081),
                route: Routes.soulMate,
              ),
              _DiscoveryCard(
                icon: Icons.loop_rounded,
                title: 'İlişki Karman',
                color: const Color(0xFF9C27B0),
                route: Routes.relationshipKarma,
              ),
              _DiscoveryCard(
                icon: Icons.star_rounded,
                title: 'Ünlü İkizin',
                color: const Color(0xFFFFD700),
                route: Routes.celebrityTwin,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // AI ASİSTANLAR
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '🤖 AI Asistanlar',
            color: const Color(0xFF6A1B9A),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.auto_awesome_rounded,
                title: 'Kozmoz İzi',
                color: const Color(0xFF6A1B9A),
                route: Routes.kozmoz,
              ),
              _DiscoveryCard(
                icon: Icons.nights_stay_rounded,
                title: 'Rüya İzi',
                color: const Color(0xFF5C6BC0),
                route: Routes.dreamInterpretation,
              ),
              _DiscoveryCard(
                icon: Icons.star_rounded,
                title: 'Burç Yorumcusu',
                color: const Color(0xFFFF6B9D),
                route: Routes.horoscope,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ═══════════════════════════════════════════════════════════════
          // PAYLAŞIM & PROFİL
          // ═══════════════════════════════════════════════════════════════
          _DiscoveryCategoryHeader(
            title: '📱 Paylaşım & Profil',
            color: const Color(0xFFE91E63),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DiscoveryCard(
                icon: Icons.share_rounded,
                title: 'Kozmik Paylaşım',
                color: const Color(0xFFE91E63),
                route: Routes.cosmicShare,
              ),
              _DiscoveryCard(
                icon: Icons.people_alt_rounded,
                title: 'Kayıtlı Profiller',
                color: const Color(0xFF9C27B0),
                route: Routes.savedProfiles,
              ),
              _DiscoveryCard(
                icon: Icons.compare_rounded,
                title: 'Karşılaştır',
                color: const Color(0xFFFF4081),
                route: Routes.comparison,
              ),
              _DiscoveryCard(
                icon: Icons.workspace_premium_rounded,
                title: 'Premium',
                color: const Color(0xFFFFD700),
                route: Routes.premium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Kategori başlığı widget'ı
class _DiscoveryCategoryHeader extends StatelessWidget {
  final String title;
  final Color color;

  const _DiscoveryCategoryHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _DiscoveryCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final String route;

  const _DiscoveryCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.route,
  });

  @override
  State<_DiscoveryCard> createState() => _DiscoveryCardState();
}

class _DiscoveryCardState extends State<_DiscoveryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.push(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withOpacity(0.15)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withOpacity(0.4)
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: 22),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TÜM ÇÖZÜMLEMELER BUTTON
// ═══════════════════════════════════════════════════════════════════════════

class _AllServicesButton extends StatefulWidget {
  @override
  State<_AllServicesButton> createState() => _AllServicesButtonState();
}

class _AllServicesButtonState extends State<_AllServicesButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.push(Routes.allServices),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(
                      const Color(0xFF9C27B0),
                      const Color(0xFFE040FB),
                      (_controller.value * 2).clamp(0, 1),
                    )!.withOpacity(_isHovered ? 0.4 : 0.25),
                    Color.lerp(
                      const Color(0xFF673AB7),
                      const Color(0xFF7C4DFF),
                      ((_controller.value - 0.3).abs() * 2).clamp(0, 1),
                    )!.withOpacity(_isHovered ? 0.35 : 0.2),
                    Color.lerp(
                      const Color(0xFFE91E63),
                      const Color(0xFFFF4081),
                      ((_controller.value - 0.6).abs() * 2).clamp(0, 1),
                    )!.withOpacity(_isHovered ? 0.3 : 0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isHovered
                      ? const Color(0xFFE040FB).withOpacity(0.6)
                      : const Color(0xFF9C27B0).withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: const Color(0xFF9C27B0).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated gradient icon
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        const Color(0xFFE040FB),
                        const Color(0xFFFFD700),
                        const Color(0xFFE040FB),
                      ],
                      stops: [0.0, _controller.value, 1.0],
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.explore_rounded,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFE040FB),
                            Color(0xFFFFD700),
                            Color(0xFFFF4081),
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Tüm Çözümlemeler',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kozmik yolculuğun için 80+ araç',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _isHovered ? 0.25 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                      color: _isHovered
                          ? const Color(0xFFE040FB)
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// HOUSE SYSTEM SECTION - Ev Sistemi
// ═══════════════════════════════════════════════════════════════════════════

class _HouseSystemSection extends StatelessWidget {
  const _HouseSystemSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90A4).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: Color(0xFF4A90A4),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🏠 Astrolojik Evler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '12 astrolojik ev ve yaşam alanları',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push(Routes.birthChart),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90A4), Color(0xFF357ABD)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore_outlined, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Ev Sistemini Keşfet',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// VENUS ONE LOGO
// ═══════════════════════════════════════════════════════════════════════════

class _VenusOneLogo extends StatefulWidget {
  @override
  State<_VenusOneLogo> createState() => _VenusOneLogoState();
}

class _VenusOneLogoState extends State<_VenusOneLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.push(Routes.allServices),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cosmicPurple.withOpacity(_isHovered ? 0.4 : 0.3),
                AppColors.auroraStart.withOpacity(_isHovered ? 0.3 : 0.2),
                AppColors.deepSpace.withOpacity(_isHovered ? 0.5 : 0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.starGold.withOpacity(_isHovered ? 0.8 : 0.5),
              width: _isHovered ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.starGold.withOpacity(_isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 20 : 12,
                spreadRadius: _isHovered ? 2 : 0,
              ),
              BoxShadow(
                color: AppColors.auroraStart.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Scottish Shorthair Kedi
              Stack(
                alignment: Alignment.center,
                children: [
                  // Kedi arka plan glow
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.starGold.withOpacity(
                                0.3 +
                                    0.1 *
                                        math.sin(
                                          _controller.value * 2 * math.pi,
                                        ),
                              ),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Venus Logo
                  Image.asset(
                    'assets/brand/venus-logo/png/venus-logo-72.png',
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Venus One yazısı
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppColors.starGold,
                        const Color(0xFFFFE55C),
                        AppColors.starGold,
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Venus One',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  // Alt yazı - sihirli tema
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final sparkle = _controller.value < 0.5 ? '✦' : '✧';
                      return Text(
                        '$sparkle Kozmik Rehber $sparkle',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: AppColors.moonSilver.withOpacity(0.8),
                          letterSpacing: 1,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // Sihirli değnek (büyük)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _isHovered
                        ? 0.1 * math.sin(_controller.value * 4 * math.pi)
                        : 0,
                    child: const Text('🪄', style: TextStyle(fontSize: 18)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// KOZMOZ HEADER BUTTON - İsim yanında kompakt versiyon
// ═══════════════════════════════════════════════════════════════════════════

class _KozmozHeaderButton extends StatefulWidget {
  final VoidCallback onTap;

  const _KozmozHeaderButton({required this.onTap});

  @override
  State<_KozmozHeaderButton> createState() => _KozmozHeaderButtonState();
}

class _KozmozHeaderButtonState extends State<_KozmozHeaderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final glowValue = 0.3 + 0.3 * _glowController.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6A1B9A).withOpacity(_isHovered ? 0.6 : 0.4),
                    const Color(0xFF9C27B0).withOpacity(_isHovered ? 0.5 : 0.3),
                    const Color(0xFFE040FB).withOpacity(_isHovered ? 0.4 : 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(
                    0xFFE040FB,
                  ).withOpacity(_isHovered ? 0.8 : 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9C27B0).withOpacity(glowValue),
                    blurRadius: _isHovered ? 16 : 10,
                    spreadRadius: _isHovered ? 2 : 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // AI ikonu
                  const Text('🌌', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Text(
                    'Kozmoz İzi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DREAM HEADER BUTTON - İsim yanında kompakt versiyon
// ═══════════════════════════════════════════════════════════════════════════

class _DreamHeaderButton extends StatefulWidget {
  final VoidCallback onTap;

  const _DreamHeaderButton({required this.onTap});

  @override
  State<_DreamHeaderButton> createState() => _DreamHeaderButtonState();
}

class _DreamHeaderButtonState extends State<_DreamHeaderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _moonController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _moonController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _moonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _moonController,
          builder: (context, child) {
            final glowValue = 0.2 + 0.2 * _moonController.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1A237E).withOpacity(_isHovered ? 0.6 : 0.4),
                    const Color(0xFF303F9F).withOpacity(_isHovered ? 0.5 : 0.3),
                    const Color(0xFF5C6BC0).withOpacity(_isHovered ? 0.4 : 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(
                    0xFF7C4DFF,
                  ).withOpacity(_isHovered ? 0.8 : 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3F51B5).withOpacity(glowValue),
                    blurRadius: _isHovered ? 16 : 10,
                    spreadRadius: _isHovered ? 2 : 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rüya ikonu
                  const Text('🌙', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Text(
                    'Rüya İzi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// HOROSCOPE HEADER BUTTON - Burç Yorumları AI Asistanı
// ═══════════════════════════════════════════════════════════════════════════

class _HoroscopeHeaderButton extends StatefulWidget {
  final VoidCallback onTap;

  const _HoroscopeHeaderButton({required this.onTap});

  @override
  State<_HoroscopeHeaderButton> createState() => _HoroscopeHeaderButtonState();
}

class _HoroscopeHeaderButtonState extends State<_HoroscopeHeaderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _starController,
          builder: (context, child) {
            final glowValue = 0.25 + 0.25 * _starController.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFF6B9D).withOpacity(_isHovered ? 0.6 : 0.4),
                    const Color(0xFFE91E63).withOpacity(_isHovered ? 0.5 : 0.3),
                    const Color(0xFFAD1457).withOpacity(_isHovered ? 0.4 : 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(
                    0xFFFF6B9D,
                  ).withOpacity(_isHovered ? 0.8 : 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE91E63).withOpacity(glowValue),
                    blurRadius: _isHovered ? 16 : 10,
                    spreadRadius: _isHovered ? 2 : 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Burç ikonu
                  const Text('⭐', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Text(
                    'Burç Yorumu',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
