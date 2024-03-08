import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/view/documentation_view/doku_nav_view.dart';
import 'package:handwerker_app/view/history_views/history_nav_view.dart';
import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';
import 'package:handwerker_app/view/user_view/user_view.dart';

class MainViewNavigator extends ConsumerWidget {
  const MainViewNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(viewProvider);
    final notifier = ref.read(viewProvider.notifier);

    return Scaffold(
      body: switch (provider) {
        MainViews.timeEntry => const TimeTrackView(),
        MainViews.doku => const DokuNavigationView(),
        MainViews.history => const HistoryNavigationView(),
        MainViews.user => const UserView(),
      },
      bottomNavigationBar: AppNavigationBar(
        index: provider.index,
        onChangedTab: (index) {
          notifier.state = provider.views(index);
        },
      ),
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
