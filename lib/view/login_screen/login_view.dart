import 'package:flutter/material.dart';
import 'package:handwerker_app/app_theme.dart/colors.dart';
import 'package:handwerker_app/view/login_screen/forget_screen.dart';
import 'package:handwerker_app/view/widgets/logo.dart';
import 'package:handwerker_app/view/widgets/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCon = TextEditingController();
    TextEditingController passCon = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: screenHeight, // Set the height to screen height
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img_anmelden.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const LogoApp(),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Anmelden",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: kWhilte),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-Mail",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    CustomField(
                      controller: emailCon,
                    ),
                    Text(
                      "Passwort",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    CustomField(
                      controller: passCon,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          child: const Text(
                            "Passwort vergessen?",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetScreen(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Center(
                        child: Text(
                          "Anmedlen",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // OutlinedButton(
                    //   style: OutlinedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12)),
                    //     padding: const EdgeInsets.all(16),
                    //     backgroundColor: kPrimaryColor,
                    //   ),
                    //   onPressed: () {
                    //     // Navigator.pushAndRemoveUntil(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //       builder: (context) => SetupProfile(),
                    //     //     ),
                    //     //     (route) => false);
                    //   },
                    //   child: Center(
                    //     child: Text(
                    //       "Neue Konto erstellen".toUpperCase(),
                    //       style: TextStyle(color: kWhilte
                    //           // color: Theme.of(context).colorScheme.onBackground,
                    //           ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
