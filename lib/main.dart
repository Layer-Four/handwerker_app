import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.system,
      // darkTheme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //       seedColor: Colors.orangeAccent, brightness: Brightness.dark),
      // ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //       seedColor: Colors.blue, brightness: Brightness.light),
      // ),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
