import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/app_injection_container.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/task_bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/task_event.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/board_local_service.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/task_local_service.dart';

final List<BlocProvider> homeBlocProviders = [
  BlocProvider<TaskBloc>(
    create: (_) => TaskBloc(
      localService: TaskLocalService(prefs: sl()),
    )..add(GetTasksEvent()),
  ),

  BlocProvider<BoardBloc>(
    create: (context) => BoardBloc(
        localService: BoardLocalService(prefs: sl()),
        taskBloc: context.read<TaskBloc>())
      ..add(GetBoardsEvent()),
  ),

  //* Cubits
  BlocProvider<SideBarCubit>(
    create: (_) => SideBarCubit(),
  ),
];
