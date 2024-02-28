import 'package:flutter_riverpod/flutter_riverpod.dart';

final viewProvider = StateProvider<int>((ref) => 1);

enum DokuViews { timeEntry, doku, consumables }

final dokuViewProvider = StateProvider((ref) => DokuViews.timeEntry);

enum HistoryViews { timeEntry, project, consumables }

final historyViewProvider = StateProvider((ref) => HistoryViews.project);
