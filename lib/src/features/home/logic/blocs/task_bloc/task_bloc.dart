import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/task_local_service.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskLocalService localService;
  TaskBloc({
    required this.localService,
  }) : super(TaskState.empty()) {
    on<GetTasksEvent>(_getTasks);
    on<CreateNewTaskEvent>(_createNewTask);
    on<EditTaskEvent>(_editTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<ToggleSubTaskCompletionEvent>(_toggleSubTaskCompletion);
  }

  void _getTasks(GetTasksEvent event, Emitter<TaskState> emit) async {
    final tasks = await localService.getTasks();
    emit(state.copyWith(tasks: tasks));
  }

  void _createNewTask(CreateNewTaskEvent event, Emitter<TaskState> emit) {
    if (event.title.isEmpty) {
      throw ArgumentError('task title cannot be empty');
    }
    final newTask = Task(
      id: getUniqueId(),
      boardId: event.boardId,
      title: event.title,
      description: event.description,
      subtasks: event.subTasks,
      status: event.status,
    );
    final newList = [newTask, ...state.tasks];

    localService.createTask(newTask);
    emit(state.copyWith(tasks: newList));
  }

  void _editTask(EditTaskEvent event, Emitter<TaskState> emit) {
    if (event.id.isEmpty || event.subTasks.isEmpty || event.status.isEmpty) {
      throw ArgumentError('task id, subtasks, and status cannot be empty');
    }

    final taskToUpdate = state.tasks.firstWhere(
      (b) => b.id == event.id,
      orElse: () => Task.initial(),
    );

    if (taskToUpdate == Task.initial()) {
      throw ArgumentError('task does not exist');
    }

    final editedTask = taskToUpdate.copyWith(
      id: event.id,
      title: event.title,
      description: event.description,
      subtasks: event.subTasks,
      status: event.status,
    );

    final updatedList = state.tasks.map((task) {
      return task.id == event.id ? editedTask : task;
    }).toList();

    localService.editTask(editedTask);
    emit(state.copyWith(tasks: updatedList));
  }

  void _deleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) {
    if (event.id.isEmpty) {
      throw ArgumentError('task name cannot be empty');
    }
    final taskToDelete = state.tasks.firstWhere(
      (b) => b.id == event.id,
      orElse: () => Task.initial(),
    );

    if (taskToDelete == Task.initial()) {
      throw ArgumentError('task does not exist');
    }

    final updatedList = state.tasks.where((b) => b.id != event.id).toList();

    localService.removeTask(taskToDelete.id);
    emit(state.copyWith(tasks: updatedList));
  }

  void _toggleSubTaskCompletion(
      ToggleSubTaskCompletionEvent event, Emitter<TaskState> emit) async {
    final taskToUpdate = state.tasks.firstWhere(
      (task) => task.id == event.taskId,
      orElse: () => Task.initial(),
    );

    if (taskToUpdate == Task.initial()) {
      throw ArgumentError('Task does not exist');
    }

    // Find the subtask to toggle
    final subTaskIndex = taskToUpdate.subtasks.indexWhere(
      (subTask) => subTask.id == event.subTaskId,
    );

    if (subTaskIndex == -1) {
      throw ArgumentError('Subtask does not exist');
    }

    // Toggle the completion of the subtask
    final updatedSubTask = taskToUpdate.subtasks[subTaskIndex].copyWith(
      isDone: !taskToUpdate.subtasks[subTaskIndex].isDone,
    );

    // Replace the old subtask with the updated one
    final updatedSubtasks = List<SubTask>.from(taskToUpdate.subtasks)
      ..[subTaskIndex] = updatedSubTask;

    // Create the updated task
    final updatedTask = taskToUpdate.copyWith(
      subtasks: updatedSubtasks,
    );

    // Update the task in the state
    final updatedList = state.tasks.map((task) {
      return task.id == event.taskId ? updatedTask : task;
    }).toList();

    localService.editTask(updatedTask);
    emit(state.copyWith(tasks: updatedList));
  }
}
