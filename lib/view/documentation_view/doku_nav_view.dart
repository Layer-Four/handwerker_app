import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/dokumentation_provider.dart';
import 'package:handwerker_app/view/documentation_view/documentation_entry/documentation_body.dart';
import 'package:handwerker_app/view/documentation_view/material_entry/material_view.dart';
import 'package:handwerker_app/view/documentation_view/time_entry/time_entry_body.dart';
import 'package:handwerker_app/view/navigation_view/nav_appbar_widget.dart';

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
