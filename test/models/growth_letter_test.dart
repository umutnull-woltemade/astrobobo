import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/growth_letter.dart';

void main() {
  group('LetterType', () {
    test('has four types', () {
      expect(LetterType.values.length, 4);
    });

    test('each has English name', () {
      expect(LetterType.toFutureSelf.nameEn(), 'To Future Self');
      expect(LetterType.toPastSelf.nameEn(), 'To Past Self');
      expect(LetterType.growthMilestone.nameEn(), 'Growth Milestone');
      expect(LetterType.gratitudeLetter.nameEn(), 'Gratitude Letter');
    });

    test('each has emoji', () {
      for (final type in LetterType.values) {
        expect(type.emoji, isNotEmpty);
      }
    });
  });

  group('GrowthLetter', () {
    test('constructs with required fields', () {
      final letter = GrowthLetter(
        letterType: LetterType.toFutureSelf,
        title: 'Dear Future Me',
        body: 'I hope you are well.',
      );
      expect(letter.id, isNotEmpty);
      expect(letter.title, 'Dear Future Me');
      expect(letter.letterType, LetterType.toFutureSelf);
    });

    test('wordCount counts correctly', () {
      final letter = GrowthLetter(
        letterType: LetterType.toPastSelf,
        title: 'T', body: 'Hello world from the past',
      );
      expect(letter.wordCount, 5);
    });

    test('wordCount handles empty body', () {
      final letter = GrowthLetter(
        letterType: LetterType.toFutureSelf, title: 'T', body: '',
      );
      expect(letter.wordCount, 0);
    });

    test('copyWith changes fields', () {
      final original = GrowthLetter(
        letterType: LetterType.growthMilestone,
        title: 'Old', body: 'Old body',
      );
      final updated = original.copyWith(title: 'New', body: 'New body');
      expect(updated.title, 'New');
      expect(updated.body, 'New body');
      expect(updated.id, original.id);
      expect(updated.letterType, original.letterType);
    });

    test('toJson produces correct map', () {
      final letter = GrowthLetter(
        id: 'gl-1', letterType: LetterType.gratitudeLetter,
        title: 'Thanks', body: 'Thank you.',
        createdAt: DateTime(2026, 3, 17),
      );
      final json = letter.toJson();
      expect(json['id'], 'gl-1');
      expect(json['letterType'], 'gratitudeLetter');
      expect(json['title'], 'Thanks');
    });

    test('fromJson parses correctly', () {
      final letter = GrowthLetter.fromJson({
        'id': 'parsed', 'letterType': 'toPastSelf',
        'title': 'Parsed', 'body': 'Content',
        'createdAt': '2026-03-17T00:00:00.000',
      });
      expect(letter.id, 'parsed');
      expect(letter.letterType, LetterType.toPastSelf);
    });

    test('fromJson defaults unknown letterType to toFutureSelf', () {
      final letter = GrowthLetter.fromJson({'letterType': 'invalid'});
      expect(letter.letterType, LetterType.toFutureSelf);
    });

    test('toJson/fromJson roundtrip', () {
      final original = GrowthLetter(
        id: 'rt', letterType: LetterType.growthMilestone,
        title: 'Milestone', body: 'I did it!',
      );
      final restored = GrowthLetter.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.letterType, original.letterType);
      expect(restored.title, original.title);
      expect(restored.body, original.body);
    });
  });
}
