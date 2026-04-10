// Minimal File stub for web builds (no-op implementation)
class File {
  final String path;
  File(this.path);

  /// No-op on web
  Future<void> writeAsBytes(List<int> bytes) async {}

  @override
  String toString() => 'File($path)';
}
