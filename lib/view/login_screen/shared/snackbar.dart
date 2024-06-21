import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(days: 1),
    content: Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
    )),
    action: SnackBarAction(label: "Schließen", onPressed: () {}),
  ));
}
