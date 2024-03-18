import 'package:handwerker_app/models/time_models/time_entry.dart';

class Workday {
  final DateTime date;
  final List<TimeEntry> timeEntries;
  const Workday({required this.date, required this.timeEntries});

  String getSumOfToday() {
    if (timeEntries.isEmpty) return '0 Stunden';
    int sum = 0;
    for (var i in timeEntries) {
      assert(i.duration != null);
      sum += i.duration!;
    }
    if (sum < 60) return '$sum Minuten';

    final hours = sum ~/ 60;
    final minutes = sum % 60;
    if (minutes < 10) return '$hours:0$minutes Stunden';
    return '$hours:$minutes Stunden';
  }
}
