import 'package:equatable/equatable.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';

class BoardState extends Equatable {
  final Board selectedBoard;
  final List<Board> boards;
  const BoardState({
    this.selectedBoard = const Board.initial(),
    required this.boards,
  });

  @override
  List<Object> get props => [selectedBoard, boards];

  BoardState.empty()
      : selectedBoard = Board.initial(),
        boards = [];

  BoardState copyWith({
    Board? selectedBoard,
    List<Board>? boards,
  }) {
    return BoardState(
      selectedBoard: selectedBoard ?? this.selectedBoard,
      boards: boards ?? this.boards,
    );
  }
}
