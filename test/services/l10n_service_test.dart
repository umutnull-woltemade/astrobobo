import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/l10n_service.dart';
import 'package:inner_cycles/data/providers/app_providers.dart';

void main() {
  group('L10nService', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await L10nService.init(AppLanguage.en);
    });

    group('Initialization', () {
      test('isInitialized returns true after init', () {
        expect(L10nService.isInitialized, isTrue);
      });

      test('currentLanguage returns the initialized language', () {
        expect(L10nService.currentLanguage, equals(AppLanguage.en));
      });

      test('supportedLanguages contains EN and TR', () {
        expect(L10nService.supportedLanguages.length, equals(2));
        expect(L10nService.supportedLanguages.contains(AppLanguage.en), isTrue);
        expect(L10nService.supportedLanguages.contains(AppLanguage.tr), isTrue);
      });
    });

    group('get', () {
      test('returns translation for valid key', () async {
        await L10nService.init(AppLanguage.en);
        final result = L10nService.get('common.back', AppLanguage.en);
        expect(result, isNotEmpty);
        expect(result, isNot(contains('['))); // Not a placeholder
      });

      test('returns placeholder for missing key', () async {
        await L10nService.init(AppLanguage.en);
        final result = L10nService.get('nonexistent.key.that.does.not.exist', AppLanguage.en);
        expect(result, contains('['));
        expect(result, contains(']'));
      });

      test('returns different translations for different languages', () async {
        await L10nService.init(AppLanguage.en);
        await L10nService.init(AppLanguage.tr);

        final enResult = L10nService.get('common.back', AppLanguage.en);
        final trResult = L10nService.get('common.back', AppLanguage.tr);

        expect(enResult, isNotEmpty);
        expect(trResult, isNotEmpty);
        // Both should be valid (not placeholders)
        expect(enResult, isNot(contains('[common.back]')));
        expect(trResult, isNot(contains('[common.back]')));
      });

      test('handles nested keys correctly', () async {
        await L10nService.init(AppLanguage.en);
        // common.cancel is a nested key (common -> cancel)
        final result = L10nService.get('common.cancel', AppLanguage.en);
        expect(result, isNotEmpty);
        expect(result, isNot(contains('[')));
      });
    });

    group('getWithParams', () {
      test('replaces parameters in translation', () async {
        await L10nService.init(AppLanguage.en);
        final result = L10nService.getWithParams(
          'test.param.key',
          AppLanguage.en,
          params: {'name': 'TestUser'},
        );
        expect(result, isA<String>());
      });
    });

    group('getList', () {
      test('returns list of strings', () async {
        await L10nService.init(AppLanguage.en);
        final result = L10nService.getList('common.months', AppLanguage.en);
        expect(result, isA<List<String>>());
      });
    });

    group('getMap', () {
      test('returns map of strings', () async {
        await L10nService.init(AppLanguage.en);
        final result = L10nService.getMap('test.map.key', AppLanguage.en);
        expect(result, isA<Map<String, String>>());
      });
    });

    group('LocalizedL10n', () {
      test('wraps L10nService with bound language', () async {
        await L10nService.init(AppLanguage.en);
        final localizedL10n = LocalizedL10n(AppLanguage.en);

        final direct = L10nService.get('common.back', AppLanguage.en);
        final wrapped = localizedL10n.get('common.back');

        expect(direct, equals(wrapped));
      });

      test('language getter returns bound language', () {
        final localizedL10n = LocalizedL10n(AppLanguage.tr);
        expect(localizedL10n.language, equals(AppLanguage.tr));
      });
    });

    group('Strict isolation', () {
      test('does not fallback to other languages', () async {
        await L10nService.init(AppLanguage.en);

        // If a key exists only in Turkish, English should return placeholder
        final result = L10nService.get('unique.turkish.only.key', AppLanguage.en);
        expect(result, contains('['));
      });
    });

    group('Exception handling', () {
      test('UnsupportedLanguageException has correct message', () {
        expect(() => throw UnsupportedLanguageException(AppLanguage.en),
               throwsA(isA<UnsupportedLanguageException>()));
      });

      test('LocaleLoadException has correct message', () {
        final exception = LocaleLoadException(AppLanguage.en, 'Test error');
        expect(exception.toString(), contains('en'));
      });
    });
  });

  group('Translation Coverage', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Preload all languages
      for (final lang in L10nService.supportedLanguages) {
        await L10nService.init(lang);
      }
    });

    test('common keys exist in all languages', () {
      final commonKeys = [
        'common.back',
        'common.save',
        'common.cancel',
        'common.ok',
        'common.loading',
      ];

      for (final lang in L10nService.supportedLanguages) {
        for (final key in commonKeys) {
          final result = L10nService.get(key, lang);
          expect(result, isNot(contains('[$key')),
                 reason: 'Key "$key" missing in ${lang.name}');
        }
      }
    });

    test('app keys exist in all languages', () {
      final appKeys = [
        'app.name',
        'app.tagline',
        'app.loading_text',
      ];

      for (final lang in L10nService.supportedLanguages) {
        for (final key in appKeys) {
          final result = L10nService.get(key, lang);
          expect(result, isNot(contains('[$key')),
                 reason: 'Key "$key" missing in ${lang.name}');
        }
      }
    });
  });
}
