import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Image.asset(
        'assets/images/img_techtool.png',
      ),
    );
  }
}
