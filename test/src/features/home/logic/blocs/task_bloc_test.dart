import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/task_bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/task_event.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/task_state.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/services/task_local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late TaskBloc taskBloc;
  late TaskLocalService taskLocalService;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    taskLocalService = TaskLocalService(prefs: prefs);
    taskBloc = TaskBloc(localService: taskLocalService);
  });

  tearDown(() {
    taskBloc.close();
  });

  group('Task Bloc', () {
    blocTest<TaskBloc, TaskState>(
      'emits updated tasks when GetTasksEvent is added',
      build: () => taskBloc,
      act: (bloc) => bloc.add(GetTasksEvent()),
      expect: () => [
        isA<TaskState>().having((s) => s.tasks, 'tasks', []),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits updated tasks when CreateNewTaskEvent is added',
      build: () => taskBloc,
      act: (bloc) {
        bloc.add(CreateNewTaskEvent(
          title: 'New Task',
          boardId: 'boardId',
          description: 'desc',
          status: 'Todo',
          subTasks: [],
        ));
      },
      expect: () => [
        isA<TaskState>()
            .having((s) => s.tasks.first, 'task', isA<Task>())
            .having((s) => s.tasks.first.title, 'title', 'New Task')
            .having((s) => s.tasks.first.boardId, 'board id', 'boardId')
            .having((s) => s.tasks.first.description, 'description', 'desc')
            .having((s) => s.tasks.first.status, 'status', 'Todo')
            .having((s) => s.tasks.first.subtasks, 'sub tasks', [])
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state.tasks, isNotEmpty);
      },
    );

    blocTest<TaskBloc, TaskState>(
      'emits updated tasks when EditTaskEvent is added',
      build: () => taskBloc,
      seed: () => TaskState(tasks: [
        Task(
          id: '1',
          title: 'Old Task',
          boardId: 'boardId',
          description: 'desc',
          status: 'Todo',
          subtasks: [],
        )
      ]),
      act: (bloc) {
        bloc.add(EditTaskEvent(
          id: '1',
          title: 'Updated Task',
        ));
      },
      expect: () => [isA<TaskState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state.tasks, isNotEmpty);
        expect(state.tasks[0], isA<Task>());
        expect(state.tasks[0].title, 'Updated Task');
      },
    );

    blocTest<TaskBloc, TaskState>(
      'does not edit a task if properties(other than the id) are empty are empty in EditTaskEvent',
      build: () => taskBloc,
      seed: () => TaskState(tasks: [
        Task(
          id: '1',
          title: 'Task',
          boardId: 'boardId',
          description: 'desc',
          status: 'Todo',
          subtasks: [],
        )
      ]),
      act: (bloc) => bloc.add(EditTaskEvent(id: '1')),
      expect: () => [],
    );

    blocTest<TaskBloc, TaskState>(
      'emits updated tasks when DeleteTaskEvent is added',
      build: () => taskBloc,
      seed: () => TaskState(tasks: [
        Task(
          id: '1',
          title: 'Task',
          boardId: 'boardId',
          description: 'desc',
          status: 'Todo',
          subtasks: [],
        )
      ]),
      act: (bloc) => bloc.add(DeleteTaskEvent(id: '1')),
      expect: () => [
        isA<TaskState>().having((s) => s.tasks, 'tasks', []),
      ],
    );
  });
}
