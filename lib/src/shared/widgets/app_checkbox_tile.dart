import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AppCheckboxTile extends HookWidget {
  final String label;
  final bool isChecked;
  final VoidCallback onToggle;

  const AppCheckboxTile({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        tileColor: theme.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        onTap: onToggle,
        hoverColor: theme.primary.withOpacity(.25),
        minTileHeight: 40,
        leading: Checkbox(
          value: isChecked,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(color: theme.inversePrimary),
          ),
          side: BorderSide(color: theme.inversePrimary),
          fillColor: WidgetStatePropertyAll(theme.tertiary),
          onChanged: (_) => onToggle(),
          activeColor: theme.primary,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        title: AppText(
          label,
          fontSize: 14,
          color: isChecked ? theme.onSurface : theme.onSurface,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
