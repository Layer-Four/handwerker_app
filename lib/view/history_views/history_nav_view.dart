import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/view/history_views/history_consumable/history_consumable_view.dart';
import 'package:handwerker_app/view/history_views/history_project/project_overview.dart';
import 'package:handwerker_app/view/history_views/history_time_entry/history_time_entry.dart';
import 'package:handwerker_app/view/widgets/navigaton_widget/navigation_head.dart';

class HistoryNavigationView extends ConsumerWidget {
  const HistoryNavigationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyViewRef = ref.watch(historyViewProvider);
    return Scaffold(
      appBar: AppBar(
        title: const NavBarHistoryVWidget(),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: switch (historyViewRef) {
          HistoryViews.timeEntry => const HistoryTimeBody(),
          HistoryViews.consumables => const HistoryMaterialBody(),
          _ => const CostumerOverviewBody(),
        },
      ),
    );
  }
}

class NavBarHistoryVWidget extends ConsumerWidget {
  const NavBarHistoryVWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewProvider = ref.watch(historyViewProvider);
    final viewNotifier = ref.read(historyViewProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => viewNotifier.state = HistoryViews.timeEntry,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.0),
            child: NavigationIcon(
              title: 'Zeiteintrag',
              isCurrent: viewProvider == HistoryViews.timeEntry,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => viewNotifier.state = HistoryViews.project,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.0),
            child: NavigationIcon(
              title: 'Kunde',
              isCurrent: viewProvider == HistoryViews.project,
            ),
          ),
        ),
        // TODO: activate the Navigation uncommented GesturDetector and delete isActiv
        // GestureDetector(
        // onTap: () => viewNotifier.state = HistoryViews.consumables,
        // child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.0),
          child: NavigationIcon(
            title: 'Material',
            isCurrent: viewProvider == HistoryViews.consumables,
            isActiv: false,
            // ),
          ),
        ),
      ],
    );
  }
}
