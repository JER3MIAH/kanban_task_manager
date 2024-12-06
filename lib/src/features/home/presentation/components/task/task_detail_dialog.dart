import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/data.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/bloc.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/navigation/app_navigator.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class TaskDetailDialog extends StatelessWidget {
  final Task task;
  const TaskDetailDialog({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (ctx) => TaskDetailCubit(task),
      child: BlocBuilder<BoardBloc, BoardState>(
        builder: (_, boardState) {
          return BlocBuilder<TaskDetailCubit, Task>(
            builder: (ctx, task) {
              final completedSubTasks =
                  task.subtasks.where((st) => st.isDone == true);

              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 480,
                  maxHeight: 523,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              task.title,
                              fontSize: 18,
                            ),
                          ),
                          XBox(15),
                          PopupMenuButton(
                            position: PopupMenuPosition.under,
                            color: theme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 192,
                            ),
                            itemBuilder: (_) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    AppNavigator(context).popDialog();
                                    AppDialog.dialog(
                                      context,
                                      AddOrEditTaskDialog(
                                        task: task,
                                        board: boardState.selectedBoard,
                                      ),
                                    );
                                  },
                                  child: AppText(
                                    'Edit Task',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    AppNavigator(context).popDialog();
                                    context
                                        .read<TaskBloc>()
                                        .add(DeleteTaskEvent(id: task.id));
                                  },
                                  child: AppText(
                                    'Delete Task',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: theme.error,
                                  ),
                                ),
                              ];
                            },
                            child: SvgAsset(iconverticalEllipsis),
                          ),
                        ],
                      ),
                      YBox(10),
                      AppText(
                        task.description,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.inversePrimary,
                      ),
                      YBox(10),
                      AppText(
                        'Subtasks (${completedSubTasks.length} of ${task.subtasks.length})',
                        fontSize: 12,
                      ),
                      YBox(10),
                      ...List.generate(
                        task.subtasks.length,
                        (index) {
                          final subtask = task.subtasks[index];
                          return AppCheckboxTile(
                            label: subtask.title,
                            isChecked: subtask.isDone,
                            onToggle: () => ctx
                                .read<TaskDetailCubit>()
                                .toggleSubtaskCompletion(subtask.id),
                          );
                        },
                      ),
                      YBox(10),
                      AppDropdown(
                        labelText: 'Current Status',
                        items: boardState.selectedBoard.columns,
                        initialSelectedValue: task.status,
                        onChanged: (value) =>
                            context.read<TaskDetailCubit>().changeStatus(value),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
