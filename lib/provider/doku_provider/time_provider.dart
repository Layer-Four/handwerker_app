import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';
import 'package:handwerker_app/models/time_models/time_entry_dm/time_entry.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

final timeEntriesProvider =
    NotifierProvider<TimeEntriesNotifier, List<TimeEntriesVM>>(() => TimeEntriesNotifier());

class TimeEntriesNotifier extends Notifier<List<TimeEntriesVM>> {
  final Api _api = Api();
  @override
  build() => [];

  void uploadTimeEntriesVM(TimeEntriesVM entry) async {
    final data = TimeEntry.fromTimeEntriesVM(entry).toJson();
    data.removeWhere((key, value) => key == 'userID');
    log(json.encode(data));

    try {
      final response = await _api.postTimeEnty(data);
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return;
        }
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return;
      }
      loadTimeTracks();
      // final newData = await _api.getAllTimeTracks;
      // final jsonResponse = response.data;
      // final entry = TimeEntriesVM.fromTimeEntryDM(TimeEntry.fromJson(jsonResponse));
      // final list = <TimeEntriesVM>[...state, entry];
      // state = list;
      log(' \nrequest success\n ');
      return;
    } catch (e) {
      if (e.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('message');
        return;
      }
      log('request was incompleted this was the error: $e');
    }
  }

  void loadTimeTracks() async {
    try {
      final response = await _api.getAllTimeTracks;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return;
        }
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return;
      }
      final List data = response.data.map((e) => e).toList();
      data.map((e) => e.asMap());
      final newstate =
          data.map((e) => TimeEntriesVM.fromTimeEntryDM(TimeEntry.fromJson(e))).toSet().toList();
      state = newstate;
      return;
    } catch (e) {
      log('request was incompleted this was the error: $e');
      return;
    }
  }

  // sortiere einträge in workdays
  List<Workday> getListOfWorkdays() {
    List<Workday> listOfWorkdays = [];
    for (var e in state) {
      if (listOfWorkdays.any((element) =>
          element.date.day == e.date.day &&
          element.date.month == e.date.month &&
          element.date.year == e.date.year)) {
        final date = listOfWorkdays.firstWhere((element) =>
            element.date.day == e.date.day &&
            element.date.month == e.date.month &&
            element.date.year == e.date.year);
        date.timeEntries.add(e);
      } else if (!listOfWorkdays.any((element) =>
          element.date.day == e.date.day &&
          element.date.month == e.date.month &&
          element.date.year == e.date.year)) {
        listOfWorkdays.add(Workday(date: e.date, timeEntries: [e]));
      } else {
        log('no matches');
      }
    }
    return listOfWorkdays;
  }
}
