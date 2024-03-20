import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';

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

    //TODO: change List of File paths to list of FormData
    final json = entry.toJson();
    final Dio http = Dio();

    try {
      final response = await http.post(const DbAdress().postProjectConsumable, data: json);
      if (response.statusCode == 200) {
        // final jsonResponse = response.data;
        log('request success');
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
      }
    } catch (e) {
      log('request was incompleted this was the error: $e');
    }
  }
}
