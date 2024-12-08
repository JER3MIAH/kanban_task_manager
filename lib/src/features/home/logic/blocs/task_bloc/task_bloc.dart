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
    on<ToggleSubTaskEvent>(_toggleSubTask);
    on<ToggleTaskStatusEvent>(_toggleTaskStatus);
    on<DeleteTaskEvent>(_deleteTask);
  }

  void _getTasks(GetTasksEvent event, Emitter<TaskState> emit) async {
    final tasks = await localService.getTasks();
    emit(state.copyWith(tasks: tasks));
  }

  void _createNewTask(CreateNewTaskEvent event, Emitter<TaskState> emit) {
    if (event.title.isEmpty) {
      throw ArgumentError('task title cannot be empty');
    }
    final taskId = getUniqueId();
    final newTask = Task(
      id: taskId,
      boardId: event.boardId,
      title: event.title,
      description: event.description,
      subtasks: event.subTasks
          .map((e) => SubTask(
                id: getUniqueId(),
                taskId: taskId,
                title: e,
                isDone: false,
              ))
          .toList(),
      status: event.status,
    );
    final newList = [newTask, ...state.tasks];

    localService.createTask(newTask);
    emit(state.copyWith(tasks: newList));
  }

  void _toggleTaskStatus(
    ToggleTaskStatusEvent event,
    Emitter<TaskState> emit,
  ) {
    final taskToUpdate = state.tasks.firstWhere(
      (task) => task.id == event.taskId,
      orElse: () => Task.initial(),
    );

    if (taskToUpdate == Task.initial()) {
      throw ArgumentError('Task with provided ID does not exist');
    }

    final updatedTask = taskToUpdate.copyWith(
      status: event.newStatus,
    );

    final updatedTasks = state.tasks.map((task) {
      return task.id == event.taskId ? updatedTask : task;
    }).toList();

    localService.editTask(updatedTask);

    emit(state.copyWith(tasks: updatedTasks));
  }

  void _editTask(EditTaskEvent event, Emitter<TaskState> emit) {
    if (event.id.isEmpty) {
      throw ArgumentError('Id of task to be edited is required');
    }
    final taskToEdit = state.tasks.firstWhere(
      (b) => b.id == event.id,
      orElse: () => Task.initial(),
    );

    if (taskToEdit == Task.initial()) {
      throw ArgumentError('Task with provided id does not exist');
    }

    if (event.title.isEmpty &&
        event.description.isEmpty &&
        event.subTasks.isEmpty &&
        event.status.isEmpty) {
      return;
    }

    final editedTask = taskToEdit.copyWith(
      id: event.id,
      title: event.title,
      description: event.description,
      subtasks: event.subTasks
          .map((e) => SubTask(
                id: taskToEdit.subtasks.map((st) => st.title).firstWhere(
                      (t) => t == e,
                      orElse: () => getUniqueId(),
                    ),
                taskId: event.id,
                title: e,
                isDone: taskToEdit.subtasks
                    .firstWhere(
                      (st) => st.title == e,
                      orElse: () => SubTask.initial(),
                    )
                    .isDone,
              ))
          .toList(),
      status: event.status,
    );

    final updatedList = state.tasks.map((task) {
      return task.id == event.id ? editedTask : task;
    }).toList();

    localService.editTask(editedTask);
    emit(state.copyWith(tasks: updatedList));
  }

  void _toggleSubTask(ToggleSubTaskEvent event, Emitter<TaskState> emit) {
    final taskToUpdate = state.tasks.firstWhere(
      (task) => task.id == event.taskId,
      orElse: () => Task.initial(),
    );

    if (taskToUpdate == Task.initial()) {
      throw ArgumentError('Task with provided ID does not exist');
    }

    final updatedSubTasks = taskToUpdate.subtasks.map((subTask) {
      if (subTask.id == event.subTaskId) {
        return subTask.copyWith(isDone: !subTask.isDone);
      }
      return subTask;
    }).toList();

    final updatedTask = taskToUpdate.copyWith(subtasks: updatedSubTasks);
    final updatedTasks = state.tasks.map((task) {
      return task.id == event.taskId ? updatedTask : task;
    }).toList();

    localService.editTask(updatedTask);
    emit(state.copyWith(tasks: updatedTasks));
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
}
