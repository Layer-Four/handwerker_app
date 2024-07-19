import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/provider/settings_provider/settings_provider.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';

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
                Text(ref.watch(settingsProv).dictionary.logUserOut),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SymmetricButton(
                    color: AppColor.kPrimaryButtonColor,
                    text: ref.watch(settingsProv).dictionary.logout,
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
              Text(ref.watch(settingsProv).dictionary.changePassword),
              SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: ref.watch(settingsProv).dictionary.changePassword,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                settings.themeMode == ThemeMode.light
                    ? settings.dictionary.lightTheme
                    : settings.themeMode == ThemeMode.system
                        ? settings.dictionary.themeModeSystem
                        : settings.dictionary.darkMode,
              ),
              IconButton(
                onPressed: (() => ref.read(settingsProv.notifier).changeThememode(
                      settings.themeMode == ThemeMode.system
                          ? ThemeMode.light
                          : settings.themeMode == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.system,
                    )),
                icon: settings.themeMode == ThemeMode.system
                    ? const Icon(Icons.sailing)
                    : settings.themeMode == ThemeMode.light
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ref.watch(settingsProv).dictionary.changeLanguage),
              DropdownButton(
                  underline: const SizedBox.shrink(),
                  value: ref.watch(settingsProv).dictionary,
                  items: [
                    DropdownMenuItem(
                      value: const GermanLanguage(),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(ref.watch(settingsProv).dictionary.german),
                      ),
                    ),
                    DropdownMenuItem(
                      value: const EnglishLanguage(),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(ref.watch(settingsProv).dictionary.english),
                      ),
                    ),
                  ],
                  onChanged: (e) => ref.read(settingsProv.notifier).changeLanguage(e))
            ],
          ),
        ],
      ),
    );
  }
}
