import 'package:astrology_app/core/platform_compat.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/services/auth_service.dart';
import '../../../shared/widgets/cosmic_background.dart';

/// Login ekrani - Apple ve Email ile giris secenekleri
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  AuthProvider? _loadingProvider;

  bool get _showAppleSignIn {
    if (kIsWeb) return true; // Web'de her zaman goster
    try {
      return PlatformCompat.isIOS || PlatformCompat.isMacOS;
    } catch (_) {
      return false;
    }
  }

  Future<void> _signInWithApple() async {
    setState(() {
      _isLoading = true;
      _loadingProvider = AuthProvider.apple;
      _errorMessage = null;
    });

    try {
      final user = await AuthService.signInWithApple();
      // user null ise kullanici iptal etti veya web OAuth redirect yapti
      if (user != null && mounted) {
        context.go(Routes.home);
      }
      // Web'de OAuth redirect yapilir, null donmesi normal
      if (kIsWeb && user == null) {
        debugPrint('Web OAuth redirect bekleniyor...');
      }
    } catch (e) {
      debugPrint('Apple Sign-In UI error: $e');
      if (mounted) {
        setState(() {
          // Hata mesajini kullaniciya goster
          final errorStr = e.toString();
          if (errorStr.contains('Exception:')) {
            _errorMessage = errorStr.replaceAll('Exception:', '').trim();
          } else if (errorStr.contains('canceled') ||
              errorStr.contains('cancelled')) {
            // Iptal durumunda hata gosterme
            _errorMessage = null;
          } else {
            _errorMessage =
                'Apple ile giris yapilamadi. Lutfen tekrar deneyin.';
          }
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingProvider = null;
        });
      }
    }
  }

  void _navigateToEmailLogin() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const EmailLoginScreen()));
  }

  void _skipLogin() {
    context.go(Routes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingXl),
            child: Column(
              children: [
                const Spacer(flex: 1),

                // Logo ve baslik
                _buildHeader(context, isDark),

                const SizedBox(height: AppConstants.spacingHuge),

                // Giris butonlari
                _buildLoginButtons(context, isDark),

                if (_errorMessage != null) ...[
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: AppColors.error, fontSize: 14),
                    textAlign: TextAlign.center,
                  ).animate().shake(),
                ],

                const Spacer(flex: 2),

                // Atlama secenegi
                _buildSkipOption(context, isDark),

                const SizedBox(height: AppConstants.spacingMd),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Column(
      children: [
        const Text('✨', style: TextStyle(fontSize: 64))
            .animate(onPlay: (c) => c.repeat())
            .shimmer(duration: 2.seconds, color: AppColors.starGold),
        const SizedBox(height: AppConstants.spacingLg),
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppColors.starGold,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: AppConstants.spacingSm),
        Text(
          'Kozmik yolculuguna basla',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isDark
                ? AppColors.textSecondary
                : AppColors.lightTextSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildLoginButtons(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Apple Sign In (iOS/macOS/Web)
        if (_showAppleSignIn)
          _SocialLoginButton(
                label: 'Apple ile Devam Et',
                icon: Icons.apple,
                backgroundColor: isDark ? Colors.white : Colors.black,
                textColor: isDark ? Colors.black : Colors.white,
                onPressed: _isLoading ? null : _signInWithApple,
                isLoading: _loadingProvider == AuthProvider.apple,
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.2),

        if (_showAppleSignIn) const SizedBox(height: AppConstants.spacingMd),

        // Email Sign In
        _SocialLoginButton(
          label: 'E-posta ile Devam Et',
          icon: Icons.email_outlined,
          backgroundColor: Colors.transparent,
          textColor: isDark
              ? AppColors.textPrimary
              : AppColors.lightTextPrimary,
          borderColor: isDark
              ? AppColors.auroraStart
              : AppColors.lightAuroraStart,
          onPressed: _isLoading ? null : _navigateToEmailLogin,
          isLoading: _loadingProvider == AuthProvider.email,
        ).animate().fadeIn(delay: 600.ms, duration: 400.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _buildSkipOption(BuildContext context, bool isDark) {
    return TextButton(
      onPressed: _isLoading ? null : _skipLogin,
      child: Text(
        'Simdilik atla',
        style: TextStyle(
          color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          fontSize: 14,
        ),
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 400.ms);
  }
}

/// Sosyal giris butonu
class _SocialLoginButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _SocialLoginButton({
    required this.label,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Email ile giris ekrani
class EmailLoginScreen extends ConsumerStatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  ConsumerState<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLoading = false;
  bool _isSignUp = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      AuthUserInfo? user;

      if (_isSignUp) {
        user = await AuthService.signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _nameController.text.trim(),
        );
        // Supabase kayit sonrasi email dogrulama gerekebilir
        if (user != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kayit basarili! Email adresinizi dogrulayin.'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go(Routes.home);
        }
      } else {
        user = await AuthService.signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        if (user != null && mounted) {
          context.go(Routes.home);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Lutfen email adresinizi girin';
      });
      return;
    }

    try {
      await AuthService.sendPasswordResetEmail(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sifre sifirlama emaili gonderildi'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingXl),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Geri butonu
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),

                  const SizedBox(height: AppConstants.spacingXl),

                  // Baslik
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 48,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: AppConstants.spacingMd),
                        Text(
                          _isSignUp ? 'Hesap Olustur' : 'Giris Yap',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: AppConstants.spacingXl),

                  // Isim (sadece kayit olurken)
                  if (_isSignUp) ...[
                    _buildTextField(
                      controller: _nameController,
                      label: 'Isim',
                      icon: Icons.person_outline,
                      isDark: isDark,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Isim gerekli';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                  ],

                  // Email
                  _buildTextField(
                    controller: _emailController,
                    label: 'E-posta',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    isDark: isDark,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-posta gerekli';
                      }
                      if (!value.contains('@')) {
                        return 'Gecerli bir e-posta girin';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: AppConstants.spacingMd),

                  // Sifre
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Sifre',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    isDark: isDark,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sifre gerekli';
                      }
                      if (value.length < 6) {
                        return 'Sifre en az 6 karakter olmali';
                      }
                      return null;
                    },
                  ),

                  // Sifremi unuttum (sadece giris yaparken)
                  if (!_isSignUp) ...[
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _forgotPassword,
                        child: Text(
                          'Sifremi unuttum',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: AppConstants.spacingMd),

                  // Hata mesaji
                  if (_errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.error.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.error,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().shake(),

                  const SizedBox(height: AppConstants.spacingXl),

                  // Giris/Kayit butonu
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              _isSignUp ? 'Kayit Ol' : 'Giris Yap',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: AppConstants.spacingMd),

                  // Kayit ol / Giris yap gecisi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isSignUp
                            ? 'Zaten hesabiniz var mi?'
                            : 'Hesabiniz yok mu?',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textMuted
                              : AppColors.lightTextMuted,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                            _errorMessage = null;
                          });
                        },
                        child: Text(
                          _isSignUp ? 'Giris Yap' : 'Kayit Ol',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(
        color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
        ),
        suffixIcon: suffixIcon,
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
            color: isDark ? AppColors.surfaceLight : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
