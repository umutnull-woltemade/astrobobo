import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'storage_service.dart' show StorageService;

/// Offline-first sync service for Supabase
/// Queues operations when offline and syncs when connectivity is restored
class SyncService {
  static const String _syncQueueBoxName = 'sync_queue_box';
  static const _uuid = Uuid();
  static Box? _syncBox;
  static Completer<SyncResult>? _syncCompleter;
  static StreamSubscription<List<ConnectivityResult>>? _connectivitySub;

  /// Stream controller for sync status updates
  static StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  /// Stream of sync status changes
  static Stream<SyncStatus> get statusStream => _statusController.stream;

  /// Current sync status
  static SyncStatus _currentStatus = SyncStatus.idle;
  static SyncStatus get currentStatus => _currentStatus;

  /// All tables that participate in sync
  static const List<String> syncTables = [
    'user_profiles',
    'journal_entries',
    'dream_entries',
    'mood_entries',
    'notes_to_self',
    'note_reminders',
    'life_events',
    'cycle_period_logs',
    'birthday_contacts',
    'bond_privacy',
  ];

  /// Registered merge handlers for pull sync (table → merge callback)
  static final Map<String, Future<void> Function(List<Map<String, dynamic>>)>
  _mergeHandlers = {};

  /// Periodic sync timer
  static Timer? _periodicSyncTimer;

  /// Register a merge handler for a table (called by each service on init)
  static void registerMergeHandler(
    String tableName,
    Future<void> Function(List<Map<String, dynamic>>) handler,
  ) {
    _mergeHandlers[tableName] = handler;
  }

  /// Initialize the sync service
  static Future<void> initialize() async {
    if (kIsWeb) {
      if (kDebugMode) {
        debugPrint('SyncService: Web mode - sync queue disabled');
      }
      return;
    }

    try {
      // Recreate stream controller if previously closed
      if (_statusController.isClosed) {
        _statusController = StreamController<SyncStatus>.broadcast();
      }

      // Open sync box with encryption (same key as StorageService)
      final cipher = await StorageService.getHiveEncryptionCipher();
      try {
        _syncBox = cipher != null
            ? await Hive.openBox(_syncQueueBoxName, encryptionCipher: cipher)
            : await Hive.openBox(_syncQueueBoxName);
      } catch (_) {
        // Migration: if existing box is unencrypted, re-create with encryption
        if (cipher != null) {
          try {
            final oldBox = await Hive.openBox(_syncQueueBoxName);
            final data = Map<dynamic, dynamic>.from(oldBox.toMap());
            await oldBox.close();
            await Hive.deleteBoxFromDisk(_syncQueueBoxName);
            _syncBox = await Hive.openBox(_syncQueueBoxName, encryptionCipher: cipher);
            for (final entry in data.entries) {
              await _syncBox!.put(entry.key, entry.value);
            }
          } catch (e2) {
            _syncBox = await Hive.openBox(_syncQueueBoxName);
            if (kDebugMode) debugPrint('SyncService: Encryption migration failed: $e2');
          }
        } else {
          _syncBox = await Hive.openBox(_syncQueueBoxName);
        }
      }

      // Purge stale queue items (older than 30 days)
      await SyncService.purgeStaleQueueItems();

      // Listen for connectivity changes (cancel previous if re-initialized)
      _connectivitySub?.cancel();
      _connectivitySub = Connectivity().onConnectivityChanged.listen((
        List<ConnectivityResult> result,
      ) {
        if (!result.contains(ConnectivityResult.none)) {
          syncPendingOperations();
        }
      });

      // Try initial sync
      syncPendingOperations();

      // Start periodic full sync every 5 minutes
      _periodicSyncTimer?.cancel();
      _periodicSyncTimer = Timer.periodic(
        const Duration(minutes: 5),
        (_) => fullSync(),
      );

      if (kDebugMode) {
        debugPrint(
          'SyncService: Initialized with ${_syncBox?.length ?? 0} pending operations',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SyncService: Initialization error: $e');
      }
    }
  }

  /// Dispose resources (cancel connectivity listener, timer, and stream)
  static void dispose() {
    _connectivitySub?.cancel();
    _connectivitySub = null;
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = null;
    _statusController.close();
  }

  /// Clear all pending sync operations (call on sign-out to prevent cross-user contamination)
  static Future<void> clearQueue() async {
    final box = _syncBox;
    if (box == null) return;
    final count = box.length;
    await box.clear();
    _updateStatus(SyncStatus.idle);
    if (kDebugMode && count > 0) {
      debugPrint('SyncService: Cleared $count pending queue items on sign-out');
    }
  }

  /// Called when app resumes from background — triggers full sync
  static void onAppResumed() {
    if (kDebugMode) debugPrint('SyncService: App resumed — triggering sync');
    fullSync();
  }

  /// Check if device is online
  static Future<bool> get _isOnline async {
    try {
      final result = await Connectivity().checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } catch (e) {
      if (kDebugMode) debugPrint('Sync: connectivity check error: $e');
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PUBLIC QUEUE API
  // ═══════════════════════════════════════════════════════════════════════════

  /// Queue a sync operation for later execution.
  /// Called by services after local persistence.
  static Future<void> queueOperation({
    required String tableName,
    required String operation,
    required String recordId,
    required Map<String, dynamic> payload,
  }) async {
    final box = _syncBox;
    if (kIsWeb || box == null) return;

    // Create a defensive copy to avoid mutating the caller's map
    final payloadCopy = Map<String, dynamic>.from(payload);

    // Inject user_id from current auth session (skip if Supabase not initialized)
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null && !payloadCopy.containsKey('user_id')) {
        payloadCopy['user_id'] = userId;
      }
    } catch (_) {
      // Supabase not initialized — queue without user_id, will be set on sync
    }

    final item = SyncQueueItem(
      id: _uuid.v4(),
      operation: operation,
      tableName: tableName,
      recordId: recordId,
      payload: payloadCopy,
      createdAt: DateTime.now(),
    );

    await box.put(item.id, jsonEncode(item.toJson()));

    if (kDebugMode) {
      debugPrint('SyncService: Queued $operation on $tableName/$recordId');
    }

    // Try immediate sync if online
    syncPendingOperations();
  }

  /// Number of pending (un-synced) operations in the queue.
  static int get pendingCount {
    final box = _syncBox;
    if (box == null) return 0;
    return box.length;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SYNC TIME TRACKING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get the last successful sync time for a specific table.
  static Future<DateTime?> getLastSyncTime(String tableName) async {
    final prefs = await SharedPreferences.getInstance();
    final ms = prefs.getInt('sync_last_$tableName');
    return ms != null ? DateTime.fromMillisecondsSinceEpoch(ms) : null;
  }

  /// Set the last successful sync time for a specific table.
  static Future<void> setLastSyncTime(String tableName, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sync_last_$tableName', time.millisecondsSinceEpoch);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FULL SYNC & PULL
  // ═══════════════════════════════════════════════════════════════════════════

  /// Push all pending local operations, then pull remote changes for all tables.
  static Future<SyncResult> fullSync() async {
    if (!await _isOnline) {
      return SyncResult(synced: 0, failed: 0, message: 'Offline');
    }

    // First push all pending
    final pushResult = await syncPendingOperations();

    // Then pull for each table
    int pulled = 0;
    for (final table in syncTables) {
      try {
        final lastSync = await getLastSyncTime(table);
        final count = await pullRemoteChanges(table, lastSync);
        pulled += count;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('SyncService: Pull failed for $table: $e');
        }
      }
    }

    return SyncResult(
      synced: pushResult.synced + pulled,
      failed: pushResult.failed,
      message: 'Full sync: pushed ${pushResult.synced}, pulled $pulled',
    );
  }

  /// Pull remote changes for a table since the given timestamp.
  /// Fetches data from Supabase and merges into local storage via registered handler.
  /// Returns the number of records pulled.
  static Future<int> pullRemoteChanges(
    String tableName,
    DateTime? since,
  ) async {
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return 0;

      var query = supabase.from(tableName).select().eq('user_id', userId);

      if (since != null) {
        query = query.gt('updated_at', since.toIso8601String());
      }

      final List<dynamic> data = await query;

      if (data.isEmpty) return 0;

      // Merge into local storage via registered handler
      final handler = _mergeHandlers[tableName];
      if (handler != null) {
        final rows = data
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
        await handler(rows);
        if (kDebugMode) {
          debugPrint('SyncService: Merged ${rows.length} rows for $tableName');
        }
      } else if (kDebugMode) {
        debugPrint(
          'SyncService: No merge handler for $tableName (${data.length} rows skipped)',
        );
      }

      await setLastSyncTime(tableName, DateTime.now());
      return data.length;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SyncService: pullRemoteChanges($tableName) error: $e');
      }
      return 0;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SYNC PENDING OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Sync all pending operations (uses Completer to prevent race conditions)
  static Future<SyncResult> syncPendingOperations() async {
    // If sync is already in progress, await the same result
    if (_syncCompleter != null) {
      return _syncCompleter!.future;
    }

    final box = _syncBox;
    if (kIsWeb || box == null) {
      return SyncResult(synced: 0, failed: 0, message: 'Sync not available');
    }

    if (!await _isOnline) {
      _updateStatus(SyncStatus.offline);
      return SyncResult(synced: 0, failed: 0, message: 'Offline');
    }

    // Skip sync if user is not authenticated — operations will be retried after sign-in
    try {
      if (Supabase.instance.client.auth.currentUser == null) {
        return SyncResult(synced: 0, failed: 0, message: 'Not authenticated');
      }
    } catch (_) {
      return SyncResult(synced: 0, failed: 0, message: 'Supabase not available');
    }

    final completer = Completer<SyncResult>();
    _syncCompleter = completer;
    _updateStatus(SyncStatus.syncing);
    int synced = 0;
    int failed = 0;

    try {
      final keys = box.keys.toList();

      for (final key in keys) {
        final json = box.get(key) as String?;
        if (json == null) continue;

        try {
          final item = SyncQueueItem.fromJson(jsonDecode(json));

          if (item.status == 'synced') {
            await box.delete(key);
            continue;
          }

          // Skip items that have failed too many times
          if (item.retryCount >= 5) {
            failed++;
            continue;
          }

          final success = await _executeOperation(item);

          if (success) {
            await box.delete(key);
            synced++;
          } else {
            // Update retry count
            final updated = item.copyWith(
              retryCount: item.retryCount + 1,
              lastError: 'Sync failed',
            );
            await box.put(key, jsonEncode(updated.toJson()));
            failed++;
          }
        } catch (e) {
          failed++;
          if (kDebugMode) {
            debugPrint('SyncService: Error processing item $key: $e');
          }
        }
      }

      _updateStatus(failed > 0 ? SyncStatus.error : SyncStatus.synced);
      final result =
          SyncResult(synced: synced, failed: failed, message: 'Sync complete');

      if (kDebugMode) {
        debugPrint(
            'SyncService: Sync complete - $synced synced, $failed failed');
      }

      completer.complete(result);
      return result;
    } catch (e) {
      _updateStatus(SyncStatus.error);
      final result = SyncResult(
          synced: synced, failed: failed, message: 'Sync error: $e');
      completer.complete(result);
      return result;
    } finally {
      _syncCompleter = null;
    }
  }

  /// Execute a single sync operation
  static Future<bool> _executeOperation(SyncQueueItem item) async {
    try {
      final supabase = Supabase.instance.client;

      // Ensure user_id is present (may have been queued before auth)
      final payload = Map<String, dynamic>.from(item.payload);
      if (!payload.containsKey('user_id')) {
        final userId = supabase.auth.currentUser?.id;
        if (userId == null) {
          // Can't sync without auth — retry later
          return false;
        }
        payload['user_id'] = userId;
      }

      switch (item.operation) {
        case 'INSERT':
          await supabase.from(item.tableName).insert(payload);
          break;
        case 'UPDATE':
          await supabase
              .from(item.tableName)
              .update(payload)
              .eq('id', item.recordId);
          break;
        case 'DELETE':
          await supabase.from(item.tableName).delete().eq('id', item.recordId);
          break;
        case 'UPSERT':
          await supabase.from(item.tableName).upsert(payload);
          break;
        default:
          if (kDebugMode) {
            debugPrint('SyncService: Unknown operation ${item.operation}');
          }
          return false;
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('SyncService: Operation failed: $e');
      }
      return false;
    }
  }

  static void _updateStatus(SyncStatus status) {
    _currentStatus = status;
    if (!_statusController.isClosed) {
      _statusController.add(status);
    }
  }

  /// Purge stale queue items older than 30 days
  static Future<int> purgeStaleQueueItems() async {
    final box = _syncBox;
    if (box == null) return 0;

    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    int purged = 0;
    final keysToDelete = <dynamic>[];

    for (final key in box.keys) {
      try {
        final json = box.get(key) as String?;
        if (json == null) {
          keysToDelete.add(key);
          continue;
        }
        final item = SyncQueueItem.fromJson(jsonDecode(json));
        if (item.createdAt.isBefore(cutoff)) {
          keysToDelete.add(key);
        }
      } catch (_) {
        // Corrupted entry — remove it
        keysToDelete.add(key);
      }
    }

    for (final key in keysToDelete) {
      await box.delete(key);
      purged++;
    }

    if (kDebugMode && purged > 0) {
      debugPrint('SyncService: Purged $purged stale queue items');
    }
    return purged;
  }
}

/// Sync status enum
enum SyncStatus { idle, syncing, synced, error, offline }

/// Sync queue item model
class SyncQueueItem {
  final String id;
  final String operation;
  final String tableName;
  final String recordId;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  final String status;
  final int retryCount;
  final String? lastError;

  SyncQueueItem({
    required this.id,
    required this.operation,
    required this.tableName,
    required this.recordId,
    required this.payload,
    required this.createdAt,
    this.status = 'pending',
    this.retryCount = 0,
    this.lastError,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'operation': operation,
    'table_name': tableName,
    'record_id': recordId,
    'payload': payload,
    'created_at': createdAt.toIso8601String(),
    'status': status,
    'retry_count': retryCount,
    'last_error': lastError,
  };

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) => SyncQueueItem(
    id: json['id']?.toString() ?? '',
    operation: json['operation']?.toString() ?? 'UPSERT',
    tableName: json['table_name']?.toString() ?? '',
    recordId: json['record_id']?.toString() ?? '',
    payload: json['payload'] is Map
        ? Map<String, dynamic>.from(json['payload'] as Map)
        : <String, dynamic>{},
    createdAt:
        DateTime.tryParse(json['created_at']?.toString() ?? '') ??
        DateTime.now(),
    status: json['status']?.toString() ?? 'pending',
    retryCount: (json['retry_count'] as num?)?.toInt() ?? 0,
    lastError: json['last_error']?.toString(),
  );

  SyncQueueItem copyWith({
    String? status,
    int? retryCount,
    String? lastError,
  }) => SyncQueueItem(
    id: id,
    operation: operation,
    tableName: tableName,
    recordId: recordId,
    payload: payload,
    createdAt: createdAt,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError ?? this.lastError,
  );
}

/// Sync result model
class SyncResult {
  final int synced;
  final int failed;
  final String message;

  SyncResult({
    required this.synced,
    required this.failed,
    required this.message,
  });
}
