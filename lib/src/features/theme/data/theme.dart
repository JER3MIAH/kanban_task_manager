import 'package:flutter/material.dart';
import 'package:kanban_task_manager/src/features/theme/data/colors.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: appColors.lightBg,
  textTheme: TextTheme().apply(fontFamily: PlusJakartaSans),
  colorScheme: ColorScheme.light(
    surface: appColors.lightBg,
    onSurface: appColors.black,
    primary: appColors.mainPurple,
    onPrimary: appColors.white,
    primaryContainer: appColors.mainPurpleHover,
    secondary: appColors.mainPurple.withOpacity(.1),
    onSecondary: appColors.mainPurple,
    secondaryContainer: appColors.mainPurple.withOpacity(.25),
    outline: appColors.linesLight,
    tertiary: appColors.white,
    error: appColors.red,
    errorContainer: appColors.redHover,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: appColors.darkBg,
  textTheme: TextTheme().apply(fontFamily: PlusJakartaSans),
  colorScheme: ColorScheme.dark(
    surface: appColors.darkBg,
    onSurface: appColors.white,
    primary: appColors.mainPurple,
    onPrimary: appColors.white,
    primaryContainer: appColors.mainPurpleHover,
    secondary: appColors.white,
    onSecondary: appColors.mainPurple,
    secondaryContainer: appColors.white,
    outline: appColors.linesDark,
    tertiary: appColors.darkGrey,
    error: appColors.red,
    errorContainer: appColors.redHover,
  ),
);
