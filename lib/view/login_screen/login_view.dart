import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/models/language/dictionary.dart';
import 'package:handwerker_app/provider/settings_provider/settings_provider.dart';
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
  late final TextEditingController _emailCon, _passCon;
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  late final dictionary = ref.watch(settingsProv).dictionary;
  @override
  void initState() {
    _emailCon = TextEditingController();
    _passCon = TextEditingController();
    isUserNameSaved();
    super.initState();
  }

  void isUserNameSaved() async {
    Future.delayed(Duration(microseconds: 0)).then((_) {
      ref.watch(userProvider.notifier).username.then((e) => e != null ? _emailCon.text = e : null);
      // TODO:when save password in securestorage, than can autofil here.
    });
  }

  String? validateEmail(String? input, Dictionary dictionary) {
    // const emailRegex = r"^[\w_%+-]+@[\w-,]+\.[a-zA-Z]{2,64}$";
    const emailRegex = r"""^[\w.,!"§$%&/()=?]+@[\w-,]+\.\w{2,62}$""";

    if (input == null || input.isEmpty) {
      return dictionary.enterEmail;
    } else if (RegExp(emailRegex).hasMatch(input)) {
      return null;
    } else {
      return dictionary.invalidEmailFormat;
    }
  }

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return dictionary.enterPassword;
    } else if (input.length >= 6) {
      return null;
    } else {
      return dictionary.shortPassword;
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
                          CustomLoginTextField(
                            controller: _emailCon,
                            inputAction: TextInputAction.next,
                            // TODO: we need it later???
                            // validator: (input) => validateEmail(input, dictionary),

                            // validator: validateEmail,
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
                          CustomLoginTextField(
                            controller: _passCon,
                            isPassword: true,
                            inputAction: TextInputAction.done,
                            // validator: validatePassword,
                            validator: (input) => validatePassword(input),

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
      if (ref.watch(userProvider.notifier).isOneTimePassword) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.setPasswordScreen);
        return;
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
      return;
    } else {
      showSnackBar(
        context,
        'Anmeldung fehlgeschlagen. Bitte überprüfen Sie Ihre Zugangsdaten und versuchen Sie es erneut.',
      );
      _passCon.clear();
    }
  }

  Future<void> _submitLogin() async {
    if (_formstate.currentState!.validate()) {
      final String email = _emailCon.text;
      final String password = _passCon.text;

      setState(() => _isLoaded = true);

      try {
        bool isSuccess = await ref.read(userProvider.notifier).loginUser(
              password: password,
              userName: email,
            );

        reactionOfLogin(isSuccess);
      } catch (e) {
        setState(() => _isLoaded = false);
        // ignore: use_build_context_synchronously
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
