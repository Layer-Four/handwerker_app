import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/view/history_view/history_consumable/history_consumable_view.dart';
import 'package:handwerker_app/view/history_view/history_project/project_overview.dart';
import 'package:handwerker_app/view/history_view/history_time_entry/history_time_entry.dart';
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
        child: SingleChildScrollView(
          child: switch (historyViewRef) {
            HistoryViews.timeEntry => const HistoryTimeBody(),
            HistoryViews.consumables => const HistoryMaterialBody(),
            _ => const HistoryProjectBody(),
          },
        ),
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
        InkWell(
          onTap: () => viewNotifier.state = HistoryViews.timeEntry,
          child: NavigationIcon(
            title: 'Zeiteintrag',
            isCurrent: viewProvider == HistoryViews.timeEntry,
          ),
          // child: NavigationIcon(title: 'Zeiteintrag', isCurrent: index == 0),
        ),
        InkWell(
          onTap: () => viewNotifier.state = HistoryViews.project,
          child: NavigationIcon(
            title: 'Projekt',
            isCurrent: viewProvider == HistoryViews.project,
          ),
        ),
        InkWell(
          onTap: () => viewNotifier.state = HistoryViews.consumables,
          child: NavigationIcon(
            title: 'Material',
            isCurrent: viewProvider == HistoryViews.consumables,
          ),
        ),
      ],
    );
  }
}