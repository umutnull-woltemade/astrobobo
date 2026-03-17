import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/mood_checkin_service.dart';

void main() {
  group('MoodEntry', () {
    test('constructs with required fields', () {
      final entry = MoodEntry(
        id: 'test-id',
        date: DateTime(2026, 3, 17),
        mood: 4,
        emoji: '😊',
      );
      expect(entry.id, 'test-id');
      expect(entry.mood, 4);
      expect(entry.emoji, '😊');
      expect(entry.selectedEmotions, isEmpty);
      expect(entry.quadrant, isNull);
      expect(entry.signalId, isNull);
      expect(entry.energy, isNull);
      expect(entry.pleasantness, isNull);
    });

    test('constructs with all fields', () {
      final now = DateTime.now();
      final entry = MoodEntry(
        id: 'full-id',
        date: DateTime(2026, 3, 17),
        mood: 5,
        emoji: '🌟',
        selectedEmotions: ['joy', 'gratitude'],
        quadrant: 'fire',
        signalId: 'fire_alive',
        energy: 8,
        pleasantness: 9,
        createdAt: now,
      );
      expect(entry.selectedEmotions, ['joy', 'gratitude']);
      expect(entry.quadrant, 'fire');
      expect(entry.signalId, 'fire_alive');
      expect(entry.energy, 8);
      expect(entry.pleasantness, 9);
      expect(entry.createdAt, now);
    });

    test('hasSignal is true when signalId is set', () {
      final entry = MoodEntry(
        id: 'id', date: DateTime.now(), mood: 3, emoji: '',
        signalId: 'water_calm',
      );
      expect(entry.hasSignal, true);
    });

    test('hasSignal is false when signalId is null', () {
      final entry = MoodEntry(id: 'id', date: DateTime.now(), mood: 3, emoji: '');
      expect(entry.hasSignal, false);
    });

    test('loggedHour uses createdAt hour', () {
      final entry = MoodEntry(
        id: 'id', date: DateTime.now(), mood: 3, emoji: '',
        createdAt: DateTime(2026, 3, 17, 14, 30),
      );
      expect(entry.loggedHour, 14);
    });

    test('loggedHour defaults to 12 when createdAt is null', () {
      final entry = MoodEntry(id: 'id', date: DateTime.now(), mood: 3, emoji: '');
      expect(entry.loggedHour, 12);
    });

    test('copyWith preserves unchanged fields', () {
      final original = MoodEntry(
        id: 'id', date: DateTime(2026, 1, 1), mood: 4, emoji: '😊',
        signalId: 'test',
      );
      final copied = original.copyWith(energy: 7);
      expect(copied.id, 'id');
      expect(copied.mood, 4);
      expect(copied.signalId, 'test');
      expect(copied.energy, 7);
    });

    test('copyWith overrides specified fields', () {
      final original = MoodEntry(
        id: 'id', date: DateTime.now(), mood: 3, emoji: '',
        energy: 5, pleasantness: 5,
      );
      final copied = original.copyWith(energy: 9, pleasantness: 2);
      expect(copied.energy, 9);
      expect(copied.pleasantness, 2);
    });

    test('toJson produces correct map', () {
      final entry = MoodEntry(
        id: 'json-id',
        date: DateTime(2026, 3, 17),
        mood: 5,
        emoji: '🔥',
        selectedEmotions: ['passion'],
        signalId: 'fire_alive',
        energy: 8,
      );
      final json = entry.toJson();
      expect(json['id'], 'json-id');
      expect(json['mood'], 5);
      expect(json['emoji'], '🔥');
      expect(json['selected_emotions'], ['passion']);
      expect(json['signal_id'], 'fire_alive');
      expect(json['energy'], 8);
    });

    test('toJson omits null optional fields', () {
      final entry = MoodEntry(id: 'id', date: DateTime.now(), mood: 3, emoji: '');
      final json = entry.toJson();
      expect(json.containsKey('quadrant'), false);
      expect(json.containsKey('signal_id'), false);
      expect(json.containsKey('energy'), false);
      expect(json.containsKey('pleasantness'), false);
    });

    test('fromJson parses correctly', () {
      final entry = MoodEntry.fromJson({
        'id': 'parsed-id',
        'date': '2026-03-17T00:00:00.000',
        'mood': 4,
        'emoji': '😊',
        'selected_emotions': ['calm', 'peace'],
        'quadrant': 'water',
        'signal_id': 'water_calm',
        'energy': 6,
        'pleasantness': 8,
        'created_at': '2026-03-17T14:30:00.000',
      });
      expect(entry.id, 'parsed-id');
      expect(entry.mood, 4);
      expect(entry.selectedEmotions, ['calm', 'peace']);
      expect(entry.quadrant, 'water');
      expect(entry.signalId, 'water_calm');
      expect(entry.energy, 6);
      expect(entry.pleasantness, 8);
      expect(entry.createdAt?.hour, 14);
    });

    test('fromJson defaults mood to 3', () {
      final entry = MoodEntry.fromJson({'emoji': '😐'});
      expect(entry.mood, 3);
    });

    test('fromJson handles missing fields gracefully', () {
      final entry = MoodEntry.fromJson({});
      expect(entry.mood, 3);
      expect(entry.emoji, '');
      expect(entry.selectedEmotions, isEmpty);
      expect(entry.id, isNotEmpty); // UUID generated
    });

    test('toJson/fromJson roundtrip', () {
      final original = MoodEntry(
        id: 'roundtrip',
        date: DateTime(2026, 3, 17),
        mood: 5,
        emoji: '🌟',
        selectedEmotions: ['joy'],
        signalId: 'fire_inspired',
        energy: 9,
        pleasantness: 10,
        createdAt: DateTime(2026, 3, 17, 10, 0),
      );
      final restored = MoodEntry.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.mood, original.mood);
      expect(restored.emoji, original.emoji);
      expect(restored.signalId, original.signalId);
      expect(restored.energy, original.energy);
      expect(restored.pleasantness, original.pleasantness);
    });
  });
}
