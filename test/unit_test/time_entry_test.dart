import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/models/service_models/service_list_vm/service_list.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';

void main() {
  List<TimeEntriesVM> sortEntries(List<TimeEntriesVM> list) {
    list.sort((a, b) => a.startTime!.compareTo(b.startTime!));
    return list;
  }

  final DateTime date = DateTime(2024, 03, 05);
  final DateTime start = DateTime(2024, 03, 05, 13, 05);
  final DateTime end = DateTime(2024, 03, 05, 15, 15);
  const ProjectShortVM costumer = ProjectShortVM(id: 5, title: 'Meier/ Bad verfliesen');
  const ServiceListVM service = ServiceListVM(
    name: 'Bad verfliesen',
    id: 7,
    hourlyRate: 0.0,
  );
  const String description = '';
  group('create entry', () {
    final TimeEntriesVM testEntry = TimeEntriesVM(
      date: date,
      startTime: start,
      endTime: end,
      projectID: costumer.id,
      serviceID: service.id,
      serviceTitle: service.name,
      description: description,
    );
    test('valiaded Data', () {
      expect(testEntry.date, date);
      expect(testEntry.startTime!.isBefore(testEntry.endTime!), true);
      expect(testEntry.description, description);
      expect(testEntry.serviceTitle, service.name);
      expect(testEntry.endTime != null, true);
    });
  });
  group('laod entries and sorted', () {
    final newstate = List.generate(
      10,
      (index) => TimeEntriesVM(
        date: DateTime(2024, Random().nextInt(13), Random().nextInt(31)),
        startTime: DateTime(2024, Random().nextInt(13), Random().nextInt(31), Random().nextInt(25),
            Random().nextInt(61)),
      ),
    );
    final x = sortEntries(newstate);
    test('check if a before b', () {
      expect(
          x[0].startTime!.millisecondsSinceEpoch <= x[1].startTime!.millisecondsSinceEpoch, true);
      expect(
          x[3].startTime!.millisecondsSinceEpoch <= x[4].startTime!.millisecondsSinceEpoch, true);
      expect(
          x[9].startTime!.millisecondsSinceEpoch <= x[9].startTime!.millisecondsSinceEpoch, true);
      expect(
          x[8].startTime!.millisecondsSinceEpoch <= x[9].startTime!.millisecondsSinceEpoch, true);
      expect(
          x[7].startTime!.millisecondsSinceEpoch <= x[5].startTime!.millisecondsSinceEpoch, false);
      expect(
          x[0].startTime!.millisecondsSinceEpoch <= x[9].startTime!.millisecondsSinceEpoch, true);
    });
  });
}
