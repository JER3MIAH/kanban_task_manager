import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class GetSavedThemePrefsEvent extends ThemeEvent {
  const GetSavedThemePrefsEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();
}
