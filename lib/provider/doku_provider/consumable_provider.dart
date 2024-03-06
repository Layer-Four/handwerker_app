import 'dart:developer';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/consumable/consumable.dart';

final consumableProvider =
    NotifierProvider<ConsumableNotifier, List<Consumable>>(() => ConsumableNotifier());

class ConsumableNotifier extends Notifier<List<Consumable>> {
  @override
  List<Consumable> build() => [];
  void addConsumable(Consumable consumable) => state = [...state, consumable];

  void uploadConsumableEntry(Consumable entry) async {
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

    const baseUri = 'https://www.azure.de/';
    final uri = Uri.http('nutzer123', '${baseUri}zeiteintrag-speicherung');
    //TODO: change List of File paths to list of FormData
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
