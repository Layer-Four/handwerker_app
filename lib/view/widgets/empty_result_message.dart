import 'package:flutter/material.dart';

class ShowEmptyMessage extends StatelessWidget {
  const ShowEmptyMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      child: const Center(
        child: Text('Keine Einträge gefunden'),
      ),
    );
  }
}
