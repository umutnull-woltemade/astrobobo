import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/note_to_self.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';

void main() {
  group('ReminderFrequency', () {
    test('has four values', () {
      expect(ReminderFrequency.values.length, 4);
    });

    test('English display names', () {
      expect(ReminderFrequency.once.displayNameEn(), 'Once');
      expect(ReminderFrequency.daily.displayNameEn(), 'Daily');
      expect(ReminderFrequency.weekly.displayNameEn(), 'Weekly');
      expect(ReminderFrequency.monthly.displayNameEn(), 'Monthly');
    });

    test('Turkish display names', () {
      expect(ReminderFrequency.once.displayNameTr(), 'Bir Kez');
      expect(ReminderFrequency.daily.displayNameTr(), 'Günlük');
    });

    test('localizedName returns correct for language', () {
      expect(ReminderFrequency.once.localizedName(AppLanguage.en), 'Once');
      expect(ReminderFrequency.once.localizedName(AppLanguage.tr), 'Bir Kez');
    });
  });

  group('NoteReminder', () {
    test('constructs with required fields', () {
      final reminder = NoteReminder(
        id: 'r1', noteId: 'n1',
        scheduledAt: DateTime(2026, 3, 17, 9, 0),
        frequency: ReminderFrequency.daily,
      );
      expect(reminder.id, 'r1');
      expect(reminder.noteId, 'n1');
      expect(reminder.isActive, true);
      expect(reminder.customMessage, isNull);
    });

    test('copyWith changes fields', () {
      final original = NoteReminder(
        id: 'r1', noteId: 'n1',
        scheduledAt: DateTime(2026, 1, 1),
        frequency: ReminderFrequency.once,
      );
      final updated = original.copyWith(isActive: false, customMessage: 'Hi');
      expect(updated.isActive, false);
      expect(updated.customMessage, 'Hi');
      expect(updated.id, 'r1');
    });

    test('toJson produces correct map', () {
      final reminder = NoteReminder(
        id: 'r1', noteId: 'n1',
        scheduledAt: DateTime(2026, 3, 17),
        frequency: ReminderFrequency.weekly,
        customMessage: 'Check in',
      );
      final json = reminder.toJson();
      expect(json['id'], 'r1');
      expect(json['frequency'], 'weekly');
      expect(json['customMessage'], 'Check in');
    });

    test('fromJson parses correctly', () {
      final reminder = NoteReminder.fromJson({
        'id': 'parsed', 'noteId': 'n2',
        'scheduledAt': '2026-03-17T09:00:00.000',
        'frequency': 'monthly',
        'isActive': false,
      });
      expect(reminder.id, 'parsed');
      expect(reminder.frequency, ReminderFrequency.monthly);
      expect(reminder.isActive, false);
    });

    test('fromJson defaults unknown frequency to once', () {
      final reminder = NoteReminder.fromJson({'frequency': 'invalid'});
      expect(reminder.frequency, ReminderFrequency.once);
    });

    test('toJson/fromJson roundtrip', () {
      final original = NoteReminder(
        id: 'rt', noteId: 'n1',
        scheduledAt: DateTime(2026, 6, 15),
        frequency: ReminderFrequency.daily,
        isActive: true, customMessage: 'Reminder!',
      );
      final restored = NoteReminder.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.frequency, original.frequency);
      expect(restored.customMessage, original.customMessage);
    });
  });

  group('NoteToSelf', () {
    test('constructs with required fields', () {
      final now = DateTime.now();
      final note = NoteToSelf(
        id: 'note-1', createdAt: now, updatedAt: now,
        title: 'My Note', content: 'Content here',
      );
      expect(note.id, 'note-1');
      expect(note.title, 'My Note');
      expect(note.isPinned, false);
      expect(note.tags, isEmpty);
      expect(note.isPrivate, false);
    });

    test('preview returns first line truncated to 80 chars', () {
      final note = NoteToSelf(
        id: '1', createdAt: DateTime.now(), updatedAt: DateTime.now(),
        title: 'T', content: 'A' * 100,
      );
      expect(note.preview.length, 83); // 80 + "..."
      expect(note.preview.endsWith('...'), true);
    });

    test('preview returns full first line if under 80 chars', () {
      final note = NoteToSelf(
        id: '1', createdAt: DateTime.now(), updatedAt: DateTime.now(),
        title: 'T', content: 'Short note',
      );
      expect(note.preview, 'Short note');
    });

    test('preview uses only first line', () {
      final note = NoteToSelf(
        id: '1', createdAt: DateTime.now(), updatedAt: DateTime.now(),
        title: 'T', content: 'Line 1\nLine 2\nLine 3',
      );
      expect(note.preview, 'Line 1');
    });

    test('copyWith changes specified fields', () {
      final note = NoteToSelf(
        id: '1', createdAt: DateTime.now(), updatedAt: DateTime.now(),
        title: 'Old', content: 'Old content', isPinned: false,
      );
      final updated = note.copyWith(title: 'New', isPinned: true);
      expect(updated.title, 'New');
      expect(updated.isPinned, true);
      expect(updated.content, 'Old content');
    });

    test('toJson produces correct map', () {
      final note = NoteToSelf(
        id: 'json-note', createdAt: DateTime(2026, 3, 17),
        updatedAt: DateTime(2026, 3, 17),
        title: 'Test', content: 'Body',
        tags: ['important', 'work'], isPrivate: true,
      );
      final json = note.toJson();
      expect(json['id'], 'json-note');
      expect(json['title'], 'Test');
      expect(json['tags'], ['important', 'work']);
      expect(json['isPrivate'], true);
    });

    test('fromJson parses correctly', () {
      final note = NoteToSelf.fromJson({
        'id': 'parsed', 'title': 'Parsed Note', 'content': 'Body',
        'createdAt': '2026-03-17T00:00:00.000',
        'updatedAt': '2026-03-17T00:00:00.000',
        'isPinned': true, 'tags': ['test'],
        'moodAtCreation': 'happy', 'isPrivate': false,
      });
      expect(note.id, 'parsed');
      expect(note.title, 'Parsed Note');
      expect(note.isPinned, true);
      expect(note.tags, ['test']);
      expect(note.moodAtCreation, 'happy');
    });

    test('fromJson handles missing fields', () {
      final note = NoteToSelf.fromJson({});
      expect(note.id, '');
      expect(note.title, '');
      expect(note.isPinned, false);
      expect(note.tags, isEmpty);
      expect(note.isPrivate, false);
    });

    test('toJson/fromJson roundtrip', () {
      final original = NoteToSelf(
        id: 'rt', createdAt: DateTime(2026, 6, 15),
        updatedAt: DateTime(2026, 6, 15),
        title: 'Roundtrip', content: 'Full test',
        isPinned: true, tags: ['a', 'b'],
        linkedJournalEntryId: 'j1', moodAtCreation: 'calm',
        isPrivate: true,
      );
      final restored = NoteToSelf.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.isPinned, original.isPinned);
      expect(restored.tags, original.tags);
      expect(restored.linkedJournalEntryId, original.linkedJournalEntryId);
      expect(restored.isPrivate, original.isPrivate);
    });
  });
}
