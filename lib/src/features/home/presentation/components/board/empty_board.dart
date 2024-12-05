import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class EmptyBoard extends StatelessWidget {
  const EmptyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'This board is empty. Create a new column to get started.',
            fontSize: 18,
            color: theme.inversePrimary,
            textAlign: TextAlign.center,
          ),
          YBox(20),
          AddColumnButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
