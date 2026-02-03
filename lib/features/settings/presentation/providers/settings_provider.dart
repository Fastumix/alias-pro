import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/app_settings.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  static const String _settingsKey = 'app_settings';

  SettingsNotifier() : super(const AppSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_settingsKey);
      
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        state = AppSettings.fromJson(json);
      }
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(state.toJson());
      await prefs.setString(_settingsKey, jsonString);
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  Future<void> updateUserName(String name) async {
    state = state.copyWith(userName: name);
    await _saveSettings();
  }

  Future<void> updateAvatarUrl(String url) async {
    state = state.copyWith(avatarUrl: url);
    await _saveSettings();
  }

  Future<void> updateLanguage(String languageCode) async {
    state = state.copyWith(language: languageCode);
    await _saveSettings();
  }

  Future<void> toggleSound() async {
    state = state.copyWith(soundEnabled: !state.soundEnabled);
    await _saveSettings();
  }

  Future<void> toggleVibration() async {
    state = state.copyWith(vibrationEnabled: !state.vibrationEnabled);
    await _saveSettings();
  }

  Future<void> resetSettings() async {
    state = const AppSettings();
    await _saveSettings();
  }
}
