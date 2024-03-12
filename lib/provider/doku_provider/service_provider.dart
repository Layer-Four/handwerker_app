import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/service_vm/service.dart';
import 'package:http/http.dart' as http;

final serviceProvider =
    AsyncNotifierProvider<ServiceNotifer, List<ServiceVM>?>(() => ServiceNotifer());

class ServiceNotifer extends AsyncNotifier<List<ServiceVM>?> {
  @override
  List<ServiceVM>? build() {
    return null;
  }

  void loadServices() async {
    const uri = DbAdress();
    try {
      final response = await http.get(uri.servicesUri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();

        state = AsyncValue.data(services);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
