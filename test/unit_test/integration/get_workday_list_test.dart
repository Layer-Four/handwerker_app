import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';
import 'package:handwerker_app/models/time_models/time_entry_dm/time_entry.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Api api = Api();
  List<TimeEntriesVM>? entries;
  try {
    final response = await api.getAllTimeTracks;
    if (response.statusCode == 200) {
      final List data = response.data.map((e) => e).toList();
      data.map((e) => e.asMap());
      entries =
          data.map((e) => TimeEntriesVM.fromTimeEntryDM(TimeEntry.fromJson(e))).toSet().toList();
    } else {
      log('${response.statusCode} ${response.data}');
    }
  } catch (e) {
    log(e.toString());
  }
  test('create list of TimeEntrys', () {
    expect(entries != null, true);
    expect(entries!.length > 2, true);
  });
  // sortiere einträge in workdays
  List<Workday?> sortEntriesForDate(List<TimeEntriesVM> entries) {
    List<Workday> two = [];
    for (var e in entries) {
      if (two.any((element) =>
          element.date.day == e.date.day &&
          element.date.month == e.date.month &&
          element.date.year == e.date.year)) {
        final date = two.firstWhere((element) =>
            element.date.day == e.date.day &&
            element.date.month == e.date.month &&
            element.date.year == e.date.year);
        date.timeEntries.add(e);
      } else if (!two.any((element) =>
          element.date.day == e.date.day &&
          element.date.month == e.date.month &&
          element.date.year == e.date.year)) {
        two.add(Workday(date: e.date, timeEntries: [e]));
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
