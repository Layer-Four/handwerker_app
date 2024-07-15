import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/view/login_screen/shared/snackbar.dart';
import 'package:handwerker_app/view/widgets/logo.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _emailCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: AppLogo(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "bitte benachrichtige den Adminstrator",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: UserAndPasswordField(
                  hintText: 'Nutzername',
                  controller: _emailCon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Consumer(
                  builder: (context, ref, child) => ElevatedButton(
                    onPressed: () {
                      if (_emailCon.text.isNotEmpty) {
                        Navigator.of(context).pop();
                        ref.read(userProvider.notifier).resetPasswordRequest(_emailCon.text);
                        showSnackBar(
                          context,
                          'Anfrage versendet, Bitte wende dich an dein Administrator für dein neues Passwort',
                        );
                        return;
                      }
                      showSnackBar(context, 'Bitte gib einen gültigen Namen ein!');
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: AppColor.kPrimaryButtonColor,
                      padding: const EdgeInsets.all(10),
                    ),
                    child: Center(
                      child: Text(
                        "Senden".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/apptheme/app_colors.dart';
// import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
// import 'package:handwerker_app/routes/app_routes.dart';
// import 'package:handwerker_app/view/login_screen/shared/custom_textfield.dart';
// import 'package:handwerker_app/view/login_screen/shared/snackbar.dart';
// import 'package:handwerker_app/view/widgets/background_widget.dart';

// class LoginView extends ConsumerStatefulWidget {
//   const LoginView({Key? key}) : super(key: key);

//   @override
//   _LoginViewState createState() => _LoginViewState();
// }

// class _LoginViewState extends ConsumerState<LoginView> {
//   bool _isPasswordVisible = false;
//   bool _isLoaded = false;
//   String? _passwordError;
//   String? _emailError;

//   final TextEditingController _emailCon = TextEditingController();
//   final TextEditingController _passCon = TextEditingController();
//   final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _emailCon.dispose();
//     _passCon.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           BackgroundWidget(
//             imageName: 'img_anmelden.png',
//             body: Padding(
//               padding: const EdgeInsets.only(top: 60),
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 46,
//                         child: Image.asset('assets/images/img_techtool.png'),
//                       ),
//                       const SizedBox(height: 75),
//                       Form(
//                         key: _formstate,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               width: 350,
//                               child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text('Nutzername',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     )),
//                               ),
//                             ),
//                             CustomTextField(
//                               controller: _emailCon,
//                               inputAction: TextInputAction.next,
//                               // Remove onFieldSubmitted
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Bitte eine gültige Mandatenname eingeben';
//                                 } else if (value.length < 3) {
//                                   return 'Mindestens 3 Zeichen erforderlich';
//                                 }
//                                 return null;
//                               },
//                               errorText: _emailError,
//                             ),
//                             const SizedBox(height: 20),
//                             const SizedBox(
//                               width: 350,
//                               child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text('Passwort',
//                                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                               ),
//                             ),
//                             CustomTextField(
//                               controller: _passCon,
//                               isPassword: true,
//                               inputAction: TextInputAction.done,
//                               // Remove onFieldSubmitted
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Bitte eine gültige password eingeben';
//                                 } else if (value.length < 6) {
//                                   return 'Mindestens 6 Zeichen erforderlich';
//                                 }
//                                 return null;
//                               },
//                               obscureText: !_isPasswordVisible,
//                               togglePasswordVisibility: () {
//                                 setState(() => _isPasswordVisible = !_isPasswordVisible);
//                               },
//                               errorText: _passwordError,
//                             ),
//                             const SizedBox(height: 10),
//                             _buildForgotPassword(),
//                             const SizedBox(height: 20),
//                             _buildLoginButton(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
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
//     showSnackBar(
//       context,
//       'Login war leider nicht erfolgreich.\nKontrolliere deine Zugangsdaten und versuche es erneut',
//     );
//   }

//   Widget _buildForgotPassword() => SizedBox(
//         width: 350,
//         child: Align(
//           alignment: Alignment.topRight,
//           child: GestureDetector(
//             child: Text(
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
//                   child: CircularProgressIndicator(),
//                 )
//               : SizedBox(
//                   width: 340,
//                   height: 44,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       backgroundColor: AppColor.kPrimaryButtonColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Anmelden',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       );
// }
