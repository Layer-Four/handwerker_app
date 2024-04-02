import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';

final projectVMProvider =
    AsyncNotifierProvider<ProjectNotifer, List<ProjectListVM>?>(() => ProjectNotifer());

class ProjectNotifer extends AsyncNotifier<List<ProjectListVM>?> {
  @override
  List<ProjectListVM>? build() => null;

  void loadpProject() async {
    final uri = const DbAdresses().getProjectsDM;
    final Dio http = Dio();
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = response.data;
        final projects = data.map<ProjectListVM>((e) => ProjectListVM.fromJson(e)).toList();
        state = AsyncValue.data(projects);
      }
      if (response.statusCode != 200) {
        log('request dismissed statuscode: ${response.statusCode} meldung: ${response.data}');
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
    return;
  }

  Future<List<ProjectCustomer>> getAllProjectEntries() async {
    final Dio dio = Dio();
    final url = const DbAdresses().getCustomerProjects;
    final result = <ProjectCustomer>[];
    // int count = 0;

    try {
      final response = await dio.get(url);
      if (response.statusCode != 200) {
        log(response.data);
        return result;
      }
      final List data = (response.data as List).map((e) => e as Map<String, dynamic>).toList();
      log(data.toString());
      final projects = data.map((e) => ProjectCustomer.fromJson(e)).toList();
      result.addAll(projects);
      return result;
    } catch (e) {
      log('this error occurent-> $e');
      throw Exception(e);
    }
  }

  Future<List<dynamic>?> loadDocumentationForProject(int projectID) async {
    final Dio dio = Dio();
    final url = DbAdresses().getDokuforProjectURL(projectID);
    log(url);
    List result = [];
    try {
      final response = await dio.get(url);
      if (response.statusCode != 200) {
        log('something went wrong-> ${response.data}');
        return null;
      }
      final List data = response.data.map((e) => e).toList();
      for (var e in data) {
        final object = {
          'description': e['description'] as String?,
          'images': e['images'],
        };
        result.add(object);
      }
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
