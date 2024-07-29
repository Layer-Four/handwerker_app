import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/language/dictionary.dart';
import '../../models/state_models/setttings_state.dart';

final settingsProv = NotifierProvider<SettingsNotifer, SettingsState>(() => SettingsNotifer());

class SettingsNotifer extends Notifier<SettingsState> {
  @override
  SettingsState build() => const SettingsState();

  void changeLanguage(Dictionary? e) {
    if (e == null) return;
    final newState = state.copyWith(newLanguage: e);
    state = newState;
    return;
  }

  void changeThememode() {
    ThemeMode nextMode = switch (state.themeMode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system
    };
    final newState = state.copyWith(nextMode: nextMode);
    state = newState;
    return;
  }
}
