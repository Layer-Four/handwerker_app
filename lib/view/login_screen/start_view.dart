import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';
import 'package:handwerker_app/view/widgets/logo.dart';

class StartView extends ConsumerWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) => ref.watch(userProvider));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BackgroundWidget(
          body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Revolutionieren \nSie Ihr Handwerk",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColor.kWhiteWOpacity, fontWeight: FontWeight.bold, fontSize: 27),
                      ),
                      Text(
                        "Alles, was Sie brauchen, in einer App!",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColor.kPrimaryButtonColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            log('token after press start -> ${ref.watch(userProvider).userToken}');
                            // TODO: set Await the navigate to QrScannerview
                            // final mandant = await ref.watch(userProvider.notifier).mandant;
                            // final user = await ref.watch(userProvider.notifier).username;
                            // (mandant == null && user == null)
                            // ? Navigator.pushReplacementNamed(
                            // context, AppRoutes.firstSigninScreen);

                            ref.watch(userProvider).userToken.isEmpty
                                ? Navigator.pushReplacementNamed(context, AppRoutes.anmeldeScreen)
                                : ref.read(userProvider.notifier).checkTokenFresh().then((e) {
                                    e
                                        ? Navigator.pushReplacementNamed(context, AppRoutes.viewScreen)
                                        : Navigator.pushReplacementNamed(context, AppRoutes.anmeldeScreen);
                                  });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: AppColor.kPrimaryButtonColor,
                          ),
                          child: const Center(
                            child: Text(
                              "Los gehts!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: AppLogo(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          imageName: 'img_anmelden.png',
        ),
      ),
    );
  }
}
