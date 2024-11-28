import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_bloc.dart';

final List<BlocProvider> themeBlocProviders = [
  BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
];
