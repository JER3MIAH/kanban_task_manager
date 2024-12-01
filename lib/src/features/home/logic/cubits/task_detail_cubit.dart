import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/models/task.dart';

class TaskDetailCubit extends Cubit<Task> {
  TaskDetailCubit(super.initialState);

  void changeStatus(String newStatus) {
    emit(state.copyWith(status: newStatus));
  }

  void toggleSubtaskCompletion(String subtaskId) {
    final updatedSubtasks = state.subtasks.map((subtask) {
      if (subtask.id == subtaskId) {
        return subtask.copyWith(isDone: !subtask.isDone);
      }
      return subtask;
    }).toList();
    emit(state.copyWith(subtasks: updatedSubtasks));
  }
}
