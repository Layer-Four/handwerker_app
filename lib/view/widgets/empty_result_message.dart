import 'package:flutter/material.dart';

class ShowEmptyMessage extends StatelessWidget {
  final String message;
  const ShowEmptyMessage({
    this.message = 'Keine Einträge gefunden',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      child: Center(
        child: Text(message),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
