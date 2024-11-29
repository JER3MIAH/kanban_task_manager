import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/theme/logic/services/theme_service.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeLocalService localService;
  ThemeBloc({
    required this.localService,
  }) : super(const ThemeState()) {
    on<GetSavedThemePrefsEvent>((event, emit) {
      emit(state.copyWith(
        isDarkMode: localService.getThemePreference(),
      ));
    });

    on<ToggleThemeEvent>((event, emit) {
      localService.saveThemePreference(!state.isDarkMode);
      emit(
        state.copyWith(isDarkMode: !state.isDarkMode),
      );
    });
  }
}
