import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/project_models/dokumentation_models/documentation_entry.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

final documentationProvider =
    AsyncNotifierProvider<ProjectNotifer, List<DocumentationEntry>?>(() => ProjectNotifer());

class ProjectNotifer extends AsyncNotifier<List<DocumentationEntry>?> {
  @override
  List<DocumentationEntry>? build() => null;

  void createDocumentationEntry(DocumentationEntry entry) async {
    final createUri = const DbAdresses().postDocumentationEntry;

    final Dio http = Dio();
    final xFileList = [];

    for (var path in entry.imageUrl) {
      final xfile = XFile(path,
          name:
              '${entry.projectName}/${entry.createDate.day}:${entry.createDate.month}:${entry.createDate.year}');
      xFileList.add(xfile);
    }

    FormData formData = FormData.fromMap({
      'projectID': entry.projectID,
      'createDate': entry.createDate.toIso8601String(),
      'description': entry.description,
    });
    for (var i = 0; i < xFileList.length; i++) {
      final XFile file = xFileList[i];
      try {
        // final bytes = await file.openRead();
        // final bytes = await file.readAsBytes();

        final multiPartFile = MultipartFile.fromFileSync(
          file.path,
          filename: file.name,
          contentType: MediaType('image', 'jpeg'),
        );
        log(multiPartFile.contentType.toString());
        // frommBytes(bytes, filename: file.name);
        formData.files.add(MapEntry('imageUrl${i == 0 ? "" : i}', multiPartFile));
      } catch (e) {
        log('Error reading file: $e');
      }
    }
    log(formData.fields.toString() + formData.files.toString());

    try {
      final response = await http.post(createUri, data: formData);
      if (response.statusCode == 200) {
        // TODO: when is possible catch response and load it on State or update some values
        // final data = json.decode(response.data);
        log('request was successful-> ${response.data}');
      } else {
        log('statuscode: ${response.statusCode}  backend returned: ${response.data}');
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
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
