import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/dokumentation_models/docmentation_dm/documentation_dm.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

final projectVMProvider =
    AsyncNotifierProvider<ProjectNotifer, List<ProjectListVM>?>(() => ProjectNotifer());

class ProjectNotifer extends AsyncNotifier<List<ProjectListVM>?> {
  final Api _api = Api();
  @override
  List<ProjectListVM>? build() => null;

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
      state = AsyncValue.data(projects);
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
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return result;
        }
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
              log(url);
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
}
