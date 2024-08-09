import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_theme.dart';

import '../language/dictionary.dart';

class SettingsState {
  final Dictionary _language;
  final List<Dictionary> _allLanguages;
  final AppTheme _theme;
  final ThemeMode _themeMode;
  final Locale _currentLocal;
  const SettingsState({
    Dictionary? language,
    AppTheme? theme,
    ThemeMode? currentMode,
    Locale? local,
    List<Dictionary>? allLanguages,
  })  : _allLanguages = allLanguages ?? const [GermanLanguage(), EnglishLanguage()],
        _currentLocal = local ?? const Locale('de'),
        _language = language ?? const GermanLanguage(),
        _themeMode = currentMode ?? ThemeMode.light,
        _theme = theme ?? const AppTheme();

  Dictionary get dictionary => _language;
  AppTheme get theme => _theme;
  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
  ThemeMode get themeMode => _themeMode;
  Locale get local => _currentLocal;
  List<Dictionary> get allLanguages => _allLanguages;
  int get languageAmount => _allLanguages.length;

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
