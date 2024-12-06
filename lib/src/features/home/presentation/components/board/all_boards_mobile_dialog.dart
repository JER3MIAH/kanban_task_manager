import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/navigation/app_navigator.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AllBoardsMobileDialog extends HookWidget {
  const AllBoardsMobileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, themeState) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YBox(15),
              Row(
                children: [
                  XBox(20),
                  AppText(
                    'ALL BOARDS (3)',
                    fontSize: 12,
                    color: theme.inversePrimary,
                  ),
                ],
              ),
              YBox(10),
              BoardTile(
                title: 'Platform Launch',
                onTap: () {},
              ),
              BoardTile(
                title: 'Marketing plan',
                onTap: () {},
              ),
              BoardTile(
                title: 'Roadmap',
                onTap: () {},
              ),
              //TODO: Display actual list of boards
              BoardTile(
                title: '+ Create New Board',
                onTap: () {
                  AppNavigator(context).popDialog();
                  AppDialog.dialog(
                    context,
                    AddOrEditBoardDialog(),
                  );
                },
              ),
              YBox(20),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ThemeSwitcher(),
              ),
              YBox(20),
            ],
          ),
        );
      },
    );
  }
}
