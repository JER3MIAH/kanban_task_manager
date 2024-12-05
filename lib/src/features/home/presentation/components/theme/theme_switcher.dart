import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_task_manager/src/features/theme/logic/bloc/theme_state.dart';
import 'package:kanban_task_manager/src/shared/shared.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return Container(
          width: 251,
          height: 48,
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgAsset(iconLightTheme),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 40,
                  height: 20,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Switch(
                      value: state.isDarkMode,
                      activeColor: theme.primary,
                      inactiveTrackColor: theme.primary,
                      inactiveThumbColor: appColors.white,
                      thumbColor: WidgetStatePropertyAll(appColors.white),
                      splashRadius: 0.0,
                      trackOutlineColor:
                          WidgetStatePropertyAll(Colors.transparent),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (_) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    ),
                  ),
                ),
              ),
              SvgAsset(iconDarkTheme),
            ],
          ),
        );
      },
    );
  }
}
