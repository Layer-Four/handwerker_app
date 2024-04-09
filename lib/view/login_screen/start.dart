import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';
import 'package:handwerker_app/view/widgets/logo.dart';

class StartView extends ConsumerStatefulWidget {
  const StartView({super.key});

  @override
  ConsumerState<StartView> createState() => _StartViewState();
}

class _StartViewState extends ConsumerState<StartView> {
  bool _firstTime = true;
  String? _token;

  @override
  void initState() {
    super.initState();
    askForToken();
  }

  void askForToken() {
    if (_firstTime) {
      ref.read(userProvider.notifier).getUserToken().then(
            (value) => setState(() {
              _token = value;
              //TODO: DO I need this?
              _firstTime = false;
            }),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.kWhiteWOpacity,
                            fontWeight: FontWeight.bold,
                            fontSize: 27),
                      ),
                      Text(
                        "Alles, was Sie brauchen, in einer App!",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColor.kPrimaryButtonColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1, // Adjust flex value as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            log('token after press start > $_token');
                            _token == null
                                ? Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.anmeldeScreen,
                                  )
                                : Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.viewScreen,
                                  );
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
                      const SizedBox(
                        height: 40,
                      ),
                      const AppLogo(),
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
