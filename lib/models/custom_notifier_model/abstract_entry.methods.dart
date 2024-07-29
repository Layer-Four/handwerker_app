import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';

import '../customer_models/customer_short_model/customer_short_dm.dart';
import '../service_models/service_list_vm/service_list.dart';

abstract class AbstractEntryMethod<T> extends Notifier<T> {
  static final Api _api = Api();
  static Api get api => _api;

  Future<List<CustomerShortDM>> getAllCustomer() async {
    final result = <CustomerShortDM>[];
    try {
      final response = await _api.getListCustomer;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getAllCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      response.data.map((e) => result.add(CustomerShortDM.fromJson(e))).toSet();
      return result;
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getAllCustomer: $e');
    }
    return [];
  }

  Future<List<ProjectShortVM>> getProjectsForCustomer(int customerID) async {
    try {
      final response = await _api.getProjectByCustomerID(customerID);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getProjectForCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      return data.map((e) => ProjectShortVM.fromJson(e)).toList();
      // state = state.copyWith(newProjects: newProjects);
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectForCustomer: $e');
    }
    return [];
  }

  Future<List<ServiceListVM>> getAllServices() async {
    try {
      final response = await _api.getExecuteableServices;
      if (response.statusCode != 200) {
        throw Exception(
          'Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message',
        );
      }
      final data = response.data;
      final services = data.map<ServiceListVM>((e) => ServiceListVM.fromJson(e)).toList();
      return services;
      // state = AsyncValue.data(services);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode}. ${e.response?.data}');
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  void updateSelectedProject(ProjectShortVM? e);
  void updateSeletedCustomer(CustomerShortDM? e);
}
