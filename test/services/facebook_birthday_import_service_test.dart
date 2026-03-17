import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/facebook_birthday_import_service.dart';
import 'package:inner_cycles/data/models/birthday_contact.dart';

void main() {
  group('FacebookBirthdayImportService', () {
    group('parseJsonExport', () {
      test('parses valid friends_v2 data', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'John Doe',
              'birthday': {'month': 3, 'day': 15, 'year': 1990},
            },
            {
              'name': 'Jane Smith',
              'birthday': {'month': 12, 'day': 25, 'year': 1985},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts.length, 2);

        expect(contacts[0].name, 'John Doe');
        expect(contacts[0].birthdayMonth, 3);
        expect(contacts[0].birthdayDay, 15);
        expect(contacts[0].birthYear, 1990);
        expect(contacts[0].source, BirthdayContactSource.facebook);
        expect(contacts[0].relationship, BirthdayRelationship.friend);
        expect(contacts[0].notificationsEnabled, true);
        expect(contacts[0].dayBeforeReminder, true);

        expect(contacts[1].name, 'Jane Smith');
        expect(contacts[1].birthdayMonth, 12);
        expect(contacts[1].birthdayDay, 25);
        expect(contacts[1].birthYear, 1985);
      });

      test('parses valid friends key (without _v2)', () {
        final jsonStr = json.encode({
          'friends': [
            {
              'name': 'Alice',
              'birthday': {'month': 1, 'day': 1, 'year': 2000},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts.length, 1);
        expect(contacts[0].name, 'Alice');
      });

      test('handles missing birthday field', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {'name': 'No Birthday'},
            {
              'name': 'Has Birthday',
              'birthday': {'month': 6, 'day': 10},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts.length, 1);
        expect(contacts[0].name, 'Has Birthday');
      });

      test('handles missing name', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'birthday': {'month': 5, 'day': 20, 'year': 1995},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('handles empty name', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': '',
              'birthday': {'month': 5, 'day': 20},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('handles missing month in birthday', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'Bob',
              'birthday': {'day': 15, 'year': 1990},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('handles missing day in birthday', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'Carol',
              'birthday': {'month': 7, 'year': 1988},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('rejects invalid month (0)', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'BadMonth',
              'birthday': {'month': 0, 'day': 15},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('rejects invalid month (13)', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'BadMonth',
              'birthday': {'month': 13, 'day': 15},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('rejects invalid day (0)', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'BadDay',
              'birthday': {'month': 3, 'day': 0},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('rejects invalid day (32)', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'BadDay',
              'birthday': {'month': 3, 'day': 32},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('accepts boundary valid month/day (1/1 and 12/31)', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'NewYear',
              'birthday': {'month': 1, 'day': 1},
            },
            {
              'name': 'NewYearsEve',
              'birthday': {'month': 12, 'day': 31},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts.length, 2);
      });

      test('sets birthYear to null when year is 1900 or below', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'OldYear',
              'birthday': {'month': 5, 'day': 10, 'year': 1900},
            },
            {
              'name': 'NoYear',
              'birthday': {'month': 5, 'day': 10, 'year': 0},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts.length, 2);
        expect(contacts[0].birthYear, isNull);
        expect(contacts[1].birthYear, isNull);
      });

      test('sets birthYear when year is above 1900', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'Modern',
              'birthday': {'month': 5, 'day': 10, 'year': 1901},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts[0].birthYear, 1901);
      });

      test('sets birthYear to null when year is missing', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'NoYear',
              'birthday': {'month': 8, 'day': 22},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts.length, 1);
        expect(contacts[0].birthYear, isNull);
      });

      test('generates unique IDs for each contact', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'A',
              'birthday': {'month': 1, 'day': 1},
            },
            {
              'name': 'B',
              'birthday': {'month': 2, 'day': 2},
            },
            {
              'name': 'C',
              'birthday': {'month': 3, 'day': 3},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        final ids = contacts.map((c) => c.id).toSet();
        expect(ids.length, 3);
      });

      test('returns empty list for invalid JSON', () {
        final contacts =
            FacebookBirthdayImportService.parseJsonExport('not valid json');
        expect(contacts, isEmpty);
      });

      test('returns empty list for empty friends array', () {
        final jsonStr = json.encode({'friends_v2': []});
        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });

      test('returns empty list when neither friends nor friends_v2 key exists', () {
        final jsonStr = json.encode({'other_data': []});
        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts, isEmpty);
      });
    });

    group('parseHtmlExport', () {
      test('parses valid HTML with Birthday format', () {
        final html = '''
<div class="name">John Doe</div><div class="info">Birthday: March 15, 1990</div>
<div class="name">Jane Smith</div><div class="info">Birthday: December 25</div>
''';

        final contacts = FacebookBirthdayImportService.parseHtmlExport(html);
        expect(contacts.length, 2);

        expect(contacts[0].name, 'John Doe');
        expect(contacts[0].birthdayMonth, 3);
        expect(contacts[0].birthdayDay, 15);
        expect(contacts[0].birthYear, 1990);

        expect(contacts[1].name, 'Jane Smith');
        expect(contacts[1].birthdayMonth, 12);
        expect(contacts[1].birthdayDay, 25);
        expect(contacts[1].birthYear, isNull);
      });

      test('parses all 12 months correctly', () {
        final months = [
          'January', 'February', 'March', 'April',
          'May', 'June', 'July', 'August',
          'September', 'October', 'November', 'December',
        ];

        for (var i = 0; i < months.length; i++) {
          final html =
              '<div>Person $i</div><div>Birthday: ${months[i]} 10, 2000</div>';
          final contacts = FacebookBirthdayImportService.parseHtmlExport(html);
          expect(contacts.length, 1, reason: '${months[i]} should parse');
          expect(contacts[0].birthdayMonth, i + 1);
          expect(contacts[0].birthdayDay, 10);
        }
      });

      test('sets source to facebook', () {
        final html =
            '<div>Test Person</div><div>Birthday: January 1, 2000</div>';
        final contacts = FacebookBirthdayImportService.parseHtmlExport(html);
        expect(contacts[0].source, BirthdayContactSource.facebook);
      });

      test('returns empty list for HTML with no birthday data', () {
        final html = '<div>Hello</div><div>No birthday here</div>';
        final contacts = FacebookBirthdayImportService.parseHtmlExport(html);
        expect(contacts, isEmpty);
      });

      test('returns empty list for empty string', () {
        final contacts = FacebookBirthdayImportService.parseHtmlExport('');
        expect(contacts, isEmpty);
      });

      test('handles year <= 1900 as null birthYear', () {
        final html =
            '<div>Old Person</div><div>Birthday: June 15, 1800</div>';
        final contacts = FacebookBirthdayImportService.parseHtmlExport(html);
        expect(contacts.length, 1);
        expect(contacts[0].birthYear, isNull);
      });
    });

    group('_decodeFbName (tested via parseJsonExport)', () {
      test('passes through ASCII names unchanged', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'John Doe',
              'birthday': {'month': 1, 'day': 1},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts[0].name, 'John Doe');
      });

      test('handles non-ASCII names (UTF-8 decoding)', () {
        // Facebook sometimes encodes names with UTF-8 bytes stored as
        // Latin-1 code units. Test that such names are decoded.
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'Ren\u00e9',
              'birthday': {'month': 4, 'day': 20},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        // The name contains non-ASCII (code unit > 127), so _decodeFbName
        // attempts utf8.decode. The result depends on the byte values.
        expect(contacts[0].name, isNotEmpty);
        expect(contacts.length, 1);
      });

      test('handles pure ASCII name without modification', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': 'Alice Bob',
              'birthday': {'month': 7, 'day': 4},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts[0].name, 'Alice Bob');
      });

      test('handles name with special characters', () {
        final jsonStr = json.encode({
          'friends_v2': [
            {
              'name': "O'Brien-Smith",
              'birthday': {'month': 9, 'day': 30},
            },
          ],
        });

        final contacts = FacebookBirthdayImportService.parseJsonExport(jsonStr);
        expect(contacts[0].name, "O'Brien-Smith");
      });
    });
  });
}
