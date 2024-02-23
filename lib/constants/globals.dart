import 'package:flutter/material.dart';

class Utilits {
  static Future<DateTime?> selecetDate(context) async {
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));
  }
}
