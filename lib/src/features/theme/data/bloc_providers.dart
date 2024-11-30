import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/app_injection_container.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/features/theme/logic/services/theme_service.dart';

final List<BlocProvider> themeBlocProviders = [
  BlocProvider<ThemeBloc>(
    create: (_) => ThemeBloc(
      localService: ThemeLocalService(prefs: sl()),
    )..add(GetSavedThemePrefsEvent()),
  ),
];
