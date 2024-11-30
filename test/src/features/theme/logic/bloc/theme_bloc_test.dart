import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/features/theme/logic/services/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  late ThemeBloc themeBloc;
  late SharedPreferences prefs;

  setUp(() async{
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    themeBloc = ThemeBloc(localService: ThemeLocalService(prefs: prefs));
  });

  tearDown(() {
    themeBloc.close();
  });

  group(
    'Theme Bloc -',
    () {
      blocTest<ThemeBloc, ThemeState>(
        'emits true or false when GetSavedThemePrefsEvent is added',
        build: () {
          return themeBloc;
        },
        act: (bloc) => bloc.add(GetSavedThemePrefsEvent()),
        expect: () => [isA<ThemeState>()],
        verify: (bloc) {
          final state = bloc.state;
          expect(state.isDarkMode, anyOf(equals(true), equals(false)));
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'emits updated isDarkMode when ToggleThemeEvent is added',
        build: () => themeBloc,
        seed: () => ThemeState(isDarkMode: true),
        act: (bloc) => bloc.add(ToggleThemeEvent()),
        expect: () => [ThemeState(isDarkMode: false)],
      );
    },
  );
}
