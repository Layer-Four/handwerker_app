import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_theme.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';

class SettingsState {
  final Dictionary _language;
  final AppTheme _theme;
  final ThemeMode _themeMode;
  final Locale _currentLocal;
  const SettingsState(
      {Dictionary? language, AppTheme? theme, ThemeMode? currentMode, Locale? local})
      : _currentLocal = local ?? const Locale('de'),
        _language = language ?? const GermanLanguage(),
        _themeMode = currentMode ?? ThemeMode.system,
        _theme = theme ?? const AppTheme();

  Dictionary get dictionary => _language;
  AppTheme get theme => _theme;
  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
  ThemeMode get themeMode => _themeMode;
  Locale get local => _currentLocal;

  SettingsState copyWith({
    Dictionary? newLanguage,
    AppTheme? newTheme,
    ThemeMode? nextMode,
    Locale? newLocal,
  }) =>
      SettingsState(
        currentMode: nextMode ?? _themeMode,
        language: newLanguage ?? _language,
        theme: newTheme ?? _theme,
        local: newLocal ?? _currentLocal,
      );
}
