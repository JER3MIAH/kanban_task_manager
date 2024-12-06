import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<BoardBloc, BoardState>(
        builder: (_, boardState) {
          final selectedBoard = boardState.selectedBoard;
          return Row(
            children: [
              SideBar(),
              Expanded(
                child: Column(
                  children: [
                    CustomAppBar(),
                    if (selectedBoard.columns.isEmpty)
                      EmptyBoard()
                    else
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: NoThumbScrollBehavior(),
                          child: ListView.builder(
                            itemCount: selectedBoard.columns.length + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              if (index == (selectedBoard.columns.length - 1)) {
                                return NewColumnContainer();
                              }
                              return BoardColumn(
                                title: selectedBoard.columns[index],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: HideSidebarContainer(),
    );
  }
}
