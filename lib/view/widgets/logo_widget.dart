import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String assetString;
  final double size;
  const LogoWidget({
    super.key,
    required this.assetString,
    this.size = 20,
  });
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Image.asset(
            assetString,
            height: size,
            width: size,
          ),
        ),
      );
}
