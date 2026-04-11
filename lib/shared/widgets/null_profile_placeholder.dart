import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../data/providers/app_providers.dart';
import '../../data/services/localization_service.dart';
import 'cosmic_background.dart';

/// Reusable placeholder widget shown when user profile is null.
/// Displays a friendly message and CTA button to create profile.
/// Uses L10n for multi-language support.
class NullProfilePlaceholder extends ConsumerWidget {
  final String emoji;
  final String titleKey;
  final String messageKey;

  const NullProfilePlaceholder({
    super.key,
    required this.emoji,
    required this.titleKey,
    required this.messageKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    return Scaffold(
      body: CosmicBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 64),
                ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                const SizedBox(height: 16),
                Text(
                  L10n.get(titleKey, language),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 8),
                Text(
                  L10n.get(messageKey, language),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => context.go('/onboarding'),
                  icon: const Icon(Icons.person_add_rounded),
                  label: Text(L10n.get('create_profile', language)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.venusPink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
