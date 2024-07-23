import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/settings_provider.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';

import '../../models/settings_state_model/setttings_state.dart';

class UserView extends ConsumerWidget {
  const UserView({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProv);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(settings.dictionary.logUserOut),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SymmetricButton(
                    color: AppColor.kPrimaryButtonColor,
                    text: settings.dictionary.logout,
                    onPressed: () {
                      ref.read(userProvider.notifier).userLogOut();
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(settings.dictionary.changePassword),
              SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: settings.dictionary.changePassword,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_choicenThemeMode(settings)),
              IconButton(
                onPressed: (() => ref.read(settingsProv.notifier).changeThememode()),
                icon: _chooseCorrectIcon(settings.themeMode),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(settings.dictionary.changeLanguage),
              DropdownButton(
                underline: const SizedBox.shrink(),
                value: ref.watch(settingsProv).dictionary,
                items: settings.allLanguages
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(settings.dictionary.ownLanguage),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (e) => ref.read(settingsProv.notifier).changeLanguage(e),
              )
            ],
          ),
        ],
      ),
    );
  }

  Icon _chooseCorrectIcon(ThemeMode c) => c == ThemeMode.system
      ? const Icon(Icons.sailing)
      : c == ThemeMode.light
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.dark_mode);

  String _choicenThemeMode(SettingsState settings) => settings.themeMode == ThemeMode.light
      ? settings.dictionary.lightTheme
      : settings.themeMode == ThemeMode.system
          ? settings.dictionary.themeModeSystem
          : settings.dictionary.darkMode;
}
