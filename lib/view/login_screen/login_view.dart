import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';
import 'package:handwerker_app/view/widgets/logo.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isOTP = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AppLogo(),
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
                          ?.copyWith(color: AppColor.kWhiteWOpacity),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formstate,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  color: AppColor.kWhiteWOpacity,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        UserAndPasswordField(
                          controller: _userNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
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
                                  color: AppColor.kWhiteWOpacity,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        UserAndPasswordField(
                          controller: _passwordController,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Switch(
                            value: isOTP,
                            onChanged: (value) {
                              setState(() {
                                isOTP = value;
                              });
                            },
                          ),
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
                            child: Consumer(builder: (context, ref, child) {
                              final user = ref.watch(userProvider);
                              return ElevatedButton(
                                onPressed: () {
                                  if (formstate.currentState!.validate()) {
                                    ref.read(userProvider.notifier).loginUser(
                                          passwort: _passwordController.text,
                                          userName: _userNameController.text,
                                        );
                                    user.when(
                                      data: (data) {
                                        if (data.userToken.isNotEmpty) {
                                          // _userNameController.clear();
                                          // _passwordController.clear();
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  AppRoutes.viewScreen);
                                        }
                                      },
                                      loading: () =>
                                          const CircularProgressIndicator(),
                                      error: (error, stackTrace) {
                                        SizedBox.expand(
                                          child: Center(
                                            child: Text(
                                                'something went wrong -> $error'),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    if (kDebugMode) {
                                      print("Not Valid");
                                    }
                                  }
                                  if (isOTP) {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.setPasswordScreen);
                                    // } else {
                                    //   Navigator.of(context).pushReplacementNamed(
                                    //       AppRoutes.viewScreen);
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
                              );
                            }),
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
