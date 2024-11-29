import 'dart:developer';

import 'package:kanban_task_manager/src/core/core.dart';

class ThemeLocalService extends LocalStorageService {
  ThemeLocalService();

  Future<void> saveThemePreference(bool value) async {
    try {
      await prefs.setBool('theme_pref', value);
    } catch (e) {
      log('save theme preference error: $e');
    }
  }

  bool getThemePreference() {
    try {
      final s = prefs.getBool('theme_pref');

      if (s == null) return false;
      return true;
    } catch (e) {
      log('get theme preference error: $e');
      return false;
    }
  }
}
