import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isMobile = DeviceType(context).isMobile;

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (_, boardState) {
        return BlocBuilder<SideBarCubit, bool>(
          builder: (_, showSideBar) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: showSideBar && !isMobile ? 300 : 0,
                  decoration: BoxDecoration(
                    color: theme.tertiary,
                    border: Border(
                      right: BorderSide(
                        color: theme.outline,
                      ),
                    ),
                  ),
                  child: !showSideBar && isMobile
                      ? const SizedBox.shrink()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: SvgAsset(
                                  themeState.isDarkMode ? logoLight : logoDark,
                                ),
                              ),
                              YBox(40),
                              Row(
                                children: [
                                  XBox(20),
                                  AppText(
                                    'ALL BOARDS (${boardState.boards.length})',
                                    fontSize: 12,
                                    color: theme.inversePrimary,
                                  ),
                                ],
                              ),
                              YBox(10),
                              ...List.generate(
                                boardState.boards.length,
                                (index) {
                                  final board = boardState.boards[index];
                                  return BoardTile(
                                    title: board.name,
                                    isSelected:
                                        board.id == boardState.selectedBoard.id,
                                    onTap: () {
                                      context
                                          .read<BoardBloc>()
                                          .add(SelectBoardEvent(board: board));
                                    },
                                  );
                                },
                              ),
                              BoardTile(
                                title: '+ Create New Board',
                                onTap: () {
                                  AppDialog.dialog(
                                    context,
                                    AddOrEditBoardDialog(),
                                  );
                                },
                              ),
                              Spacer(),
                              ThemeSwitcher(),
                              YBox(10),
                              BoardTile(
                                title: 'Hide Sidebar',
                                icon: iconHideSidebar,
                                onTap: () {
                                  context.read<SideBarCubit>().hideSideBar();
                                },
                              ),
                              YBox(20),
                            ],
                          ),
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class HideSidebarContainer extends HookWidget {
  const HideSidebarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final borderRadius = BorderRadius.horizontal(
      right: Radius.circular(100),
    );

    final buttonColor = useState<Color>(theme.primary);

    return BlocBuilder<SideBarCubit, bool>(
      builder: (_, showSidebar) {
        if (showSidebar || DeviceType(context).isMobile) {
          return SizedBox.shrink();
        }
        return Transform.translate(
          offset: const Offset(-16, 0),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              context.read<SideBarCubit>().showSideBar();
            },
            child: MouseRegion(
              onEnter: (_) => buttonColor.value = theme.primaryContainer,
              onExit: (_) => buttonColor.value = theme.primary,
              child: Container(
                width: 56,
                height: 48,
                decoration: BoxDecoration(
                  color: buttonColor.value,
                  borderRadius: borderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgAsset(
                    iconShowSidebar,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
