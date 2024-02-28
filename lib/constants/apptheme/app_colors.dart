import 'package:flutter/material.dart';

class AppColor {
  static Color kPrimaryColor = const Color.fromARGB(255, 224, 142, 60);
  static Color kGreyColor = const Color.fromARGB(255, 98, 98, 98);
  static Color kWhite = Colors.white;
  static Color kTextfieldBorder = const Color.fromARGB(255, 220, 217, 217);
  static Color kBlue = Colors.blue;

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  static final darkTheme = ThemeData(
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
