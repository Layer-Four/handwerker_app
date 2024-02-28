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
        0 => const TimeTrackView(),
        1 => const DokuNavigationView(),
        2 => const HistoryView(),
        3 => const UserView(),
        _ => const DokuNavigationView(),
      },
      bottomNavigationBar: AppNavigationBar(
        index: index,
        onChangedTab: (index) => notifier.state = index,
      ),
    );
  }
}

class UserView extends StatelessWidget {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('User Information')),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Verlauf')),
    );
  }
}

class TimeTrackView extends StatelessWidget {
  const TimeTrackView({super.key});
  static const startScreen = '/start_view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Time tracker')),
    );
  }
}
