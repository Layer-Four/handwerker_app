import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

// TODO: think the view change by index. When timeEntry is last than they don't have the correct index
enum MainViews {
  timeEntry,
  doku,
  history,
  user,
  logOut,
}

final viewProvider = StateProvider<MainViews>((ref) {
  if (ref.watch(userProvider).userToken.isEmpty) return MainViews.logOut;

  return MainViews.doku;
});

extension MainViewsExention on MainViews {
  int get index => switch (this) {
        MainViews.timeEntry => 0,
        MainViews.doku => 1,
        MainViews.history => 2,
        MainViews.user => 3,
        MainViews.logOut => 4
      };
  MainViews views(int index) => switch (index) {
        0 => MainViews.timeEntry,
        2 => MainViews.history,
        3 => MainViews.user,
        _ => MainViews.doku,
      };
}

enum DokuViews {
  timeEntry,
  project,
  consumables,
}

final dokuViewProvider = StateProvider<DokuViews>((ref) => DokuViews.timeEntry);

enum HistoryViews { timeEntry, jobs, consumables, projects }

final historyViewProvider = StateProvider((ref) => HistoryViews.jobs);
