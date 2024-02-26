import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/view_provider.dart';
import 'package:handwerker_app/routes/app_routes.dart';
import 'package:handwerker_app/view/execution_view/execuion_body.dart';
import 'package:handwerker_app/view/login_screen/login_view.dart';
import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';
import 'package:handwerker_app/view/widgets/navigaton_widget/navigation_head.dart';

class ViewNavigator extends ConsumerWidget {
  const ViewNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationIcon(title: 'Zeiteintrag', isCurrent: true),
            NavigationIcon(title: 'Doku'),
            NavigationIcon(title: 'Material'),
          ],
        ),
      ),
      body: switch (ref.watch(viewProvider)) {
        0 => const ExecutionBody(),
        _ => LoginView(),
        //   ViewPage.ticket => TicketView(),
        //   ViewPage.table => MatchStatisticsView(),
        //   ViewPage.shop => const ShopView(),
        //   // ViewPage.newsFeed => const NewsFeed(),
        //   ViewPage.error => ShowErrorScreen(error: ref.watch(errorProvider).last),
        //   ViewPage.myTabBar => const MyTabBar(),
      },
      bottomNavigationBar: AppNavigationBar(
        index: ref.watch(viewProvider),
        onChangedTab: (index) {
          // Navigator.of(context).pushReplacementNamed(AppRoutes.routes[index]);
          ref.read(viewProvider.notifier).state = index;
        },
      ),
    );
  }
}
