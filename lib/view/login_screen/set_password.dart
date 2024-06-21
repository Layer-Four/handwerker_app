import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/view/login_screen/shared/constants.dart';
import 'package:handwerker_app/view/login_screen/shared/snackbar.dart';
import 'package:handwerker_app/view/widgets/logo.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool isVisable = true;
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _oldPWController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();

  bool isPassword6Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  onPasswordChanged(String password) {
    isPassword6Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{6,}'))) {
        isPassword6Char = true;
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

  waitLoad() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _oldPWController.dispose();
    _passwordController.dispose();
    _newpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 33, right: 33),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AppLogo(),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Passwort ändern",
                    style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColor.kBlack),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                TextFormField(
                  controller: _oldPWController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
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
                TextFormField(
                  onChanged: (password) {
                    setState(() {
                      _newpasswordController.text = password;
                    });
                    onPasswordChanged(password);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (value.length < 6) {
                      return "Enter at least 6 Zeichen";
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _newpasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: isVisable ? true : false,
                  decoration: decorationTextfield.copyWith(
                    contentPadding: const EdgeInsets.all(8),
                    isDense: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisable = !isVisable;
                        });
                      },
                      icon: isVisable
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColor.kRed),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColor.kRed),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                const SizedBox(
                  height: 15,
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
                    return value!.length < 6 ? "Enter at least 6 characters" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: isVisable ? true : false,
                  decoration: decorationTextfield.copyWith(
                    contentPadding: const EdgeInsets.all(8),
                    isDense: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisable = !isVisable;
                        });
                      },
                      icon: isVisable
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColor.kRed),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColor.kRed),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
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
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isPassword6Char ? Colors.green : Colors.white,
                                border: Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            const SizedBox(width: 11),
                            const Text("mindestens 6 Zeichen"),
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
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isPasswordHas1Number ? Colors.green : Colors.white,
                                    border:
                                        Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                const Text("mindenstens 1 Nummer"),
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
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hasUppercase ? Colors.green : Colors.white,
                                border: Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            const Text("Großbuchstabe"),
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hasLowercase ? Colors.green : Colors.white,
                                border: Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            const Text("Kleinbuchstabe "),
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hasSpecialCharacters ? Colors.green : Colors.white,
                                border: Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            const Text("Sonderzeichen "),
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
                    child: Consumer(
                      builder: (context, ref, child) => ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text == _newpasswordController.text) {
                              ref
                                  .read(userProvider.notifier)
                                  .setNewPassword(_oldPWController.text, _passwordController.text)
                                  .then((e) {
                                Navigator.of(context).pop();
                                showSnackBar(
                                    context,
                                    e
                                        ? 'Passwort erfolgreich geändert'
                                        : 'Leider hat es nicht geklappt');
                              });
                            } else {
                              showSnackBar(
                                context,
                                "Die Passwörter stimmen nicht überein. Bitte versuche es erneut.",
                              );
                            }
                          } else {
                            showSnackBar(
                              context,
                              " Error .",
                            );
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
                            "Speichern",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
