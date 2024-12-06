import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/blocs.dart';
import 'package:kanban_task_manager/src/features/navigation/app_navigator.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AddOrEditBoardDialog extends HookWidget {
  final Board? board;
  const AddOrEditBoardDialog({
    super.key,
    this.board,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final formKey2 = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: board?.name);

    final columnLength = useState<int>(board?.columns.length ?? 2);

    final columnControllerList = useMemoized<List<TextEditingController>>(
      () => List.generate(
        columnLength.value,
        (index) => TextEditingController(
          text: board?.columns[index] ?? '',
        ),
      ),
      [board],
    );

    void addColumn() {
      columnControllerList.add(TextEditingController());
      columnLength.value++;
    }

    void removeColumn(int index) {
      columnControllerList[index].dispose();
      columnControllerList.removeAt(index);
      columnLength.value--;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 480,
        maxHeight: 650,
      ),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ScrollConfiguration(
            behavior: NoThumbScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    '${board == null ? 'Add New' : 'Edit'} Board',
                    fontSize: 18,
                  ),
                  YBox(15),
                  AppTextField(
                    controller: nameController,
                    labelText: 'Board Name',
                    hintText: 'e.g. Web Design',
                  ),
                  YBox(15),
                  AppText(
                    'Columns',
                    fontSize: 12,
                    color: theme.inversePrimary,
                  ),
                  YBox(7),
                  Form(
                    key: formKey2,
                    child: Column(
                      children: List.generate(
                        columnControllerList.length,
                        (index) {
                          final controller = columnControllerList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: AppTextField(
                              controller: controller,
                              hintText: index.isOdd
                                  ? 'e.g. Make coffee'
                                  : 'e.g. Drink coffee & smile',
                              onTapClear: () {
                                removeColumn(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  YBox(5),
                  AppButton(
                    expanded: true,
                    title: '+ Add New Column',
                    textColor: theme.primary,
                    color: theme.secondary,
                    hoverColor: theme.secondaryContainer,
                    onTap: () {
                      if (!formKey2.currentState!.validate()) return;
                      addColumn();
                    },
                  ),
                  YBox(15),
                  AppButton(
                    expanded: true,
                    title: board == null ? 'Create New Board' : 'Save Changes',
                    onTap: () {
                      if (!formKey.currentState!.validate()) return;
                      if (board == null) {
                        context.read<BoardBloc>().add(
                              CreateNewBoardEvent(
                                name: nameController.text.trim(),
                                columns: columnControllerList
                                    .map((e) => e.text.trim())
                                    .toList(),
                              ),
                            );
                      } else {
                        context.read<BoardBloc>().add(
                              EditBoardEvent(
                                id: board!.id,
                                name: nameController.text.trim(),
                                columns: columnControllerList
                                    .map((e) => e.text.trim())
                                    .toList(),
                              ),
                            );
                      }
                      AppNavigator(context).popDialog();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
