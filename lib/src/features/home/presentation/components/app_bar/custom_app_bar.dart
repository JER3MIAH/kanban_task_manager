import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:kanban_task_manager/src/features/home/logic/cubits/cubits.dart';
import 'package:kanban_task_manager/src/features/home/presentation/components/components.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isMobile = DeviceType(context).isMobile;

    return BlocBuilder<SideBarCubit, bool>(
      builder: (_, showSidebar) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) {
            return Container(
              height: 76,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.tertiary,
                border: Border(
                  bottom: BorderSide(
                    color: theme.outline,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: isMobile
                        ? () {
                            //TODO: Show dialog
                          }
                        : null,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!showSidebar || isMobile)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SvgAsset(
                                    isMobile
                                        ? logoMobile
                                        : (themeState.isDarkMode
                                            ? logoLight
                                            : logoDark),
                                  ),
                                ),
                                Container(
                                  color: theme.outline,
                                  width: 1,
                                  height: double.infinity,
                                  margin: EdgeInsets.only(right: 15),
                                ),
                              ],
                            ),
                          AppText(
                            'Platform Launch',
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isMobile) ...[
                            XBox(10),
                            SvgAsset(arrowDown),
                          ]
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddTaskButton(
                        inactive: false,
                        onTap: () {
                          AppDialog.dialog(context, AddOrEditTaskDialog(
                            board: Board(id: 'id', name: 'name', columns: ['TODO', 'DOING']),
                          ));
                        },
                      ),
                      XBox(15),
                      PopupMenuButton(
                        position: PopupMenuPosition.under,
                        color: theme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 192,
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              onTap: () {},
                              child: AppText(
                                'Edit Board',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {},
                              child: AppText(
                                'Delete Board',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: theme.error,
                              ),
                            ),
                          ];
                        },
                        child: SvgAsset(iconverticalEllipsis),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
