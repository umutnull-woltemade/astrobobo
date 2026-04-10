import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:astrology_app/core/io_compat.dart';
import '../../../core/theme/mystical_colors.dart';
import '../../../data/models/zodiac_sign.dart' as zodiac;
import '../../../data/providers/app_providers.dart';
import 'instagram_story_card.dart';

class ShareSummaryScreen extends ConsumerStatefulWidget {
  const ShareSummaryScreen({super.key});

  @override
  ConsumerState<ShareSummaryScreen> createState() => _ShareSummaryScreenState();
}

class _ShareSummaryScreenState extends ConsumerState<ShareSummaryScreen> {
  final GlobalKey _cardKey = GlobalKey();
  bool _isCapturing = false;

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final sign = userProfile?.sunSign ?? zodiac.ZodiacSign.aries;

    return Scaffold(
      backgroundColor: MysticalColors.bgDeepSpace,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: MysticalColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Kozmik Paylaşım',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: MysticalColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Instagram Story Card (9:16 aspect ratio - NEW DESIGN)
            RepaintBoundary(
                  key: _cardKey,
                  child: InstagramStoryCard(
                    name: userProfile?.name ?? sign.nameTr,
                    sign: sign,
                    moonSign: userProfile?.moonSign,
                    risingSign: userProfile?.risingSign,
                    birthDate: userProfile?.birthDate,
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(begin: const Offset(0.95, 0.95)),

            const SizedBox(height: 24),

            // Share Button
            _ShareButton(
              isLoading: _isCapturing,
              onPressed: _captureAndShare,
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            const SizedBox(height: 16),

            // Hint
            Text(
              'Instagram hikayende kozmik enerjini paylaş!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MysticalColors.textSecondary,
              ),
            ).animate().fadeIn(delay: 500.ms),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndShare() async {
    setState(() => _isCapturing = true);

    try {
      // Wait for next frame
      await Future.delayed(const Duration(milliseconds: 100));

      // Find RenderRepaintBoundary
      final boundary =
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      // Capture image
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/venusone_summary.png');
      await file.writeAsBytes(bytes);

      // Share
      await Share.shareXFiles(
        [XFile(file.path)],
        text:
            'Bugünün kozmik enerjisi benimle! ✨🔮 Evrenin fısıltılarını dinle... #venusone #astroloji #burçyorumu #kozmikenerji',
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Paylaşım hatası: $e')));
    } finally {
      setState(() => _isCapturing = false);
    }
  }
}

class _ShareButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _ShareButton({required this.isLoading, required this.onPressed});

  @override
  State<_ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<_ShareButton>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _pulseController;
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _gradientController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _pulseController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onPressed,
      child: ListenableBuilder(
        listenable: Listenable.merge([
          _shimmerController,
          _pulseController,
          _gradientController,
        ]),
        builder: (context, child) {
          final pulseValue = 1.0 + (_pulseController.value * 0.03);
          final gradientShift = _gradientController.value;

          return Transform.scale(
            scale: pulseValue,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1 + gradientShift * 2, -1),
                  end: Alignment(1 + gradientShift * 2, 1),
                  colors: const [
                    Color(0xFFFF3CAC), // Hot pink
                    Color(0xFF784BA0), // Purple
                    Color(0xFF2B86C5), // Blue
                    Color(0xFFFF3CAC), // Hot pink (repeat for smooth loop)
                  ],
                  stops: const [0.0, 0.33, 0.66, 1.0],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(60),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFFFF3CAC,
                    ).withAlpha((100 + 50 * _pulseController.value).toInt()),
                    blurRadius: 25 + 10 * _pulseController.value,
                    offset: const Offset(-3, 6),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: const Color(
                      0xFF2B86C5,
                    ).withAlpha((100 + 50 * _pulseController.value).toInt()),
                    blurRadius: 25 + 10 * _pulseController.value,
                    offset: const Offset(3, 6),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white.withAlpha(30),
                    blurRadius: 1,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Glass effect overlay
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withAlpha(40),
                              Colors.white.withAlpha(5),
                            ],
                            stops: const [0.0, 0.5],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Shimmer effect
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment(
                              -1.5 + 3 * _shimmerController.value,
                              0,
                            ),
                            end: Alignment(
                              -0.5 + 3 * _shimmerController.value,
                              0,
                            ),
                            colors: [
                              Colors.white.withAlpha(0),
                              Colors.white.withAlpha(80),
                              Colors.white.withAlpha(0),
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Container(color: Colors.white.withAlpha(10)),
                      ),
                    ),
                  ),
                  // Content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isLoading)
                        const SizedBox(
                          width: 26,
                          height: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      else ...[
                        // Sparkle emoji
                        const Text('✨', style: TextStyle(fontSize: 22)),
                        const SizedBox(width: 10),
                        // Instagram icon - premium design
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFEDA77),
                                Color(0xFFF58529),
                                Color(0xFFDD2A7B),
                                Color(0xFF8134AF),
                                Color(0xFF515BD4),
                              ],
                              stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFDD2A7B).withAlpha(120),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Inner border
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              // Camera icon
                              const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              // Dot
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Instagram\'da Paylaş',
                                  style: GoogleFonts.raleway(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withAlpha(60),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '💫',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Hikayende kozmik enerjini paylaş!',
                              style: GoogleFonts.raleway(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withAlpha(220),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Text('🔮', style: TextStyle(fontSize: 22)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
