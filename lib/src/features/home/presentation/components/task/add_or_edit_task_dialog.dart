import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/blocs/task_bloc/bloc.dart';
import 'package:kanban_task_manager/src/features/navigation/app_navigator.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AddOrEditTaskDialog extends HookWidget {
  final Task? task;
  final Board board;
  const AddOrEditTaskDialog({
    super.key,
    this.task,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final formKey2 = useMemoized(() => GlobalKey<FormState>());
    final titleController = useTextEditingController(text: task?.title);
    final descriptionController =
        useTextEditingController(text: task?.description);

    final subTaskLength = useState<int>(task?.subtasks.length ?? 2);
    final selectedStatus =
        useState<String>(task?.status ?? board.columns.first);

    final subTaskControllerList = useMemoized<List<TextEditingController>>(
      () => List.generate(
        subTaskLength.value,
        (index) => TextEditingController(
          text: task?.subtasks[index].title ?? '',
        ),
      ),
      [task],
    );

    void addSubTask() {
      subTaskControllerList.add(TextEditingController());
      subTaskLength.value++;
    }

    void removeSubTask(int index) {
      subTaskControllerList[index].dispose();
      subTaskControllerList.removeAt(index);
      subTaskLength.value--;
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
                    '${task == null ? 'Add' : 'Edit'} Task',
                    fontSize: 18,
                  ),
                  YBox(15),
                  AppTextField(
                    controller: titleController,
                    labelText: 'Title',
                    hintText: 'e.g. Take coffee break',
                  ),
                  YBox(15),
                  AppTextField(
                    multiLine: true,
                    controller: descriptionController,
                    labelText: 'Description',
                    hintText:
                        'e.g. It’s always good to take a break. This 15 minute break will recharge the batteries a little.',
                  ),
                  YBox(15),
                  AppText(
                    'Subtasks',
                    fontSize: 12,
                    color: theme.inversePrimary,
                  ),
                  YBox(7),
                  Form(
                    key: formKey2,
                    child: Column(
                      children: List.generate(
                        subTaskControllerList.length,
                        (index) {
                          final controller = subTaskControllerList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: AppTextField(
                              controller: controller,
                              hintText: index.isOdd
                                  ? 'e.g. Make coffee'
                                  : 'e.g. Drink coffee & smile',
                              onTapClear: () {
                                removeSubTask(index);
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
                    title: '+ Add New Subtask',
                    textColor: theme.primary,
                    color: theme.secondary,
                    hoverColor: theme.secondaryContainer,
                    onTap: () {
                      if (!formKey2.currentState!.validate()) return;
                      addSubTask();
                    },
                  ),
                  YBox(15),
                  AppDropdown(
                    labelText: 'Status',
                    items: board.columns,
                    initialSelectedValue: selectedStatus.value,
                    onChanged: (value) {
                      selectedStatus.value = value;
                    },
                  ),
                  YBox(15),
                  AppButton(
                    expanded: true,
                    title: task == null ? 'Create Task' : 'Save Changes',
                    onTap: () {
                      if (!formKey.currentState!.validate()) return;
                      if (task == null) {
                        context.read<TaskBloc>().add(
                              CreateNewTaskEvent(
                                boardId: board.id,
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                subTasks: subTaskControllerList
                                    .map((e) => e.text.trim())
                                    .toList(),
                                status: selectedStatus.value,
                              ),
                            );
                      } else {
                        context.read<TaskBloc>().add(
                              EditTaskEvent(
                                id: task!.id,
                                title: titleController.text.trim(),
                                status: selectedStatus.value,
                                description: descriptionController.text.trim(),
                                subTasks: subTaskControllerList
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
