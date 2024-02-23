import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewNavigator extends ConsumerWidget {
  const ViewNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Text('zeiterfassung'),
          ),
        ),
        // switch (view) {
        //   ViewPage.ticket => TicketView(),
        //   ViewPage.table => MatchStatisticsView(),
        //   ViewPage.shop => const ShopView(),
        //   // ViewPage.newsFeed => const NewsFeed(),
        //   ViewPage.error => ShowErrorScreen(error: ref.watch(errorProvider).last),
        //   ViewPage.myTabBar => const MyTabBar(),
        //   _ => HomeView()
        // },
        bottomNavigationBar: NavigationBar(
          height: MediaQuery.of(context).size.height / 10,
          backgroundColor: Colors.grey,
          destinations: [],
        ),
      ),
    );
  }
}
