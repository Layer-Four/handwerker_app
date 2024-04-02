import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';

final consumableProvider =
    NotifierProvider<ConsumableNotifier, List<Consumable>>(() => ConsumableNotifier());

class ConsumableNotifier extends Notifier<List<Consumable>> {
  @override
  List<Consumable> build() => [];
  void addConsumable(Consumable consumable) => state = [...state, consumable];

  void uploadConsumableEntry(ConsumealbeEntry entry) async {
    final json3 = entry.toJson();
    final Dio http = Dio();
    log(json.encode(json3.toString()));
    try {
      final response = await http.post(
        const DbAdresses().postProjectConsumable,
        data: json3,
      );
      if (response.statusCode == 200) {
        log('request success -> ${response.data}');
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : \n${response.data} ');
      }
    } catch (e) {
      log('request was incompleted this was the error-> $e');
    }
  }
}
