import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/service_models/service_list_vm/service_list.dart';

final serviceProvider =
    AsyncNotifierProvider<ServiceNotifer, List<ServiceListVM>?>(() => ServiceNotifer());

class ServiceNotifer extends AsyncNotifier<List<ServiceListVM>?> {
  final Api _api = Api();
  @override
  List<ServiceListVM>? build() {
    return null;
  }

  void loadServices() async {
    try {
      final response = await _api.getExecuteableServices;
      if (response.statusCode != 200) {
        throw Exception(
          'Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message',
        );
      }
      final data = response.data;
      final services = data.map<ServiceListVM>((e) => ServiceListVM.fromJson(e)).toList();
      state = AsyncValue.data(services);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode}. ${e.response?.data}');
    } catch (e) {
      throw Exception(e);
    }
    return;
  }
}
