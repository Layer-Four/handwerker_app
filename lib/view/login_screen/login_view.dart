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
  bool isFocused = false;
  bool _isPasswordVisible = false;
  bool _isLoaded = false;

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(
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
                                child: Text('Nutzername',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            CustomTextField(
                              controller: _emailCon,
                              inputAction: TextInputAction.next,
                              onFieldSubmitted: (_) => _submitLogin(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Bitte eine gültige Mandatenname eingeben';
                                } else if (value.isNotEmpty && value.length < 3) {
                                  return 'Bitte eine gültige Mandatenname eingeben';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              width: 350,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('Passwort',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                            ),
                            CustomTextField(
                              controller: _passCon,
                              isPassword: true,
                              inputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submitLogin(),
                              obscureText: !_isPasswordVisible,
                              togglePasswordVisibility: () {
                                setState(() => _isPasswordVisible = !_isPasswordVisible);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Bitte mehr als 6 Buchstaben eingeben';
                                } else if (value.length < 7) {
                                  return 'Bitte mehr als 6 Buchstaben eingeben';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
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
        ],
      ),
    );
  }

  void reactionOfLogin(bool isSuccess) {
    setState(() => _isLoaded = false);
    if (isSuccess) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
      return;
    }
    _passCon.clear();
    // ignore: void_checks
    return showSnackBar(
      context,
      'leider hat es nicht geklappt.\nKontrolliere deine Zugangsdaten und versuche es erneut',
    );
  }

  Future<void> _submitLogin() async {
    if (_emailCon.text.isEmpty || _passCon.text.isEmpty) {
      showSnackBar(context, 'Bitte alle Textfelder ausfüllen.');
      return;
    }

    if (_formstate.currentState!.validate()) {
      setState(() => _isLoaded = true);
      bool isSuccess = await ref.read(userProvider.notifier).loginUser(
            password: _passCon.text,
            userName: _emailCon.text,
          );
      reactionOfLogin(isSuccess);
    }
  }

  Widget _buildForgotPassword() => SizedBox(
        width: 350,
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Text(
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
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: 340,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => _submitLogin(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColor.kPrimaryButtonColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Anmelden',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ),
      );
}
