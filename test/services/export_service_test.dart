import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:inner_cycles/data/services/export_service.dart';

void main() {
  group('ExportFormat', () {
    test('has four formats', () {
      expect(ExportFormat.values.length, 4);
      expect(ExportFormat.values, contains(ExportFormat.text));
      expect(ExportFormat.values, contains(ExportFormat.csv));
      expect(ExportFormat.values, contains(ExportFormat.json));
      expect(ExportFormat.values, contains(ExportFormat.pdf));
    });
  });

  group('ExportResult', () {
    test('constructs with required fields', () {
      const result = ExportResult(
        content: 'test data',
        fileName: 'export.txt',
        mimeType: 'text/plain',
      );
      expect(result.content, 'test data');
      expect(result.fileName, 'export.txt');
      expect(result.mimeType, 'text/plain');
      expect(result.pdfBytes, isNull);
    });

    test('constructs with pdfBytes', () {
      final bytes = List<int>.filled(100, 0);
      final result = ExportResult(
        content: '',
        fileName: 'export.pdf',
        mimeType: 'application/pdf',
        pdfBytes: Uint8List.fromList(bytes),
      );
      expect(result.pdfBytes, isNotNull);
      expect(result.pdfBytes!.length, 100);
    });
  });
}
