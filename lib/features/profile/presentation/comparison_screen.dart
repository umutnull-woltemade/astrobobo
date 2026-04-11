import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/models/zodiac_sign.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/services/comparison_service.dart';

class ComparisonScreen extends ConsumerStatefulWidget {
  const ComparisonScreen({super.key});

  @override
  ConsumerState<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends ConsumerState<ComparisonScreen> {
  List<UserProfile?> _selectedProfiles = [null, null];
  List<ComparisonResult> _pairResults = [];
  static const int _maxProfiles = 7;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final primary = ref.read(primaryProfileProvider);
      if (primary != null && _selectedProfiles[0] == null) {
        setState(() {
          _selectedProfiles[0] = primary;
        });
      }
    });
  }

  void _calculateResults() {
    _pairResults.clear();
    final validProfiles = _selectedProfiles.whereType<UserProfile>().toList();

    if (validProfiles.length >= 2) {
      // Her ikili kombinasyonu hesapla
      for (int i = 0; i < validProfiles.length; i++) {
        for (int j = i + 1; j < validProfiles.length; j++) {
          _pairResults.add(
            ComparisonService.analyze(validProfiles[i], validProfiles[j]),
          );
        }
      }
    }
  }

  int get _groupAverageScore {
    if (_pairResults.isEmpty) return 0;
    final total = _pairResults.fold<int>(0, (sum, r) => sum + r.overallScore);
    return (total / _pairResults.length).round();
  }

  ComparisonResult? get _bestPair {
    if (_pairResults.isEmpty) return null;
    return _pairResults.reduce(
      (a, b) => a.overallScore > b.overallScore ? a : b,
    );
  }

  ComparisonResult? get _worstPair {
    if (_pairResults.isEmpty) return null;
    return _pairResults.reduce(
      (a, b) => a.overallScore < b.overallScore ? a : b,
    );
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(savedProfilesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final validCount = _selectedProfiles.whereType<UserProfile>().length;
    if (validCount >= 2) {
      _calculateResults();
    }

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1F1A2E)
          : const Color(0xFFFFF0F5),
      body: Stack(
        children: [
          // Kalpli arka plan
          _HeartPatternBackground(isDark: isDark),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(context, isDark),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppConstants.spacingLg),
                    child: Column(
                      children: [
                        _buildMultiProfileSelectors(context, profiles, isDark),
                        if (_pairResults.isNotEmpty) ...[
                          const SizedBox(height: AppConstants.spacingLg),
                          if (_selectedProfiles
                                  .whereType<UserProfile>()
                                  .length >
                              2)
                            _buildGroupScoreSection(context, isDark),
                          if (_selectedProfiles
                                      .whereType<UserProfile>()
                                      .length ==
                                  2 &&
                              _pairResults.isNotEmpty) ...[
                            _buildScoreSection(
                              context,
                              _pairResults.first,
                              isDark,
                            ),
                            const SizedBox(height: AppConstants.spacingLg),
                            _buildCategoryScores(
                              context,
                              _pairResults.first,
                              isDark,
                            ),
                            const SizedBox(height: AppConstants.spacingLg),
                            _buildSummaryCard(
                              context,
                              _pairResults.first,
                              isDark,
                            ),
                            const SizedBox(height: AppConstants.spacingLg),
                            _buildStrengthsCard(
                              context,
                              _pairResults.first,
                              isDark,
                            ),
                            const SizedBox(height: AppConstants.spacingLg),
                            _buildChallengesCard(
                              context,
                              _pairResults.first,
                              isDark,
                            ),
                            const SizedBox(height: AppConstants.spacingLg),
                            _buildAdviceCard(
                              context,
                              _pairResults.first,
                              isDark,
                            ),
                          ],
                          const SizedBox(height: AppConstants.spacingXl),
                        ] else if (validCount < 2)
                          _buildEmptyState(context, isDark),
                      ],
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
                  'Burç Uyumu',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Detaylı karşılaştırma analizi',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.withAlpha(40),
                  Colors.purple.withAlpha(30),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.pink, size: 24),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildMultiProfileSelectors(
    BuildContext context,
    List<UserProfile> profiles,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profil sayısı göstergesi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profiller (${_selectedProfiles.whereType<UserProfile>().length}/$_maxProfiles)',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              ),
            ),
            if (_selectedProfiles.length > 2)
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedProfiles = [
                      _selectedProfiles[0],
                      _selectedProfiles[1],
                    ];
                    _pairResults.clear();
                  });
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Sıfırla'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.pink,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        // Profil kartları - yatay scroll
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._selectedProfiles.asMap().entries.map((entry) {
                final index = entry.key;
                final profile = entry.value;
                final label = index == 0
                    ? 'Sen'
                    : (index == 1 ? 'Partner' : 'Arkadaş ${index - 1}');

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _ProfileSelector(
                    profile: profile,
                    label: label,
                    profiles: profiles,
                    isDark: isDark,
                    showRemove: index > 1,
                    onSelect: (p) {
                      setState(() {
                        _selectedProfiles[index] = p;
                        _pairResults.clear();
                      });
                    },
                    onRemove: index > 1
                        ? () {
                            setState(() {
                              _selectedProfiles.removeAt(index);
                              _pairResults.clear();
                            });
                          }
                        : null,
                  ),
                );
              }),

              // Ekleme butonu
              if (_selectedProfiles.length < _maxProfiles)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedProfiles.add(null);
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 110,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.pink.withAlpha(20)
                          : Colors.pink.withAlpha(15),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMd,
                      ),
                      border: Border.all(
                        color: Colors.pink.withAlpha(60),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.pink.withAlpha(180),
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ekle',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: Colors.pink.withAlpha(180)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildGroupScoreSection(BuildContext context, bool isDark) {
    final avgScore = _groupAverageScore;
    final best = _bestPair;
    final worst = _worstPair;
    final scoreColor = avgScore >= 70
        ? Colors.green
        : avgScore >= 50
        ? Colors.amber
        : Colors.red;

    return Container(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.withAlpha(30),
                Colors.purple.withAlpha(20),
                isDark
                    ? Colors.transparent
                    : AppColors.lightCard.withAlpha(200),
              ],
            ),
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            border: Border.all(color: Colors.pink.withAlpha(50)),
          ),
          child: Column(
            children: [
              // Grup ortalaması
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          scoreColor.withAlpha(120),
                          scoreColor.withAlpha(40),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: scoreColor.withAlpha(80),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$avgScore%',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: scoreColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Grup Uyumu',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textMuted
                                      : AppColors.lightTextMuted,
                                  fontSize: 9,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingLg),

              // En uyumlu ve en az uyumlu ikililer
              Row(
                children: [
                  if (best != null)
                    Expanded(
                      child: _PairHighlightCard(
                        title: 'En Uyumlu',
                        result: best,
                        color: Colors.green,
                        icon: Icons.favorite,
                        isDark: isDark,
                      ),
                    ),
                  if (best != null && worst != null) const SizedBox(width: 12),
                  if (worst != null && _pairResults.length > 1)
                    Expanded(
                      child: _PairHighlightCard(
                        title: 'Dikkat!',
                        result: worst,
                        color: Colors.orange,
                        icon: Icons.warning_amber,
                        isDark: isDark,
                      ),
                    ),
                ],
              ),

              if (_pairResults.length > 2) ...[
                const SizedBox(height: AppConstants.spacingMd),
                // Tüm ikililer listesi
                ExpansionTile(
                  title: Text(
                    'Tüm İkili Uyumları (${_pairResults.length})',
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.pink),
                  ),
                  iconColor: Colors.pink,
                  collapsedIconColor: Colors.pink,
                  children: _pairResults.map((r) {
                    return ListTile(
                      dense: true,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            r.profile1.sunSign.symbol,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Text(' 💕 ', style: TextStyle(fontSize: 10)),
                          Text(
                            r.profile2.sunSign.symbol,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      title: Text(
                        '${r.profile1.name ?? r.profile1.sunSign.nameTr} & ${r.profile2.name ?? r.profile2.sunSign.nameTr}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.textPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (r.overallScore >= 70
                                      ? Colors.green
                                      : r.overallScore >= 50
                                      ? Colors.amber
                                      : Colors.red)
                                  .withAlpha(40),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${r.overallScore}%',
                          style: TextStyle(
                            color: r.overallScore >= 70
                                ? Colors.green
                                : r.overallScore >= 50
                                ? Colors.amber
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 400.ms)
        .scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.pink.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.compare_arrows,
              size: 48,
              color: Colors.pink.withAlpha(150),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            'İki profil seçin',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDark
                  ? AppColors.textPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Karşılaştırma için yukarıdaki\nkutulardan profil seçin',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildScoreSection(
    BuildContext context,
    ComparisonResult result,
    bool isDark,
  ) {
    final scoreColor = result.overallScore >= 70
        ? Colors.green
        : result.overallScore >= 50
        ? Colors.amber
        : Colors.red;

    return Container(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.withAlpha(25),
                Colors.purple.withAlpha(15),
                isDark ? AppColors.surfaceDark : AppColors.lightCard,
              ],
            ),
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            border: Border.all(color: Colors.pink.withAlpha(40)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileAvatar(result.profile1),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              scoreColor.withAlpha(100),
                              scoreColor.withAlpha(30),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: scoreColor.withAlpha(60),
                              blurRadius: 16,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${result.overallScore}%',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: scoreColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                result.emoji,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: scoreColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          result.levelTr,
                          style: TextStyle(
                            color: scoreColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  _buildProfileAvatar(result.profile2),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 400.ms)
        .scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildProfileAvatar(UserProfile profile) {
    return Column(
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
        const SizedBox(height: 4),
        Text(
          profile.name ?? 'İsimsiz',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Text(
          profile.sunSign.nameTr,
          style: TextStyle(fontSize: 10, color: profile.sunSign.color),
        ),
      ],
    );
  }

  Widget _buildCategoryScores(
    BuildContext context,
    ComparisonResult result,
    bool isDark,
  ) {
    return Row(
      children: [
        Expanded(
          child: _ScoreCard(
            label: 'Aşk',
            score: result.loveScore,
            icon: Icons.favorite,
            color: Colors.pink,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ScoreCard(
            label: 'Arkadaş',
            score: result.friendshipScore,
            icon: Icons.people,
            color: Colors.blue,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ScoreCard(
            label: 'İletişim',
            score: result.communicationScore,
            icon: Icons.chat,
            color: Colors.orange,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ScoreCard(
            label: 'Güven',
            score: result.trustScore,
            icon: Icons.shield,
            color: Colors.green,
            isDark: isDark,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }

  Widget _buildSummaryCard(
    BuildContext context,
    ComparisonResult result,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceLight.withAlpha(20)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.purple, size: 20),
              const SizedBox(width: 8),
              Text(
                'Kozmik Uyum',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            result.summaryTr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
  }

  Widget _buildStrengthsCard(
    BuildContext context,
    ComparisonResult result,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: Colors.green.withAlpha(15),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.green.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.thumb_up, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              Text(
                'Güçlü Yanlar',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...result.strengthsTr.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      s,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }

  Widget _buildChallengesCard(
    BuildContext context,
    ComparisonResult result,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        color: Colors.orange.withAlpha(15),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.orange.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Dikkat Edilecekler',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          ...result.challengesTr.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      c,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildAdviceCard(
    BuildContext context,
    ComparisonResult result,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.withAlpha(20), Colors.pink.withAlpha(15)],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: Colors.purple.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: Colors.purple,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Tavsiye',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            result.adviceTr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms, duration: 400.ms);
  }
}

// Kalpli arka plan widget'ı
class _HeartPatternBackground extends StatelessWidget {
  final bool isDark;

  const _HeartPatternBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF2D1B3D),
                  const Color(0xFF1F1A2E),
                  const Color(0xFF2D1B3D),
                ]
              : [
                  const Color(0xFFFFF0F5),
                  const Color(0xFFFFE4EC),
                  const Color(0xFFFFF5F8),
                ],
        ),
      ),
      child: CustomPaint(
        painter: _HeartPatternPainter(isDark: isDark),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _HeartPatternPainter extends CustomPainter {
  final bool isDark;

  _HeartPatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? Colors.pink : Colors.pink.shade200).withAlpha(
        isDark ? 15 : 25,
      )
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Deterministic random for consistency

    // Küçük kalpler çiz
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final heartSize = 8.0 + random.nextDouble() * 16;

      _drawHeart(canvas, Offset(x, y), heartSize, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();

    // Basit kalp şekli
    path.moveTo(center.dx, center.dy + size * 0.3);
    path.cubicTo(
      center.dx - size * 0.5,
      center.dy - size * 0.3,
      center.dx - size * 0.5,
      center.dy - size * 0.7,
      center.dx,
      center.dy - size * 0.3,
    );
    path.cubicTo(
      center.dx + size * 0.5,
      center.dy - size * 0.7,
      center.dx + size * 0.5,
      center.dy - size * 0.3,
      center.dx,
      center.dy + size * 0.3,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// İkili highlight kartı
class _PairHighlightCard extends StatelessWidget {
  final String title;
  final ComparisonResult result;
  final Color color;
  final IconData icon;
  final bool isDark;

  const _PairHighlightCard({
    required this.title,
    required this.result,
    required this.color,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result.profile1.sunSign.symbol,
                style: const TextStyle(fontSize: 18),
              ),
              const Text(' 💕 ', style: TextStyle(fontSize: 12)),
              Text(
                result.profile2.sunSign.symbol,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${result.overallScore}%',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '${result.profile1.name ?? 'İsimsiz'} & ${result.profile2.name ?? 'İsimsiz'}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              fontSize: 9,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ProfileSelector extends StatelessWidget {
  final UserProfile? profile;
  final String label;
  final List<UserProfile> profiles;
  final bool isDark;
  final Function(UserProfile) onSelect;
  final VoidCallback? onRemove;
  final bool showRemove;

  const _ProfileSelector({
    required this.profile,
    required this.label,
    required this.profiles,
    required this.isDark,
    required this.onSelect,
    this.onRemove,
    this.showRemove = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _showProfilePicker(context),
          child: Container(
            width: 80,
            padding: const EdgeInsets.all(AppConstants.spacingSm),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceLight.withAlpha(20)
                  : AppColors.lightCard,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: profile != null
                    ? profile!.sunSign.color.withAlpha(60)
                    : (isDark ? Colors.white12 : Colors.black12),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                    fontSize: 9,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                if (profile != null) ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          profile!.sunSign.color.withAlpha(100),
                          profile!.sunSign.color.withAlpha(30),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        profile!.avatarEmoji ?? profile!.sunSign.symbol,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile!.name ?? 'İsimsiz',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    profile!.sunSign.nameTr,
                    style: TextStyle(
                      fontSize: 9,
                      color: profile!.sunSign.color,
                    ),
                  ),
                ] else ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppColors.surfaceLight.withAlpha(40)
                          : Colors.grey.shade200,
                    ),
                    child: Icon(
                      Icons.person_add,
                      size: 18,
                      color: isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Seç',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        // Silme butonu
        if (showRemove && onRemove != null)
          Positioned(
            top: -4,
            right: -4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(200),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 4),
                  ],
                ),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  void _showProfilePicker(BuildContext context) {
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
            Text(
              'Profil Seç',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            if (profiles.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                child: Text(
                  'Henüz profil eklenmedi',
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
              )
            else
              ...profiles.map(
                (p) => ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          p.sunSign.color.withAlpha(100),
                          p.sunSign.color.withAlpha(30),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        p.avatarEmoji ?? p.sunSign.symbol,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  title: Text(
                    p.name ?? 'İsimsiz',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  subtitle: Text(
                    p.sunSign.nameTr,
                    style: TextStyle(color: p.sunSign.color),
                  ),
                  onTap: () {
                    onSelect(p);
                    Navigator.pop(context);
                  },
                ),
              ),
            const SizedBox(height: AppConstants.spacingMd),
          ],
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String label;
  final int score;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _ScoreCard({
    required this.label,
    required this.score,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            '$score%',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isDark ? AppColors.textMuted : AppColors.lightTextMuted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
