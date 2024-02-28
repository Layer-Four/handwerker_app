import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/view_provider.dart';
import 'package:handwerker_app/view/documentation_view/doku_nav_view.dart';
import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';

class ViewNavigator extends ConsumerWidget {
  const ViewNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(viewProvider);
    final notifier = ref.read(viewProvider.notifier);

    return Scaffold(
      body: switch (index) {
        1 => const DokuNavigation(),
        _ => const DokuNavigation(),
      },
      bottomNavigationBar: AppNavigationBar(
        index: index,
        onChangedTab: (index) => notifier.state = index,
      ),
    );
  }
}
