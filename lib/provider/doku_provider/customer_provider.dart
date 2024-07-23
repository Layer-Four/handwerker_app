import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/customer_models/customer_short_model/customer_short_dm.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'dart:developer';

class CustomerNotifier extends StateNotifier<List<CustomerShortDM>> {
  final Api _api = Api();

  CustomerNotifier() : super([]);

  Future<void> loadCustomers() async {
    try {
      final response = await _api.getListCustomer;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getAllCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final result = <CustomerShortDM>[];
      response.data.map((e) => result.add(CustomerShortDM.fromJson(e))).toList();
      state = result;
    } catch (e) {
      log('Exception on getAllCustomer: $e');
    }
  }
}

final customerProvider = StateNotifierProvider<CustomerNotifier, List<CustomerShortDM>>((ref) {
  final notifier = CustomerNotifier();
  notifier.loadCustomers();
  return notifier;
});
