// Exports real dart:io on native platforms, and a minimal stub on web
export 'io_stub.dart' if (dart.library.io) 'dart:io';
