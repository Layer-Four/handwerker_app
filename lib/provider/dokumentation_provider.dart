import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DokuViews {
  zeiteintrag,
  doku,
  material,
}

final dokuProvider =
    NotifierProvider<InputNotifier, List<Map<String, dynamic>>>(() => InputNotifier());
final dokuViewProvider = StateProvider((ref) => DokuViews.zeiteintrag);

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

  void saveService({required String? service}) {
    if (service == null) return;
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

  void saveUser({required List<String>? users}) {
    if (users == null) return;
    if (state.contains('user')) {
      final list = [];
      state.map((e) {
        if (!e.containsKey('user')) list.add(e);
      });
      list.add({'user': users});
      state = list as List<Map<String, dynamic>>;
      return;
    }
    state = [
      ...state,
      {'user': users}
    ];
  }
}
