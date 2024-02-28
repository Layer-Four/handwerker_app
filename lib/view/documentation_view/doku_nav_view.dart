import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            DokuViews.doku => const DokumentationBody(),
            DokuViews.material => const MaterialBody(),
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
    final viewProvider = ref.watch(dokuViewProvider);
    final viewNotifier = ref.read(dokuViewProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => viewNotifier.state = DokuViews.zeiteintrag,
          child: NavigationIcon(
            title: 'Zeiteintrag',
            isCurrent: viewProvider == DokuViews.zeiteintrag,
          ),
          // child: NavigationIcon(title: 'Zeiteintrag', isCurrent: index == 0),
        ),
        InkWell(
          onTap: () => viewNotifier.state = DokuViews.doku,
          child: NavigationIcon(
            title: 'Dokumentation',
            isCurrent: viewProvider == DokuViews.doku,
          ),
        ),
        InkWell(
          onTap: () => viewNotifier.state = DokuViews.material,
          child: NavigationIcon(
            title: 'Material',
            isCurrent: viewProvider == DokuViews.material,
          ),
        ),
      ],
    );
  }
}
