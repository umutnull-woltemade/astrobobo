import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/user_profile.dart';
import 'storage_service.dart';

/// Seeds rich demo data for App Store screenshots.
/// Call DemoSeedService.seed() once — it populates SharedPreferences
/// with hundreds of journal entries, mood check-ins, dreams, gratitude, etc.
class DemoSeedService {
  static const _uuid = Uuid();
  static final _rng = Random(42); // Deterministic for consistency

  /// Check if already seeded (v2 = birthday fix)
  static Future<bool> isSeeded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('demo_seed_version') == 3;
  }

  /// Seed all demo data
  static Future<void> seed() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('demo_seeded') == true) return;

    // 1. Set premium status (lifetime)
    await prefs.setBool('is_premium', true);
    await prefs.setInt('premium_tier', 3); // lifetime = index 3
    await prefs.setBool('is_lifetime', true);
    // premium_expiry as int (milliseconds) to match PremiumService._loadLocalPremiumStatus
    await prefs.setInt('premium_expiry', DateTime(2099, 12, 31).millisecondsSinceEpoch);

    // 2. Set onboarding complete
    await prefs.setBool('onboarding_complete', true);
    await prefs.setBool('disclaimer_accepted', true);

    // 3. Set install time (simulate 2+ years ago)
    final installDate = DateTime.now().subtract(const Duration(days: 800));
    await prefs.setInt('ic_intro_offer_install_time', installDate.millisecondsSinceEpoch);

    // 4. Seed journal entries (800+ entries over ~2.5 years)
    await _seedJournalEntries(prefs);

    // 5. Seed mood check-ins (90 days)
    await _seedMoodCheckins(prefs);

    // 6. Seed dream journal entries
    await _seedDreamEntries(prefs);

    // 7. Seed gratitude entries
    await _seedGratitudeEntries(prefs);

    // 8. Seed streak data
    await _seedStreakData(prefs);

    // 9. Seed birthday contacts
    await _seedBirthdayContacts(prefs);

    // 10. Seed habits
    await _seedHabits(prefs);

    // 11. Seed sleep data
    await _seedSleepData(prefs);

    // 12. Seed notes to self
    await _seedNotes(prefs);

    // 13. Set preferred focus area
    await prefs.setString('preferred_focus_area', 'emotions');

    // 14. Save user profile (Dalai Lama) via StorageService (Hive)
    final profile = UserProfile(
      name: 'Dalai Lama',
      birthDate: DateTime(1935, 7, 6),
      birthPlace: 'Taktser, Tibet',
      avatarEmoji: '🙏',
      isPrimary: true,
    );
    await StorageService.saveUserProfile(profile);
    await StorageService.saveOnboardingComplete(true);

    // Mark as seeded (version 2)
    await prefs.setInt('demo_seed_version', 3);
  }

  // ═══════════════════════════════════════════════════════════════════
  // JOURNAL ENTRIES
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedJournalEntries(SharedPreferences prefs) async {
    final entries = <Map<String, dynamic>>[];
    final now = DateTime.now();
    final focusAreas = ['energy', 'focus', 'emotions', 'decisions', 'social'];

    // Dalai Lama-style reflective notes
    final notes = [
      'Morning meditation brought unexpected clarity. The mind is like a lake — when still, it reflects everything clearly.',
      'Met with students today. Their questions reminded me that wisdom begins with genuine curiosity.',
      'Felt a wave of compassion during the afternoon walk. Even small acts of kindness ripple outward.',
      'Sleep was restful. Gratitude practice before bed settles the mind beautifully.',
      'Noticed frustration arising during a difficult conversation. Observing without reacting is the deepest practice.',
      'Energy was high today. Physical movement connects the body and mind in ways words cannot.',
      'Reading ancient texts — the same human patterns repeat across centuries. We are not so different from our ancestors.',
      'A quiet day. Sometimes the most productive thing is to simply be present.',
      'Decision-making felt clear today. When aligned with values, choices become simple.',
      'Connection with old friends reminded me: relationships are the true measure of a life well-lived.',
      'The garden teaches patience. Growth cannot be hurried, only nurtured.',
      'Felt scattered this morning. Returned to breath — three minutes changed the entire day.',
      'Joyful conversation with a child. They see the world without the filters we accumulate.',
      'Challenging news arrived. Sat with discomfort instead of reacting. The storm passed.',
      'Writing letters today. Words carry energy long after they are spoken.',
      'Observed my own mental patterns with curiosity rather than judgment. Progress.',
      'Early morning practice was deep. The boundary between self and world dissolved briefly.',
      'Physical energy lower today. The body has its own wisdom — listened and rested.',
      'Gratitude for simple things: warm tea, sunlight through the window, a friend\'s voice.',
      'Noticed how productivity obsession can become its own form of suffering. Balance.',
      'Led a group reflection session. Collective wisdom always exceeds individual insight.',
      'Walked in nature. Trees don\'t compare themselves to each other.',
      'Difficult emotions surfaced. Welcomed them like old friends — they carry important messages.',
      'Focus was razor-sharp today. Clarity comes from simplicity.',
      'Social connections felt nourishing rather than draining. Authenticity is the key.',
      'Reflected on impermanence. Every moment is both precious and fleeting.',
      'Creative energy flowed easily today. Art and contemplation share the same source.',
      'Inner dialogue was gentle today. Self-compassion is not weakness — it is courage.',
      'Made a difficult decision with peace. Not every choice needs certainty.',
      'Evening meditation revealed a subtle pattern I\'ve been carrying for months. Awareness is the first step.',
    ];

    final tags = [
      ['meditation', 'clarity'],
      ['compassion', 'growth'],
      ['gratitude', 'peace'],
      ['energy', 'movement'],
      ['reflection', 'wisdom'],
      ['patience', 'nature'],
      ['connection', 'friendship'],
      ['mindfulness', 'breath'],
      ['creativity', 'flow'],
      ['balance', 'rest'],
    ];

    // Generate 800 entries over ~2.5 years
    for (int i = 0; i < 800; i++) {
      final date = now.subtract(Duration(days: i));
      // Skip some days randomly (realistic — not every day has an entry)
      if (i > 30 && _rng.nextDouble() < 0.15) continue;

      final focusArea = focusAreas[i % focusAreas.length];
      final noteIndex = i % notes.length;
      final tagIndex = i % tags.length;

      // Mood follows a natural sine wave + noise pattern
      final baseMood = 3.5 + 1.2 * sin(i * 0.05) + (_rng.nextDouble() - 0.5);
      final mood = baseMood.clamp(1, 5).round();

      final subKeys = _subKeysFor(focusArea);
      final subRatings = <String, int>{};
      for (final key in subKeys) {
        subRatings[key] = (mood + (_rng.nextInt(3) - 1)).clamp(1, 5);
      }

      entries.add({
        'id': _uuid.v4(),
        'date': date.toIso8601String(),
        'createdAt': date.add(Duration(hours: 8 + _rng.nextInt(4))).toIso8601String(),
        'focusArea': focusArea,
        'overallRating': mood,
        'subRatings': subRatings,
        'note': notes[noteIndex],
        'imagePath': null,
        'tags': tags[tagIndex],
        'isPrivate': i % 20 == 0,
        'isFavorite': i % 7 == 0,
      });
    }

    await prefs.setString(
      'inner_cycles_journal_entries',
      jsonEncode(entries),
    );
  }

  static List<String> _subKeysFor(String focusArea) {
    switch (focusArea) {
      case 'energy': return ['physical', 'mental', 'motivation'];
      case 'focus': return ['clarity', 'productivity', 'distractibility'];
      case 'emotions': return ['mood', 'stress', 'calm'];
      case 'decisions': return ['confidence', 'certainty', 'regret'];
      case 'social': return ['connection', 'isolation', 'communication'];
      default: return ['mood', 'stress', 'calm'];
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // MOOD CHECK-INS
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedMoodCheckins(SharedPreferences prefs) async {
    final entries = <Map<String, dynamic>>[];
    final now = DateTime.now();
    final emojis = ['😔', '😐', '🙂', '😊', '🤩'];
    final emotions = [
      ['anxious', 'overwhelmed'],
      ['tired', 'neutral'],
      ['calm', 'content'],
      ['grateful', 'motivated'],
      ['inspired', 'joyful'],
    ];

    for (int i = 0; i < 90; i++) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final baseMood = 3.5 + 1.0 * sin(i * 0.08) + (_rng.nextDouble() - 0.5);
      final mood = baseMood.clamp(1, 5).round();

      entries.add({
        'id': _uuid.v4(),
        'date': date.toIso8601String(),
        'mood': mood,
        'emoji': emojis[mood - 1],
        'selected_emotions': emotions[mood - 1],
        'energy': (mood + _rng.nextInt(2) - 1).clamp(1, 5),
        'pleasantness': (mood + _rng.nextInt(2) - 1).clamp(1, 5),
        'created_at': date.add(Duration(hours: 9 + _rng.nextInt(3))).toIso8601String(),
      });
    }

    await prefs.setString('inner_cycles_mood_checkins', jsonEncode(entries));
  }

  // ═══════════════════════════════════════════════════════════════════
  // DREAM ENTRIES
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedDreamEntries(SharedPreferences prefs) async {
    final dreams = <Map<String, dynamic>>[];
    final now = DateTime.now();

    final dreamData = [
      {
        'title': 'The Mountain Temple',
        'content': 'Walked up a steep mountain path. At the top, a small temple with an open door. Inside, a single candle burned. No one was there but I felt deeply welcomed.',
        'symbols': ['mountain', 'temple', 'candle', 'door'],
        'emotion': 'peaceful',
        'intensity': 7,
      },
      {
        'title': 'River of Light',
        'content': 'Standing by a river that glowed silver. The water spoke in whispers — not words, but feelings. I understood everything without thinking.',
        'symbols': ['river', 'light', 'water', 'whisper'],
        'emotion': 'wonder',
        'intensity': 9,
      },
      {
        'title': 'The Library Without Walls',
        'content': 'An infinite library where books floated in mid-air. Each book contained a year of someone\'s life. I opened one and lived a stranger\'s happiest memory.',
        'symbols': ['library', 'books', 'floating', 'memory'],
        'emotion': 'curious',
        'intensity': 8,
      },
      {
        'title': 'Flying Over the Valley',
        'content': 'Lucid dream — realized I was dreaming and chose to fly. Soared over a green valley with golden light. Felt completely free and alive.',
        'symbols': ['flying', 'valley', 'golden light', 'freedom'],
        'emotion': 'joy',
        'intensity': 10,
        'lucid': true,
      },
      {
        'title': 'The Old Garden',
        'content': 'Returned to a garden from childhood. Everything was overgrown but beautiful. Found a small bird nesting where I used to play.',
        'symbols': ['garden', 'childhood', 'bird', 'nest'],
        'emotion': 'nostalgic',
        'intensity': 6,
      },
      {
        'title': 'Mirror Room',
        'content': 'Room full of mirrors, each showing a different version of myself. Some older, some younger. None were wrong — all were true.',
        'symbols': ['mirror', 'reflection', 'identity', 'room'],
        'emotion': 'contemplative',
        'intensity': 8,
      },
      {
        'title': 'The Storm That Passed',
        'content': 'Dark storm approaching but I stood calmly. The wind roared around me but I was untouched. After it passed, everything was clean and fresh.',
        'symbols': ['storm', 'wind', 'calm', 'renewal'],
        'emotion': 'strength',
        'intensity': 7,
      },
      {
        'title': 'Underwater City',
        'content': 'Discovered a city beneath the ocean. People lived there peacefully, breathing water like air. They welcomed me without surprise.',
        'symbols': ['ocean', 'city', 'underwater', 'breathing'],
        'emotion': 'wonder',
        'intensity': 9,
      },
      {
        'title': 'Seeds of Stars',
        'content': 'Planting seeds in dark soil. Each seed sprouted into a tiny star. The field became a galaxy I could walk through.',
        'symbols': ['seeds', 'stars', 'planting', 'galaxy'],
        'emotion': 'awe',
        'intensity': 10,
      },
      {
        'title': 'The Conversation',
        'content': 'Long conversation with someone whose face I couldn\'t see. They asked questions I\'d been avoiding. Woke up with clarity I didn\'t have before.',
        'symbols': ['conversation', 'unknown figure', 'questions', 'clarity'],
        'emotion': 'insightful',
        'intensity': 7,
      },
    ];

    final moonPhases = ['new_moon', 'waxing_crescent', 'first_quarter', 'waxing_gibbous', 'full_moon', 'waning_gibbous', 'last_quarter', 'waning_crescent'];

    for (int i = 0; i < 45; i++) {
      final daysAgo = i * 4 + _rng.nextInt(3);
      final date = now.subtract(Duration(days: daysAgo));
      final d = dreamData[i % dreamData.length];

      dreams.add({
        'id': _uuid.v4(),
        'dreamDate': date.toIso8601String(),
        'recordedAt': date.add(Duration(hours: 7)).toIso8601String(),
        'title': d['title'],
        'content': d['content'],
        'detectedSymbols': d['symbols'],
        'userTags': [],
        'dominantEmotion': d['emotion'],
        'emotionalIntensity': d['intensity'],
        'isRecurring': i % 5 == 0,
        'isLucid': d['lucid'] == true,
        'isNightmare': false,
        'moonPhase': moonPhases[i % moonPhases.length],
        'clarity': 5 + _rng.nextInt(5),
        'sleepQuality': ['fair', 'good', 'good', 'excellent'][_rng.nextInt(4)],
      });
    }

    await prefs.setString('dream_journal_entries', jsonEncode(dreams));
  }

  // ═══════════════════════════════════════════════════════════════════
  // GRATITUDE ENTRIES
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedGratitudeEntries(SharedPreferences prefs) async {
    final entries = <Map<String, dynamic>>[];
    final now = DateTime.now();

    final gratitudes = [
      'The warmth of morning sunlight through the window',
      'A student\'s question that made me think deeply',
      'Hot tea shared with a dear friend',
      'The silence after a long meditation',
      'Birds singing at dawn — they need no reason to sing',
      'A letter from someone I helped years ago',
      'The ability to walk in nature today',
      'Laughter during dinner — genuine and unburdened',
      'A moment of unexpected kindness from a stranger',
      'Rain after a dry spell — the earth\'s gratitude is visible',
      'Clear mind after a restful night',
      'The patience of teachers who shaped my path',
      'Music that moved me to tears of joy',
      'Fresh vegetables from the garden',
      'A child\'s unfiltered honesty',
    ];

    for (int i = 0; i < 120; i++) {
      final date = now.subtract(Duration(days: i));
      if (_rng.nextDouble() < 0.2) continue; // Skip some days

      entries.add({
        'id': _uuid.v4(),
        'date': date.toIso8601String(),
        'text': gratitudes[i % gratitudes.length],
        'createdAt': date.add(Duration(hours: 21 + _rng.nextInt(2))).toIso8601String(),
      });
    }

    await prefs.setString('gratitude_entries', jsonEncode(entries));
  }

  // ═══════════════════════════════════════════════════════════════════
  // STREAK DATA
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedStreakData(SharedPreferences prefs) async {
    await prefs.setInt('streak_current', 47);
    await prefs.setInt('streak_longest', 186);
    await prefs.setInt('streak_total_entries', 742);
    await prefs.setString('streak_last_entry_date', DateTime.now().toIso8601String());

    // Milestones achieved
    final milestones = [7, 14, 30, 50, 100, 150];
    await prefs.setString('streak_milestones', jsonEncode(milestones));
  }

  // ═══════════════════════════════════════════════════════════════════
  // BIRTHDAY CONTACTS
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedBirthdayContacts(SharedPreferences prefs) async {
    final now = DateTime.now();
    final contacts = [
      {'id': _uuid.v4(), 'name': 'Tenzin Gyatso', 'birthdayMonth': 7, 'birthdayDay': 6, 'birthYear': 1935, 'relationship': 'family', 'avatarEmoji': '🙏', 'note': 'A day for deep reflection', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Thich Nhat Hanh', 'birthdayMonth': 10, 'birthdayDay': 11, 'birthYear': 1926, 'relationship': 'friend', 'avatarEmoji': '🪷', 'note': 'Master of mindful living', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Pema Chödrön', 'birthdayMonth': 7, 'birthdayDay': 14, 'birthYear': 1936, 'relationship': 'friend', 'avatarEmoji': '☀️', 'note': 'Wisdom keeper', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Matthieu Ricard', 'birthdayMonth': 2, 'birthdayDay': 15, 'birthYear': 1946, 'relationship': 'friend', 'avatarEmoji': '😊', 'note': 'The happiest person in the world', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Yongey Mingyur', 'birthdayMonth': 6, 'birthdayDay': 15, 'birthYear': 1975, 'relationship': 'friend', 'avatarEmoji': '🧘', 'note': 'Joy of living teacher', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Sharon Salzberg', 'birthdayMonth': 8, 'birthdayDay': 5, 'birthYear': 1952, 'relationship': 'friend', 'avatarEmoji': '💛', 'note': 'Loving-kindness practice', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Jon Kabat-Zinn', 'birthdayMonth': 6, 'birthdayDay': 5, 'birthYear': 1944, 'relationship': 'colleague', 'avatarEmoji': '🌿', 'note': 'Mindfulness pioneer', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Ram Dass', 'birthdayMonth': 4, 'birthdayDay': 6, 'birthYear': 1931, 'relationship': 'friend', 'avatarEmoji': '🙏', 'note': 'Be here now', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      // Upcoming birthdays (within next 30 days for visibility)
      {'id': _uuid.v4(), 'name': 'Maya Patel', 'birthdayMonth': now.month, 'birthdayDay': (now.day + 2) > 28 ? 1 : now.day + 2, 'birthYear': 1990, 'relationship': 'friend', 'avatarEmoji': '🌸', 'note': 'Meditation retreat partner', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Anya Nakamura', 'birthdayMonth': now.month, 'birthdayDay': (now.day + 5) > 28 ? 5 : now.day + 5, 'birthYear': 1985, 'relationship': 'friend', 'avatarEmoji': '🎨', 'note': 'Creative soul', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Leo Bergman', 'birthdayMonth': now.month == 12 ? 1 : now.month + 1, 'birthdayDay': 8, 'birthYear': 1978, 'relationship': 'colleague', 'avatarEmoji': '📚', 'note': 'Philosophy discussion partner', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
      {'id': _uuid.v4(), 'name': 'Sofia Reyes', 'birthdayMonth': 3, 'birthdayDay': 21, 'birthYear': 1995, 'relationship': 'friend', 'avatarEmoji': '🌺', 'note': 'Spring equinox birthday', 'source': 'manual', 'notificationsEnabled': true, 'dayBeforeReminder': true, 'createdAt': now.toIso8601String()},
    ];

    await prefs.setString('inner_cycles_birthday_contacts', jsonEncode(contacts));
  }

  // ═══════════════════════════════════════════════════════════════════
  // HABITS
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedHabits(SharedPreferences prefs) async {
    final now = DateTime.now();
    final habits = [
      {
        'id': _uuid.v4(),
        'name': 'Morning Meditation',
        'emoji': '🧘',
        'frequency': 'daily',
        'streak': 47,
        'completedDates': List.generate(47, (i) =>
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i)).toIso8601String(),
        ),
      },
      {
        'id': _uuid.v4(),
        'name': 'Gratitude Journal',
        'emoji': '🙏',
        'frequency': 'daily',
        'streak': 32,
        'completedDates': List.generate(32, (i) =>
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i)).toIso8601String(),
        ),
      },
      {
        'id': _uuid.v4(),
        'name': 'Nature Walk',
        'emoji': '🌿',
        'frequency': 'daily',
        'streak': 15,
        'completedDates': List.generate(15, (i) =>
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i)).toIso8601String(),
        ),
      },
      {
        'id': _uuid.v4(),
        'name': 'Reading',
        'emoji': '📚',
        'frequency': 'daily',
        'streak': 23,
        'completedDates': List.generate(23, (i) =>
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i)).toIso8601String(),
        ),
      },
      {
        'id': _uuid.v4(),
        'name': 'Breathwork',
        'emoji': '🌬️',
        'frequency': 'daily',
        'streak': 8,
        'completedDates': List.generate(8, (i) =>
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i)).toIso8601String(),
        ),
      },
    ];

    await prefs.setString('user_habits', jsonEncode(habits));
  }

  // ═══════════════════════════════════════════════════════════════════
  // SLEEP DATA
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedSleepData(SharedPreferences prefs) async {
    final entries = <Map<String, dynamic>>[];
    final now = DateTime.now();

    for (int i = 0; i < 60; i++) {
      final date = now.subtract(Duration(days: i));
      final quality = ['poor', 'fair', 'good', 'good', 'excellent'][_rng.nextInt(5)];
      final hours = 6.5 + _rng.nextDouble() * 2.5; // 6.5-9 hours

      entries.add({
        'id': _uuid.v4(),
        'date': date.toIso8601String(),
        'quality': quality,
        'hoursSlept': double.parse(hours.toStringAsFixed(1)),
        'bedtime': '${21 + _rng.nextInt(2)}:${_rng.nextInt(4) * 15}'.padLeft(5, '0'),
        'wakeTime': '${5 + _rng.nextInt(2)}:${_rng.nextInt(4) * 15}'.padLeft(5, '0'),
        'notes': i % 5 == 0 ? 'Deep sleep, vivid dreams' : null,
      });
    }

    await prefs.setString('sleep_entries', jsonEncode(entries));
  }

  // ═══════════════════════════════════════════════════════════════════
  // NOTES TO SELF
  // ═══════════════════════════════════════════════════════════════════

  static Future<void> _seedNotes(SharedPreferences prefs) async {
    final now = DateTime.now();
    final notes = <Map<String, dynamic>>[
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 180)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 180)).toIso8601String(),
        'title': 'Morning Ritual',
        'content': 'Wake before sunrise. Sit in silence for 20 minutes. Let thoughts come and go like clouds. Then begin the day with intention, not reaction.',
        'isPinned': true,
        'tags': ['mindfulness', 'morning', 'ritual'],
        'moodAtCreation': '😌',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 150)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 140)).toIso8601String(),
        'title': 'On Compassion',
        'content': 'If you want others to be happy, practice compassion. If you want to be happy, practice compassion. This is the simplest truth I keep forgetting.',
        'isPinned': true,
        'tags': ['compassion', 'wisdom', 'reminder'],
        'moodAtCreation': '🙏',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 120)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 120)).toIso8601String(),
        'title': 'Letting Go',
        'content': 'Attachment is the origin of suffering. Today I practiced releasing my grip on outcomes. The peace that followed was profound.',
        'isPinned': false,
        'tags': ['letting go', 'peace', 'growth'],
        'moodAtCreation': '😊',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 90)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 85)).toIso8601String(),
        'title': 'Sleep & Recovery',
        'content': 'Sleep is not laziness. Rest is not weakness. The mind needs stillness to process the fullness of experience. Honor the body\'s need for restoration.',
        'isPinned': false,
        'tags': ['sleep', 'self-care', 'health'],
        'moodAtCreation': '😴',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 60)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 55)).toIso8601String(),
        'title': 'Gratitude Practice',
        'content': 'Every day, think as you wake up: today I am fortunate to be alive. I have a precious human life. I am not going to waste it.',
        'isPinned': true,
        'tags': ['gratitude', 'morning', 'mindfulness'],
        'moodAtCreation': '🌅',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 45)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 45)).toIso8601String(),
        'title': 'Inner Dialogue Insight',
        'content': 'The voice inside that criticizes is not your enemy — it is a frightened part of you seeking safety. Respond with kindness, not resistance.',
        'isPinned': false,
        'tags': ['inner voice', 'self-compassion', 'insight'],
        'moodAtCreation': '💡',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 30)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 28)).toIso8601String(),
        'title': 'Patience Reminder',
        'content': 'Growth is not linear. Some days you will feel like you are going backwards. Trust the process. The seed grows in darkness before it reaches the light.',
        'isPinned': false,
        'tags': ['patience', 'growth', 'trust'],
        'moodAtCreation': '🌱',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 14)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 14)).toIso8601String(),
        'title': 'Emotional Awareness',
        'content': 'I noticed anger rising during the afternoon. Instead of reacting, I paused. Breathed. The anger passed like weather. I am not my emotions — I am the sky.',
        'isPinned': false,
        'tags': ['emotions', 'awareness', 'breath'],
        'moodAtCreation': '🌤️',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 7)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 7)).toIso8601String(),
        'title': 'Connection',
        'content': 'We are all interconnected. The happiness of others is inseparable from our own. Today I reached out to an old friend and felt the warmth return tenfold.',
        'isPinned': false,
        'tags': ['connection', 'friendship', 'love'],
        'moodAtCreation': '❤️',
        'isPrivate': false,
      },
      {
        'id': _uuid.v4(),
        'createdAt': now.subtract(const Duration(days: 2)).toIso8601String(),
        'updatedAt': now.subtract(const Duration(days: 2)).toIso8601String(),
        'title': 'Today\'s Intention',
        'content': 'Be the reason someone smiles today. Small acts of kindness ripple outward in ways we cannot see. A gentle word, a moment of listening, a warm gaze.',
        'isPinned': true,
        'tags': ['intention', 'kindness', 'daily'],
        'moodAtCreation': '😊',
        'isPrivate': false,
      },
    ];

    await prefs.setString('notes_to_self_entries', jsonEncode(notes));
  }
}
