import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class OutloggedView extends StatelessWidget {
  const OutloggedView({super.key});
  @override
  Widget build(context) => Material(
        child: SizedBox(
          child: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute),
              child: const Text('Zurück zur Anmeldeseite'),
            ),
          ),
        ),
      );
}
