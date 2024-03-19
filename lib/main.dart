import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/provider/doku_provider/service_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';

final themeProvider = StateProvider<bool>((ref) => true);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themeProvider);
    if (ref.watch(serviceProvider).value == null) {
      ref.read(serviceProvider.notifier).loadServices();
    }
    if (ref.watch(projectProvider).value == null) {
      ref.read(projectProvider.notifier).loadpProject();
    }

    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: AppColor.kPrimary,
        primaryTextTheme: const TextTheme().apply(
          displayColor: AppColor.kWhite,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
        Locale('ar'),
      ],
    );
  }
}
