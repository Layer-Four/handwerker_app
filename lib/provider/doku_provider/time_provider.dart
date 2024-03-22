import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/time_models/time_entry.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';

final timeEntryProvider =
    NotifierProvider<TimeEntryNotifier, List<TimeEntry>>(() => TimeEntryNotifier());

class TimeEntryNotifier extends Notifier<List<TimeEntry>> {
  @override
  build() => [];

  void addTimeEntry(TimeEntry entry) => state = [...state, entry];

  // TODO: write request provider for encaplusalted logic
  void uploadTimeEntry(TimeEntry entry) async {
    final uri = const DbAdresses().postTimeEnty;
    final Dio dio = Dio();

    try {
      final response = await dio.post(uri, data: entry.toJson());
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final entry = TimeEntry.fromJson(jsonResponse);
        final list = <TimeEntry>[...state, entry];

        state = list;
        log('länge Zeiteinträge: ${state.length}');
        log('request success, this was the response: $jsonResponse');
        return;
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }

  void loadEntrys() async {
    final String url = const DbAdresses().getAllTimeEntrys;
    final Dio dio = Dio();
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final List data = response.data.map((e) => e).toList();
        data.map((e) => e.asMap());
        final entry = data.map((e) => TimeEntry.fromJson(e)).toSet().toList();
        state = entry;

        log('länge Zeiteinträge: ${state.length}');
        log('request success, this was the response: $entry');
        return;
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }

  // sortiere einträge in workdays
  List<Workday?> getListOfWorkdays() {
    List<Workday> listOfWorkdays = [];
    for (var e in state) {
      if (listOfWorkdays.any((element) =>
          element.date.day == e.startTime.day &&
          element.date.month == e.startTime.month &&
          element.date.year == e.startTime.year)) {
        final date = listOfWorkdays.firstWhere((element) =>
            element.date.day == e.startTime.day &&
            element.date.month == e.startTime.month &&
            element.date.year == e.startTime.year);
        date.timeEntries.add(e);
      } else if (!listOfWorkdays.any((element) =>
          element.date.day == e.startTime.day &&
          element.date.month == e.startTime.month &&
          element.date.year == e.startTime.year)) {
        listOfWorkdays.add(Workday(date: e.startTime, timeEntries: [e]));
      } else {
        log('no matches');
      }
    }
    return listOfWorkdays;
  }
}
