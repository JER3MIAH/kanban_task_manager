import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/board_local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kanban_task_manager/src/features/home/data/models/board.dart';

void main() {
  late SharedPreferences prefs;
  late BoardLocalService boardLocalService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    boardLocalService = BoardLocalService(prefs: prefs);
  });

  group('BoardLocalService', () {
    final testBoard = Board(
      id: '1',
      name: 'Test Board',
      columns: ['Todo', 'Doing', 'Done'],
    );

    test('getBoards returns an empty list if no boards are stored', () async {
      final boards = await boardLocalService.getBoards();
      expect(boards, isEmpty);
    });
    test('getSelectedBoard returns null if no board is selected', () async {
      final board = await boardLocalService.getSelectedBoard();
      expect(board, null);
    });

    test('getSelectedBoard returns board if selected board exists', () async {
      boardLocalService.changeSelectedBoard(testBoard);
      final selectedBoard = prefs.getString('selected_board');
      expect(selectedBoard, isNotNull);
      expect(Board.fromJson(selectedBoard!), testBoard);
    });

    test('createBoard adds a board to the storage', () async {
      await boardLocalService.createBoard(testBoard);

      final storedBoards = prefs.getStringList('board_list');
      expect(storedBoards, isNotNull);
      expect(storedBoards!.length, 1);
      expect(Board.fromJson(storedBoards.first), testBoard);
    });

    test('getBoards retrieves stored boards', () async {
      await boardLocalService.createBoard(testBoard);
      final boards = await boardLocalService.getBoards();

      expect(boards.length, 1);
      expect(boards.first, testBoard);
    });

    test('editBoard updates an existing board', () async {
      await boardLocalService.createBoard(testBoard);

      final updatedBoard = testBoard.copyWith(name: 'Updated Board');

      await boardLocalService.editBoard(updatedBoard);

      final boards = await boardLocalService.getBoards();
      expect(boards.first.name, 'Updated Board');
      expect(boards.first.columns, testBoard.columns);
    });

    test('removeBoard deletes a board from storage', () async {
      await boardLocalService.createBoard(testBoard);
      await boardLocalService.removeBoard(testBoard.id);

      final boards = await boardLocalService.getBoards();
      expect(boards, isEmpty);
    });
  });
}
