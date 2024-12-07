import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double fontSize;
  final double bHeight;
  final bool expanded;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.fontSize = 13,
    this.bHeight = 40,
    this.expanded = false,
    this.color,
    this.hoverColor,
    this.textColor,
  });

  const AppButton.large({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.hoverColor,
    this.textColor,
  })  : expanded = false,
        fontSize = 15,
        bHeight = 48;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BounceInAnimation(
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color ?? theme.primary),
          elevation: WidgetStatePropertyAll(0),
          overlayColor: WidgetStatePropertyAll(
            hoverColor ?? theme.primaryContainer,
          ),
          minimumSize: WidgetStatePropertyAll(
            expanded ? Size(double.infinity, bHeight) : null,
          ),
          fixedSize: WidgetStatePropertyAll(Size.fromHeight(bHeight)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        child: AppText(
          title,
          fontSize: fontSize,
          color: textColor ?? theme.onPrimary,
        ),
      ),
    );
  }
}

class AddTaskButton extends HookWidget {
  final bool inactive;
  final VoidCallback? onTap;
  const AddTaskButton({
    super.key,
    this.inactive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isMobile = DeviceType(context).isMobile;
    final isTablet = DeviceType(context).isTablet;
    final buttonColor = useState<Color>(theme.primary);

    final content = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => buttonColor.value = theme.primaryContainer,
      onExit: (_) => buttonColor.value = theme.primary,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: (isMobile || isTablet) ? 48 : 164,
        height: (isMobile || isTablet) ? 32 : 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: inactive ? theme.primary.withOpacity(.3) : buttonColor.value,
          borderRadius: BorderRadius.circular(100),
        ),
        child: (isMobile || isTablet)
            ? SvgAsset(addIcon)
            : AppText(
                '+ Add New Task',
                fontSize: 15,
                color: inactive
                    ? appColors.white.withOpacity(.6)
                    : appColors.white,
              ),
      ),
    );

    if (inactive) return content;
    return BounceInAnimation(
      onTap: onTap,
      child: content,
    );
  }
}

class AddColumnButton extends HookWidget {
  final bool isBoard;
  final VoidCallback? onTap;
  const AddColumnButton({
    super.key,
    this.onTap,
    this.isBoard = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final buttonColor = useState<Color>(theme.primary);

    return BounceInAnimation(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => buttonColor.value = theme.primaryContainer,
        onExit: (_) => buttonColor.value = theme.primary,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 174,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: buttonColor.value,
            borderRadius: BorderRadius.circular(100),
          ),
          child: AppText(
            '+ Add New ${isBoard ? 'Board' : 'Column'}',
            fontSize: 15,
            color: appColors.white,
          ),
        ),
      ),
    );
  }
}
