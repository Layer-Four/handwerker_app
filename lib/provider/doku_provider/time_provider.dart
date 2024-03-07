import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:handwerker_app/models/time_entry/time_entry.dart';

final timeEntryProvider =
    NotifierProvider<TimeEntryNotifier, List<TimeEntry?>>(() => TimeEntryNotifier());

class TimeEntryNotifier extends Notifier<List<TimeEntry?>> {
  @override
  build() => [];

  void addTimeEntry(TimeEntry entry) => state = [...state, entry];

  // TODO: write request provider for encaplusalted logic
  void uploadTimeEntry(TimeEntry entry) async {
    const baseUri = 'https://www.azure.de/';
    final uri = Uri.http('nutzer123', '${baseUri}zeiteintrag-speicherung');
    final json = {
      'username': 'marten.meissern',
      'password': 'abc.123',
    };
    // entry.toJson();
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
