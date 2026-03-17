import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/backup_restore_service.dart';

void main() {
  group('BackupMetadata', () {
    test('constructs with required fields', () {
      final now = DateTime.now();
      final metadata = BackupMetadata(
        version: '1.0.0',
        createdAt: now,
        deviceName: 'TestDevice',
        entryCount: 42,
        checksum: 'abc123',
      );
      expect(metadata.version, '1.0.0');
      expect(metadata.createdAt, now);
      expect(metadata.deviceName, 'TestDevice');
      expect(metadata.entryCount, 42);
      expect(metadata.checksum, 'abc123');
    });

    test('toJson produces correct map', () {
      final now = DateTime(2026, 3, 17, 12, 0, 0);
      final metadata = BackupMetadata(
        version: '1.0.0',
        createdAt: now,
        deviceName: 'iPhone',
        entryCount: 100,
        checksum: 'sha256hash',
      );
      final json = metadata.toJson();
      expect(json['version'], '1.0.0');
      expect(json['device_name'], 'iPhone');
      expect(json['entry_count'], 100);
      expect(json['checksum'], 'sha256hash');
      expect(json['created_at'], contains('2026-03-17'));
    });

    test('fromJson parses correctly', () {
      final json = {
        'version': '1.0.0',
        'created_at': '2026-03-17T12:00:00.000',
        'device_name': 'iPad',
        'entry_count': 55,
        'checksum': 'hash123',
      };
      final metadata = BackupMetadata.fromJson(json);
      expect(metadata.version, '1.0.0');
      expect(metadata.deviceName, 'iPad');
      expect(metadata.entryCount, 55);
      expect(metadata.checksum, 'hash123');
      expect(metadata.createdAt.year, 2026);
    });

    test('fromJson handles missing fields', () {
      final metadata = BackupMetadata.fromJson({});
      expect(metadata.version, '1.0.0');
      expect(metadata.deviceName, 'Unknown');
      expect(metadata.entryCount, 0);
      expect(metadata.checksum, '');
    });

    test('fromJson handles null values', () {
      final metadata = BackupMetadata.fromJson({
        'version': null,
        'created_at': null,
        'device_name': null,
        'entry_count': null,
        'checksum': null,
      });
      expect(metadata.version, '1.0.0');
      expect(metadata.deviceName, 'Unknown');
      expect(metadata.entryCount, 0);
    });

    test('toJson/fromJson roundtrip', () {
      final original = BackupMetadata(
        version: '2.0.0',
        createdAt: DateTime(2026, 6, 15),
        deviceName: 'MacBook',
        entryCount: 999,
        checksum: 'roundtrip_hash',
      );
      final json = original.toJson();
      final restored = BackupMetadata.fromJson(json);
      expect(restored.version, original.version);
      expect(restored.deviceName, original.deviceName);
      expect(restored.entryCount, original.entryCount);
      expect(restored.checksum, original.checksum);
    });
  });

  group('BackupResult', () {
    test('success result has file path', () {
      final result = BackupResult(success: true, filePath: '/path/to/backup.json');
      expect(result.success, true);
      expect(result.filePath, '/path/to/backup.json');
      expect(result.error, isNull);
    });

    test('failure result has error', () {
      final result = BackupResult(success: false, error: 'Disk full');
      expect(result.success, false);
      expect(result.filePath, isNull);
      expect(result.error, 'Disk full');
    });
  });

  group('RestoreResult', () {
    test('success result has entry count', () {
      final result = RestoreResult(success: true, restoredEntries: 42);
      expect(result.success, true);
      expect(result.restoredEntries, 42);
      expect(result.error, isNull);
    });

    test('failure result has error and zero entries', () {
      final result = RestoreResult(success: false, error: 'Corrupted file');
      expect(result.success, false);
      expect(result.restoredEntries, 0);
      expect(result.error, 'Corrupted file');
    });

    test('default restoredEntries is 0', () {
      final result = RestoreResult(success: true);
      expect(result.restoredEntries, 0);
    });
  });
}
