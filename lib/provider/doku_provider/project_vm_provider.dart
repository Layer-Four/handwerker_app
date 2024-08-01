import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

import '../../models/dokumentation_models/docmentation_dm/documentation_dm.dart';
import '../../models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';

final projectVMProvider = StateNotifierProvider<ProjectNotifier, List<ProjectShortVM>>(
  (ref) => ProjectNotifier(ref),
);

class ProjectNotifier extends StateNotifier<List<ProjectShortVM>> {
  final bool isError = false;
  List<ProjectShortVM> build() {
    loadpProject();
    return [];
  }

  final Ref ref;
  final Api _api = Api();

  ProjectNotifier(this.ref) : super([]);

  ProjectShortVM? _chosenProject;
  ProjectShortVM? get chosenProject => _chosenProject;

  Future<List<ProjectShortVM>> loadpProject() async {
    try {
      final response = await _api.getProjectsDM;
      if (response.statusCode != 200) {
        log('Request dismissed statusCode: ${response.statusCode}, message: ${response.data}');
        state = [];
        return [];
      }
      final List<dynamic> data = response.data;
      final projects = data.map<ProjectShortVM>((e) => ProjectShortVM.fromJson(e)).toList();
      state = projects;
      return projects;
    } catch (e) {
      log('Error occurred: $e');
      state = []; // Set state to an empty list in case of error
      return []; // Return an empty list in case of error
    }
  }

  void updateProject(ProjectShortVM? e) => _chosenProject = e;

  Future<List<ProjectCustomer>> getAllProjectEntries() async {
    final result = <ProjectCustomer>[];
    try {
      final response = await _api.getCustomerProjects;
      if (response.statusCode != 200) {
        throw Exception(
          'Error occurred on getAllProjectEntries, status: ${response.statusCode}, data: ${response.data}',
        );
      }
      final List<dynamic> data = response.data;
      final projects = data.map((e) => ProjectCustomer.fromJson(e)).toList();
      result.addAll(projects);
      return result;
    } catch (e) {
      log('Error occurred: $e');
      throw Exception(e);
    }
  }

  Future<List<DocumentationDM>?> loadDocumentationForProject(int projectID) async {
    final result = <DocumentationDM>[];
    try {
      final response = await _api.getDokuforProjectURL(projectID);
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return result;
        }
        log('Error occurred: ${response.data}');
        return null;
      }
      final List<dynamic> data = response.data;
      for (var e in data) {
        final imageUrls = <String>[];
        final String? description = e['description'];
        final List<dynamic> images = e['images'];
        if (images.isNotEmpty) {
          for (var j in images) {
            if (j != null && j.isNotEmpty) {
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
      if (error.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('Server error');
        return [];
      }
      throw Exception(error);
    }
  }

  Future<List<ProjectShortVM>> getProjectsForCustomer(int customerId) async {
    try {
      final response = await _api.getProjectByCustomerID(customerId);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getProjectsForCustomer, status: ${response.statusCode}, data: ${response.data}',
        );
      }
      final List<dynamic> data = response.data;
      return data.map((e) => ProjectShortVM.fromJson(e)).toList();
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectsForCustomer: $e');
    }
    return [];
  }

  Future<void> loadProjectsForCustomer(int customerID) async {
    try {
      final projects = await getProjectsForCustomer(customerID);
      state = projects.map((shortVM) {
        return ProjectShortVM(
          id: shortVM.id!,
          title: shortVM.title!,
        );
      }).toList();
    } catch (e) {
      log('Exception: $e');
      state = []; // Set state to an empty list in case of error
    }
  }
}
