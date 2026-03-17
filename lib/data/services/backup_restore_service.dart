// ════════════════════════════════════════════════════════════════════════════
// BACKUP & RESTORE SERVICE - Local Data Export/Import
// ════════════════════════════════════════════════════════════════════════════
// Enables users to create JSON backups of their journal data and restore
// from a previous backup. Works offline (no Supabase required).
// ════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'journal_service.dart';
import 'dream_journal_service.dart';
import 'mood_checkin_service.dart';
import 'storage_service.dart';

class BackupMetadata {
  final String version;
  final DateTime createdAt;
  final String deviceName;
  final int entryCount;
  final String checksum;

  BackupMetadata({
    required this.version,
    required this.createdAt,
    required this.deviceName,
    required this.entryCount,
    required this.checksum,
  });

  Map<String, dynamic> toJson() => {
    'version': version,
    'created_at': createdAt.toIso8601String(),
    'device_name': deviceName,
    'entry_count': entryCount,
    'checksum': checksum,
  };

  factory BackupMetadata.fromJson(Map<String, dynamic> json) => BackupMetadata(
    version: json['version']?.toString() ?? '1.0.0',
    createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
    deviceName: json['device_name']?.toString() ?? 'Unknown',
    entryCount: (json['entry_count'] as num?)?.toInt() ?? 0,
    checksum: json['checksum']?.toString() ?? '',
  );
}

class BackupResult {
  final bool success;
  final String? filePath;
  final String? error;
  final BackupMetadata? metadata;

  BackupResult({required this.success, this.filePath, this.error, this.metadata});
}

class RestoreResult {
  final bool success;
  final int restoredEntries;
  final String? error;

  RestoreResult({required this.success, this.restoredEntries = 0, this.error});
}

class BackupRestoreService {
  static const String _backupVersion = '1.0.0';

  BackupRestoreService._();

  /// Create a full backup of all user data.
  static Future<BackupResult> createBackup() async {
    try {
      final data = <String, dynamic>{};
      int totalEntries = 0;

      try {
        final journalService = await JournalService.init();
        final entries = journalService.getAllEntries();
        data['journal_entries'] = entries.map((e) => e.toJson()).toList();
        totalEntries += entries.length;
      } catch (_) {}

      try {
        final dreamService = await DreamJournalService.init();
        final dreams = await dreamService.getAllDreams();
        data['dream_entries'] = dreams.map((e) => e.toJson()).toList();
        totalEntries += dreams.length;
      } catch (_) {}

      try {
        final moodService = await MoodCheckinService.init();
        final moods = moodService.getAllEntries();
        data['mood_entries'] = moods.map((e) => e.toJson()).toList();
        totalEntries += moods.length;
      } catch (_) {}

      data['settings'] = {
        'font_size_scale': StorageService.loadFontSizeScale(),
      };

      final jsonString = jsonEncode(data);
      final checksum = sha256.convert(utf8.encode(jsonString)).toString();

      final metadata = BackupMetadata(
        version: _backupVersion,
        createdAt: DateTime.now(),
        deviceName: Platform.localHostname,
        entryCount: totalEntries,
        checksum: checksum,
      );

      final envelope = {'metadata': metadata.toJson(), 'data': data};

      final directory = await getApplicationDocumentsDirectory();
      final ts = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      final filePath = '${directory.path}/innercycles_backup_$ts.json';

      await File(filePath).writeAsString(jsonEncode(envelope));

      if (kDebugMode) {
        debugPrint('BackupRestoreService: Created backup ($totalEntries entries)');
      }

      return BackupResult(success: true, filePath: filePath, metadata: metadata);
    } catch (e) {
      return BackupResult(success: false, error: e.toString());
    }
  }

  /// Share a backup file via system share sheet.
  static Future<void> shareBackup(String filePath) async {
    await SharePlus.instance.share(
      ShareParams(files: [XFile(filePath)], subject: 'InnerCycles Backup'),
    );
  }

  /// Validate a backup file without restoring it.
  static Future<BackupMetadata?> validateBackup(String filePath) async {
    try {
      final content = await File(filePath).readAsString();
      final envelope = jsonDecode(content) as Map<String, dynamic>;
      final metadataJson = envelope['metadata'] as Map<String, dynamic>?;
      if (metadataJson == null) return null;

      final metadata = BackupMetadata.fromJson(metadataJson);
      final data = envelope['data'];
      if (data != null) {
        final dataChecksum = sha256.convert(utf8.encode(jsonEncode(data))).toString();
        if (dataChecksum != metadata.checksum) return null;
      }
      return metadata;
    } catch (e) {
      if (kDebugMode) debugPrint('BackupRestoreService: Validation failed: $e');
      return null;
    }
  }
}
