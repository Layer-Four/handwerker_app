import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/view/documentation_view/documentation_entry/documentation_body.dart';
import 'package:handwerker_app/view/documentation_view/material_entry/material_view.dart';
import 'package:handwerker_app/view/documentation_view/time_entry/time_entry_body.dart';
import 'package:handwerker_app/view/widgets/navigaton_widget/navigation_head.dart';

class DokuNavigationView extends ConsumerWidget {
  const DokuNavigationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dokuViewRef = ref.watch(dokuViewProvider);
    return Scaffold(
      appBar: AppBar(
        title: const NavAppBarWidget(),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: switch (dokuViewRef) {
            DokuViews.project => const DocumentationBody(),
            DokuViews.consumables => const MaterialBody(),
            _ => const TimeEntryBody(),
          },
        ),
      ),
    );
  }
}

class NavAppBarWidget extends ConsumerWidget {
  const NavAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final language = ref.watch(languangeProvider);
    final viewProvider = ref.watch(dokuViewProvider);
    final viewNotifier = ref.read(dokuViewProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => viewNotifier.state = DokuViews.timeEntry,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: NavigationIcon(
              title: 'Zeiteintrag',
              isCurrent: viewProvider == DokuViews.timeEntry,
            ),
          ),
          // child: NavigationIcon(title: 'Zeiteintrag', isCurrent: index == 0),
        ),
        GestureDetector(
          onTap: () => viewNotifier.state = DokuViews.project,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: NavigationIcon(
              title: language.documentationLabel,
              isCurrent: viewProvider == DokuViews.project,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => viewNotifier.state = DokuViews.consumables,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: NavigationIcon(
              title: language.consumables,
              isCurrent: viewProvider == DokuViews.consumables,
            ),
          ),
        ),
      ],
    );
  }
}
