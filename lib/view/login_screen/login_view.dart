// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/apptheme/app_colors.dart';
// import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
// import 'package:handwerker_app/routes/app_routes.dart';
// import 'package:handwerker_app/view/login_screen/shared/custom_textfield.dart';
// import 'package:handwerker_app/view/login_screen/shared/snackbar.dart';
// import 'package:handwerker_app/view/widgets/background_widget.dart';

// class LoginView extends ConsumerStatefulWidget {
//   const LoginView({super.key});

//   @override
//   ConsumerState<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends ConsumerState<LoginView> {
//   bool isUsernameFocused = false;
//   bool isPasswordFocused = false;
//   bool isOTP = false;
//   bool _isPasswordVisible = false;
//   bool _isLoaded = false;

//   final TextEditingController _emailCon = TextEditingController();
//   final TextEditingController _passCon = TextEditingController();
//   final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

//   String? validateEmail(String? input) {
//     const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

//     if (input == null || input.isEmpty) {
//       // return showSnackBar(context, 'Email bitte eingeben');
//       return "Email bitte eingeben";
//     } else if (RegExp(emailRegex).hasMatch(input)) {
//       return null;
//     } else {
//       return "Ungültige Nutzernamen Format";
//       // return showSnackBar(context, 'Ungültige Nutzernamen Format');
//     }
//   }

//   String? validatePassword(String? input) {
//     if (input == null || input.isEmpty) {
//       // return showSnackBar(context, 'Passwort bitte eingeben');
//       return 'Psswort bitte eingeben';
//     } else if (input.length >= 6) {
//       return null;
//     } else {
//       return "Mehr als 6 Zeichen bitte eingeben";
//       // return showSnackBar(context, 'Mehr als 6 Zeichen bitte eingeben');
//     }
//   }

//   @override
//   void dispose() {
//     _emailCon.dispose();
//     _passCon.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         child: BackgroundWidget(
//           imageName: 'img_anmelden.png',
//           body: Padding(
//             padding: const EdgeInsets.only(top: 60),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 46,
//                       child: Image.asset('assets/images/img_techtool.png'),
//                     ),
//                     const SizedBox(height: 75),
//                     Form(
//                       key: _formstate,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             width: 350,
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 'Nutzername',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           CustomTextField(
//                             controller: _emailCon,
//                             inputAction: TextInputAction.next,
//                             onFieldSubmitted: (_) => _submitLogin(),
//                             validator: validateEmail,
//                           ),
//                           const SizedBox(height: 20),
//                           // _buildUsernameTextField(),

//                           const SizedBox(
//                             width: 350,
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 'Passwort',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           CustomTextField(
//                             controller: _passCon,
//                             isPassword: true,
//                             inputAction: TextInputAction.done,
//                             onFieldSubmitted: (_) => _submitLogin(),
//                             validator: validatePassword,
//                             // obscureText: !_isPasswordVisible,
//                             // togglePasswordVisibility: () {
//                             //   setState(() => _isPasswordVisible = !_isPasswordVisible);
//                             // },
//                           ),
//                           const SizedBox(height: 10),
//                           // _buildPasswordTextField(),
//                           // _buildForgotPassword(),
//                           const SizedBox(height: 20),
//                           _buildLoginButton(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void reactionOfLogin(bool isSuccess) {
//     setState(() => _isLoaded = false);
//     if (isSuccess) {
//       Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
//       return;
//     }
//     _passCon.clear();
//     // ignore: void_checks
//     // return showSnackBar(
//     //   context,
//     //   'Leider hat es nicht geklappt.\nKontrolliere deine Zugangsdaten und versuche es erneut.',
//     // );
//   }

//   Future<void> _submitLogin() async {
//     if (_formstate.currentState!.validate()) {
//       final String email = _emailCon.text;
//       final String password = _passCon.text;

//       setState(() {
//         _isLoaded = true;
//       });

//       try {
//         bool isSuccess = await ref.read(userProvider.notifier).loginUser(
//               password: password,
//               userName: email,
//             );

//         reactionOfLogin(isSuccess);
//       } catch (e) {
//         setState(() {
//           _isLoaded = false;
//         });
//         showSnackBar(context, 'Leider hat es nicht geklappt : ${e.toString()}');
//       }
//     } else {
//       showSnackBar(context, 'Ungültige Nutzernamme oder Passwort Eingabe');
//     }
//   }

//   // Widget _buildUsernameTextField() =>
//   // Container(
//   //       margin: const EdgeInsets.only(top: 3, bottom: 20),
//   //       width: 355,
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(8),
//   //         color: const Color.fromARGB(255, 231, 226, 226),
//   //       ),
//   //       child: Focus(
//   //         onFocusChange: (hasFocus) {
//   //           setState(() => isUsernameFocused = hasFocus);
//   //         },
//   //         child: AnimatedContainer(
//   //           duration: const Duration(milliseconds: 300),
//   //           height: isUsernameFocused ? 44 : 40,
//   //           width: 355,
//   //           child: TextFormField(
//   //             autovalidateMode: AutovalidateMode.onUserInteraction,
//   //             autofocus: true,
//   //             keyboardType: TextInputType.emailAddress,
//   //             textInputAction: TextInputAction.next,
//   //             validator: validateEmail,
//   //             onFieldSubmitted: (_) => _submitLogin(),
//   //             controller: _emailCon,
//   //             decoration: InputDecoration(
//   //               filled: true,
//   //               fillColor: Colors.transparent,
//   //               contentPadding: const EdgeInsets.all(10),
//   //               focusedBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: AppColor.kPrimaryButtonColor,
//   //                   width: 2,
//   //                 ),
//   //               ),
//   //               errorStyle: const TextStyle(fontSize: 0.01),
//   //               enabledBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: AppColor.kPrimaryButtonColor,
//   //                   width: 2,
//   //                   style: BorderStyle.solid,
//   //                 ),
//   //               ),
//   //               errorBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: Colors.red,
//   //                   width: 2,
//   //                   style: BorderStyle.solid,
//   //                 ),
//   //               ),
//   //               focusedErrorBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: Colors.red,
//   //                   width: 2,
//   //                   style: BorderStyle.solid,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     );
//   // Widget _buildPasswordTextField() => Container(
//   //       margin: const EdgeInsets.only(top: 3, bottom: 5),
//   //       width: 350,
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(8),
//   //         color: AppColor.kTextfieldBorder,
//   //       ),
//   //       child: Focus(
//   //         onFocusChange: (hasFocus) => setState(() => isPasswordFocused = hasFocus),
//   //         child: AnimatedContainer(
//   //           duration: const Duration(milliseconds: 300),
//   //           height: isPasswordFocused ? 44 : 40,
//   //           // height: 40,
//   //           child: TextFormField(
//   //             autovalidateMode: AutovalidateMode.onUserInteraction,
//   //             textInputAction: TextInputAction.done,
//   //             validator: validatePassword,
//   //             onFieldSubmitted: (_) => _submitLogin(),
//   //             obscureText: !_isPasswordVisible,
//   //             controller: _passCon,
//   //             decoration: InputDecoration(
//   //               filled: true,
//   //               fillColor: Colors.transparent,
//   //               suffixIcon: IconButton(
//   //                 onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
//   //                 icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
//   //                 color: Theme.of(context).iconTheme.color,
//   //               ),
//   //               contentPadding: const EdgeInsets.all(10),
//   //               focusedBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: AppColor.kPrimaryButtonColor,
//   //                   width: 2,
//   //                 ),
//   //               ),
//   //               enabledBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: Colors.transparent,
//   //                   width: 0,
//   //                 ),
//   //               ),
//   //               errorStyle: const TextStyle(fontSize: 0.01),
//   //               errorBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: Colors.red,
//   //                   width: 1,
//   //                   style: BorderStyle.solid,
//   //                 ),
//   //               ),
//   //               focusedErrorBorder: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(8),
//   //                 borderSide: const BorderSide(
//   //                   color: Colors.red,
//   //                   width: 1,
//   //                   style: BorderStyle.solid,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     );

//   Widget _buildForgotPassword() => SizedBox(
//         width: 350,
//         child: Align(
//           alignment: Alignment.topRight,
//           child: GestureDetector(
//             child: const Text(
//               'Passwort vergessen?',
//               style: TextStyle(
//                 color: AppColor.kWhite,
//                 fontWeight: FontWeight.w700,
//                 decorationColor: AppColor.kPrimaryButtonColor,
//                 decorationThickness: 2.0,
//               ),
//             ),
//             onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.forgotPassword),
//           ),
//         ),
//       );

//   Widget _buildLoginButton() => Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: _isLoaded
//               ? const SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(AppColor.kPrimaryButtonColor),
//                   ),
//                 )
//               : SizedBox(
//                   width: 340,
//                   height: 44,
//                   child: ElevatedButton(
//                     onPressed: () => _submitLogin(),
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       backgroundColor: AppColor.kPrimaryButtonColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Anmelden',
//                         style: TextStyle(color: AppColor.kWhite),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       );
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/login_screen/shared/custom_textfield.dart';
import 'package:handwerker_app/view/login_screen/shared/snackbar.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool isUsernameFocused = false;
  bool isPasswordFocused = false;
  bool _isLoaded = false;

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  String? validateEmail(String? input) {
    const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (input == null || input.isEmpty) {
      return "Email bitte eingeben";
    } else if (RegExp(emailRegex).hasMatch(input)) {
      return null;
    } else {
      return "Ungültige Nutzernamen Format";
    }
  }

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return 'Passwort bitte eingeben';
    } else if (input.length >= 6) {
      return null;
    } else {
      return "Mehr als 6 Zeichen bitte eingeben";
    }
  }

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BackgroundWidget(
          imageName: 'img_anmelden.png',
          body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 46,
                      child: Image.asset('assets/images/img_techtool.png'),
                    ),
                    const SizedBox(height: 75),
                    Form(
                      key: _formstate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 350,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Nutzername',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _emailCon,
                            inputAction: TextInputAction.next,
                            validator: validateEmail,
                            onFieldSubmitted: (_) => _submitLogin(),
                            onFocusChange: (hasFocus) {
                              setState(() => isUsernameFocused = hasFocus);
                            },
                            autofillHints: const [AutofillHints.email],
                          ),
                          const SizedBox(
                            width: 350,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Passwort',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passCon,
                            isPassword: true,
                            inputAction: TextInputAction.done,
                            validator: validatePassword,
                            onFieldSubmitted: (_) => _submitLogin(),
                            onFocusChange: (hasFocus) {
                              setState(() => isPasswordFocused = hasFocus);
                            },
                            autofillHints: const [AutofillHints.password],
                          ),
                          _buildForgotPassword(),
                          const SizedBox(height: 20),
                          _buildLoginButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void reactionOfLogin(bool isSuccess) {
    setState(() => _isLoaded = false);
    if (isSuccess) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
    } else {
      showSnackBar(
          context, 'Anmeldung fehlgeschlagen. Bitte überprüfen Sie Ihre Zugangsdaten und versuchen Sie es erneut.');
      _passCon.clear();
    }
  }

  Future<void> _submitLogin() async {
    if (_formstate.currentState!.validate()) {
      final String email = _emailCon.text;
      final String password = _passCon.text;

      setState(() {
        _isLoaded = true;
      });

      try {
        bool isSuccess = await ref.read(userProvider.notifier).loginUser(
              password: password,
              userName: email,
            );

        reactionOfLogin(isSuccess);
      } catch (e) {
        setState(() {
          _isLoaded = false;
        });
        showSnackBar(context, 'Leider hat es nicht geklappt: ${e.toString()}');
      }
    } else {
      showSnackBar(context, 'Ungültige Nutzernamme oder Passwort Eingabe');
    }
  }

  Widget _buildForgotPassword() => SizedBox(
        width: 350,
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: const Text(
              'Passwort vergessen?',
              style: TextStyle(
                color: AppColor.kWhite,
                fontWeight: FontWeight.w700,
                decorationColor: AppColor.kPrimaryButtonColor,
                decorationThickness: 2.0,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.forgotPassword),
          ),
        ),
      );

  Widget _buildLoginButton() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: _isLoaded
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.kPrimaryButtonColor),
                  ),
                )
              : SizedBox(
                  width: 340,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _submitLogin,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColor.kPrimaryButtonColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Anmelden',
                        style: TextStyle(color: AppColor.kWhite),
                      ),
                    ),
                  ),
                ),
        ),
      );
}
