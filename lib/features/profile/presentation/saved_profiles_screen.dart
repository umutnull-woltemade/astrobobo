import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../shared/widgets/cosmic_background.dart';
import 'add_profile_sheet.dart';

class SavedProfilesScreen extends ConsumerWidget {
  const SavedProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(savedProfilesProvider);
    final primaryId = ref.watch(primaryProfileProvider)?.id;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isDark),
              Expanded(
                child: profiles.isEmpty
                    ? _buildEmptyState(context, isDark)
                    : _buildProfilesList(
                        context,
                        ref,
                        profiles,
                        primaryId,
                        isDark,
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddProfileSheet(context, ref),
        backgroundColor: AppColors.auroraStart,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('Profil Ekle', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: isDark
                  ? AppColors.textPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kayıtlı Profiller',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.starGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Karşılaştırma için profil ekle',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push('/comparison'),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.withAlpha(40),
                    Colors.purple.withAlpha(30),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.compare_arrows,
                color: Colors.pink,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.auroraStart.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 64,
              color: AppColors.auroraStart.withAlpha(150),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            'Henüz profil eklenmedi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDark
                  ? AppColors.textPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Partner, arkadas veya aile ekleyerek\nburç uyumunuzu keşfedin',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildProfilesList(
    BuildContext context,
    WidgetRef ref,
    List<UserProfile> profiles,
    String? primaryId,
    bool isDark,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        final isPrimary = profile.id == primaryId;

        return _ProfileCard(
              profile: profile,
              isPrimary: isPrimary,
              isDark: isDark,
              onTap: () =>
                  _showProfileOptions(context, ref, profile, isPrimary),
              onCompare: () => _startComparison(context, ref, profile),
            )
            .animate()
            .fadeIn(delay: (index * 100).ms, duration: 400.ms)
            .slideX(begin: 0.1);
      },
    );
  }

  void _showAddProfileSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddProfileSheet(
        onSave: (profile) async {
          await ref.read(savedProfilesProvider.notifier).addProfile(profile);
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _showProfileOptions(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
    bool isPrimary,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        profile.sunSign.color.withAlpha(100),
                        profile.sunSign.color.withAlpha(30),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      profile.avatarEmoji ?? profile.sunSign.symbol,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name ?? 'İsimsiz',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${profile.sunSign.nameTr} ${profile.relationshipLabel}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: profile.sunSign.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingLg),
            if (!isPrimary)
              ListTile(
                leading: const Icon(
                  Icons.star_outline,
                  color: AppColors.starGold,
                ),
                title: Text(
                  'Ana Profil Yap',
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                onTap: () {
                  ref
                      .read(savedProfilesProvider.notifier)
                      .setPrimary(profile.id);
                  Navigator.pop(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.compare_arrows, color: Colors.pink),
              title: Text(
                'Karşılaştır',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _startComparison(context, ref, profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text(
                'Profili Sil',
                style: TextStyle(color: AppColors.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref, profile);
              },
            ),
            const SizedBox(height: AppConstants.spacingMd),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
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
          'Profili Sil',
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ),
        content: Text(
          '${profile.name ?? "Bu profil"} silinecek. Emin misiniz?',
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
              'İptal',
              style: TextStyle(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(savedProfilesProvider.notifier)
                  .removeProfile(profile.id);
              Navigator.pop(context);
            },
            child: const Text('Sil', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _startComparison(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
  ) {
    ref.read(comparisonProfile2Provider.notifier).state = profile;
    context.push('/comparison');
  }
}

class _ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final bool isPrimary;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onCompare;

  const _ProfileCard({
    required this.profile,
    required this.isPrimary,
    required this.isDark,
    required this.onTap,
    required this.onCompare,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceLight.withAlpha(20)
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: isPrimary
                ? AppColors.starGold.withAlpha(100)
                : (isDark ? Colors.white12 : Colors.black12),
            width: isPrimary ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        profile.sunSign.color.withAlpha(100),
                        profile.sunSign.color.withAlpha(30),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      profile.avatarEmoji ?? profile.sunSign.symbol,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                if (isPrimary)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.starGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        profile.name ?? 'İsimsiz',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: isDark
                                  ? AppColors.textPrimary
                                  : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (profile.relationship != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getRelationshipColor(
                              profile.relationship!,
                            ).withAlpha(30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            profile.relationshipLabel,
                            style: TextStyle(
                              fontSize: 10,
                              color: _getRelationshipColor(
                                profile.relationship!,
                              ),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        profile.sunSign.symbol,
                        style: TextStyle(color: profile.sunSign.color),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.sunSign.nameTr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: profile.sunSign.color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${profile.age} yas',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.textMuted
                              : AppColors.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onCompare,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite, color: Colors.pink, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRelationshipColor(String relationship) {
    switch (relationship) {
      case 'partner':
        return Colors.pink;
      case 'friend':
        return Colors.blue;
      case 'family':
        return Colors.orange;
      case 'colleague':
        return Colors.teal;
      default:
        return Colors.purple;
    }
  }
}
