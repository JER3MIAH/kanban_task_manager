import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/data/data.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/bloc.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

import '../../../logic/blocs/blocs.dart';

class BoardColumn extends HookWidget {
  final String title;
  const BoardColumn({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isItemHovering = useState<bool>(false);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<BoardBloc, BoardState>(
          builder: (_, boardState) {
            return BlocBuilder<TaskBloc, TaskState>(
              builder: (_, taskState) {
                final tasks = taskState.tasks
                    .where((task) =>
                        task.status == title &&
                        boardState.selectedBoard.id == task.boardId)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: DragTarget<Task>(onAcceptWithDetails: (details) {
                    final task = details.data;
                    isItemHovering.value = false;
                    context.read<TaskBloc>().add(
                          ToggleTaskStatusEvent(
                            taskId: task.id,
                            newStatus: title,
                          ),
                        );
                  }, onLeave: (_) {
                    isItemHovering.value = false;
                  }, onWillAcceptWithDetails: (details) {
                    isItemHovering.value = true;
                    return true;
                  }, builder: (_, candidateItems, rejectedItems) {
                    return SizedBox(
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
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: isItemHovering.value || tasks.isEmpty
                                  ? BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: themeState.isDarkMode
                                            ? [
                                                Color(0xFF2B2C37)
                                                    .withOpacity(.25),
                                                Color(0xFF2B2C37)
                                                    .withOpacity(.125),
                                              ]
                                            : [
                                                Color(0xFFE9EFFA),
                                                Color(0xFFE9EFFA)
                                                    .withOpacity(.5),
                                              ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                  : null,
                              child: tasks.isEmpty
                                  ? Center(
                                      child: AppText(
                                        '. . .',
                                        fontSize: 24,
                                        color: theme.inversePrimary,
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: tasks.length,
                                      itemBuilder: (_, index) {
                                        final task = tasks[index];
                                        return Draggable<Task>(
                                          data: task,
                                          dragAnchorStrategy:
                                              pointerDragAnchorStrategy,
                                          feedback: Material(
                                            color: Colors.transparent,
                                            child: TaskTile(task: task),
                                          ),
                                          child: TaskTile(
                                            task: task,
                                            onTap: () {
                                              AppDialog.dialog(
                                                context,
                                                TaskDetailDialog(
                                                  task: task,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                );
              },
            );
          },
        );
      },
    );
  }
}
