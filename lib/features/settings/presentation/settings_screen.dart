import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/localization_service.dart';
import '../../../data/models/house.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/url_launcher_service.dart';
import '../../../data/services/premium_service.dart';
import '../../../data/services/paywall_service.dart';
import '../../../shared/widgets/cosmic_background.dart';
import 'notification_settings_section.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    final themeMode = ref.watch(themeModeProvider);
    final houseSystem = ref.watch(houseSystemProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, language),
                const SizedBox(height: AppConstants.spacingXl),
                _buildThemeSection(context, ref, language, themeMode, isDark),
                const SizedBox(height: AppConstants.spacingLg),
                _buildLanguageSection(context, ref, language, isDark),
                const SizedBox(height: AppConstants.spacingLg),
                _buildHouseSystemSection(
                  context,
                  ref,
                  language,
                  houseSystem,
                  isDark,
                ),
                const SizedBox(height: AppConstants.spacingLg),
                _buildAccountSection(context, ref, language, isDark),
                const SizedBox(height: AppConstants.spacingLg),
                const NotificationSettingsSection()
                    .animate()
                    .fadeIn(delay: 350.ms, duration: 400.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: AppConstants.spacingXl),
                _buildAppInfoSection(context, ref, language, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLanguage language) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.textPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(width: AppConstants.spacingSm),
        Text(
          L10n.get('settings', language),
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.starGold),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildThemeSection(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
    ThemeMode themeMode,
    bool isDark,
  ) {
    return _SettingsSection(
      title: L10n.get('theme', language),
      icon: Icons.palette_outlined,
      isDark: isDark,
      child: Row(
        children: [
          Expanded(
            child: _ThemeOption(
              label: L10n.get('light_mode', language),
              icon: Icons.light_mode,
              isSelected: themeMode == ThemeMode.light,
              isDark: isDark,
              onTap: () {
                ref.read(themeModeProvider.notifier).state = ThemeMode.light;
                StorageService.saveThemeMode(ThemeMode.light);
              },
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: _ThemeOption(
              label: L10n.get('dark_mode', language),
              icon: Icons.dark_mode,
              isSelected: themeMode == ThemeMode.dark,
              isDark: isDark,
              onTap: () {
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
                StorageService.saveThemeMode(ThemeMode.dark);
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildLanguageSection(
    BuildContext context,
    WidgetRef ref,
    AppLanguage currentLanguage,
    bool isDark,
  ) {
    return _SettingsSection(
      title: L10n.get('language', currentLanguage),
      icon: Icons.language,
      isDark: isDark,
      child: Wrap(
        spacing: AppConstants.spacingSm,
        runSpacing: AppConstants.spacingSm,
        children: AppLanguage.values.map((lang) {
          final isSelected = lang == currentLanguage;
          return GestureDetector(
            onTap: () {
              ref.read(languageProvider.notifier).state = lang;
              StorageService.saveLanguage(lang);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
                vertical: AppConstants.spacingSm,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.auroraStart.withOpacity(0.2)
                    : (isDark
                          ? AppColors.surfaceLight.withOpacity(0.3)
                          : AppColors.lightSurfaceVariant),
                borderRadius: BorderRadius.circular(AppConstants.radiusFull),
                border: Border.all(
                  color: isSelected
                      ? AppColors.auroraStart
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(lang.flag, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    lang.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? AppColors.auroraStart
                          : (isDark
                                ? AppColors.textPrimary
                                : AppColors.lightTextPrimary),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: AppColors.auroraStart,
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildHouseSystemSection(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
    HouseSystem currentSystem,
    bool isDark,
  ) {
    return _SettingsSection(
      title: _getLocalizedString('house_system', language),
      icon: Icons.grid_view_rounded,
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getLocalizedString('house_system_desc', language),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: AppConstants.spacingSm,
            runSpacing: AppConstants.spacingSm,
            children: HouseSystem.values.map((system) {
              final isSelected = system == currentSystem;
              return GestureDetector(
                onTap: () {
                  ref.read(houseSystemProvider.notifier).state = system;
                  StorageService.saveHouseSystem(system.index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingMd,
                    vertical: AppConstants.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.celestialGold.withOpacity(0.2)
                        : (isDark
                              ? AppColors.surfaceLight.withOpacity(0.3)
                              : AppColors.lightSurfaceVariant),
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusFull,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.celestialGold
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        system.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? AppColors.celestialGold
                              : (isDark
                                    ? AppColors.textPrimary
                                    : AppColors.lightTextPrimary),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: AppColors.celestialGold,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (currentSystem != HouseSystem.placidus) ...[
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: AppColors.celestialGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                border: Border.all(
                  color: AppColors.celestialGold.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.celestialGold,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      currentSystem.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 250.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildAccountSection(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
    bool isDark,
  ) {
    final premiumState = ref.watch(premiumProvider);
    final isPremium = premiumState.isPremium;

    return _SettingsSection(
      title: _getLocalizedString('account', language),
      icon: Icons.person_outline,
      isDark: isDark,
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.account_circle_outlined,
            title: _getLocalizedString('edit_profile', language),
            subtitle: _getLocalizedString('edit_profile_desc', language),
            isDark: isDark,
            onTap: () => context.push(Routes.profile),
          ),
          const Divider(height: 1),
          _SettingsTile(
            icon: Icons.workspace_premium_outlined,
            title: _getLocalizedString('premium', language),
            subtitle: isPremium
                ? _getLocalizedString('premium_active', language)
                : _getLocalizedString('premium_desc', language),
            isDark: isDark,
            onTap: () => context.push(Routes.premium),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: isPremium
                    ? LinearGradient(
                        colors: [
                          AppColors.success,
                          AppColors.success.withOpacity(0.8),
                        ],
                      )
                    : AppColors.goldGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isPremium ? '✓ PRO' : 'PRO',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isPremium ? Colors.white : AppColors.deepSpace,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Show "Manage Subscription" only for premium users
          if (isPremium) ...[
            const Divider(height: 1),
            _SettingsTile(
              icon: Icons.credit_card_outlined,
              title: _getLocalizedString('manage_subscription', language),
              subtitle: _getLocalizedString(
                'manage_subscription_desc',
                language,
              ),
              isDark: isDark,
              onTap: () async {
                await ref.read(paywallServiceProvider).presentCustomerCenter();
              },
            ),
          ],
          const Divider(height: 1),
          _SettingsTile(
            icon: Icons.delete_outline,
            title: _getLocalizedString('clear_data', language),
            subtitle: _getLocalizedString('clear_data_desc', language),
            isDark: isDark,
            isDestructive: true,
            onTap: () => _showClearDataDialog(context, ref, language),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildAppInfoSection(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
    bool isDark,
  ) {
    final urlLauncher = ref.read(urlLauncherServiceProvider);

    return _SettingsSection(
      title: _getLocalizedString('about', language),
      icon: Icons.info_outline,
      isDark: isDark,
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.star_outline,
            title: _getLocalizedString('rate_app', language),
            subtitle: _getLocalizedString('rate_app_desc', language),
            isDark: isDark,
            onTap: () async {
              await urlLauncher.requestAppReview();
            },
          ),
          const Divider(height: 1),
          _SettingsTile(
            icon: Icons.gavel_outlined,
            title: _getLocalizedString('disclaimer', language),
            subtitle: _getLocalizedString('disclaimer_desc', language),
            isDark: isDark,
            onTap: () => _showDisclaimerDialog(context, language, isDark),
          ),
          const Divider(height: 1),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: _getLocalizedString('privacy_policy', language),
            subtitle: null,
            isDark: isDark,
            onTap: () async {
              await urlLauncher.openPrivacyPolicy();
            },
          ),
          const Divider(height: 1),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: _getLocalizedString('terms_of_service', language),
            subtitle: null,
            isDark: isDark,
            onTap: () async {
              await urlLauncher.openTermsOfService();
            },
          ),
          const Divider(height: 1),
          _SettingsTile(
            icon: Icons.mail_outline,
            title: _getLocalizedString('contact_support', language),
            subtitle: null,
            isDark: isDark,
            onTap: () async {
              await urlLauncher.openSupportEmail(
                subject: 'Venus One Destek',
                body: '\n\n---\nApp Version: 1.0.0',
              );
            },
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Venus One v1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ),
          const Divider(height: 24),
          _SettingsTile(
            icon: Icons.admin_panel_settings,
            title: 'Admin',
            subtitle: 'Dashboard & Analytics',
            isDark: isDark,
            onTap: () => context.push(Routes.adminLogin),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.starGold, AppColors.celestialGold],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'PIN',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.deepSpace,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1);
  }

  void _showClearDataDialog(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        title: Text(
          _getLocalizedString('clear_data_confirm', language),
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ),
        content: Text(
          _getLocalizedString('clear_data_warning', language),
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              L10n.get('cancel', language),
              style: TextStyle(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await StorageService.clearAllData();
              ref.read(userProfileProvider.notifier).clearProfile();
              ref.read(onboardingCompleteProvider.notifier).state = false;
              if (context.mounted) {
                context.go(Routes.onboarding);
              }
            },
            child: Text(
              _getLocalizedString('delete', language),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showDisclaimerDialog(
    BuildContext context,
    AppLanguage language,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.starGold),
            const SizedBox(width: 12),
            Text(
              _getLocalizedString('disclaimer', language),
              style: TextStyle(
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _getLocalizedString('disclaimer_content', language),
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.starGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.starGold.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.starGold,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getLocalizedString('disclaimer_tip', language),
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.lightTextSecondary,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              L10n.get('ok', language),
              style: TextStyle(color: AppColors.starGold),
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedString(String key, AppLanguage language) {
    final Map<String, Map<AppLanguage, String>> strings = {
      'disclaimer': {
        AppLanguage.en: 'Disclaimer',
        AppLanguage.tr: 'Yasal Uyarı',
        AppLanguage.el: 'Αποποίηση',
        AppLanguage.bg: 'Отказ от отговорност',
        AppLanguage.ru: 'Отказ от ответственности',
        AppLanguage.zh: '免责声明',
        AppLanguage.fr: 'Avertissement',
        AppLanguage.de: 'Haftungsausschluss',
        AppLanguage.es: 'Descargo',
        AppLanguage.ar: 'إخلاء المسؤولية',
      },
      'disclaimer_desc': {
        AppLanguage.en: 'Entertainment purposes only',
        AppLanguage.tr: 'Sadece eğlence amaçlıdır',
        AppLanguage.el: 'Μόνο για ψυχαγωγικούς σκοπούς',
        AppLanguage.bg: 'Само за забавление',
        AppLanguage.ru: 'Только для развлечения',
        AppLanguage.zh: '仅供娱乐',
        AppLanguage.fr: 'À des fins de divertissement uniquement',
        AppLanguage.de: 'Nur zu Unterhaltungszwecken',
        AppLanguage.es: 'Solo para entretenimiento',
        AppLanguage.ar: 'لأغراض الترفيه فقط',
      },
      'disclaimer_content': {
        AppLanguage.en:
            '''This app provides astrological, numerological, tarot, and dream interpretation content for entertainment and self-reflection purposes only.

The content does not constitute professional advice in any field including but not limited to: medical, psychological, financial, legal, or relationship advice.

If you need professional support, please consult qualified professionals in the relevant field.

All interpretations are generated for informational and entertainment purposes and should not be used as the basis for important life decisions.''',
        AppLanguage.tr:
            '''Bu uygulama astroloji, numeroloji, tarot ve rüya yorumu içeriklerini yalnızca eğlence ve kendini keşfetme amaçlı sunmaktadır.

İçerikler; tıbbi, psikolojik, finansal, hukuki veya ilişki danışmanlığı dahil hiçbir alanda profesyonel tavsiye niteliği taşımaz.

Profesyonel desteğe ihtiyacınız varsa, lütfen ilgili alanda uzman kişilere başvurun.

Tüm yorumlar bilgilendirme ve eğlence amaçlı oluşturulmaktadır ve önemli yaşam kararlarına temel oluşturmamalıdır.''',
        AppLanguage.el:
            'Αυτή η εφαρμογή παρέχει αστρολογικό περιεχόμενο μόνο για σκοπούς ψυχαγωγίας.',
        AppLanguage.bg:
            'Това приложение предоставя астрологично съдържание само за забавление.',
        AppLanguage.ru:
            'Это приложение предоставляет астрологический контент только для развлечения.',
        AppLanguage.zh: '此应用程序仅提供娱乐性的占星内容。',
        AppLanguage.fr:
            'Cette application fournit du contenu astrologique à des fins de divertissement uniquement.',
        AppLanguage.de:
            'Diese App bietet astrologische Inhalte nur zur Unterhaltung.',
        AppLanguage.es:
            'Esta aplicación proporciona contenido astrológico solo para entretenimiento.',
        AppLanguage.ar: 'يقدم هذا التطبيق محتوى فلكي لأغراض الترفيه فقط.',
      },
      'disclaimer_tip': {
        AppLanguage.en:
            'Use the content for self-reflection, not decision-making.',
        AppLanguage.tr:
            'İçerikleri karar verme için değil, kendini keşfetmek için kullan.',
        AppLanguage.el: 'Χρησιμοποιήστε το περιεχόμενο για αυτοστοχασμό.',
        AppLanguage.bg: 'Използвайте съдържанието за саморефлексия.',
        AppLanguage.ru: 'Используйте контент для самоанализа.',
        AppLanguage.zh: '使用内容进行自我反思。',
        AppLanguage.fr: 'Utilisez le contenu pour la réflexion personnelle.',
        AppLanguage.de: 'Nutze den Inhalt zur Selbstreflexion.',
        AppLanguage.es: 'Usa el contenido para la autorreflexión.',
        AppLanguage.ar: 'استخدم المحتوى للتأمل الذاتي.',
      },
      'house_system': {
        AppLanguage.en: 'House System',
        AppLanguage.tr: 'Ev Sistemi',
        AppLanguage.el: 'Σύστημα Οίκων',
        AppLanguage.bg: 'Система на Домовете',
        AppLanguage.ru: 'Система Домов',
        AppLanguage.zh: '宫位系统',
        AppLanguage.fr: 'Système de Maisons',
        AppLanguage.de: 'Häusersystem',
        AppLanguage.es: 'Sistema de Casas',
        AppLanguage.ar: 'نظام البيوت',
      },
      'house_system_desc': {
        AppLanguage.en: 'Choose how houses are calculated in your charts',
        AppLanguage.tr: 'Haritalarınızda evlerin nasıl hesaplanacağını seçin',
        AppLanguage.el: 'Επιλέξτε πώς υπολογίζονται οι οίκοι στα χάρτες σας',
        AppLanguage.bg: 'Изберете как се изчисляват домовете в картите ви',
        AppLanguage.ru: 'Выберите, как рассчитываются дома в ваших картах',
        AppLanguage.zh: '选择星盘中宫位的计算方式',
        AppLanguage.fr:
            'Choisissez comment les maisons sont calculées dans vos cartes',
        AppLanguage.de: 'Wähle, wie Häuser in deinen Karten berechnet werden',
        AppLanguage.es: 'Elige cómo se calculan las casas en tus cartas',
        AppLanguage.ar: 'اختر كيفية حساب البيوت في خرائطك',
      },
      'account': {
        AppLanguage.en: 'Account',
        AppLanguage.tr: 'Hesap',
        AppLanguage.el: 'Λογαριασμός',
        AppLanguage.bg: 'Акаунт',
        AppLanguage.ru: 'Аккаунт',
        AppLanguage.zh: '账户',
        AppLanguage.fr: 'Compte',
        AppLanguage.de: 'Konto',
        AppLanguage.es: 'Cuenta',
        AppLanguage.ar: 'الحساب',
      },
      'edit_profile': {
        AppLanguage.en: 'Edit Profile',
        AppLanguage.tr: 'Profili Düzenle',
        AppLanguage.el: 'Επεξεργασία Προφίλ',
        AppLanguage.bg: 'Редактиране на Профил',
        AppLanguage.ru: 'Редактировать Профиль',
        AppLanguage.zh: '编辑个人资料',
        AppLanguage.fr: 'Modifier le Profil',
        AppLanguage.de: 'Profil Bearbeiten',
        AppLanguage.es: 'Editar Perfil',
        AppLanguage.ar: 'تعديل الملف الشخصي',
      },
      'edit_profile_desc': {
        AppLanguage.en: 'Update your birth information',
        AppLanguage.tr: 'Doğum bilgilerini güncelle',
        AppLanguage.el: 'Ενημερώστε τα στοιχεία γέννησής σας',
        AppLanguage.bg: 'Актуализирайте информацията за раждането си',
        AppLanguage.ru: 'Обновите данные о рождении',
        AppLanguage.zh: '更新您的出生信息',
        AppLanguage.fr: 'Mettez à jour vos informations de naissance',
        AppLanguage.de: 'Aktualisiere deine Geburtsdaten',
        AppLanguage.es: 'Actualiza tu información de nacimiento',
        AppLanguage.ar: 'تحديث معلومات ميلادك',
      },
      'premium': {
        AppLanguage.en: 'Premium',
        AppLanguage.tr: 'Premium',
        AppLanguage.el: 'Premium',
        AppLanguage.bg: 'Premium',
        AppLanguage.ru: 'Premium',
        AppLanguage.zh: '高级版',
        AppLanguage.fr: 'Premium',
        AppLanguage.de: 'Premium',
        AppLanguage.es: 'Premium',
        AppLanguage.ar: 'بريميوم',
      },
      'premium_desc': {
        AppLanguage.en: 'Unlock all cosmic powers',
        AppLanguage.tr: 'Tüm kozmik güçleri aç',
        AppLanguage.el: 'Ξεκλειδώστε όλες τις κοσμικές δυνάμεις',
        AppLanguage.bg: 'Отключете всички космически сили',
        AppLanguage.ru: 'Разблокируйте все космические силы',
        AppLanguage.zh: '解锁所有宇宙力量',
        AppLanguage.fr: 'Débloquez tous les pouvoirs cosmiques',
        AppLanguage.de: 'Alle kosmischen Kräfte freischalten',
        AppLanguage.es: 'Desbloquea todos los poderes cósmicos',
        AppLanguage.ar: 'افتح جميع القوى الكونية',
      },
      'premium_active': {
        AppLanguage.en: 'Cosmic powers active',
        AppLanguage.tr: 'Kozmik güçler aktif',
        AppLanguage.el: 'Κοσμικές δυνάμεις ενεργές',
        AppLanguage.bg: 'Космическите сили са активни',
        AppLanguage.ru: 'Космические силы активны',
        AppLanguage.zh: '宇宙力量已激活',
        AppLanguage.fr: 'Pouvoirs cosmiques actifs',
        AppLanguage.de: 'Kosmische Kräfte aktiv',
        AppLanguage.es: 'Poderes cósmicos activos',
        AppLanguage.ar: 'القوى الكونية نشطة',
      },
      'manage_subscription': {
        AppLanguage.en: 'Manage Subscription',
        AppLanguage.tr: 'Aboneliği Yönet',
        AppLanguage.el: 'Διαχείριση Συνδρομής',
        AppLanguage.bg: 'Управление на Абонамента',
        AppLanguage.ru: 'Управление Подпиской',
        AppLanguage.zh: '管理订阅',
        AppLanguage.fr: 'Gérer l\'Abonnement',
        AppLanguage.de: 'Abonnement Verwalten',
        AppLanguage.es: 'Gestionar Suscripción',
        AppLanguage.ar: 'إدارة الاشتراك',
      },
      'manage_subscription_desc': {
        AppLanguage.en: 'View and manage your subscription',
        AppLanguage.tr: 'Aboneliğini görüntüle ve yönet',
        AppLanguage.el: 'Δείτε και διαχειριστείτε τη συνδρομή σας',
        AppLanguage.bg: 'Преглед и управление на абонамента ви',
        AppLanguage.ru: 'Просмотр и управление подпиской',
        AppLanguage.zh: '查看和管理您的订阅',
        AppLanguage.fr: 'Voir et gérer votre abonnement',
        AppLanguage.de: 'Abonnement anzeigen und verwalten',
        AppLanguage.es: 'Ver y gestionar tu suscripción',
        AppLanguage.ar: 'عرض وإدارة اشتراكك',
      },
      'clear_data': {
        AppLanguage.en: 'Clear Data',
        AppLanguage.tr: 'Verileri Sil',
        AppLanguage.el: 'Διαγραφή Δεδομένων',
        AppLanguage.bg: 'Изтриване на Данни',
        AppLanguage.ru: 'Очистить Данные',
        AppLanguage.zh: '清除数据',
        AppLanguage.fr: 'Effacer les Données',
        AppLanguage.de: 'Daten Löschen',
        AppLanguage.es: 'Borrar Datos',
        AppLanguage.ar: 'مسح البيانات',
      },
      'clear_data_desc': {
        AppLanguage.en: 'Delete all your data and start fresh',
        AppLanguage.tr: 'Tüm verilerini sil ve baştan başla',
        AppLanguage.el:
            'Διαγράψτε όλα τα δεδομένα σας και ξεκινήστε από την αρχή',
        AppLanguage.bg: 'Изтрийте всички данни и започнете отначало',
        AppLanguage.ru: 'Удалите все данные и начните заново',
        AppLanguage.zh: '删除所有数据并重新开始',
        AppLanguage.fr: 'Supprimez toutes vos données et recommencez',
        AppLanguage.de: 'Lösche alle Daten und starte neu',
        AppLanguage.es: 'Elimina todos tus datos y empieza de nuevo',
        AppLanguage.ar: 'احذف جميع بياناتك وابدأ من جديد',
      },
      'clear_data_confirm': {
        AppLanguage.en: 'Clear All Data?',
        AppLanguage.tr: 'Tüm Veriler Silinsin mi?',
        AppLanguage.el: 'Διαγραφή Όλων των Δεδομένων;',
        AppLanguage.bg: 'Изтриване на Всички Данни?',
        AppLanguage.ru: 'Очистить Все Данные?',
        AppLanguage.zh: '清除所有数据？',
        AppLanguage.fr: 'Effacer Toutes les Données?',
        AppLanguage.de: 'Alle Daten Löschen?',
        AppLanguage.es: '¿Borrar Todos los Datos?',
        AppLanguage.ar: 'مسح جميع البيانات؟',
      },
      'clear_data_warning': {
        AppLanguage.en:
            'This will delete your profile, settings, and all saved data. This action cannot be undone.',
        AppLanguage.tr:
            'Bu işlem profilinizi, ayarlarınızı ve tüm kayıtlı verilerinizi silecektir. Bu işlem geri alınamaz.',
        AppLanguage.el:
            'Αυτό θα διαγράψει το προφίλ σας, τις ρυθμίσεις και όλα τα αποθηκευμένα δεδομένα. Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.',
        AppLanguage.bg:
            'Това ще изтрие вашия профил, настройки и всички запазени данни. Това действие не може да бъде отменено.',
        AppLanguage.ru:
            'Это удалит ваш профиль, настройки и все сохраненные данные. Это действие нельзя отменить.',
        AppLanguage.zh: '这将删除您的个人资料、设置和所有保存的数据。此操作无法撤消。',
        AppLanguage.fr:
            'Cela supprimera votre profil, vos paramètres et toutes les données enregistrées. Cette action ne peut pas être annulée.',
        AppLanguage.de:
            'Dies löscht dein Profil, deine Einstellungen und alle gespeicherten Daten. Diese Aktion kann nicht rückgängig gemacht werden.',
        AppLanguage.es:
            'Esto eliminará tu perfil, configuración y todos los datos guardados. Esta acción no se puede deshacer.',
        AppLanguage.ar:
            'سيؤدي هذا إلى حذف ملفك الشخصي وإعداداتك وجميع البيانات المحفوظة. لا يمكن التراجع عن هذا الإجراء.',
      },
      'delete': {
        AppLanguage.en: 'Delete',
        AppLanguage.tr: 'Sil',
        AppLanguage.el: 'Διαγραφή',
        AppLanguage.bg: 'Изтриване',
        AppLanguage.ru: 'Удалить',
        AppLanguage.zh: '删除',
        AppLanguage.fr: 'Supprimer',
        AppLanguage.de: 'Löschen',
        AppLanguage.es: 'Eliminar',
        AppLanguage.ar: 'حذف',
      },
      'about': {
        AppLanguage.en: 'About',
        AppLanguage.tr: 'Hakkında',
        AppLanguage.el: 'Σχετικά',
        AppLanguage.bg: 'Относно',
        AppLanguage.ru: 'О приложении',
        AppLanguage.zh: '关于',
        AppLanguage.fr: 'À propos',
        AppLanguage.de: 'Über',
        AppLanguage.es: 'Acerca de',
        AppLanguage.ar: 'حول',
      },
      'rate_app': {
        AppLanguage.en: 'Rate App',
        AppLanguage.tr: 'Uygulamayı Değerlendir',
        AppLanguage.el: 'Βαθμολογήστε την Εφαρμογή',
        AppLanguage.bg: 'Оценете Приложението',
        AppLanguage.ru: 'Оценить Приложение',
        AppLanguage.zh: '评价应用',
        AppLanguage.fr: 'Évaluer l\'Application',
        AppLanguage.de: 'App Bewerten',
        AppLanguage.es: 'Valorar App',
        AppLanguage.ar: 'تقييم التطبيق',
      },
      'rate_app_desc': {
        AppLanguage.en: 'Share your cosmic experience',
        AppLanguage.tr: 'Kozmik deneyimini paylaş',
        AppLanguage.el: 'Μοιραστείτε την κοσμική σας εμπειρία',
        AppLanguage.bg: 'Споделете космическия си опит',
        AppLanguage.ru: 'Поделитесь своим космическим опытом',
        AppLanguage.zh: '分享您的宇宙体验',
        AppLanguage.fr: 'Partagez votre expérience cosmique',
        AppLanguage.de: 'Teile deine kosmische Erfahrung',
        AppLanguage.es: 'Comparte tu experiencia cósmica',
        AppLanguage.ar: 'شارك تجربتك الكونية',
      },
      'privacy_policy': {
        AppLanguage.en: 'Privacy Policy',
        AppLanguage.tr: 'Gizlilik Politikası',
        AppLanguage.el: 'Πολιτική Απορρήτου',
        AppLanguage.bg: 'Политика за Поверителност',
        AppLanguage.ru: 'Политика Конфиденциальности',
        AppLanguage.zh: '隐私政策',
        AppLanguage.fr: 'Politique de Confidentialité',
        AppLanguage.de: 'Datenschutzrichtlinie',
        AppLanguage.es: 'Política de Privacidad',
        AppLanguage.ar: 'سياسة الخصوصية',
      },
      'terms_of_service': {
        AppLanguage.en: 'Terms of Service',
        AppLanguage.tr: 'Kullanım Koşulları',
        AppLanguage.el: 'Όροι Χρήσης',
        AppLanguage.bg: 'Условия за Ползване',
        AppLanguage.ru: 'Условия Использования',
        AppLanguage.zh: '服务条款',
        AppLanguage.fr: 'Conditions d\'Utilisation',
        AppLanguage.de: 'Nutzungsbedingungen',
        AppLanguage.es: 'Términos de Servicio',
        AppLanguage.ar: 'شروط الخدمة',
      },
      'contact_support': {
        AppLanguage.en: 'Contact Support',
        AppLanguage.tr: 'Destek ile İletişim',
        AppLanguage.el: 'Επικοινωνία Υποστήριξης',
        AppLanguage.bg: 'Свържете се с Поддръжката',
        AppLanguage.ru: 'Связаться с Поддержкой',
        AppLanguage.zh: '联系支持',
        AppLanguage.fr: 'Contacter le Support',
        AppLanguage.de: 'Support Kontaktieren',
        AppLanguage.es: 'Contactar Soporte',
        AppLanguage.ar: 'الاتصال بالدعم',
      },
    };

    return strings[key]?[language] ?? strings[key]?[AppLanguage.en] ?? key;
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final bool isDark;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withOpacity(0.7)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.starGold, size: 20),
              const SizedBox(width: AppConstants.spacingSm),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),
          child,
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.auroraStart.withOpacity(0.3),
                    AppColors.auroraEnd.withOpacity(0.3),
                  ],
                )
              : null,
          color: isSelected
              ? null
              : (isDark
                    ? AppColors.surfaceLight.withOpacity(0.3)
                    : AppColors.lightSurfaceVariant),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.auroraStart : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.starGold
                  : (isDark ? AppColors.textMuted : AppColors.lightTextMuted),
              size: 28,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? (isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary)
                    : (isDark ? AppColors.textMuted : AppColors.lightTextMuted),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isDark;
  final bool isDestructive;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.isDark,
    this.isDestructive = false,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppColors.error
        : (isDark ? AppColors.textPrimary : AppColors.lightTextPrimary);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isDestructive
            ? AppColors.error
            : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            )
          : null,
      trailing:
          trailing ??
          Icon(
            Icons.chevron_right,
            color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
          ),
      onTap: onTap,
    );
  }
}
