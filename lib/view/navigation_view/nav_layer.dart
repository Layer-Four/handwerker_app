import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/documentation_view/doku_nav_view.dart';
import 'package:handwerker_app/view/history_views/history_nav_view.dart';
import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';
import 'package:handwerker_app/view/user_view/user_view.dart';

class MainViewNavigator extends ConsumerStatefulWidget {
  const MainViewNavigator({super.key});

  @override
  ConsumerState<MainViewNavigator> createState() => _MainViewNavigatorState();
}

class _MainViewNavigatorState extends ConsumerState<MainViewNavigator> {
  bool _firstLoad = true;
  @override
  Widget build(BuildContext context) {
    if (_firstLoad) {
      setState(() {
        _firstLoad = false;
      });
    }
    final provider = ref.watch(viewProvider);
    final notifier = ref.read(viewProvider.notifier);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: switch (provider) {
          MainViews.timeEntry => const TimeTrackView(),
          MainViews.doku => const DokuNavigationView(),
          MainViews.history => const HistoryNavigationView(),
          MainViews.user => const UserView(),
          MainViews.logOut => Focus(
              autofocus: true,
              child: const SizedBox.shrink(),
              onFocusChange: (value) async {
                if (ref.watch(userProvider).userToken.isEmpty && (!_firstLoad)) {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.outloggedView);

                  // TODO: can throw error after false login
                }
              },
            ),
        },
      ),
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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Time tracker')),
    );
  }
}
