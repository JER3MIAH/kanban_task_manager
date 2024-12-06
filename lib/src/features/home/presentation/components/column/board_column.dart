import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/bloc.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

import '../../../logic/blocs/blocs.dart';

class BoardColumn extends StatelessWidget {
  final String title;
  const BoardColumn({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (_, boardState) {
        return BlocBuilder<TaskBloc, TaskState>(
          builder: (_, taskState) {
            final tasks = taskState.tasks.where((task) =>
                task.status == title &&
                boardState.selectedBoard.id == task.boardId).toList();

            return Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: SizedBox(
                width: 280,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        XBox(10),
                        AppText(
                          '$title (${tasks.length})',
                          fontSize: 12,
                          color: theme.inversePrimary,
                        ),
                      ],
                    ),
                    YBox(20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (_, index) {
                          final task = tasks[index];
                          return TaskTile(
                            task: task,
                            onTap: () {
                              AppDialog.dialog(
                                context,
                                TaskDetailDialog(
                                  task: task,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
