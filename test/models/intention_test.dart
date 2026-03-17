import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/intention.dart';

void main() {
  group('Intention', () {
    test('constructs with required fields', () {
      final i = Intention(
        id: 'int-1', text: 'Be present', weekKey: '2026-W12',
        createdAt: DateTime(2026, 3, 17),
      );
      expect(i.id, 'int-1');
      expect(i.text, 'Be present');
      expect(i.weekKey, '2026-W12');
      expect(i.selfRating, isNull);
      expect(i.isActive, true);
    });

    test('copyWith changes selfRating', () {
      final original = Intention(
        id: '1', text: 'Focus', weekKey: '2026-W12',
        createdAt: DateTime(2026, 3, 17),
      );
      final rated = original.copyWith(selfRating: 4);
      expect(rated.selfRating, 4);
      expect(rated.text, 'Focus');
      expect(rated.isActive, true);
    });

    test('copyWith changes isActive', () {
      final original = Intention(
        id: '1', text: 'Test', weekKey: '2026-W12',
        createdAt: DateTime.now(),
      );
      final deactivated = original.copyWith(isActive: false);
      expect(deactivated.isActive, false);
    });

    test('toJson produces correct map', () {
      final i = Intention(
        id: 'json-1', text: 'Breathe deeply', weekKey: '2026-W12',
        selfRating: 3, isActive: false,
        createdAt: DateTime(2026, 3, 17),
      );
      final json = i.toJson();
      expect(json['id'], 'json-1');
      expect(json['text'], 'Breathe deeply');
      expect(json['weekKey'], '2026-W12');
      expect(json['selfRating'], 3);
      expect(json['isActive'], false);
    });

    test('fromJson parses correctly', () {
      final i = Intention.fromJson({
        'id': 'parsed', 'text': 'Be kind', 'weekKey': '2026-W10',
        'selfRating': 5, 'isActive': true,
        'createdAt': '2026-03-10T00:00:00.000',
      });
      expect(i.id, 'parsed');
      expect(i.text, 'Be kind');
      expect(i.selfRating, 5);
    });

    test('fromJson handles missing fields', () {
      final i = Intention.fromJson({});
      expect(i.id, '');
      expect(i.text, '');
      expect(i.selfRating, isNull);
      expect(i.isActive, true);
    });

    test('toJson/fromJson roundtrip', () {
      final original = Intention(
        id: 'rt', text: 'Stay calm', weekKey: '2026-W25',
        selfRating: 4, isActive: true,
        createdAt: DateTime(2026, 6, 15),
      );
      final restored = Intention.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.text, original.text);
      expect(restored.weekKey, original.weekKey);
      expect(restored.selfRating, original.selfRating);
      expect(restored.isActive, original.isActive);
    });
  });
}
