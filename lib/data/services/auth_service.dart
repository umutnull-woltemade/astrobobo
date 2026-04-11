import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Kullanici bilgileri - tum auth metodlari icin ortak
class AuthUserInfo {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final AuthProvider provider;

  AuthUserInfo({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.provider,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'provider': provider.name,
  };

  factory AuthUserInfo.fromSupabaseUser(User user, AuthProvider provider) {
    return AuthUserInfo(
      uid: user.id,
      email: user.email,
      displayName:
          user.userMetadata?['full_name'] as String? ??
          user.userMetadata?['name'] as String?,
      photoUrl:
          user.userMetadata?['avatar_url'] as String? ??
          user.userMetadata?['picture'] as String?,
      provider: provider,
    );
  }
}

enum AuthProvider { apple, email }

/// Unified Authentication Service - Supabase
/// Apple ve Email/Password destekli
class AuthService {
  /// Check if Supabase is initialized (safe for testing)
  static bool get isSupabaseInitialized {
    try {
      // ignore: unnecessary_null_comparison
      return Supabase.instance.client != null;
    } catch (_) {
      return false;
    }
  }

  static SupabaseClient get _supabase => Supabase.instance.client;

  // ==================== Current User ====================

  /// Mevcut kullanici
  static User? get currentUser => _supabase.auth.currentUser;

  /// Kullanici oturum acmis mi?
  static bool get isSignedIn => _supabase.auth.currentUser != null;

  /// Auth state degisikliklerini dinle
  static Stream<AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;

  /// Mevcut kullanici bilgilerini al
  static AuthUserInfo? getCurrentUserInfo() {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    // Provider'i belirle
    AuthProvider provider = AuthProvider.email;
    final identities = user.identities;
    if (identities != null && identities.isNotEmpty) {
      final providerName = identities.first.provider;
      if (providerName == 'apple') {
        provider = AuthProvider.apple;
      }
    }

    return AuthUserInfo.fromSupabaseUser(user, provider);
  }

  /// Supabase baglantisi aktif mi kontrol et
  static bool get _isSupabaseConfigured {
    final url = dotenv.env['SUPABASE_URL'] ?? '';
    return url.isNotEmpty &&
        !url.contains('demo.supabase.co') &&
        !url.contains('placeholder');
  }

  // ==================== Apple Sign In ====================

  /// Apple ile giris yap
  /// Web'de Supabase OAuth kullanir, mobilde native Apple Sign-In kullanir
  static Future<AuthUserInfo?> signInWithApple() async {
    try {
      debugPrint('🍎 Apple Sign-In baslatiliyor...');
      debugPrint('🍎 Platform: ${kIsWeb ? "Web" : "Native"}');

      // Web platformunda Supabase OAuth akisini kullan
      if (kIsWeb) {
        return await _signInWithAppleWeb();
      }

      // Mobilde native Apple Sign-In kullan
      return await _signInWithAppleNative();
    } on SignInWithAppleAuthorizationException catch (e) {
      // Kullanici iptali veya Apple hatasi
      debugPrint('🍎 Apple Authorization Error: ${e.code} - ${e.message}');
      if (e.code == AuthorizationErrorCode.canceled) {
        debugPrint('🍎 Kullanici girisi iptal etti');
        return null; // Kullanici iptal etti, hata gosterme
      }
      if (e.code == AuthorizationErrorCode.failed) {
        throw Exception('Apple girisi basarisiz. Lutfen tekrar deneyin.');
      }
      if (e.code == AuthorizationErrorCode.invalidResponse) {
        throw Exception('Apple\'dan gecersiz yanit alindi.');
      }
      if (e.code == AuthorizationErrorCode.notHandled) {
        throw Exception('Apple girisi islenemedi.');
      }
      if (e.code == AuthorizationErrorCode.notInteractive) {
        throw Exception('Apple girisi interaktif modda basarisiz.');
      }
      if (e.code == AuthorizationErrorCode.unknown) {
        throw Exception('Apple girisi bilinmeyen bir hatayla karsilasti.');
      }
      rethrow;
    } on AuthException catch (e) {
      // Supabase auth hatasi
      debugPrint('🍎 Supabase Auth Error: ${e.message}');
      throw Exception('Kimlik dogrulama hatasi: ${e.message}');
    } catch (e) {
      debugPrint('🍎 Apple Sign-In error: $e');
      if (e.toString().contains('canceled') ||
          e.toString().contains('cancelled') ||
          e.toString().contains('user_canceled')) {
        return null; // Kullanici iptal etti
      }
      rethrow;
    }
  }

  /// Web icin Supabase OAuth akisi (Apple)
  static Future<AuthUserInfo?> _signInWithAppleWeb() async {
    debugPrint('🍎 Web OAuth akisi baslatiliyor...');
    try {
      // Web'de Apple Sign In icin Supabase OAuth redirect kullan
      final result = await _supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        authScreenLaunchMode: LaunchMode.platformDefault,
      );

      debugPrint('🍎 OAuth sonucu: $result');
      // OAuth akisi redirect yapacagi icin burada null donuyoruz
      // Kullanici donus yaptiginda auth state listener yakalayacak
      return null;
    } catch (e) {
      debugPrint('🍎 Apple OAuth error: $e');
      final errorStr = e.toString();
      // Web'de JS interop hatalari OAuth redirect sirasinda normal
      if (errorStr.contains('TypeError') ||
          errorStr.contains('TypeErrorImpl') ||
          errorStr.contains('JSObject') ||
          errorStr.contains('minified')) {
        debugPrint('🍎 JS interop hatasi - OAuth redirect devam ediyor');
        return null;
      }
      rethrow;
    }
  }

  /// Mobil icin native Apple Sign-In
  static Future<AuthUserInfo?> _signInWithAppleNative() async {
    debugPrint('🍎 Native Apple Sign-In baslatiliyor...');

    // Apple Sign In kullanilabilir mi kontrol et
    final isAvailable = await SignInWithApple.isAvailable();
    debugPrint('🍎 Apple Sign In kullanilabilir: $isAvailable');

    if (!isAvailable) {
      throw Exception(
        'Apple Sign In bu cihazda kullanilabilir degil. iOS 13+ gerekli.',
      );
    }

    // Nonce olustur (guvenlik icin)
    final rawNonce = _generateNonce();
    final hashedNonce = _sha256ofString(rawNonce);
    debugPrint('🍎 Nonce olusturuldu');

    // Apple Sign In baslat
    debugPrint('🍎 Apple credential isteniyor...');
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );
    debugPrint('🍎 Apple credential alindi');

    final idToken = appleCredential.identityToken;
    if (idToken == null) {
      throw Exception('Apple ID token alinamadi');
    }

    // Supabase yapilandirilmamissa sadece Apple auth bilgilerini dondur
    if (!_isSupabaseConfigured) {
      final fullName =
          '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
              .trim();
      return AuthUserInfo(
        uid: appleCredential.userIdentifier ?? 'apple_user',
        email: appleCredential.email,
        displayName: fullName.isNotEmpty ? fullName : null,
        photoUrl: null,
        provider: AuthProvider.apple,
      );
    }

    // Supabase'e giris yap
    final response = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );

    final user = response.user;
    if (user == null) return null;

    // Apple ilk giriste isim veriyor, sonra vermiyor
    if (appleCredential.givenName != null) {
      final fullName =
          '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'
              .trim();
      if (fullName.isNotEmpty) {
        await _supabase.auth.updateUser(
          UserAttributes(data: {'full_name': fullName}),
        );
      }
    }

    return AuthUserInfo.fromSupabaseUser(user, AuthProvider.apple);
  }

  // ==================== Email/Password Auth ====================

  /// Email ve sifre ile kayit ol
  static Future<AuthUserInfo?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    if (!_isSupabaseConfigured) {
      throw 'Email girisi icin sunucu baglantisi gerekli.';
    }

    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'full_name': displayName} : null,
      );

      final user = response.user;
      if (user == null) return null;

      return AuthUserInfo.fromSupabaseUser(user, AuthProvider.email);
    } on AuthException catch (e) {
      throw _handleSupabaseAuthError(e);
    }
  }

  /// Email ve sifre ile giris yap
  static Future<AuthUserInfo?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_isSupabaseConfigured) {
      throw 'Email girisi icin sunucu baglantisi gerekli.';
    }

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) return null;

      return AuthUserInfo.fromSupabaseUser(user, AuthProvider.email);
    } on AuthException catch (e) {
      throw _handleSupabaseAuthError(e);
    }
  }

  /// Sifre sifirlama emaili gonder
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw _handleSupabaseAuthError(e);
    }
  }

  // ==================== Sign Out ====================

  /// Oturumdan cik
  static Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Hesabi ve tum verileri sil
  static Future<void> deleteAccount() async {
    try {
      if (_isSupabaseConfigured) {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          // Kullanici verilerini sil
          try {
            await _supabase.from('profiles').delete().eq('id', user.id);
          } catch (_) {}

          try {
            await _supabase.from('user_charts').delete().eq('user_id', user.id);
          } catch (_) {}

          try {
            await _supabase
                .from('saved_readings')
                .delete()
                .eq('user_id', user.id);
          } catch (_) {}

          await _supabase.auth.signOut();
        }
      }
    } catch (e) {
      debugPrint('Account deletion error: $e');
      rethrow;
    }
  }

  // ==================== Helper Methods ====================

  /// Nonce olustur (Apple Sign In icin)
  static String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// SHA256 hash olustur
  static String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Supabase Auth hatalarini kullanici dostu mesajlara cevir
  static String _handleSupabaseAuthError(AuthException e) {
    final message = e.message.toLowerCase();

    if (message.contains('email already registered') ||
        message.contains('user already registered')) {
      return 'Bu email adresi zaten kullanimda';
    }
    if (message.contains('invalid email')) {
      return 'Gecersiz email adresi';
    }
    if (message.contains('password') && message.contains('weak')) {
      return 'Sifre cok zayif (en az 6 karakter)';
    }
    if (message.contains('invalid login credentials') ||
        message.contains('invalid password')) {
      return 'Email veya sifre hatali';
    }
    if (message.contains('email not confirmed')) {
      return 'Lutfen email adresinizi dogrulayin';
    }
    if (message.contains('too many requests') ||
        message.contains('rate limit')) {
      return 'Cok fazla deneme. Lutfen biraz bekleyin';
    }
    if (message.contains('network') || message.contains('connection')) {
      return 'Internet baglantisi yok';
    }
    if (message.contains('user not found')) {
      return 'Bu email ile kayitli hesap bulunamadi';
    }

    return 'Bir hata olustu: ${e.message}';
  }
}
