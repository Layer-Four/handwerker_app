import 'package:flutter/material.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';
import 'package:flutter/material.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
// import 'package:handwerker_app/view/execution_view/execution_view.dart';
import 'package:handwerker_app/view/login_screen/start.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';

class AppRoutes {
  static const initialRoute = '/start_view';
  static const anmeldeScreen = '/login_view';
  static const startScreen = '/start_view';
  static const viewScreen = '/view_view';

  static Map<String, WidgetBuilder> routes = {
    anmeldeScreen: (context) => LoginView(),
    viewScreen: (context) => const ViewNavigator(),
    initialRoute: (context) => const StartView(),
  };
}

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        child: Text('start login'),
        onPressed: () => Navigator.of(context).pushReplacementNamed(
          AppRoutes.anmeldeScreen,
        ),
      ),
    ));
  }
}

class LoginView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        child: Text('login'),
        onTap: () => Navigator.of(context).pushReplacementNamed(
          AppRoutes.viewScreen,
        ),
      )),
    );
  }
}
