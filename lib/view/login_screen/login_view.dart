import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/login_screen/forget_screen.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';
import 'package:handwerker_app/view/widgets/logo.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/text_field.dart';

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
    GlobalKey<FormState> formstate = GlobalKey();

    bool isOTP = true;
    return Scaffold(
      body: BackgroundWidget(
          body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LogoApp(),
                  const SizedBox(
                    height: 9,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Anmelden",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColor.kWhilteWOpacity),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nutzername",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppColor.kWhilteWOpacity,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        UserAndPasswordField(
                          controller: emailCon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Additional validation logic if needed
                            return null; // Return null if the value is valid
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Passwort",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColor.kWhilteWOpacity,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        UserAndPasswordField(
                          controller: passCon,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: Text(
                                "Passwort vergessen?",
                                style: TextStyle(
                                    color: AppColor.kWhite,
                                    fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.forgotPassword);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 235,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formstate.currentState!.validate()) {
                                  print("valid");
                                } else {
                                  print("Not Valid");
                                }
                                if (isOTP) {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.setPasswordScreen);
                                } else {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppRoutes.viewScreen);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: AppColor.kPrimaryButtonColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "Anmelden",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          imageName: 'img_anmelden.png'),
    );
    // Opacity(
    //   opacity: 0.8,
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Container(
    //           height: screenHeight,
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage("assets/images/img_anmelden.png"),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           child:
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
  }
}
