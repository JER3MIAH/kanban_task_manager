import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/navigation/app_navigator.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class DeleteBoardDialog extends HookWidget {
  final Board board;
  const DeleteBoardDialog({
    super.key,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 480,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Delete this board?',
              fontSize: 18,
              color: theme.error,
            ),
            YBox(25),
            AppText(
              'Are you sure you want to delete the ‘${board.name}’ board? This action will remove all columns and tasks and cannot be reversed.',
              color: theme.inversePrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            YBox(25),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Delete',
                    textColor: appColors.white,
                    color: theme.error,
                    hoverColor: theme.errorContainer,
                    onTap: () {
                      context
                          .read<BoardBloc>()
                          .add(DeleteBoardEvent(id: board.id));
                      AppNavigator(context).popDialog();
                    },
                  ),
                ),
                XBox(20),
                Expanded(
                  child: AppButton(
                    title: 'Cancel',
                    textColor: theme.primary,
                    color: theme.secondary,
                    hoverColor: theme.secondaryContainer,
                    onTap: () {
                      AppNavigator(context).popDialog();
                    },
                  ),
                ),
              ],
            ),
            YBox(15),
          ],
        ),
      ),
    );
  }
}
