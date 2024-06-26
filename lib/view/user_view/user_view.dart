import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';

class UserView extends ConsumerWidget {
  const UserView({super.key});
  @override
  Widget build(BuildContext context, ref) {
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
                const Text('Nutze abmelden'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SymmetricButton(
                    color: AppColor.kPrimaryButtonColor,
                    text: 'Logout',
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
              const Text('Password ändern'),
              SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: 'Password ändern',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
