import 'package:flutter/material.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/login_screen/start.dart';
import 'package:handwerker_app/view/navigation_view/nav_layer.dart';

class AppRoutes {
  static const initialRoute = '/start_view';
  static const anmeldeScreen = '/login_view';
  static const viewScreen = '/view_view';

  static Map<String, WidgetBuilder> routes = {
    anmeldeScreen: (context) => const LoginView(),
    viewScreen: (context) => const ViewNavigator(),
    initialRoute: (context) => const StartView(),
  };
}
