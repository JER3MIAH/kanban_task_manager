import 'package:equatable/equatable.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';

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
  final List<SubTask> subTasks;
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
  final List<SubTask> subTasks;
  final String status;
  const EditTaskEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.subTasks,
    required this.status,
  });

  @override
  List<Object> get props => [id, title, description, subTasks, status];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  const DeleteTaskEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ToggleSubTaskCompletionEvent extends TaskEvent {
  final String taskId;
  final String subTaskId;

  const ToggleSubTaskCompletionEvent({
    required this.taskId,
    required this.subTaskId,
  });

  @override
  List<Object> get props => [taskId, subTaskId];
}
