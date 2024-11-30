import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/task_local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kanban_task_manager/src/features/home/data/models/task.dart';

void main() {
  late SharedPreferences prefs;
  late TaskLocalService taskLocalService;

  final testTask = Task(
    id: '1',
    boardId: 'board-1',
    title: 'Test Task',
    description: 'This is a test task',
    subtasks: [],
    status: 'Todo',
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    taskLocalService = TaskLocalService(prefs: prefs);
  });

  group('TaskLocalService', () {
    test('getTasks returns an empty list if no tasks are stored', () async {
      final tasks = await taskLocalService.getTasks();
      expect(tasks, isEmpty);
    });

    test('createTask adds a task to storage', () async {
      await taskLocalService.createTask(testTask);

      final storedTasks = prefs.getStringList('task_list');
      expect(storedTasks, isNotNull);
      expect(storedTasks!.length, 1);
      expect(Task.fromJson(storedTasks.first), testTask);
    });

    test('getTasks retrieves stored tasks', () async {
      await taskLocalService.createTask(testTask);

      final tasks = await taskLocalService.getTasks();
      expect(tasks.length, 1);
      expect(tasks.first, testTask);
    });

    test('editTask updates an existing task', () async {
      await taskLocalService.createTask(testTask);

      final updatedTask = testTask.copyWith(status: 'In Progress');
      await taskLocalService.editTask(updatedTask);

      final tasks = await taskLocalService.getTasks();
      expect(tasks.first.status, 'In Progress');
      expect(tasks.first.title, testTask.title); // Ensure title is unchanged
    });

    test('removeTask deletes a task from storage', () async {
      await taskLocalService.createTask(testTask);
      await taskLocalService.removeTask(testTask.id);

      final tasks = await taskLocalService.getTasks();
      expect(tasks, isEmpty);
    });
  });
}
