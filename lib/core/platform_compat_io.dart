import 'dart:io' as io;

class PlatformCompat {
  static bool get isIOS => io.Platform.isIOS;
  static bool get isAndroid => io.Platform.isAndroid;
  static bool get isMacOS => io.Platform.isMacOS;
}
