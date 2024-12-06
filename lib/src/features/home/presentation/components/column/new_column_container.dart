import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class NewColumnContainer extends HookWidget {
  const NewColumnContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final isHovering = useState<bool>(false);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return BlocBuilder<BoardBloc, BoardState>(
          builder: (_, boardState) {
            return BounceInAnimation(
              onTap: () {
                AppDialog.dialog(
                  context,
                  AddOrEditBoardDialog(
                    board: boardState.selectedBoard,
                  ),
                );
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => isHovering.value = true,
                onExit: (_) => isHovering.value = false,
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.all(20).copyWith(top: 57),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: state.isDarkMode
                          ? [
                              Color(0xFF2B2C37).withOpacity(.25),
                              Color(0xFF2B2C37).withOpacity(.125),
                            ]
                          : [
                              Color(0xFFE9EFFA),
                              Color(0xFFE9EFFA).withOpacity(.5),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppText(
                    '+ New Column',
                    fontSize: 24,
                    color:
                        isHovering.value ? theme.primary : theme.inversePrimary,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
