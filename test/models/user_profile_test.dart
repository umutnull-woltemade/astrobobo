import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/user_profile.dart';

void main() {
  group('UserProfile', () {
    test('constructs with required birthDate', () {
      final profile = UserProfile(birthDate: DateTime(1990, 5, 15));
      expect(profile.id, isNotEmpty);
      expect(profile.birthDate.year, 1990);
      expect(profile.isPrimary, false);
      expect(profile.name, isNull);
      expect(profile.avatarEmoji, isNull);
    });

    test('generates UUID if id not provided', () {
      final p1 = UserProfile(birthDate: DateTime(2000, 1, 1));
      final p2 = UserProfile(birthDate: DateTime(2000, 1, 1));
      expect(p1.id, isNot(equals(p2.id)));
    });

    test('uses provided id', () {
      final profile = UserProfile(id: 'custom-id', birthDate: DateTime(2000, 1, 1));
      expect(profile.id, 'custom-id');
    });

    test('toJson produces correct map', () {
      final profile = UserProfile(
        id: 'json-id', name: 'Test User',
        birthDate: DateTime(1990, 5, 15),
        birthPlace: 'Istanbul', isPrimary: true,
        avatarEmoji: '🌟', relationship: 'self',
      );
      final json = profile.toJson();
      expect(json['id'], 'json-id');
      expect(json['name'], 'Test User');
      expect(json['birthPlace'], 'Istanbul');
      expect(json['isPrimary'], true);
      expect(json['avatarEmoji'], '🌟');
      expect(json['relationship'], 'self');
    });

    test('fromJson parses correctly', () {
      final profile = UserProfile.fromJson({
        'id': 'parsed', 'name': 'Parsed User',
        'birthDate': '1990-05-15T00:00:00.000',
        'isPrimary': true, 'avatarEmoji': '😊',
        'birthLatitude': 41.0, 'birthLongitude': 29.0,
      });
      expect(profile.id, 'parsed');
      expect(profile.name, 'Parsed User');
      expect(profile.birthDate.year, 1990);
      expect(profile.isPrimary, true);
      expect(profile.birthLatitude, 41.0);
    });

    test('fromJson defaults birthDate to 2000-01-01 if missing', () {
      final profile = UserProfile.fromJson({});
      expect(profile.birthDate.year, 2000);
    });

    test('toJson/fromJson roundtrip', () {
      final original = UserProfile(
        id: 'rt', name: 'Roundtrip', birthDate: DateTime(1995, 12, 25),
        birthTime: '14:30', birthPlace: 'Ankara',
        isPrimary: true, relationship: 'partner', avatarEmoji: '💜',
      );
      final restored = UserProfile.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.birthDate.year, original.birthDate.year);
      expect(restored.birthTime, original.birthTime);
      expect(restored.birthPlace, original.birthPlace);
      expect(restored.isPrimary, original.isPrimary);
      expect(restored.relationship, original.relationship);
      expect(restored.avatarEmoji, original.avatarEmoji);
    });
  });
}
