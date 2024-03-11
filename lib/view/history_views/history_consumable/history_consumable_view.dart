import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryMaterialBody extends ConsumerWidget {
  const HistoryMaterialBody({super.key});
  @override
  Widget build(context, ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Consumables overview'),
          ],
        ),
      ),
    );
  }
}
