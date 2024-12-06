import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class EmptyBoard extends StatelessWidget {
  const EmptyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Expanded(
      child: BlocBuilder<BoardBloc, BoardState>(
        builder: (_, state) {
          final isBoard = state.selectedBoard == Board.initial();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                isBoard
                    ? 'You currently have no boards. Creaet a new board to get started'
                    : 'This board is empty. Create a new column to get started.',
                fontSize: 18,
                color: theme.inversePrimary,
                textAlign: TextAlign.center,
              ),
              YBox(20),
              AddColumnButton(
                isBoard: isBoard,
                onTap: () {
                  AppDialog.dialog(
                    context,
                    AddOrEditBoardDialog(
                      board: isBoard ? null : state.selectedBoard,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
