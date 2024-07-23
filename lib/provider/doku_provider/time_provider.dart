import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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

  Future<bool> createTimeEntriesVM(TimeEntriesVM entry) async {
    final data = TimeEntry.fromTimeEntriesVM(entry).toJson();
    data.removeWhere((key, value) => key == 'userID');
    // log(json.encode(data));
    try {
      final response = await _api.postTimeEnty(data);
      if (response.statusCode != 200) {
        throw Exception(
            'Error occuren on createTimeEntriesVM: ${response.statusCode}\n${response.data}');
      }
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        ref.read(userProvider.notifier).userLogOut();
        log('userLogout on createTimeEntriesVM \n${jsonEncode(e)}');
      }
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  void loadTimeEntriesVM() async {
    try {
      final response = await _api.getAllTimeentriesDM;
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
      newstate.sort((a, b) => a.date.compareTo(b.date));
      state = newstate;
      return;
    } catch (e) {
      log('request was incompleted this was the error: $e');
      return;
    }
  }

  List<TimeEntriesVM> loadWorkOrder() {
    final allEntries = state;
    if (state.isEmpty) return [];

    allEntries.sort(
      (a, b) => b.startTime.millisecondsSinceEpoch.compareTo(a.startTime.millisecondsSinceEpoch),
    );
    return allEntries.where((e) => e.type == TimeEntryType.workOrder).toList();
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
