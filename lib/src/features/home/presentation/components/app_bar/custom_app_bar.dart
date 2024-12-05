import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isMobile = DeviceType(context).isMobile;

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
                  AppText(
                    'Platform stuff',
                    fontSize: 24,
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
          Spacer(),
          AddTaskButton(
            inactive: false,
            onTap: () {},
          ),
          XBox(15),
          PopupMenuButton(
            child: SvgAsset(iconverticalEllipsis),
            itemBuilder: (context) {
              return [];
            },
          ),
        ],
      ),
    );
  }
}
