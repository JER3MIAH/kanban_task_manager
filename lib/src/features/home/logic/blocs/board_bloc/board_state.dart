import 'package:equatable/equatable.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';

class BoardState extends Equatable {
  final List<Board> boards;
  const BoardState({
    required this.boards,
  });

  @override
  List<Object> get props => [boards];

  BoardState.empty() : boards = [];

  BoardState copyWith({
    List<Board>? boards,
  }) {
    return BoardState(
      boards: boards ?? this.boards,
    );
  }
}
