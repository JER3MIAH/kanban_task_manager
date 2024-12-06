import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class BoardColumn extends StatelessWidget {
  final String title;
  const BoardColumn({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

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
                  '$title (4)',
                  fontSize: 12,
                  color: theme.inversePrimary,
                ),
              ],
            ),
            YBox(20),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return TaskTile(
                    task: Task(
                      id: 'id',
                      boardId: '',
                      title: 'Build UI for onboarding flow',
                      description: 'description',
                      subtasks: [],
                      status: 'status',
                    ),
                    onTap: () {
                      
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
