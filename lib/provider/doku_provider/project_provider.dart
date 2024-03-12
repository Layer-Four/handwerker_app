import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/project_models/project_vm/project.dart';
import 'package:http/http.dart' as http;
import 'package:handwerker_app/models/project_models/project_dm/project_entry.dart';

final projectProvider =
    AsyncNotifierProvider<ProjectNotifer, List<ProjectVM>?>(() => ProjectNotifer());

class ProjectNotifer extends AsyncNotifier<List<ProjectVM>?> {
  @override
  List<ProjectVM>? build() => null;

  void loadpProject() async {
    final uri = const DbAdress().projects;
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final projects = data.map<ProjectVM>((e) => ProjectVM.fromJson(e)).toList();
        state = AsyncValue.data(projects);
      }
      if (response.statusCode != 200) {
        log('request dismissed statuscode: ${response.statusCode}');
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
    return;
  }

  // TODO: write request provider for encaplusalted logic
  void uploadProjectEntry(ProjectEntry entry) async {
    // * var request = new http.MultipartRequest("POST", url);
    // * request.fields['user'] = 'someone@somewhere.com';
    // * request.files.add(http.MultipartFile.fromPath(
    // *     'package',
    // *     'build/package.tar.gz',
    // *     contentType: new MediaType('application', 'x-tar'),
    // * ));
    // * request.send().then((response) {
    // *   if (response.statusCode == 200) print("Uploaded!");
    // * });
    // * FormData formData = new FormData.from({
    // *   "name": "wendux",
    // *   "file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")
    // * });
    // * response = await dio.post("/info", data: formData)

    //TODO: change List of File paths to list of FormData

    try {
      final response = await http.post(Uri.base, body: entry.toJson());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log('request success, this was the response: $data');
      } else {
        throw 'statuscode: ${response.statusCode}';
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }
}
