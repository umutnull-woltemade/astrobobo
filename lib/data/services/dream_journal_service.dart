/// Dream Journal Service - Advanced Dream Journaling and Pattern Analysis System
/// Provides comprehensive dream tracking, pattern detection, and insight generation
/// Integrates with existing DreamMemoryService and DreamInterpretationService
library;

import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/dream_interpretation_models.dart';
import 'dream_memory_service.dart';
import 'dream_interpretation_service.dart';

// ════════════════════════════════════════════════════════════════
// DREAM ENTRY MODEL
// ════════════════════════════════════════════════════════════════

/// Comprehensive dream entry with full metadata and analysis
class DreamEntry {
  final String id;
  final DateTime dreamDate;
  final DateTime recordedAt;
  final String title;
  final String content;
  final List<String> detectedSymbols;
  final List<String> userTags;
  final EmotionalTone dominantEmotion;
  final int emotionalIntensity; // 1-10
  final bool isRecurring;
  final bool isLucid;
  final bool isNightmare;
  final MoonPhase moonPhase;
  final String? moonSign;
  final List<String>? relevantTransits;
  final FullDreamInterpretation? interpretation;
  final String? voiceRecordingPath;
  final List<String>? imageUrls;
  final Map<String, dynamic>? metadata;

  // Additional analysis fields
  final DreamRole? userRole;
  final TimeLayer? timeLayer;
  final List<String>? characters;
  final List<String>? locations;
  final String? dreamSeriesId;
  final int? clarity; // 1-10 how clearly remembered
  final String? sleepQuality; // poor, fair, good, excellent
  final Duration? sleepDuration;
  final DateTime? wakeTime;
  final String? lifeSituation;

  const DreamEntry({
    required this.id,
    required this.dreamDate,
    required this.recordedAt,
    required this.title,
    required this.content,
    this.detectedSymbols = const [],
    this.userTags = const [],
    required this.dominantEmotion,
    this.emotionalIntensity = 5,
    this.isRecurring = false,
    this.isLucid = false,
    this.isNightmare = false,
    required this.moonPhase,
    this.moonSign,
    this.relevantTransits,
    this.interpretation,
    this.voiceRecordingPath,
    this.imageUrls,
    this.metadata,
    this.userRole,
    this.timeLayer,
    this.characters,
    this.locations,
    this.dreamSeriesId,
    this.clarity,
    this.sleepQuality,
    this.sleepDuration,
    this.wakeTime,
    this.lifeSituation,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'dreamDate': dreamDate.toIso8601String(),
    'recordedAt': recordedAt.toIso8601String(),
    'title': title,
    'content': content,
    'detectedSymbols': detectedSymbols,
    'userTags': userTags,
    'dominantEmotion': dominantEmotion.name,
    'emotionalIntensity': emotionalIntensity,
    'isRecurring': isRecurring,
    'isLucid': isLucid,
    'isNightmare': isNightmare,
    'moonPhase': moonPhase.name,
    'moonSign': moonSign,
    'relevantTransits': relevantTransits,
    'interpretation': interpretation?.toJson(),
    'voiceRecordingPath': voiceRecordingPath,
    'imageUrls': imageUrls,
    'metadata': metadata,
    'userRole': userRole?.name,
    'timeLayer': timeLayer?.name,
    'characters': characters,
    'locations': locations,
    'dreamSeriesId': dreamSeriesId,
    'clarity': clarity,
    'sleepQuality': sleepQuality,
    'sleepDuration': sleepDuration?.inMinutes,
    'wakeTime': wakeTime?.toIso8601String(),
    'lifeSituation': lifeSituation,
  };

  factory DreamEntry.fromJson(Map<String, dynamic> json) => DreamEntry(
    id: json['id'],
    dreamDate: DateTime.parse(json['dreamDate']),
    recordedAt: DateTime.parse(json['recordedAt']),
    title: json['title'],
    content: json['content'],
    detectedSymbols: List<String>.from(json['detectedSymbols'] ?? []),
    userTags: List<String>.from(json['userTags'] ?? []),
    dominantEmotion: EmotionalTone.values.firstWhere(
      (e) => e.name == json['dominantEmotion'],
      orElse: () => EmotionalTone.merak,
    ),
    emotionalIntensity: json['emotionalIntensity'] ?? 5,
    isRecurring: json['isRecurring'] ?? false,
    isLucid: json['isLucid'] ?? false,
    isNightmare: json['isNightmare'] ?? false,
    moonPhase: MoonPhase.values.firstWhere(
      (e) => e.name == json['moonPhase'],
      orElse: () => MoonPhaseCalculator.today,
    ),
    moonSign: json['moonSign'],
    relevantTransits: json['relevantTransits'] != null
        ? List<String>.from(json['relevantTransits'])
        : null,
    interpretation: json['interpretation'] != null
        ? FullDreamInterpretation.fromJson(json['interpretation'])
        : null,
    voiceRecordingPath: json['voiceRecordingPath'],
    imageUrls: json['imageUrls'] != null
        ? List<String>.from(json['imageUrls'])
        : null,
    metadata: json['metadata'],
    userRole: json['userRole'] != null
        ? DreamRole.values.firstWhere((e) => e.name == json['userRole'])
        : null,
    timeLayer: json['timeLayer'] != null
        ? TimeLayer.values.firstWhere((e) => e.name == json['timeLayer'])
        : null,
    characters: json['characters'] != null
        ? List<String>.from(json['characters'])
        : null,
    locations: json['locations'] != null
        ? List<String>.from(json['locations'])
        : null,
    dreamSeriesId: json['dreamSeriesId'],
    clarity: json['clarity'],
    sleepQuality: json['sleepQuality'],
    sleepDuration: json['sleepDuration'] != null
        ? Duration(minutes: json['sleepDuration'])
        : null,
    wakeTime: json['wakeTime'] != null
        ? DateTime.parse(json['wakeTime'])
        : null,
    lifeSituation: json['lifeSituation'],
  );

  DreamEntry copyWith({
    String? id,
    DateTime? dreamDate,
    DateTime? recordedAt,
    String? title,
    String? content,
    List<String>? detectedSymbols,
    List<String>? userTags,
    EmotionalTone? dominantEmotion,
    int? emotionalIntensity,
    bool? isRecurring,
    bool? isLucid,
    bool? isNightmare,
    MoonPhase? moonPhase,
    String? moonSign,
    List<String>? relevantTransits,
    FullDreamInterpretation? interpretation,
    String? voiceRecordingPath,
    List<String>? imageUrls,
    Map<String, dynamic>? metadata,
    DreamRole? userRole,
    TimeLayer? timeLayer,
    List<String>? characters,
    List<String>? locations,
    String? dreamSeriesId,
    int? clarity,
    String? sleepQuality,
    Duration? sleepDuration,
    DateTime? wakeTime,
    String? lifeSituation,
  }) => DreamEntry(
    id: id ?? this.id,
    dreamDate: dreamDate ?? this.dreamDate,
    recordedAt: recordedAt ?? this.recordedAt,
    title: title ?? this.title,
    content: content ?? this.content,
    detectedSymbols: detectedSymbols ?? this.detectedSymbols,
    userTags: userTags ?? this.userTags,
    dominantEmotion: dominantEmotion ?? this.dominantEmotion,
    emotionalIntensity: emotionalIntensity ?? this.emotionalIntensity,
    isRecurring: isRecurring ?? this.isRecurring,
    isLucid: isLucid ?? this.isLucid,
    isNightmare: isNightmare ?? this.isNightmare,
    moonPhase: moonPhase ?? this.moonPhase,
    moonSign: moonSign ?? this.moonSign,
    relevantTransits: relevantTransits ?? this.relevantTransits,
    interpretation: interpretation ?? this.interpretation,
    voiceRecordingPath: voiceRecordingPath ?? this.voiceRecordingPath,
    imageUrls: imageUrls ?? this.imageUrls,
    metadata: metadata ?? this.metadata,
    userRole: userRole ?? this.userRole,
    timeLayer: timeLayer ?? this.timeLayer,
    characters: characters ?? this.characters,
    locations: locations ?? this.locations,
    dreamSeriesId: dreamSeriesId ?? this.dreamSeriesId,
    clarity: clarity ?? this.clarity,
    sleepQuality: sleepQuality ?? this.sleepQuality,
    sleepDuration: sleepDuration ?? this.sleepDuration,
    wakeTime: wakeTime ?? this.wakeTime,
    lifeSituation: lifeSituation ?? this.lifeSituation,
  );
}

// ════════════════════════════════════════════════════════════════
// PATTERN ANALYSIS MODELS
// ════════════════════════════════════════════════════════════════

/// Recurring pattern detected across multiple dreams
class RecurringPattern {
  final String id;
  final String patternType; // symbol, emotion, theme, location, character
  final String patternValue;
  final int occurrenceCount;
  final DateTime firstSeen;
  final DateTime lastSeen;
  final List<String> dreamIds;
  final String? evolutionNote;
  final double significance; // 0.0 - 1.0

  const RecurringPattern({
    required this.id,
    required this.patternType,
    required this.patternValue,
    required this.occurrenceCount,
    required this.firstSeen,
    required this.lastSeen,
    required this.dreamIds,
    this.evolutionNote,
    this.significance = 0.5,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'patternType': patternType,
    'patternValue': patternValue,
    'occurrenceCount': occurrenceCount,
    'firstSeen': firstSeen.toIso8601String(),
    'lastSeen': lastSeen.toIso8601String(),
    'dreamIds': dreamIds,
    'evolutionNote': evolutionNote,
    'significance': significance,
  };

  factory RecurringPattern.fromJson(Map<String, dynamic> json) =>
      RecurringPattern(
        id: json['id'],
        patternType: json['patternType'],
        patternValue: json['patternValue'],
        occurrenceCount: json['occurrenceCount'],
        firstSeen: DateTime.parse(json['firstSeen']),
        lastSeen: DateTime.parse(json['lastSeen']),
        dreamIds: List<String>.from(json['dreamIds']),
        evolutionNote: json['evolutionNote'],
        significance: json['significance'] ?? 0.5,
      );
}

/// Dream series - connected dreams over time
class DreamSeries {
  final String id;
  final String title;
  final String? description;
  final List<String> dreamIds;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final List<String> commonSymbols;
  final List<String> commonThemes;
  final String? storyArc;
  final String? resolution;

  const DreamSeries({
    required this.id,
    required this.title,
    this.description,
    required this.dreamIds,
    required this.startDate,
    this.endDate,
    this.isActive = true,
    this.commonSymbols = const [],
    this.commonThemes = const [],
    this.storyArc,
    this.resolution,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dreamIds': dreamIds,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'isActive': isActive,
    'commonSymbols': commonSymbols,
    'commonThemes': commonThemes,
    'storyArc': storyArc,
    'resolution': resolution,
  };

  factory DreamSeries.fromJson(Map<String, dynamic> json) => DreamSeries(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dreamIds: List<String>.from(json['dreamIds']),
    startDate: DateTime.parse(json['startDate']),
    endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    isActive: json['isActive'] ?? true,
    commonSymbols: List<String>.from(json['commonSymbols'] ?? []),
    commonThemes: List<String>.from(json['commonThemes'] ?? []),
    storyArc: json['storyArc'],
    resolution: json['resolution'],
  );
}

/// Weekly/Monthly dream insights
class DreamInsights {
  final String period; // 'weekly', 'monthly'
  final DateTime startDate;
  final DateTime endDate;
  final int totalDreams;
  final int lucidCount;
  final int nightmareCount;
  final int recurringCount;
  final List<String> topSymbols;
  final Map<EmotionalTone, int> emotionDistribution;
  final double averageIntensity;
  final String dominantTheme;
  final String insightMessage;
  final List<String> recommendations;
  final String? shadowWorkProgress;
  final String? archetypeJourney;
  final Map<MoonPhase, int> moonPhaseDistribution;

  const DreamInsights({
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.totalDreams,
    this.lucidCount = 0,
    this.nightmareCount = 0,
    this.recurringCount = 0,
    this.topSymbols = const [],
    this.emotionDistribution = const {},
    this.averageIntensity = 5.0,
    this.dominantTheme = '',
    required this.insightMessage,
    this.recommendations = const [],
    this.shadowWorkProgress,
    this.archetypeJourney,
    this.moonPhaseDistribution = const {},
  });

  Map<String, dynamic> toJson() => {
    'period': period,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'totalDreams': totalDreams,
    'lucidCount': lucidCount,
    'nightmareCount': nightmareCount,
    'recurringCount': recurringCount,
    'topSymbols': topSymbols,
    'emotionDistribution': emotionDistribution.map(
      (k, v) => MapEntry(k.name, v),
    ),
    'averageIntensity': averageIntensity,
    'dominantTheme': dominantTheme,
    'insightMessage': insightMessage,
    'recommendations': recommendations,
    'shadowWorkProgress': shadowWorkProgress,
    'archetypeJourney': archetypeJourney,
    'moonPhaseDistribution': moonPhaseDistribution.map(
      (k, v) => MapEntry(k.name, v),
    ),
  };
}

/// Dream statistics
class DreamStatistics {
  final int totalDreams;
  final int totalDaysRecording;
  final double dreamsPerWeek;
  final double dreamsPerMonth;
  final int longestStreak;
  final int currentStreak;
  final Map<String, int> symbolFrequency;
  final Map<EmotionalTone, int> emotionDistribution;
  final double lucidPercentage;
  final double nightmarePercentage;
  final double recurringPercentage;
  final Map<MoonPhase, int> moonPhaseDistribution;
  final Map<String, int> weekdayDistribution;
  final double averageClarity;
  final double averageIntensity;
  final String? bestMoonPhaseForLucid;
  final String? mostCommonWakeTime;
  final List<String> topLocations;
  final List<String> topCharacters;

  const DreamStatistics({
    required this.totalDreams,
    required this.totalDaysRecording,
    required this.dreamsPerWeek,
    required this.dreamsPerMonth,
    required this.longestStreak,
    required this.currentStreak,
    required this.symbolFrequency,
    required this.emotionDistribution,
    required this.lucidPercentage,
    required this.nightmarePercentage,
    required this.recurringPercentage,
    required this.moonPhaseDistribution,
    required this.weekdayDistribution,
    required this.averageClarity,
    required this.averageIntensity,
    this.bestMoonPhaseForLucid,
    this.mostCommonWakeTime,
    this.topLocations = const [],
    this.topCharacters = const [],
  });

  Map<String, dynamic> toJson() => {
    'totalDreams': totalDreams,
    'totalDaysRecording': totalDaysRecording,
    'dreamsPerWeek': dreamsPerWeek,
    'dreamsPerMonth': dreamsPerMonth,
    'longestStreak': longestStreak,
    'currentStreak': currentStreak,
    'symbolFrequency': symbolFrequency,
    'emotionDistribution': emotionDistribution.map(
      (k, v) => MapEntry(k.name, v),
    ),
    'lucidPercentage': lucidPercentage,
    'nightmarePercentage': nightmarePercentage,
    'recurringPercentage': recurringPercentage,
    'moonPhaseDistribution': moonPhaseDistribution.map(
      (k, v) => MapEntry(k.name, v),
    ),
    'weekdayDistribution': weekdayDistribution,
    'averageClarity': averageClarity,
    'averageIntensity': averageIntensity,
    'bestMoonPhaseForLucid': bestMoonPhaseForLucid,
    'mostCommonWakeTime': mostCommonWakeTime,
    'topLocations': topLocations,
    'topCharacters': topCharacters,
  };
}

/// Personal dream dictionary entry
class PersonalSymbolEntry {
  final String symbol;
  final String personalMeaning;
  final List<String> associatedEmotions;
  final List<String> associatedDreamIds;
  final DateTime firstAppeared;
  final DateTime lastAppeared;
  final int occurrenceCount;
  final String? evolutionNote;
  final bool isShadowSymbol;
  final bool isHealingSymbol;

  const PersonalSymbolEntry({
    required this.symbol,
    required this.personalMeaning,
    this.associatedEmotions = const [],
    this.associatedDreamIds = const [],
    required this.firstAppeared,
    required this.lastAppeared,
    this.occurrenceCount = 1,
    this.evolutionNote,
    this.isShadowSymbol = false,
    this.isHealingSymbol = false,
  });

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'personalMeaning': personalMeaning,
    'associatedEmotions': associatedEmotions,
    'associatedDreamIds': associatedDreamIds,
    'firstAppeared': firstAppeared.toIso8601String(),
    'lastAppeared': lastAppeared.toIso8601String(),
    'occurrenceCount': occurrenceCount,
    'evolutionNote': evolutionNote,
    'isShadowSymbol': isShadowSymbol,
    'isHealingSymbol': isHealingSymbol,
  };

  factory PersonalSymbolEntry.fromJson(Map<String, dynamic> json) =>
      PersonalSymbolEntry(
        symbol: json['symbol'],
        personalMeaning: json['personalMeaning'],
        associatedEmotions: List<String>.from(json['associatedEmotions'] ?? []),
        associatedDreamIds: List<String>.from(json['associatedDreamIds'] ?? []),
        firstAppeared: DateTime.parse(json['firstAppeared']),
        lastAppeared: DateTime.parse(json['lastAppeared']),
        occurrenceCount: json['occurrenceCount'] ?? 1,
        evolutionNote: json['evolutionNote'],
        isShadowSymbol: json['isShadowSymbol'] ?? false,
        isHealingSymbol: json['isHealingSymbol'] ?? false,
      );
}

/// Export data for PDF/Timeline
class DreamJournalExport {
  final List<DreamEntry> dreams;
  final DreamStatistics statistics;
  final List<RecurringPattern> patterns;
  final Map<String, PersonalSymbolEntry> personalDictionary;
  final List<DreamSeries> dreamSeries;
  final DateTime exportDate;
  final String? userNotes;

  const DreamJournalExport({
    required this.dreams,
    required this.statistics,
    required this.patterns,
    required this.personalDictionary,
    required this.dreamSeries,
    required this.exportDate,
    this.userNotes,
  });

  Map<String, dynamic> toJson() => {
    'dreams': dreams.map((d) => d.toJson()).toList(),
    'statistics': statistics.toJson(),
    'patterns': patterns.map((p) => p.toJson()).toList(),
    'personalDictionary': personalDictionary.map(
      (k, v) => MapEntry(k, v.toJson()),
    ),
    'dreamSeries': dreamSeries.map((s) => s.toJson()).toList(),
    'exportDate': exportDate.toIso8601String(),
    'userNotes': userNotes,
  };
}

// ════════════════════════════════════════════════════════════════
// DREAM JOURNAL SERVICE
// ════════════════════════════════════════════════════════════════

/// Comprehensive dream journal and pattern analysis service
class DreamJournalService {
  static const String _dreamsKey = 'dream_journal_entries';
  static const String _patternsKey = 'dream_journal_patterns';
  static const String _seriesKey = 'dream_journal_series';
  static const String _dictionaryKey = 'dream_personal_dictionary';
  static const String _statsKey = 'dream_journal_stats';

  final SharedPreferences _prefs;
  final DreamMemoryService? _memoryService;

  DreamJournalService(this._prefs, {DreamMemoryService? memoryService})
    : _memoryService = memoryService;

  /// Initialize service with SharedPreferences
  static Future<DreamJournalService> init({
    DreamMemoryService? memoryService,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return DreamJournalService(prefs, memoryService: memoryService);
  }

  // ═══════════════════════════════════════════════════════════════
  // CRUD OPERATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Save a new dream entry
  Future<DreamEntry> saveDream(DreamEntry entry) async {
    final dreams = await getAllDreams();

    // Check if updating existing
    final existingIndex = dreams.indexWhere((d) => d.id == entry.id);
    if (existingIndex >= 0) {
      dreams[existingIndex] = entry;
    } else {
      dreams.insert(0, entry); // Add newest first
    }

    await _saveDreams(dreams);

    // Update patterns
    await _updatePatternsFromDream(entry);

    // Update personal dictionary
    await _updateDictionaryFromDream(entry);

    return entry;
  }

  /// Get a specific dream by ID
  Future<DreamEntry?> getDream(String id) async {
    final dreams = await getAllDreams();
    try {
      return dreams.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all dreams
  Future<List<DreamEntry>> getAllDreams() async {
    final dreamsJson = _prefs.getString(_dreamsKey);
    if (dreamsJson == null) return [];

    final List<dynamic> decoded = jsonDecode(dreamsJson);
    return decoded.map((d) => DreamEntry.fromJson(d)).toList();
  }

  /// Get dreams for a specific date range
  Future<List<DreamEntry>> getDreamsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final dreams = await getAllDreams();
    return dreams.where((d) {
      return d.dreamDate.isAfter(start.subtract(const Duration(days: 1))) &&
          d.dreamDate.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  /// Get recent dreams (last N days)
  Future<List<DreamEntry>> getRecentDreams({int days = 7}) async {
    final dreams = await getAllDreams();
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return dreams.where((d) => d.dreamDate.isAfter(cutoff)).toList();
  }

  /// Update existing dream
  Future<void> updateDream(DreamEntry dream) async {
    await saveDream(dream);
  }

  /// Delete a dream
  Future<void> deleteDream(String id) async {
    final dreams = await getAllDreams();
    dreams.removeWhere((d) => d.id == id);
    await _saveDreams(dreams);
  }

  Future<void> _saveDreams(List<DreamEntry> dreams) async {
    await _prefs.setString(
      _dreamsKey,
      jsonEncode(dreams.map((d) => d.toJson()).toList()),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // ANALYSIS - SYMBOL FREQUENCY
  // ═══════════════════════════════════════════════════════════════

  /// Get symbol frequency across all dreams
  Map<String, int> getSymbolFrequency(List<DreamEntry> dreams) {
    final frequency = <String, int>{};
    for (final dream in dreams) {
      for (final symbol in dream.detectedSymbols) {
        frequency[symbol] = (frequency[symbol] ?? 0) + 1;
      }
      for (final tag in dream.userTags) {
        frequency[tag] = (frequency[tag] ?? 0) + 1;
      }
    }
    // Sort by frequency
    final sorted = frequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }

  /// Get top N symbols
  Future<List<MapEntry<String, int>>> getTopSymbols({int limit = 10}) async {
    final dreams = await getAllDreams();
    final frequency = getSymbolFrequency(dreams);
    return frequency.entries.take(limit).toList();
  }

  // ═══════════════════════════════════════════════════════════════
  // ANALYSIS - EMOTION DISTRIBUTION
  // ═══════════════════════════════════════════════════════════════

  /// Get emotion distribution across dreams
  Map<EmotionalTone, int> getEmotionDistribution(List<DreamEntry> dreams) {
    final distribution = <EmotionalTone, int>{};
    for (final dream in dreams) {
      distribution[dream.dominantEmotion] =
          (distribution[dream.dominantEmotion] ?? 0) + 1;
    }
    // Sort by count
    final sorted = distribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted);
  }

  /// Get emotion trend over time
  Future<List<MapEntry<DateTime, EmotionalTone>>> getEmotionTrend({
    int days = 30,
  }) async {
    final dreams = await getRecentDreams(days: days);
    dreams.sort((a, b) => a.dreamDate.compareTo(b.dreamDate));
    return dreams.map((d) => MapEntry(d.dreamDate, d.dominantEmotion)).toList();
  }

  // ═══════════════════════════════════════════════════════════════
  // PATTERN DETECTION
  // ═══════════════════════════════════════════════════════════════

  /// Detect recurring patterns in dreams
  List<RecurringPattern> detectRecurringPatterns(List<DreamEntry> dreams) {
    final patterns = <RecurringPattern>[];
    final uuid = const Uuid();

    // Symbol patterns
    final symbolCounts = <String, List<DreamEntry>>{};
    for (final dream in dreams) {
      for (final symbol in dream.detectedSymbols) {
        symbolCounts.putIfAbsent(symbol, () => []).add(dream);
      }
    }
    for (final entry in symbolCounts.entries) {
      if (entry.value.length >= 3) {
        patterns.add(
          RecurringPattern(
            id: uuid.v4(),
            patternType: 'symbol',
            patternValue: entry.key,
            occurrenceCount: entry.value.length,
            firstSeen: entry.value.last.dreamDate,
            lastSeen: entry.value.first.dreamDate,
            dreamIds: entry.value.map((d) => d.id).toList(),
            significance: _calculateSignificance(
              entry.value.length,
              dreams.length,
            ),
          ),
        );
      }
    }

    // Emotion patterns
    final emotionCounts = <EmotionalTone, List<DreamEntry>>{};
    for (final dream in dreams) {
      emotionCounts.putIfAbsent(dream.dominantEmotion, () => []).add(dream);
    }
    for (final entry in emotionCounts.entries) {
      if (entry.value.length >= 3) {
        patterns.add(
          RecurringPattern(
            id: uuid.v4(),
            patternType: 'emotion',
            patternValue: entry.key.label,
            occurrenceCount: entry.value.length,
            firstSeen: entry.value.last.dreamDate,
            lastSeen: entry.value.first.dreamDate,
            dreamIds: entry.value.map((d) => d.id).toList(),
            significance: _calculateSignificance(
              entry.value.length,
              dreams.length,
            ),
          ),
        );
      }
    }

    // Location patterns
    final locationCounts = <String, List<DreamEntry>>{};
    for (final dream in dreams) {
      if (dream.locations != null) {
        for (final location in dream.locations!) {
          locationCounts.putIfAbsent(location, () => []).add(dream);
        }
      }
    }
    for (final entry in locationCounts.entries) {
      if (entry.value.length >= 2) {
        patterns.add(
          RecurringPattern(
            id: uuid.v4(),
            patternType: 'location',
            patternValue: entry.key,
            occurrenceCount: entry.value.length,
            firstSeen: entry.value.last.dreamDate,
            lastSeen: entry.value.first.dreamDate,
            dreamIds: entry.value.map((d) => d.id).toList(),
            significance: _calculateSignificance(
              entry.value.length,
              dreams.length,
            ),
          ),
        );
      }
    }

    // Character patterns
    final characterCounts = <String, List<DreamEntry>>{};
    for (final dream in dreams) {
      if (dream.characters != null) {
        for (final character in dream.characters!) {
          characterCounts.putIfAbsent(character, () => []).add(dream);
        }
      }
    }
    for (final entry in characterCounts.entries) {
      if (entry.value.length >= 2) {
        patterns.add(
          RecurringPattern(
            id: uuid.v4(),
            patternType: 'character',
            patternValue: entry.key,
            occurrenceCount: entry.value.length,
            firstSeen: entry.value.last.dreamDate,
            lastSeen: entry.value.first.dreamDate,
            dreamIds: entry.value.map((d) => d.id).toList(),
            significance: _calculateSignificance(
              entry.value.length,
              dreams.length,
            ),
          ),
        );
      }
    }

    // Sort by significance
    patterns.sort((a, b) => b.significance.compareTo(a.significance));
    return patterns;
  }

  double _calculateSignificance(int count, int total) {
    if (total == 0) return 0.0;
    final frequency = count / total;
    // Log scale for more natural significance
    return (log(count + 1) / log(10)) * frequency;
  }

  /// Detect recurring dreams (same dream appearing multiple times)
  Future<List<DreamEntry>> detectRecurringDreams() async {
    final dreams = await getAllDreams();
    return dreams.where((d) => d.isRecurring).toList();
  }

  /// Update patterns database
  Future<void> _updatePatternsFromDream(DreamEntry dream) async {
    final patterns = await getStoredPatterns();

    // Update symbol patterns
    for (final symbol in dream.detectedSymbols) {
      final existingIndex = patterns.indexWhere(
        (p) => p.patternType == 'symbol' && p.patternValue == symbol,
      );

      if (existingIndex >= 0) {
        final existing = patterns[existingIndex];
        final updatedDreamIds = [...existing.dreamIds];
        if (!updatedDreamIds.contains(dream.id)) {
          updatedDreamIds.add(dream.id);
        }
        patterns[existingIndex] = RecurringPattern(
          id: existing.id,
          patternType: existing.patternType,
          patternValue: existing.patternValue,
          occurrenceCount: updatedDreamIds.length,
          firstSeen: existing.firstSeen,
          lastSeen: dream.dreamDate,
          dreamIds: updatedDreamIds,
          significance: _calculateSignificance(updatedDreamIds.length, 100),
        );
      } else {
        patterns.add(
          RecurringPattern(
            id: const Uuid().v4(),
            patternType: 'symbol',
            patternValue: symbol,
            occurrenceCount: 1,
            firstSeen: dream.dreamDate,
            lastSeen: dream.dreamDate,
            dreamIds: [dream.id],
            significance: 0.1,
          ),
        );
      }
    }

    await _savePatterns(patterns);
  }

  Future<List<RecurringPattern>> getStoredPatterns() async {
    final patternsJson = _prefs.getString(_patternsKey);
    if (patternsJson == null) return [];
    final List<dynamic> decoded = jsonDecode(patternsJson);
    return decoded.map((p) => RecurringPattern.fromJson(p)).toList();
  }

  Future<void> _savePatterns(List<RecurringPattern> patterns) async {
    await _prefs.setString(
      _patternsKey,
      jsonEncode(patterns.map((p) => p.toJson()).toList()),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // INSIGHT GENERATION
  // ═══════════════════════════════════════════════════════════════

  /// Generate weekly dream insights
  DreamInsights generateWeeklyInsights(List<DreamEntry> dreams) {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final weekDreams = dreams
        .where((d) => d.dreamDate.isAfter(weekAgo))
        .toList();

    return _generateInsights(weekDreams, 'weekly', weekAgo, now);
  }

  /// Generate monthly dream insights
  DreamInsights generateMonthlyInsights(List<DreamEntry> dreams) {
    final now = DateTime.now();
    final monthAgo = now.subtract(const Duration(days: 30));
    final monthDreams = dreams
        .where((d) => d.dreamDate.isAfter(monthAgo))
        .toList();

    return _generateInsights(monthDreams, 'monthly', monthAgo, now);
  }

  DreamInsights _generateInsights(
    List<DreamEntry> dreams,
    String period,
    DateTime start,
    DateTime end,
  ) {
    final emotionDist = getEmotionDistribution(dreams);
    final symbolFreq = getSymbolFrequency(dreams);
    final moonPhaseDist = _getMoonPhaseDistribution(dreams);

    final lucidCount = dreams.where((d) => d.isLucid).length;
    final nightmareCount = dreams.where((d) => d.isNightmare).length;
    final recurringCount = dreams.where((d) => d.isRecurring).length;

    final avgIntensity = dreams.isEmpty
        ? 5.0
        : dreams.map((d) => d.emotionalIntensity).reduce((a, b) => a + b) /
              dreams.length;

    final topSymbols = symbolFreq.entries.take(5).map((e) => e.key).toList();
    final dominantTheme = _detectDominantTheme(dreams);

    final insightMessage = _generateInsightMessage(
      dreams.length,
      emotionDist,
      topSymbols,
      lucidCount,
      nightmareCount,
      period,
    );

    final recommendations = _generateRecommendations(
      emotionDist,
      nightmareCount,
      lucidCount,
      dreams.length,
    );

    final shadowProgress = _assessShadowWorkProgress(dreams);
    final archetypeJourney = _assessArchetypeJourney(dreams);

    return DreamInsights(
      period: period,
      startDate: start,
      endDate: end,
      totalDreams: dreams.length,
      lucidCount: lucidCount,
      nightmareCount: nightmareCount,
      recurringCount: recurringCount,
      topSymbols: topSymbols,
      emotionDistribution: emotionDist,
      averageIntensity: avgIntensity,
      dominantTheme: dominantTheme,
      insightMessage: insightMessage,
      recommendations: recommendations,
      shadowWorkProgress: shadowProgress,
      archetypeJourney: archetypeJourney,
      moonPhaseDistribution: moonPhaseDist,
    );
  }

  String _generateInsightMessage(
    int count,
    Map<EmotionalTone, int> emotions,
    List<String> topSymbols,
    int lucidCount,
    int nightmareCount,
    String period,
  ) {
    if (count == 0) {
      return period == 'weekly'
          ? 'Bu hafta henuz ruya kaydetmedin. Bilincaltinin sesini dinlemeye hazir misin?'
          : 'Bu ay ruya kaydettikce, oruntuleri kesfedecekim.';
    }

    final dominantEmotion = emotions.entries.isNotEmpty
        ? emotions.entries.first.key
        : EmotionalTone.merak;

    final symbolNote = topSymbols.isNotEmpty
        ? '"${topSymbols.first}" sembolu ruyalarinda sik beliriyor.'
        : '';

    final lucidNote = lucidCount > 0
        ? ' $lucidCount lucid ruya deneyimledin - farkindalik gelisiyor!'
        : '';

    final nightmareNote = nightmareCount > 0
        ? ' $nightmareCount kabus, golge entegrasyonu icin firsat sunuyor.'
        : '';

    return '$count ruya kaydettin. Dominant duygu: ${dominantEmotion.label}. '
        '$symbolNote$lucidNote$nightmareNote';
  }

  List<String> _generateRecommendations(
    Map<EmotionalTone, int> emotions,
    int nightmareCount,
    int lucidCount,
    int totalDreams,
  ) {
    final recommendations = <String>[];

    if (totalDreams < 3) {
      recommendations.add('Her gun ruya gunlugu tutarak oruntuleri kesfet.');
    }

    if (nightmareCount > 2) {
      recommendations.add('Kabuslarla calisma: Lucid teknikleriyle donustur.');
      recommendations.add('Uyku oncesi rahatlama ritueli olustur.');
    }

    if (lucidCount == 0 && totalDreams >= 7) {
      recommendations.add(
        'Reality check teknigini dene - lucid ruya potansiyelin var.',
      );
    }

    if (emotions.isNotEmpty) {
      final dominant = emotions.entries.first.key;
      if (dominant == EmotionalTone.korku) {
        recommendations.add(
          'Korku temasini incele - golge calismasi yapabilirsin.',
        );
      } else if (dominant == EmotionalTone.ozlem) {
        recommendations.add('Ozlem duygusu uzerine yansitma gunlugu tut.');
      }
    }

    if (recommendations.isEmpty) {
      recommendations.add(
        'Ruya yolculugun harika gidiyor. Kaydetmeye devam et!',
      );
    }

    return recommendations;
  }

  String _detectDominantTheme(List<DreamEntry> dreams) {
    if (dreams.isEmpty) return 'Belirsiz';

    final themeCounts = <String, int>{};
    for (final dream in dreams) {
      if (dream.isLucid) {
        themeCounts['Farkindalik'] = (themeCounts['Farkindalik'] ?? 0) + 1;
      }
      if (dream.isNightmare) {
        themeCounts['Golge Calismasi'] =
            (themeCounts['Golge Calismasi'] ?? 0) + 1;
      }
      if (dream.isRecurring) {
        themeCounts['Tekrarlayan Kalip'] =
            (themeCounts['Tekrarlayan Kalip'] ?? 0) + 1;
      }
      if (dream.userRole == DreamRole.kahraman) {
        themeCounts['Kahraman Yolculugu'] =
            (themeCounts['Kahraman Yolculugu'] ?? 0) + 1;
      }
      if (dream.userRole == DreamRole.arayan) {
        themeCounts['Arayis'] = (themeCounts['Arayis'] ?? 0) + 1;
      }
    }

    if (themeCounts.isEmpty) return 'Kesfediliyor';

    final sorted = themeCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }

  String _assessShadowWorkProgress(List<DreamEntry> dreams) {
    final nightmares = dreams.where((d) => d.isNightmare).toList();
    if (nightmares.isEmpty) return 'Golge henuz belirgin degil.';

    final recentNightmares = nightmares.where((d) {
      return d.dreamDate.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).length;

    final olderNightmares = nightmares.where((d) {
      return d.dreamDate.isBefore(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).length;

    if (recentNightmares < olderNightmares) {
      return 'Golge entegrasyonu ilerliyor - kabuslar azaliyor.';
    } else if (recentNightmares > 0) {
      return 'Aktif golge calismasi donemi - kabuslarla yuzlesme zamani.';
    }
    return 'Golge sakin, entegrasyon suruyor.';
  }

  String _assessArchetypeJourney(List<DreamEntry> dreams) {
    final roleCounts = <DreamRole, int>{};
    for (final dream in dreams) {
      if (dream.userRole != null) {
        roleCounts[dream.userRole!] = (roleCounts[dream.userRole!] ?? 0) + 1;
      }
    }

    if (roleCounts.isEmpty) return 'Arketip yolculugu basliyor.';

    final sorted = roleCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final dominant = sorted.first.key;

    switch (dominant) {
      case DreamRole.kahraman:
        return 'Kahraman arketipi aktif - cesaretle ilerle!';
      case DreamRole.arayan:
        return 'Arayici arketipi - icsel bir yolculuktasin.';
      case DreamRole.kurtarici:
        return 'Kurtarici arketipi - baskalarini destekliyorsun.';
      case DreamRole.izleyici:
        return 'Gozlemci arketipi - farkindalik gelistiriyorsun.';
      case DreamRole.kacan:
        return 'Kacis temasi - neyle yuzlesmekten kaciniyorsun?';
      default:
        return 'Arketip yolculugun evrim geçiriyor.';
    }
  }

  Map<MoonPhase, int> _getMoonPhaseDistribution(List<DreamEntry> dreams) {
    final distribution = <MoonPhase, int>{};
    for (final dream in dreams) {
      distribution[dream.moonPhase] = (distribution[dream.moonPhase] ?? 0) + 1;
    }
    return distribution;
  }

  // ═══════════════════════════════════════════════════════════════
  // DREAM SERIES DETECTION
  // ═══════════════════════════════════════════════════════════════

  /// Detect connected dreams / story arcs
  Future<List<DreamSeries>> detectDreamSeries() async {
    final dreams = await getAllDreams();
    final series = <DreamSeries>[];
    final uuid = const Uuid();

    // Group by common symbols appearing in at least 3 consecutive dreams
    for (var i = 0; i < dreams.length - 2; i++) {
      final dream1 = dreams[i];
      final dream2 = dreams[i + 1];
      final dream3 = dreams[i + 2];

      final common = dream1.detectedSymbols
          .toSet()
          .intersection(dream2.detectedSymbols.toSet())
          .intersection(dream3.detectedSymbols.toSet());

      if (common.isNotEmpty) {
        series.add(
          DreamSeries(
            id: uuid.v4(),
            title: 'Seri: ${common.first}',
            dreamIds: [dream1.id, dream2.id, dream3.id],
            startDate: dream3.dreamDate,
            commonSymbols: common.toList(),
            storyArc: _detectStoryArc([dream1, dream2, dream3]),
          ),
        );
      }
    }

    return series;
  }

  String _detectStoryArc(List<DreamEntry> dreams) {
    if (dreams.length < 2) return 'Tek bolum';

    final intensities = dreams.map((d) => d.emotionalIntensity).toList();
    final avgFirst =
        intensities.take(dreams.length ~/ 2).reduce((a, b) => a + b) /
        (dreams.length ~/ 2);
    final avgSecond =
        intensities.skip(dreams.length ~/ 2).reduce((a, b) => a + b) /
        (dreams.length - dreams.length ~/ 2);

    if (avgSecond > avgFirst) {
      return 'Yukselen ark - yogunluk artiyor';
    } else if (avgSecond < avgFirst) {
      return 'Cozum arki - rahatlama geliyor';
    }
    return 'Duz ark - sabit enerji';
  }

  /// Find similar dreams to a given dream
  List<DreamEntry> findSimilarDreams(
    DreamEntry dream,
    List<DreamEntry> allDreams,
  ) {
    final similar = <DreamEntry>[];
    final targetSymbols = dream.detectedSymbols.toSet();
    final targetEmotion = dream.dominantEmotion;

    for (final other in allDreams) {
      if (other.id == dream.id) continue;

      final otherSymbols = other.detectedSymbols.toSet();
      final commonSymbols = targetSymbols.intersection(otherSymbols);

      // Similarity score
      int score = 0;
      score += commonSymbols.length * 2;
      if (other.dominantEmotion == targetEmotion) score += 3;
      if (other.isNightmare == dream.isNightmare) score += 1;
      if (other.isLucid == dream.isLucid) score += 1;
      if (other.userRole == dream.userRole) score += 2;

      if (score >= 3) {
        similar.add(other);
      }
    }

    // Sort by similarity (could add actual score to model)
    return similar;
  }

  // ═══════════════════════════════════════════════════════════════
  // CORRELATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Group dreams by moon phase
  Map<MoonPhase, List<DreamEntry>> groupByMoonPhase(List<DreamEntry> dreams) {
    final grouped = <MoonPhase, List<DreamEntry>>{};
    for (final phase in MoonPhase.values) {
      grouped[phase] = [];
    }
    for (final dream in dreams) {
      grouped[dream.moonPhase]!.add(dream);
    }
    return grouped;
  }

  /// Get best moon phase for lucid dreams
  Future<MoonPhase?> getBestMoonPhaseForLucid() async {
    final dreams = await getAllDreams();
    final lucidByPhase = <MoonPhase, int>{};

    for (final dream in dreams) {
      if (dream.isLucid) {
        lucidByPhase[dream.moonPhase] =
            (lucidByPhase[dream.moonPhase] ?? 0) + 1;
      }
    }

    if (lucidByPhase.isEmpty) return null;

    final sorted = lucidByPhase.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }

  /// Correlate dreams with life situations
  Future<Map<String, List<DreamEntry>>> groupByLifeSituation() async {
    final dreams = await getAllDreams();
    final grouped = <String, List<DreamEntry>>{};

    for (final dream in dreams) {
      if (dream.lifeSituation != null && dream.lifeSituation!.isNotEmpty) {
        grouped.putIfAbsent(dream.lifeSituation!, () => []).add(dream);
      }
    }

    return grouped;
  }

  // ═══════════════════════════════════════════════════════════════
  // STATISTICS
  // ═══════════════════════════════════════════════════════════════

  /// Calculate comprehensive dream statistics
  Future<DreamStatistics> calculateStatistics(List<DreamEntry> dreams) async {
    if (dreams.isEmpty) {
      return const DreamStatistics(
        totalDreams: 0,
        totalDaysRecording: 0,
        dreamsPerWeek: 0,
        dreamsPerMonth: 0,
        longestStreak: 0,
        currentStreak: 0,
        symbolFrequency: {},
        emotionDistribution: {},
        lucidPercentage: 0,
        nightmarePercentage: 0,
        recurringPercentage: 0,
        moonPhaseDistribution: {},
        weekdayDistribution: {},
        averageClarity: 0,
        averageIntensity: 0,
      );
    }

    // Sort by date
    final sorted = List<DreamEntry>.from(dreams)
      ..sort((a, b) => a.dreamDate.compareTo(b.dreamDate));

    final firstDate = sorted.first.dreamDate;
    final lastDate = sorted.last.dreamDate;
    final totalDays = lastDate.difference(firstDate).inDays + 1;

    // Calculate streaks
    final streaks = _calculateStreaks(sorted);

    // Weekday distribution
    final weekdays = <String, int>{
      'Pazartesi': 0,
      'Sali': 0,
      'Carsamba': 0,
      'Persembe': 0,
      'Cuma': 0,
      'Cumartesi': 0,
      'Pazar': 0,
    };
    for (final dream in dreams) {
      final dayIndex = dream.dreamDate.weekday;
      final dayName = [
        'Pazartesi',
        'Sali',
        'Carsamba',
        'Persembe',
        'Cuma',
        'Cumartesi',
        'Pazar',
      ][dayIndex - 1];
      weekdays[dayName] = weekdays[dayName]! + 1;
    }

    // Averages
    final clarityValues = dreams
        .where((d) => d.clarity != null)
        .map((d) => d.clarity!);
    final avgClarity = clarityValues.isEmpty
        ? 0.0
        : clarityValues.reduce((a, b) => a + b) / clarityValues.length;

    final avgIntensity =
        dreams.map((d) => d.emotionalIntensity).reduce((a, b) => a + b) /
        dreams.length;

    // Locations and characters
    final allLocations = <String, int>{};
    final allCharacters = <String, int>{};
    for (final dream in dreams) {
      if (dream.locations != null) {
        for (final loc in dream.locations!) {
          allLocations[loc] = (allLocations[loc] ?? 0) + 1;
        }
      }
      if (dream.characters != null) {
        for (final char in dream.characters!) {
          allCharacters[char] = (allCharacters[char] ?? 0) + 1;
        }
      }
    }

    final topLocs = allLocations.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topChars = allCharacters.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Best moon phase for lucid
    final lucidByPhase = <MoonPhase, int>{};
    for (final dream in dreams.where((d) => d.isLucid)) {
      lucidByPhase[dream.moonPhase] = (lucidByPhase[dream.moonPhase] ?? 0) + 1;
    }
    String? bestPhase;
    if (lucidByPhase.isNotEmpty) {
      final sorted = lucidByPhase.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      bestPhase = sorted.first.key.label;
    }

    // Most common wake time
    final wakeTimes = <int, int>{};
    for (final dream in dreams) {
      if (dream.wakeTime != null) {
        wakeTimes[dream.wakeTime!.hour] =
            (wakeTimes[dream.wakeTime!.hour] ?? 0) + 1;
      }
    }
    String? commonWake;
    if (wakeTimes.isNotEmpty) {
      final sorted = wakeTimes.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      commonWake = '${sorted.first.key}:00';
    }

    return DreamStatistics(
      totalDreams: dreams.length,
      totalDaysRecording: totalDays,
      dreamsPerWeek: (dreams.length / (totalDays / 7)).clamp(0, 7),
      dreamsPerMonth: (dreams.length / (totalDays / 30)).clamp(0, 30),
      longestStreak: streaks['longest']!,
      currentStreak: streaks['current']!,
      symbolFrequency: getSymbolFrequency(dreams),
      emotionDistribution: getEmotionDistribution(dreams),
      lucidPercentage:
          (dreams.where((d) => d.isLucid).length / dreams.length) * 100,
      nightmarePercentage:
          (dreams.where((d) => d.isNightmare).length / dreams.length) * 100,
      recurringPercentage:
          (dreams.where((d) => d.isRecurring).length / dreams.length) * 100,
      moonPhaseDistribution: _getMoonPhaseDistribution(dreams),
      weekdayDistribution: weekdays,
      averageClarity: avgClarity,
      averageIntensity: avgIntensity,
      bestMoonPhaseForLucid: bestPhase,
      mostCommonWakeTime: commonWake,
      topLocations: topLocs.take(5).map((e) => e.key).toList(),
      topCharacters: topChars.take(5).map((e) => e.key).toList(),
    );
  }

  Map<String, int> _calculateStreaks(List<DreamEntry> sortedDreams) {
    if (sortedDreams.isEmpty) return {'longest': 0, 'current': 0};

    int currentStreak = 1;
    int longestStreak = 1;
    int tempStreak = 1;

    for (int i = 1; i < sortedDreams.length; i++) {
      final diff = sortedDreams[i].dreamDate
          .difference(sortedDreams[i - 1].dreamDate)
          .inDays;
      if (diff <= 1) {
        tempStreak++;
        if (tempStreak > longestStreak) longestStreak = tempStreak;
      } else {
        tempStreak = 1;
      }
    }

    // Calculate current streak from today
    final today = DateTime.now();
    for (int i = sortedDreams.length - 1; i >= 0; i--) {
      final diff = today.difference(sortedDreams[i].dreamDate).inDays;
      if (diff <= 1) {
        currentStreak = sortedDreams.length - i;
        for (int j = i - 1; j >= 0; j--) {
          final innerDiff = sortedDreams[j + 1].dreamDate
              .difference(sortedDreams[j].dreamDate)
              .inDays;
          if (innerDiff <= 1) {
            currentStreak++;
          } else {
            break;
          }
        }
        break;
      }
    }

    return {'longest': longestStreak, 'current': currentStreak};
  }

  // ═══════════════════════════════════════════════════════════════
  // PERSONAL DICTIONARY
  // ═══════════════════════════════════════════════════════════════

  /// Update personal dream dictionary from new dream
  Future<void> _updateDictionaryFromDream(DreamEntry dream) async {
    final dictionary = await getPersonalDictionary();

    for (final symbol in dream.detectedSymbols) {
      if (dictionary.containsKey(symbol)) {
        final existing = dictionary[symbol]!;
        final updatedEmotions = List<String>.from(existing.associatedEmotions);
        if (!updatedEmotions.contains(dream.dominantEmotion.name)) {
          updatedEmotions.add(dream.dominantEmotion.name);
        }
        final updatedDreamIds = List<String>.from(existing.associatedDreamIds);
        if (!updatedDreamIds.contains(dream.id)) {
          updatedDreamIds.add(dream.id);
        }

        dictionary[symbol] = PersonalSymbolEntry(
          symbol: existing.symbol,
          personalMeaning: existing.personalMeaning,
          associatedEmotions: updatedEmotions,
          associatedDreamIds: updatedDreamIds,
          firstAppeared: existing.firstAppeared,
          lastAppeared: dream.dreamDate,
          occurrenceCount: existing.occurrenceCount + 1,
          evolutionNote: existing.evolutionNote,
          isShadowSymbol: dream.isNightmare || existing.isShadowSymbol,
          isHealingSymbol: existing.isHealingSymbol,
        );
      } else {
        dictionary[symbol] = PersonalSymbolEntry(
          symbol: symbol,
          personalMeaning: '',
          associatedEmotions: [dream.dominantEmotion.name],
          associatedDreamIds: [dream.id],
          firstAppeared: dream.dreamDate,
          lastAppeared: dream.dreamDate,
          occurrenceCount: 1,
          isShadowSymbol: dream.isNightmare,
        );
      }
    }

    await _saveDictionary(dictionary);
  }

  /// Get personal dream dictionary
  Future<Map<String, PersonalSymbolEntry>> getPersonalDictionary() async {
    final dictJson = _prefs.getString(_dictionaryKey);
    if (dictJson == null) return {};

    final Map<String, dynamic> decoded = jsonDecode(dictJson);
    return decoded.map(
      (key, value) => MapEntry(key, PersonalSymbolEntry.fromJson(value)),
    );
  }

  /// Update personal meaning for a symbol
  Future<void> updatePersonalMeaning(String symbol, String meaning) async {
    final dictionary = await getPersonalDictionary();
    if (dictionary.containsKey(symbol)) {
      final existing = dictionary[symbol]!;
      dictionary[symbol] = PersonalSymbolEntry(
        symbol: existing.symbol,
        personalMeaning: meaning,
        associatedEmotions: existing.associatedEmotions,
        associatedDreamIds: existing.associatedDreamIds,
        firstAppeared: existing.firstAppeared,
        lastAppeared: existing.lastAppeared,
        occurrenceCount: existing.occurrenceCount,
        evolutionNote: existing.evolutionNote,
        isShadowSymbol: existing.isShadowSymbol,
        isHealingSymbol: existing.isHealingSymbol,
      );
      await _saveDictionary(dictionary);
    }
  }

  Future<void> _saveDictionary(
    Map<String, PersonalSymbolEntry> dictionary,
  ) async {
    await _prefs.setString(
      _dictionaryKey,
      jsonEncode(dictionary.map((k, v) => MapEntry(k, v.toJson()))),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // SEARCH & FILTER
  // ═══════════════════════════════════════════════════════════════

  /// Search dreams by keyword
  Future<List<DreamEntry>> searchByKeyword(String keyword) async {
    final dreams = await getAllDreams();
    final lowercaseKeyword = keyword.toLowerCase();

    return dreams.where((d) {
      return d.title.toLowerCase().contains(lowercaseKeyword) ||
          d.content.toLowerCase().contains(lowercaseKeyword) ||
          d.detectedSymbols.any(
            (s) => s.toLowerCase().contains(lowercaseKeyword),
          ) ||
          d.userTags.any((t) => t.toLowerCase().contains(lowercaseKeyword));
    }).toList();
  }

  /// Filter by emotion
  Future<List<DreamEntry>> filterByEmotion(EmotionalTone emotion) async {
    final dreams = await getAllDreams();
    return dreams.where((d) => d.dominantEmotion == emotion).toList();
  }

  /// Filter by symbol
  Future<List<DreamEntry>> filterBySymbol(String symbol) async {
    final dreams = await getAllDreams();
    return dreams.where((d) => d.detectedSymbols.contains(symbol)).toList();
  }

  /// Filter by date range
  Future<List<DreamEntry>> filterByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return getDreamsByDateRange(start, end);
  }

  /// Filter by moon phase
  Future<List<DreamEntry>> filterByMoonPhase(MoonPhase phase) async {
    final dreams = await getAllDreams();
    return dreams.where((d) => d.moonPhase == phase).toList();
  }

  /// Filter lucid dreams only
  Future<List<DreamEntry>> getLucidDreams() async {
    final dreams = await getAllDreams();
    return dreams.where((d) => d.isLucid).toList();
  }

  /// Filter nightmares only
  Future<List<DreamEntry>> getNightmares() async {
    final dreams = await getAllDreams();
    return dreams.where((d) => d.isNightmare).toList();
  }

  /// Advanced filter with multiple criteria
  Future<List<DreamEntry>> advancedFilter({
    EmotionalTone? emotion,
    MoonPhase? moonPhase,
    String? symbol,
    bool? isLucid,
    bool? isNightmare,
    bool? isRecurring,
    DateTime? startDate,
    DateTime? endDate,
    int? minIntensity,
    int? maxIntensity,
    DreamRole? role,
    String? keyword,
  }) async {
    var dreams = await getAllDreams();

    if (emotion != null) {
      dreams = dreams.where((d) => d.dominantEmotion == emotion).toList();
    }
    if (moonPhase != null) {
      dreams = dreams.where((d) => d.moonPhase == moonPhase).toList();
    }
    if (symbol != null) {
      dreams = dreams.where((d) => d.detectedSymbols.contains(symbol)).toList();
    }
    if (isLucid != null) {
      dreams = dreams.where((d) => d.isLucid == isLucid).toList();
    }
    if (isNightmare != null) {
      dreams = dreams.where((d) => d.isNightmare == isNightmare).toList();
    }
    if (isRecurring != null) {
      dreams = dreams.where((d) => d.isRecurring == isRecurring).toList();
    }
    if (startDate != null) {
      dreams = dreams.where((d) => d.dreamDate.isAfter(startDate)).toList();
    }
    if (endDate != null) {
      dreams = dreams.where((d) => d.dreamDate.isBefore(endDate)).toList();
    }
    if (minIntensity != null) {
      dreams = dreams
          .where((d) => d.emotionalIntensity >= minIntensity)
          .toList();
    }
    if (maxIntensity != null) {
      dreams = dreams
          .where((d) => d.emotionalIntensity <= maxIntensity)
          .toList();
    }
    if (role != null) {
      dreams = dreams.where((d) => d.userRole == role).toList();
    }
    if (keyword != null && keyword.isNotEmpty) {
      final lowercaseKeyword = keyword.toLowerCase();
      dreams = dreams.where((d) {
        return d.title.toLowerCase().contains(lowercaseKeyword) ||
            d.content.toLowerCase().contains(lowercaseKeyword);
      }).toList();
    }

    return dreams;
  }

  // ═══════════════════════════════════════════════════════════════
  // EXPORT FEATURES
  // ═══════════════════════════════════════════════════════════════

  /// Generate complete export data
  Future<DreamJournalExport> generateExport({String? userNotes}) async {
    final dreams = await getAllDreams();
    final statistics = await calculateStatistics(dreams);
    final patterns = detectRecurringPatterns(dreams);
    final dictionary = await getPersonalDictionary();
    final series = await detectDreamSeries();

    return DreamJournalExport(
      dreams: dreams,
      statistics: statistics,
      patterns: patterns,
      personalDictionary: dictionary,
      dreamSeries: series,
      exportDate: DateTime.now(),
      userNotes: userNotes,
    );
  }

  /// Export as JSON string
  Future<String> exportAsJson() async {
    final export = await generateExport();
    return jsonEncode(export.toJson());
  }

  /// Generate timeline data for visualization
  Future<List<Map<String, dynamic>>> generateTimelineData() async {
    final dreams = await getAllDreams();
    return dreams
        .map(
          (d) => {
            'date': d.dreamDate.toIso8601String(),
            'title': d.title,
            'emotion': d.dominantEmotion.name,
            'intensity': d.emotionalIntensity,
            'isLucid': d.isLucid,
            'isNightmare': d.isNightmare,
            'symbols': d.detectedSymbols,
            'moonPhase': d.moonPhase.name,
          },
        )
        .toList();
  }

  /// Get symbol glossary (all unique symbols with counts)
  Future<Map<String, int>> getSymbolGlossary() async {
    final dreams = await getAllDreams();
    return getSymbolFrequency(dreams);
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Create a new dream entry with auto-detected moon phase
  DreamEntry createDreamEntry({
    required String title,
    required String content,
    required EmotionalTone emotion,
    DateTime? dreamDate,
    List<String>? symbols,
    List<String>? tags,
    int intensity = 5,
    bool isRecurring = false,
    bool isLucid = false,
    bool isNightmare = false,
    String? moonSign,
    List<String>? transits,
    DreamRole? role,
    TimeLayer? timeLayer,
    List<String>? characters,
    List<String>? locations,
    int? clarity,
    String? sleepQuality,
    Duration? sleepDuration,
    DateTime? wakeTime,
    String? lifeSituation,
  }) {
    final date = dreamDate ?? DateTime.now();
    final moonPhase = MoonPhaseCalculator.calculate(date);

    return DreamEntry(
      id: const Uuid().v4(),
      dreamDate: date,
      recordedAt: DateTime.now(),
      title: title,
      content: content,
      detectedSymbols: symbols ?? [],
      userTags: tags ?? [],
      dominantEmotion: emotion,
      emotionalIntensity: intensity,
      isRecurring: isRecurring,
      isLucid: isLucid,
      isNightmare: isNightmare,
      moonPhase: moonPhase,
      moonSign: moonSign,
      relevantTransits: transits,
      userRole: role,
      timeLayer: timeLayer,
      characters: characters,
      locations: locations,
      clarity: clarity,
      sleepQuality: sleepQuality,
      sleepDuration: sleepDuration,
      wakeTime: wakeTime,
      lifeSituation: lifeSituation,
    );
  }

  /// Auto-detect symbols from dream content
  List<String> autoDetectSymbols(String content) {
    if (_memoryService != null) {
      return _memoryService.extractSymbols(content);
    }

    // Fallback basic detection
    final symbols = <String>[];
    final text = content.toLowerCase();

    final patterns = {
      'su': ['su', 'suda', 'deniz', 'okyanus', 'gol', 'nehir', 'yagmur'],
      'yilan': ['yilan', 'kobra', 'boa'],
      'ucmak': ['ucuyordum', 'uctum', 'ucmak', 'havada'],
      'dusmek': ['dustum', 'dusuyordum', 'dusus'],
      'olum': ['olum', 'oldum', 'oldu', 'cenaze', 'mezar'],
      'ev': ['evde', 'evim', 'oda', 'daire', 'bina'],
      'bebek': ['bebek', 'cocuk', 'hamile', 'dogum'],
      'dis': ['dis', 'disler'],
      'araba': ['araba', 'arac', 'otomobil'],
      'kopek': ['kopek'],
      'kedi': ['kedi'],
      'ates': ['ates', 'yangin', 'alev'],
      'ay': ['ay', 'dolunay', 'yeniay'],
      'kacmak': ['kaciyordum', 'kactim', 'kovaliyordu'],
      'orman': ['orman', 'agaclar'],
    };

    for (final entry in patterns.entries) {
      for (final keyword in entry.value) {
        if (text.contains(keyword)) {
          if (!symbols.contains(entry.key)) {
            symbols.add(entry.key);
          }
          break;
        }
      }
    }

    return symbols;
  }

  /// Clear all dream journal data
  Future<void> clearAllData() async {
    await _prefs.remove(_dreamsKey);
    await _prefs.remove(_patternsKey);
    await _prefs.remove(_seriesKey);
    await _prefs.remove(_dictionaryKey);
    await _prefs.remove(_statsKey);
  }

  /// Get dream count
  Future<int> getDreamCount() async {
    final dreams = await getAllDreams();
    return dreams.length;
  }

  /// Check if user has logged a dream today
  Future<bool> hasLoggedDreamToday() async {
    final dreams = await getAllDreams();
    if (dreams.isEmpty) return false;

    final today = DateTime.now();
    return dreams.any(
      (d) =>
          d.dreamDate.year == today.year &&
          d.dreamDate.month == today.month &&
          d.dreamDate.day == today.day,
    );
  }
}
