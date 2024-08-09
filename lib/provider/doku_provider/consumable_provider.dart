import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/consumable_models/unit_dm/unit_dm.dart';
import 'package:handwerker_app/models/custom_notifier_model/abstract_entry.methods.dart';
import 'package:handwerker_app/models/customer_models/customer_short_model/customer_short_dm.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';

import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

import '../../models/state_models/consumeable_state.dart';

final consumableProvider = NotifierProvider<ConsumableNotifier, ConsumableState>(() => ConsumableNotifier());

class ConsumableNotifier extends AbstractEntryMethod<ConsumableState> {
  final _api = Api();

  CustomerShortDM? get currentCustomer => state.currentCustomer;
  ConsumableDM? get currentMaterial => state.consumable;
  ProjectShortVM? get curerntProject => state.project;
  List<CustomerShortDM> get customers => state.customers;
  List<ProjectShortVM> get customersProjects => state.customerProject;
  ConsumalbeEntry? get entry => state.entry;
  List<ConsumableDM> get materials => state.consumables;

  @override
  ConsumableState build() {
    initState();
    return const ConsumableState();
  }

  // Method to add a consumable to the state
  void addConsumable(ConsumableDM consumable) {
//s    state = [...state, consumable];
  }

  void initState() async {
    final customers = await getAllCustomer();
    final consumables = await getAllConsumables();
    state = state.copyWith(
      newConsumalbels: consumables,
      newCustomers: customers,
    );
  }

//: TODO :we doesn't need units on mobile because we define units on Web for materials
  // Fetch units from the API
  Future<List<UnitDM>> getUnits() async {
    final List<UnitDM> result = [];
    try {
      final response = await _api.getAllUnits;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
        }
        log('Request not completed: ${response.statusCode} -> \n${response.data}');
        return result;
      }

      final List data = response.data as List;
      for (final unit in data) {
        result.add(UnitDM.fromJson(unit));
      }
    } catch (e) {
      if (e.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('User logout due to server error on getUnits \n${jsonEncode(e)}');
      }
      log('Request was incomplete. Error: $e');
    }
    return result;
  }

  // Upload consumable entry to the server
  Future<void> uploadConsumableEntry() async {
    if (!validState()) return;
    // TODO: after sending entry set all variables to default
    final json = state.entry!.toJson();
    try {
      final response = await _api.postProjectConsumable(json);
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
        }
        log('Request not completed: ${response.statusCode}. Backend returned: \n${response.data}');
        return;
      }
      log('Request success: ${response.data}');
    } catch (e) {
      if (e.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('User logout due to server error on uploadConsumableEntry \n${jsonEncode(e)}');
      }
      log('Request was incomplete. Error: $e');
    }
  }

  @override
  void updateSelectedProject(ProjectShortVM? e) {
    if (e == null || e == state.project) return;
    final newEntry = state.entry?.copyWith(projectID: e.id);
    state = state.copyWith(
      editedProject: () => e,
      newEntry: newEntry,
    );
  }

  @override
  void updateSeletedCustomer(CustomerShortDM? e) async {
    if (e == null || state.currentCustomer == e) return;
    final user = await _api.getUsername;
    final mandant = await _api.getMandant;
    log(user.toString());
    log(mandant.toString());
    final newProjects = await getProjectsForCustomer(e.id);
    state = state.copyWith(
      newProjects: newProjects,
      editedCustomer: () => e,
      editedProject: () => null,
    );
  }

// TODO: write copywith for nullable entry
  void updateSelectedConsumable(ConsumableDM? e) {
    if (e == null || e == currentMaterial) return;
    // TODO: overthing the createDate
    final newEntry = entry == null
        ? ConsumalbeEntry(createDate: DateTime.now(), consumables: [e])
        : entry!.copyWith(consumables: [...entry!.consumables, e]);
    state = state.copyWith(editedConsumable: e, newEntry: newEntry);
  }

  void updateEntry({
    DateTime? createdDate,
    int? newProjectID,
    List<ConsumableDM>? newconsumables,
  }) {
    final newEntry = state.entry == null
        ? ConsumalbeEntry(
            createDate: createdDate ?? DateTime.now(),
            projectID: newProjectID,
            consumables: [],
          )
        : state.entry!.copyWith(
            createDate: createdDate ?? entry!.createDate,
            projectID: newProjectID ?? entry!.projectID,
            consumables: newconsumables ?? entry!.consumables,
          );
    state = state.copyWith(newEntry: newEntry);
  }

  bool validState() {
    if (state.entry == null) return false;
    if (state.entry!.consumables.isEmpty) return false;
    if (state.entry!.projectID == null) return false;
    return true;
  }
}
