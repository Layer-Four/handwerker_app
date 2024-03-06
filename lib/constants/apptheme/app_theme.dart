import 'package:flutter/material.dart';

class AppTheme {
  static light() => ThemeData(
        textTheme: ThemeData().textTheme.apply(fontFamily: 'poppins'),
        brightness: Brightness.light,
      );
  static dark() => ThemeData(
        brightness: Brightness.dark,
      );
}
