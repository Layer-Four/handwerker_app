import 'package:flutter/material.dart';
// import 'package:handwerker_app/view/execution_view/execution_view.dart';
import 'package:handwerker_app/view/login_screen/start.dart';

class AppRoutes {
  static const initialRoute = '/execution_view';
  static const anmeldeScreen = '/login_view';
  static Map<String, WidgetBuilder> routes = {
    // anmeldeScreen: (context) => LoginView(),
    initialRoute: (context) => const StartView(),
  };
}
