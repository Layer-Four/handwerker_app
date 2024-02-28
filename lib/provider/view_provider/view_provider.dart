import 'package:flutter_riverpod/flutter_riverpod.dart';

final viewProvider = StateProvider<MainViews>((ref) => MainViews.doku);

enum MainViews { timeEntry, doku, history, user }

extension MainViewsExention on MainViews {
  int get index => switch (this) {
        MainViews.timeEntry => 0,
        MainViews.doku => 1,
        MainViews.history => 2,
        MainViews.user => 3,
      };
  MainViews views(int index) => switch (index) {
        0 => MainViews.timeEntry,
        2 => MainViews.history,
        3 => MainViews.user,
        _ => MainViews.doku,
      };
}

enum DokuViews { timeEntry, doku, consumables }

final dokuViewProvider = StateProvider((ref) => DokuViews.timeEntry);

enum HistoryViews { timeEntry, project, consumables }

final historyViewProvider = StateProvider((ref) => HistoryViews.project);
