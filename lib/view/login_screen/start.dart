import 'package:flutter/material.dart';
import 'package:handwerker_app/app_theme.dart/colors.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';
import 'package:handwerker_app/view/widgets/logo.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
          child: Column(
            children: [
              Flexible(
                flex: 1, // Adjust flex value as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Revolutionieren \nSie Ihr Handwerk",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: kWhilteWOpacity,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      "Alles, was Sie brauchen, in einer App!",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: kPrimaryColor),
                    ),
                    const SizedBox(
                      height: 15,
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
                      width: 235,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the other page when the button is clicked
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewNavigator()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            "Los gehts!",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const LogoApp(),
                  ],
                ),
              ),
            ],
          ),
        ),
        imageName: 'img_anmelden.png',
      ),
    );
  }
}
