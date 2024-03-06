// import 'package:flutter/material.dart';
// import 'package:handwerker_app/constants/apptheme/app_colors.dart';
// import 'package:handwerker_app/routes/app_routes.dart';
// import 'package:handwerker_app/view/widgets/background_widget.dart';
// import 'package:handwerker_app/view/widgets/logo.dart';
// import 'package:handwerker_app/view/widgets/textfield_widgets/text_field.dart';

// class PasswordView extends StatefulWidget {
//   const PasswordView({super.key});

//   @override
//   State<PasswordView> createState() => _PasswordViewState();
// }

// class _PasswordViewState extends State<PasswordView> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailCon = TextEditingController();
//     TextEditingController passCon = TextEditingController();
//     GlobalKey<FormState> formstate = GlobalKey();

//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//         child: BackgroundWidget(
//             body: Padding(
//               padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const LogoApp(),
//                     const SizedBox(
//                       height: 9,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Passwort zurücksetzen",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineSmall
//                             ?.copyWith(color: AppColor.kWhilteWOpacity),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Form(
//                       key: formstate,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Altes Passwort",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                     color: AppColor.kWhilteWOpacity,
//                                     fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 3,
//                           ),
//                           UserAndPasswordField(
//                             controller: emailCon,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               // Additional validation logic if needed
//                               return null; // Return null if the value is valid
//                             },
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             "Passwort",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge
//                                 ?.copyWith(
//                                     color: AppColor.kWhilteWOpacity,
//                                     fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 3,
//                           ),
//                           UserAndPasswordField(
//                             controller: passCon,
//                             isPass: true,
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           UserAndPasswordField(
//                             controller: passCon,
//                             isPass: true,
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
// Center(
//   child: SizedBox(
//     width: 235,
//     height: 35,
//     child: ElevatedButton(
//       onPressed: () {
//         if (formstate.currentState!.validate()) {
//           print("valid");
//         } else {
//           print("Not Valid");
//         }
//         Navigator.of(context).pushReplacementNamed(
//             AppRoutes.viewScreen);
//       },
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         backgroundColor: AppColor.kPrimaryButtonColor,
//       ),
//       child: const Center(
//         child: Text(
//           "Senden",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     ),
//   ),
// ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             imageName: 'img_anmelden.png'),
//       ),
//     );
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
//   }
// }

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/login_screen/shared/constants.dart';
import 'package:handwerker_app/view/login_screen/shared/snackbar.dart';
import 'package:handwerker_app/view/widgets/logo.dart';

class PasswordView extends StatefulWidget {
  PasswordView({Key? key}) : super(key: key);

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool isVisable = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0, left: 33, right: 33),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  LogoApp(),
                  // const SizedBox(
                  //   height: 9,
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Passwort zurücksetzen",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColor.kBlack),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Altes Passwort",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColor.kBlack, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith()),
                  const SizedBox(
                    height: 20,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Neues Passwort",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColor.kBlack, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),

                  TextFormField(
                      validator: (email) {
                        return email!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith()),
                  const SizedBox(
                    height: 33,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Passwort widerholen",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColor.kBlack, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    onChanged: (password) {
                      onPasswordChanged(password);
                    },
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: decorationTextfield.copyWith(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: isVisable
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isPassword8Char
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)),
                                ),
                              ),
                              SizedBox(width: 11),
                              Text("mindestens 8 Zeichen"),
                            ],
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isPasswordHas1Number
                                          ? Colors.green
                                          : Colors.white,
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 189, 189, 189)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Text("mindenstens 1 Nummer"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hasUppercase
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)),
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Text("Großbuchstabe"),
                            ],
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hasLowercase
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)),
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Text("Kleinbuchstabe "),
                            ],
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hasSpecialCharacters
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189)),
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Text("Sonderzeichen "),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Center(
                    child: SizedBox(
                      width: 235,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await register();
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()),
                            );
                          } else {
                            showSnackBar(context, "ERROR");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColor.kPrimaryButtonColor,
                        ),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Speichern",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       await register();
                  //       if (!mounted) return;
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => LoginView()),
                  //       );
                  //     } else {
                  //       showSnackBar(context, "ERROR");
                  //     }
                  //   },
                  //   child: isLoading
                  //       ? CircularProgressIndicator(
                  //           color: Colors.white,
                  //         )
                  //       : Text(
                  //           "Register",
                  //           style: TextStyle(fontSize: 19),
                  //         ),
                  //   style: ButtonStyle(
                  //     // backgroundColor: Color.fromARGB(12, 100, 50, 1),
                  //     padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8))),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 33,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("Do not have an account?",
                  //         style: TextStyle(fontSize: 18)),
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.pushReplacement(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => LoginView()),
                  //           );
                  //         },
                  //         child: Text('sign in',
                  //             style: TextStyle(
                  //                 fontSize: 18,
                  //                 decoration: TextDecoration.underline))),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
