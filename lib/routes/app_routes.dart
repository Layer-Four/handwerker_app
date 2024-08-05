import 'package:flutter/material.dart';
import 'package:handwerker_app/view/login_screen/forget_pasword_view.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/login_screen/set_password_view.dart';
import 'package:handwerker_app/view/login_screen/start_view.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';

import '../view/login_screen/init_login_view.dart';
import '../view/login_screen/logout_view.dart';

class AppRoutes {
  static const initialRoute = '/start_view';
  static const anmeldeScreen = '/login_view';
  static const setPasswordScreen = '/set_password_view';
  static const viewScreen = '/view_view';
  static const outloggedView = '/view_loggedOut';
  static const forgotPassword = '/forgot_password';
  static const firstSigninScreen = '/init_mandant';

  static Map<String, WidgetBuilder> routes = {
    anmeldeScreen: (context) => const LoginView(),
    forgotPassword: (context) => const ForgetPasswordView(),
    initialRoute: (context) => const StartView(),
    setPasswordScreen: (context) => const PasswordView(),
    viewScreen: (context) => const MainViewNavigator(),
    outloggedView: (context) => const OutloggedView(),
    firstSigninScreen: (context) => const ReadQRCodeView(),
  };
}
