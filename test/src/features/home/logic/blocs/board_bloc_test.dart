import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/board_bloc/board_bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/board_bloc/board_event.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/board_bloc/board_state.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/board_local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late BoardBloc boardBloc;
  late BoardLocalService boardLocalService;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    boardLocalService = BoardLocalService(prefs: prefs);
    boardBloc = BoardBloc(localService: boardLocalService);
  });

  tearDown(() {
    boardBloc.close();
  });

  group('Board Bloc', () {
    blocTest<BoardBloc, BoardState>(
      'emits updated boards when GetBoardsEvent is added',
      build: () => boardBloc,
      act: (bloc) => bloc.add(GetBoardsEvent()),
      expect: () => [
        isA<BoardState>().having((s) => s.boards, 'boards', []),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'emits updated selected board when GetBoardsEvent is added',
      build: () => boardBloc,
      act: (bloc) => bloc.add(SelectBoardEvent(
        board: Board.initial(),
      )),
      expect: () => [
        isA<BoardState>().having(
          (s) => s.selectedBoard,
          'selected board',
          Board.initial(),
        ),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'emits updated boards when CreateNewBoardEvent is added',
      build: () => boardBloc,
      act: (bloc) {
        bloc.add(CreateNewBoardEvent(
            name: 'New Board', columns: ['Todo', 'In Progress', 'Done']));
      },
      expect: () => [
        isA<BoardState>()
            .having(
              (s) => s.boards.first,
              'boards[0]',
              isA<Board>(),
            )
            .having(
              (s) => s.boards.first.name,
              'boards[0].name',
              'New Board',
            )
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state.boards, isNotEmpty);
      },
    );

    blocTest<BoardBloc, BoardState>(
      'emits updated boards when EditBoardEvent is added',
      build: () => boardBloc,
      seed: () => BoardState(boards: [
        Board(
          id: '1',
          name: 'Old Board',
          columns: ['Todo', 'Doing', 'Done'],
        )
      ]),
      act: (bloc) {
        bloc.add(EditBoardEvent(
          id: '1',
          name: 'Updated Board',
          columns: ['Todo', 'In Progress'],
        ));
      },
      expect: () => [isA<BoardState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state.boards, isNotEmpty);
        expect(state.boards[0], isA<Board>());
        expect(state.boards[0].name, 'Updated Board');
      },
    );

    blocTest<BoardBloc, BoardState>(
      'does not edit a board if name, or columns are empty in EditBoardEvent',
      build: () => boardBloc,
      seed: () => BoardState(boards: [
        Board(
          id: '1',
          name: 'Board name',
          columns: ['Todo', 'Doing', 'Done'],
        )
      ]),
      act: (bloc) => bloc.add(EditBoardEvent(id: '1', name: '', columns: [])),
      expect: () => [],
    );

    blocTest<BoardBloc, BoardState>(
      'emits updated boards when DeleteBoardEvent is added',
      build: () => boardBloc,
      seed: () => BoardState(boards: [
        Board(
          id: '1',
          name: 'Old Board',
          columns: ['Todo', 'Doing', 'Done'],
        )
      ]),
      act: (bloc) => bloc.add(DeleteBoardEvent(id: '1')),
      expect: () => [
        isA<BoardState>().having((s) => s.boards, 'boards', []),
      ],
    );
  });
}
