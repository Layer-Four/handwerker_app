import 'package:flutter/material.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
// import 'package:handwerker_app/view/execution_view/execution_view.dart';
import 'package:handwerker_app/view/login_screen/start.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';

class AppRoutes {
  static const initialRoute = '/execution_view';
  static const anmeldeScreen = '/login_view';
  static const viewScreen = '/nav_view';

  static Map<String, WidgetBuilder> routes = {
    viewScreen: (context) => const ViewNavigator(),
    anmeldeScreen: (context) => const LoginView(),
    initialRoute: (context) => const StartView(),
  };
}
