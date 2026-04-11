import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dream_memory.dart';

/// Dream Memory Service - Manages dream storage, retrieval, and pattern detection
/// This is the core retention engine - creates emotional continuity between sessions
class DreamMemoryService {
  static const String _dreamsKey = 'user_dreams';
  static const String _memoryKey = 'dream_memory';
  static const String _lastDreamDateKey = 'last_dream_date';

  final SharedPreferences _prefs;

  DreamMemoryService(this._prefs);

  /// Initialize service with SharedPreferences
  static Future<DreamMemoryService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return DreamMemoryService(prefs);
  }

  // ═══════════════════════════════════════════════════════════════
  // DREAM CRUD OPERATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Save a new dream
  Future<Dream> saveDream(Dream dream) async {
    final dreams = await getAllDreams();
    dreams.insert(0, dream); // Add to beginning (newest first)

    await _prefs.setString(
      _dreamsKey,
      jsonEncode(dreams.map((d) => d.toJson()).toList()),
    );
    await _prefs.setString(
      _lastDreamDateKey,
      dream.dreamDate.toIso8601String(),
    );

    // Update memory with new symbols and patterns
    await _updateMemoryFromDream(dream);

    return dream;
  }

  /// Get all dreams
  Future<List<Dream>> getAllDreams() async {
    final dreamsJson = _prefs.getString(_dreamsKey);
    if (dreamsJson == null) return [];

    final List<dynamic> decoded = jsonDecode(dreamsJson);
    return decoded.map((d) => Dream.fromJson(d)).toList();
  }

  /// Get recent dreams (last N days)
  Future<List<Dream>> getRecentDreams({int days = 7}) async {
    final dreams = await getAllDreams();
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return dreams.where((d) => d.dreamDate.isAfter(cutoff)).toList();
  }

  /// Get dream by ID
  Future<Dream?> getDreamById(String id) async {
    final dreams = await getAllDreams();
    try {
      return dreams.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update existing dream
  Future<void> updateDream(Dream dream) async {
    final dreams = await getAllDreams();
    final index = dreams.indexWhere((d) => d.id == dream.id);
    if (index != -1) {
      dreams[index] = dream;
      await _prefs.setString(
        _dreamsKey,
        jsonEncode(dreams.map((d) => d.toJson()).toList()),
      );
    }
  }

  /// Delete dream
  Future<void> deleteDream(String id) async {
    final dreams = await getAllDreams();
    dreams.removeWhere((d) => d.id == id);
    await _prefs.setString(
      _dreamsKey,
      jsonEncode(dreams.map((d) => d.toJson()).toList()),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MEMORY & PATTERN OPERATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Get user's dream memory (patterns, symbols, streaks)
  Future<DreamMemory> getDreamMemory() async {
    final memoryJson = _prefs.getString(_memoryKey);
    if (memoryJson == null) {
      return DreamMemory(
        userId: 'local_user',
        emotionalProfile: EmotionalProfile(),
        milestones: DreamMilestones(),
        updatedAt: DateTime.now(),
      );
    }
    return DreamMemory.fromJson(jsonDecode(memoryJson));
  }

  /// Update memory with new dream data
  Future<void> _updateMemoryFromDream(Dream dream) async {
    final memory = await getDreamMemory();

    // Update symbols
    final updatedSymbols = Map<String, SymbolOccurrence>.from(memory.symbols);
    for (final symbol in dream.symbols) {
      if (updatedSymbols.containsKey(symbol)) {
        updatedSymbols[symbol] = updatedSymbols[symbol]!.increment(
          context: dream.mood,
          emotion: dream.dominantEmotion,
        );
      } else {
        updatedSymbols[symbol] = SymbolOccurrence(
          count: 1,
          firstSeen: DateTime.now(),
          lastSeen: DateTime.now(),
          contexts: dream.mood != null ? [dream.mood!] : [],
          emotionalAssociations: dream.dominantEmotion != null
              ? [dream.dominantEmotion!]
              : [],
        );
      }
    }

    // Update themes
    final updatedThemes = Map<String, ThemeOccurrence>.from(memory.themes);
    for (final theme in dream.themes) {
      if (updatedThemes.containsKey(theme)) {
        updatedThemes[theme] = ThemeOccurrence(
          count: updatedThemes[theme]!.count + 1,
          evolution: updatedThemes[theme]!.evolution,
          lastSeen: DateTime.now(),
        );
      } else {
        updatedThemes[theme] = ThemeOccurrence(
          count: 1,
          lastSeen: DateTime.now(),
        );
      }
    }

    // Update milestones
    final updatedMilestones = memory.milestones.logDream();

    // Update emotional profile
    final updatedEmotionalProfile = _updateEmotionalProfile(
      memory.emotionalProfile,
      dream.dominantEmotion,
    );

    final updatedMemory = DreamMemory(
      userId: memory.userId,
      symbols: updatedSymbols,
      emotionalProfile: updatedEmotionalProfile,
      themes: updatedThemes,
      milestones: updatedMilestones,
      updatedAt: DateTime.now(),
    );

    await _prefs.setString(_memoryKey, jsonEncode(updatedMemory.toJson()));
  }

  EmotionalProfile _updateEmotionalProfile(
    EmotionalProfile current,
    String? newEmotion,
  ) {
    if (newEmotion == null) return current;

    final tones = List<String>.from(current.dominantTones);
    if (!tones.contains(newEmotion)) {
      tones.add(newEmotion);
      if (tones.length > 5) tones.removeAt(0); // Keep last 5
    }

    // Simple trend detection
    String trend = current.recentTrend;
    if (newEmotion.contains('kaygi') || newEmotion.contains('korku')) {
      trend = 'processing';
    } else if (newEmotion.contains('mutlu') || newEmotion.contains('huzur')) {
      trend = 'integrating';
    } else if (newEmotion.contains('merak') || newEmotion.contains('saskin')) {
      trend = 'seeking';
    }

    return EmotionalProfile(
      dominantTones: tones,
      recentTrend: trend,
      weeklySnapshots: current.weeklySnapshots,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // PATTERN DETECTION
  // ═══════════════════════════════════════════════════════════════

  /// Get recurring symbols (appeared 3+ times)
  Future<List<MapEntry<String, SymbolOccurrence>>> getRecurringSymbols() async {
    final memory = await getDreamMemory();
    return memory.recurringSymbols;
  }

  /// Check if a symbol is recurring for this user
  Future<bool> isRecurringSymbol(String symbol) async {
    final memory = await getDreamMemory();
    final occurrence = memory.symbols[symbol];
    return occurrence != null && occurrence.count >= 3;
  }

  /// Get symbol occurrence count
  Future<int> getSymbolCount(String symbol) async {
    final memory = await getDreamMemory();
    return memory.symbols[symbol]?.count ?? 0;
  }

  /// Detect new patterns (called after saving a dream)
  Future<PatternAlert?> detectNewPattern(Dream dream) async {
    final memory = await getDreamMemory();

    // Check for recurring symbol alert
    for (final symbol in dream.symbols) {
      final occurrence = memory.symbols[symbol];
      if (occurrence != null && occurrence.count == 3) {
        return PatternAlert(
          type: PatternAlertType.recurringSymbol,
          title: 'Tekrarlayan Sembol Tespit Edildi',
          message:
              '${_getSymbolEmoji(symbol)} "$symbol" sembolü rüyalarında 3. kez belirdi. Bu senin için özel bir anlam taşıyor olabilir.',
          symbol: symbol,
          count: 3,
        );
      }
    }

    // Check for streak milestones
    if (memory.milestones.currentStreak == 7) {
      return PatternAlert(
        type: PatternAlertType.streakMilestone,
        title: '7 Günlük Seri!',
        message:
            'Harika! 7 gündür rüyalarını kaydediyorsun. Bilinçaltınla bağlantın güçleniyor.',
        count: 7,
      );
    }

    // Check for dream count milestones
    if (memory.milestones.dreamCount == 10) {
      return PatternAlert(
        type: PatternAlertType.dreamMilestone,
        title: '10. Rüya!',
        message:
            'İlk 10 rüyana ulaştın. Artık örüntüler ortaya çıkmaya başlıyor.',
        count: 10,
      );
    }

    return null;
  }

  String _getSymbolEmoji(String symbol) {
    return DreamSymbol.commonSymbols[symbol]?.emoji ?? '🔮';
  }

  // ═══════════════════════════════════════════════════════════════
  // STREAK & GAMIFICATION
  // ═══════════════════════════════════════════════════════════════

  /// Get current streak
  Future<int> getCurrentStreak() async {
    final memory = await getDreamMemory();
    return memory.milestones.isStreakActive
        ? memory.milestones.currentStreak
        : 0;
  }

  /// Get longest streak
  Future<int> getLongestStreak() async {
    final memory = await getDreamMemory();
    return memory.milestones.longestStreak;
  }

  /// Get total dream count
  Future<int> getTotalDreamCount() async {
    final memory = await getDreamMemory();
    return memory.milestones.dreamCount;
  }

  /// Get last dream date
  Future<DateTime?> getLastDreamDate() async {
    final dateStr = _prefs.getString(_lastDreamDateKey);
    return dateStr != null ? DateTime.parse(dateStr) : null;
  }

  /// Check if user has logged a dream today
  Future<bool> hasLoggedDreamToday() async {
    final lastDate = await getLastDreamDate();
    if (lastDate == null) return false;

    final now = DateTime.now();
    return lastDate.year == now.year &&
        lastDate.month == now.month &&
        lastDate.day == now.day;
  }

  // ═══════════════════════════════════════════════════════════════
  // SUMMARIES & INSIGHTS
  // ═══════════════════════════════════════════════════════════════

  /// Generate weekly summary
  Future<DreamSummary> getWeeklySummary() async {
    final dreams = await getRecentDreams(days: 7);
    final memory = await getDreamMemory();

    // Aggregate symbols
    final symbolCounts = <String, int>{};
    final emotions = <String>[];

    for (final dream in dreams) {
      for (final symbol in dream.symbols) {
        symbolCounts[symbol] = (symbolCounts[symbol] ?? 0) + 1;
      }
      if (dream.dominantEmotion != null) {
        emotions.add(dream.dominantEmotion!);
      }
    }

    // Get top symbols
    final topSymbols = symbolCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return DreamSummary(
      period: 'Bu Hafta',
      dreamCount: dreams.length,
      topSymbols: topSymbols.take(5).map((e) => e.key).toList(),
      dominantEmotion: _getMostFrequent(emotions),
      insight: _generateWeeklyInsight(dreams.length, topSymbols),
      currentStreak: memory.milestones.currentStreak,
    );
  }

  String? _getMostFrequent(List<String> items) {
    if (items.isEmpty) return null;
    final counts = <String, int>{};
    for (final item in items) {
      counts[item] = (counts[item] ?? 0) + 1;
    }
    return counts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String _generateWeeklyInsight(
    int dreamCount,
    List<MapEntry<String, int>> topSymbols,
  ) {
    if (dreamCount == 0) {
      return 'Bu hafta henüz rüya kaydetmedin. Bilinçaltının sesini dinlemeye hazır mısın?';
    }
    if (dreamCount == 1) {
      return 'Bu hafta 1 rüya kaydettin. Düzenli kayıt, örüntüleri keşfetmeni sağlar.';
    }
    if (topSymbols.isNotEmpty) {
      final topSymbol = topSymbols.first.key;
      return 'Bu hafta $dreamCount rüya kaydettin. En çok "$topSymbol" sembolü belirdi - bu senin için ne anlam taşıyor?';
    }
    return 'Bu hafta $dreamCount rüya kaydettin. Rüya günlüğün zenginleşiyor!';
  }

  // ═══════════════════════════════════════════════════════════════
  // SYMBOL EXTRACTION (Basic - can be enhanced with AI)
  // ═══════════════════════════════════════════════════════════════

  /// Extract symbols from dream text (basic keyword matching)
  List<String> extractSymbols(String dreamText) {
    final text = dreamText.toLowerCase();
    final found = <String>[];

    // Turkish keyword patterns
    final patterns = {
      'su': [
        'su ',
        'suda',
        'suya',
        'suyu',
        'deniz',
        'okyanus',
        'göl',
        'nehir',
        'yağmur',
      ],
      'yilan': ['yılan', 'yilan', 'kobra', 'boa'],
      'ucmak': ['uçuyordum', 'uçtum', 'uçmak', 'havada', 'gökyüzü'],
      'dusmek': ['düştüm', 'düşüyordum', 'düşmek', 'düşüş'],
      'olum': ['ölüm', 'öldüm', 'öldü', 'cenaze', 'mezar'],
      'ev': ['ev ', 'evde', 'evim', 'oda', 'daire', 'bina'],
      'bebek': ['bebek', 'çocuk', 'hamile', 'doğum'],
      'dis': ['diş', 'dişler', 'diş düş'],
      'araba': ['araba', 'araç', 'otomobil', 'sürüyordum'],
      'kopek': ['köpek', 'it '],
      'kedi': ['kedi', 'kedicik'],
      'ates': ['ateş', 'yangın', 'alev', 'yanıyor'],
      'ay': ['ay ', 'dolunay', 'yeni ay', 'gece'],
      'kaçmak': ['kaçıyordum', 'kaçtım', 'kovalıyordu', 'kovalandım'],
      'orman': ['orman', 'ağaçlar', 'ormanda'],
    };

    for (final entry in patterns.entries) {
      for (final keyword in entry.value) {
        if (text.contains(keyword)) {
          if (!found.contains(entry.key)) {
            found.add(entry.key);
          }
          break;
        }
      }
    }

    return found;
  }
}

/// Pattern alert for user notification
class PatternAlert {
  final PatternAlertType type;
  final String title;
  final String message;
  final String? symbol;
  final int? count;

  PatternAlert({
    required this.type,
    required this.title,
    required this.message,
    this.symbol,
    this.count,
  });
}

enum PatternAlertType {
  recurringSymbol,
  emotionalPattern,
  streakMilestone,
  dreamMilestone,
}

/// Dream summary for weekly/monthly reports
class DreamSummary {
  final String period;
  final int dreamCount;
  final List<String> topSymbols;
  final String? dominantEmotion;
  final String insight;
  final int currentStreak;

  DreamSummary({
    required this.period,
    required this.dreamCount,
    required this.topSymbols,
    this.dominantEmotion,
    required this.insight,
    required this.currentStreak,
  });
}
