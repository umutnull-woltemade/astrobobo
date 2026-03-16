import 'package:flutter/foundation.dart';
// ════════════════════════════════════════════════════════════════════════════
// TODAY FEED SCREEN - InnerCycles Premium Home (v3 Three-Zone Architecture)
// ════════════════════════════════════════════════════════════════════════════
// Zone 1 ANCHOR:   Header → HeroJournal → MoodStatsStrip
// Zone 2 CORE:     StreakRecovery → DailyPulse → RecentEntries →
//                  Birthdays → LifeEvents → StreakCard
// Zone 3 DISCOVER: PromotionalBannerStack
// ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/liquid_glass/glass_animations.dart';
import '../../../data/providers/app_providers.dart';
import '../../streak/presentation/streak_card.dart';
import '../../streak/presentation/streak_recovery_banner.dart';
import '../../../shared/widgets/cosmic_background.dart';
import 'widgets/home_header.dart';
import 'widgets/hero_journal_card.dart';
import 'widgets/mood_stats_strip.dart';
import 'widgets/daily_pulse_card.dart';
import 'widgets/anomaly_alert_card.dart';
import 'widgets/recent_entries_section.dart';
import 'widgets/today_birthday_banner.dart';
import 'widgets/recent_life_events_section.dart';
import 'widgets/on_this_day_banner.dart';
import 'widgets/promotional_banner_stack.dart';
import 'widgets/weekly_focus_progress.dart';
import 'widgets/social_proof_strip.dart';
import 'widgets/draft_continuation_banner.dart';
import 'widgets/quick_mood_checkin.dart';
import 'widgets/mood_habit_correlation_card.dart';
import 'widgets/weekly_reflection_card.dart';
import 'widgets/focus_area_streak.dart';
import 'widgets/year_progress_ring.dart';
import 'widgets/welcome_banner.dart';
import 'widgets/wellness_score_card.dart';
import 'widgets/gratitude_quick_card.dart';
import 'widgets/active_challenge_card.dart';
import 'widgets/streak_at_risk_banner.dart';
import 'widgets/badge_unlock_banner.dart';
import 'widgets/daily_habits_strip.dart';
import 'widgets/daily_affirmation_card.dart';
import 'widgets/pinned_notes_strip.dart';
import 'widgets/community_pulse_card.dart';
import 'widgets/community_challenge_card.dart';
import 'widgets/blind_spot_discovery_card.dart';
import 'widgets/seasonal_progress_ring.dart';
import 'widgets/guided_program_card.dart';
import 'widgets/referral_invite_card.dart';
import 'widgets/attachment_quiz_banner.dart';
import 'widgets/pattern_loop_card.dart';
import 'widgets/shift_outlook_card.dart';
import 'widgets/weekly_digest_mini_card.dart';
import 'widgets/weekly_momentum_card.dart';
import 'widgets/mindfulness_stats_card.dart';
import 'widgets/pattern_health_alert_card.dart';
import 'widgets/habit_suggestion_card.dart';
import 'widgets/sleep_quality_mini_card.dart';
import 'widgets/life_event_anniversary_card.dart';
import 'widgets/onboarding_checklist_card.dart';
import 'widgets/journaling_tip_card.dart';
import 'widgets/cross_correlation_card.dart';
import 'widgets/mood_temporal_insight_card.dart';
import 'widgets/gratitude_mood_correlation_card.dart';
import 'widgets/time_capsule_delivery_card.dart';
import 'widgets/emotional_fingerprint_card.dart';
import 'widgets/clarity_score_card.dart';
import 'widgets/journal_query_teaser_card.dart';
import 'widgets/intentions_board_card.dart';
import 'widgets/value_of_week_card.dart';
import 'widgets/inner_dialogue_card.dart';
import 'widgets/trigger_awareness_card.dart';
import 'widgets/self_compassion_card.dart';
import 'widgets/morning_pages_card.dart';
import 'widgets/mood_board_card.dart';
import 'widgets/growth_letter_card.dart';
import 'widgets/word_cloud_mini_card.dart';
import 'widgets/reflection_prompt_card.dart';
import 'widgets/time_capsule_write_card.dart';
import 'widgets/life_wheel_checkin_card.dart';
import 'widgets/monthly_theme_card.dart';
import 'widgets/fear_awareness_card.dart';
import 'widgets/premium_expiry_banner.dart';
import 'widgets/sync_status_banner.dart';
import 'widgets/win_back_offer_banner.dart';
import 'widgets/partner_touch_card.dart';
import '../../../data/services/l10n_service.dart';
import '../../../data/providers/bond_providers.dart';
import '../../../data/models/bond.dart';
import '../../bond/presentation/widgets/bond_touch_received_overlay.dart';

class TodayFeedScreen extends ConsumerStatefulWidget {
  const TodayFeedScreen({super.key});

  @override
  ConsumerState<TodayFeedScreen> createState() => _TodayFeedScreenState();
}

class _TodayFeedScreenState extends ConsumerState<TodayFeedScreen> {
  static const _lastOpenKey = 'today_feed_last_open';
  Touch? _incomingTouch;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkWelcomeBack();
      _checkAppAnniversary();
    });
  }

  Future<void> _checkWelcomeBack() async {
    final prefs = await SharedPreferences.getInstance();
    final lastOpen = prefs.getInt(_lastOpenKey);
    await prefs.setInt(_lastOpenKey, DateTime.now().millisecondsSinceEpoch);

    if (lastOpen == null) return; // First ever open — skip
    final daysSince = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastOpen))
        .inDays;
    if (daysSince < 3) return; // Active enough — lowered from 7 to 3

    if (!mounted) return;
    final language = ref.read(languageProvider);
    final isEn = language == AppLanguage.en;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get previous streak for urgency
    int previousStreak = 0;
    try {
      final journalService = await ref.read(journalServiceProvider.future);
      previousStreak = journalService.getCurrentStreak();
    } catch (e) { if (kDebugMode) debugPrint('Streak fetch: $e'); }

    final hasStreak = previousStreak > 1;
    final subtitle = hasStreak
        ? (isEn
            ? 'You had a $previousStreak-day streak! One entry restarts your momentum.'
            : '$previousStreak günlük serin vardı! Bir kayıt ivmeni yeniden başlatır.')
        : (isEn
            ? 'It\'s been $daysSince days. A quick check-in is all it takes to restart.'
            : '$daysSince gündür burada değildin. Kısa bir kayıt yeniden başlamak için yeter.');

    if (!mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: L10nService.get('common.dismiss', language),
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (ctx, anim, _, child) =>
          FadeTransition(opacity: anim, child: child),
      pageBuilder: (ctx, _, _) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.starGold.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  hasStreak
                      ? Icons.local_fire_department_rounded
                      : Icons.wb_sunny_rounded,
                  size: 44,
                  color: AppColors.starGold,
                ),
                const SizedBox(height: 16),
                Text(
                  L10nService.get('today.today_feed.welcome_back', language),
                  style: AppTypography.displayFont.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.textPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.decorativeScript(
                    fontSize: 15,
                    color: isDark
                        ? AppColors.textSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push(Routes.journal);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.starGold, AppColors.celestialGold],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        L10nService.get('today.today_feed.write_an_entry', language),
                        style: AppTypography.modernAccent(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepSpace,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Text(
                    L10nService.get('today.today_feed.maybe_later', language),
                    style: AppTypography.elegantAccent(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.textMuted
                          : AppColors.lightTextMuted,
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

  static const _anniversaryCelebratedKey = 'anniversary_celebrated_';
  static const _anniversaryMilestones = [30, 90, 180, 365];

  Future<void> _checkAppAnniversary() async {
    final prefs = await SharedPreferences.getInstance();
    final installMs = prefs.getInt('ic_intro_offer_install_time');
    if (installMs == null) return;

    final installDate = DateTime.fromMillisecondsSinceEpoch(installMs);
    final daysSinceInstall = DateTime.now().difference(installDate).inDays;

    int? milestone;
    for (final m in _anniversaryMilestones.reversed) {
      if (daysSinceInstall >= m) {
        milestone = m;
        break;
      }
    }
    if (milestone == null) return;

    final key = '$_anniversaryCelebratedKey$milestone';
    if (prefs.getBool(key) == true) return;
    await prefs.setBool(key, true);

    if (!mounted) return;
    final language = ref.read(languageProvider);
    final isEn = language == AppLanguage.en;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final label = milestone >= 365
        ? (L10nService.get('today.today_feed.1_year', language))
        : milestone >= 180
            ? (L10nService.get('today.today_feed.6_months', language))
            : milestone >= 90
                ? (L10nService.get('today.today_feed.3_months', language))
                : (L10nService.get('today.today_feed.1_month', language));

    final emoji = milestone >= 365
        ? '\u{1F389}'
        : milestone >= 90
            ? '\u{1F31F}'
            : '\u{2B50}';

    final message = isEn
        ? 'You\'ve been journaling for $label.\nYour commitment to self-reflection is inspiring.'
        : '$label boyunca g\u00fcnl\u00fck tutuyorsun.\n\u00d6z yans\u0131ma konusundaki kararl\u0131l\u0131\u011f\u0131n ilham verici.';

    if (!mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: L10nService.get('common.dismiss', language),
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (ctx, anim, _, child) =>
          FadeTransition(opacity: anim, child: child),
      pageBuilder: (ctx, _, _) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.starGold.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.starGold.withValues(alpha: 0.12),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 56)),
                const SizedBox(height: 16),
                Text(
                  L10nService.getWithParams('today.anniversary_label', language, params: {'label': label}),
                  style: AppTypography.displayFont.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.starGold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTypography.decorativeScript(
                    fontSize: 15,
                    color: isDark
                        ? AppColors.textSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final text = isEn
                            ? '$emoji $label of journaling with InnerCycles!\n\n'
                              'Building a reflection practice, one day at a time.\n\n'
                              '${AppConstants.appStoreUrl}\n#InnerCycles #Anniversary'
                            : '$emoji InnerCycles ile $label g\u00fcnl\u00fck tutuyorum!\n\n'
                              'Her g\u00fcn bir yans\u0131ma prati\u011fi olu\u015fturuyorum.\n\n'
                              '${AppConstants.appStoreUrl}\n#InnerCycles';
                        SharePlus.instance.share(ShareParams(text: text));
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.starGold.withValues(alpha: 0.15),
                          border: Border.all(
                            color: AppColors.starGold.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.share_rounded,
                          size: 20,
                          color: AppColors.starGold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(ctx),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.starGold,
                                AppColors.celestialGold,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              L10nService.get('today.today_feed.continue', language),
                              style: AppTypography.modernAccent(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepSpace,
                              ),
                            ),
                          ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);
    final isEn = language == AppLanguage.en;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userProfile = ref.watch(userProfileProvider);
    final userName = userProfile?.name ?? '';

    // Listen for incoming touches
    ref.listen<AsyncValue<Touch?>>(incomingTouchProvider, (prev, next) {
      final touch = next.valueOrNull;
      if (touch != null && mounted) {
        setState(() => _incomingTouch = touch);
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          CosmicBackground(
            child: SafeArea(
          child: CupertinoScrollbar(
            child: RefreshIndicator(
              color: AppColors.starGold,
              onRefresh: () async {
                ref.invalidate(journalServiceProvider);
                ref.invalidate(moodCheckinServiceProvider);
                ref.invalidate(streakStatsProvider);
                ref.invalidate(todayBirthdaysProvider);
                await Future.delayed(const Duration(milliseconds: 300));
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  // ═══════════════════════════════════════════════
                  // ZONE 1: ANCHOR
                  // ═══════════════════════════════════════════════

                  // 1. Header (mood-aware greeting + partner orb)
                  SliverToBoxAdapter(
                    child: Consumer(
                      builder: (context, ref, _) {
                        final moodAsync = ref.watch(moodCheckinServiceProvider);
                        final yesterdayMood = moodAsync.whenOrNull(
                          data: (service) {
                            final week = service.getWeekMoods();
                            // index 5 = yesterday (week is last 7 days, 6=today)
                            return week.length >= 7 ? week[5]?.mood : null;
                          },
                        );
                        final bondCount = ref.watch(bondCountProvider).whenOrNull(data: (v) => v) ?? 0;
                        return HomeHeader(
                          userName: userName,
                          language: language,
                          isDark: isDark,
                          yesterdayMoodScore: yesterdayMood,
                          hasBond: bondCount > 0,
                        ).glassEntrance(context: context);
                      },
                    ),
                  ),

                  // 1a2. Quick-access shortcuts row
                  SliverToBoxAdapter(
                    child: _QuickShortcutsRow(isEn: isEn, isDark: isDark),
                  ),

                  // 1b. Welcome Banner (new users only)
                  SliverToBoxAdapter(
                    child: WelcomeBanner(isEn: isEn, isDark: isDark),
                  ),

                  // 1b2. Sync Status Banner (offline/error indicator)
                  SliverToBoxAdapter(
                    child: SyncStatusBanner(isEn: isEn, isDark: isDark),
                  ),

                  // 1c. Onboarding Checklist (first-week guided progress)
                  SliverToBoxAdapter(
                    child: OnboardingChecklistCard(isEn: isEn, isDark: isDark),
                  ),

                  // 2. Hero Journal Card (promoted to #2)
                  SliverToBoxAdapter(
                    child: HeroJournalCard(language: language, isDark: isDark),
                  ),

                  // 2a. Badge Unlock Banner (conditional)
                  SliverToBoxAdapter(
                    child: BadgeUnlockBanner(language: language, isDark: isDark),
                  ),

                  // 2b. Draft Continuation Banner (conditional)
                  SliverToBoxAdapter(
                    child: DraftContinuationBanner(isEn: isEn, isDark: isDark),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 12)),

                  // 3. Mood + Stats Strip
                  SliverToBoxAdapter(
                    child: MoodStatsStrip(
                      language: language,
                      isDark: isDark,
                    ).glassEntrance(context: context, delay: 180.ms),
                  ),

                  // 3b. Quick Mood Check-in (shows only if no mood today)
                  SliverToBoxAdapter(
                    child: QuickMoodCheckin(language: language, isDark: isDark),
                  ),

                  // 3b½. Mood Temporal Insight (best time-of-day)
                  SliverToBoxAdapter(
                    child: MoodTemporalInsightCard(isEn: isEn, isDark: isDark),
                  ),

                  // 3c. Focus Area Streak (2+ consecutive days)
                  SliverToBoxAdapter(
                    child: FocusAreaStreak(isEn: isEn, isDark: isDark),
                  ),

                  // 3d. Gratitude Quick-Add
                  SliverToBoxAdapter(
                    child: GratitudeQuickCard(isEn: isEn, isDark: isDark),
                  ),

                  // 3d½. Gratitude-Mood Correlation
                  SliverToBoxAdapter(
                    child: GratitudeMoodCorrelationCard(isEn: isEn, isDark: isDark),
                  ),

                  // 3e. Daily Habits Strip
                  SliverToBoxAdapter(
                    child: DailyHabitsStrip(language: language, isDark: isDark),
                  ),

                  // 3f. Seasonal Reflection Progress
                  SliverToBoxAdapter(
                    child: SeasonalProgressRing(language: language, isDark: isDark),
                  ),

                  // Zone 1→2 primary divider
                  SliverToBoxAdapter(
                    child: _goldDivider(isDark, primary: true),
                  ),

                  // ═══════════════════════════════════════════════
                  // ZONE 2: CORE
                  // ═══════════════════════════════════════════════

                  // 4. Streak At Risk Banner (proactive freeze visibility)
                  SliverToBoxAdapter(
                    child: StreakAtRiskBanner(isEn: isEn, isDark: isDark),
                  ),

                  // 4b. Premium Expiry Banner (conditional — near expiry)
                  SliverToBoxAdapter(
                    child: PremiumExpiryBanner(isEn: isEn, isDark: isDark),
                  ),

                  // 4c. Win-Back Offer (lapsed free users, 14+ days away)
                  SliverToBoxAdapter(
                    child: WinBackOfferBanner(isEn: isEn, isDark: isDark),
                  ),

                  // 4d. Streak Recovery Banner (conditional — after streak broken)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: StreakRecoveryBanner(),
                    ),
                  ),

                  // 5. Daily Pulse Card
                  SliverToBoxAdapter(
                    child: DailyPulseCard(
                      language: language,
                      isDark: isDark,
                    ).glassReveal(context: context, delay: 280.ms),
                  ),

                  // 5a. Pattern Health Alert (yellow/red severity)
                  SliverToBoxAdapter(
                    child: PatternHealthAlertCard(isEn: isEn, isDark: isDark),
                  ),

                  // 5b. Anomaly Alert (significant deviations from baseline)
                  SliverToBoxAdapter(
                    child: AnomalyAlertCard(
                      language: language,
                      isDark: isDark,
                    ),
                  ),

                  // 5b. Weekly Focus Progress
                  SliverToBoxAdapter(
                    child: WeeklyFocusProgress(
                      language: language,
                      isDark: isDark,
                    ).animate().fadeIn(delay: 320.ms, duration: 400.ms),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Gold divider
                  SliverToBoxAdapter(child: _goldDivider(isDark)),

                  // 6. Recent Entries
                  SliverToBoxAdapter(
                    child: RecentEntriesSection(
                      language: language,
                      isDark: isDark,
                    ).glassEntrance(context: context, delay: 400.ms),
                  ),

                  // 7. Today's Birthdays (conditional)
                  SliverToBoxAdapter(
                    child: TodayBirthdayBanner(language: language, isDark: isDark),
                  ),

                  // 7a. Bond Partner Touch Card (conditional)
                  const SliverToBoxAdapter(
                    child: PartnerTouchCard(),
                  ),

                  // 7b. Life Event Anniversary (1/2/5/10-year milestones)
                  SliverToBoxAdapter(
                    child: LifeEventAnniversaryCard(isEn: isEn, isDark: isDark),
                  ),

                  // 7c. On This Day — Anniversary memories
                  SliverToBoxAdapter(
                    child: OnThisDayBanner(language: language, isDark: isDark),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),

                  // 8. Recent Life Events
                  SliverToBoxAdapter(
                    child: RecentLifeEventsSection(language: language, isDark: isDark),
                  ),

                  // 8b. Wellness Score Card
                  SliverToBoxAdapter(
                    child: WellnessScoreCard(language: language, isDark: isDark),
                  ),

                  // 8c. Active Challenge Card
                  SliverToBoxAdapter(
                    child: ActiveChallengeCard(language: language, isDark: isDark),
                  ),

                  // 8d. Guided Program Quick-Start
                  SliverToBoxAdapter(
                    child: GuidedProgramCard(language: language, isDark: isDark),
                  ),

                  // 8e. Blind Spot Discovery
                  SliverToBoxAdapter(
                    child: BlindSpotDiscoveryCard(language: language, isDark: isDark),
                  ),

                  // 8f. Pattern Loop Card
                  SliverToBoxAdapter(
                    child: PatternLoopCard(language: language, isDark: isDark),
                  ),

                  // 8g. Shift Outlook Card
                  SliverToBoxAdapter(
                    child: ShiftOutlookCard(language: language, isDark: isDark),
                  ),

                  // 8h. Habit Suggestion Card
                  SliverToBoxAdapter(
                    child: HabitSuggestionCard(isEn: isEn, isDark: isDark),
                  ),

                  // 8i. Weekly Community Challenge
                  SliverToBoxAdapter(
                    child: CommunityChallengeCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9. Streak Card
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverToBoxAdapter(
                      child: const StreakCard().glassReveal(
                        context: context,
                        delay: 580.ms,
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),

                  // 9b. Year Progress Ring
                  SliverToBoxAdapter(
                    child: YearProgressRing(isEn: isEn, isDark: isDark),
                  ),

                  // 9c. Weekly Reflection (Fri–Sun only)
                  SliverToBoxAdapter(
                    child: WeeklyReflectionCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9d. Daily Affirmation
                  SliverToBoxAdapter(
                    child: DailyAffirmationCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9d2. Journaling Tip of the Day
                  SliverToBoxAdapter(
                    child: JournalingTipCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9e. Pinned Notes
                  SliverToBoxAdapter(
                    child: PinnedNotesStrip(isEn: isEn, isDark: isDark),
                  ),

                  // 9f. Sleep Quality Mini-Card
                  SliverToBoxAdapter(
                    child: SleepQualityMiniCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9g. Attachment Style Quiz Banner
                  SliverToBoxAdapter(
                    child: AttachmentQuizBanner(isEn: isEn, isDark: isDark),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),

                  // 9g. Mood-Habit Correlation Insight
                  SliverToBoxAdapter(
                    child: MoodHabitCorrelationCard(language: language, isDark: isDark),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),

                  // 9h. Cross-Feature Correlation Insights
                  SliverToBoxAdapter(
                    child: CrossCorrelationCard(language: language, isDark: isDark),
                  ),

                  // 9i. Time Capsule Delivery
                  SliverToBoxAdapter(
                    child: TimeCapsuleDeliveryCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9j. Emotional Fingerprint (first 3 days of month)
                  SliverToBoxAdapter(
                    child: EmotionalFingerprintCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9k. Weekly Clarity Score
                  SliverToBoxAdapter(
                    child: ClarityScoreCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9l. Ask Your Journal Teaser
                  SliverToBoxAdapter(
                    child: JournalQueryTeaserCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9m. Weekly Intentions Board
                  SliverToBoxAdapter(
                    child: IntentionsBoardCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9n. Value of the Week
                  SliverToBoxAdapter(
                    child: ValueOfWeekCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9o. Morning Pages (before noon only)
                  SliverToBoxAdapter(
                    child: MorningPagesCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9p. Inner Dialogue
                  SliverToBoxAdapter(
                    child: InnerDialogueCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9q. Self-Compassion Score
                  SliverToBoxAdapter(
                    child: SelfCompassionCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9r. Trigger Awareness
                  SliverToBoxAdapter(
                    child: TriggerAwarenessCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9s. Mood Board (visual mood collage)
                  SliverToBoxAdapter(
                    child: MoodBoardCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9t. Growth Letter
                  SliverToBoxAdapter(
                    child: GrowthLetterCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9u. Word Cloud Mini
                  SliverToBoxAdapter(
                    child: WordCloudMiniCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9v. Reflection Prompt
                  SliverToBoxAdapter(
                    child: ReflectionPromptCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9w. Time Capsule Write
                  SliverToBoxAdapter(
                    child: TimeCapsuleWriteCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9x. Life Wheel Check-In
                  SliverToBoxAdapter(
                    child: LifeWheelCheckinCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9y. Monthly Theme
                  SliverToBoxAdapter(
                    child: MonthlyThemeCard(isEn: isEn, isDark: isDark),
                  ),

                  // 9z. Fear Awareness
                  SliverToBoxAdapter(
                    child: FearAwarenessCard(isEn: isEn, isDark: isDark),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Gold divider
                  SliverToBoxAdapter(child: _goldDivider(isDark)),

                  // ═══════════════════════════════════════════════
                  // ZONE 3: DISCOVER
                  // ═══════════════════════════════════════════════

                  // 10. Weekly Digest Mini-Card
                  SliverToBoxAdapter(
                    child: WeeklyDigestMiniCard(language: language, isDark: isDark),
                  ),

                  // 10a2. Weekly Momentum Card
                  SliverToBoxAdapter(
                    child: WeeklyMomentumCard(isEn: isEn, isDark: isDark),
                  ),

                  // 10a3. Mindfulness Stats Card
                  SliverToBoxAdapter(
                    child: MindfulnessStatsCard(isEn: isEn, isDark: isDark),
                  ),

                  // 10a. Community Pulse (anonymous social layer)
                  SliverToBoxAdapter(
                    child: CommunityPulseCard(isEn: isEn, isDark: isDark),
                  ),

                  // 10b. Referral Invite Card
                  SliverToBoxAdapter(
                    child: ReferralInviteCard(language: language, isDark: isDark),
                  ),

                  // 11. Promotional Banner Stack
                  SliverToBoxAdapter(
                    child: PromotionalBannerStack(language: language, isDark: isDark),
                  ),

                  // 12. Social Proof Strip
                  SliverToBoxAdapter(
                    child: SocialProofStrip(language: language, isDark: isDark),
                  ),

                  // 12. Bottom padding
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          ),
        ),
      ),
      // Touch received overlay
      if (_incomingTouch != null)
        Positioned.fill(
          child: BondTouchReceivedOverlay(
            touchType: _incomingTouch!.touchType,
            isEn: isEn,
            onDismissed: () => setState(() => _incomingTouch = null),
          ),
        ),
        ],
      ),
    );
  }

  Widget _goldDivider(bool isDark, {bool primary = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      child: Container(
        height: primary ? 0.8 : 0.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              (isDark ? AppColors.starGold : AppColors.lightStarGold)
                  .withValues(alpha: 0.18),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickShortcutsRow extends StatelessWidget {
  final bool isEn;
  final bool isDark;

  const _QuickShortcutsRow({required this.isEn, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final shortcuts = [
      (Icons.edit_note_rounded, isEn ? 'Journal' : 'Günlük', Routes.journal),
      (Icons.nights_stay_rounded, isEn ? 'Dreams' : 'Rüyalar', Routes.dreamInterpretation),
      (Icons.favorite_rounded, isEn ? 'Gratitude' : 'Şükran', Routes.gratitudeJournal),
      (Icons.cake_rounded, isEn ? 'Birthdays' : 'Doğum Günleri', Routes.birthdayAgenda),
      (Icons.check_circle_outline_rounded, isEn ? 'Habits' : 'Alışkanlıklar', Routes.dailyHabits),
      (Icons.self_improvement_rounded, isEn ? 'Breathe' : 'Nefes', Routes.breathing),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: shortcuts.map((s) {
          final (icon, label, route) = s;
          return Semantics(
            button: true,
            label: label,
            child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              context.push(route);
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.04),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isDark
                        ? AppColors.textSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: AppTypography.elegantAccent(
                    fontSize: 10,
                    color: isDark
                        ? AppColors.textMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
              ],
            ),
          ),
          );
        }).toList(),
      ),
    );
  }
}
