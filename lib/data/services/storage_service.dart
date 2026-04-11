import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../providers/app_providers.dart';
import 'package:flutter/material.dart';

/// Local storage service using Hive for persisting user data
class StorageService {
  static const String _userProfileBoxName = 'user_profile_box';
  static const String _settingsBoxName = 'settings_box';

  static const String _profileKey = 'user_profile';
  static const String _allProfilesKey = 'all_profiles';
  static const String _primaryProfileIdKey = 'primary_profile_id';
  static const String _onboardingKey = 'onboarding_complete';
  static const String _disclaimerKey = 'disclaimer_accepted';
  static const String _languageKey = 'app_language';
  static const String _themeModeKey = 'theme_mode';

  static Box? _profileBox;
  static Box? _settingsBox;

  // ═══════════════════════════════════════════════════════════════════════
  // WEB persistence — uses shared_preferences (localStorage backend).
  // Loaded into memory map at init() so existing sync API keeps working.
  // ═══════════════════════════════════════════════════════════════════════
  static SharedPreferences? _webPrefs;
  static final Map<String, dynamic> _webCache = {};

  static bool get _isInitialized => _profileBox != null && _settingsBox != null;
  static bool get _hasWebStorage => kIsWeb && _webPrefs != null;

  static void _warnIfNotInitialized(String method) {
    if (!_isInitialized && !_hasWebStorage && kDebugMode) {
      debugPrint('StorageService.$method called before initialize()');
    }
  }

  /// Generic key-value getters that work on both Hive (mobile) and prefs (web)
  static dynamic _get(String key, {dynamic defaultValue}) {
    if (kIsWeb) {
      return _webCache[key] ?? defaultValue;
    }
    return _settingsBox?.get(key, defaultValue: defaultValue);
  }

  static dynamic _getProfile(String key) {
    if (kIsWeb) {
      return _webCache[key];
    }
    return _profileBox?.get(key);
  }

  static Future<void> _put(String key, dynamic value) async {
    if (kIsWeb) {
      _webCache[key] = value;
      final prefs = _webPrefs;
      if (prefs == null) return;
      if (value is String)
        await prefs.setString(key, value);
      else if (value is int)
        await prefs.setInt(key, value);
      else if (value is bool)
        await prefs.setBool(key, value);
      else if (value is double)
        await prefs.setDouble(key, value);
      else
        await prefs.setString(key, jsonEncode(value));
      return;
    }
    await _settingsBox?.put(key, value);
  }

  static Future<void> _putProfile(String key, dynamic value) async {
    if (kIsWeb) {
      _webCache[key] = value;
      final prefs = _webPrefs;
      if (prefs == null) return;
      if (value is String)
        await prefs.setString(key, value);
      else
        await prefs.setString(key, jsonEncode(value));
      return;
    }
    await _profileBox?.put(key, value);
  }

  static Future<void> _delete(String key) async {
    if (kIsWeb) {
      _webCache.remove(key);
      await _webPrefs?.remove(key);
      return;
    }
    await _profileBox?.delete(key);
    await _settingsBox?.delete(key);
  }

  /// Initialize Hive and open boxes (web uses shared_preferences instead)
  static Future<void> initialize() async {
    // ═══════════════════════════════════════════════════════════════════
    // WEB: Use shared_preferences (localStorage) for persistence.
    // Preload all keys into memory map so sync API still works.
    // ═══════════════════════════════════════════════════════════════════
    if (kIsWeb) {
      try {
        _webPrefs = await SharedPreferences.getInstance().timeout(
          const Duration(seconds: 5),
        );
        // Preload all known keys into memory cache for sync access
        final prefs = _webPrefs!;
        for (final key in prefs.getKeys()) {
          _webCache[key] = prefs.get(key);
        }
        if (kDebugMode) {
          debugPrint(
            'StorageService: Web prefs loaded (${_webCache.length} keys)',
          );
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint(
            'StorageService: Web prefs failed: $e (memory-only fallback)',
          );
        }
      }
      return;
    }

    try {
      await Hive.initFlutter();

      // Try to open boxes with individual timeouts
      _profileBox = await Hive.openBox(_userProfileBoxName).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          if (kDebugMode) {
            debugPrint('Warning: Profile box initialization timed out');
          }
          throw TimeoutException('Profile box timeout');
        },
      );

      _settingsBox = await Hive.openBox(_settingsBoxName).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          if (kDebugMode) {
            debugPrint('Warning: Settings box initialization timed out');
          }
          throw TimeoutException('Settings box timeout');
        },
      );

      if (kDebugMode) {
        debugPrint('StorageService initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('StorageService initialization error: $e');
      }
      // Continue without storage - app will work in memory-only mode
    }
  }

  // ========== USER PROFILE ==========

  /// Save user profile to local storage
  static Future<void> saveUserProfile(UserProfile profile) async {
    _warnIfNotInitialized('saveUserProfile');
    final json = jsonEncode(profile.toJson());

    if (kIsWeb) {
      await _putProfile(_profileKey, json);
      return;
    }

    final box = _profileBox;
    if (box == null) return;
    await box.put(_profileKey, json);
  }

  /// Load user profile from local storage
  static UserProfile? loadUserProfile() {
    _warnIfNotInitialized('loadUserProfile');

    String? json;
    if (kIsWeb) {
      final raw = _getProfile(_profileKey);
      json = raw is String ? raw : null;
    } else {
      final box = _profileBox;
      if (box == null) return null;
      final raw = box.get(_profileKey);
      json = raw is String ? raw : null;
    }

    if (json == null) return null;

    try {
      final data = jsonDecode(json) as Map<String, dynamic>;
      final profile = UserProfile.fromJson(data);

      if (profile.name == null || profile.name!.isEmpty) {
        if (kIsWeb) {
          _delete(_profileKey);
        } else {
          _profileBox?.delete(_profileKey);
        }
        return null;
      }

      return profile;
    } catch (e) {
      if (kIsWeb) {
        _delete(_profileKey);
      } else {
        _profileBox?.delete(_profileKey);
      }
      return null;
    }
  }

  /// Delete user profile from local storage
  static Future<void> deleteUserProfile() async {
    _warnIfNotInitialized('deleteUserProfile');
    if (kIsWeb) {
      await _delete(_profileKey);
      return;
    }
    await _profileBox?.delete(_profileKey);
  }

  // ========== MULTIPLE PROFILES ==========

  static Future<void> saveProfile(UserProfile profile) async {
    _warnIfNotInitialized('saveProfile');

    final profiles = loadAllProfiles();
    final index = profiles.indexWhere((p) => p.id == profile.id);

    if (index >= 0) {
      profiles[index] = profile.copyWith(updatedAt: DateTime.now());
    } else {
      profiles.add(profile);
    }

    final jsonList = profiles.map((p) => p.toJson()).toList();
    final encoded = jsonEncode(jsonList);

    if (kIsWeb) {
      await _putProfile(_allProfilesKey, encoded);
    } else {
      final box = _profileBox;
      if (box == null) return;
      await box.put(_allProfilesKey, encoded);
    }

    if (profile.isPrimary || profiles.length == 1) {
      await setPrimaryProfileId(profile.id);
    }
  }

  static List<UserProfile> loadAllProfiles() {
    _warnIfNotInitialized('loadAllProfiles');

    String? json;
    if (kIsWeb) {
      final raw = _getProfile(_allProfilesKey);
      json = raw is String ? raw : null;
    } else {
      final box = _profileBox;
      if (box == null) return [];
      final raw = box.get(_allProfilesKey);
      json = raw is String ? raw : null;
    }

    if (json == null) {
      final legacy = loadUserProfile();
      if (legacy != null) {
        return [legacy.copyWith(isPrimary: true)];
      }
      return [];
    }

    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
          .where((p) => p.name != null && p.name!.isNotEmpty)
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> deleteProfile(String id) async {
    _warnIfNotInitialized('deleteProfile');

    final profiles = loadAllProfiles();
    profiles.removeWhere((p) => p.id == id);

    final jsonList = profiles.map((p) => p.toJson()).toList();
    final encoded = jsonEncode(jsonList);

    if (kIsWeb) {
      await _putProfile(_allProfilesKey, encoded);
    } else {
      final box = _profileBox;
      if (box == null) return;
      await box.put(_allProfilesKey, encoded);
    }

    final primaryId = getPrimaryProfileId();
    if (primaryId == id && profiles.isNotEmpty) {
      await setPrimaryProfileId(profiles.first.id);
    }
  }

  static Future<void> setPrimaryProfileId(String id) async {
    _warnIfNotInitialized('setPrimaryProfileId');
    if (kIsWeb) {
      await _putProfile(_primaryProfileIdKey, id);
      return;
    }
    await _profileBox?.put(_primaryProfileIdKey, id);
  }

  static String? getPrimaryProfileId() {
    _warnIfNotInitialized('getPrimaryProfileId');
    if (kIsWeb) {
      final raw = _getProfile(_primaryProfileIdKey);
      return raw is String ? raw : null;
    }
    final raw = _profileBox?.get(_primaryProfileIdKey);
    return raw is String ? raw : null;
  }

  static UserProfile? getPrimaryProfile() {
    final profiles = loadAllProfiles();
    final primaryId = getPrimaryProfileId();

    if (primaryId != null) {
      final primary = profiles.where((p) => p.id == primaryId).firstOrNull;
      if (primary != null) return primary;
    }

    return profiles.isNotEmpty ? profiles.first : null;
  }

  static UserProfile? getProfileById(String id) {
    final profiles = loadAllProfiles();
    return profiles.where((p) => p.id == id).firstOrNull;
  }

  // ========== ONBOARDING ==========

  /// Save onboarding completion status
  static Future<void> saveOnboardingComplete(bool complete) async {
    _warnIfNotInitialized('saveOnboardingComplete');
    if (kIsWeb) {
      await _put(_onboardingKey, complete);
      return;
    }
    await _settingsBox?.put(_onboardingKey, complete);
  }

  /// Load onboarding completion status
  /// Returns false if there's no valid user profile (to force onboarding)
  static bool loadOnboardingComplete() {
    _warnIfNotInitialized('loadOnboardingComplete');

    bool isComplete = false;
    if (kIsWeb) {
      final raw = _get(_onboardingKey, defaultValue: false);
      isComplete = raw is bool ? raw : false;
    } else {
      final box = _settingsBox;
      if (box == null) return false;
      final raw = box.get(_onboardingKey, defaultValue: false);
      isComplete = raw is bool ? raw : false;
    }

    // If onboarding is marked complete but there's no valid profile, reset it
    if (isComplete) {
      final profile = loadUserProfile();
      if (profile == null) {
        if (kIsWeb) {
          _put(_onboardingKey, false);
        } else {
          _settingsBox?.put(_onboardingKey, false);
        }
        return false;
      }
    }

    return isComplete;
  }

  // ========== DISCLAIMER ==========

  /// Save disclaimer accepted status
  static Future<void> saveDisclaimerAccepted(bool accepted) async {
    _warnIfNotInitialized('saveDisclaimerAccepted');
    if (kIsWeb) {
      await _put(_disclaimerKey, accepted);
      return;
    }
    await _settingsBox?.put(_disclaimerKey, accepted);
  }

  /// Load disclaimer accepted status
  static bool loadDisclaimerAccepted() {
    _warnIfNotInitialized('loadDisclaimerAccepted');
    if (kIsWeb) {
      final raw = _get(_disclaimerKey, defaultValue: false);
      return raw is bool ? raw : false;
    }
    final box = _settingsBox;
    if (box == null) return false;
    final raw = box.get(_disclaimerKey, defaultValue: false);
    return raw is bool ? raw : false;
  }

  // ========== LANGUAGE ==========

  /// Save selected language
  static Future<void> saveLanguage(AppLanguage language) async {
    _warnIfNotInitialized('saveLanguage');
    if (kIsWeb) {
      await _put(_languageKey, language.index);
      return;
    }
    await _settingsBox?.put(_languageKey, language.index);
  }

  /// Load selected language
  static AppLanguage loadLanguage() {
    _warnIfNotInitialized('loadLanguage');
    int index = AppLanguage.tr.index;
    if (kIsWeb) {
      final raw = _get(_languageKey, defaultValue: AppLanguage.tr.index);
      index = raw is int ? raw : AppLanguage.tr.index;
    } else {
      final box = _settingsBox;
      if (box == null) return AppLanguage.tr;
      final raw = box.get(_languageKey, defaultValue: AppLanguage.tr.index);
      index = raw is int ? raw : AppLanguage.tr.index;
    }
    if (index >= 0 && index < AppLanguage.values.length) {
      return AppLanguage.values[index];
    }
    return AppLanguage.tr;
  }

  // ========== THEME MODE ==========

  /// Save theme mode
  static Future<void> saveThemeMode(ThemeMode mode) async {
    _warnIfNotInitialized('saveThemeMode');
    if (kIsWeb) {
      await _put(_themeModeKey, mode.index);
      return;
    }
    await _settingsBox?.put(_themeModeKey, mode.index);
  }

  /// Load theme mode (defaults to dark)
  static ThemeMode loadThemeMode() {
    _warnIfNotInitialized('loadThemeMode');
    int index = ThemeMode.dark.index;
    if (kIsWeb) {
      final raw = _get(_themeModeKey, defaultValue: ThemeMode.dark.index);
      index = raw is int ? raw : ThemeMode.dark.index;
    } else {
      final box = _settingsBox;
      if (box == null) return ThemeMode.dark;
      final raw = box.get(_themeModeKey, defaultValue: ThemeMode.dark.index);
      index = raw is int ? raw : ThemeMode.dark.index;
    }
    if (index >= 0 && index < ThemeMode.values.length) {
      return ThemeMode.values[index];
    }
    return ThemeMode.dark;
  }

  // ========== HOUSE SYSTEM ==========

  static const String _houseSystemKey = 'house_system';

  /// Save selected house system
  static Future<void> saveHouseSystem(int index) async {
    _warnIfNotInitialized('saveHouseSystem');
    if (kIsWeb) {
      await _put(_houseSystemKey, index);
      return;
    }
    await _settingsBox?.put(_houseSystemKey, index);
  }

  /// Load selected house system index (defaults to 0 = Placidus)
  static int loadHouseSystemIndex() {
    _warnIfNotInitialized('loadHouseSystemIndex');
    if (kIsWeb) {
      final raw = _get(_houseSystemKey, defaultValue: 0);
      return raw is int ? raw : 0;
    }
    final box = _settingsBox;
    if (box == null) return 0;
    final raw = box.get(_houseSystemKey, defaultValue: 0);
    return raw is int ? raw : 0;
  }

  // ========== CLEAR ALL DATA ==========

  /// Clear all stored data
  static Future<void> clearAllData() async {
    if (kIsWeb) {
      _webCache.clear();
      await _webPrefs?.clear();
      return;
    }
    await _profileBox?.clear();
    await _settingsBox?.clear();
  }
}
