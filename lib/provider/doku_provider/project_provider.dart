import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:handwerker_app/models/projectVM/project.dart';

final projectProvider = NotifierProvider<ProjectNotifer, List<Project>>(() => ProjectNotifer());

class ProjectNotifer extends Notifier<List<Project>> {
  @override
  List<Project> build() => [];
  void addProject(Project project) => state = [...state, project];

  // TODO: write request provider for encaplusalted logic
  void uploadProjectEntry(Project entry) async {
    const baseUri = 'https://www.azure.de/';
    final uri = Uri.http('nutzer123', '${baseUri}zeiteintrag-speicherung');
    final json = entry.toJson();
    try {
      final response = await http.post(uri, body: json);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        log('request success, this was the response: $jsonResponse');
      } else {
        throw 'statuscode: ${response.statusCode}';
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }
}
