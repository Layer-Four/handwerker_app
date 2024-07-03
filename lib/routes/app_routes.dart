import 'package:flutter/material.dart';
import 'package:handwerker_app/view/login_screen/forget_screen.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/login_screen/set_password.dart';
import 'package:handwerker_app/view/login_screen/start.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';

class AppRoutes {
  static const initialRoute = '/start_view';
  static const anmeldeScreen = '/login_view';
  static const setPasswordScreen = '/set_password_view';
  static const viewScreen = '/view_view';
  static const outloggedView = '/view_loggedOut';
  static const forgotPassword = '/forgot_password';

  static Map<String, WidgetBuilder> routes = {
    anmeldeScreen: (context) => const LoginView(),
    forgotPassword: (context) => const ForgetScreen(),
    initialRoute: (context) => const StartView(),
    setPasswordScreen: (context) => const PasswordView(),
    viewScreen: (context) => const MainViewNavigator(),
    outloggedView: (context) => const OutloggedView(),
  };
}

class OutloggedView extends StatelessWidget {
  const OutloggedView({super.key});
  @override
  Widget build(context) => Material(
        child: SizedBox(
          child: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute),
              child: const Text('Zurück zur Anmeldeseite'),
            ),
          ),
        ),
      );
}
