import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: theme.tertiary,
            border: Border(
              right: BorderSide(
                color: theme.outline,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: SvgAsset(state.isDarkMode ? logoLight : logoDark),
              ),
              YBox(40),
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
              BoardTile(
                title: '+ Create New Board',
                onTap: () {},
              ),
              Spacer(),
              ThemeSwitcher(),
              YBox(10),
              BoardTile(
                title: 'Hide Sidebar',
                icon: iconHideSidebar,
              ),
              YBox(20),
            ],
          ),
        );
      },
    );
  }
}
