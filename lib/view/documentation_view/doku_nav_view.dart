import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/dokumentation_provider.dart';
import 'package:handwerker_app/view/documentation_view/documentation_body.dart';
import 'package:handwerker_app/view/execution_view/execuion_body.dart';
import 'package:handwerker_app/view/navigation_view/nav_appbar_widget.dart';

class DokuNavigation extends ConsumerWidget {
  const DokuNavigation({super.key});

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
            _ => const ExecutionBody(),
          },
        ),
      ),
    );
  }
}

class MaterialBody extends ConsumerStatefulWidget {
  const MaterialBody({super.key});

  @override
  ConsumerState<MaterialBody> createState() => _MaterialBodyState();
}

class _MaterialBodyState extends ConsumerState<MaterialBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
