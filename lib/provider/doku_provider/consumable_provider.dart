import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/consumable_models/unit_dm/unit_dm.dart';

final consumableProvider =
    NotifierProvider<ConsumableNotifier, List<Consumable>>(() => ConsumableNotifier());

class ConsumableNotifier extends Notifier<List<Consumable>> {
  final Dio http = Dio();
  final adressBook = const DbAdresses();
  @override
  List<Consumable> build() => [];
  void addConsumable(Consumable consumable) => state = [...state, consumable];
  Future<List<UnitDM>> getUnits() async {
    final List<UnitDM> result = [];
    try {
      final response = await http.get(adressBook.getAllUnits);
      if (response.statusCode != 200) {
        log('Request not completed: ${response.statusCode} -> \n${response.data} ');
        return result;
      }
      final List data = response.data.map((e) => e).toList();
      for (final unit in data) {
        final object = UnitDM.fromJson(unit);
        result.add(object);
      }
      return result;
    } catch (e) {
      log('request was incompleted this was the error-> $e');
      return result;
    }
  }

  void uploadConsumableEntry(ConsumealbeEntry entry) async {
    final json = entry.toJson();
    try {
      final response = await http.post(
        adressBook.postProjectConsumable,
        data: json,
      );
      if (response.statusCode != 200) {
        log('Request not completed: ${response.statusCode} Backend returned : \n${response.data} ');
        return;
      }
      log('request success-> ${response.data}');
      return;
    } catch (e) {
      log('request was incompleted this was the error-> $e');
    }
  }
}
