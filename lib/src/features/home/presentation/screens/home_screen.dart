import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final controller = useTextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
              YBox(20),
              AppTextField(
                controller: controller,
                labelText: 'TextField',
                hintText: 'Example textfield',
              ),
              YBox(20),
              AppDropdown(
                labelText: 'Dropdown',
                initialSelectedValue: 'First',
                items: ['First', 'Second', 'Third'],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
