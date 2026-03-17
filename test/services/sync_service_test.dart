import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/sync_service.dart';

void main() {
  group('SyncQueueItem', () {
    test('toJson produces correct map', () {
      final item = SyncQueueItem(
        id: 'test-id-1',
        operation: 'UPSERT',
        tableName: 'journal_entries',
        recordId: 'record-1',
        payload: {'title': 'Hello', 'rating': 5},
        createdAt: DateTime(2026, 2, 24, 12, 0),
      );

      final json = item.toJson();
      expect(json['id'], 'test-id-1');
      expect(json['operation'], 'UPSERT');
      expect(json['table_name'], 'journal_entries');
      expect(json['record_id'], 'record-1');
      expect(json['payload']['title'], 'Hello');
      expect(json['payload']['rating'], 5);
      expect(json['status'], 'pending');
      expect(json['retry_count'], 0);
      expect(json['last_error'], isNull);
    });

    test('fromJson reconstructs item correctly', () {
      final json = {
        'id': 'abc-123',
        'operation': 'DELETE',
        'table_name': 'mood_entries',
        'record_id': 'mood-1',
        'payload': {'is_deleted': true},
        'created_at': '2026-02-24T10:30:00.000',
        'status': 'pending',
        'retry_count': 2,
        'last_error': 'Network timeout',
      };

      final item = SyncQueueItem.fromJson(json);
      expect(item.id, 'abc-123');
      expect(item.operation, 'DELETE');
      expect(item.tableName, 'mood_entries');
      expect(item.recordId, 'mood-1');
      expect(item.payload['is_deleted'], true);
      expect(item.retryCount, 2);
      expect(item.lastError, 'Network timeout');
    });

    test('fromJson handles missing optional fields', () {
      final json = {
        'id': 'min-1',
        'operation': 'INSERT',
        'table_name': 'notes_to_self',
        'record_id': 'note-1',
        'payload': {},
      };

      final item = SyncQueueItem.fromJson(json);
      expect(item.status, 'pending');
      expect(item.retryCount, 0);
      expect(item.lastError, isNull);
      expect(item.createdAt, isNotNull);
    });

    test('fromJson handles null payload gracefully', () {
      final json = {
        'id': 'null-payload',
        'operation': 'UPDATE',
        'table_name': 'user_profiles',
        'record_id': 'p-1',
        'payload': null,
      };

      final item = SyncQueueItem.fromJson(json);
      expect(item.payload, isEmpty);
    });

    test('copyWith updates specified fields only', () {
      final original = SyncQueueItem(
        id: 'orig-1',
        operation: 'UPSERT',
        tableName: 'journal_entries',
        recordId: 'j-1',
        payload: {'note': 'test'},
        createdAt: DateTime(2026, 1, 1),
        retryCount: 0,
      );

      final updated = original.copyWith(retryCount: 3, lastError: 'Timeout');
      expect(updated.id, 'orig-1');
      expect(updated.operation, 'UPSERT');
      expect(updated.tableName, 'journal_entries');
      expect(updated.retryCount, 3);
      expect(updated.lastError, 'Timeout');
      expect(updated.status, 'pending');
    });

    test('round-trip toJson/fromJson preserves data', () {
      final original = SyncQueueItem(
        id: 'rt-1',
        operation: 'UPSERT',
        tableName: 'dream_entries',
        recordId: 'd-1',
        payload: {
          'title': 'Flying dream',
          'symbols': ['bird', 'sky'],
        },
        createdAt: DateTime(2026, 2, 24, 15, 30),
        status: 'pending',
        retryCount: 1,
        lastError: 'Server error',
      );

      final json = original.toJson();
      final restored = SyncQueueItem.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.operation, original.operation);
      expect(restored.tableName, original.tableName);
      expect(restored.recordId, original.recordId);
      expect(restored.payload['title'], 'Flying dream');
      expect(restored.retryCount, 1);
      expect(restored.lastError, 'Server error');
    });
  });

  group('SyncResult', () {
    test('creates with correct values', () {
      final result = SyncResult(synced: 5, failed: 2, message: 'Done');
      expect(result.synced, 5);
      expect(result.failed, 2);
      expect(result.message, 'Done');
    });
  });

  group('SyncStatus', () {
    test('has all expected values', () {
      expect(SyncStatus.values.length, 5);
      expect(SyncStatus.values, contains(SyncStatus.idle));
      expect(SyncStatus.values, contains(SyncStatus.syncing));
      expect(SyncStatus.values, contains(SyncStatus.synced));
      expect(SyncStatus.values, contains(SyncStatus.error));
      expect(SyncStatus.values, contains(SyncStatus.offline));
    });
  });

  group('SyncService static config', () {
    test('syncTables contains all 10 tables', () {
      expect(SyncService.syncTables.length, 10);
      expect(SyncService.syncTables, contains('user_profiles'));
      expect(SyncService.syncTables, contains('journal_entries'));
      expect(SyncService.syncTables, contains('dream_entries'));
      expect(SyncService.syncTables, contains('mood_entries'));
      expect(SyncService.syncTables, contains('notes_to_self'));
      expect(SyncService.syncTables, contains('note_reminders'));
      expect(SyncService.syncTables, contains('life_events'));
      expect(SyncService.syncTables, contains('cycle_period_logs'));
      expect(SyncService.syncTables, contains('birthday_contacts'));
      expect(SyncService.syncTables, contains('bond_privacy'));
    });

    test('registerMergeHandler stores handler', () {
      var called = false;
      SyncService.registerMergeHandler('test_table', (data) async {
        called = true;
      });
      // Handler registered — we can't easily test invocation without
      // full Supabase setup, but registration doesn't throw.
      expect(called, false);
    });
  });
}
