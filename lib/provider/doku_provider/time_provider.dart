import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/service_models/service_list_vm/service_list.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';
import 'package:handwerker_app/models/time_models/time_entry_dm/time_entry.dart';
import 'package:handwerker_app/models/state_models/time_state.dart';
import 'package:handwerker_app/models/time_models/workday_models/workday_vm.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/models/customer_models/customer_short_model/customer_short_dm.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/models/custom_notifier_model/abstract_entry.methods.dart';

final timeEntriesProvider = NotifierProvider<TimeEntriesNotifier, TimeEntryState>(() => TimeEntriesNotifier());

// Notifier<TimeEntryState> implements
class TimeEntriesNotifier extends AbstractEntryMethod<TimeEntryState> {
  final Api _api = Api();

  TimeEntriesVM get entry => state.entry;
  List<ServiceListVM> get allServices => state.allServices;
  ServiceListVM? get service => state.currentService;
  CustomerShortDM? get currentCustomer => state.currentCustomer;
  ProjectShortVM? get project => state.project;
  List<ProjectShortVM> get projectsList => state.customerProjects;
  List<CustomerShortDM>? get customers => state.customers;
  @override
  TimeEntryState build() {
    loadAllCustomer();
    loadAllServices();
    return const TimeEntryState();
  }

  @override
  void updateSeletedCustomer(CustomerShortDM? e) async {
    if (e == null || state.currentCustomer == e) return;
    final newProjects = await getProjectsForCustomer(e.id);
    final newEntry = state.entry.copyWith(customerName: e.companyName);
    state = state.copyWith(
      newProjects: newProjects,
      editedCustomer: () => e,
      editedProject: () => null,
      newEntry: newEntry,
    );
  }

  loadAllServices() => getAllServices().then(
        (e) => state = state.copyWith(newServices: e),
      );
  @override
  void updateSelectedProject(ProjectShortVM? e) {
    if (e == null || e == state.project) return;
    final newEntry = state.entry.copyWith(projectID: e.id, projektTitle: e.title);
    state = state.copyWith(editedProject: () => e, newEntry: newEntry);
  }

  void updateEntry({
    DateTime? newDate,
    String? description,
    int? duration,
    DateTime? endTime,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    DateTime? startTime,
  }) {
    final newEntry = state.entry.copyWith(
      date: newDate ?? entry.date,
      description: description ?? entry.description,
      duration: duration ?? entry.duration,
      endTime: endTime ?? entry.endTime,
      pauseEnd: pauseEnd ?? entry.pauseEnd,
      pauseStart: pauseStart ?? entry.pauseStart,
      startTime: startTime ?? entry.startTime,
    );
    state = state.copyWith(newEntry: newEntry);
  }

  void loadAllCustomer() {
    getAllCustomer().then((e) => state = state.copyWith(newCustomers: e));
  }

  void updateSelectedService(ServiceListVM? e) {
    if (e == null || e == state.currentService) return;
    final newEntry = state.entry.copyWith(serviceID: e.id, serviceTitle: e.name);
    state = state.copyWith(nextService: e, newEntry: newEntry);
  }

  Future<bool> createTimeEntriesVM() async {
    if (!(entry.isMinfilled())) return false;
    final data = TimeEntry.fromTimeEntriesVM(entry).toJson();
    data.removeWhere((key, value) => key == 'userID');
    // log(json.encode(data));
    try {
      final response = await _api.postTimeEnty(data);
      if (response.statusCode != 200) {
        throw Exception('Error occuren on createTimeEntriesVM: ${response.statusCode}\n${response.data}');
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
      final allTimeEntries = data.map((e) => TimeEntriesVM.fromTimeEntryDM(TimeEntry.fromJson(e))).toSet().toList();
      allTimeEntries.sort((a, b) => a.date!.compareTo(b.date!));
      state = state.copyWith(newEntries: allTimeEntries);
      return;
    } catch (e) {
      log('request was incompleted this was the error: $e');
      return;
    }
  }

  List<TimeEntriesVM> loadWorkOrder() {
    if (state.allEntries.isEmpty) return [];

    state.allEntries.sort(
      (a, b) => b.startTime!.millisecondsSinceEpoch.compareTo(a.startTime!.millisecondsSinceEpoch),
    );
    return state.allEntries.where((e) => e.type == TimeEntryType.workOrder).toList();
  }

  // sortiere einträge in workdays
  List<Workday> getListOfWorkdays() {
    List<Workday> listOfWorkdays = [];
    for (var e in state.allEntries) {
      if (listOfWorkdays
          .any((element) => element.date.day == e.date!.day && element.date.month == e.date!.month && element.date.year == e.date!.year)) {
        final date = listOfWorkdays.firstWhere(
            (element) => element.date.day == e.date!.day && element.date.month == e.date!.month && element.date.year == e.date!.year);
        date.timeEntries.add(e);
      } else if (!listOfWorkdays
          .any((element) => element.date.day == e.date!.day && element.date.month == e.date!.month && element.date.year == e.date!.year)) {
        listOfWorkdays.add(Workday(date: e.date!, timeEntries: [e]));
      } else {
        log('no matches');
      }
    }
    return listOfWorkdays;
  }
}
