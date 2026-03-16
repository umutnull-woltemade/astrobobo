import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/routes.dart';
import '../../../data/services/haptic_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/l10n_service.dart';

import '../../../data/services/notification_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/url_launcher_service.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/services/premium_service.dart';
import '../../../data/services/paywall_service.dart';
import '../../../data/services/app_lock_service.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/sync_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../shared/providers/sync_status_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/liquid_glass/glass_panel.dart';
import '../../../shared/widgets/cosmic_background.dart';
import '../../../shared/widgets/glass_dialog.dart';
import '../../../shared/widgets/gradient_text.dart';
import '../../../shared/widgets/glass_sliver_app_bar.dart';
import '../../premium/presentation/contextual_paywall_modal.dart';
import '../../../data/services/analytics_service.dart';
import 'notification_settings_section.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(analyticsServiceProvider).logScreenView('settings');
    final language = ref.watch(languageProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPremium = ref.watch(isPremiumUserProvider);
    final urlLauncher = ref.read(urlLauncherServiceProvider);

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: CupertinoScrollbar(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                GlassSliverAppBar(
                  title: L10nService.get('settings.title', language),
                  largeTitleMode: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ═══ APPEARANCE SECTION ═══
                      _SectionHeader(
                        title: L10nService.get('settings.theme_title', language)
                            .toUpperCase(),
                        isDark: isDark,
                      ),
                      _GroupedContainer(
                        isDark: isDark,
                        child: Row(
                          children: [
                            Expanded(
                              child: _ThemeOption(
                                label: language == AppLanguage.en
                                    ? 'Light'
                                    : 'Açık',
                                icon: Icons.light_mode,
                                isSelected: themeMode == ThemeMode.light,
                                isDark: isDark,
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  ref.read(themeModeProvider.notifier).state =
                                      ThemeMode.light;
                                  StorageService.saveThemeMode(ThemeMode.light);
                                  ref.read(analyticsServiceProvider).logEvent('theme_changed', {'theme': 'light'});
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _ThemeOption(
                                label: language == AppLanguage.en
                                    ? 'Dark'
                                    : 'Koyu',
                                icon: Icons.dark_mode,
                                isSelected: themeMode == ThemeMode.dark,
                                isDark: isDark,
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  ref.read(themeModeProvider.notifier).state =
                                      ThemeMode.dark;
                                  StorageService.saveThemeMode(ThemeMode.dark);
                                  ref.read(analyticsServiceProvider).logEvent('theme_changed', {'theme': 'dark'});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),

                      // ═══ TEXT SIZE SECTION ═══
                      _SectionHeader(
                        title: (language == AppLanguage.en
                                ? 'Text Size'
                                : 'Yazı Boyutu')
                            .toUpperCase(),
                        isDark: isDark,
                      ),
                      _GroupedContainer(
                        isDark: isDark,
                        child: Builder(builder: (context) {
                          final currentScale = ref.watch(fontSizeScaleProvider);
                          return Row(
                            children: [
                              Expanded(
                                child: _ThemeOption(
                                  label: language == AppLanguage.en
                                      ? 'Small'
                                      : 'Küçük',
                                  icon: Icons.text_decrease_rounded,
                                  isSelected:
                                      (currentScale - 0.85).abs() < 0.01,
                                  isDark: isDark,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    ref
                                        .read(fontSizeScaleProvider.notifier)
                                        .state = 0.85;
                                    StorageService.saveFontSizeScale(0.85);
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ThemeOption(
                                  label: language == AppLanguage.en
                                      ? 'Normal'
                                      : 'Normal',
                                  icon: Icons.text_fields_rounded,
                                  isSelected:
                                      (currentScale - 1.0).abs() < 0.01,
                                  isDark: isDark,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    ref
                                        .read(fontSizeScaleProvider.notifier)
                                        .state = 1.0;
                                    StorageService.saveFontSizeScale(1.0);
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ThemeOption(
                                  label: language == AppLanguage.en
                                      ? 'Large'
                                      : 'Büyük',
                                  icon: Icons.text_increase_rounded,
                                  isSelected:
                                      (currentScale - 1.15).abs() < 0.01,
                                  isDark: isDark,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    ref
                                        .read(fontSizeScaleProvider.notifier)
                                        .state = 1.15;
                                    StorageService.saveFontSizeScale(1.15);
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 35),

                      // ═══ LANGUAGE SECTION ═══
                      _SectionHeader(
                        title: L10nService.get('settings.language_title', language)
                            .toUpperCase(),
                        isDark: isDark,
                      ),
                      _GroupedContainer(
                        isDark: isDark,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: AppLanguage.values
                                .where((lang) => lang.hasStrictIsolation)
                                .map((lang) {
                                  final isSelected = lang == language;
                                  return Semantics(
                                    label: lang.displayName,
                                    button: true,
                                    selected: isSelected,
                                    child: GestureDetector(
                                      onTap: () async {
                                        HapticFeedback.selectionClick();
                                        // Load translations for the new language before switching
                                        await L10nService.init(lang);
                                        AppLanguage.setCurrent(lang);
                                        ref
                                                .read(languageProvider.notifier)
                                                .state =
                                            lang;
                                        StorageService.saveLanguage(lang);
                                        ref.read(analyticsServiceProvider).logEvent('language_changed', {'language': lang == AppLanguage.en ? 'en' : 'tr'});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.auroraStart
                                                    .withValues(alpha: 0.2)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.auroraStart
                                                : Colors.transparent,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              lang.flag,
                                              style: AppTypography.subtitle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              lang.displayName,
                                              style: isSelected
                                                  ? AppTypography.modernAccent(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.auroraStart,
                                                    )
                                                  : AppTypography.subtitle(
                                                      fontSize: 15,
                                                      color: isDark
                                                          ? AppColors
                                                                .textPrimary
                                                          : AppColors
                                                                .lightTextPrimary,
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
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),

                      // ═══ ACCOUNT SECTION ═══
                      _SectionHeader(
                        title: L10nService.get(
                          'settings.account',
                          language,
                        ).toUpperCase(),
                        isDark: isDark,
                      ),
                      _GroupedContainer(
                        isDark: isDark,
                        noPadding: true,
                        child: Column(
                          children: [
                            _GroupedTile(
                              icon: Icons.account_circle_outlined,
                              title: L10nService.get(
                                'settings.edit_profile',
                                language,
                              ),
                              isDark: isDark,
                              onTap: () => context.push(Routes.profile),
                            ),
                            if (AuthService.isSupabaseInitialized &&
                                AuthService.currentUser != null) ...[
                              _GroupedSeparator(isDark: isDark),
                              _SyncStatusTile(
                                isDark: isDark,
                                isEn: language == AppLanguage.en,
                              ),
                            ],
                            _GroupedSeparator(isDark: isDark),
                            Container(
                              decoration: !isPremium
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.starGold.withValues(
                                            alpha: isDark ? 0.06 : 0.04,
                                          ),
                                          AppColors.celestialGold.withValues(
                                            alpha: isDark ? 0.03 : 0.02,
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,
                              child: _GroupedTile(
                                icon: Icons.workspace_premium_outlined,
                                title: L10nService.get(
                                  'settings.premium',
                                  language,
                                ),
                                isDark: isDark,
                                onTap: () => isPremium
                                    ? context.push(Routes.premium)
                                    : showContextualPaywall(
                                        context,
                                        ref,
                                        paywallContext: PaywallContext.general,
                                        bypassTimingGate: true,
                                      ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: isPremium
                                        ? LinearGradient(
                                            colors: [
                                              AppColors.success,
                                              AppColors.success.withValues(
                                                alpha: 0.8,
                                              ),
                                            ],
                                          )
                                        : LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              AppColors.starGold,
                                              AppColors.celestialGold,
                                            ],
                                          ),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: !isPremium
                                        ? [
                                            BoxShadow(
                                              color: AppColors.starGold
                                                  .withValues(alpha: 0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    'PRO',
                                    style: AppTypography.modernAccent(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: isPremium
                                          ? Colors.white
                                          : AppColors.deepSpace,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (isPremium) ...[
                              _GroupedSeparator(isDark: isDark),
                              _GroupedTile(
                                icon: Icons.credit_card_outlined,
                                title: L10nService.get(
                                  'settings.manage_subscription',
                                  language,
                                ),
                                isDark: isDark,
                                onTap: () async {
                                  await ref
                                      .read(paywallServiceProvider)
                                      .presentCustomerCenter();
                                },
                              ),
                            ],
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.restore,
                              title: language == AppLanguage.en
                                  ? 'Restore Purchases'
                                  : 'Satın Alımları Geri Yükle',
                              isDark: isDark,
                              onTap: () async {
                                final restored = await ref
                                    .read(premiumProvider.notifier)
                                    .restorePurchases();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        restored
                                            ? L10nService.get('settings.purchases_restored', language)
                                            : L10nService.get('settings.no_purchases_found', language),
                                      ),
                                      backgroundColor: restored
                                          ? AppColors.success
                                          : AppColors.surfaceLight,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.delete_outline,
                              title: L10nService.get(
                                'settings.clear_data',
                                language,
                              ),
                              isDark: isDark,
                              isDestructive: true,
                              onTap: () =>
                                  _showClearDataDialog(context, ref, language),
                            ),
                            if (AuthService.isSupabaseInitialized &&
                                AuthService.currentUser != null) ...[
                              _GroupedSeparator(isDark: isDark),
                              _GroupedTile(
                                icon: Icons.logout_rounded,
                                title: language == AppLanguage.en
                                    ? 'Sign Out'
                                    : 'Çıkış Yap',
                                isDark: isDark,
                                isDestructive: true,
                                onTap: () =>
                                    _showSignOutDialog(context, ref, language),
                              ),
                              _GroupedSeparator(isDark: isDark),
                              _GroupedTile(
                                icon: Icons.person_remove_outlined,
                                title: language == AppLanguage.en
                                    ? 'Delete Account'
                                    : 'Hesabı Sil',
                                isDark: isDark,
                                isDestructive: true,
                                onTap: () =>
                                    _showDeleteAccountDialog(context, ref, language),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),

                      // Share & Earn section removed (killed feature)

                      // ═══ FEATURES SECTION ═══
                      _SectionHeader(
                        title:
                            (language == AppLanguage.en
                                    ? 'Features'
                                    : 'Özellikler')
                                .toUpperCase(),
                        isDark: isDark,
                      ),
                      _GroupedContainer(
                        isDark: isDark,
                        noPadding: true,
                        child: Column(
                          children: [
                            _GroupedTile(
                              icon: Icons.air_outlined,
                              title: language == AppLanguage.en
                                  ? 'Guided Breathwork'
                                  : 'Rehberli Nefes',
                              isDark: isDark,
                              onTap: () => context.push(Routes.breathing),
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.self_improvement_outlined,
                              title: language == AppLanguage.en
                                  ? 'Meditation Timer'
                                  : 'Meditasyon Zamanlayıcı',
                              isDark: isDark,
                              onTap: () => context.push(Routes.meditation),
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.file_download_outlined,
                              title: language == AppLanguage.en
                                  ? 'Export Data'
                                  : 'Verileri Dışa Aktar',
                              isDark: isDark,
                              onTap: () => context.push(Routes.exportData),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),

                      // ═══ NOTIFICATIONS SECTION ═══
                      _SectionHeader(
                        title: L10nService.get(
                          'settings.notifications_title',
                          language,
                        ).toUpperCase(),
                        isDark: isDark,
                      ),
                      const NotificationSettingsSection(),
                      const SizedBox(height: 35),

                      // ═══ PRIVACY & SECURITY SECTION ═══
                      _SectionHeader(
                        title:
                            (language == AppLanguage.en
                                    ? 'Privacy & Security'
                                    : 'Gizlilik ve Güvenlik')
                                .toUpperCase(),
                        isDark: isDark,
                      ),
                      _AppLockSection(isDark: isDark, language: language),
                      const SizedBox(height: 35),

                      // ═══ ABOUT SECTION ═══
                      _SectionHeader(
                        title: L10nService.get(
                          'settings.about',
                          language,
                        ).toUpperCase(),
                        isDark: isDark,
                      ),
                      _GroupedContainer(
                        isDark: isDark,
                        noPadding: true,
                        child: Column(
                          children: [
                            _GroupedTile(
                              icon: Icons.people_outline_rounded,
                              title: language == AppLanguage.en
                                  ? 'Tell a Friend'
                                  : 'Arkadaşına Öner',
                              isDark: isDark,
                              onTap: () {
                                final message = language == AppLanguage.en
                                    ? 'I\'ve been journaling with InnerCycles and discovering my personal patterns. Try it out!\n\n${AppConstants.appStoreUrl}'
                                    : 'InnerCycles ile günlük tutuyorum ve kişisel örüntülerimi keşfediyorum. Sen de dene!\n\n${AppConstants.appStoreUrl}';
                                SharePlus.instance.share(
                                  ShareParams(text: message),
                                );
                              },
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.star_outline,
                              title: L10nService.get(
                                'settings.rate_app',
                                language,
                              ),
                              isDark: isDark,
                              onTap: () async {
                                await urlLauncher.requestAppReview();
                              },
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.gavel_outlined,
                              title: L10nService.get(
                                'settings.disclaimer',
                                language,
                              ),
                              isDark: isDark,
                              onTap: () => _showDisclaimerDialog(
                                context,
                                language,
                                isDark,
                              ),
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.privacy_tip_outlined,
                              title: L10nService.get(
                                'settings.privacy_policy',
                                language,
                              ),
                              isDark: isDark,
                              onTap: () async {
                                await urlLauncher.openPrivacyPolicy();
                              },
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.description_outlined,
                              title: L10nService.get(
                                'settings.terms_of_service',
                                language,
                              ),
                              isDark: isDark,
                              onTap: () async {
                                await urlLauncher.openTermsOfService();
                              },
                            ),
                            _GroupedSeparator(isDark: isDark),
                            _GroupedTile(
                              icon: Icons.mail_outline,
                              title: L10nService.get(
                                'settings.contact_support',
                                language,
                              ),
                              isDark: isDark,
                              onTap: () async {
                                await urlLauncher.openSupportEmail(
                                  subject: language == AppLanguage.en
                                      ? 'Support Request'
                                      : 'Destek Talebi',
                                  body: language == AppLanguage.en
                                      ? '\n\n---\nApp Version: 1.0.0'
                                      : '\n\n---\nUygulama Sürümü: 1.0.0',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          L10nService.get('settings.version', language),
                          style: AppTypography.elegantAccent(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.textMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),

                      // ═══ ADMIN SECTION (debug only) ═══
                      if (kDebugMode) ...[
                        _GroupedContainer(
                          isDark: isDark,
                          noPadding: true,
                          child: _GroupedTile(
                            icon: Icons.admin_panel_settings,
                            title: L10nService.get('settings.admin', language),
                            isDark: isDark,
                            onTap: () => context.push(Routes.adminLogin),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.starGold,
                                    AppColors.celestialGold,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                L10nService.get('settings.pin', language),
                                style: AppTypography.modernAccent(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.deepSpace,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                    ]),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.02, duration: 400.ms),
          ),
        ),
      ),
    );
  }

  Future<void> _showClearDataDialog(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
  ) async {
    final confirmed = await GlassDialog.confirm(
      context,
      title: L10nService.get('settings.clear_data_confirm', language),
      message: L10nService.get('settings.clear_data_warning', language),
      cancelLabel: L10nService.get('common.cancel', language),
      confirmLabel: L10nService.get('settings.delete', language),
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    // Cancel scheduled notifications
    try {
      await NotificationService().cancelAll();
    } catch (e) {
      if (kDebugMode) debugPrint('Cancel notifications failed: $e');
    }
    await StorageService.clearAllData();
    if (!context.mounted) return;
    ref.read(userProfileProvider.notifier).clearProfile();
    ref.read(onboardingCompleteProvider.notifier).state = false;
    if (context.mounted) {
      context.go(Routes.onboarding);
    }
  }

  Future<void> _showSignOutDialog(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
  ) async {
    final confirmed = await GlassDialog.confirm(
      context,
      title: L10nService.get('settings.sign_out_title', language),
      message: L10nService.get('settings.sign_out_message', language),
      cancelLabel: L10nService.get('common.cancel', language),
      confirmLabel: L10nService.get('settings.sign_out_confirm', language),
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    try {
      // Clear sync queue before sign-out to prevent cross-user contamination
      await SyncService.clearQueue();
      await StorageService.clearAllData();
      // Log out of RevenueCat before Supabase sign-out
      await ref.read(premiumProvider.notifier).logoutUser();
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      if (kDebugMode) debugPrint('Sign out error: $e');
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            L10nService.get('settings.sign_out_success', language),
          ),
          backgroundColor: AppColors.surfaceLight,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _showDeleteAccountDialog(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
  ) async {
    final confirmed = await GlassDialog.confirm(
      context,
      title: L10nService.get('settings.settings.delete_account', language),
      message: L10nService.get('settings.settings.this_will_permanently_delete_your_accoun', language),
      cancelLabel: L10nService.get('settings.settings.cancel', language),
      confirmLabel: L10nService.get('settings.settings.delete_account_1', language),
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    // Second confirmation
    final doubleConfirmed = await GlassDialog.confirm(
      context,
      title: L10nService.get('settings.settings.delete_your_account', language),
      message: L10nService.get('settings.settings.all_your_cloud_data_will_be_permanently', language),
      cancelLabel: L10nService.get('settings.settings.keep_account', language),
      confirmLabel: L10nService.get('settings.settings.yes_delete', language),
      isDestructive: true,
    );
    if (doubleConfirmed != true || !context.mounted) return;

    try {
      // Guard: require active session before attempting delete
      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                L10nService.get('settings.no_active_session', language),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
        return;
      }

      // Guard: require network connectivity for server-side deletion
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                L10nService.get('settings.settings.no_internet_connection_please_try_again', language),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
        return;
      }

      // Call edge function to delete all user data + auth account
      final response = await Supabase.instance.client.functions.invoke(
        'delete-user-data',
        headers: {
          'Authorization': 'Bearer ${session.accessToken}',
        },
      );

      if (response.status == 200) {
        // Clear sync queue + local data + vault photos
        await SyncService.clearQueue();
        await StorageService.clearAllData();
        await Supabase.instance.client.auth.signOut();
        try {
          final appDir = await getApplicationDocumentsDirectory();
          final vaultDir = Directory('${appDir.path}/vault_photos');
          if (await vaultDir.exists()) {
            await vaultDir.delete(recursive: true);
            // Verify deletion
            if (await vaultDir.exists()) {
              if (kDebugMode) debugPrint('Warning: vault_photos dir still exists after deletion');
            }
          }
        } catch (e) { if (kDebugMode) debugPrint('Vault dir cleanup: $e'); }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                L10nService.get('settings.account_deleted', language),
              ),
              backgroundColor: AppColors.surfaceLight,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      } else {
        // Edge function failed — do NOT sign out, let user retry
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                L10nService.get('settings.settings.account_deletion_requested_you_have_been', language),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Delete account error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              L10nService.get('settings.settings.something_went_wrong_please_contact_supp', language),
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _showDisclaimerDialog(
    BuildContext context,
    AppLanguage language,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (_) => GlassDialog(
        title: L10nService.get('settings.disclaimer', language),
        gradientVariant: GradientTextVariant.gold,
        contentWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                L10nService.get('settings.disclaimer_content', language),
                style: AppTypography.decorativeScript(
                  color: isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary,
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
                        L10nService.get('settings.disclaimer_tip', language),
                        style: AppTypography.decorativeScript(
                          fontSize: 12,
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
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              L10nService.get('settings.got_it', language),
              style: AppTypography.modernAccent(
                color: AppColors.starGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// iOS GROUPED LIST COMPONENTS
// ══════════════════════════════════════════════════════════════════════════════

/// Section header with decorative accent line
class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionHeader({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [AppColors.starGold, AppColors.celestialGold]
                    : [AppColors.lightStarGold, AppColors.celestialGold],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTypography.elegantAccent(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// iOS-style .insetGrouped container (10pt radius, proper background)
class _GroupedContainer extends StatelessWidget {
  final bool isDark;
  final Widget child;
  final bool noPadding;

  const _GroupedContainer({
    required this.isDark,
    required this.child,
    this.noPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      elevation: GlassElevation.g2,
      borderRadius: BorderRadius.circular(10),
      padding: noPadding ? EdgeInsets.zero : const EdgeInsets.all(16),
      child: child,
    );
  }
}

/// iOS-style 0.33pt separator with leading inset
class _GroupedSeparator extends StatelessWidget {
  final bool isDark;

  const _GroupedSeparator({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 60),
      height: 0.33,
      color: isDark
          ? Colors.white.withValues(alpha: 0.15)
          : Colors.black.withValues(alpha: 0.1),
    );
  }
}

/// Sync status indicator tile for Settings → Account section
class _SyncStatusTile extends ConsumerWidget {
  final bool isDark;
  final bool isEn;

  const _SyncStatusTile({required this.isDark, required this.isEn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = AppLanguage.fromIsEn(isEn);
    final syncAsync = ref.watch(syncStatusProvider);
    final pendingCount = ref.watch(pendingSyncCountProvider);

    final status = syncAsync.when(
      data: (s) => s,
      loading: () => SyncStatus.idle,
      error: (_, _) => SyncStatus.error,
    );

    final IconData icon;
    final String label;
    final Color color;
    switch (status) {
      case SyncStatus.syncing:
        icon = Icons.sync;
        label = L10nService.get('settings.settings.syncing', language);
        color = AppColors.auroraStart;
      case SyncStatus.synced:
        icon = Icons.cloud_done_outlined;
        label = L10nService.get('settings.settings.synced', language);
        color = AppColors.success;
      case SyncStatus.error:
        icon = Icons.cloud_off_outlined;
        label = L10nService.get('settings.settings.sync_error', language);
        color = AppColors.error;
      case SyncStatus.offline:
        icon = Icons.cloud_off_outlined;
        label = L10nService.get('settings.settings.offline', language);
        color = isDark ? AppColors.textMuted : AppColors.lightTextMuted;
      case SyncStatus.idle:
        icon = Icons.cloud_outlined;
        label = L10nService.get('settings.settings.ready', language);
        color = isDark ? AppColors.textMuted : AppColors.lightTextMuted;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: AppTypography.subtitle(fontSize: 17, color: color),
            ),
          ),
          if (pendingCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$pendingCount',
                style: AppTypography.modernAccent(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// iOS-style grouped list row (44pt minimum height, disclosure chevron)
class _GroupedTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;
  final bool isDestructive;
  final Widget? trailing;
  final VoidCallback onTap;

  const _GroupedTile({
    required this.icon,
    required this.title,
    required this.isDark,
    this.isDestructive = false,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDestructive
        ? AppColors.error
        : (isDark ? AppColors.textPrimary : AppColors.lightTextPrimary);
    final iconColor = isDestructive
        ? AppColors.error
        : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary);

    return Semantics(
      label: title,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.subtitle(
                      fontSize: 17,
                      color: textColor,
                    ),
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  trailing!,
                  const SizedBox(width: 4),
                ],
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: isDark
                      ? AppColors.textMuted.withValues(alpha: 0.5)
                      : AppColors.lightTextMuted.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Theme selection option within grouped container
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
    return Semantics(
      label: label,
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            AppColors.auroraStart.withValues(alpha: 0.15),
                            AppColors.auroraEnd.withValues(alpha: 0.08),
                          ]
                        : [
                            AppColors.auroraStart.withValues(alpha: 0.08),
                            AppColors.auroraEnd.withValues(alpha: 0.04),
                          ],
                  )
                : null,
            color: isSelected
                ? null
                : (isDark
                      ? AppColors.surfaceLight.withValues(alpha: 0.15)
                      : AppColors.lightSurfaceVariant),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.starGold.withValues(alpha: 0.5)
                  : (isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.04)),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.starGold.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
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
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTypography.elegantAccent(
                  fontSize: 13,
                  color: isSelected
                      ? (isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary)
                      : (isDark
                            ? AppColors.textMuted
                            : AppColors.lightTextMuted),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _ReferralCard removed (feature killed — Tell a Friend in About section instead)

/// App Lock toggle section
class _AppLockSection extends ConsumerStatefulWidget {
  final bool isDark;
  final AppLanguage language;

  const _AppLockSection({required this.isDark, required this.language});

  @override
  ConsumerState<_AppLockSection> createState() => _AppLockSectionState();
}

class _AppLockSectionState extends ConsumerState<_AppLockSection> {
  @override
  Widget build(BuildContext context) {
    final lockAsync = ref.watch(appLockServiceProvider);
    final language = widget.language;
    final isEn = language == AppLanguage.en;

    return lockAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (service) {
        final language = AppLanguage.fromIsEn(isEn);
        final isEnabled = service.isEnabled;

        return _GroupedContainer(
          isDark: widget.isDark,
          noPadding: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: widget.isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                      size: 22,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            L10nService.get('settings.settings.app_lock', language),
                            style: AppTypography.subtitle(
                              fontSize: 17,
                              color: widget.isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            L10nService.get('settings.settings.require_pin_or_biometrics_to_open', language),
                            style: AppTypography.elegantAccent(
                              fontSize: 13,
                              color: widget.isDark
                                  ? AppColors.textMuted
                                  : AppColors.lightTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Semantics(
                      label: isEnabled
                          ? L10nService.get('settings.app_lock_enabled', language)
                          : L10nService.get('settings.app_lock_disabled', language),
                      toggled: isEnabled,
                      child: CupertinoSwitch(
                        value: isEnabled,
                        activeTrackColor: AppColors.auroraStart,
                        onChanged: (value) async {
                          HapticService.toggleChanged();
                          if (value) {
                            _showPinSetup(service);
                          } else {
                            await service.setEnabled(false);
                            await service.removePin();
                            if (!mounted) return;
                            ref.invalidate(appLockServiceProvider);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (isEnabled) ...[
                _GroupedSeparator(isDark: widget.isDark),
                Semantics(
                  label: L10nService.get('settings.settings.change_pin', language),
                  button: true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showPinSetup(service),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.pin_outlined,
                            color: widget.isDark
                                ? AppColors.textSecondary
                                : AppColors.lightTextSecondary,
                            size: 22,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              L10nService.get('settings.settings.change_pin_1', language),
                              style: AppTypography.subtitle(
                                fontSize: 17,
                                color: widget.isDark
                                    ? AppColors.textPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: widget.isDark
                                ? AppColors.textMuted.withValues(alpha: 0.5)
                                : AppColors.lightTextMuted.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showPinSetup(AppLockService service) {
    final language = widget.language;
    final controller = TextEditingController();
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => GlassDialog(
        title: L10nService.get('settings.settings.set_4digit_pin', language),
        gradientVariant: GradientTextVariant.gold,
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              style: AppTypography.subtitle(
                color: widget.isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
              decoration: InputDecoration(
                labelText: L10nService.get('settings.settings.4digit_pin', language),
                labelStyle: AppTypography.subtitle(
                  color: widget.isDark
                      ? AppColors.textMuted
                      : AppColors.lightTextMuted,
                ),
              ),
            ),
            TextField(
              controller: confirmController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              style: AppTypography.subtitle(
                color: widget.isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
              ),
              decoration: InputDecoration(
                labelText: L10nService.get('settings.settings.reenter_pin', language),
                labelStyle: AppTypography.subtitle(
                  color: widget.isDark
                      ? AppColors.textMuted
                      : AppColors.lightTextMuted,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              L10nService.get('settings.settings.cancel_1', language),
              style: AppTypography.subtitle(
                color: widget.isDark
                    ? AppColors.textMuted
                    : AppColors.lightTextMuted,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final pin = controller.text;
              final confirm = confirmController.text;

              if (pin.length != 4) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      L10nService.get('settings.settings.pin_must_be_4_digits', language),
                    ),
                    backgroundColor: AppColors.warning,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
                return;
              }

              if (pin != confirm) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      L10nService.get('settings.settings.pins_do_not_match', language),
                    ),
                    backgroundColor: AppColors.warning,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
                return;
              }

              await service.setPin(pin);
              await service.setEnabled(true);
              if (!mounted) return;
              ref.invalidate(appLockServiceProvider);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(
              L10nService.get('settings.settings.save_changes', widget.language),
              style: AppTypography.modernAccent(
                color: AppColors.starGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ).then((_) {
      controller.dispose();
      confirmController.dispose();
    });
  }
}
