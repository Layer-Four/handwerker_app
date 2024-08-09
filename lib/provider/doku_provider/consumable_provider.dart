import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/consumable_models/unit_dm/unit_dm.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

final consumableProvider = NotifierProvider<ConsumableNotifier, List<Consumable>>(
      () => ConsumableNotifier(),
);

class ConsumableNotifier extends Notifier<List<Consumable>> {
  final api = Api();

  @override
  List<Consumable> build() => [];

  // Method to add a consumable to the state
  void addConsumable(Consumable consumable) {
    state = [...state, consumable];
  }

  // Fetch units from the API
  Future<List<UnitDM>> getUnits() async {
    final List<UnitDM> result = [];
    try {
      final response = await api.getAllUnits;
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
  Future<void> uploadConsumableEntry(ConsumealbeEntry entry) async {
    final json = entry.toJson();
    try {
      final response = await api.postProjectConsumable(json);
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
}
