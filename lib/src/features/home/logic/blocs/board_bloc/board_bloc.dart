import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/board_bloc/board_event.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/board_local_service.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardLocalService localService;
  final TaskBloc taskBloc;
  BoardBloc({
    required this.localService,
    required this.taskBloc,
  }) : super(BoardState.empty()) {
    on<GetBoardsEvent>(_getBoards);
    on<SelectBoardEvent>(_selectBoard);
    on<CreateNewBoardEvent>(_createNewBoard);
    on<EditBoardEvent>(_editBoard);
    on<DeleteBoardEvent>(_deleteBoard);
  }

  void _getBoards(GetBoardsEvent event, Emitter<BoardState> emit) async {
    final boards = await localService.getBoards();
    final selectedBoard = await localService.getSelectedBoard();
    emit(state.copyWith(
      selectedBoard: selectedBoard,
      boards: boards,
    ));
  }

  void _selectBoard(SelectBoardEvent event, Emitter<BoardState> emit) async {
    localService.changeSelectedBoard(event.board);
    emit(state.copyWith(selectedBoard: event.board));
  }

  void _createNewBoard(CreateNewBoardEvent event, Emitter<BoardState> emit) {
    if (event.name.isEmpty) {
      throw ArgumentError('board name cannot be empty');
    }
    final newBoard = Board(
      id: getUniqueId(),
      name: event.name,
      columns: event.columns,
    );
    final newList = [newBoard, ...state.boards];

    localService.createBoard(newBoard);
    emit(state.copyWith(boards: newList));
    if (state.boards.length == 1) {
      emit(state.copyWith(selectedBoard: newBoard));
    }
  }

  void _editBoard(EditBoardEvent event, Emitter<BoardState> emit) {
    if (event.id.isEmpty) {
      throw ArgumentError('Id of board to be edited is required');
    }
    final boardToEdit = state.boards.firstWhere(
      (b) => b.id == event.id,
      orElse: () => Board.initial(),
    );

    if (boardToEdit == Board.initial()) {
      throw ArgumentError('Board with provided id does not exist');
    }

    if (event.name.isEmpty && event.columns.isEmpty) {
      return;
    }

    final editedBoard = Board(
      id: event.id,
      name: event.name,
      columns: event.columns,
    );

    final updatedList = state.boards.map((board) {
      return board.id == event.id ? editedBoard : board;
    }).toList();

    localService.editBoard(editedBoard);
    emit(state.copyWith(
      boards: updatedList,
      selectedBoard:
          editedBoard.id == state.selectedBoard.id ? editedBoard : null,
    ));

    //* Map old columns to new columns
    final newColumns = editedBoard.columns;
    final oldColumns = boardToEdit.columns;

    for (int i = 0; i < newColumns.length; i++) {
      final newColumn = newColumns[i];
      if (i < oldColumns.length) {
        final oldColumn = oldColumns[i];

        //* Update tasks from the old column to the new column
        final tasksToUpdate = taskBloc.state.tasks.where(
          (t) => t.boardId == event.id && t.status == oldColumn,
        );
        for (var task in tasksToUpdate) {
          taskBloc.add(
            ToggleTaskStatusEvent(
              taskId: task.id,
              newStatus: newColumn,
            ),
          );
        }
      }
    }
  }

  void _deleteBoard(DeleteBoardEvent event, Emitter<BoardState> emit) {
    if (event.id.isEmpty) {
      throw ArgumentError('board id cannot be empty');
    }
    final boardToDelete = state.boards.firstWhere(
      (b) => b.id == event.id,
      orElse: () => Board.initial(),
    );

    if (boardToDelete == Board.initial()) {
      throw ArgumentError('board does not exist');
    }

    final updatedList = state.boards.where((b) => b.id != event.id).toList();

    localService.removeBoard(boardToDelete.id);
    emit(state.copyWith(
      boards: updatedList,
    ));
    localService.changeSelectedBoard(
        (state.boards.isEmpty ? null : state.boards.first));
    emit(state.copyWith(
      selectedBoard: boardToDelete.id == state.selectedBoard.id
          ? (state.boards.isEmpty ? Board.initial() : state.boards.first)
          : null,
    ));

    //* remove tasks under this baoard
    final tasksToDelete =
        taskBloc.state.tasks.where((t) => t.boardId == event.id).toList();
    for (var task in tasksToDelete) {
      taskBloc.add(DeleteTaskEvent(id: task.id));
    }
  }
}
