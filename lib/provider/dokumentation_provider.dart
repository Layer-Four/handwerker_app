import 'package:flutter_riverpod/flutter_riverpod.dart';

final dokuProvider =
    NotifierProvider<InputNotifier, List<Map<String, dynamic>>>(() => InputNotifier());

class InputNotifier extends Notifier<List<Map<String, dynamic>>> {
  @override
  build() {
    return [];
  }

  void saveStart({required DateTime start}) {
    if (state.contains('start')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('start')) list.add(e);
      });
      list.add({'start': start});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    final list = state;
    list.add({'start': start});
    state = list;
  }

  void saveEnd({required DateTime end}) {
    if (state.contains('end')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('end')) list.add(e);
      });
      list.add({'end': end});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    final list = state;
    list.add({'end': end});
    state = list;
  }

  void saveDescription({String? description}) {
    if (state.contains('description')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('description')) list.add(e);
      });
      list.add({'description': description});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    state = [
      ...state,
      {'description': description}
    ];
  }

  void saveProject({required String project}) {
    if (state.contains('project')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('project')) list.add(e);
      });
      list.add({'project': project});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    state = [
      ...state,
      {'project': project}
    ];
  }

  void saveService({required String service}) {
    if (state.contains('service')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('service')) list.add(e);
      });
      list.add({'service': service});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    state = [
      ...state,
      {'service': service}
    ];
  }

  void saveUser({required String user}) {
    if (state.contains('user')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('user')) list.add(e);
      });
      list.add({'user': user});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    state = [
      ...state,
      {'user': user}
    ];
  }
}
