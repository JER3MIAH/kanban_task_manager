import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalService {
  final SharedPreferences prefs;

  ThemeLocalService({required this.prefs});

  Future<void> saveThemePreference(bool value) async {
    try {
      await prefs.setBool('theme_pref', value);
    } catch (e) {
      log('save theme preference error: $e');
    }
  }

  bool getThemePreference() {
    try {
      return prefs.getBool('theme_pref') ?? false;
    } catch (e) {
      log('get theme preference error: $e');
      return false;
    }
  }
}

