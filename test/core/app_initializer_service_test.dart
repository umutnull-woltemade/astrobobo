import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/core/app_initializer_service.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';
import 'package:inner_cycles/data/models/user_profile.dart';

void main() {
  group('InitResult', () {
    test('constructs with all required fields', () {
      final result = InitResult(
        language: AppLanguage.en,
        themeMode: ThemeMode.dark,
        fontSizeScale: 1.0,
        onboardingComplete: true,
      );

      expect(result.language, AppLanguage.en);
      expect(result.themeMode, ThemeMode.dark);
      expect(result.fontSizeScale, 1.0);
      expect(result.onboardingComplete, true);
      expect(result.profile, isNull);
    });

    test('constructs with profile set to null by default', () {
      final result = InitResult(
        language: AppLanguage.tr,
        themeMode: ThemeMode.system,
        fontSizeScale: 1.2,
        onboardingComplete: false,
      );

      expect(result.profile, isNull);
    });

    test('constructs with profile provided', () {
      final profile = UserProfile(
        id: 'test-user-1',
        name: 'Test User',
        birthDate: DateTime(1990, 5, 15),
      );

      final result = InitResult(
        language: AppLanguage.en,
        themeMode: ThemeMode.light,
        fontSizeScale: 0.9,
        onboardingComplete: true,
        profile: profile,
      );

      expect(result.profile, isNotNull);
      expect(result.profile!.id, 'test-user-1');
      expect(result.profile!.name, 'Test User');
    });

    test('language field is properly assigned for English', () {
      final result = InitResult(
        language: AppLanguage.en,
        themeMode: ThemeMode.system,
        fontSizeScale: 1.0,
        onboardingComplete: false,
      );

      expect(result.language, AppLanguage.en);
    });

    test('language field is properly assigned for Turkish', () {
      final result = InitResult(
        language: AppLanguage.tr,
        themeMode: ThemeMode.system,
        fontSizeScale: 1.0,
        onboardingComplete: false,
      );

      expect(result.language, AppLanguage.tr);
    });

    test('themeMode accepts all ThemeMode values', () {
      for (final mode in ThemeMode.values) {
        final result = InitResult(
          language: AppLanguage.en,
          themeMode: mode,
          fontSizeScale: 1.0,
          onboardingComplete: false,
        );
        expect(result.themeMode, mode);
      }
    });

    test('fontSizeScale stores fractional values', () {
      final result = InitResult(
        language: AppLanguage.en,
        themeMode: ThemeMode.system,
        fontSizeScale: 1.35,
        onboardingComplete: false,
      );

      expect(result.fontSizeScale, 1.35);
    });

    test('onboardingComplete true is properly assigned', () {
      final result = InitResult(
        language: AppLanguage.en,
        themeMode: ThemeMode.system,
        fontSizeScale: 1.0,
        onboardingComplete: true,
      );

      expect(result.onboardingComplete, true);
    });

    test('onboardingComplete false is properly assigned', () {
      final result = InitResult(
        language: AppLanguage.en,
        themeMode: ThemeMode.system,
        fontSizeScale: 1.0,
        onboardingComplete: false,
      );

      expect(result.onboardingComplete, false);
    });

    test('all fields are independently assigned', () {
      final profile = UserProfile(
        id: 'u-42',
        name: 'Full Test',
        birthDate: DateTime(1985, 3, 17),
      );

      final result = InitResult(
        language: AppLanguage.tr,
        themeMode: ThemeMode.dark,
        fontSizeScale: 1.5,
        onboardingComplete: true,
        profile: profile,
      );

      expect(result.language, AppLanguage.tr);
      expect(result.themeMode, ThemeMode.dark);
      expect(result.fontSizeScale, 1.5);
      expect(result.onboardingComplete, true);
      expect(result.profile, isNotNull);
      expect(result.profile!.id, 'u-42');
      expect(result.profile!.name, 'Full Test');
    });
  });
}
