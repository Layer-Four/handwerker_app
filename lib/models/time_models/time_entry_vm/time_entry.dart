import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_entry.freezed.dart';
part 'time_entry.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    required DateTime date,
    String? customerName,
    int? type,
    int? duration,
    String? description,
    DateTime? endTime,
    int? id,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? projectID,
    String? projektTitle,
    int? serviceID,
    String? serviceTitle,
    DateTime? startTime,
    String? userID,
  }) = _TimeEntry;

  const TimeEntry._();
  String getDurationInHours() {
    if (duration == null) return '';
    final hours = duration! ~/ 60;
    final minutes = duration! % 60;
    if (minutes < 10) return '$hours:0$minutes';
    return '$hours:$minutes';
  }

  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
}

/// this enum represent the different status of an TimeEntry.
///
enum TimeEntryType {
  timeEntry,
  assignment,
  onHold,
  waiting,
}

extension TimeEntryTypeExtention on TimeEntryType {
  int get index => switch (this) {
        TimeEntryType.timeEntry => 0,
        TimeEntryType.assignment => 1,
        TimeEntryType.onHold => 2,
        TimeEntryType.waiting => 3,
      };
}
