import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/dokumentation_models/docmentation_dm/documentation_dm.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';

final projectVMProvider = NotifierProvider<ProjectNotifer, List<ProjectListVM>>(
  () => ProjectNotifer(),
);

class ProjectNotifer extends Notifier<List<ProjectListVM>> {
  final Api _api = Api();

  @override
  List<ProjectListVM> build() => [];

  void loadpProject() async {
    try {
      final response = await _api.getProjectsDM;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return;
        }
        log('request dismissed statuscode: ${response.statusCode} meldung: ${response.data}');
        return;
      }
      final data = response.data;
      final projects = data.map<ProjectListVM>((e) => ProjectListVM.fromJson(e)).toList();
      state = projects;
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProjectCustomer>> getAllProjectEntries() async {
    final result = <ProjectCustomer>[];
    try {
      final response = await _api.getCustomerProjects;
      if (response.statusCode != 200) {
        throw Exception(
          'Error occurent on getAllProjectEntries, status->${response.statusCode}\n${response.data}',
        );
      }
      final List data = (response.data).map((e) => e).toList();
      final projects = data.map((e) => ProjectCustomer.fromJson(e)).toList();
      // for (var e in data) {
      //   log(e.toString());
      //   result.add(ProjectCustomer.fromJson(e));
      // }
      // log(result.length.toString());
      result.addAll(projects);
      return result;
    } catch (e) {
      log('this error occurred -> $e');
      throw Exception(e);
    }
  }

  Future<List<DocumentationDM>?> loadDocumentationForProject(int projectID) async {
    List<DocumentationDM> result = [];
    try {
      final response = await _api.getDokuforProjectURL(projectID);
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return result;
        }
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
      if (error.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('message');
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
          'Error on getProjectsForCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
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
      // Directly mapping from ProjectShortVM to ProjectListVM
      final projectListVMs = projects.map((shortVM) {
        return ProjectListVM(
          id: shortVM.id!,
          title: shortVM.title!,
        );
      }).toList();
      state = AsyncValue.data(projectListVMs);
    } catch (e) {
      throw Exception(e);
    }
  }
}
