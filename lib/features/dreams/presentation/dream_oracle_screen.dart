/// Ruya Dongusu - 7 Boyutlu Kapsamli Ruya Yorumlama Arayuzu
/// Features: Rich input, multiple interpretation styles, mystical animations, 10-section results
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/mystical_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../data/models/dream_interpretation_models.dart';
import '../../../data/services/dream_interpretation_service.dart';

// ============================================================================
// DREAM ORACLE SCREEN - MAIN WIDGET
// ============================================================================

class DreamOracleScreen extends StatefulWidget {
  const DreamOracleScreen({super.key});

  @override
  State<DreamOracleScreen> createState() => _DreamOracleScreenState();
}

class _DreamOracleScreenState extends State<DreamOracleScreen>
    with TickerProviderStateMixin {
  // Controllers
  final TextEditingController _dreamController = TextEditingController();
  final TextEditingController _lifeContextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _pulseController;
  late AnimationController _orbController;
  late AnimationController _loadingController;

  // State
  DreamOracleState _state = DreamOracleState.input;
  FullDreamInterpretation? _interpretation;

  // Input Options
  EmotionalTone? _selectedEmotion;
  InterpretationStyle _selectedStyle = InterpretationStyle.jungian;
  bool _isRecurring = false;
  MoonPhase _currentMoonPhase = MoonPhase.dolunay;

  // Services
  final DreamInterpretationService _dreamService = DreamInterpretationService();

  // Loading messages
  final List<String> _loadingMessages = [
    'Bilinçaltının derinliklerine iniliyor...',
    'Semboller çözümleniyor...',
    'Arketiplerle bağlantı kuruluyor...',
    'Ay fazı etkisi hesaplanıyor...',
    'Kadim bilgelik danışılıyor...',
    'Gölge ve ışık analiz ediliyor...',
    'Kozmik zamanlama okunuyor...',
    'Rüya yorumu şekilleniyor...',
  ];
  int _currentLoadingIndex = 0;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _calculateMoonPhase();
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
  }

  void _calculateMoonPhase() {
    _currentMoonPhase = MoonPhaseCalculator.today;
  }

  @override
  void dispose() {
    _dreamController.dispose();
    _lifeContextController.dispose();
    _scrollController.dispose();
    _pulseController.dispose();
    _orbController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  Future<void> _interpretDream() async {
    if (_dreamController.text.trim().isEmpty) {
      _showError('Lutfen ruyani anlat');
      return;
    }

    setState(() {
      _state = DreamOracleState.loading;
      _currentLoadingIndex = 0;
    });

    // Cycle through loading messages
    _startLoadingMessageCycle();

    try {
      // Simulate processing time for mystical effect
      await Future.delayed(const Duration(seconds: 3));

      final input = DreamInput(
        dreamDescription: _dreamController.text.trim(),
        dominantEmotion: _selectedEmotion,
        isRecurring: _isRecurring,
        currentLifeSituation: _lifeContextController.text.isNotEmpty
            ? _lifeContextController.text.trim()
            : null,
      );

      final interpretation = _dreamService.generateLocalInterpretation(
        input,
        _currentMoonPhase,
      );

      if (mounted) {
        setState(() {
          _interpretation = interpretation;
          _state = DreamOracleState.results;
        });

        // Scroll to results
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _state = DreamOracleState.input;
        });
        _showError('Bir hata olustu. Lutfen tekrar dene.');
      }
    }
  }

  void _startLoadingMessageCycle() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (_state == DreamOracleState.loading && mounted) {
        setState(() {
          _currentLoadingIndex =
              (_currentLoadingIndex + 1) % _loadingMessages.length;
        });
        return true;
      }
      return false;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: MysticalColors.solarOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
      ),
    );
  }

  void _resetToInput() {
    setState(() {
      _state = DreamOracleState.input;
      _interpretation = null;
      _dreamController.clear();
      _lifeContextController.clear();
      _selectedEmotion = null;
      _isRecurring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.lg,
        vertical: Spacing.md,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MysticalColors.cosmicPurple.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
            color: MysticalColors.textPrimary,
          ),
          const SizedBox(width: Spacing.sm),
          // Animated moon icon
          _buildAnimatedMoonIcon(),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ruya Orakeli',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MysticalColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      _currentMoonPhase.emoji,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _currentMoonPhase.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MysticalColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_state == DreamOracleState.results)
            IconButton(
              onPressed: _resetToInput,
              icon: const Icon(Icons.refresh),
              color: MysticalColors.starGold,
              tooltip: 'Yeni Ruya',
            ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildAnimatedMoonIcon() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                MysticalColors.amethyst.withOpacity(
                  0.5 + _pulseController.value * 0.3,
                ),
                MysticalColors.cosmicPurple.withOpacity(0.3),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: MysticalColors.amethyst.withOpacity(
                  0.4 * _pulseController.value,
                ),
                blurRadius: 15 + _pulseController.value * 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Text('\u{1F319}', style: TextStyle(fontSize: 24)),
        );
      },
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case DreamOracleState.input:
        return _buildInputSection();
      case DreamOracleState.loading:
        return _buildLoadingSection();
      case DreamOracleState.results:
        return _buildResultsSection();
    }
  }

  // ============================================================================
  // INPUT SECTION
  // ============================================================================

  Widget _buildInputSection() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dream Input Card
          _buildDreamInputCard(),
          const SizedBox(height: Spacing.xl),

          // Emotion Selector
          _buildEmotionSelector(),
          const SizedBox(height: Spacing.xl),

          // Recurring Toggle
          _buildRecurringToggle(),
          const SizedBox(height: Spacing.xl),

          // Life Context (Optional)
          _buildLifeContextInput(),
          const SizedBox(height: Spacing.xl),

          // Interpretation Style Selector
          _buildStyleSelector(),
          const SizedBox(height: Spacing.xl),

          // Moon Phase Display
          _buildMoonPhaseDisplay(),
          const SizedBox(height: Spacing.xxl),

          // Interpret Button
          _buildInterpretButton(),
          const SizedBox(height: Spacing.huge),
        ],
      ),
    );
  }

  Widget _buildDreamInputCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  MysticalColors.amethyst.withOpacity(0.15),
                  MysticalColors.bgCosmic,
                ]
              : [
                  MysticalColors.lavender.withOpacity(0.2),
                  MysticalColors.bgLightElevated,
                ],
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusLg),
        border: Border.all(color: MysticalColors.amethyst.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: MysticalColors.amethyst.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: MysticalColors.amethyst.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                const Text('\u{2728}', style: TextStyle(fontSize: 20)),
                const SizedBox(width: Spacing.sm),
                Text(
                  'Ruyani Anlat',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark
                        ? MysticalColors.textPrimary
                        : MysticalColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Voice-to-text icon (placeholder)
                IconButton(
                  onPressed: () {
                    _showError('Sesli giris yakinda aktif olacak');
                  },
                  icon: Icon(
                    Icons.mic_outlined,
                    color: MysticalColors.amethyst,
                  ),
                  tooltip: 'Sesli Anlat',
                ),
              ],
            ),
          ),
          // Text Input
          Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: TextField(
              controller: _dreamController,
              maxLines: 6,
              style: TextStyle(
                color: isDark
                    ? MysticalColors.textPrimary
                    : MysticalColors.textDark,
                height: 1.6,
              ),
              decoration: InputDecoration(
                hintText:
                    'Gordugum ruyada...\n\nNe gordun? Kimler vardi? Neler oldu? Ne hissettin?',
                hintStyle: TextStyle(
                  color:
                      (isDark
                              ? MysticalColors.textSecondary
                              : MysticalColors.textDarkSecondary)
                          .withOpacity(0.6),
                  height: 1.6,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          // Character count
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Spacing.lg,
              0,
              Spacing.lg,
              Spacing.lg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${_dreamController.text.length} karakter',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MysticalColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildEmotionSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final emotions = EmotionalTone.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('\u{1F3AD}', style: TextStyle(fontSize: 18)),
            const SizedBox(width: Spacing.sm),
            Text(
              'Ruyandaki Duygu',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isDark
                    ? MysticalColors.textPrimary
                    : MysticalColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: emotions.map((emotion) {
              final isSelected = _selectedEmotion == emotion;
              return Padding(
                padding: const EdgeInsets.only(right: Spacing.sm),
                child: _EmotionChip(
                  emotion: emotion,
                  isSelected: isSelected,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _selectedEmotion = isSelected ? null : emotion;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms);
  }

  Widget _buildRecurringToggle() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color: isDark
            ? MysticalColors.bgElevated.withOpacity(0.5)
            : MysticalColors.bgLightElevated,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(
          color: _isRecurring
              ? MysticalColors.starGold.withOpacity(0.5)
              : MysticalColors.textMuted.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Text(
            _isRecurring ? '\u{1F504}' : '\u{1F4AD}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bu ruya tekrarliyor mu?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark
                        ? MysticalColors.textPrimary
                        : MysticalColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Tekrarlayan ruyalar ozel mesajlar tasir',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MysticalColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isRecurring,
            onChanged: (value) {
              HapticFeedback.lightImpact();
              setState(() => _isRecurring = value);
            },
            activeColor: MysticalColors.starGold,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildLifeContextInput() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('\u{1F4DD}', style: TextStyle(fontSize: 18)),
            const SizedBox(width: Spacing.sm),
            Text(
              'Hayatindaki Durum (Istege Bagli)',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isDark
                    ? MysticalColors.textPrimary
                    : MysticalColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.md),
        Container(
          decoration: BoxDecoration(
            color: isDark
                ? MysticalColors.bgElevated.withOpacity(0.5)
                : MysticalColors.bgLightElevated,
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            border: Border.all(
              color: MysticalColors.textMuted.withOpacity(0.2),
            ),
          ),
          child: TextField(
            controller: _lifeContextController,
            maxLines: 2,
            style: TextStyle(
              color: isDark
                  ? MysticalColors.textPrimary
                  : MysticalColors.textDark,
            ),
            decoration: InputDecoration(
              hintText: 'Su an hayatinda neler oluyor? (kariyer, iliski, vb.)',
              hintStyle: TextStyle(
                color: MysticalColors.textMuted.withOpacity(0.6),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(Spacing.lg),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }

  Widget _buildStyleSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('\u{1F52E}', style: TextStyle(fontSize: 18)),
            const SizedBox(width: Spacing.sm),
            Text(
              'Yorum Turu',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isDark
                    ? MysticalColors.textPrimary
                    : MysticalColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: InterpretationStyle.values.map((style) {
              final isSelected = _selectedStyle == style;
              return Padding(
                padding: const EdgeInsets.only(right: Spacing.sm),
                child: _StyleChip(
                  style: style,
                  isSelected: isSelected,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() => _selectedStyle = style);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  Widget _buildMoonPhaseDisplay() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MysticalColors.midnightBlue.withOpacity(0.3),
            MysticalColors.cosmicPurple.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(color: MysticalColors.moonSilver.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(_currentMoonPhase.emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: Spacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gunun Ay Fazi',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MysticalColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentMoonPhase.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark
                        ? MysticalColors.textPrimary
                        : MysticalColors.textDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentMoonPhase.meaning,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MysticalColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 500.ms);
  }

  Widget _buildInterpretButton() {
    return SizedBox(
          width: double.infinity,
          child: GradientButton(
            label: 'Ruyami Yorumla',
            icon: Icons.auto_awesome,
            onPressed: _interpretDream,
            gradient: LinearGradient(
              colors: [MysticalColors.amethyst, MysticalColors.orchid],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 600.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  // ============================================================================
  // LOADING SECTION
  // ============================================================================

  Widget _buildLoadingSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mystical loading animation
          _buildMysticalLoadingAnimation(),
          const SizedBox(height: Spacing.xxl),
          // Loading message
          Text(
                _loadingMessages[_currentLoadingIndex],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: MysticalColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              )
              .animate(key: ValueKey(_currentLoadingIndex))
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.1, end: 0),
          const SizedBox(height: Spacing.xl),
          // Progress dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(8, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index <= _currentLoadingIndex
                      ? MysticalColors.starGold
                      : MysticalColors.textMuted.withOpacity(0.3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMysticalLoadingAnimation() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring
          AnimatedBuilder(
            animation: _orbController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _orbController.value * 2 * math.pi,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MysticalColors.starGold.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 85,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: MysticalColors.starGold,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: MysticalColors.starGold.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Middle ring (reverse)
          AnimatedBuilder(
            animation: _orbController,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_orbController.value * 2 * math.pi * 0.7,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MysticalColors.amethyst.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 60,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: MysticalColors.amethyst,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: MysticalColors.amethyst.withOpacity(0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Center eye
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 70 + _pulseController.value * 10,
                height: 70 + _pulseController.value * 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      MysticalColors.starGold.withOpacity(0.8),
                      MysticalColors.amethyst.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text('\u{1F441}', style: TextStyle(fontSize: 32)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // RESULTS SECTION
  // ============================================================================

  Widget _buildResultsSection() {
    if (_interpretation == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Kadim Giris
          _buildKadimGirisSection(),
          const SizedBox(height: Spacing.xl),

          // Section 2: Ana Mesaj
          _buildAnaMesajSection(),
          const SizedBox(height: Spacing.xl),

          // Section 3: Sembol Analizi
          _buildSymbolAnalysisSection(),
          const SizedBox(height: Spacing.xl),

          // Section 4: Arketip Baglantisi
          _buildArchetypeSection(),
          const SizedBox(height: Spacing.xl),

          // Section 5: Duygusal Okuma
          _buildEmotionalReadingSection(),
          const SizedBox(height: Spacing.xl),

          // Section 6: Astro Zamanlama
          _buildAstroTimingSection(),
          const SizedBox(height: Spacing.xl),

          // Section 7: Isik/Golge
          _buildLightShadowSection(),
          const SizedBox(height: Spacing.xl),

          // Section 8: Pratik Rehberlik
          _buildGuidanceSection(),
          const SizedBox(height: Spacing.xl),

          // Section 9: Lucid Potansiyel
          _buildLucidPotentialSection(),
          const SizedBox(height: Spacing.xl),

          // Section 10: Fisildayan Cumle
          _buildWhisperQuoteSection(),
          const SizedBox(height: Spacing.xxl),

          // Action Buttons
          _buildActionButtons(),
          const SizedBox(height: Spacing.xl),

          // Exploration Links
          _buildExplorationLinks(),
          const SizedBox(height: Spacing.huge),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String emoji,
    required String title,
    required Widget content,
    Color? accentColor,
    int delayIndex = 0,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = accentColor ?? MysticalColors.amethyst;

    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [color.withOpacity(0.15), MysticalColors.bgCosmic]
                  : [color.withOpacity(0.1), MysticalColors.bgLightElevated],
            ),
            borderRadius: BorderRadius.circular(Spacing.radiusLg),
            border: Border.all(color: color.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(Spacing.lg),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: color.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: Spacing.md),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: content,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: (100 * delayIndex).ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildKadimGirisSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _buildSectionCard(
      emoji: '\u{1F3DB}',
      title: 'Kadim Giris',
      accentColor: MysticalColors.antiqueGold,
      delayIndex: 0,
      content: Text(
        _interpretation!.ancientIntro,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isDark ? MysticalColors.textPrimary : MysticalColors.textDark,
          height: 1.8,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildAnaMesajSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _buildSectionCard(
      emoji: '\u{1F4AC}',
      title: 'Ana Mesaj',
      accentColor: MysticalColors.starGold,
      delayIndex: 1,
      content: Container(
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: MysticalColors.starGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          border: Border.all(color: MysticalColors.starGold.withOpacity(0.3)),
        ),
        child: Text(
          _interpretation!.coreMessage,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isDark
                ? MysticalColors.textPrimary
                : MysticalColors.textDark,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSymbolAnalysisSection() {
    if (_interpretation!.symbols.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSectionCard(
      emoji: '\u{1F50D}',
      title: 'Sembol Analizi',
      accentColor: MysticalColors.nebulaTeal,
      delayIndex: 2,
      content: Column(
        children: _interpretation!.symbols.map((symbol) {
          return _ExpandableSymbolCard(symbol: symbol);
        }).toList(),
      ),
    );
  }

  Widget _buildArchetypeSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return _buildSectionCard(
      emoji: '\u{1F3AD}',
      title: 'Arketip Baglantisi: ${_interpretation!.archetypeName}',
      accentColor: MysticalColors.orchid,
      delayIndex: 3,
      content: Text(
        _interpretation!.archetypeConnection,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isDark ? MysticalColors.textPrimary : MysticalColors.textDark,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _buildEmotionalReadingSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reading = _interpretation!.emotionalReading;

    return _buildSectionCard(
      emoji: '\u{2764}',
      title: 'Duygusal Okuma',
      accentColor: MysticalColors.nebulaRose,
      delayIndex: 4,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dominant emotion badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md,
              vertical: Spacing.sm,
            ),
            decoration: BoxDecoration(
              color: MysticalColors.nebulaRose.withOpacity(0.2),
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  reading.dominantEmotion.emoji,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: Spacing.sm),
                Text(
                  reading.dominantEmotion.label,
                  style: TextStyle(
                    color: MysticalColors.nebulaRose,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),
          _buildEmotionalItem('Yuzey Mesaji', reading.surfaceMessage, isDark),
          const SizedBox(height: Spacing.md),
          _buildEmotionalItem('Derin Anlam', reading.deeperMeaning, isDark),
          const SizedBox(height: Spacing.md),
          _buildEmotionalItem(
            'Golge Sorusu',
            reading.shadowQuestion,
            isDark,
            isQuestion: true,
          ),
          const SizedBox(height: Spacing.md),
          _buildEmotionalItem(
            'Entegrasyon Yolu',
            reading.integrationPath,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionalItem(
    String label,
    String text,
    bool isDark, {
    bool isQuestion = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: MysticalColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isQuestion ? '"$text"' : text,
          style: TextStyle(
            color: isDark
                ? MysticalColors.textPrimary
                : MysticalColors.textDark,
            height: 1.5,
            fontStyle: isQuestion ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildAstroTimingSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timing = _interpretation!.astroTiming;

    return _buildSectionCard(
      emoji: '\u{1FA90}',
      title: 'Astro Zamanlama',
      accentColor: MysticalColors.stardustBlue,
      delayIndex: 5,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Moon phase badge
          Row(
            children: [
              Text(
                timing.moonPhase.emoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timing.moonPhase.label,
                      style: TextStyle(
                        color: MysticalColors.stardustBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      timing.moonPhase.meaning,
                      style: TextStyle(
                        color: MysticalColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          Text(
            timing.timingMessage,
            style: TextStyle(
              color: isDark
                  ? MysticalColors.textPrimary
                  : MysticalColors.textDark,
              height: 1.6,
            ),
          ),
          const SizedBox(height: Spacing.md),
          Container(
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: MysticalColors.stardustBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              border: Border(
                left: BorderSide(color: MysticalColors.stardustBlue, width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Neden Simdi?',
                  style: TextStyle(
                    color: MysticalColors.stardustBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timing.whyNow,
                  style: TextStyle(
                    color: isDark
                        ? MysticalColors.textPrimary
                        : MysticalColors.textDark,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLightShadowSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ls = _interpretation!.lightShadow;

    return _buildSectionCard(
      emoji: '\u{2600}\u{FE0F}\u{1F311}',
      title: 'Isik ve Golge',
      accentColor: MysticalColors.lavender,
      delayIndex: 6,
      content: Column(
        children: [
          // Light
          _buildLightShadowItem(
            '\u{2600}\u{FE0F}',
            'Isik Yonu',
            ls.lightMessage,
            MysticalColors.starGold,
            isDark,
          ),
          const SizedBox(height: Spacing.lg),
          // Shadow
          _buildLightShadowItem(
            '\u{1F311}',
            'Golge Yonu',
            ls.shadowMessage,
            MysticalColors.cosmicPurple,
            isDark,
          ),
          const SizedBox(height: Spacing.lg),
          // Integration
          Container(
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MysticalColors.starGold.withOpacity(0.1),
                  MysticalColors.cosmicPurple.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '\u{267E}\u{FE0F}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: Spacing.sm),
                    Text(
                      'Entegrasyon Yolu',
                      style: TextStyle(
                        color: MysticalColors.lavender,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.sm),
                Text(
                  ls.integrationPath,
                  style: TextStyle(
                    color: isDark
                        ? MysticalColors.textPrimary
                        : MysticalColors.textDark,
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

  Widget _buildLightShadowItem(
    String emoji,
    String label,
    String text,
    Color color,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: Spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: TextStyle(
                  color: isDark
                      ? MysticalColors.textPrimary
                      : MysticalColors.textDark,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuidanceSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final guidance = _interpretation!.guidance;

    return _buildSectionCard(
      emoji: '\u{1F9ED}',
      title: 'Pratik Rehberlik',
      accentColor: MysticalColors.auroraGreen,
      delayIndex: 7,
      content: Column(
        children: [
          _buildGuidanceItem(
            '\u{1F3AF}',
            'Bugun Ne Yap',
            guidance.todayAction,
            MysticalColors.auroraGreen,
            isDark,
          ),
          const SizedBox(height: Spacing.md),
          _buildGuidanceItem(
            '\u{1F4C5}',
            'Haftalik Odak',
            guidance.weeklyFocus,
            MysticalColors.stardustBlue,
            isDark,
          ),
          const SizedBox(height: Spacing.md),
          _buildGuidanceItem(
            '\u{2753}',
            'Yansitma Sorusu',
            '"${guidance.reflectionQuestion}"',
            MysticalColors.amethyst,
            isDark,
            isItalic: true,
          ),
          const SizedBox(height: Spacing.md),
          _buildGuidanceItem(
            '\u{26A0}\u{FE0F}',
            'Kacin',
            guidance.avoidance,
            MysticalColors.solarOrange,
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildGuidanceItem(
    String emoji,
    String label,
    String text,
    Color color,
    bool isDark, {
    bool isItalic = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: isDark
                        ? MysticalColors.textPrimary
                        : MysticalColors.textDark,
                    height: 1.5,
                    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLucidPotentialSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final potential = _interpretation!.lucidPotential ?? 'Orta';

    Color getColor() {
      switch (potential) {
        case 'Cok Yuksek':
          return MysticalColors.starGold;
        case 'Yuksek':
          return MysticalColors.auroraGreen;
        case 'Orta':
          return MysticalColors.stardustBlue;
        default:
          return MysticalColors.textMuted;
      }
    }

    return _buildSectionCard(
      emoji: '\u{1F4AB}',
      title: 'Lucid Ruya Potansiyeli',
      accentColor: MysticalColors.etherealCyan,
      delayIndex: 8,
      content: Column(
        children: [
          // Potential indicator
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MysticalColors.bgElevated,
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _getPotentialProgress(potential),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [getColor().withOpacity(0.5), getColor()],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Spacing.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: getColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                ),
                child: Text(
                  potential,
                  style: TextStyle(
                    color: getColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          Text(
            'Bu ruyada lucid (bilinçli) ruya gorme potansiyeliniz yukseldi. '
            'Gelecek gece uyumadan once niyet koymayi deneyin.',
            style: TextStyle(
              color: isDark
                  ? MysticalColors.textSecondary
                  : MysticalColors.textDarkSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  double _getPotentialProgress(String potential) {
    switch (potential) {
      case 'Cok Yuksek':
        return 1.0;
      case 'Yuksek':
        return 0.75;
      case 'Orta':
        return 0.5;
      default:
        return 0.25;
    }
  }

  Widget _buildWhisperQuoteSection() {
    return Container(
          padding: const EdgeInsets.all(Spacing.xl),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                MysticalColors.cosmicPurple.withOpacity(0.8),
                MysticalColors.midnightBlue.withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(Spacing.radiusLg),
            boxShadow: [
              BoxShadow(
                color: MysticalColors.amethyst.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text('\u{1F54A}\u{FE0F}', style: TextStyle(fontSize: 36)),
              const SizedBox(height: Spacing.lg),
              Text(
                'Fisildayan Cumle',
                style: TextStyle(
                  color: MysticalColors.starGold,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: Spacing.md),
              Text(
                '"${_interpretation!.whisperQuote}"',
                style: const TextStyle(
                  color: MysticalColors.starlightWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 900.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _shareDream,
            icon: const Icon(Icons.share_outlined),
            label: const Text('Paylas'),
            style: OutlinedButton.styleFrom(
              foregroundColor: MysticalColors.starGold,
              side: BorderSide(color: MysticalColors.starGold.withOpacity(0.5)),
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
            ),
          ),
        ),
        const SizedBox(width: Spacing.md),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _saveDream,
            icon: const Icon(Icons.bookmark_outline),
            label: const Text('Kaydet'),
            style: OutlinedButton.styleFrom(
              foregroundColor: MysticalColors.amethyst,
              side: BorderSide(color: MysticalColors.amethyst.withOpacity(0.5)),
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 1000.ms);
  }

  Widget _buildExplorationLinks() {
    if (_interpretation!.explorationLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('\u{1F517}', style: TextStyle(fontSize: 18)),
            const SizedBox(width: Spacing.sm),
            Text(
              'Daha Fazla Kesfet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: MysticalColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.md),
        ...(_interpretation!.explorationLinks.map((link) {
          return _buildExplorationLinkCard(link);
        })),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 1100.ms);
  }

  Widget _buildExplorationLinkCard(DreamExplorationLink link) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.md),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(link.route),
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          child: Container(
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              color: isDark
                  ? MysticalColors.bgElevated.withOpacity(0.5)
                  : MysticalColors.bgLightElevated,
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              border: Border.all(
                color: MysticalColors.amethyst.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Text(link.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        link.title,
                        style: TextStyle(
                          color: isDark
                              ? MysticalColors.textPrimary
                              : MysticalColors.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        link.description,
                        style: TextStyle(
                          color: MysticalColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: MysticalColors.amethyst,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _shareDream() {
    if (_interpretation == null) return;

    final shareText =
        '${_interpretation!.shareCard.emoji} '
        '"${_interpretation!.shareCard.quote}"\n\n'
        '- Ruya Orakeli\n'
        '#RuyaYorumu #Bilinçaltı';

    Share.share(shareText);
  }

  void _saveDream() {
    // TODO: Implement save to dream journal
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ruya gunlugune kaydedildi'),
        backgroundColor: MysticalColors.auroraGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
      ),
    );
  }
}

// ============================================================================
// SUPPORTING WIDGETS
// ============================================================================

/// Emotion chip for emotion selector
class _EmotionChip extends StatelessWidget {
  final EmotionalTone emotion;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmotionChip({
    required this.emotion,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    MysticalColors.amethyst.withOpacity(0.4),
                    MysticalColors.amethyst.withOpacity(0.2),
                  ],
                )
              : null,
          color: isSelected
              ? null
              : isDark
              ? MysticalColors.bgElevated.withOpacity(0.5)
              : MysticalColors.bgLightElevated,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
          border: Border.all(
            color: isSelected
                ? MysticalColors.amethyst
                : MysticalColors.textMuted.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: MysticalColors.amethyst.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emotion.emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: Spacing.xs),
            Text(
              emotion.label,
              style: TextStyle(
                color: isSelected
                    ? MysticalColors.textPrimary
                    : MysticalColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Style chip for interpretation style selector
class _StyleChip extends StatelessWidget {
  final InterpretationStyle style;
  final bool isSelected;
  final VoidCallback onTap;

  const _StyleChip({
    required this.style,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.lg,
          vertical: Spacing.md,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    style.color.withOpacity(0.4),
                    style.color.withOpacity(0.2),
                  ],
                )
              : null,
          color: isSelected
              ? null
              : isDark
              ? MysticalColors.bgElevated.withOpacity(0.5)
              : MysticalColors.bgLightElevated,
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          border: Border.all(
            color: isSelected
                ? style.color
                : MysticalColors.textMuted.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: style.color.withOpacity(0.3), blurRadius: 8)]
              : null,
        ),
        child: Column(
          children: [
            Text(style.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: Spacing.xs),
            Text(
              style.label,
              style: TextStyle(
                color: isSelected
                    ? style.color
                    : isDark
                    ? MysticalColors.textSecondary
                    : MysticalColors.textDarkSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Expandable symbol card for symbol analysis
class _ExpandableSymbolCard extends StatefulWidget {
  final SymbolInterpretation symbol;

  const _ExpandableSymbolCard({required this.symbol});

  @override
  State<_ExpandableSymbolCard> createState() => _ExpandableSymbolCardState();
}

class _ExpandableSymbolCardState extends State<_ExpandableSymbolCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.md),
      decoration: BoxDecoration(
        color: isDark
            ? MysticalColors.bgElevated.withOpacity(0.5)
            : MysticalColors.bgLightElevated,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(color: MysticalColors.nebulaTeal.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Header (always visible)
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _isExpanded = !_isExpanded);
            },
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Row(
                children: [
                  Text(
                    widget.symbol.symbolEmoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.symbol.symbol,
                          style: TextStyle(
                            color: isDark
                                ? MysticalColors.textPrimary
                                : MysticalColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.symbol.universalMeaning,
                          style: TextStyle(
                            color: MysticalColors.textMuted,
                            fontSize: 12,
                          ),
                          maxLines: _isExpanded ? null : 1,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _isExpanded ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: MysticalColors.nebulaTeal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              padding: const EdgeInsets.fromLTRB(
                Spacing.lg,
                0,
                Spacing.lg,
                Spacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: MysticalColors.textMuted.withOpacity(0.2)),
                  const SizedBox(height: Spacing.md),
                  _buildSymbolDetail(
                    'Kisisel Baglam',
                    widget.symbol.personalContext,
                    isDark,
                  ),
                  const SizedBox(height: Spacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSymbolDetail(
                          '\u{2600}\u{FE0F} Isik Yonu',
                          widget.symbol.lightAspect,
                          isDark,
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: _buildSymbolDetail(
                          '\u{1F311} Golge Yonu',
                          widget.symbol.shadowAspect,
                          isDark,
                        ),
                      ),
                    ],
                  ),
                  if (widget.symbol.relatedSymbols.isNotEmpty) ...[
                    const SizedBox(height: Spacing.md),
                    Wrap(
                      spacing: Spacing.xs,
                      runSpacing: Spacing.xs,
                      children: [
                        Text(
                          'Iliskili: ',
                          style: TextStyle(
                            color: MysticalColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                        ...widget.symbol.relatedSymbols.map((s) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: MysticalColors.nebulaTeal.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                Spacing.radiusSm,
                              ),
                            ),
                            child: Text(
                              s,
                              style: TextStyle(
                                color: MysticalColors.nebulaTeal,
                                fontSize: 11,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildSymbolDetail(String label, String text, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: MysticalColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            color: isDark
                ? MysticalColors.textPrimary
                : MysticalColors.textDark,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// ENUMS AND MODELS
// ============================================================================

/// Screen state
enum DreamOracleState { input, loading, results }

/// Interpretation styles
enum InterpretationStyle {
  jungian(
    'Jungian',
    '\u{1F9E0}',
    'Derinlik Psikolojisi',
    MysticalColors.amethyst,
  ),
  spiritual('Spiritüel', '\u{2728}', 'Mistik Yorum', MysticalColors.starGold),
  turkishFolk(
    'Halk Tabiri',
    '\u{1F9FF}',
    'Turk Gelenegine Gore',
    MysticalColors.nebulaRose,
  ),
  islamic('Islami', '\u{1F54C}', 'Islami Tabir', MysticalColors.auroraGreen),
  quick('Hizli', '\u{26A1}', '3 Dakikada Yorum', MysticalColors.etherealCyan);

  final String label;
  final String emoji;
  final String description;
  final Color color;

  const InterpretationStyle(
    this.label,
    this.emoji,
    this.description,
    this.color,
  );
}
