import 'package:flutter/material.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';

class AppTheme {
  const AppTheme();

  static ThemeData get lightTheme => ThemeData(
        canvasColor: AppColor.kWhite,
        cardColor: AppColor.kWhite,
        focusColor: AppColor.kPrimaryButtonColor,
        bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.kPrimary),
        useMaterial3: null,
        fontFamily: 'poppins',
        primarySwatch: AppColor.materialColorPrimary,
        scaffoldBackgroundColor: AppColor.kWhite,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColor.kWhite,
          centerTitle: true,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
      );
}
