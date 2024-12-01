import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:kanban_task_manager/src/features/home/data/models/sub_task.dart';
import 'package:kanban_task_manager/src/features/home/data/models/task.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';

void main() {
  late TaskDetailCubit taskDetailCubit;
  late Task task;

  setUp(() {
    task = Task(
      id: 'id',
      boardId: 'boardId',
      title: 'title',
      description: 'description',
      subtasks: [
        SubTask(
          id: '1',
          taskId: 'taskId',
          title: 'title 1',
          isDone: true,
        ),
        SubTask(
          id: '2',
          taskId: 'taskId',
          title: 'title 2',
          isDone: false,
        ),
      ],
      status: 'status',
    );
    taskDetailCubit = TaskDetailCubit(task);
  });

  tearDown(() {
    taskDetailCubit.close();
  });

  group(
    'Task Detail Cubit',
    () {
      blocTest(
        'emits updated task with new status when [changeStatus] function is called',
        build: () => taskDetailCubit,
        act: (bloc) => bloc.changeStatus('new status'),
        expect: () => [
          isA<Task>().having((t) => t.status, 'status', 'new status'),
        ],
      );

      blocTest(
        'emits updated task with inversed isDone value when [toggleSubtaskCompletion] function is called',
        build: () => taskDetailCubit,
        act: (bloc) => bloc.toggleSubtaskCompletion('2'),
        expect: () => [
          isA<Task>().having(
            (t) => t.subtasks[1].isDone,
            'subtask isDone property',
            true,
          ),
        ],
      );
    },
  );
}
