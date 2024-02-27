import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/view_provider.dart';
import 'package:handwerker_app/view/execution_view/execuion_body.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';
import 'package:handwerker_app/view/widgets/navigaton_widget/navigation_head.dart';

class ViewNavigator extends ConsumerWidget {
  const ViewNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(viewProvider);
    final notifier = ref.read(viewProvider.notifier);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: NavAppBarWidget(notifier: notifier, index: index),
        ),
        body: switch (index) {
          0 => const ExecutionBody(),
          _ => LoginView(),
        },
        bottomNavigationBar: AppNavigationBar(
          index: index,
          onChangedTab: (index) => notifier.state = index,
        ),
      ),
    );
  }
}

class NavAppBarWidget extends StatelessWidget {
  const NavAppBarWidget({
    super.key,
    required this.notifier,
    required this.index,
  });

  final StateController<int> notifier;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => notifier.state = 0,
          child: NavigationIcon(title: 'Zeiteintrag', isCurrent: index == 0),
        ),
        InkWell(
          onTap: () => notifier.state = 1,
          child: NavigationIcon(title: 'Dokumentation', isCurrent: index == 1),
        ),
        InkWell(
          onTap: () => notifier.state = 2,
          child: NavigationIcon(title: 'Material', isCurrent: index == 2),
        ),
      ],
    );
  }
}
