import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/models/vault_photo.dart';

void main() {
  group('VaultPhoto', () {
    test('constructs with required fields', () {
      final photo = VaultPhoto(
        id: 'photo-1',
        filePath: '/path/to/photo.jpg',
        createdAt: DateTime(2026, 3, 17),
      );
      expect(photo.id, 'photo-1');
      expect(photo.filePath, '/path/to/photo.jpg');
      expect(photo.createdAt.year, 2026);
      expect(photo.caption, isNull);
      expect(photo.thumbnailPath, isNull);
    });

    test('toJson produces correct map', () {
      final photo = VaultPhoto(
        id: 'photo-json',
        filePath: '/photos/vault/img.png',
        createdAt: DateTime(2026, 3, 17, 14, 30),
        caption: 'My secret photo',
      );
      final json = photo.toJson();
      expect(json['id'], 'photo-json');
      expect(json['filePath'], '/photos/vault/img.png');
      expect(json['caption'], 'My secret photo');
      expect(json['createdAt'], contains('2026-03-17'));
      expect(json['thumbnailPath'], isNull);
    });

    test('fromJson parses correctly', () {
      final photo = VaultPhoto.fromJson({
        'id': 'parsed-id',
        'filePath': '/path/img.jpg',
        'createdAt': '2026-03-17T14:30:00.000',
        'caption': 'Test label',
        'thumbnailPath': '/thumb.jpg',
      });
      expect(photo.id, 'parsed-id');
      expect(photo.filePath, '/path/img.jpg');
      expect(photo.caption, 'Test label');
      expect(photo.thumbnailPath, '/thumb.jpg');
      expect(photo.createdAt.hour, 14);
    });

    test('fromJson handles missing optional fields', () {
      final photo = VaultPhoto.fromJson({
        'id': 'minimal',
        'filePath': '/img.jpg',
        'createdAt': '2026-01-01',
      });
      expect(photo.id, 'minimal');
      expect(photo.caption, isNull);
      expect(photo.thumbnailPath, isNull);
    });

    test('fromJson handles empty map', () {
      final photo = VaultPhoto.fromJson({});
      expect(photo.id, '');
      expect(photo.filePath, '');
    });

    test('copyWith creates new instance with changed fields', () {
      final original = VaultPhoto(
        id: 'orig',
        filePath: '/orig.jpg',
        createdAt: DateTime(2026, 1, 1),
        caption: 'original',
      );
      final copied = original.copyWith(caption: 'updated');
      expect(copied.id, 'orig');
      expect(copied.filePath, '/orig.jpg');
      expect(copied.caption, 'updated');
    });

    test('toJson/fromJson roundtrip', () {
      final original = VaultPhoto(
        id: 'roundtrip',
        filePath: '/vault/secret.jpg',
        createdAt: DateTime(2026, 6, 15, 10, 0),
        caption: 'Important memory',
        thumbnailPath: '/vault/thumb_secret.jpg',
      );
      final restored = VaultPhoto.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.filePath, original.filePath);
      expect(restored.caption, original.caption);
      expect(restored.thumbnailPath, original.thumbnailPath);
    });
  });
}
