import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasksEvent extends TaskEvent {
  const GetTasksEvent();
}

class CreateNewTaskEvent extends TaskEvent {
  final String boardId;
  final String title;
  final String description;
  final List<String> subTasks;
  final String status;
  const CreateNewTaskEvent({
    required this.boardId,
    required this.title,
    required this.description,
    required this.subTasks,
    required this.status,
  });

  @override
  List<Object> get props => [boardId, title, description, subTasks, status];
}

class EditTaskEvent extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final List<String> subTasks;
  final String status;
  const EditTaskEvent({
    required this.id,
    this.title = '',
    this.description = '',
    this.subTasks = const [],
    this.status = '',
  });

  @override
  List<Object> get props => [id, title, description, subTasks, status];
}

class ToggleSubTaskEvent extends TaskEvent {
  final String taskId;
  final String subTaskId;

  const ToggleSubTaskEvent({
    required this.taskId,
    required this.subTaskId,
  });

  @override
  List<Object> get props => [taskId, subTaskId];
}

class ToggleTaskStatusEvent extends TaskEvent {
  final String taskId;
  final String newStatus;

  const ToggleTaskStatusEvent({
    required this.taskId,
    required this.newStatus,
  });

  @override
  List<Object> get props => [taskId, newStatus];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  const DeleteTaskEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
