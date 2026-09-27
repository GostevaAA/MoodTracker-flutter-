import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/theme_preset.dart';

/// Сохраняет и читает выбранную тему из shared_preferences.
class ThemeRepository {
  ThemeRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _presetKey = 'theme_preset';
  static const _modeKey = 'theme_mode';

  ThemePresetId getPreset() {
    return ThemePresetId.fromStorage(_prefs.getString(_presetKey));
  }

  Future<void> setPreset(ThemePresetId preset) async {
    await _prefs.setString(_presetKey, preset.storageKey);
  }

  ThemeMode getMode() {
    final stored = _prefs.getString(_modeKey);
    switch (stored) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_modeKey, value);
  }
}
