import 'dart:async';
import 'dart:math' show cos, sin, pi;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/liquid_glass/glass_animations.dart';
import '../../../core/theme/liquid_glass/glass_panel.dart';
// glass_tokens import removed (archetype result page removed)
import '../../../data/models/journal_entry.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/analytics_service.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/l10n_service.dart';
import '../../../data/services/mood_checkin_service.dart';
import '../../../data/services/notification_service.dart';
import '../../../data/services/referral_service.dart';
import '../../../data/services/storage_service.dart';
// birth_date_picker removed (birthday deferred to settings)
import '../../../shared/widgets/app_symbol.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/content_disclaimer.dart';
import '../../../shared/widgets/cosmic_loading_indicator.dart';

// Quiz data moved to standalone ArchetypeQuizScreen (post-onboarding)

// ════════════════════════════════════════════════════════════════════════════
// ONBOARDING SCREEN — 7-Step Focused Flow
// ════════════════════════════════════════════════════════════════════════════
//   Page 0: Welcome — Branding + 3 feature highlights
//   Page 1: Identity — Name + Apple Sign-In
//   Page 2: First Cycle — Focus area selection
//   Page 3: First Mood — Quick mood check-in (seeds data for trends)
//   Page 4: First Insight — Personalized "wow" moment (pattern preview)
//   Page 5: Premium — Soft paywall with skip option
//   Page 6: Permission + Start — Notifications + CTA
// ════════════════════════════════════════════════════════════════════════════

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String? _userName;
  FocusArea? _selectedFocusArea;
  int? _selectedMood;
  String? _selectedMoodEmoji;
  bool _notificationsRequested = false;
  bool _isCompleting = false;
  String _referralCode = '';

  static const int _totalPages = 7; // 1 welcome + 4 setup + 1 insight + 1 paywall
  static const int _valuePropCount = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    HapticFeedback.lightImpact();
    // Track onboarding step for funnel analytics
    AnalyticsService().logOnboardingStepCompleted(step: page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _goToPage(_currentPage + 1);
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  Future<void> _requestNotifications() async {
    if (kIsWeb || _notificationsRequested) return;

    setState(() => _notificationsRequested = true);
    try {
      final notifService = NotificationService();
      await notifService.initialize();
      final granted = await notifService.requestPermissions();
      if (granted) {
        await notifService.scheduleDailyReflection(hour: 9, minute: 0);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Onboarding notification setup failed: $e');
      }
    }
  }

  Future<void> _completeOnboarding() async {
    if (_isCompleting) return;
    _isCompleting = true;

    HapticFeedback.heavyImpact();

    try {
      final profile = UserProfile(
        name: (_userName != null && _userName!.isNotEmpty) ? _userName : null,
        birthDate: DateTime(2000, 1, 1),
      );

      ref.read(userProfileProvider.notifier).setProfile(profile);
      ref.read(onboardingCompleteProvider.notifier).state = true;

      await StorageService.saveUserProfile(profile);
      await StorageService.saveOnboardingComplete(true);

      // Save selected focus area preference
      if (_selectedFocusArea != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('preferred_focus_area', _selectedFocusArea!.name);
      }

      // Save mood check-in from onboarding so screens have data immediately
      if (_selectedMood != null && _selectedMoodEmoji != null) {
        try {
          final moodService = await MoodCheckinService.init();
          await moodService.logMood(_selectedMood!, _selectedMoodEmoji!);
          ref.invalidate(moodCheckinServiceProvider);
        } catch (e) { if (kDebugMode) debugPrint('Onboarding service init: $e'); }
      }

      // Apply referral code if entered during onboarding
      if (_referralCode.trim().isNotEmpty) {
        try {
          final referralService = await ReferralService.init();
          await referralService.applyCode(_referralCode.trim());
        } catch (e) { if (kDebugMode) debugPrint('Onboarding service init: $e'); }
      }

      // Track onboarding completion
      AnalyticsService().logEvent('onboarding_completed', {
        'has_name': _userName != null && _userName!.isNotEmpty,
        'has_focus_area': _selectedFocusArea != null,
        'has_mood': _selectedMood != null,
        'has_referral': _referralCode.trim().isNotEmpty,
      });

      await Future.delayed(const Duration(milliseconds: 100));

      if (mounted) {
        context.go(Routes.today);
      }
    } catch (e) {
      // Ensure user can still enter the app even if persistence fails
      _isCompleting = false;
      if (mounted) {
        context.go(Routes.today);
      }
    }
  }

  bool _canProceed() {
    // All pages allow proceeding — skip is always possible
    return true;
  }

  bool get _isOnSkippableStep {
    if (_currentPage < _valuePropCount) return false;
    final step = _currentPage - _valuePropCount;
    if (step == 0) return _userName == null || _userName!.isEmpty;
    if (step == 1) return _selectedFocusArea == null;
    if (step == 2) return _selectedMood == null;
    if (step == 3) return false; // Insight page — always auto-proceeds
    if (step == 4) return true; // Paywall page is always skippable
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.deepSpace
          : AppColors.lightBackground,
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Back button — visible after first page
              if (_currentPage > 0)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
                      color: AppColors.textMuted,
                      tooltip: L10nService.get('common.back', language),
                    ),
                  ),
                ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _totalPages,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 0;
                        if (_pageController.position.haveDimensions) {
                          value = (_pageController.page! - index)
                              .clamp(-1.0, 1.0);
                        }
                        return Transform.translate(
                          offset: Offset(
                            value *
                                MediaQuery.sizeOf(context).width *
                                0.3,
                            0,
                          ),
                          child: Opacity(
                            opacity:
                                (1 - value.abs() * 0.4).clamp(0.0, 1.0),
                            child: child,
                          ),
                        );
                      },
                      child: _buildPage(index, language),
                    );
                  },
                ),
              ),
              _buildBottomSection(language),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index, AppLanguage language) {
    switch (index) {
      case 0:
        return _WelcomePage(language: language);
      case 1:
        return _IdentityPage(
          userName: _userName,
          onNameChanged: (name) => setState(() => _userName = name),
          onContinue: _nextPage,
          language: language,
        );
      case 2:
        return _FirstCyclePage(
          selectedFocusArea: _selectedFocusArea,
          onFocusAreaSelected: (area) =>
              setState(() => _selectedFocusArea = area),
          language: language,
        );
      case 3:
        return _FirstMoodPage(
          selectedMood: _selectedMood,
          selectedEmoji: _selectedMoodEmoji,
          onMoodSelected: (mood, emoji) => setState(() {
            _selectedMood = mood;
            _selectedMoodEmoji = emoji;
          }),
          language: language,
        );
      case 4:
        return _FirstInsightPage(
          selectedFocusArea: _selectedFocusArea,
          selectedMood: _selectedMood,
          selectedMoodEmoji: _selectedMoodEmoji,
          userName: _userName,
          language: language,
        );
      case 5:
        return _PaywallPage(
          onSkip: _nextPage,
          language: language,
        );
      case 6:
        return _PermissionStartPage(
          notificationsRequested: _notificationsRequested,
          onRequestNotifications: _requestNotifications,
          onReferralCodeChanged: (code) => _referralCode = code,
          language: language,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomSection(AppLanguage language) {
    final isLastPage = _currentPage == _totalPages - 1;
    final isLastValueProp = _currentPage == _valuePropCount - 1;

    // Determine button label
    String buttonLabel;
    IconData buttonIcon;
    if (isLastPage) {
      buttonLabel = L10nService.get('common.start_journey', language);
      buttonIcon = Icons.auto_awesome;
    } else if (isLastValueProp) {
      buttonLabel = L10nService.get('onboarding.onboarding.get_started', language);
      buttonIcon = Icons.arrow_forward;
    } else {
      buttonLabel = L10nService.get('common.continue', language);
      buttonIcon = Icons.arrow_forward;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          // Progress bar
          Column(
            children: [
              Container(
                width: 140,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(1.5),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (_currentPage + 1) / _totalPages,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${_currentPage + 1} / $_totalPages',
                style: AppTypography.elegantAccent(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // CTA button — gold on final page with shimmer
          if (isLastPage)
            GradientButton.gold(
              label: buttonLabel,
              icon: buttonIcon,
              width: double.infinity,
              onPressed: _canProceed() ? _nextPage : null,
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .then(delay: 600.ms)
                .shimmer(
                  duration: 2000.ms,
                  color: AppColors.celestialGold.withValues(alpha: 0.2),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                  delay: 4000.ms,
                  duration: 2000.ms,
                  color: AppColors.celestialGold.withValues(alpha: 0.15),
                )
          else
            GradientButton(
              label: buttonLabel,
              icon: buttonIcon,
              width: double.infinity,
              onPressed: _canProceed() ? _nextPage : null,
            ),
          // Skip link for steps that require input
          if (_isOnSkippableStep) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _nextPage,
              child: Text(
                L10nService.get('onboarding.onboarding.skip_for_now', language),
                style: AppTypography.elegantAccent(
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// STEP 0: IDENTITY PAGE — Name + Apple Sign-In
// ════════════════════════════════════════════════════════════════════════════

class _IdentityPage extends StatefulWidget {
  final String? userName;
  final ValueChanged<String> onNameChanged;
  final VoidCallback onContinue;
  final AppLanguage language;

  const _IdentityPage({
    required this.userName,
    required this.onNameChanged,
    required this.onContinue,
    required this.language,
  });

  @override
  State<_IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<_IdentityPage>
    with SingleTickerProviderStateMixin {
  bool _isAppleLoading = false;
  late AnimationController _glowController;
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _glowController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
      return;
    }

    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    if (!AuthService.isSupabaseInitialized) return;

    _authSubscription = AuthService.authStateChanges.listen((state) {
      if (state.event == AuthChangeEvent.signedIn && state.session != null) {
        _handleOAuthSuccess(state.session!.user);
      }
    });

    final currentUser = AuthService.currentUser;
    if (currentUser != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _handleOAuthSuccess(currentUser);
      });
    }
  }

  void _handleOAuthSuccess(User user) {
    if (!mounted) return;
    final fullNameRaw = user.userMetadata?['full_name'];
    final nameRaw = user.userMetadata?['name'];
    final displayName =
        (fullNameRaw is String ? fullNameRaw : null) ??
        (nameRaw is String ? nameRaw : null) ??
        user.email?.split('@').first;

    _showCosmicWelcome(displayName);
  }

  void _showCosmicWelcome(String? name) {
    final cosmicGreetings = L10nService.getList(
      'greetings.cosmic_welcome',
      widget.language,
    );
    final greeting = cosmicGreetings.isNotEmpty
        ? cosmicGreetings[DateTime.now().millisecond % cosmicGreetings.length]
        : L10nService.get('greetings.cosmic_welcome', widget.language);

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return _CosmicWelcomeOverlay(
          greeting: greeting,
          name: name,
          language: widget.language,
          onComplete: () {
            Navigator.of(context).pop();
            // Auto-fill name if available from OAuth
            if (name != null && name.isNotEmpty) {
              widget.onNameChanged(name);
            }
            widget.onContinue();
          },
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _handleAppleSignIn() async {
    setState(() => _isAppleLoading = true);
    try {
      final userInfo = await AuthService.signInWithApple();
      if (!mounted) return;
      if (userInfo != null) {
        _showCosmicWelcome(userInfo.displayName);
      } else {
        setState(() => _isAppleLoading = false);
      }
    } catch (e) {
      if (!mounted) return;
      final errorStr = e.toString();
      if (errorStr.contains('TypeError') ||
          errorStr.contains('JSObject') ||
          errorStr.contains('minified')) {
        setState(() => _isAppleLoading = false);
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${L10nService.get('auth.apple_connection_failed', widget.language)}: $e',
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      setState(() => _isAppleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _buildWebVersion();
    }
    return _buildMobileVersion();
  }

  Widget _buildWebVersion() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/brand/app-logo/png/app-planet-transparent.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              semanticLabel: 'InnerCycles logo',
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.auroraStart, AppColors.auroraEnd],
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 48,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            GradientText(
              L10nService.get('app.name', widget.language),
              style: AppTypography.displayFont.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                letterSpacing: 4,
              ),
              variant: GradientTextVariant.gold,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 300,
              child: _NameInput(
                userName: widget.userName,
                onNameChanged: widget.onNameChanged,
                language: widget.language,
              ),
            ),
            const SizedBox(height: 24),
            ContentDisclaimer(language: widget.language, compact: true),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileVersion() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 32),

          // Animated logo with cosmic glow
          _buildAnimatedLogo(),
          const SizedBox(height: 20),

          // App name
          GradientText(
            L10nService.get('app.name', widget.language),
            style: AppTypography.displayFont.copyWith(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              letterSpacing: 4,
            ),
            variant: GradientTextVariant.gold,
          ).glassReveal(context: context),

          const SizedBox(height: 8),

          // Tagline
          Text(
            L10nService.get('onboarding.start_cosmic_journey', widget.language),
            style: AppTypography.decorativeScript(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).glassListItem(context: context, index: 1),

          const SizedBox(height: 28),

          // Warm greeting
          GradientText(
            widget.language == AppLanguage.en
                ? 'Let\'s start with your name'
                : 'İsminle başlayalım',
            style: AppTypography.displayFont.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            variant: GradientTextVariant.amethyst,
            textAlign: TextAlign.center,
          ).glassListItem(context: context, index: 1),

          const SizedBox(height: 20),

          // Name input — primary action
          _NameInput(
            userName: widget.userName,
            onNameChanged: widget.onNameChanged,
            language: widget.language,
          ).glassListItem(context: context, index: 2),

          const SizedBox(height: 28),

          // Apple Sign-In button
          _buildAppleSignInButton(),

          const SizedBox(height: 16),

          // Terms text
          Text(
            L10nService.get('onboarding.by_continuing', widget.language),
            style: AppTypography.subtitle(
              fontSize: 14,
              color: AppColors.textMuted.withValues(alpha: 0.59),
            ),
            textAlign: TextAlign.center,
          ).glassListItem(context: context, index: 5),

          const SizedBox(height: 16),

          ContentDisclaimer(language: widget.language, compact: true),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.auroraStart
                    .withValues(alpha: (60 * _glowController.value + 20) / 255),
                blurRadius: 50 + (25 * _glowController.value),
                spreadRadius: 8 + (12 * _glowController.value),
              ),
              BoxShadow(
                color: AppColors.amethyst
                    .withValues(alpha: (40 * _glowController.value + 15) / 255),
                blurRadius: 70 + (30 * _glowController.value),
                spreadRadius: 5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Image.asset(
        'assets/brand/app-logo/png/app-planet-transparent.png',
        width: 160,
        height: 160,
        fit: BoxFit.contain,
        semanticLabel: 'InnerCycles logo',
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.self_improvement,
          size: 100,
          color: AppColors.amethyst,
        ),
      ),
    ).glassReveal(context: context);
  }

  Widget _buildAppleSignInButton() {
    return Semantics(
      button: true,
      label: widget.language.name == 'en'
          ? 'Sign in with Apple'
          : 'Apple ile giriş yap',
      child: GestureDetector(
        onTap: _isAppleLoading ? null : _handleAppleSignIn,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isAppleLoading)
                const CosmicLoadingIndicator(size: 22)
              else
                const Icon(Icons.apple, color: Colors.white, size: 26),
              const SizedBox(width: 12),
              Text(
                _isAppleLoading
                    ? L10nService.get('onboarding.connecting', widget.language)
                    : L10nService.get(
                        'onboarding.connect_with_apple',
                        widget.language,
                      ),
                style: AppTypography.modernAccent(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    ).glassListItem(context: context, index: 3);
  }
}

// ════════════════════════════════════════════════════════════════════════════
// STEP 1: FIRST CYCLE — Focus Area Selection
// ════════════════════════════════════════════════════════════════════════════

class _FirstCyclePage extends StatelessWidget {
  final FocusArea? selectedFocusArea;
  final ValueChanged<FocusArea> onFocusAreaSelected;
  final AppLanguage language;

  const _FirstCyclePage({
    required this.selectedFocusArea,
    required this.onFocusAreaSelected,
    required this.language,
  });

  static const _focusAreas = [
    FocusArea.energy,
    FocusArea.emotions,
    FocusArea.focus,
    FocusArea.social,
  ];

  static const Map<FocusArea, IconData> _focusIcons = {
    FocusArea.energy: Icons.local_fire_department_rounded,
    FocusArea.emotions: Icons.water_drop_rounded,
    FocusArea.focus: Icons.visibility_rounded,
    FocusArea.social: Icons.public_rounded,
  };

  static const Map<FocusArea, String> _focusDescEn = {
    FocusArea.energy: 'What lights you up or burns you out',
    FocusArea.emotions: 'The waves beneath the surface',
    FocusArea.focus: 'Where your attention actually goes',
    FocusArea.social: 'The people who shape your days',
  };

  static const Map<FocusArea, String> _focusDescTr = {
    FocusArea.energy: 'Seni neyin ateşlediği, neyin tükettiği',
    FocusArea.emotions: 'Yüzeyin altındaki dalgalar',
    FocusArea.focus: 'Dikkatinin gerçekte nereye gittiği',
    FocusArea.social: 'Günlerini şekillendiren insanlar',
  };

  static const Map<FocusArea, Color> _focusColors = {
    FocusArea.energy: AppColors.starGold,
    FocusArea.emotions: AppColors.chartPink,
    FocusArea.focus: AppColors.chartBlue,
    FocusArea.social: AppColors.chartPurple,
  };

  @override
  Widget build(BuildContext context) {
    final isEn = language == AppLanguage.en;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Title
          GradientText(
            L10nService.get('onboarding.onboarding.pick_your_starting_signal', language),
            style: AppTypography.displayFont.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            variant: GradientTextVariant.gold,
          ).glassEntrance(context: context),

          const SizedBox(height: 8),

          Text(
            L10nService.get('onboarding.onboarding.theres_no_wrong_answer_follow_your_curio', language),
            style: AppTypography.decorativeScript(
              fontSize: 19,
              color: AppColors.textMuted,
            ),
          ).glassListItem(context: context, index: 0),

          const SizedBox(height: 32),

          // 2x2 Focus Area Grid
          GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.85,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _focusAreas.asMap().entries.map((entry) {
                final index = entry.key;
                final area = entry.value;
                final isSelected = selectedFocusArea == area;
                final color = _focusColors[area] ?? AppColors.auroraStart;

                return Semantics(
                  button: true,
                  label: area.localizedName(language),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onFocusAreaSelected(area);
                    },
                    child: AnimatedScale(
                      scale: isSelected ? 1.03 : 1.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? color
                              : Colors.white.withValues(alpha: 0.12),
                          width: isSelected ? 2 : 1,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color.withValues(alpha: isSelected ? 0.2 : 0.08),
                            color.withValues(alpha: isSelected ? 0.12 : 0.03),
                          ],
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.16),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _focusIcons[area],
                              size: 32,
                              color: isSelected
                                  ? color
                                  : color.withValues(alpha: 0.71),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              area.localizedName(language),
                              style: AppTypography.elegantAccent(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.78),
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: Text(
                                isEn
                                    ? (_focusDescEn[area] ?? '')
                                    : (_focusDescTr[area] ?? ''),
                                style: AppTypography.decorativeScript(
                                  fontSize: 14,
                                  color: AppColors.textMuted.withValues(
                                    alpha: 0.71,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                ).glassListItem(context: context, index: index);
              }).toList(),
            ),

          const SizedBox(height: 14),

          // Info note
          GlassPanel(
            elevation: GlassElevation.g1,
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    L10nService.get('onboarding.onboarding.all_signals_unlock_as_you_journal', language),
                    style: AppTypography.subtitle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ).glassListItem(context: context, index: 5),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Birthday and Archetype Quiz pages removed — deferred to settings/post-onboarding

// ════════════════════════════════════════════════════════════════════════════
// STEP 2b: FIRST MOOD CHECK-IN — Seeds data so trends aren't empty
// ════════════════════════════════════════════════════════════════════════════

class _FirstMoodPage extends StatelessWidget {
  final int? selectedMood;
  final String? selectedEmoji;
  final void Function(int mood, String emoji) onMoodSelected;
  final AppLanguage language;

  const _FirstMoodPage({
    required this.selectedMood,
    required this.selectedEmoji,
    required this.onMoodSelected,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final isEn = language == AppLanguage.en;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Emoji hero — shows selected mood or placeholder with glow
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: selectedEmoji != null
                  ? [
                      BoxShadow(
                        color: AppColors.amethyst.withValues(alpha: 0.12),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: child,
              ),
              child: Text(
                selectedEmoji ?? '🌿',
                key: ValueKey(selectedEmoji),
                style: const TextStyle(fontSize: 76),
              ),
            ),
          ),

          const SizedBox(height: 20),

          GradientText(
            L10nService.get('onboarding.onboarding.how_are_you_feeling_right_now', language),
            style: AppTypography.displayFont.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            variant: GradientTextVariant.amethyst,
            textAlign: TextAlign.center,
          ).glassEntrance(context: context),

          const SizedBox(height: 8),

          Text(
            L10nService.get('onboarding.onboarding.your_first_checkin_this_powers_your_mood', language),
            style: AppTypography.decorativeScript(
              fontSize: 15,
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ).glassListItem(context: context, index: 0),

          const SizedBox(height: 40),

          // Mood options row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: MoodCheckinService.moodOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final (mood, emoji, labelEn, labelTr) = entry.value;
              final label = isEn ? labelEn : labelTr;
              final isSelected = selectedMood == mood;

              return Semantics(
                label: label,
                button: true,
                selected: isSelected,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onMoodSelected(mood, emoji);
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.12 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutBack,
                    child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? AppColors.amethyst.withValues(alpha: 0.15)
                          : Colors.transparent,
                      border: isSelected
                          ? Border.all(
                              color: AppColors.amethyst.withValues(alpha: 0.4),
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Column(
                      children: [
                        Text(
                          emoji,
                          style: TextStyle(
                            fontSize: isSelected ? 36 : 30,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          label,
                          style: AppTypography.elegantAccent(
                            fontSize: 11,
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textMuted,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              ).glassListItem(context: context, index: index + 1);
            }).toList(),
          ),

          const Spacer(flex: 3),

          // Info note
          GlassPanel(
            elevation: GlassElevation.g1,
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.auto_graph_rounded, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    L10nService.get('onboarding.onboarding.check_in_daily_to_see_patterns_emerge', language),
                    style: AppTypography.subtitle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ).glassListItem(context: context, index: 6),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// STEP 3: FIRST INSIGHT — "Wow" Moment (personalized preview)
// ════════════════════════════════════════════════════════════════════════════

class _FirstInsightPage extends StatefulWidget {
  final FocusArea? selectedFocusArea;
  final int? selectedMood;
  final String? selectedMoodEmoji;
  final String? userName;
  final AppLanguage language;

  const _FirstInsightPage({
    required this.selectedFocusArea,
    required this.selectedMood,
    required this.selectedMoodEmoji,
    required this.userName,
    required this.language,
  });

  @override
  State<_FirstInsightPage> createState() => _FirstInsightPageState();
}

class _FirstInsightPageState extends State<_FirstInsightPage> {
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _revealed = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.language == AppLanguage.en;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final focus = widget.selectedFocusArea;
    final mood = widget.selectedMood;
    final moodEmoji = widget.selectedMoodEmoji ?? '🌿';
    final name = widget.userName;

    // Build personalized insight based on focus + mood
    final focusLabel = focus != null
        ? (isEn ? focus.displayNameEn : focus.displayNameTr)
        : (isEn ? 'self-reflection' : 'öz yansıma');

    // Personalized stat (seeded from selections)
    final statPercent = _insightPercent(focus, mood);
    final insightText = isEn
        ? '$statPercent% of journalers who feel ${_moodLabel(mood, isEn)} find $focusLabel entries most revealing'
        : '${_moodLabel(mood, isEn)} hisseden günlükçülerin %$statPercent\'${_trSuffix(statPercent)} $focusLabel kayıtlarını en açıklayıcı buluyor';

    final trendPreview = _trendPreviewItems(focus, isEn);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Analyzing animation → reveal
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: _revealed
                ? Column(
                    key: const ValueKey('insight'),
                    children: [
                      // Personalized greeting
                      if (name != null && name.isNotEmpty)
                        Text(
                          isEn ? 'Here\'s your first insight, $name' : 'İşte ilk içgörün, $name',
                          style: AppTypography.decorativeScript(
                            fontSize: 16,
                            color: AppColors.textMuted,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),

                      const SizedBox(height: 12),

                      // Big insight emoji
                      Text(moodEmoji, style: const TextStyle(fontSize: 56))
                          .animate()
                          .scale(
                            begin: const Offset(0.5, 0.5),
                            end: const Offset(1, 1),
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                          ),

                      const SizedBox(height: 16),

                      GradientText(
                        isEn ? 'Your Pattern Preview' : 'Örüntü Önizlemen',
                        style: AppTypography.displayFont.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                        variant: GradientTextVariant.aurora,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

                      const SizedBox(height: 20),

                      // Key stat card
                      GlassPanel(
                        elevation: GlassElevation.g2,
                        borderRadius: BorderRadius.circular(16),
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.auroraStart.withValues(alpha: 0.2),
                                        AppColors.amethyst.withValues(alpha: 0.15),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$statPercent%',
                                      style: AppTypography.displayFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.starGold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    insightText,
                                    style: AppTypography.subtitle(
                                      fontSize: 14,
                                      color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.05, end: 0),

                      const SizedBox(height: 16),

                      // Trend preview items
                      ...trendPreview.asMap().entries.map((entry) {
                        final i = entry.key;
                        final (icon, label, value) = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(icon, size: 18, color: AppColors.starGold),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  label,
                                  style: AppTypography.elegantAccent(
                                    fontSize: 14,
                                    color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                value,
                                style: AppTypography.elegantAccent(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.starGold,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: (300 + i * 100).ms, duration: 300.ms).slideX(begin: 0.05, end: 0);
                      }),
                    ],
                  )
                : Column(
                    key: const ValueKey('loading'),
                    children: [
                      CosmicLoadingIndicator(size: 60),
                      const SizedBox(height: 20),
                      Text(
                        isEn ? 'Analyzing your patterns...' : 'Örüntülerin analiz ediliyor...',
                        style: AppTypography.decorativeScript(
                          fontSize: 18,
                          color: AppColors.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),

          const Spacer(flex: 3),

          // Bottom hint
          if (_revealed)
            GlassPanel(
              elevation: GlassElevation.g1,
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, size: 16, color: AppColors.starGold),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isEn
                          ? 'This gets smarter with every entry you write'
                          : 'Her yazdığın kayıtla daha akıllı hale gelir',
                      style: AppTypography.subtitle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 800.ms, duration: 400.ms),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  int _insightPercent(FocusArea? focus, int? mood) {
    // Generate a plausible stat based on selections
    final base = switch (focus) {
      FocusArea.energy => 73,
      FocusArea.emotions => 68,
      FocusArea.focus => 71,
      FocusArea.social => 65,
      FocusArea.decisions => 70,
      null => 67,
    };
    final moodOffset = switch (mood) {
      1 => 4,
      2 => 2,
      3 => 0,
      4 => -2,
      5 => -3,
      _ => 0,
    };
    return base + moodOffset;
  }

  String _moodLabel(int? mood, bool isEn) {
    return switch (mood) {
      1 => isEn ? 'calm' : 'sakin',
      2 => isEn ? 'good' : 'iyi',
      3 => isEn ? 'neutral' : 'nötr',
      4 => isEn ? 'low' : 'düşük',
      5 => isEn ? 'stressed' : 'stresli',
      _ => isEn ? 'reflective' : 'düşünceli',
    };
  }

  String _trSuffix(int n) {
    // Turkish vowel harmony for number suffix
    final lastDigit = n % 10;
    if (lastDigit <= 3 || lastDigit == 4) return 'ü';
    return 'i';
  }

  List<(IconData, String, String)> _trendPreviewItems(FocusArea? focus, bool isEn) {
    return [
      (
        Icons.trending_up_rounded,
        isEn ? 'Pattern detection' : 'Örüntü tespiti',
        isEn ? 'Unlocks at 5 entries' : '5 kayıtta açılır',
      ),
      (
        Icons.insights_rounded,
        isEn ? 'Weekly digest' : 'Haftalık özet',
        isEn ? 'Every Sunday' : 'Her Pazar',
      ),
      (
        Icons.auto_graph_rounded,
        isEn ? 'Mood trends' : 'Ruh hali eğilimleri',
        isEn ? 'After 7 days' : '7 gün sonra',
      ),
    ];
  }
}

// ════════════════════════════════════════════════════════════════════════════
// STEP 5: PREMIUM PAYWALL (soft — always skippable)
// ════════════════════════════════════════════════════════════════════════════

class _PaywallPage extends StatelessWidget {
  final VoidCallback onSkip;
  final AppLanguage language;

  const _PaywallPage({
    required this.onSkip,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEn = language == AppLanguage.en;

    final features = [
      (Icons.insights_rounded, isEn ? 'Personalized Reflections' : 'Kişiselleştirilmiş Yansımalar', isEn ? 'AI-powered insights from your entries' : 'Girişlerinden güçlü içgörüler'),
      (Icons.auto_graph_rounded, isEn ? 'Advanced Patterns' : 'Gelişmiş Örüntüler', isEn ? 'Deep emotional trend detection' : 'Derin duygusal eğilim tespiti'),
      (Icons.all_inclusive_rounded, isEn ? 'Unlimited Entries' : 'Sınırsız Giriş', isEn ? 'Journal and dream logs without limits' : 'Sınırsız günlük ve rüya kaydı'),
      (Icons.block_rounded, isEn ? 'Ad-Free Experience' : 'Reklamsız Deneyim', isEn ? 'Focus on you, not ads' : 'Reklamlara değil, kendine odaklan'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Crown icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.starGold.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Icon(
                Icons.workspace_premium_rounded,
                size: 40,
                color: AppColors.starGold,
              ),
            ).animate().scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 500.ms,
              curve: Curves.easeOutBack,
            ),

            const SizedBox(height: 20),

            GradientText(
              isEn ? 'Unlock Your Full Potential' : 'Tam Potansiyelini Aç',
              variant: GradientTextVariant.gold,
              style: AppTypography.displayFont.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              isEn
                  ? 'Get deeper insights and unlimited journaling'
                  : 'Daha derin içgörüler ve sınırsız günlük',
              style: AppTypography.subtitle(
                fontSize: 15,
                color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            // Feature list
            ...features.asMap().entries.map((entry) {
              final i = entry.key;
              final (icon, title, desc) = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.starGold.withValues(alpha: isDark ? 0.1 : 0.08),
                      ),
                      child: Icon(icon, size: 20, color: AppColors.starGold),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTypography.displayFont.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            desc,
                            style: AppTypography.subtitle(
                              fontSize: 13,
                              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate(delay: (100 + i * 80).ms).fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
            }),

            const SizedBox(height: 16),

            // Social proof
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_rounded,
                  size: 14,
                  color: AppColors.starGold.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    isEn
                        ? 'Trusted by thousands of journalers'
                        : 'Binlerce günlükçünün güvendiği uygulama',
                    style: AppTypography.subtitle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textMuted.withValues(alpha: 0.7)
                          : AppColors.lightTextMuted.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ).animate(delay: 500.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 20),

            // CTA — navigate to premium screen
            GradientButton.gold(
              label: isEn ? 'See Plans' : 'Planları Gör',
              icon: Icons.arrow_forward_rounded,
              width: double.infinity,
              onPressed: () {
                HapticFeedback.lightImpact();
                context.push(Routes.premium);
              },
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// STEP 6: PERMISSION + START
// ════════════════════════════════════════════════════════════════════════════

class _PermissionStartPage extends StatefulWidget {
  final bool notificationsRequested;
  final VoidCallback onRequestNotifications;
  final ValueChanged<String> onReferralCodeChanged;
  final AppLanguage language;

  const _PermissionStartPage({
    required this.notificationsRequested,
    required this.onRequestNotifications,
    required this.onReferralCodeChanged,
    required this.language,
  });

  @override
  State<_PermissionStartPage> createState() => _PermissionStartPageState();
}

class _PermissionStartPageState extends State<_PermissionStartPage> {
  bool _showReferralInput = false;
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = widget.language;
    final notificationsRequested = widget.notificationsRequested;
    final onRequestNotifications = widget.onRequestNotifications;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // Success icon — premium double-ring design + particle burst
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Particle burst dots
                ...List.generate(8, (i) {
                  final angle = (i / 8) * 2 * pi;
                  final dx = cos(angle) * 55;
                  final dy = sin(angle) * 55;
                  return Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.starGold.withValues(alpha: 0.5),
                    ),
                  )
                      .animate(delay: (200 + i * 50).ms)
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        duration: 300.ms,
                      )
                      .moveX(
                        end: dx,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      )
                      .moveY(
                        end: dy,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeOut(delay: 350.ms, duration: 200.ms);
                }),
                // Main icon
                Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.starGold.withValues(alpha: 0.12),
                  AppColors.starGold.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer sacred ring
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.starGold.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                  ),
                  // Inner glow circle
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.amethyst.withValues(alpha: 0.15),
                          AppColors.auroraStart.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.starGold.withValues(alpha: 0.12),
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.amethyst.withValues(alpha: 0.2),
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                        BoxShadow(
                          color: AppColors.starGold.withValues(alpha: 0.08),
                          blurRadius: 40,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.auto_stories_rounded,
                      size: 36,
                      color: AppColors.starGold.withValues(alpha: 0.9),
                    ),
                  ),
                  // Decorative sparkle dots
                  Positioned(
                    top: 6,
                    right: 14,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.starGold.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.amethyst.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    left: 6,
                    child: Container(
                      width: 2.5,
                      height: 2.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.starGold.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).glassReveal(context: context),
              ],
            ),
          ),

          const SizedBox(height: 20),

          GradientText(
            L10nService.get('onboarding.onboarding.youre_all_set', language),
            style: AppTypography.displayFont.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
            variant: GradientTextVariant.gold,
          ).glassListItem(context: context, index: 1),

          const SizedBox(height: 12),

          Text(
            L10nService.get('onboarding.onboarding.one_last_thing_stay_on_track_with_gentle', language),
            style: AppTypography.decorativeScript(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).glassListItem(context: context, index: 2),

          const SizedBox(height: 24),

          // Notification toggle card
          if (!kIsWeb)
            GlassPanel(
              elevation: GlassElevation.g2,
              borderRadius: BorderRadius.circular(14),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.auroraStart.withValues(alpha: 0.16),
                          AppColors.amethyst.withValues(alpha: 0.16),
                        ],
                      ),
                    ),
                    child: Icon(
                      notificationsRequested
                          ? Icons.notifications_active_rounded
                          : Icons.notifications_outlined,
                      color: notificationsRequested
                          ? AppColors.starGold
                          : AppColors.auroraStart,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          L10nService.get('onboarding.onboarding.daily_reflection_reminder', language),
                          style: AppTypography.elegantAccent(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          L10nService.get('onboarding.onboarding.a_gentle_nudge_at_900_am', language),
                          style: AppTypography.decorativeScript(
                            fontSize: 15,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: L10nService.get('onboarding.onboarding.enable_notifications', language),
                    child: GestureDetector(
                      onTap: notificationsRequested
                          ? null
                          : onRequestNotifications,
                      child: SizedBox(
                        width: 52,
                        height: 44,
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 52,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notificationsRequested
                                  ? AppColors.starGold
                                  : Colors.white.withValues(alpha: 0.1),
                              border: Border.all(
                                color: notificationsRequested
                                    ? AppColors.starGold
                                    : Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutBack,
                              alignment: notificationsRequested
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: notificationsRequested
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.71),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).glassListItem(context: context, index: 3),

          const SizedBox(height: 24),

          // Features summary
          GlassPanel(
            elevation: GlassElevation.g2,
            borderRadius: BorderRadius.circular(14),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L10nService.get('onboarding.onboarding.whats_included', language),
                  style: AppTypography.elegantAccent(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lavender,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 14),
                _FeatureRow(
                  icon: Icons.edit_note,
                  text: L10nService.get('onboarding.onboarding.daily_reflection_journal', language),
                ),
                _FeatureRow(
                  icon: Icons.nights_stay,
                  text: L10nService.get('onboarding.onboarding.dream_journal', language),
                ),
                _FeatureRow(
                  icon: Icons.auto_graph,
                  text: L10nService.get('onboarding.onboarding.pattern_recognition', language),
                ),
                _FeatureRow(
                  icon: Icons.library_books,
                  text: L10nService.get('onboarding.onboarding.symbol_glossary', language),
                ),
              ],
            ),
          ).glassListItem(context: context, index: 4),

          const SizedBox(height: 20),

          // Referral code — collapsible section
          GestureDetector(
            onTap: () => setState(() => _showReferralInput = !_showReferralInput),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.card_giftcard_rounded,
                  size: 16,
                  color: AppColors.starGold.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 6),
                Text(
                  L10nService.get('onboarding.onboarding.have_an_invite_code', language),
                  style: AppTypography.subtitle(
                    fontSize: 14,
                    color: AppColors.starGold.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: _showReferralInput ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.starGold.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ).glassListItem(context: context, index: 5),

          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: GlassPanel(
                elevation: GlassElevation.g2,
                borderRadius: BorderRadius.circular(14),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      L10nService.get('onboarding.onboarding.enter_your_friends_code_for_7_days_free', language),
                      style: AppTypography.subtitle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _codeController,
                        textCapitalization: TextCapitalization.characters,
                        textAlign: TextAlign.center,
                        style: AppTypography.elegantAccent(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: 4,
                        ),
                        decoration: InputDecoration(
                          hintText: L10nService.get('onboarding.onboarding.abcd1234', language),
                          hintStyle: AppTypography.subtitle(
                            fontSize: 18,
                            color: AppColors.textMuted.withValues(alpha: 0.3),
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.starGold.withValues(alpha: 0.2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.starGold.withValues(alpha: 0.15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.starGold.withValues(alpha: 0.5),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLength: 8,
                        buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                        onChanged: (value) => widget.onReferralCodeChanged(value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState: _showReferralInput
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),

          const SizedBox(height: 24),

          // Disclaimer
          GlassPanel(
            elevation: GlassElevation.g1,
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    L10nService.get('disclaimer.reflection_only', widget.language),
                    style: AppTypography.subtitle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ).glassListItem(context: context, index: 5),

          const SizedBox(height: 8),
        ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// WELCOME PAGE — Branding + 3 Feature Highlights
// ════════════════════════════════════════════════════════════════════════════

class _WelcomePage extends StatelessWidget {
  final AppLanguage language;

  const _WelcomePage({required this.language});

  @override
  Widget build(BuildContext context) {
    final isEn = language == AppLanguage.en;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Logo with pulsing outer ring + ambient glow
          Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing outer ring
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.starGold.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
              ).glassPulse(context: context, scale: 1.05),
              // Inner icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.starGold.withValues(alpha: 0.18),
                      AppColors.starGold.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.starGold.withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.self_improvement,
                  size: 56,
                  color: AppColors.starGold,
                ),
              ),
            ],
          ).glassReveal(context: context),

          const SizedBox(height: 28),

          // App name with shimmer
          GradientText(
            'InnerCycles',
            style: AppTypography.displayFont.copyWith(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              height: 1.2,
            ),
            variant: GradientTextVariant.gold,
            textAlign: TextAlign.center,
          )
              .glassEntrance(
                context: context,
                delay: const Duration(milliseconds: 200),
              )
              .animate()
              .then(delay: 800.ms)
              .shimmer(
                duration: 2000.ms,
                color: AppColors.celestialGold.withValues(alpha: 0.15),
              ),

          const SizedBox(height: 14),

          // Tagline
          Text(
            L10nService.get('onboarding.onboarding.your_story_your_patterns_your_clarity', language),
            style: AppTypography.decorativeScript(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).glassEntrance(
            context: context,
            delay: const Duration(milliseconds: 400),
          ),

          const SizedBox(height: 40),

          // Feature highlights row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FeatureHighlight(
                icon: Icons.waves_rounded,
                color: AppColors.amethyst,
                label: isEn ? 'Emotional\nCycles' : 'Duygusal\nDöngüler',
              ),
              _FeatureHighlight(
                icon: Icons.nights_stay_rounded,
                color: AppColors.auroraStart,
                label: isEn ? 'Dream\nJournal' : 'Rüya\nGünlüğü',
              ),
              _FeatureHighlight(
                icon: Icons.auto_graph_rounded,
                color: AppColors.chartPink,
                label: isEn ? 'Pattern\nInsights' : 'Kalıp\nİçgörüler',
              ),
            ],
          ).glassEntrance(
            context: context,
            delay: const Duration(milliseconds: 600),
          ),

          const SizedBox(height: 32),

          // Privacy callout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_rounded,
                  size: 14,
                  color: AppColors.starGold.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    L10nService.get('onboarding.onboarding.private_secure_your_journal_stays_on_you', language),
                    style: AppTypography.elegantAccent(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ).glassEntrance(
            context: context,
            delay: const Duration(milliseconds: 800),
          ),

          const SizedBox(height: 12),

          // Social proof
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_rounded,
                size: 14,
                color: AppColors.starGold.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  isEn
                      ? 'Join thousands discovering their inner patterns'
                      : 'İç örüntülerini keşfeden binlerce kişiye katıl',
                  style: AppTypography.elegantAccent(
                    fontSize: 12,
                    color: AppColors.textMuted.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ).glassEntrance(
            context: context,
            delay: const Duration(milliseconds: 900),
          ),

          // KVKK data consent notice (Turkish users only)
          if (language == AppLanguage.tr) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                L10nService.get('onboarding.onboarding.kvkk_consent', language),
                textAlign: TextAlign.center,
                style: AppTypography.elegantAccent(
                  fontSize: 11,
                  color: AppColors.textMuted.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse(AppConstants.privacyPolicyUrl)),
              child: Text(
                L10nService.get('onboarding.onboarding.privacy_policy_link', language),
                textAlign: TextAlign.center,
                style: AppTypography.elegantAccent(
                  fontSize: 11,
                  color: AppColors.starGold,
                ),
              ),
            ),
          ],

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

class _FeatureHighlight extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _FeatureHighlight({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: 0.2),
                color.withValues(alpha: 0.05),
              ],
            ),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, size: 28, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.elegantAccent(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
            letterSpacing: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.auroraStart),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTypography.decorativeScript(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ════════════════════════════════════════════════════════════════════════════

class _NameInput extends StatelessWidget {
  final String? userName;
  final ValueChanged<String> onNameChanged;
  final AppLanguage language;

  const _NameInput({
    required this.userName,
    required this.onNameChanged,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final hasValue = userName != null && userName!.isNotEmpty;

    return TextField(
      onChanged: onNameChanged,
      style: AppTypography.subtitle(
        color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: L10nService.get('input.your_name', language),
        hintStyle: AppTypography.subtitle(
          color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          fontSize: 15,
        ),
        prefixIcon: Icon(
          Icons.person_outline,
          color: hasValue
              ? colorScheme.primary
              : (isDark ? AppColors.textMuted : AppColors.lightTextMuted),
        ),
        suffixIcon: hasValue
            ? const Icon(Icons.check_circle, color: AppColors.success, size: 20)
            : null,
        filled: true,
        fillColor: isDark
            ? AppColors.surfaceDark.withValues(alpha: 0.5)
            : AppColors.lightSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasValue
                ? colorScheme.primary
                : (isDark
                      ? AppColors.surfaceLight
                      : AppColors.lightSurfaceVariant),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.starGold),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// COSMIC WELCOME OVERLAY — Full screen animated welcome for OAuth
// ════════════════════════════════════════════════════════════════════════════

class _CosmicWelcomeOverlay extends StatefulWidget {
  final String greeting;
  final String? name;
  final AppLanguage language;
  final VoidCallback onComplete;

  const _CosmicWelcomeOverlay({
    required this.greeting,
    this.name,
    required this.language,
    required this.onComplete,
  });

  @override
  State<_CosmicWelcomeOverlay> createState() => _CosmicWelcomeOverlayState();
}

class _CosmicWelcomeOverlayState extends State<_CosmicWelcomeOverlay>
    with TickerProviderStateMixin {
  late AnimationController _starController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _starController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Semantics(
        button: true,
        label: widget.language.name == 'en'
            ? 'Tap to continue'
            : 'Devam etmek için dokunun',
        child: GestureDetector(
          onTap: widget.onComplete,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.deepSpace,
                  AppColors.cosmicPurple,
                  AppColors.nebulaPurple,
                  AppColors.amethystBlue,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Stars background
                ...List.generate(50, (index) {
                  final random = index * 7.3;
                  return Positioned(
                    left: (random * 13) % MediaQuery.sizeOf(context).width,
                    top: (random * 17) % MediaQuery.sizeOf(context).height,
                    child: AnimatedBuilder(
                      animation: _starController,
                      builder: (context, child) {
                        final twinkle =
                            ((_starController.value * 2 + random / 50) % 1.0);
                        return Opacity(
                          opacity: 0.3 + twinkle * 0.7,
                          child: Icon(
                            Icons.star,
                            size: 4 + (index % 4) * 2.0,
                            color: index % 3 == 0
                                ? AppColors.starGold
                                : index % 3 == 1
                                ? AppColors.lavender
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  );
                }),

                // Main content
                Center(
                  child: FadeTransition(
                    opacity: _textController,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _textController,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AppSymbol('📓', size: AppSymbolSize.xxl),
                          const SizedBox(height: 32),

                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                AppColors.starGold,
                                AppColors.chartPink,
                                AppColors.amethyst,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              widget.greeting,
                              style: AppTypography.displayFont.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          if (widget.name != null &&
                              widget.name!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              widget.name!,
                              style: AppTypography.displayFont.copyWith(
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
                                color: AppColors.starGold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],

                          const SizedBox(height: 48),

                          Text(
                            L10nService.get(
                              'onboarding.tap_to_continue',
                              widget.language,
                            ),
                            style: AppTypography.elegantAccent(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.5),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
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
}
