import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/widgets/background_widget.dart';
import 'package:handwerker_app/view/widgets/logo.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/text_field.dart';

import '../../provider/settings_provider/settings_provider.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final TextEditingController _userNameController, _passwordController;
  late final GlobalKey<FormState> formstate;

  @override
  void initState() {
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    formstate = GlobalKey();
    super.initState();
  }

  void reactionOfLogin(bool isSuccess) {
    if (isSuccess) {
      if (ref.watch(userProvider.notifier).isOneTimePassword == false) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
        return;
      }
      Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('leider hats nicht geklappt')));
    return;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 40, right: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AppLogo(),
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColor.kWhiteWOpacity, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        UserAndPasswordField(
                          controller: _userNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ref.watch(settingsProv).dictionary.plsEnterUserName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          ref.watch(settingsProv).dictionary.enterPassword,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColor.kWhiteWOpacity, fontWeight: FontWeight.bold),
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
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: Text(
                                ref.watch(settingsProv).dictionary.forgetPassword,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
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
                              onPressed: () async {
                                if (formstate.currentState!.validate()) {
                                  ref
                                      .read(userProvider.notifier)
                                      .loginUser(
                                        _passwordController.text,
                                        _userNameController.text,
                                      )
                                      .then((value) => reactionOfLogin(value));
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
  }
}
