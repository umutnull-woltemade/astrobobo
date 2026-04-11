import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/mystical_colors.dart';
import '../../../data/models/zodiac_sign.dart' as zodiac;
import '../../../data/models/planet.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/cosmic_share_content_service.dart';
import '../../../data/services/instagram_share_service.dart';

/// MOBILE OPTIMIZATION FLAG
/// On mobile devices (<768px), disable heavy animations for performance
bool _shouldUseLiteMode(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  // Mobile: < 768px, use lite mode (no heavy animations)
  // Also check if on mobile platform (iOS/Android)
  if (width < 768) return true;
  if (!kIsWeb) {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.android) {
      return width < 768;
    }
  }
  return false;
}

/// Viral Personal Cosmic Horoscope Share Screen
/// Optimized for Instagram/X sharing (9:16 screenshot)
///
/// PERFORMANCE OPTIMIZATIONS (Mobile Lite Mode):
/// - Disable complex animations on mobile
/// - Reduce shadow/glow effects
/// - Simpler gradients
/// - No parallax or heavy effects
class CosmicShareScreen extends ConsumerStatefulWidget {
  const CosmicShareScreen({super.key});

  @override
  ConsumerState<CosmicShareScreen> createState() => _CosmicShareScreenState();
}

class _CosmicShareScreenState extends ConsumerState<CosmicShareScreen> {
  final GlobalKey _shareCardKey = GlobalKey();
  bool _isCapturing = false;
  late CosmicShareContent _content;
  late zodiac.ZodiacSign _sign;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    _sign = userProfile?.sunSign ?? zodiac.ZodiacSign.aries;

    // Generate content
    _content = CosmicShareContentService.generateContent(
      sunSign: _sign,
      birthDate: userProfile?.birthDate ?? DateTime(1990, 1, 1),
      risingSign: userProfile?.risingSign,
      moonSign: userProfile?.moonSign,
    );

    return Scaffold(
      backgroundColor: MysticalColors.bgDeepSpace,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // Share Card (for screenshot)
                    // MOBILE OPTIMIZATION: Disable heavy animations on mobile
                    Builder(
                      builder: (context) {
                        final liteMode = _shouldUseLiteMode(context);
                        final card = RepaintBoundary(
                          key: _shareCardKey,
                          child: _CosmicShareCard(
                            content: _content,
                            sign: _sign,
                            userName: userProfile?.name,
                            liteMode: liteMode,
                          ),
                        );
                        // Skip animations in lite mode for performance
                        if (liteMode) {
                          return card;
                        }
                        return card
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              curve: Curves.easeOutBack,
                            );
                      },
                    ),
                    const SizedBox(height: 24),
                    // Share CTA
                    _buildShareCTA(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: MysticalColors.textPrimary),
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              'Kozmik Paylaşım',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MysticalColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48), // Balance for close button
        ],
      ),
    );
  }

  Widget _buildShareCTA(BuildContext context) {
    return Column(
      children: [
        // Viral Hook Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: MysticalColors.amethyst.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: MysticalColors.amethyst.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Text(
                _content.viralHook,
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MysticalColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _content.sharePrompt,
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 13,
                  color: MysticalColors.textMuted,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 20),

        // Share Button
        GestureDetector(
          onTap: _isCapturing ? null : _captureAndShare,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MysticalColors.amethyst, MysticalColors.cosmicPurple],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: MysticalColors.amethyst.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isCapturing)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                else
                  const Icon(Icons.share, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  _isCapturing ? 'Hazırlanıyor...' : 'Hikayende Paylaş',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.9, 0.9)),

        const SizedBox(height: 12),

        Text(
          'Instagram hikayende kozmik enerjini paylaş!',
          style: GoogleFonts.raleway(
            fontSize: 12,
            color: MysticalColors.textMuted,
          ),
        ).animate().fadeIn(delay: 600.ms),
      ],
    );
  }

  Future<void> _captureAndShare() async {
    setState(() => _isCapturing = true);

    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final boundary =
          _shareCardKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) {
        _showErrorFeedback('Görsel oluşturulamadı');
        return;
      }

      // Build share text with hashtags
      final shareText =
          'Bugünün kozmik enerjisi benimle! ${_content.heroBlock.moonPhaseEmoji} ${_sign.symbol} Evrenin fısıltılarını dinle...';
      final hashtags =
          '#venusone #astroloji #${_sign.name.toLowerCase()} #kozmikenerji #burcyorumu #gunlukburc';

      // Use the new Instagram share service
      final result = await InstagramShareService.shareCosmicContent(
        boundary: boundary,
        shareText: shareText,
        hashtags: hashtags,
      );

      if (!mounted) return;

      if (result.success) {
        _showSuccessFeedback(result.message);
      } else if (result.error == ShareError.webFallback &&
          result.fallbackData != null) {
        // Show web fallback dialog
        _showWebFallbackDialog(result.fallbackData!);
      } else if (result.error == ShareError.dismissed) {
        // User cancelled - no feedback needed
      } else {
        _showErrorFeedback(result.message);
      }
    } catch (e) {
      if (mounted) {
        _showErrorFeedback('Paylaşım hatası: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  void _showSuccessFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: MysticalColors.auroraGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: MysticalColors.solarOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showWebFallbackDialog(ShareFallbackData fallback) {
    showModalBottomSheet(
      context: context,
      backgroundColor: MysticalColors.bgCosmic,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: MysticalColors.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.info_outline,
              color: MysticalColors.etherealCyan,
              size: 32,
            ),
            const SizedBox(height: 16),
            Text(
              'Instagram\'da Paylaş',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: MysticalColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...fallback.instructions.map(
              (instruction) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_right,
                      size: 16,
                      color: MysticalColors.amethyst,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        instruction,
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          color: MysticalColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: fallback.copyText),
                      );
                      if (mounted) {
                        Navigator.pop(context);
                        _showSuccessFeedback('Metin kopyalandı!');
                      }
                    },
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text('Metni Kopyala'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MysticalColors.textPrimary,
                      side: BorderSide(
                        color: MysticalColors.amethyst.withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await InstagramShareService.openInstagram();
                      if (mounted) Navigator.pop(context);
                    },
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Instagram\'ı Aç'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MysticalColors.amethyst,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// The main shareable card widget - optimized for 9:16 aspect ratio
///
/// MOBILE OPTIMIZATION (liteMode):
/// - Reduced shadows and glows
/// - Simpler gradients
/// - No complex custom painters
/// - Smaller blur radius
class _CosmicShareCard extends StatelessWidget {
  final CosmicShareContent content;
  final zodiac.ZodiacSign sign;
  final String? userName;
  final bool liteMode;

  const _CosmicShareCard({
    required this.content,
    required this.sign,
    this.userName,
    this.liteMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 32;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MysticalColors.bgCosmic,
            MysticalColors.cosmicPurple.withOpacity(0.95),
            MysticalColors.midnightBlue,
            MysticalColors.bgDeepSpace,
          ],
          stops: const [0.0, 0.25, 0.6, 1.0],
        ),
        // MOBILE OPTIMIZATION: Reduced shadow effects in lite mode
        boxShadow: liteMode
            ? [
                BoxShadow(
                  color: sign.color.withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: sign.color.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
      ),
      child: Stack(
        children: [
          // Background decorations - SKIP in lite mode for performance
          if (!liteMode)
            Positioned.fill(
              child: CustomPaint(painter: _CosmicBackgroundPainter(sign.color)),
            ),
          // Stars - REDUCED in lite mode
          ..._buildStars(screenWidth, liteMode: liteMode),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Section 1: Hero Identity Block
                _buildHeroBlock(),
                const SizedBox(height: 20),

                // Section 2: Personal Cosmic Message
                _buildPersonalMessage(),
                const SizedBox(height: 20),

                // Section 3: Cosmic Energy Meter
                _buildEnergyMeter(),
                const SizedBox(height: 20),

                // Section 4: Planetary Influence
                _buildPlanetaryInfluence(),
                const SizedBox(height: 20),

                // Section 5: Shadow & Light Duality
                _buildShadowLightDuality(),
                const SizedBox(height: 20),

                // Section 6: Cosmic Advice
                _buildCosmicAdvice(),
                const SizedBox(height: 20),

                // Section 7: Tarot/Symbolic Message
                _buildSymbolicMessage(),
                const SizedBox(height: 20),

                // Section 8: Micro Messages (Viral Core)
                _buildMicroMessages(),
                const SizedBox(height: 20),

                // Section 9: Rüya İzi (Dream Insight) - NEW
                _buildDreamInsight(),
                const SizedBox(height: 20),

                // Section 10: Numeroloji (Numerology) - NEW
                _buildNumerologyInsight(),
                const SizedBox(height: 20),

                // Section 11: Tantra Wisdom - NEW
                _buildTantraWisdom(),
                const SizedBox(height: 20),

                // Section 12: Chakra Snapshot - NEW
                _buildChakraSnapshot(),
                const SizedBox(height: 20),

                // Section 13: Cosmic Timing - NEW
                _buildTimingHint(),
                const SizedBox(height: 20),

                // Section 14: Collective Moment (Social Proof)
                _buildCollectiveMoment(),
                const SizedBox(height: 20),

                // Section 15: Soft Premium Curiosity
                _buildPremiumCuriosity(),
                const SizedBox(height: 20),

                // Branding
                _buildBranding(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MOBILE OPTIMIZATION: Reduced star count and no shadows in lite mode
  List<Widget> _buildStars(double width, {bool liteMode = false}) {
    final random = math.Random(42);
    // MOBILE: Reduce star count from 30 to 10 for performance
    final starCount = liteMode ? 10 : 30;

    return List.generate(starCount, (i) {
      final x = random.nextDouble() * width;
      final y = random.nextDouble() * 1200;
      final size = random.nextDouble() * 2 + 1;
      final opacity = random.nextDouble() * 0.5 + 0.3;

      return Positioned(
        left: x,
        top: y,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(opacity),
            // MOBILE: No shadow in lite mode
            boxShadow: liteMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.white.withOpacity(opacity * 0.5),
                      blurRadius: size * 2,
                      spreadRadius: size * 0.5,
                    ),
                  ],
          ),
        ),
      );
    });
  }

  /// Section 1: Hero Cosmic Identity Block
  Widget _buildHeroBlock() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            sign.color.withOpacity(0.15),
            MysticalColors.cosmicPurple.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: sign.color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          // Date and Moon Phase
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  content.heroBlock.dateFormatted,
                  style: GoogleFonts.raleway(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: MysticalColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                content.heroBlock.moonPhaseEmoji,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            content.heroBlock.moonPhaseText,
            style: GoogleFonts.raleway(
              fontSize: 10,
              color: MysticalColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),

          // Sign Symbol
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  sign.color.withOpacity(0.4),
                  sign.color.withOpacity(0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: sign.color.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(
                sign.symbol,
                style: TextStyle(
                  fontSize: 44,
                  color: sign.color,
                  shadows: [
                    Shadow(color: sign.color.withOpacity(0.5), blurRadius: 10),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Cosmic Title
          Text(
            content.heroBlock.signTitle,
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: MysticalColors.textPrimary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sign.nameTr,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: sign.color,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),

          // Cosmic Headline
          Text(
            content.heroBlock.cosmicHeadline,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MysticalColors.starGold,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Section 2: Personal Cosmic Message
  Widget _buildPersonalMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MysticalColors.bgElevated.withOpacity(0.5),
        border: Border.all(color: MysticalColors.amethyst.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 16,
                color: MysticalColors.starGold,
              ),
              const SizedBox(width: 8),
              Text(
                'Bugünün Mesajı',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.textGold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content.personalMessage.message,
            style: GoogleFonts.merriweather(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: MysticalColors.textPrimary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: sign.color.withOpacity(0.15),
              ),
              child: Text(
                content.personalMessage.emotionalCore,
                style: GoogleFonts.raleway(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: sign.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 3: Cosmic Energy Meter
  Widget _buildEnergyMeter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MysticalColors.nebulaTeal.withOpacity(0.2),
            MysticalColors.cosmicPurple.withOpacity(0.2),
          ],
        ),
        border: Border.all(color: MysticalColors.nebulaTeal.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bugünün Kozmik Enerjisi',
            style: GoogleFonts.raleway(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: MysticalColors.etherealCyan,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),

          // Energy Level
          _buildEnergyBar(
            label: 'Enerji Seviyesi',
            value: content.energyMeter.energyLevel,
            color: MysticalColors.auroraGreen,
            description: content.energyMeter.energyDescription,
          ),
          const SizedBox(height: 14),

          // Intuition
          _buildEnergyBar(
            label: 'Sezgi Gücü',
            value: content.energyMeter.intuitionStrength,
            color: MysticalColors.amethyst,
            description: content.energyMeter.intuitionDescription,
          ),
          const SizedBox(height: 14),

          // Emotional Intensity
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _getIntensityColor(
                    content.energyMeter.emotionalIntensity,
                  ).withOpacity(0.2),
                ),
                child: Text(
                  content.energyMeter.emotionalIntensity,
                  style: GoogleFonts.raleway(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getIntensityColor(
                      content.energyMeter.emotionalIntensity,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  content.energyMeter.intensityDescription,
                  style: GoogleFonts.raleway(
                    fontSize: 10,
                    color: MysticalColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action/Reflection Balance
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.05),
            ),
            child: Row(
              children: [
                Text(
                  'Düşün',
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    color: MysticalColors.textMuted,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor:
                            content.energyMeter.actionReflectionBalance,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: LinearGradient(
                              colors: [
                                MysticalColors.stardustBlue,
                                MysticalColors.solarOrange,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Hareket',
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    color: MysticalColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyBar({
    required String label,
    required int value,
    required Color color,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.raleway(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: MysticalColors.textSecondary,
              ),
            ),
            Text(
              '$value%',
              style: GoogleFonts.raleway(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value / 100,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.7), color],
                  ),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.4), blurRadius: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.raleway(
            fontSize: 9,
            color: MysticalColors.textMuted,
          ),
        ),
      ],
    );
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity) {
      case 'Sakin':
        return MysticalColors.auroraGreen;
      case 'Yükselen':
        return MysticalColors.amber;
      case 'Yoğun':
        return MysticalColors.solarOrange;
      case 'Fırtınalı':
        return MysticalColors.nebulaRose;
      default:
        return MysticalColors.textSecondary;
    }
  }

  /// Section 4: Planetary Influence Snapshot
  Widget _buildPlanetaryInfluence() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MysticalColors.bgElevated.withOpacity(0.4),
        border: Border.all(color: MysticalColors.starGold.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Planet Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content.planetaryInfluence.planetSymbol,
                style: TextStyle(
                  fontSize: 28,
                  color: MysticalColors.starGold,
                  shadows: [
                    Shadow(
                      color: MysticalColors.starGold.withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dominant Gezegen',
                    style: GoogleFonts.raleway(
                      fontSize: 10,
                      color: MysticalColors.textMuted,
                    ),
                  ),
                  Text(
                    content.planetaryInfluence.dominantPlanet.nameTr,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: MysticalColors.starGold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Activates / Blocks
          Row(
            children: [
              Expanded(
                child: _buildInfluenceChip(
                  icon: Icons.bolt,
                  label: 'Aktive Ediyor',
                  value: content.planetaryInfluence.activates,
                  color: MysticalColors.auroraGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildInfluenceChip(
                  icon: Icons.block,
                  label: 'Engelliyor',
                  value: content.planetaryInfluence.blocks,
                  color: MysticalColors.nebulaRose,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // One Action
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MysticalColors.starGold.withOpacity(0.1),
              border: Border.all(
                color: MysticalColors.starGold.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'BUGÜNKÜ EYLEM',
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: MysticalColors.textGold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content.planetaryInfluence.oneAction,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MysticalColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Exclusivity
          Text(
            content.planetaryInfluence.exclusivityText,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 9,
              fontStyle: FontStyle.italic,
              color: MysticalColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfluenceChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.raleway(
              fontSize: 11,
              color: MysticalColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Section 5: Shadow & Light Duality
  Widget _buildShadowLightDuality() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            MysticalColors.midnightBlue.withOpacity(0.6),
            MysticalColors.cosmicPurple.withOpacity(0.6),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Gölge & Işık',
            style: GoogleFonts.playfairDisplay(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MysticalColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shadow Side
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.nights_stay,
                            size: 14,
                            color: MysticalColors.violetMist,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Gölge',
                            style: GoogleFonts.raleway(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: MysticalColors.violetMist,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildShadowItem(
                        'Meydan Okuma',
                        content.shadowLight.shadowChallenge,
                      ),
                      const SizedBox(height: 8),
                      _buildShadowItem('Korku', content.shadowLight.shadowFear),
                      const SizedBox(height: 8),
                      _buildShadowItem(
                        'Kalıp',
                        content.shadowLight.shadowPattern,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Light Side
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MysticalColors.starGold.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            size: 14,
                            color: MysticalColors.starGold,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Işık',
                            style: GoogleFonts.raleway(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: MysticalColors.starGold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildLightItem('Güç', content.shadowLight.lightStrength),
                      const SizedBox(height: 8),
                      _buildLightItem(
                        'Fırsat',
                        content.shadowLight.lightOpportunity,
                      ),
                      const SizedBox(height: 8),
                      _buildLightItem(
                        'Aura',
                        content.shadowLight.lightMagnetic,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShadowItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: MysticalColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.raleway(
            fontSize: 10,
            color: MysticalColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLightItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: MysticalColors.textGold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.raleway(
            fontSize: 10,
            color: MysticalColors.textPrimary,
          ),
        ),
      ],
    );
  }

  /// Section 6: Cosmic Advice (Shareable Statements)
  Widget _buildCosmicAdvice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MysticalColors.amethyst.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.format_quote,
                size: 16,
                color: MysticalColors.amethyst,
              ),
              const SizedBox(width: 8),
              Text(
                'Kozmik Öğütler',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...content.cosmicAdvice.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: entry.key < content.cosmicAdvice.length - 1 ? 12 : 0,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      MysticalColors.amethyst.withOpacity(
                        0.1 + entry.key * 0.05,
                      ),
                      MysticalColors.cosmicPurple.withOpacity(0.2),
                    ],
                  ),
                ),
                child: Text(
                  '"${entry.value}"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: MysticalColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Section 7: Tarot/Symbolic Message
  Widget _buildSymbolicMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            MysticalColors.orchid.withOpacity(0.15),
            MysticalColors.cosmicPurple.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: MysticalColors.orchid.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Type badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MysticalColors.orchid.withOpacity(0.2),
            ),
            child: Text(
              content.symbolicMessage.type.toUpperCase(),
              style: GoogleFonts.raleway(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: MysticalColors.orchid,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Symbol and Title
          Text(
            content.symbolicMessage.symbol,
            style: TextStyle(
              fontSize: 36,
              color: MysticalColors.orchid,
              shadows: [
                Shadow(
                  color: MysticalColors.orchid.withOpacity(0.5),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content.symbolicMessage.title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MysticalColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // Meaning
          Text(
            content.symbolicMessage.meaning,
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 12,
              color: MysticalColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Section 8: Micro Messages (Viral Core - Ultra Shareable)
  Widget _buildMicroMessages() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MysticalColors.starGold.withOpacity(0.08),
            MysticalColors.cosmicPurple.withOpacity(0.15),
          ],
        ),
        border: Border.all(color: MysticalColors.starGold.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '✦',
                style: TextStyle(fontSize: 14, color: MysticalColors.starGold),
              ),
              const SizedBox(width: 8),
              Text(
                'Bugünün Sesi',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.textGold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '✦',
                style: TextStyle(fontSize: 14, color: MysticalColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Micro messages - screenshot friendly
          ...content.microMessages.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: entry.key < content.microMessages.length - 1 ? 14 : 0,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.25),
                  border: Border.all(
                    color: MysticalColors.starGold.withOpacity(0.15),
                  ),
                ),
                child: Text(
                  content.microMessages[entry.key],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MysticalColors.textPrimary,
                    letterSpacing: 0.3,
                    height: 1.4,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Section 9: Collective Moment (Social Proof)
  Widget _buildCollectiveMoment() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MysticalColors.nebulaTeal.withOpacity(0.15),
        border: Border.all(color: MysticalColors.nebulaTeal.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MysticalColors.nebulaTeal.withOpacity(0.2),
            ),
            child: Icon(
              Icons.groups_outlined,
              size: 20,
              color: MysticalColors.etherealCyan,
            ),
          ),
          const SizedBox(height: 12),

          // Main text
          Text(
            content.collectiveMoment.mainText,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: MysticalColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),

          // Sub text
          Text(
            content.collectiveMoment.subText,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: MysticalColors.etherealCyan,
            ),
          ),
        ],
      ),
    );
  }

  /// Section 10: Soft Premium Curiosity (No Lock, No Pressure)
  Widget _buildPremiumCuriosity() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MysticalColors.violetMist.withOpacity(0.08),
            MysticalColors.cosmicPurple.withOpacity(0.12),
          ],
        ),
      ),
      child: Column(
        children: [
          // Subtle divider dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDot(),
              const SizedBox(width: 8),
              _buildDot(),
              const SizedBox(width: 8),
              _buildDot(),
            ],
          ),
          const SizedBox(height: 14),

          // Curiosity text
          Text(
            content.premiumCuriosity.curiosityText,
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: MysticalColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),

          // Invitation text (soft, no CTA)
          Text(
            content.premiumCuriosity.invitationText,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 11,
              color: MysticalColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MysticalColors.violetMist.withOpacity(0.5),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MASTER LEVEL: NEW SECTIONS
  // ═══════════════════════════════════════════════════════════════

  /// Section 9: Rüya İzi - Dream Insight
  Widget _buildDreamInsight() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MysticalColors.midnightBlue.withOpacity(0.8),
            MysticalColors.cosmicPurple.withOpacity(0.6),
          ],
        ),
        border: Border.all(color: MysticalColors.moonSilver.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Header with moon icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🌙', style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                'Rüya İzi',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.moonSilver,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Dream symbol
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MysticalColors.moonSilver.withOpacity(0.1),
              border: Border.all(
                color: MysticalColors.moonSilver.withOpacity(0.3),
              ),
            ),
            child: Center(
              child: Text(
                content.dreamInsight.symbol,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Symbol meaning
          Text(
            content.dreamInsight.symbolMeaning,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: MysticalColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // Dream prompt
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Text(
              content.dreamInsight.dreamPrompt,
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: MysticalColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Night message
          Text(
            content.dreamInsight.nightMessage,
            style: GoogleFonts.raleway(
              fontSize: 10,
              color: MysticalColors.moonSilver,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Section 10: Numerology Insight
  Widget _buildNumerologyInsight() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            MysticalColors.starGold.withOpacity(0.1),
            MysticalColors.amber.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: MysticalColors.starGold.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '✦',
                style: TextStyle(fontSize: 14, color: MysticalColors.starGold),
              ),
              const SizedBox(width: 8),
              Text(
                'Bugünün Sayısı',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.textGold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '✦',
                style: TextStyle(fontSize: 14, color: MysticalColors.starGold),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Big number display
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  MysticalColors.starGold.withOpacity(0.3),
                  MysticalColors.starGold.withOpacity(0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: MysticalColors.starGold.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${content.numerologyInsight.dayNumber}',
                style: GoogleFonts.cinzel(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: MysticalColors.starGold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Number meaning
          Text(
            content.numerologyInsight.numberMeaning,
            style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: MysticalColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content.numerologyInsight.vibration,
            style: GoogleFonts.raleway(
              fontSize: 11,
              color: MysticalColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          // Lucky hour
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MysticalColors.starGold.withOpacity(0.15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: MysticalColors.starGold,
                ),
                const SizedBox(width: 6),
                Text(
                  'Şanslı Saat: ${content.numerologyInsight.luckyHour}',
                  style: GoogleFonts.raleway(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: MysticalColors.starGold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section 11: Tantra Wisdom
  Widget _buildTantraWisdom() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MysticalColors.nebulaRose.withOpacity(0.08),
            MysticalColors.orchid.withOpacity(0.12),
          ],
        ),
        border: Border.all(color: MysticalColors.nebulaRose.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Header
          Text(
            '༄ Tantra ༄',
            style: GoogleFonts.playfairDisplay(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MysticalColors.nebulaRose,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 14),

          // Breath focus
          _buildTantraItem(
            icon: '🌬️',
            label: 'Nefes',
            value: content.tantraWisdom.breathFocus,
          ),
          const SizedBox(height: 10),

          // Awareness point
          _buildTantraItem(
            icon: '👁️',
            label: 'Farkındalık',
            value: content.tantraWisdom.awarenessPoint,
          ),
          const SizedBox(height: 10),

          // Inner connection
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MysticalColors.nebulaRose.withOpacity(0.1),
            ),
            child: Text(
              content.tantraWisdom.innerConnection,
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: MysticalColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTantraItem({
    required String icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.raleway(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.nebulaRose,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.raleway(
                  fontSize: 11,
                  color: MysticalColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Section 12: Chakra Snapshot
  Widget _buildChakraSnapshot() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MysticalColors.auroraGreen.withOpacity(0.1),
            MysticalColors.etherealCyan.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: MysticalColors.auroraGreen.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content.chakraSnapshot.chakraSymbol,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Text(
                content.chakraSnapshot.activeChakra,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.auroraGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Chakra message
          Text(
            content.chakraSnapshot.chakraMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 12,
              color: MysticalColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

          // Balance bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Denge Seviyesi',
                    style: GoogleFonts.raleway(
                      fontSize: 10,
                      color: MysticalColors.textMuted,
                    ),
                  ),
                  Text(
                    '${(content.chakraSnapshot.balanceLevel * 100).round()}%',
                    style: GoogleFonts.raleway(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: MysticalColors.auroraGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: content.chakraSnapshot.balanceLevel,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(
                          colors: [
                            MysticalColors.auroraGreen.withOpacity(0.7),
                            MysticalColors.auroraGreen,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section 13: Cosmic Timing Hint
  Widget _buildTimingHint() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MysticalColors.bgElevated.withOpacity(0.5),
        border: Border.all(color: MysticalColors.etherealCyan.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: MysticalColors.etherealCyan,
              ),
              const SizedBox(width: 8),
              Text(
                'Kozmik Zamanlama',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: MysticalColors.etherealCyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Timing row
          Row(
            children: [
              // Golden hour
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MysticalColors.auroraGreen.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Text('✨', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(
                        'Altın Saat',
                        style: GoogleFonts.raleway(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: MysticalColors.auroraGreen,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        content.timingHint.goldenHour,
                        style: GoogleFonts.raleway(
                          fontSize: 11,
                          color: MysticalColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Avoid hour
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MysticalColors.nebulaRose.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Text('⏸️', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(
                        'Dikkatli Ol',
                        style: GoogleFonts.raleway(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: MysticalColors.nebulaRose,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        content.timingHint.avoidHour,
                        style: GoogleFonts.raleway(
                          fontSize: 11,
                          color: MysticalColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Ritual suggestion
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.05),
            ),
            child: Row(
              children: [
                Text('🕯️', style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    content.timingHint.ritualSuggestion,
                    style: GoogleFonts.raleway(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: MysticalColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Branding Footer
  Widget _buildBranding() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    MysticalColors.amethyst,
                    MysticalColors.cosmicPurple,
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  '✧',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'venusone',
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MysticalColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Evrenin fısıltılarını dinle',
          style: GoogleFonts.raleway(
            fontSize: 10,
            fontStyle: FontStyle.italic,
            color: MysticalColors.textMuted,
          ),
        ),
      ],
    );
  }
}

/// Custom painter for cosmic background effects - MASTER LEVEL
class _CosmicBackgroundPainter extends CustomPainter {
  final Color accentColor;

  _CosmicBackgroundPainter(this.accentColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random(42);

    // 1. Nebula clouds - soft gradient blobs
    for (int i = 0; i < 5; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 100.0 + random.nextDouble() * 150;

      final gradient = RadialGradient(
        colors: [
          accentColor.withOpacity(0.08),
          MysticalColors.cosmicPurple.withOpacity(0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      );

      paint.shader = gradient.createShader(
        Rect.fromCircle(center: Offset(x, y), radius: radius),
      );
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // 2. Sacred geometry - Flower of Life pattern (subtle)
    paint
      ..shader = null
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = MysticalColors.starGold.withOpacity(0.04);

    final centerX = size.width * 0.5;
    final centerY = size.height * 0.35;
    final baseRadius = 60.0;

    // Center circle
    canvas.drawCircle(Offset(centerX, centerY), baseRadius, paint);

    // 6 surrounding circles
    for (int i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x = centerX + baseRadius * math.cos(angle);
      final y = centerY + baseRadius * math.sin(angle);
      canvas.drawCircle(Offset(x, y), baseRadius, paint);
    }

    // 3. Orbital rings with gradient
    paint.style = PaintingStyle.stroke;
    for (int i = 0; i < 4; i++) {
      paint
        ..color = accentColor.withOpacity(0.02 + i * 0.01)
        ..strokeWidth = 0.5 + i * 0.2;

      final orbitCenter = Offset(
        size.width * (0.2 + i * 0.2),
        size.height * (0.5 + i * 0.1),
      );
      final radius = 120.0 + i * 80;

      // Draw dashed orbit
      final path = Path()
        ..addOval(Rect.fromCircle(center: orbitCenter, radius: radius));
      canvas.drawPath(path, paint);
    }

    // 4. Constellation lines
    paint
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 0.5;

    final constellationPoints = <Offset>[];
    for (int i = 0; i < 8; i++) {
      constellationPoints.add(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
      );
    }

    for (int i = 0; i < constellationPoints.length - 1; i++) {
      if (random.nextBool()) {
        canvas.drawLine(
          constellationPoints[i],
          constellationPoints[i + 1],
          paint,
        );
      }
    }

    // 5. Tiny stars with varying sizes
    for (int i = 0; i < 40; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final starSize = random.nextDouble() * 1.5 + 0.5;
      final opacity = random.nextDouble() * 0.4 + 0.1;

      paint
        ..style = PaintingStyle.fill
        ..color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }

    // 6. Zodiac wheel hint (very subtle)
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = MysticalColors.starGold.withOpacity(0.03);

    final zodiacCenter = Offset(size.width * 0.5, size.height * 0.7);
    final zodiacRadius = 100.0;

    canvas.drawCircle(zodiacCenter, zodiacRadius, paint);
    canvas.drawCircle(zodiacCenter, zodiacRadius * 0.7, paint);

    // 12 division lines
    for (int i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final start = Offset(
        zodiacCenter.dx + zodiacRadius * 0.7 * math.cos(angle),
        zodiacCenter.dy + zodiacRadius * 0.7 * math.sin(angle),
      );
      final end = Offset(
        zodiacCenter.dx + zodiacRadius * math.cos(angle),
        zodiacCenter.dy + zodiacRadius * math.sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }

    // 7. Moon phases arc (bottom)
    paint
      ..color = MysticalColors.moonSilver.withOpacity(0.04)
      ..strokeWidth = 0.5;

    final moonArcRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.9),
      width: size.width * 0.8,
      height: 60,
    );
    canvas.drawArc(moonArcRect, math.pi, math.pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
