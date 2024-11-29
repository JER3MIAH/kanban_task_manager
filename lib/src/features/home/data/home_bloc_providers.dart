import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/board_local_service.dart';

final List<BlocProvider> homeBlocProviders = [
  BlocProvider<BoardBloc>(
    create: (_) => BoardBloc(
      localService: BoardLocalService(),
    )..add(GetBoardsEvent()),
  ),
];
