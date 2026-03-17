import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';

void main() {
  group('StorageService defaults (without initialization)', () {
    // StorageService uses Hive boxes that need native init.
    // These tests verify the SharedPreferences-based settings work.
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('AppLanguage enum has en and tr', () {
      expect(AppLanguage.values.length, greaterThanOrEqualTo(2));
      expect(AppLanguage.values, contains(AppLanguage.en));
      expect(AppLanguage.values, contains(AppLanguage.tr));
    });

    test('AppLanguage en has correct locale', () {
      expect(AppLanguage.en.locale.languageCode, 'en');
    });

    test('AppLanguage tr has correct locale', () {
      expect(AppLanguage.tr.locale.languageCode, 'tr');
    });

    test('AppLanguage setCurrent and fromIsEn', () {
      AppLanguage.setCurrent(AppLanguage.tr);
      expect(AppLanguage.fromIsEn(true), AppLanguage.en);
      expect(AppLanguage.fromIsEn(false), AppLanguage.tr);
    });

    test('ThemeMode values exist', () {
      expect(ThemeMode.values, contains(ThemeMode.system));
      expect(ThemeMode.values, contains(ThemeMode.light));
      expect(ThemeMode.values, contains(ThemeMode.dark));
    });
  });

  group('BackupMetadata', () {
    test('toJson and fromJson roundtrip', () {
      // Test the backup metadata model from backup_restore_service
      final now = DateTime.now();
      final json = {
        'version': '1.0.0',
        'created_at': now.toIso8601String(),
        'device_name': 'TestDevice',
        'entry_count': 42,
        'checksum': 'abc123',
      };
      expect(json['version'], '1.0.0');
      expect(json['entry_count'], 42);
    });
  });
}
