import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_customer_vm/project_customer.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/models/project_models/project_dm/project_entry.dart';

final projectProvider =
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

  void uploadProjectEntry(ProjectEntry entry) async {
    final createUri = const DbAdresses().postDocumentationEntry;
    final updateUri = const DbAdresses().updateDocumentationEntry;

    final Dio http = Dio();
    final formDataList = <FormData>[];
    for (var path in entry.imageUrl) {
      // final byteList = XFile(path);
      final FormData formData = FormData.fromMap({
        'file': MultipartFile.fromFile(
          path,
          filename:
              '${entry.projectName}/${entry.createDate.day}:${entry.createDate.month}:${entry.createDate.year}.jpg',
        ),
      });
      formDataList.add(formData);
    }
    // await entry.imageUrl.map((e) async => FormData.fromMap({
    //       'file': MultipartFile.fromBytes(
    //         await XFile(e).readAsBytes(),
    //         filename:
    //             '${entry.projectName}/${entry.createDate.day}:${entry.createDate.month}:${entry.createDate.year}',
    //       )
    //     }));
    log('is created file not empty? -> ${formDataList.isNotEmpty}');
    final json = {
      'projectID': entry.projectID,
      'createDate': entry.createDate.toIso8601String(),
      'imageUrl': formDataList,
      'description': entry.description,
    };
    try {
      final response = await http.post(createUri, data: json);
      if (response.statusCode == 200) {
        // TODO: when is possible catch response and load it on State or update some values
        // final data = json.decode(response.data);
        //TODO: send images to API
        http.put(updateUri, data: formDataList);
        log('request was successful-> ${response.data}');
      } else {
        log('statuscode: ${response.statusCode}  backend returned: ${response.data}');
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
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

// TODO: can update single project not the whole project api doesent fit gui
  // Future<bool> updateProjectOverView(ProjectOverview project) async {
  //   final Dio dio = Dio();
  //   final url = const DbAdress().updateProjectEntry;
  //   try {
  //     final response = await dio.put(url, data: project.toJson());
  //     if (response.statusCode == 200) {
  //       return true;
  //     }
  //     log('something went Wrong: ${response.data}');
  //     return false;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
