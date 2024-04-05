import 'dart:developer';

import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/time_models/time_entry.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final Api api = Api();
  // Lad einträge vom Web.
  // final dio = Dio();
  List<TimeEntry>? entries;
  // final response = await dio.get(DbAdresses().getAllTimeEntrys);
  final response = await api.getAllTimeEntrys;
  if (response.statusCode == 200) {
    final List data = response.data.map((e) => e).toList();
    data.map((e) => e.asMap());
    entries = data.map((e) => TimeEntry.fromJson(e)).toSet().toList();
  }
  test('create list of TimeEntrys', () {
    expect(entries != null, true);
    expect(entries!.length > 2, true);
  });
  // sortiere einträge in workdays
  List<Workday?> sortEntriesForDate(List<TimeEntry> entries) {
    List<Workday> two = [];
    for (var e in entries) {
      if (two.any((element) =>
          element.date.day == e.startTime.day &&
          element.date.month == e.startTime.month &&
          element.date.year == e.startTime.year)) {
        final date = two.firstWhere((element) =>
            element.date.day == e.startTime.day &&
            element.date.month == e.startTime.month &&
            element.date.year == e.startTime.year);
        date.timeEntries.add(e);
      } else if (!two.any((element) =>
          element.date.day == e.startTime.day &&
          element.date.month == e.startTime.month &&
          element.date.year == e.startTime.year)) {
        two.add(Workday(date: e.startTime, timeEntries: [e]));
      } else {
        log('no matches');
      }
    }
    return two;
  }

  test('sort TimeEntries in lost of Workdays', () {
    final workdays = sortEntriesForDate(entries!);
    expect(workdays.isNotEmpty, true);
    expect(workdays.length < 18, true);
    expect(workdays[0]!.timeEntries.isNotEmpty, true);
    expect(workdays[3]!.timeEntries.length > 2, true);
  });
}
