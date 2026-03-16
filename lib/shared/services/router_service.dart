import '../../data/providers/app_providers.dart';
import '../../data/services/l10n_service.dart';
// ════════════════════════════════════════════════════════════════════════════
// ROUTER SERVICE - InnerCycles Navigation (Survival Release)
// ════════════════════════════════════════════════════════════════════════════
// 5-Tab: Home | Journal | Signal Dashboard | Notes | Profile
// SECONDARY features soft-archived: code preserved, routes removed.
// ════════════════════════════════════════════════════════════════════════════

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/routes.dart';
import '../../core/navigation/page_transitions.dart';
import '../../core/theme/app_typography.dart';
import '../../data/services/notification_service.dart' show navigatorKey;

// ── CORE screen imports ──
import '../../features/disclaimer/presentation/disclaimer_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/archetype_quiz_screen.dart';
import '../../features/today/presentation/today_feed_screen.dart';
import '../../features/journal/presentation/daily_entry_screen.dart';
import '../../features/journal/presentation/entry_detail_screen.dart';
import '../../features/journal/presentation/patterns_screen.dart';
import '../../features/journal/presentation/archive_screen.dart';
import '../../features/journal/presentation/monthly_reflection_screen.dart';
import '../../features/journal/presentation/emotional_cycle_screen.dart';
import '../../features/mood/presentation/mood_trends_screen.dart';
import '../../features/calendar/presentation/calendar_heatmap_screen.dart';
import '../../features/breathing/presentation/breathing_timer_screen.dart';
import '../../features/meditation/presentation/meditation_timer_screen.dart';
import '../../features/profile/presentation/profile_hub_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/premium/presentation/premium_screen.dart';
import '../../features/settings/presentation/notification_schedule_screen.dart';
import '../../features/export/presentation/export_screen.dart';
import '../../features/streak/presentation/streak_stats_screen.dart';
import '../../features/app_lock/presentation/app_lock_screen.dart';
import '../../features/vault/presentation/vault_pin_screen.dart';
import '../../features/vault/presentation/vault_screen.dart';
import '../../features/notes/presentation/notes_list_screen.dart';
import '../../features/notes/presentation/note_detail_screen.dart';
import '../../features/admin/presentation/admin_login_screen.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/cycle_sync/presentation/cycle_sync_screen.dart';
import '../../features/bond/presentation/bond_hub_screen.dart';
import '../../features/bond/presentation/bond_invite_screen.dart';
import '../../features/bond/presentation/bond_accept_screen.dart';
import '../../features/bond/presentation/bond_detail_screen.dart';
import '../../features/bond/presentation/bond_mood_calendar_screen.dart';
import '../../features/shadow_work/presentation/shadow_work_screen.dart';
import '../../features/prompts/presentation/prompt_library_screen.dart';
import '../../features/milestones/presentation/milestone_screen.dart';
import '../../features/year_review/presentation/year_review_screen.dart';
import '../../features/year_review/presentation/wrapped_screen.dart';
import '../../features/habits/presentation/daily_habits_screen.dart';
import '../../features/referral/presentation/referral_screen.dart';
import '../../features/journal/presentation/annual_report_screen.dart';
import '../../features/retrospective/presentation/retrospective_screen.dart';
import '../../features/digest/presentation/monthly_wrapped_screen.dart';
import '../../features/sharing/presentation/share_card_gallery.dart';
import '../../features/habits/presentation/habit_suggestions_screen.dart';
import '../../features/growth/presentation/growth_dashboard_screen.dart';
import '../../features/growth/presentation/time_capsule_screen.dart';
import '../../features/discovery/presentation/life_wheel_screen.dart';
import '../../features/seasonal/presentation/monthly_theme_screen.dart';
import '../../features/shadow_work/presentation/fear_inventory_screen.dart';
import '../../features/digest/presentation/weekly_digest_screen.dart';
import '../../features/affirmation/presentation/affirmation_library_screen.dart';
import '../../features/archetype/presentation/archetype_screen.dart';
// articles_screen import removed (killed feature)
import '../../features/blind_spot/presentation/blind_spot_screen.dart';
import '../../features/challenges/presentation/challenge_hub_screen.dart';
import '../../features/challenges/presentation/challenge_list_screen.dart';
// compatibility_reflection_screen import removed (killed feature)
import '../../features/dreams/presentation/dream_archive_screen.dart';
import '../../features/dreams/presentation/canonical/dream_theme_screen.dart';
import '../../features/dreams/presentation/dream_glossary_screen.dart';
import '../../features/dreams/presentation/dream_interpretation_screen.dart';
import '../../features/energy/presentation/energy_map_screen.dart';
import '../../features/life_events/presentation/life_event_screen.dart';
import '../../features/life_events/presentation/life_event_detail_screen.dart';
import '../../features/life_events/presentation/life_timeline_screen.dart';
import '../../features/birthdays/presentation/birthday_agenda_screen.dart';
import '../../features/birthdays/presentation/birthday_detail_screen.dart';
import '../../features/birthdays/presentation/birthday_add_screen.dart';
import '../../features/birthdays/presentation/birthday_import_screen.dart';
import '../../features/gratitude/presentation/gratitude_archive_screen.dart';
import '../../features/gratitude/presentation/gratitude_screen.dart';
import '../../features/insight/presentation/insight_screen.dart';
import '../../features/insight/presentation/insights_discovery_screen.dart';
import '../../features/library/presentation/library_hub_screen.dart';
// moon_calendar_screen import removed (killed feature)
import '../../features/mood/presentation/emotional_vocabulary_screen.dart';
import '../../features/programs/presentation/active_program_screen.dart';
import '../../features/programs/presentation/program_completion_screen.dart';
import '../../features/programs/presentation/program_list_screen.dart';
import '../../features/quiz/presentation/attachment_quiz_screen.dart';
import '../../features/quiz/presentation/generic_quiz_screen.dart';
import '../../features/quiz/presentation/quiz_hub_screen.dart';
import '../../features/rituals/presentation/ritual_create_screen.dart';
import '../../features/rituals/presentation/rituals_screen.dart';
import '../../features/search/presentation/global_search_screen.dart';
import '../../features/seasonal/presentation/seasonal_reflection_screen.dart';
import '../../features/sleep/presentation/sleep_detail_screen.dart';
import '../../features/sleep/presentation/sleep_trends_screen.dart';
import '../../features/memories/presentation/memories_screen.dart';
import '../../features/memories/presentation/emotional_timeline_screen.dart';
import '../../features/journal/presentation/sprint_entry_screen.dart';
import '../../features/journal/presentation/journal_query_screen.dart';
import '../../features/growth/presentation/intentions_screen.dart';
import '../../features/growth/presentation/trigger_map_screen.dart';
import '../../features/quiz/presentation/values_compass_screen.dart';
import '../../features/journal/presentation/inner_dialogue_screen.dart';
import '../../features/journal/presentation/morning_pages_screen.dart';
import '../../features/mood/presentation/mood_board_screen.dart';
import '../../features/mood/presentation/mood_compass_screen.dart';
import '../../features/mood/presentation/self_compassion_screen.dart';
import '../../features/mood/presentation/clarity_score_screen.dart';
import '../../features/mood/presentation/emotional_cycles_screen.dart';
import '../../features/growth/presentation/growth_letters_screen.dart';
import '../../features/journal/presentation/word_cloud_screen.dart';
import '../../features/dreams/presentation/dream_correlation_screen.dart';
import '../../features/mood/presentation/shift_outlook_screen.dart';
import '../../features/profile/presentation/emotional_fingerprint_screen.dart';
import '../../features/cycle_sync/presentation/cycle_correlation_screen.dart';
import '../../features/quiz/presentation/attachment_style_result_screen.dart';
import '../../features/rituals/presentation/ritual_stats_screen.dart';
import '../../features/gratitude/presentation/gratitude_insights_screen.dart';
import '../../features/shadow_work/presentation/shadow_work_archive_screen.dart';
import '../../features/journal/presentation/pattern_health_screen.dart';
import '../../features/habits/presentation/habit_adoption_screen.dart';
import '../../features/wellness/presentation/wellness_history_screen.dart';
import '../../features/journal/presentation/pattern_loop_archive_screen.dart';
import '../../features/dreams/presentation/dream_memory_analytics_screen.dart';
import '../../features/journal/presentation/cross_correlation_screen.dart';
import '../../features/journal/presentation/anomaly_detection_screen.dart';
import '../../features/profile/presentation/journey_analytics_screen.dart';
import '../../features/mood/presentation/mood_archive_screen.dart';
import '../../features/archetype/presentation/archetype_growth_screen.dart';
import '../../features/energy/presentation/energy_map_explorer_screen.dart';
import '../../features/bond/presentation/bond_touch_timeline_screen.dart';
import '../../features/library/presentation/context_module_library_screen.dart';
import '../../features/programs/presentation/program_progression_screen.dart';
import '../../features/quiz/presentation/quiz_results_archive_screen.dart';
import '../../features/tools/presentation/tool_catalog_screen.dart';
import '../../features/wellness/presentation/wellness_detail_screen.dart';
import '../../shared/widgets/main_shell_screen.dart';
import '../../data/services/admin_auth_service.dart';
import '../../data/services/storage_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.disclaimer,
    errorBuilder: (context, state) => _NotFoundScreen(path: state.uri.path),
    redirect: (context, state) {
      final path = state.uri.path;

      // Allow disclaimer, onboarding, quiz, and lock without guard
      if (path == Routes.disclaimer ||
          path == Routes.onboarding ||
          path == Routes.archetypeQuiz ||
          path == Routes.appLock) {
        return null;
      }

      // Allow admin routes without onboarding (debug only)
      if (kDebugMode && path.startsWith(Routes.admin)) {
        return null;
      }

      // WEB: Skip storage check
      if (kIsWeb) {
        return null;
      }

      // MOBILE: First-launch disclaimer check
      final disclaimerAccepted = StorageService.loadDisclaimerAccepted();
      if (!disclaimerAccepted) {
        return Routes.disclaimer;
      }

      // MOBILE: Guard - redirect to onboarding if not completed
      final onboardingDone = StorageService.loadOnboardingComplete();
      if (!onboardingDone) {
        return Routes.onboarding;
      }

      return null;
    },
    routes: [
      // ════════════════════════════════════════════════════════════════
      // SYSTEM ROUTES
      // ════════════════════════════════════════════════════════════════
      GoRoute(path: '/', redirect: (_, _) => Routes.today),
      GoRoute(
        path: Routes.disclaimer,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const DisclaimerScreen(),
          transitionsBuilder: (ctx, anim, secAnim, child) => FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: Routes.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const OnboardingScreen(),
          transitionsBuilder: (ctx, anim, secAnim, child) => FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        path: Routes.archetypeQuiz,
        builder: (context, state) => const ArchetypeQuizScreen(),
      ),
      // ════════════════════════════════════════════════════════════════
      // 5-TAB SHELL: Home | Journal | Insights | Notes | Profile
      // ════════════════════════════════════════════════════════════════
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          // Tab 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.today,
                builder: (context, state) => const TodayFeedScreen(),
              ),
            ],
          ),
          // Tab 1: Journal
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.journal,
                builder: (context, state) {
                  final extra = state.extra is Map<String, dynamic> ? state.extra as Map<String, dynamic> : null;
                  return DailyEntryScreen(
                    initialDate: extra?['initialDate'] as DateTime?,
                    journalPrompt: extra?['journalPrompt'] as String?,
                    retrospectiveDateId:
                        extra?['retrospectiveDateId'] as String?,
                  );
                },
              ),
            ],
          ),
          // Tab 2: Insights
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.moodTrends,
                builder: (context, state) => const MoodTrendsScreen(),
              ),
            ],
          ),
          // Tab 3: Notes
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.notesList,
                builder: (context, state) => const NotesListScreen(),
              ),
            ],
          ),
          // Tab 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profileHub,
                builder: (context, state) => const ProfileHubScreen(),
              ),
            ],
          ),
        ],
      ),

      // ════════════════════════════════════════════════════════════════
      // JOURNAL (sub-screens, outside shell)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.journalEntryDetail,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PageTransitions.cardDetail(
            child: EntryDetailScreen(entryId: id),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.journalPatterns,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const PatternsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.journalMonthly,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const MonthlyReflectionScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.journalArchive,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ArchiveScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.sprintEntry,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const SprintEntryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.journalQuery,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const JournalQueryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.memories,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const MemoriesScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.emotionalTimeline,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const EmotionalTimelineScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // INTENTIONS & VALUES
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.intentions,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const IntentionsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.valuesCompass,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ValuesCompassScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.innerDialogue,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const InnerDialogueScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.triggerMap,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const TriggerMapScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.morningPages,
        pageBuilder: (context, state) => PageTransitions.slideUp(
          child: const MorningPagesScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.moodBoard,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const MoodBoardScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.growthLetters,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const GrowthLettersScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.wordCloud,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const WordCloudScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // INSIGHTS (sub-screens, outside shell)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.moodCompass,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const MoodCompassScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.calendarHeatmap,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const CalendarHeatmapScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // LIFE EVENTS
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.lifeEventNew,
        builder: (context, state) {
          final date = state.uri.queryParameters['date'];
          return LifeEventScreen(initialDate: date);
        },
      ),
      GoRoute(
        path: Routes.lifeEventEdit,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return LifeEventScreen(editId: id);
        },
      ),
      GoRoute(
        path: Routes.lifeEventDetail,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PageTransitions.cardDetail(
            child: LifeEventDetailScreen(eventId: id),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.lifeTimeline,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const LifeTimelineScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.emotionalCycles,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const EmotionalCycleScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // BIRTHDAY AGENDA
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.birthdayAgenda,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const BirthdayAgendaScreen(),
          key: state.pageKey,
        ),
      ),
      // Literal routes MUST come before parametric :id route
      GoRoute(
        path: Routes.birthdayAdd,
        builder: (context, state) => const BirthdayAddScreen(),
      ),
      GoRoute(
        path: Routes.birthdayImport,
        builder: (context, state) => const BirthdayImportScreen(),
      ),
      GoRoute(
        path: Routes.birthdayEdit,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return BirthdayAddScreen(editId: id);
        },
      ),
      GoRoute(
        path: Routes.birthdayDetail,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PageTransitions.cardDetail(
            child: BirthdayDetailScreen(contactId: id),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.cycleSync,
        builder: (context, state) => const CycleSyncScreen(),
      ),
      GoRoute(
        path: Routes.shadowWork,
        builder: (context, state) => const ShadowWorkScreen(),
      ),
      // ════════════════════════════════════════════════════════════════
      // BREATHE & MEDITATION (standalone, accessible from Profile)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.breathing,
        pageBuilder: (context, state) => PageTransitions.slideUp(
          child: const BreathingTimerScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.meditation,
        pageBuilder: (context, state) => PageTransitions.slideUp(
          child: const MeditationTimerScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // PROFILE & SETTINGS
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.profile,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ProfileScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.settings,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const SettingsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.premium,
        pageBuilder: (context, state) => PageTransitions.scaleModal(
          child: const PremiumScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.notifications,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const NotificationScheduleScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.exportData,
        pageBuilder: (context, state) => PageTransitions.slideUp(
          child: const ExportScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // STREAK
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.streakStats,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const StreakStatsScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // NOTES TO SELF (detail/create sub-screens, outside shell)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.noteDetail,
        pageBuilder: (context, state) {
          final extra = state.extra is Map<String, dynamic> ? state.extra as Map<String, dynamic> : null;
          final noteId = extra?['noteId'] as String? ??
              state.uri.queryParameters['noteId'] ??
              '';
          return PageTransitions.cardDetail(
            child: NoteDetailScreen(noteId: noteId),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.noteCreate,
        builder: (context, state) => const NoteDetailScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // APP LOCK
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.appLock,
        builder: (context, state) => const AppLockScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // BOND (BAĞ) - Partner Feature
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.bondHub,
        builder: (context, state) => const BondHubScreen(),
      ),
      GoRoute(
        path: Routes.bondInvite,
        builder: (context, state) => const BondInviteScreen(),
      ),
      GoRoute(
        path: Routes.bondAccept,
        builder: (context, state) => const BondAcceptScreen(),
      ),
      GoRoute(
        path: Routes.bondAcceptCode,
        builder: (context, state) => BondAcceptScreen(
          prefilledCode: state.pathParameters['code'],
        ),
      ),
      GoRoute(
        path: Routes.bondDetail,
        builder: (context, state) => BondDetailScreen(
          bondId: state.pathParameters['bondId'] ?? '',
        ),
      ),
      GoRoute(
        path: Routes.bondMoodCalendar,
        builder: (context, state) => BondMoodCalendarScreen(
          bondId: state.pathParameters['bondId'] ?? '',
        ),
      ),
      // ════════════════════════════════════════════════════════════════
      // PRIVATE VAULT
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.vaultPin,
        pageBuilder: (context, state) {
          final extra = state.extra is Map<String, dynamic> ? state.extra as Map<String, dynamic> : null;
          final mode = extra?['mode'] as String?;
          return PageTransitions.scaleModal(
            child: VaultPinScreen(mode: mode),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.vault,
        pageBuilder: (context, state) => PageTransitions.scaleModal(
          child: const VaultScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // ADMIN SYSTEM (debug builds only)
      // ════════════════════════════════════════════════════════════════
      if (kDebugMode) ...[
        GoRoute(
          path: Routes.adminLogin,
          builder: (context, state) => const AdminLoginScreen(),
        ),
        GoRoute(
          path: Routes.admin,
          redirect: (context, state) {
            if (!AdminAuthService.isAuthenticated) {
              return Routes.adminLogin;
            }
            return null;
          },
          builder: (context, state) => const AdminDashboardScreen(),
        ),
      ],

      // ════════════════════════════════════════════════════════════════
      // DISCOVERY & GROWTH FEATURES
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.promptLibrary,
        builder: (context, state) => const PromptLibraryScreen(),
      ),
      GoRoute(
        path: Routes.milestones,
        builder: (context, state) => const MilestoneScreen(),
      ),
      GoRoute(
        path: Routes.yearReview,
        builder: (context, state) => const YearReviewScreen(),
      ),
      GoRoute(
        path: Routes.wrapped,
        builder: (context, state) => const WrappedScreen(),
      ),
      GoRoute(
        path: Routes.dailyHabits,
        builder: (context, state) => const DailyHabitsScreen(),
      ),
      // partner + referral routes removed (killed features)
      GoRoute(
        path: Routes.annualReport,
        builder: (context, state) => const AnnualReportScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // RETROSPECTIVE & MONTHLY WRAPPED
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.retrospective,
        builder: (context, state) => const RetrospectiveScreen(),
      ),
      GoRoute(
        path: Routes.monthlyWrapped,
        builder: (context, state) => const MonthlyWrappedScreen(),
      ),
      GoRoute(
        path: Routes.shareCardGallery,
        builder: (context, state) => const ShareCardGalleryScreen(),
      ),
      GoRoute(
        path: Routes.habitSuggestions,
        builder: (context, state) => const HabitSuggestionsScreen(),
      ),
      GoRoute(
        path: Routes.growthDashboard,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const GrowthDashboardScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.timeCapsule,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const TimeCapsuleScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.lifeWheel,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const LifeWheelScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.monthlyTheme,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const MonthlyThemeScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.fearInventory,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const FearInventoryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.selfCompassion,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const SelfCompassionScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.clarityScore,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ClarityScoreScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.moodRhythm,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const EmotionalCyclesScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.dreamCorrelation,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const DreamCorrelationScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.shiftOutlook,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ShiftOutlookScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.emotionalFingerprint,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const EmotionalFingerprintScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.cycleCorrelation,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const CycleCorrelationScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.attachmentStyleResult,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const AttachmentStyleResultScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.ritualStats,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const RitualStatsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.gratitudeInsights,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const GratitudeInsightsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.shadowWorkArchive,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ShadowWorkArchiveScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.patternHealth,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const PatternHealthScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.habitAdoption,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const HabitAdoptionScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.wellnessHistory,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const WellnessHistoryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.patternLoopArchive,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const PatternLoopArchiveScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.dreamMemoryAnalytics,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const DreamMemoryAnalyticsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.crossCorrelations,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const CrossCorrelationScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.anomalyDetection,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const AnomalyDetectionScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.journeyAnalytics,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const JourneyAnalyticsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.moodArchive,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const MoodArchiveScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.archetypeGrowth,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ArchetypeGrowthScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.energyMapExplorer,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const EnergyMapExplorerScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.bondTouchTimeline,
        pageBuilder: (context, state) {
          final bondId = state.pathParameters['bondId'] ?? '';
          return PageTransitions.fadeSlide(
            child: BondTouchTimelineScreen(bondId: bondId),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.contextModuleLibrary,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ContextModuleLibraryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.programProgression,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ProgramProgressionScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.quizResultsArchive,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const QuizResultsArchiveScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.weeklyDigest,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const WeeklyDigestScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // INSIGHT & DISCOVERY
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.insight,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const InsightScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.insightsDiscovery,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const InsightsDiscoveryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.search,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const GlobalSearchScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // DREAMS
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.dreamInterpretation,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const DreamInterpretationScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.dreamGlossary,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const DreamGlossaryScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.dreamArchive,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const DreamArchiveScreen(),
          key: state.pageKey,
        ),
      ),
      // ── Dream Pages (single parameterized route) ──
      GoRoute(
        path: '/dreams/:theme',
        pageBuilder: (context, state) {
          final theme = state.pathParameters['theme'] ?? '';
          // Skip non-canonical routes handled above
          if (theme == 'archive') {
            return PageTransitions.fadeSlide(
              child: const DreamArchiveScreen(),
              key: state.pageKey,
            );
          }
          return PageTransitions.cardDetail(
            child: DreamThemeScreen(themeId: theme),
            key: state.pageKey,
          );
        },
      ),

      // ════════════════════════════════════════════════════════════════
      // RITUALS & WELLNESS
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.rituals,
        builder: (context, state) => const RitualsScreen(),
      ),
      GoRoute(
        path: Routes.ritualCreate,
        builder: (context, state) => const RitualCreateScreen(),
      ),
      GoRoute(
        path: Routes.wellnessDetail,
        builder: (context, state) => const WellnessDetailScreen(),
      ),
      GoRoute(
        path: Routes.energyMap,
        builder: (context, state) => const EnergyMapScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // SEASONAL, MOON, CHALLENGES
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.seasonal,
        builder: (context, state) => const SeasonalReflectionScreen(),
      ),
      // moonCalendar route removed (killed feature)
      GoRoute(
        path: Routes.challengeHub,
        builder: (context, state) => const ChallengeHubScreen(),
      ),
      GoRoute(
        path: Routes.challenges,
        builder: (context, state) => const ChallengeListScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // GRATITUDE & SLEEP
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.gratitudeJournal,
        builder: (context, state) => const GratitudeScreen(),
      ),
      GoRoute(
        path: Routes.gratitudeArchive,
        builder: (context, state) => const GratitudeArchiveScreen(),
      ),
      GoRoute(
        path: Routes.sleepDetail,
        builder: (context, state) => const SleepDetailScreen(),
      ),
      GoRoute(
        path: Routes.sleepTrends,
        builder: (context, state) => const SleepTrendsScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // PROGRAMS
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.programs,
        builder: (context, state) => const ProgramListScreen(),
      ),
      GoRoute(
        path: Routes.programDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ActiveProgramScreen(programId: id);
        },
      ),
      GoRoute(
        path: Routes.programCompletion,
        builder: (context, state) {
          final extra = state.extra is Map<String, dynamic> ? state.extra as Map<String, dynamic> : <String, dynamic>{};
          return ProgramCompletionScreen(
            programTitle: extra['programTitle'] as String? ?? '',
            programEmoji: extra['programEmoji'] as String? ?? '',
            durationDays: extra['durationDays'] as int? ?? 0,
            completedDays: extra['completedDays'] as int? ?? 0,
          );
        },
      ),

      // ════════════════════════════════════════════════════════════════
      // QUIZZES
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.quizHub,
        builder: (context, state) => const QuizHubScreen(),
      ),
      GoRoute(
        path: Routes.attachmentQuiz,
        builder: (context, state) => const AttachmentQuizScreen(),
      ),
      GoRoute(
        path: Routes.quizGeneric,
        builder: (context, state) {
          final quizId = state.pathParameters['quizId'] ?? '';
          return GenericQuizScreen(quizId: quizId);
        },
      ),

      // ════════════════════════════════════════════════════════════════
      // REFERENCE & CONTENT
      // ════════════════════════════════════════════════════════════════
      // articles route removed (killed feature)
      GoRoute(
        path: Routes.affirmations,
        builder: (context, state) => const AffirmationLibraryScreen(),
      ),
      GoRoute(
        path: Routes.emotionalVocabulary,
        builder: (context, state) => const EmotionalVocabularyScreen(),
      ),
      // Redirect dead routes to closest equivalents
      GoRoute(
        path: Routes.shareInsight,
        redirect: (_, _) => Routes.shareCardGallery,
      ),
      GoRoute(path: Routes.glossary, redirect: (_, _) => Routes.dreamGlossary),

      // ════════════════════════════════════════════════════════════════
      // PERSONALITY & COMPATIBILITY
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.archetype,
        builder: (context, state) => const ArchetypeScreen(),
      ),
      // compatibility route removed (killed feature)
      GoRoute(
        path: Routes.blindSpot,
        builder: (context, state) => const BlindSpotScreen(),
      ),

      // ════════════════════════════════════════════════════════════════
      // TABS (library, tools)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.library,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const LibraryHubScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.tools,
        pageBuilder: (context, state) => PageTransitions.fadeSlide(
          child: const ToolCatalogScreen(),
          key: state.pageKey,
        ),
      ),

      // ════════════════════════════════════════════════════════════════
      // DEEP LINK ROUTES (innercycles:// scheme)
      // ════════════════════════════════════════════════════════════════
      GoRoute(
        path: Routes.referralProgram,
        builder: (context, state) {
          final code = state.uri.queryParameters['code'];
          return ReferralScreen(initialCode: code);
        },
      ),
      GoRoute(
        path: Routes.deepLinkInvite,
        redirect: (context, state) {
          final code = state.pathParameters['code'] ?? '';
          return '${Routes.referralProgram}?code=$code';
        },
      ),
      GoRoute(
        path: Routes.deepLinkShare,
        redirect: (context, state) {
          // Navigate to share card gallery (cardId available via query for future use)
          final cardId = state.pathParameters['cardId'] ?? '';
          return '${Routes.shareCardGallery}?cardId=$cardId';
        },
      ),

      // ════════════════════════════════════════════════════════════════
      // LEGACY DREAM REDIRECTS (Turkish backward compatibility)
      // ════════════════════════════════════════════════════════════════
      ...Routes.legacyRouteRedirects.entries.map(
        (entry) =>
            GoRoute(path: entry.key, redirect: (context, state) => entry.value),
      ),
    ],
  );
});

// ════════════════════════════════════════════════════════════════════════════
// NOT FOUND SCREEN
// ════════════════════════════════════════════════════════════════════════════

class _NotFoundScreen extends StatelessWidget {
  final String path;

  const _NotFoundScreen({required this.path});

  @override
  Widget build(BuildContext context) {
    final isEn = ui.PlatformDispatcher.instance.locale.languageCode != 'tr';
    final language = AppLanguage.fromIsEn(isEn);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.explore_off, size: 64, color: Colors.white38),
            const SizedBox(height: 24),
            Text(
              L10nService.get('error.page_not_found', language),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              path,
              style: AppTypography.subtitle(
                fontSize: 12,
                color: Colors.white38,
              ).copyWith(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 32),
            TextButton.icon(
              onPressed: () => context.go(Routes.today),
              icon: const Icon(Icons.home, color: Colors.white70),
              label: Text(
                L10nService.get('common.home', language),
                style: AppTypography.elegantAccent(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
