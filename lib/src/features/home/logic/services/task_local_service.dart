import 'dart:developer';
import 'package:kanban_task_manager/src/core/core.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskLocalService extends LocalStorageService {
  final SharedPreferences prefs;

  TaskLocalService({required this.prefs});


  Future<List<Task>> getTasks() async {
    try {
      List<String>? jsonList = prefs.getStringList('task_list');
      if (jsonList == null) return [];

      return jsonList.map((json) => Task.fromJson(json)).toList();
    } catch (e, stack) {
      log('error getting tasks $e at $stack');
      return [];
    }
  }

  Future<void> createTask(Task task) async {
    try {
      List<String>? existingJsonList = prefs.getStringList('task_list');

      List<Task> existing = existingJsonList != null
          ? existingJsonList.map((json) => Task.fromJson((json))).toList()
          : [];

      if (!existing.any((b) => b.id == task.id)) {
        existing.add(task);
      }

      List<String> updatedJsonList =
          existing.map((preset) => preset.toJson()).toList();
      await prefs.setStringList('task_list', updatedJsonList);
    } catch (e, stack) {
      log('error creating task $e at $stack');
    }
  }

  Future<void> editTask(Task updatedTask) async {
    try {
      List<String>? jsonList = prefs.getStringList('task_list');

      if (jsonList != null) {
        List<Task> existing = jsonList.map((json) {
          return Task.fromJson(json);
        }).toList();

        int index = existing.indexWhere((timer) => timer.id == updatedTask.id);

        if (index != -1) {
          existing[index] = updatedTask;
        }

        List<String> updatedJsonList =
            existing.map((timer) => timer.toJson()).toList();
        await prefs.setStringList('task_list', updatedJsonList);
      }
    } catch (e, stack) {
      log('error editing task $e at $stack');
    }
  }

  Future<void> removeTask(String id) async {
    try {
      List<String>? jsonList = prefs.getStringList('task_list');

      if (jsonList != null) {
        List<Task> existing =
            jsonList.map((json) => Task.fromJson(json)).toList();

        existing.removeWhere((task) => task.id == id);

        List<String> updatedjsonList =
            existing.map((task) => task.toJson()).toList();
        await prefs.setStringList('task_list', updatedjsonList);
      }
    } catch (e, stack) {
      log('error removing task $e at $stack');
    }
  }
}
