import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/features/theme/data/colors.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: appColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              title: 'Small Button',
              onTap: () {},
            ),
            YBox(20),
            AppButton(
              title: 'Red Button',
              color: theme.error,
              hoverColor: theme.errorContainer,
              onTap: () {},
            ),
            YBox(20),
            AppButton(
              title: 'Secondary Button',
              color: theme.secondary,
              hoverColor: theme.secondaryContainer,
              textColor: theme.primary,
              onTap: () {},
            ),
            YBox(20),
            AppButton.large(
              title: 'Large Button',
              onTap: () {},
            ),
            YBox(20),
            AppCheckboxTile(
              label: 'Eat well',
              isChecked: false,
              onToggle: () {},
            ),
          ],
        ),
      ),
    );
  }
}
