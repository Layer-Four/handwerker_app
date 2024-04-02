import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';

final consumableProvider =
    NotifierProvider<ConsumableNotifier, List<Consumable>>(() => ConsumableNotifier());

class ConsumableNotifier extends Notifier<List<Consumable>> {
  @override
  List<Consumable> build() => [];
  void addConsumable(Consumable consumable) => state = [...state, consumable];

  void uploadConsumableEntry(Consumable entry) async {
    final json = entry.toJson();
    final Dio http = Dio();

    try {
      final response = await http.post(const DbAdresses().postProjectConsumable, data: json);
      if (response.statusCode == 200) {
        // final jsonResponse = response.data;
        log('request success');
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }
}
