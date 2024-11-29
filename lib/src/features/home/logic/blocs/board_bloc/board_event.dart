import 'package:equatable/equatable.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class GetBoardsEvent extends BoardEvent {
  const GetBoardsEvent();
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
