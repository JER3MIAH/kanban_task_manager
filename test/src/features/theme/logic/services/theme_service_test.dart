import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kanban_task_manager/src/features/theme/logic/services/theme_service.dart';

void main() {
  late SharedPreferences prefs;
  late ThemeLocalService themeLocalService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    themeLocalService = ThemeLocalService(prefs: prefs);
  });

  group(
    'Theme Local Service',
    () {
      test('saveThemePreference saves the theme to shared preferences',
          () async {
        await themeLocalService.saveThemePreference(true);
        expect(prefs.getBool('theme_pref'), true);
      });

      test('getThemePreference retrieves the saved theme preference', () async {
        prefs.setBool('theme_pref', true);
        expect(themeLocalService.getThemePreference(), true);
      });
    },
  );
}
