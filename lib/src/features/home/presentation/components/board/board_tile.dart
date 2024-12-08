import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class BoardTile extends HookWidget {
  final String title;
  final String? icon;
  final bool isSelected;
  final VoidCallback? onTap;
  const BoardTile({
    super.key,
    required this.title,
    this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final buttonColor = useState<Color>((Colors.transparent));
    final textColor = useState<Color>(
        (title.startsWith('+') ? theme.primary : theme.inversePrimary));
    final iconColor = useState<Color>(
        title.startsWith('+') ? theme.primary : (theme.inversePrimary));
    final borderRadius = BorderRadius.horizontal(
      right: Radius.circular(100),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: MouseRegion(
        onEnter: (_) {
          buttonColor.value = theme.secondaryContainer;
          if (!title.startsWith('+')) {
            textColor.value = theme.primary;
            iconColor.value = theme.primary;
          }
        },
        onExit: (_) {
          buttonColor.value = Colors.transparent;
          if (!title.startsWith('+')) {
            textColor.value = theme.inversePrimary;
            iconColor.value = theme.inversePrimary;
          }
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 276,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? theme.primary : buttonColor.value,
            borderRadius: borderRadius,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              XBox(20),
              SvgAsset(
                icon ?? iconBoard,
                color: isSelected ? appColors.white : iconColor.value,
              ),
              XBox(15),
              AppText(
                title,
                height: 1.5,
                fontSize: 15,
                color: isSelected ? appColors.white : textColor.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
