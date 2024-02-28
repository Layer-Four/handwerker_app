import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryProjectBody extends ConsumerWidget {
  const HistoryProjectBody({super.key});
  @override
  Widget build(context, ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Project overview'),
          ],
        ),
      ),
    );
  }
}
