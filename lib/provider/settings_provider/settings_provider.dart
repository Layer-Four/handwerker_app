import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/settings_state_model/settings_state.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';

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

  void changeThememode(ThemeMode? mode) {
    if (mode == null) return;
    final newState = state.copyWith(nextMode: mode);
    state = newState;
    return;
  }
}
