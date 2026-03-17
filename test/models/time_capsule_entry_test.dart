import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/time_capsule_entry.dart';

void main() {
  group('TimeCapsuleEntry', () {
    test('constructs with required fields', () {
      final entry = TimeCapsuleEntry(
        id: 'tc-1',
        content: 'Dear future me...',
        createdAt: DateTime(2026, 3, 17),
        deliveryDate: DateTime(2027, 3, 17),
      );
      expect(entry.id, 'tc-1');
      expect(entry.content, 'Dear future me...');
      expect(entry.isDelivered, false);
      expect(entry.isOpened, false);
    });

    test('dateKey formats correctly', () {
      final entry = TimeCapsuleEntry(
        id: '1', content: '', createdAt: DateTime(2026, 3, 5),
        deliveryDate: DateTime(2027, 1, 1),
      );
      expect(entry.dateKey, '2026-03-05');
    });

    test('deliveryDateKey formats correctly', () {
      final entry = TimeCapsuleEntry(
        id: '1', content: '', createdAt: DateTime(2026, 1, 1),
        deliveryDate: DateTime(2027, 12, 25),
      );
      expect(entry.deliveryDateKey, '2027-12-25');
    });

    test('isReadyToDeliver is true when past delivery date and not opened', () {
      final entry = TimeCapsuleEntry(
        id: '1', content: 'test',
        createdAt: DateTime(2025, 1, 1),
        deliveryDate: DateTime(2025, 6, 1), // Past
      );
      expect(entry.isReadyToDeliver, true);
    });

    test('isReadyToDeliver is false when already opened', () {
      final entry = TimeCapsuleEntry(
        id: '1', content: 'test',
        createdAt: DateTime(2025, 1, 1),
        deliveryDate: DateTime(2025, 6, 1),
        isOpened: true,
      );
      expect(entry.isReadyToDeliver, false);
    });

    test('copyWith changes specified fields', () {
      final original = TimeCapsuleEntry(
        id: '1', content: 'test',
        createdAt: DateTime(2026, 1, 1),
        deliveryDate: DateTime(2027, 1, 1),
      );
      final opened = original.copyWith(isOpened: true, isDelivered: true);
      expect(opened.isOpened, true);
      expect(opened.isDelivered, true);
      expect(opened.id, '1');
      expect(opened.content, 'test');
    });

    test('toJson produces correct map', () {
      final entry = TimeCapsuleEntry(
        id: 'tc-json', content: 'Hello future!',
        createdAt: DateTime(2026, 3, 17),
        deliveryDate: DateTime(2027, 3, 17),
        isDelivered: true,
      );
      final json = entry.toJson();
      expect(json['id'], 'tc-json');
      expect(json['content'], 'Hello future!');
      expect(json['isDelivered'], true);
      expect(json['isOpened'], false);
    });

    test('fromJson parses correctly', () {
      final entry = TimeCapsuleEntry.fromJson({
        'id': 'parsed',
        'content': 'Future message',
        'createdAt': '2026-03-17T00:00:00.000',
        'deliveryDate': '2027-03-17T00:00:00.000',
        'isDelivered': true,
        'isOpened': false,
      });
      expect(entry.id, 'parsed');
      expect(entry.content, 'Future message');
      expect(entry.isDelivered, true);
    });

    test('fromJson handles missing fields', () {
      final entry = TimeCapsuleEntry.fromJson({});
      expect(entry.id, '');
      expect(entry.content, '');
      expect(entry.isDelivered, false);
      expect(entry.isOpened, false);
    });

    test('toJson/fromJson roundtrip', () {
      final original = TimeCapsuleEntry(
        id: 'roundtrip', content: 'See you in a year',
        createdAt: DateTime(2026, 6, 15),
        deliveryDate: DateTime(2027, 6, 15),
        isDelivered: false, isOpened: false,
      );
      final restored = TimeCapsuleEntry.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.content, original.content);
      expect(restored.isDelivered, original.isDelivered);
    });
  });
}
