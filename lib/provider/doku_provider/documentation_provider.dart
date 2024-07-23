import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/dokumentation_models/documentation_entry/documentation_entry.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

final documentationProvider =
    AsyncNotifierProvider<ProjectNotifer, List<DocumentationEntry>?>(() => ProjectNotifer());

class ProjectNotifer extends AsyncNotifier<List<DocumentationEntry>?> {
  final Api _api = Api();
  @override
  List<DocumentationEntry>? build() => null;

  void createDocumentationEntry(DocumentationEntry entry) async {
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
      final response = await _api.postDocumentationEntry(formData);
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return;
        }

        log('statuscode: ${response.statusCode}, backend returned: ${response.data}');
        return;
      }
      log('request was successful-> ${response.data}');
      return;
    } catch (e) {
      if (e.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('message');
        return;
      }
      log('request was incompleted this was the error: $e');
    }
  }
}
