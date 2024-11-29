import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/board_bloc/board_event.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/board_local_service.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardLocalService localService;
  BoardBloc({
    required this.localService,
  }) : super(BoardState.empty()) {
    on<GetBoardsEvent>(_getBoards);
    on<CreateNewBoardEvent>(_createNewBoard);
    on<EditBoardEvent>(_editBoard);
    on<DeleteBoardEvent>(_deleteBoard);
  }

  void _getBoards(GetBoardsEvent event, Emitter<BoardState> emit) async {
    final boards = await localService.getBoards();
    emit(state.copyWith(boards: boards));
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
  }

  void _editBoard(EditBoardEvent event, Emitter<BoardState> emit) {
    if (event.id.isEmpty || event.name.isEmpty || event.columns.isEmpty) {
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
    emit(state.copyWith(boards: updatedList));
  }

  void _deleteBoard(DeleteBoardEvent event, Emitter<BoardState> emit) {
    if (event.id.isEmpty) {
      throw ArgumentError('board name cannot be empty');
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
    emit(state.copyWith(boards: updatedList));
    //TODO: Add event to remove tasks under this baoard
  }
}
