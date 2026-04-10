import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/runtime_flags.dart' as runtime_flags;

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/cities/world_cities.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../shared/widgets/birth_date_picker.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/gradient_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime = const TimeOfDay(
    hour: 12,
    minute: 0,
  ); // Default 12:00
  String? _userName;
  String? _birthPlace = 'Marmaris, Mugla (Türkiye)'; // Default Marmaris
  double? _birthLatitude = 36.8500; // Marmaris coordinates
  double? _birthLongitude = 28.2667;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    if (_selectedDate != null) {
      String? birthTimeStr;
      if (_selectedTime != null) {
        birthTimeStr =
            '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
      }

      final profile = UserProfile(
        name: _userName,
        birthDate: _selectedDate!,
        birthTime: birthTimeStr,
        birthPlace: _birthPlace,
        birthLatitude: _birthLatitude,
        birthLongitude: _birthLongitude,
      );

      // Save to state
      ref.read(userProfileProvider.notifier).setProfile(profile);
      ref.read(onboardingCompleteProvider.notifier).state = true;

      // Persist to local storage
      await StorageService.saveUserProfile(profile);
      await StorageService.saveOnboardingComplete(true);

      if (mounted) {
        context.go(Routes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _WelcomePage(onContinue: _nextPage),
                    _BirthDataPage(
                      selectedDate: _selectedDate,
                      onDateSelected: (date) {
                        setState(() => _selectedDate = date);
                      },
                      selectedTime: _selectedTime,
                      onTimeSelected: (time) {
                        setState(() => _selectedTime = time);
                      },
                      userName: _userName,
                      onNameChanged: (name) {
                        setState(() => _userName = name);
                      },
                      birthPlace: _birthPlace,
                      onPlaceChanged: (place, lat, lng) {
                        setState(() {
                          _birthPlace = place;
                          _birthLatitude = lat;
                          _birthLongitude = lng;
                        });
                      },
                      onContinue: _nextPage,
                    ),
                    _YourSignPage(
                      selectedDate: _selectedDate,
                      selectedTime: _selectedTime,
                      birthPlace: _birthPlace,
                      onComplete: _completeOnboarding,
                    ),
                  ],
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingXl),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.auroraStart
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Continue button
          GradientButton(
            label: _currentPage == 2 ? 'Yolculuğa Başla' : 'İlerle',
            icon: _currentPage == 2 ? Icons.auto_awesome : Icons.arrow_forward,
            width: double.infinity,
            onPressed: _canProceed() ? _nextPage : null,
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    if (_currentPage == 1) {
      // All fields are required for accurate chart calculation
      return _userName != null &&
          _userName!.isNotEmpty &&
          _selectedDate != null &&
          _selectedTime != null &&
          _birthPlace != null;
    }
    return true;
  }
}

class _WelcomePage extends StatefulWidget {
  final VoidCallback onContinue;

  const _WelcomePage({required this.onContinue});

  @override
  State<_WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<_WelcomePage>
    with SingleTickerProviderStateMixin {
  bool _isAppleLoading = false;
  late AnimationController _glowController;
  late final Stream<AuthState> _authStateStream;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    if (!runtime_flags.disableAnimations) {
      _glowController.repeat(reverse: true);
    }

    // OAuth callback'lerini dinle (web'de sayfa yeniden yüklendiğinde)
    _authStateStream = AuthService.authStateChanges;
    _authStateStream.listen((state) {
      debugPrint('🔐 Auth state changed: ${state.event}');
      if (state.event == AuthChangeEvent.signedIn && state.session != null) {
        debugPrint('🔐 User signed in via OAuth callback!');
        _handleOAuthSuccess(state.session!.user);
      }
    });

    // Sayfa yüklendiğinde zaten oturum açık mı kontrol et
    final currentUser = AuthService.currentUser;
    if (currentUser != null) {
      debugPrint('🔐 User already signed in: ${currentUser.email}');
      // Biraz bekle ki UI hazır olsun
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _handleOAuthSuccess(currentUser);
        }
      });
    }
  }

  void _handleOAuthSuccess(User user) {
    if (!mounted) return;

    final displayName =
        user.userMetadata?['full_name'] as String? ??
        user.userMetadata?['name'] as String? ??
        user.email?.split('@').first;

    // Kozmik karşılama overlay'i göster
    _showCosmicWelcome(displayName);
  }

  void _showCosmicWelcome(String? name) {
    // Ezoterik karşılama mesajları
    final cosmicGreetings = [
      'Yıldızlar seni bekliyordu',
      'Kozmik yolculuğun başlıyor',
      'Evren seninle buluştu',
      'Ruhun eve döndü',
      'Kaderin kapısı açıldı',
      'Işığın parlamaya başladı',
    ];
    final greeting =
        cosmicGreetings[DateTime.now().millisecond % cosmicGreetings.length];

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return _CosmicWelcomeOverlay(
          greeting: greeting,
          name: name,
          onComplete: () {
            Navigator.of(context).pop();
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
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // ══════════════════════════════════════════════════════
            // ANIMATED LOGO with cosmic glow
            // ══════════════════════════════════════════════════════
            _buildAnimatedLogo(),
            const SizedBox(height: 24),

            // App name with gradient
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFFFFD700),
                  Color(0xFFFF6B9D),
                  Color(0xFF9B59B6),
                  Color(0xFF667EEA),
                ],
              ).createShader(bounds),
              child: Text(
                'Venus One',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'Kozmik Yolculuğuna Başla',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 16,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

            const SizedBox(height: 48),

            // ══════════════════════════════════════════════════════
            // SIGN-IN BUTTONS - Premium Design
            // ══════════════════════════════════════════════════════

            // Apple Sign-In Button
            _buildAppleSignInButton(),

            const SizedBox(height: 24),

            // Divider with text
            _buildDivider(),

            const SizedBox(height: 24),

            // Guest continue button
            _buildGuestButton(),

            const SizedBox(height: 32),

            // Features preview
            _buildFeaturesPreview(),

            const SizedBox(height: 24),

            // Terms text
            Text(
              'Devam ederek Kullanım Şartlarını kabul etmiş olursunuz',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted.withAlpha(150),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 1200.ms),

            const SizedBox(height: 20),
          ],
        ),
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
                    color: const Color(
                      0xFF667EEA,
                    ).withAlpha((100 * _glowController.value).toInt() + 50),
                    blurRadius: 40 + (20 * _glowController.value),
                    spreadRadius: 10 + (10 * _glowController.value),
                  ),
                  BoxShadow(
                    color: const Color(
                      0xFF9B59B6,
                    ).withAlpha((80 * _glowController.value).toInt() + 30),
                    blurRadius: 60 + (30 * _glowController.value),
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: const Color(
                      0xFFFFD700,
                    ).withAlpha((60 * _glowController.value).toInt() + 20),
                    blurRadius: 80,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: ClipOval(
            child: Image.asset(
              'assets/images/app_icon.png',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if image doesn't exist
                return Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF667EEA),
                        Color(0xFF9B59B6),
                        Color(0xFFFF6B9D),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text('🐱', style: TextStyle(fontSize: 80)),
                  ),
                );
              },
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 1000.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          curve: Curves.elasticOut,
          duration: 1200.ms,
        );
  }

  Widget _buildAppleSignInButton() {
    return GestureDetector(
      onTap: _isAppleLoading ? null : _handleAppleSignIn,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isAppleLoading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              const Icon(Icons.apple, color: Colors.white, size: 28),
            const SizedBox(width: 14),
            Text(
              _isAppleLoading ? 'Bağlanıyor...' : 'Apple ile devam et',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 500.ms).slideY(begin: 0.3);
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.textMuted.withAlpha(100),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'veya',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.textMuted.withAlpha(100),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms, duration: 400.ms);
  }

  Widget _buildGuestButton() {
    return GestureDetector(
      onTap: widget.onContinue,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA).withAlpha(40),
              const Color(0xFF9B59B6).withAlpha(40),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF667EEA).withAlpha(100),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF9B59B6)],
              ).createShader(bounds),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF9B59B6)],
              ).createShader(bounds),
              child: const Text(
                'Hemen Keşfetmeye Başla',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 900.ms, duration: 500.ms).slideY(begin: 0.2);
  }

  Widget _buildFeaturesPreview() {
    final features = [
      {'icon': '🌙', 'text': 'Doğum Haritası'},
      {'icon': '✨', 'text': 'Günlük Yorum'},
      {'icon': '🔮', 'text': 'Tarot'},
      {'icon': '💫', 'text': 'Numeroloji'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;

        return Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight.withAlpha(50),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF667EEA).withAlpha(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      feature['icon']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feature['text']!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                ),
              ],
            )
            .animate()
            .fadeIn(delay: (1000 + index * 100).ms, duration: 400.ms)
            .slideY(begin: 0.3);
      }).toList(),
    );
  }

  Future<void> _handleAppleSignIn() async {
    setState(() => _isAppleLoading = true);

    try {
      // Import and use AuthService for Apple Sign-In
      final userInfo = await AuthService.signInWithApple();

      if (!mounted) return;

      if (userInfo != null) {
        // Kozmik karşılama overlay'i göster
        _showCosmicWelcome(userInfo.displayName);
      }
      // userInfo null ise web'de OAuth redirect olacak
      // authStateChanges listener basarili girisi yakalayacak
      // Loading state'i devam etsin ta ki redirect olana kadar
    } catch (e) {
      if (!mounted) return;
      final errorStr = e.toString();

      // Web'de JS interop hatalarini gosterme - OAuth devam ediyor olabilir
      if (errorStr.contains('TypeError') ||
          errorStr.contains('JSObject') ||
          errorStr.contains('minified')) {
        debugPrint(
          '🍎 JS interop hatasi yakalandi - OAuth redirect bekleniyor',
        );
        // Loading state'i devam etsin
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Apple bağlantısı kurulamadı: $e'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      setState(() => _isAppleLoading = false);
    }
    // finally bloğunu kaldırdık - loading state'i sadece hata durumunda kapatılıyor
    // başarılı OAuth'da redirect olacağı için loading devam etmeli
  }
}

class _BirthDataPage extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final String? userName;
  final ValueChanged<String> onNameChanged;
  final String? birthPlace;
  final void Function(String place, double lat, double lng) onPlaceChanged;
  final VoidCallback onContinue;

  const _BirthDataPage({
    required this.selectedDate,
    required this.onDateSelected,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.userName,
    required this.onNameChanged,
    required this.birthPlace,
    required this.onPlaceChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Center(
            child: SvgPicture.asset(
              'assets/images/logo_cat.svg',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Center(
            child: Text(
              'Kozmik Kimliğin',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 400.ms),
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Name input
          _buildSectionTitle(context, 'İsim *'),
          const SizedBox(height: 8),
          _NameInput(
            userName: userName,
            onNameChanged: onNameChanged,
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),

          // Birth Date
          _buildSectionTitle(context, 'Doğum Tarihi *'),
          const SizedBox(height: 8),
          BirthDatePicker(
            initialDate: selectedDate,
            onDateChanged: onDateSelected,
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),

          // Birth Time
          _buildSectionTitle(context, 'Doğum Saati *'),
          const SizedBox(height: 8),
          _BirthTimePicker(
            selectedTime: selectedTime,
            onTimeSelected: onTimeSelected,
          ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
          const SizedBox(height: AppConstants.spacingLg),

          // Birth Place
          _buildSectionTitle(context, 'Doğum Yeri *'),
          const SizedBox(height: 8),
          _BirthPlacePicker(
            selectedPlace: birthPlace,
            onPlaceSelected: onPlaceChanged,
          ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

          const SizedBox(height: AppConstants.spacingLg),

          // Info box
          _InfoBox().animate().fadeIn(delay: 700.ms, duration: 400.ms),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  final String? userName;
  final ValueChanged<String> onNameChanged;

  const _NameInput({required this.userName, required this.onNameChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final hasValue = userName != null && userName!.isNotEmpty;

    return TextField(
      onChanged: onNameChanged,
      style: TextStyle(
        color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: 'İsmin',
        hintStyle: TextStyle(
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
            ? AppColors.surfaceDark.withAlpha(128)
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
                : (isDark ? AppColors.surfaceLight : Colors.grey.shade300),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(isDark ? 25 : 15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.primary.withAlpha(isDark ? 76 : 50),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kozmik haritanın tüm katmanlarını açmak için bilgilerini eksiksiz gir.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _BirthTimePicker extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const _BirthTimePicker({
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showTimePicker(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark.withAlpha(128)
              : AppColors.lightSurfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedTime != null
                ? colorScheme.primary
                : (isDark ? AppColors.surfaceLight : Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: selectedTime != null
                  ? colorScheme.primary
                  : (isDark ? AppColors.textMuted : AppColors.lightTextMuted),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: selectedTime != null
                  ? Text(
                      '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    )
                  : Text(
                      'Saat seç',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                    ),
            ),
            if (selectedTime != null)
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int selectedHour = selectedTime?.hour ?? 12;
        int selectedMinute = selectedTime?.minute ?? 0;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 350,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'İptal',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ),
                      Text(
                        'Doğum Saati',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          onTimeSelected(
                            TimeOfDay(
                              hour: selectedHour,
                              minute: selectedMinute,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Tamam',
                          style: TextStyle(color: colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        // Hour picker
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedHour,
                            ),
                            itemExtent: 40,
                            onSelectedItemChanged: (index) {
                              setModalState(() => selectedHour = index);
                            },
                            children: List.generate(24, (index) {
                              return Center(
                                child: Text(
                                  index.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textPrimary
                                        : AppColors.lightTextPrimary,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        Text(
                          ':',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textPrimary
                                : AppColors.lightTextPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Minute picker
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedMinute,
                            ),
                            itemExtent: 40,
                            onSelectedItemChanged: (index) {
                              setModalState(() => selectedMinute = index);
                            },
                            children: List.generate(60, (index) {
                              return Center(
                                child: Text(
                                  index.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textPrimary
                                        : AppColors.lightTextPrimary,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _BirthPlacePicker extends StatefulWidget {
  final String? selectedPlace;
  final void Function(String place, double lat, double lng) onPlaceSelected;

  const _BirthPlacePicker({
    required this.selectedPlace,
    required this.onPlaceSelected,
  });

  @override
  State<_BirthPlacePicker> createState() => _BirthPlacePickerState();
}

class _BirthPlacePickerState extends State<_BirthPlacePicker> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showPlacePicker(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark.withAlpha(128)
              : AppColors.lightSurfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.selectedPlace != null
                ? colorScheme.primary
                : (isDark ? AppColors.surfaceLight : Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: widget.selectedPlace != null
                  ? colorScheme.primary
                  : (isDark ? AppColors.textMuted : AppColors.lightTextMuted),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: widget.selectedPlace != null
                  ? Text(
                      widget.selectedPlace!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(
                      'Şehir seç (${WorldCities.sortedCities.length} şehir)',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                    ),
            ),
            if (widget.selectedPlace != null)
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  void _showPlacePicker(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String searchQuery = '';

        return StatefulBuilder(
          builder: (context, setModalState) {
            List<CityData> filteredCities;
            if (searchQuery.isEmpty) {
              filteredCities = WorldCities.sortedCities;
            } else {
              filteredCities = WorldCities.search(searchQuery);
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'İptal',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Doğum Yeri',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textPrimary
                                      : AppColors.lightTextPrimary,
                                ),
                          ),
                          Text(
                            '${WorldCities.sortedCities.length} şehir',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textMuted
                                      : AppColors.lightTextMuted,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 60),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search field
                  TextField(
                    onChanged: (value) {
                      setModalState(() => searchQuery = value);
                    },
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Şehir veya ülke ara. . .',
                      hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                      filled: true,
                      fillColor: isDark
                          ? AppColors.surfaceLight.withAlpha(76)
                          : AppColors.lightSurfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Results count
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${filteredCities.length} sonuç',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCities.length,
                      itemBuilder: (context, index) {
                        final city = filteredCities[index];
                        final isSelected =
                            widget.selectedPlace == city.displayName;

                        return ListTile(
                          leading: Icon(
                            city.country == 'Türkiye' || city.country == 'KKTC'
                                ? Icons.flag
                                : Icons.public,
                            color: isSelected
                                ? colorScheme.primary
                                : (isDark
                                      ? AppColors.textMuted
                                      : AppColors.lightTextMuted),
                          ),
                          title: Text(
                            city.name,
                            style: TextStyle(
                              color: isSelected
                                  ? colorScheme.primary
                                  : (isDark
                                        ? AppColors.textPrimary
                                        : AppColors.lightTextPrimary),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            city.region != null
                                ? '${city.region}, ${city.country}'
                                : city.country,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textMuted
                                  : AppColors.lightTextMuted,
                              fontSize: 14,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color: colorScheme.primary,
                                )
                              : null,
                          onTap: () {
                            widget.onPlaceSelected(
                              city.displayName,
                              city.lat,
                              city.lng,
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _YourSignPage extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? birthPlace;
  final VoidCallback onComplete;

  const _YourSignPage({
    required this.selectedDate,
    required this.selectedTime,
    required this.birthPlace,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDate == null) {
      return Center(
        child: Text(
          'Lütfen doğum tarihini gir',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 18,
          ),
        ),
      );
    }

    final sign = ZodiacSignExtension.fromDate(selectedDate!);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Üst bölüm - Burç sembolü ve ismi
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [sign.color.withAlpha(50), sign.color.withAlpha(20)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: sign.color.withAlpha(80)),
            ),
            child: Row(
              children: [
                // Burç sembolü
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: sign.color.withAlpha(40),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: sign.color.withAlpha(100),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Text(
                    sign.symbol,
                    style: TextStyle(fontSize: 48, color: sign.color),
                  ),
                ).animate().scale(
                  begin: const Offset(0.5, 0.5),
                  curve: Curves.elasticOut,
                  duration: 600.ms,
                ),
                const SizedBox(width: 16),
                // Burç bilgileri
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Güneş Burcun',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        sign.nameTr,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: sign.color,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        sign.dateRange,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Alt bölüm - Üst: Doğum bilgileri, Alt: Çözümlenecekler (dikey yerleşim)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Üst - Doğum Bilgileri
                  Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight.withAlpha(50),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: AppColors.auroraStart,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Doğum Bilgilerin',
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        color: AppColors.auroraStart,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildCompactDataRow(
                              context,
                              '📅',
                              'Tarih',
                              _formatDate(selectedDate!),
                            ),
                            if (selectedTime != null)
                              _buildCompactDataRow(
                                context,
                                '🕐',
                                'Saat',
                                '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',
                              ),
                            if (birthPlace != null)
                              _buildCompactDataRow(
                                context,
                                '📍',
                                'Yer',
                                birthPlace!,
                              ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .slideY(begin: -0.2),

                  const SizedBox(height: 12),

                  // Alt - Çözümlenecekler - Pastel gradient
                  Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2D2040), // Koyu mor
                              Color(0xFF1A2540), // Koyu mavi
                              Color(0xFF1F3040), // Koyu turkuaz
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(
                              0xFFE6E6FA,
                            ).withAlpha(40), // Pastel lavanta border
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text('✦', style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Çözümlenecekler',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: const Color(
                                            0xFFE6E6FA,
                                          ), // Pastel lavanta
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Feature list (no longer scrollable, uses wrap)
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPastelFeatureRow(
                                  context,
                                  '♄',
                                  '10 Gezegen',
                                  const Color(0xFFFFB347),
                                  true,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '△',
                                  'Gezegen Açıları',
                                  const Color(0xFF87CEEB),
                                  true,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '□',
                                  '12 Ev Sistemi',
                                  const Color(0xFFDDA0DD),
                                  selectedTime != null && birthPlace != null,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '↑',
                                  'Yükselen Burç',
                                  const Color(0xFF98FB98),
                                  selectedTime != null && birthPlace != null,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '☽',
                                  'Ay Düğümleri',
                                  const Color(0xFFE6E6FA),
                                  true,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '◆',
                                  'Karmik Harita',
                                  const Color(0xFFFFB6C1),
                                  true,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '○',
                                  'Psikolojik Profil',
                                  const Color(0xFFADD8E6),
                                  true,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '∞',
                                  'Numeroloji',
                                  const Color(0xFFF0E68C),
                                  true,
                                ),
                                _buildPastelFeatureRow(
                                  context,
                                  '☯',
                                  'Element Dengesi',
                                  const Color(0xFFB0E0E6),
                                  true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 400.ms)
                      .slideY(begin: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactDataRow(
    BuildContext context,
    String emoji,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pastel renkli feature row - her öğe kendi rengiyle
  Widget _buildPastelFeatureRow(
    BuildContext context,
    String emoji,
    String feature,
    Color pastelColor,
    bool available,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              feature,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: available
                    ? pastelColor
                    : AppColors.textMuted.withOpacity(0.5),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: available
                  ? pastelColor.withOpacity(0.2)
                  : Colors.transparent,
              border: Border.all(
                color: available
                    ? pastelColor
                    : AppColors.textMuted.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: available
                ? Icon(Icons.check, size: 10, color: pastelColor)
                : null,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
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
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

/// Kozmik karşılama overlay'i - tam ekran, animasyonlu
class _CosmicWelcomeOverlay extends StatefulWidget {
  final String greeting;
  final String? name;
  final VoidCallback onComplete;

  const _CosmicWelcomeOverlay({
    required this.greeting,
    this.name,
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
    );
    if (!runtime_flags.disableAnimations) {
      _starController.repeat();
    }

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    // 2.5 saniye sonra otomatik geç
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
                Color(0xFF0D0D1A),
                Color(0xFF1A1A2E),
                Color(0xFF16213E),
                Color(0xFF0F3460),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Yıldızlar arka planı
              ...List.generate(50, (index) {
                final random = index * 7.3;
                return Positioned(
                  left: (random * 13) % MediaQuery.of(context).size.width,
                  top: (random * 17) % MediaQuery.of(context).size.height,
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
                              ? const Color(0xFFFFD700)
                              : index % 3 == 1
                              ? const Color(0xFFE6E6FA)
                              : Colors.white,
                        ),
                      );
                    },
                  ),
                );
              }),

              // Ana içerik
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
                        // Ay/Yıldız ikonu
                        const Text('🌙', style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 32),

                        // Ezoterik mesaj
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFFFFD700),
                              Color(0xFFFF6B9D),
                              Color(0xFF9B59B6),
                            ],
                          ).createShader(bounds),
                          child: Text(
                            widget.greeting,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // İsim varsa göster
                        if (widget.name != null && widget.name!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            widget.name!,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFD700),
                              letterSpacing: 2,
                            ),
                          ),
                        ],

                        const SizedBox(height: 48),

                        // Alt mesaj
                        Text(
                          '✨ Dokunarak devam et ✨',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.5),
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
    );
  }
}
