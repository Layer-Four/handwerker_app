// import 'package:flutter/material.dart';
// // import 'package:huskies_app/views/view_widgets/newsfeed/newsfeed.dart';

// class ViewNavigator extends ConsumerWidget {
//   const ViewNavigator({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final view = ref.watch(viewProvider);
//     final viewNotifier = ref.read(viewProvider.notifier);
//     return SafeArea(
//       child: Scaffold(
//         body: switch (view) {
//           ViewPage.ticket => TicketView(),
//           ViewPage.table => MatchStatisticsView(),
//           ViewPage.shop => const ShopView(),
//         // ViewPage.newsFeed => const NewsFeed(),
//           ViewPage.error => ShowErrorScreen(error: ref.watch(errorProvider).last),
//           ViewPage.myTabBar => const MyTabBar(),
//           _ => HomeView()
//         },
//         bottomNavigationBar: NavigationBar(
//           height: MediaQuery.of(context).size.height / 10,
//           backgroundColor: AppTheme.highlightedBackground,
//           destinations: [
//             NavBarIconWidget(
//               icon: Icons.home_outlined,
//               name: 'Home',
//               isCurrentView: view == ViewPage.home,
//               onPressed: () => viewNotifier.state = ViewPage.home,
//             ),
//             // NavBarIconWidget(
//             //   icon: Icons.newspaper,
//             //   name: 'News',
//             //   isCurrentView: view == ViewPage.newsFeed,
//             //   onPressed: () => viewNotifier.state = ViewPage.newsFeed,
//             // ),
//             NavBarIconWidget(
//               icon: Icons.newspaper,
//               name: 'Team',
//               isCurrentView: view == ViewPage.myTabBar,
//               onPressed: () => viewNotifier.state = ViewPage.myTabBar,
//             ),
//             NavBarIconWidget(
//               icon: Icons.bookmark_border_outlined,
//               name: 'Tickets',
//               isCurrentView: view == ViewPage.ticket,
//               onPressed: () => viewNotifier.state = ViewPage.ticket,
//             ),
//             NavBarIconWidget(
//               icon: Icons.mail_outline,
//               name: 'Ergebnisse',
//               isCurrentView: view == ViewPage.table,
//               onPressed: () => viewNotifier.state = ViewPage.table,
//             ),
//             NavBarIconWidget(
//               icon: Icons.card_giftcard,
//               name: 'shop',
//               isCurrentView: view == ViewPage.shop,
//               onPressed: () {
//                 if (view != ViewPage.shop) {
//                   ref.read(statusProvider.notifier).onLoading(
//                     duration: const Duration(seconds: 2),
//                   );

//                   viewNotifier.state = ViewPage.shop;
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }