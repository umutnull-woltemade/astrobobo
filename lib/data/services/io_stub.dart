// Stub for dart:io classes on web
class File {
  final String path;
  File(this.path);
  Future<File> writeAsBytes(List<int> bytes) async => this;
  Future<List<int>> readAsBytes() async => [];
}

class Directory {
  final String path;
  Directory(this.path);
}
