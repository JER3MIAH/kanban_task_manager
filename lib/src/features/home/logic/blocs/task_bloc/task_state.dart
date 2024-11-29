import 'package:equatable/equatable.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  const TaskState({
    required this.tasks,
  });

  @override
  List<Object> get props => [tasks];

  TaskState.empty() : tasks = [];

  TaskState copyWith({
    List<Task>? tasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }
}
