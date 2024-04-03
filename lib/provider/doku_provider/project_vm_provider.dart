import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/dokumentation_models/docmentation_dm/documentation_dm.dart';
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
        return result;
      }
      final List data = (response.data as List).map((e) => e as Map<String, dynamic>).toList();
      final projects = data.map((e) => ProjectCustomer.fromJson(e)).toList();
      result.addAll(projects);
      return result;
    } catch (e) {
      log('this error occurent-> $e');
      throw Exception(e);
    }
  }

  Future<List<DocumentationDM>?> loadDocumentationForProject(int projectID) async {
    final Dio dio = Dio();
    final url = const DbAdresses().getDokuforProjectURL(projectID);
    List<DocumentationDM> result = [];
    try {
      final response = await dio.get(url);
      if (response.statusCode != 200) {
        log('something went wrong-> ${response.data}');
        return null;
      }
      final List data = response.data.map((e) => e).toList();
      for (var e in data) {
        final imageUrls = <String>[];
        final String? description = e['description'];
        final List something = e['images'];
        if (something.isNotEmpty) {
          for (var j in something) {
            if (j != null || j!.isNotEmpty) {
              final url = 'https://rsahapp.blob.core.windows.net/$j';
              imageUrls.add(url);
            }
          }
        }
        final documentation = DocumentationDM(
          description: description,
          imagesUrl: imageUrls,
        );

        result.add(documentation);
      }
      return result;
    } catch (error) {
      throw Exception(error);
    }
  }
}
