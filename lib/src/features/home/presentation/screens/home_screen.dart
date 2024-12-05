import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/data/models/task.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                CustomAppBar(),
                // EmptyBoard(),
                TaskTile(
                  task: Task(
                    id: 'id',
                    boardId: '',
                    title: 'Build UI for onboarding flow',
                    description: 'description',
                    subtasks: [],
                    status: 'status',
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: HideSidebarContainer(),
    );
  }
}
