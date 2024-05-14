import 'package:flutter_test/flutter_test.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/models/service_models/service_list_vm/service_list.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';

void main() {
  final DateTime date = DateTime(2024, 03, 05);
  final DateTime start = DateTime(2024, 03, 05, 13, 05);
  final DateTime end = DateTime(2024, 03, 05, 15, 15);
  const ProjectListVM costumer = ProjectListVM(id: 5, title: 'Meier/ Bad verfliesen');
  const ServiceListVM service = ServiceListVM(name: 'Bad verfliesen', id: 7);
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

    // test('load data in mockProvider', () {
    //   final mockProvider = NotifierProvider<TimeEntryNotifier, List<TimeEntry?>>(
    //     () => TimeEntryNotifier(),
    //   );
    //   final container = ProviderContainer();
    //   addTearDown(() => container.dispose());
    //   container.read(mockProvider);
    // });
  });
}
