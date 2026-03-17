import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/ritual_service.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';

void main() {
  group('RitualTime', () {
    test('has three values', () {
      expect(RitualTime.values.length, 3);
      expect(RitualTime.values, contains(RitualTime.morning));
      expect(RitualTime.values, contains(RitualTime.midday));
      expect(RitualTime.values, contains(RitualTime.evening));
    });

    test('displayNameEn returns correct names', () {
      expect(RitualTime.morning.displayNameEn, 'Morning');
      expect(RitualTime.midday.displayNameEn, 'Midday');
      expect(RitualTime.evening.displayNameEn, 'Evening');
    });

    test('displayNameTr returns Turkish names', () {
      expect(RitualTime.morning.displayNameTr, 'Sabah');
      expect(RitualTime.midday.displayNameTr, 'Öğle');
      expect(RitualTime.evening.displayNameTr, 'Akşam');
    });

    test('localizedName returns correct for language', () {
      expect(RitualTime.morning.localizedName(AppLanguage.en), 'Morning');
      expect(RitualTime.morning.localizedName(AppLanguage.tr), 'Sabah');
    });

    test('icon returns emoji', () {
      expect(RitualTime.morning.icon, '🌅');
      expect(RitualTime.midday.icon, '☀️');
      expect(RitualTime.evening.icon, '🌙');
    });
  });

  group('RitualItem', () {
    test('constructs correctly', () {
      const item = RitualItem(id: 'item-1', name: 'Meditate', order: 0);
      expect(item.id, 'item-1');
      expect(item.name, 'Meditate');
      expect(item.order, 0);
    });

    test('toJson produces correct map', () {
      const item = RitualItem(id: 'item-1', name: 'Stretch', order: 1);
      final json = item.toJson();
      expect(json['id'], 'item-1');
      expect(json['name'], 'Stretch');
      expect(json['order'], 1);
    });

    test('fromJson parses correctly', () {
      final item = RitualItem.fromJson({
        'id': 'parsed', 'name': 'Journal', 'order': 2,
      });
      expect(item.id, 'parsed');
      expect(item.name, 'Journal');
      expect(item.order, 2);
    });

    test('fromJson handles missing fields', () {
      final item = RitualItem.fromJson({});
      expect(item.id, '');
      expect(item.name, '');
      expect(item.order, 0);
    });
  });

  group('RitualStack', () {
    test('constructs correctly', () {
      final stack = RitualStack(
        id: 'stack-1',
        time: RitualTime.morning,
        name: 'Morning Routine',
        items: const [
          RitualItem(id: '1', name: 'Meditate', order: 0),
          RitualItem(id: '2', name: 'Journal', order: 1),
        ],
        createdAt: DateTime(2026, 3, 17),
      );
      expect(stack.id, 'stack-1');
      expect(stack.time, RitualTime.morning);
      expect(stack.items.length, 2);
    });

    test('copyWith changes name', () {
      final stack = RitualStack(
        id: '1', time: RitualTime.morning, name: 'Old',
        items: const [], createdAt: DateTime(2026, 1, 1),
      );
      final updated = stack.copyWith(name: 'New Name');
      expect(updated.name, 'New Name');
      expect(updated.id, '1');
    });

    test('toJson produces correct map', () {
      final stack = RitualStack(
        id: 's1', time: RitualTime.evening, name: 'Wind Down',
        items: const [RitualItem(id: 'i1', name: 'Read', order: 0)],
        createdAt: DateTime(2026, 3, 17),
      );
      final json = stack.toJson();
      expect(json['id'], 's1');
      expect(json['time'], 'evening');
      expect(json['name'], 'Wind Down');
      expect((json['items'] as List).length, 1);
    });

    test('fromJson parses correctly', () {
      final stack = RitualStack.fromJson({
        'id': 'parsed',
        'time': 'morning',
        'name': 'Start Day',
        'items': [{'id': 'i1', 'name': 'Breathe', 'order': 0}],
        'createdAt': '2026-03-17T00:00:00.000',
      });
      expect(stack.id, 'parsed');
      expect(stack.time, RitualTime.morning);
      expect(stack.name, 'Start Day');
      expect(stack.items.length, 1);
      expect(stack.items[0].name, 'Breathe');
    });

    test('fromJson defaults unknown time to morning', () {
      final stack = RitualStack.fromJson({'time': 'invalid'});
      expect(stack.time, RitualTime.morning);
    });

    test('toJson/fromJson roundtrip', () {
      final original = RitualStack(
        id: 'rt', time: RitualTime.midday, name: 'Lunch Break',
        items: const [
          RitualItem(id: 'a', name: 'Walk', order: 0),
          RitualItem(id: 'b', name: 'Stretch', order: 1),
        ],
        createdAt: DateTime(2026, 6, 15),
      );
      final restored = RitualStack.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.time, original.time);
      expect(restored.name, original.name);
      expect(restored.items.length, 2);
      expect(restored.items[0].name, 'Walk');
      expect(restored.items[1].name, 'Stretch');
    });
  });
}
