import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_entry.freezed.dart';
part 'time_entry.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    required DateTime date,
    int? duration,
    String? description,
    DateTime? endTime,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    String? projectID,
    String? service,
    required DateTime startTime,
    String? userID,
  }) = _TimeEntry;

  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
}
