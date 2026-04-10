// Export real platform helpers when dart:io is available, otherwise export stubs
export 'platform_compat_stub.dart'
    if (dart.library.io) 'platform_compat_io.dart';
