import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:http/http.dart' as http;
import 'package:handwerker_app/models/time_dm/time_entry.dart';

final timeEntryProvider =
    NotifierProvider<TimeEntryNotifier, List<TimeEntry?>>(() => TimeEntryNotifier());

class TimeEntryNotifier extends Notifier<List<TimeEntry?>> {
  @override
  build() => [];

  void addTimeEntry(TimeEntry entry) => state = [...state, entry];

  // TODO: write request provider for encaplusalted logic
  void uploadTimeEntry(TimeEntry entry) async {
    final uri = const DbAdress().postTimeEnty;
    try {
      final response = await http.post(uri, body: json.encode(entry.toJson()));
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
