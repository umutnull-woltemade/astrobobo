// ════════════════════════════════════════════════════════════════════════════
// APP PROVIDERS - Core State Management (App Store 4.3(b) Compliant)
// ════════════════════════════════════════════════════════════════════════════
// All legacy providers have been removed for App Store compliance.
// This file now focuses on:
// - User profile management
// - Language settings
// - Theme settings
// - Dream journal
// ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

import '../services/storage_service.dart';
import '../services/dream_journal_service.dart';
import '../services/journal_service.dart';
import '../services/streak_service.dart';
import '../services/gratitude_service.dart';
import '../services/ritual_service.dart';
import '../services/review_service.dart';
import '../services/attachment_style_service.dart';
import '../services/sleep_service.dart';
import '../services/wellness_score_service.dart';
import '../services/energy_map_service.dart';
import '../services/guided_program_service.dart';
import '../services/seasonal_reflection_service.dart';
import '../services/growth_challenge_service.dart';
import '../services/weekly_digest_service.dart';
import '../services/mood_checkin_service.dart';
import '../services/archetype_service.dart';
// compatibility_service removed (killed feature)
import '../services/blind_spot_service.dart';
import '../services/export_service.dart';
import '../services/affirmation_service.dart';
import '../services/milestone_service.dart';
import '../services/journal_prompt_service.dart';
import '../services/pattern_health_service.dart';
import '../services/quiz_engine_service.dart';
import '../services/notification_lifecycle_service.dart';
import '../services/voice_journal_service.dart';
import '../services/pattern_engine_service.dart';
import '../services/year_review_service.dart';
// referral + intro offer providers defined in their service files
import '../services/context_module_service.dart';
import '../services/habit_suggestion_service.dart';
import '../services/app_lock_service.dart';
import '../services/pattern_loop_service.dart';
import '../services/shift_outlook_service.dart';
import '../services/emotional_cycle_service.dart';
import '../services/cycle_sync_service.dart';
import '../services/cycle_correlation_service.dart';
import '../services/shadow_work_service.dart';
// partner_sync_service removed (killed feature)
import '../services/telemetry_service.dart';
import '../services/progressive_unlock_service.dart';
import '../services/life_event_service.dart';
import '../services/birthday_contact_service.dart';
import '../models/birthday_contact.dart';
import '../services/retrospective_date_service.dart';
import '../services/monthly_wrapped_service.dart';
import '../services/note_to_self_service.dart';
import '../models/journal_entry.dart';
import '../models/note_to_self.dart';
import '../models/cross_correlation_result.dart';
import '../services/sync_service.dart';
import '../services/vault_service.dart';
import '../models/vault_photo.dart';
import '../services/smart_prompt_service.dart';
import '../services/time_capsule_service.dart';
import '../services/clarity_score_service.dart';
import '../services/intention_service.dart';
import '../services/values_service.dart';
import '../services/inner_dialogue_service.dart';
import '../services/trigger_map_service.dart';
import '../services/self_compassion_service.dart';
import '../services/morning_pages_service.dart';
import '../services/growth_letter_service.dart';
import '../services/word_cloud_service.dart';
import '../services/reflection_prompt_engine.dart';
import '../services/life_wheel_service.dart';
import '../services/monthly_theme_service.dart';
import '../services/fear_inventory_service.dart';
import '../services/dream_journal_correlation_service.dart';
import '../services/dream_memory_service.dart';
import '../services/feature_flag_service.dart';

// =============================================================================
// USER PROFILE PROVIDERS
// =============================================================================

/// User profile state using Notifier (Riverpod 2.x+)
final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfile?>(
  () {
    return UserProfileNotifier();
  },
);

class UserProfileNotifier extends Notifier<UserProfile?> {
  @override
  UserProfile? build() => null;

  void setProfile(UserProfile profile) {
    state = profile;
    _syncToStorage(profile);
  }

  void clearProfile() {
    state = null;
  }

  void _syncToStorage(UserProfile profile) {
    StorageService.saveUserProfile(profile);
    ref.read(savedProfilesProvider.notifier).updateProfile(profile);
  }
}

/// Multiple profiles provider
final savedProfilesProvider =
    NotifierProvider<SavedProfilesNotifier, List<UserProfile>>(() {
      return SavedProfilesNotifier();
    });

class SavedProfilesNotifier extends Notifier<List<UserProfile>> {
  @override
  List<UserProfile> build() {
    return StorageService.loadAllProfiles();
  }

  Future<void> addProfile(UserProfile profile) async {
    await StorageService.saveProfile(profile);
    state = StorageService.loadAllProfiles();
  }

  Future<void> updateProfile(UserProfile profile) async {
    await StorageService.saveProfile(profile);
    state = StorageService.loadAllProfiles();
  }

  Future<void> removeProfile(String id) async {
    await StorageService.deleteProfile(id);
    state = StorageService.loadAllProfiles();
  }

  Future<void> setPrimary(String id) async {
    await StorageService.setPrimaryProfileId(id);
    final profiles = state.map((p) {
      return p.copyWith(isPrimary: p.id == id);
    }).toList();
    state = profiles;
  }

  void refresh() {
    state = StorageService.loadAllProfiles();
  }
}

// =============================================================================
// APP STATE PROVIDERS
// =============================================================================

/// Onboarding completed flag
final onboardingCompleteProvider = StateProvider<bool>((ref) => false);

// =============================================================================
// LANGUAGE PROVIDER
// =============================================================================

enum AppLanguage {
  en, // English
  tr; // Türkçe

  /// Tracks the actual current language set by the user.
  static AppLanguage _current = en;
  static void setCurrent(AppLanguage lang) => _current = lang;

  /// Convert legacy bool isEn to AppLanguage.
  /// Returns the actual current language instead of hardcoded `tr` for non-EN.
  static AppLanguage fromIsEn(bool isEn) => isEn ? en : _current;
}

extension AppLanguageExtension on AppLanguage {
  String get displayName {
    switch (this) {
      case AppLanguage.en:
        return 'English';
      case AppLanguage.tr:
        return 'Türkçe';
    }
  }

  String get flag {
    switch (this) {
      case AppLanguage.en:
        return '🇬🇧';
      case AppLanguage.tr:
        return '🇹🇷';
    }
  }

  bool get isEn => this == AppLanguage.en;

  bool get isRTL => false;

  /// Languages with complete translations and strict isolation support
  bool get hasStrictIsolation => true;

  /// Languages that are fully available for selection
  bool get isFullyAvailable => true;

  Locale get locale {
    switch (this) {
      case AppLanguage.en:
        return const Locale('en', 'US');
      case AppLanguage.tr:
        return const Locale('tr', 'TR');
    }
  }
}

final languageProvider = StateProvider<AppLanguage>((ref) => AppLanguage.en);

// =============================================================================
// THEME PROVIDER
// =============================================================================

/// Theme mode provider - default is dark
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

/// Font size scale provider (0.85 = small, 1.0 = normal, 1.15 = large)
final fontSizeScaleProvider = StateProvider<double>((ref) => 1.0);

// =============================================================================
// DREAM JOURNAL PROVIDER
// =============================================================================

/// Dream Journal Service provider - async initialization
final dreamJournalServiceProvider = FutureProvider<DreamJournalService>((
  ref,
) async {
  final service = await DreamJournalService.init();
  SyncService.registerMergeHandler('dream_entries', service.mergeRemoteDreams);
  return service;
});

/// Derived dream count provider (sync-safe for widget builds).
final dreamCountProvider = FutureProvider<int>((ref) async {
  final service = await ref.watch(dreamJournalServiceProvider.future);
  return service.getDreamCount();
});

/// Dream Memory Service provider - symbol tracking & analysis
final dreamMemoryServiceProvider = FutureProvider<DreamMemoryService>((
  ref,
) async {
  return DreamMemoryService.init();
});

// =============================================================================
// JOURNAL PROVIDERS (InnerCycles)
// =============================================================================

/// Journal Service provider - async initialization
final journalServiceProvider = FutureProvider<JournalService>((ref) async {
  final service = await JournalService.init();
  SyncService.registerMergeHandler(
    'journal_entries',
    service.mergeRemoteEntries,
  );
  return service;
});

/// Today's journal entry (null if not logged yet)
final todayJournalEntryProvider = FutureProvider<JournalEntry?>((ref) async {
  final service = await ref.watch(journalServiceProvider.future);
  return service.getTodayEntry();
});

/// Total journal entry count (lightweight — avoids watching full JournalService)
final journalEntryCountProvider = FutureProvider<int>((ref) async {
  final service = await ref.watch(journalServiceProvider.future);
  return service.getAllEntries().length;
});

/// Current streak count
final journalStreakProvider = FutureProvider<int>((ref) async {
  final service = await ref.watch(journalServiceProvider.future);
  return service.getCurrentStreak();
});

// =============================================================================
// STREAK SERVICE PROVIDER
// =============================================================================

final streakServiceProvider = FutureProvider<StreakService>((ref) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return await StreakService.init(journalService);
});

final streakStatsProvider = FutureProvider<StreakStats>((ref) async {
  final streakService = await ref.watch(streakServiceProvider.future);
  return streakService.getStats();
});

// =============================================================================
// GRATITUDE SERVICE PROVIDER
// =============================================================================

final gratitudeServiceProvider = FutureProvider<GratitudeService>((ref) async {
  return await GratitudeService.init();
});

final todayGratitudeProvider = FutureProvider<GratitudeEntry?>((ref) async {
  final service = await ref.watch(gratitudeServiceProvider.future);
  return service.getTodayEntry();
});

final gratitudeSummaryProvider = FutureProvider<GratitudeSummary>((ref) async {
  final service = await ref.watch(gratitudeServiceProvider.future);
  return service.getWeeklySummary();
});

// =============================================================================
// RITUAL SERVICE PROVIDER
// =============================================================================

final ritualServiceProvider = FutureProvider<RitualService>((ref) async {
  return await RitualService.init();
});

final timeCapsuleServiceProvider = FutureProvider<TimeCapsuleService>((ref) async {
  return await TimeCapsuleService.init();
});

final clarityScoreServiceProvider = FutureProvider<ClarityScoreService>((ref) async {
  final journal = await ref.watch(journalServiceProvider.future);
  final mood = await ref.watch(moodCheckinServiceProvider.future);
  final ritual = await ref.watch(ritualServiceProvider.future);
  final sleep = await ref.watch(sleepServiceProvider.future);
  final gratitude = await ref.watch(gratitudeServiceProvider.future);
  final streak = await ref.watch(streakServiceProvider.future);
  return ClarityScoreService.init(
    journalService: journal,
    moodService: mood,
    ritualService: ritual,
    sleepService: sleep,
    gratitudeService: gratitude,
    streakService: streak,
  );
});

final intentionServiceProvider = FutureProvider<IntentionService>((ref) async {
  return IntentionService.init();
});

final valuesServiceProvider = FutureProvider<ValuesService>((ref) async {
  return ValuesService.init();
});

final innerDialogueServiceProvider = FutureProvider<InnerDialogueService>((ref) async {
  return InnerDialogueService.init();
});

final triggerMapServiceProvider = FutureProvider<TriggerMapService>((ref) async {
  return TriggerMapService.init();
});

final selfCompassionServiceProvider = FutureProvider<SelfCompassionService>((ref) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return SelfCompassionService(journalService);
});

final morningPagesServiceProvider = FutureProvider<MorningPagesService>((ref) async {
  return MorningPagesService.init();
});

final growthLetterServiceProvider = FutureProvider<GrowthLetterService>((ref) async {
  return GrowthLetterService.init();
});

final wordCloudServiceProvider = FutureProvider<WordCloudService>((ref) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return WordCloudService(journalService);
});

final reflectionPromptEngineProvider = FutureProvider<ReflectionPromptEngine>((ref) async {
  final moodService = await ref.watch(moodCheckinServiceProvider.future);
  return ReflectionPromptEngine(moodService);
});

final lifeWheelServiceProvider = FutureProvider<LifeWheelService>((ref) async {
  return LifeWheelService.init();
});

final monthlyThemeServiceProvider = FutureProvider<MonthlyThemeService>((ref) async {
  return MonthlyThemeService.init();
});

final fearInventoryServiceProvider = FutureProvider<FearInventoryService>((ref) async {
  return FearInventoryService.init();
});

final ritualStacksProvider = FutureProvider<List<RitualStack>>((ref) async {
  final service = await ref.watch(ritualServiceProvider.future);
  return service.getStacks();
});

final todayRitualSummaryProvider = FutureProvider<DailyRitualSummary>((
  ref,
) async {
  final service = await ref.watch(ritualServiceProvider.future);
  return service.getTodaySummary();
});

// =============================================================================
// REVIEW SERVICE PROVIDER
// =============================================================================

final reviewServiceProvider = FutureProvider<ReviewService>((ref) async {
  return await ReviewService.init();
});

// =============================================================================
// ATTACHMENT STYLE PROVIDER
// =============================================================================

final attachmentStyleServiceProvider = FutureProvider<AttachmentStyleService>((
  ref,
) async {
  return await AttachmentStyleService.init();
});

// =============================================================================
// SLEEP SERVICE PROVIDER
// =============================================================================

final sleepServiceProvider = FutureProvider<SleepService>((ref) async {
  return await SleepService.init();
});

final todaySleepProvider = FutureProvider<SleepEntry?>((ref) async {
  final service = await ref.watch(sleepServiceProvider.future);
  return service.getTodayEntry();
});

final sleepSummaryProvider = FutureProvider<SleepSummary>((ref) async {
  final service = await ref.watch(sleepServiceProvider.future);
  return service.getWeeklySummary();
});

// =============================================================================
// WELLNESS SCORE PROVIDER
// =============================================================================

final wellnessScoreServiceProvider = FutureProvider<WellnessScoreService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  final gratitudeService = await ref.watch(gratitudeServiceProvider.future);
  final ritualService = await ref.watch(ritualServiceProvider.future);
  final streakService = await ref.watch(streakServiceProvider.future);
  final sleepService = await ref.watch(sleepServiceProvider.future);
  return await WellnessScoreService.init(
    journalService: journalService,
    gratitudeService: gratitudeService,
    ritualService: ritualService,
    streakService: streakService,
    sleepService: sleepService,
  );
});

final wellnessScoreProvider = FutureProvider<WellnessScore?>((ref) async {
  final service = await ref.watch(wellnessScoreServiceProvider.future);
  return await service.calculateTodayScore();
});

final wellnessTrendProvider = FutureProvider<WellnessTrend>((ref) async {
  final service = await ref.watch(wellnessScoreServiceProvider.future);
  return service.getWeeklyTrend();
});

// =============================================================================
// ENERGY MAP PROVIDER
// =============================================================================

final energyMapServiceProvider = FutureProvider<EnergyMapService>((ref) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return EnergyMapService(journalService);
});

final energyMapProvider = FutureProvider<EnergyMapData?>((ref) async {
  final service = await ref.watch(energyMapServiceProvider.future);
  if (!service.hasEnoughData()) return null;
  return service.buildHeatmap();
});

// =============================================================================
// GUIDED PROGRAM PROVIDER
// =============================================================================

final guidedProgramServiceProvider = FutureProvider<GuidedProgramService>((
  ref,
) async {
  return await GuidedProgramService.init();
});

// =============================================================================
// SEASONAL REFLECTION PROVIDER
// =============================================================================

final seasonalReflectionServiceProvider =
    FutureProvider<SeasonalReflectionService>((ref) async {
      return await SeasonalReflectionService.init();
    });

// =============================================================================
// GROWTH CHALLENGE PROVIDER
// =============================================================================

final growthChallengeServiceProvider = FutureProvider<GrowthChallengeService>((
  ref,
) async {
  return await GrowthChallengeService.init();
});

// =============================================================================
// WEEKLY DIGEST PROVIDER
// =============================================================================

final weeklyDigestServiceProvider = FutureProvider<WeeklyDigestService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  final patternEngine = await ref.watch(patternEngineServiceProvider.future);
  return await WeeklyDigestService.init(
    journalService: journalService,
    patternEngine: patternEngine,
  );
});

/// Pre-computed weekly digest data for the current week
final weeklyDigestDataProvider = FutureProvider<WeeklyDigestData?>((ref) async {
  final service = await ref.watch(weeklyDigestServiceProvider.future);
  if (!service.hasDataForWeek(DateTime.now())) return null;
  return service.generateDigest(DateTime.now());
});

// =============================================================================
// MOOD CHECK-IN PROVIDER
// =============================================================================

final moodCheckinServiceProvider = FutureProvider<MoodCheckinService>((
  ref,
) async {
  final service = await MoodCheckinService.init();
  SyncService.registerMergeHandler('mood_entries', service.mergeRemoteMoods);
  return service;
});

// =============================================================================
// SIGNAL PROVIDERS (derived from mood check-in)
// =============================================================================

// =============================================================================
// APP LOCK PROVIDER
// =============================================================================

final appLockServiceProvider = FutureProvider<AppLockService>((ref) async {
  return await AppLockService.init();
});

// =============================================================================
// ARCHETYPE PROVIDER
// =============================================================================

final archetypeServiceProvider = FutureProvider<ArchetypeService>((ref) async {
  return await ArchetypeService.init();
});

// =============================================================================
// COMPATIBILITY PROVIDER
// =============================================================================

// compatibilityServiceProvider removed (killed feature)

// =============================================================================
// BLIND SPOT PROVIDER
// =============================================================================

final blindSpotServiceProvider = FutureProvider<BlindSpotService>((ref) async {
  return await BlindSpotService.init();
});

// =============================================================================
// EXPORT SERVICE PROVIDER
// =============================================================================

final exportServiceProvider = FutureProvider<ExportService>((ref) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return ExportService(journalService);
});

// =============================================================================
// AFFIRMATION SERVICE PROVIDER
// =============================================================================

final affirmationServiceProvider = FutureProvider<AffirmationService>((
  ref,
) async {
  return await AffirmationService.init();
});

// =============================================================================
// MILESTONE SERVICE PROVIDER
// =============================================================================

final milestoneServiceProvider = FutureProvider<MilestoneService>((ref) async {
  return await MilestoneService.init();
});

// =============================================================================
// JOURNAL PROMPT SERVICE PROVIDER
// =============================================================================

final journalPromptServiceProvider = FutureProvider<JournalPromptService>((
  ref,
) async {
  return await JournalPromptService.init();
});

// =============================================================================
// SMART PROMPT SERVICE PROVIDER
// =============================================================================

final smartPromptServiceProvider = FutureProvider<SmartPromptService>((
  ref,
) async {
  return await SmartPromptService.init();
});

/// AI-personalized daily prompt. Calls edge function once per day, caches result.
/// Falls back to null (caller should use static prompt pool as fallback).
final smartDailyPromptProvider = FutureProvider<String?>((ref) async {
  final smartService = await ref.watch(smartPromptServiceProvider.future);

  // Return cache immediately if available
  final cached = smartService.getCachedPrompt();
  if (cached != null) return cached;

  // Generate new prompt
  final journalService = await ref.watch(journalServiceProvider.future);
  final language = ref.watch(languageProvider);
  PatternEngineService? patternEngine;
  try {
    patternEngine = await ref.watch(patternEngineServiceProvider.future);
  } catch (_) {}
  int currentStreak = 0;
  try {
    final streakService = await ref.watch(streakServiceProvider.future);
    currentStreak = streakService.getCurrentStreak();
  } catch (_) {}

  return await smartService.getSmartPrompt(
    journalService: journalService,
    language: language,
    patternEngine: patternEngine,
    currentStreak: currentStreak,
  );
});

// =============================================================================
// PATTERN HEALTH SERVICE PROVIDER
// =============================================================================

final patternHealthServiceProvider = FutureProvider<PatternHealthService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return await PatternHealthService.init(journalService);
});

final patternHealthReportProvider = FutureProvider<PatternHealthReport>((
  ref,
) async {
  final service = await ref.watch(patternHealthServiceProvider.future);
  return await service.analyzeHealth();
});

// =============================================================================
// VOICE JOURNAL SERVICE PROVIDER
// =============================================================================

final voiceJournalServiceProvider = FutureProvider<VoiceJournalService>((
  ref,
) async {
  final service = await VoiceJournalService.init();
  ref.onDispose(() => service.dispose());
  return service;
});

// =============================================================================
// NOTIFICATION LIFECYCLE PROVIDER
// =============================================================================

final notificationLifecycleServiceProvider =
    FutureProvider<NotificationLifecycleService>((ref) async {
      return await NotificationLifecycleService.init();
    });

// =============================================================================
// PATTERN ENGINE SERVICE PROVIDER (with cross-correlation support)
// =============================================================================

final patternEngineServiceProvider = FutureProvider<PatternEngineService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  final sleepService = await ref.watch(sleepServiceProvider.future);
  final gratitudeService = await ref.watch(gratitudeServiceProvider.future);
  final ritualService = await ref.watch(ritualServiceProvider.future);
  final wellnessScoreService = await ref.watch(
    wellnessScoreServiceProvider.future,
  );
  final moodCheckinService = await ref.watch(moodCheckinServiceProvider.future);
  final streakService = await ref.watch(streakServiceProvider.future);
  return PatternEngineService(
    journalService,
    sleepService: sleepService,
    gratitudeService: gratitudeService,
    ritualService: ritualService,
    wellnessScoreService: wellnessScoreService,
    moodCheckinService: moodCheckinService,
    streakService: streakService,
  );
});

// =============================================================================
// CROSS-CORRELATIONS PROVIDER
// =============================================================================

final crossCorrelationsProvider = FutureProvider<List<CrossCorrelation>>((
  ref,
) async {
  final engine = await ref.watch(patternEngineServiceProvider.future);
  return engine.getCrossCorrelations();
});

// =============================================================================
// GRATITUDE-MOOD COMPARISON PROVIDER
// =============================================================================

final gratitudeMoodComparisonProvider =
    FutureProvider<GratitudeMoodComparison?>((ref) async {
      final engine = await ref.watch(patternEngineServiceProvider.future);
      return engine.getGratitudeMoodComparison();
    });

// =============================================================================
// QUIZ ENGINE SERVICE PROVIDER
// =============================================================================

final quizEngineServiceProvider = FutureProvider<QuizEngineService>((
  ref,
) async {
  return await QuizEngineService.init();
});

// =============================================================================
// YEAR REVIEW SERVICE PROVIDER
// =============================================================================

final yearReviewServiceProvider = FutureProvider<YearReviewService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return await YearReviewService.init(journalService);
});

// =============================================================================
// REFERRAL SERVICE PROVIDER
// =============================================================================

// Referral + Introductory Offer providers are defined in their service files:
// - referralServiceProvider → referral_service.dart
// - introductoryOfferProvider → introductory_offer_service.dart

// =============================================================================
// CONTEXT MODULE SERVICE PROVIDER
// =============================================================================

final contextModuleServiceProvider = FutureProvider<ContextModuleService>((
  ref,
) async {
  return await ContextModuleService.init();
});

// =============================================================================
// HABIT SUGGESTION SERVICE PROVIDER
// =============================================================================

final habitSuggestionServiceProvider = FutureProvider<HabitSuggestionService>((
  ref,
) async {
  return await HabitSuggestionService.init();
});

// =============================================================================
// PATTERN LOOP SERVICE PROVIDER (Emotion Intelligence)
// =============================================================================

final patternLoopServiceProvider = FutureProvider<PatternLoopService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return await PatternLoopService.init(journalService);
});

final patternLoopAnalysisProvider = FutureProvider<PatternLoopAnalysis>((
  ref,
) async {
  final service = await ref.watch(patternLoopServiceProvider.future);
  return service.analyze();
});

// =============================================================================
// SHIFT OUTLOOK SERVICE PROVIDER (Emotion Intelligence — Premium)
// =============================================================================

final shiftOutlookServiceProvider = FutureProvider<ShiftOutlookService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return ShiftOutlookService(journalService);
});

final shiftOutlookProvider = FutureProvider<ShiftOutlook>((ref) async {
  final service = await ref.watch(shiftOutlookServiceProvider.future);
  return service.generateOutlook();
});

// =============================================================================
// EMOTIONAL CYCLE ANALYSIS PROVIDER (Emotion Intelligence)
// =============================================================================

final emotionalCycleServiceProvider = FutureProvider<EmotionalCycleService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  return EmotionalCycleService(journalService);
});

final emotionalCycleAnalysisProvider = FutureProvider<EmotionalCycleAnalysis>((
  ref,
) async {
  final cycleService = await ref.watch(emotionalCycleServiceProvider.future);
  if (!cycleService.hasEnoughData()) {
    return EmotionalCycleAnalysis(
      areaSummaries: {},
      insights: [],
      totalEntries: cycleService.entryCount,
    );
  }
  return cycleService.analyze();
});

// =============================================================================
// CYCLE SYNC PROVIDERS (Hormonal Cycle Tracking)
// =============================================================================

final cycleSyncServiceProvider = FutureProvider<CycleSyncService>((ref) async {
  final service = await CycleSyncService.init();
  SyncService.registerMergeHandler(
    'cycle_period_logs',
    service.mergeRemoteLogs,
  );
  return service;
});

final cycleCorrelationServiceProvider = FutureProvider<CycleCorrelationService>(
  (ref) async {
    final cycleSyncService = await ref.watch(cycleSyncServiceProvider.future);
    final journalService = await ref.watch(journalServiceProvider.future);
    return CycleCorrelationService(cycleSyncService, journalService);
  },
);

final dreamCorrelationServiceProvider =
    FutureProvider<DreamJournalCorrelationService>((ref) async {
  final dreamService = await ref.watch(dreamJournalServiceProvider.future);
  final journalService = await ref.watch(journalServiceProvider.future);
  return DreamJournalCorrelationService.init(
    dreamService: dreamService,
    journalService: journalService,
  );
});

// =============================================================================
// SHADOW WORK PROVIDERS (Guided Shadow Journal)
// =============================================================================

final shadowWorkServiceProvider = FutureProvider<ShadowWorkService>((
  ref,
) async {
  return await ShadowWorkService.init();
});

// =============================================================================
// PARTNER SYNC PROVIDERS (Partner Cycle Sharing — Local-First MVP)
// =============================================================================

// partnerSyncServiceProvider removed (killed feature)

// =============================================================================
// DREAM-JOURNAL CORRELATION PROVIDERS (Dream-Mood Cross-Analysis)
// =============================================================================

// =============================================================================
// TELEMETRY SERVICE PROVIDER
// =============================================================================

final telemetryServiceProvider = FutureProvider<TelemetryService>((ref) async {
  return await TelemetryService.init();
});

// =============================================================================
// PROGRESSIVE UNLOCK SERVICE PROVIDER
// =============================================================================

final progressiveUnlockServiceProvider =
    FutureProvider<ProgressiveUnlockService>((ref) async {
      return await ProgressiveUnlockService.init();
    });

// =============================================================================
// LIFE EVENT SERVICE PROVIDER
// =============================================================================

final lifeEventServiceProvider = FutureProvider<LifeEventService>((ref) async {
  final service = await LifeEventService.init();
  SyncService.registerMergeHandler('life_events', service.mergeRemoteEvents);
  return service;
});

// =============================================================================
// BIRTHDAY CONTACT SERVICE PROVIDER
// =============================================================================

final birthdayContactServiceProvider = FutureProvider<BirthdayContactService>((
  ref,
) async {
  final service = await BirthdayContactService.init();
  SyncService.registerMergeHandler(
    'birthday_contacts',
    service.mergeRemoteContacts,
  );
  return service;
});

final todayBirthdaysProvider = FutureProvider<List<BirthdayContact>>((
  ref,
) async {
  final service = await ref.watch(birthdayContactServiceProvider.future);
  return service.getTodayBirthdays();
});

// =============================================================================
// RETROSPECTIVE DATE SERVICE PROVIDER
// =============================================================================

final retrospectiveDateServiceProvider =
    FutureProvider<RetrospectiveDateService>((ref) async {
      return await RetrospectiveDateService.init();
    });

// =============================================================================
// MONTHLY WRAPPED SERVICE PROVIDER
// =============================================================================

final monthlyWrappedServiceProvider = FutureProvider<MonthlyWrappedService>((
  ref,
) async {
  final journalService = await ref.watch(journalServiceProvider.future);
  final patternEngine = await ref.watch(patternEngineServiceProvider.future);
  return MonthlyWrappedService(
    journalService: journalService,
    patternEngine: patternEngine,
  );
});

// =============================================================================
// NOTES TO SELF SERVICE PROVIDER
// =============================================================================

final notesToSelfServiceProvider = FutureProvider<NoteToSelfService>((
  ref,
) async {
  final service = await NoteToSelfService.init();
  SyncService.registerMergeHandler('notes_to_self', service.mergeRemoteNotes);
  SyncService.registerMergeHandler(
    'note_reminders',
    service.mergeRemoteReminders,
  );
  return service;
});

final allNotesProvider = FutureProvider<List<NoteToSelf>>((ref) async {
  final service = await ref.watch(notesToSelfServiceProvider.future);
  return service.getAllNotes();
});

final pinnedNotesProvider = FutureProvider<List<NoteToSelf>>((ref) async {
  final service = await ref.watch(notesToSelfServiceProvider.future);
  return service.getPinnedNotes();
});

final upcomingRemindersProvider = FutureProvider<List<NoteReminder>>((
  ref,
) async {
  final service = await ref.watch(notesToSelfServiceProvider.future);
  return service.getUpcomingReminders(hours: 48);
});

// =============================================================================
// VAULT SERVICE PROVIDER (Private Content Vault)
// =============================================================================

final vaultServiceProvider = FutureProvider<VaultService>((ref) async {
  return await VaultService.init();
});

final vaultPhotosProvider = FutureProvider<List<VaultPhoto>>((ref) async {
  final service = await ref.watch(vaultServiceProvider.future);
  return service.getAllPhotos();
});

final vaultPhotoCountProvider = FutureProvider<int>((ref) async {
  final service = await ref.watch(vaultServiceProvider.future);
  return service.photoCount;
});

final privateJournalEntriesProvider = FutureProvider<List<JournalEntry>>((
  ref,
) async {
  final service = await ref.watch(journalServiceProvider.future);
  return service.getPrivateEntries();
});

final privateNotesProvider = FutureProvider<List<NoteToSelf>>((ref) async {
  final service = await ref.watch(notesToSelfServiceProvider.future);
  return service.getPrivateNotes();
});

// =============================================================================
// FEATURE FLAG PROVIDER
// =============================================================================

final featureFlagServiceProvider = FutureProvider<FeatureFlagService>((
  ref,
) async {
  return await FeatureFlagService.init();
});

