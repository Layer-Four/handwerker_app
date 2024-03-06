import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/time_entry/time_entry.dart';
import 'package:handwerker_app/provider/doku_provider/dokumentation_provider.dart';
import 'package:test/test.dart';

void main() {
  final String date = DateTime(2024, 03, 05, 13, 05).toIso8601String();
  final String start = date;
  final String end = DateTime(2024, 03, 05, 15, 15).toIso8601String();
  const String costumer = ' Meier/ Bad verfliesen';
  const String service = 'Bad fliesen';
  const String material = ' Fliesen';
  const String description = '';
  test('valiaded Data', () {
    expect(date, start);
    expect(DateTime.parse(end).isAfter(DateTime.parse(start)), true);
    expect(material, ' Fliesen');
    expect(costumer, ' Meier/ Bad verfliesen');
    expect(service, 'Bad fliesen');
    expect(description, '');
  });
  test('load data in mockProvider', () {
    final mockProvider = NotifierProvider<InputNotifier, List<TimeEntry?>>(
      () => InputNotifier(),
    );
    final container = ProviderContainer();
    addTearDown(() => container.dispose());
    container.listen(mockProvider, (previous, next) {});
  });
}
