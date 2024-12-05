import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/data/models/task.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class TaskTile extends HookWidget {
  final Task task;
  final VoidCallback? onTap;
  const TaskTile({
    super.key,
    required this.task,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final hovering = useState<bool>(false);

    final completedSubTasks = task.subtasks.where((st) => st.isDone == true);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => hovering.value = true,
        onExit: (_) => hovering.value = false,
        child: Container(
          width: 280,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: theme.tertiary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: 0,
                color: Color(0xFF364E7E).withOpacity(.1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                task.title,
                fontSize: 15,
                color: hovering.value ? theme.primary : null,
              ),
              YBox(10),
              AppText(
                '${completedSubTasks.length} of ${task.subtasks.length} substasks',
                fontSize: 12,
                color: theme.inversePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
