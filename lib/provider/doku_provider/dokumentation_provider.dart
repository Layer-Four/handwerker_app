import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/time_entry/time_entry.dart';

final dokuProvider = NotifierProvider<InputNotifier, List<TimeEntry?>>(() => InputNotifier());

class InputNotifier extends Notifier<List<TimeEntry?>> {
  @override
  build() => [];

  void addTimeEntry(TimeEntry entry) => state = [...state, entry];

  void saveStart({required DateTime start}) {
    if (state.isEmpty) {
      state = [...state, TimeEntry(date: start, startTime: start)];
      return;
    }
    final doubled = state.firstWhere((e) => e?.date == start);
    if (doubled != null) {
      final newEntry = doubled.copyWith(date: start, startTime: start);
      List<TimeEntry?> newList = [...state];
      newList.remove(doubled);
      newList.add(newEntry);
      state = newList;
    }
    state = [...state, TimeEntry(date: start, startTime: start)];
  }

  void saveEnd({required DateTime end, required String projectID}) {
    final doubled = state.firstWhere((e) => e?.projectID == projectID);

    if (doubled != null) {
      final newEntry = doubled.copyWith(endTime: end);
      List<TimeEntry?> newList = [...state];
      newList.remove(doubled);
      newList.add(newEntry);
      state = newList;
      return;
    }
    throw Exception('no existing entry found');
  }

  // void saveGalleryFile({required File? galleryFile}) {
  //   if (state.contains('galleryFile')) {
  //     final list = [];
  //     state.map((e) {
  //       if (!e.containsKey('galleryFile')) list.add(e);
  //     });
  //     list.add({'galleryFile': galleryFile});
  //     state = list as List<Map<String, dynamic>>;
  //     return;
  //   }
  //   state = [
  //     ...state,
  //     {'galleryFile': galleryFile}
  //   ];
  // }

  // void saveStorageFile({required File? storageFile}) {
  //   if (state.contains('storageFile')) {
  //     final list = [];
  //     state.map((e) {
  //       if (!e.containsKey('storageFile')) list.add(e);
  //     });
  //     list.add({'storageFile': storageFile});
  //     state = list as List<Map<String, dynamic>>;
  //     return;
  //   }
  //   state = [
  //     ...state,
  //     {'storageFile': storageFile}
  //   ];
  // }

  void saveDescription({String? description, required String projectID}) {
    final doubled = state.firstWhere((e) => e?.projectID == projectID);
    if (doubled != null) {
      final newEntry = doubled.copyWith(description: description);
      List<TimeEntry?> newList = [...state];
      newList.remove(doubled);
      newList.add(newEntry);
      state = newList;
      return;
    }
    throw Exception('no existing entry found');
  }

  // void saveProject({required String project}) {
  //   if (state.contains('project')) {
  //     final list = [];
  //     state.map((e) {
  //       if (!e.containsKey('project')) list.add(e);
  //     });
  //     list.add({'project': project});
  //     state = list as List<Map<String, dynamic>>;
  //     return;
  //   }
  //   state = [
  //     ...state,
  //     {'project': project}
  //   ];
  // }

  // void saveService({required String? service}) {
  //   if (service == null) return;
  //   if (state.contains('service')) {
  //     final list = [];
  //     state.map((e) {
  //       if (!e.containsKey('service')) list.add(e);
  //     });
  //     list.add({'service': service});
  //     state = list as List<Map<String, dynamic>>;
  //     return;
  //   }
  //   state = [
  //     ...state,
  //     {'service': service}
  //   ];
  // }

  // void saveUser({required List<String?> users}) {
  //   if (users.isEmpty) return;
  //   if (state.contains('user')) {
  //     final list = [];
  //     state.map((e) {
  //       if (!e.containsKey('user')) list.add(e);
  //     });
  //     list.add({'user': users});
  //     state = list as List<Map<String, dynamic>>;
  //     return;
  //   }
  //   state = [
  //     ...state,
  //     {'user': users}
  //   ];
  // }
}
