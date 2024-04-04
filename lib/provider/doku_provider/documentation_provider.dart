import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/dokumentation_models/documentation_entry/documentation_entry.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

final documentationProvider =
    AsyncNotifierProvider<ProjectNotifer, List<DocumentationEntry>?>(() => ProjectNotifer());

class ProjectNotifer extends AsyncNotifier<List<DocumentationEntry>?> {
  final Api api = Api();
  @override
  List<DocumentationEntry>? build() => null;

  void createDocumentationEntry(DocumentationEntry entry) async {
    // final createUri = DbAdresses().postDocumentationEntry;

    // final Dio http = Dio();
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
        final multiPartFile = MultipartFile.fromFileSync(
          file.path,
          filename: file.name,
          contentType: MediaType('image', 'jpeg'),
        );
        formData.files.add(MapEntry('imageUrl${i == 0 ? "" : i}', multiPartFile));
      } catch (e) {
        log('Error reading file: $e');
      }
    }

    try {
      // final response = await http.post(createUri, data: formData);
      final response = await api.postDocumentationEntry(formData);
      if (response.statusCode != 200) {
        // TODO: when is possible catch response and load it on State or update some values
        log('statuscode: ${response.statusCode}  backend returned: ${response.data}');
        return;
      }
      log('request was successful-> ${response.data}');
      return;
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }
}
