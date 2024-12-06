import 'package:equatable/equatable.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class GetBoardsEvent extends BoardEvent {
  const GetBoardsEvent();
}

class SelectBoardEvent extends BoardEvent {
  final Board board;
  const SelectBoardEvent({
    required this.board,
  });

  @override
  List<Object> get props => [board];
}

class CreateNewBoardEvent extends BoardEvent {
  final String name;
  final List<String> columns;
  const CreateNewBoardEvent({
    required this.name,
    required this.columns,
  });

  @override
  List<Object> get props => [name, columns];
}

class EditBoardEvent extends BoardEvent {
  final String id;
  final String name;
  final List<String> columns;
  const EditBoardEvent({
    required this.id,
    required this.name,
    required this.columns,
  });

  @override
  List<Object> get props => [id, name, columns];
}

class DeleteBoardEvent extends BoardEvent {
  final String id;
  const DeleteBoardEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
