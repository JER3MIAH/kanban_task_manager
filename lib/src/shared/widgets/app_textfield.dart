import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool multiLine;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.multiLine = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final tStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: theme.onSurface,
    );
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: theme.inversePrimary.withOpacity(.25)),
      borderRadius: BorderRadius.circular(4),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          labelText,
          fontSize: 12,
          color: theme.inversePrimary,
        ),
        YBox(7),
        TextFormField(
          controller: controller,
          cursorColor: theme.primary,
          style: tStyle,
          keyboardType:
              multiLine ? TextInputType.multiline : TextInputType.text,
          maxLines: 8,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: tStyle.copyWith(
              color: theme.onSurface.withOpacity(.25),
            ),
            constraints: BoxConstraints(
              minHeight: multiLine ? 112 : 40,
              maxHeight: multiLine ? 112 : 40,
            ),
            focusedBorder: border,
            enabledBorder: border,
            disabledBorder: border,
            errorBorder: border.copyWith(
              borderSide: BorderSide(color: theme.error),
            ),
          ),
        ),
      ],
    );
  }
}
