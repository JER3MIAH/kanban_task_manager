import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/data.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class TaskDetailDialog extends StatelessWidget {
  final Task task;
  const TaskDetailDialog({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskDetailCubit(task),
      child: BlocBuilder<TaskDetailCubit, Task>(
        builder: (_, task) {
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
                children: [
                  AppText(
                    task.title,
                    fontSize: 18,
                  ),
                  YBox(10),
                  AppText(
                    task.description,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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
                        onToggle: () => context
                            .read<TaskDetailCubit>()
                            .toggleSubtaskCompletion(subtask.id),
                      );
                    },
                  ),
                  YBox(10),
                  AppDropdown(
                    labelText: 'Current Status',
                    items: [
                      //TODO:
                    ],
                    initialSelectedValue: task.status,
                    onChanged: (value) =>
                        context.read<TaskDetailCubit>().changeStatus(value),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
