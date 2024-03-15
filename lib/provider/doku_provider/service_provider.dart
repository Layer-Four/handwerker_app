import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/service_models/service_vm/service.dart';

final serviceProvider =
    AsyncNotifierProvider<ServiceNotifer, List<ServiceVM>?>(() => ServiceNotifer());

class ServiceNotifer extends AsyncNotifier<List<ServiceVM>?> {
  @override
  List<ServiceVM>? build() {
    return null;
  }

  void loadServices() async {
    final uri = const DbAdress().getExecuteableServices;
    final Dio http = Dio();
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = response.data;
        final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();

        state = AsyncValue.data(services);
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
