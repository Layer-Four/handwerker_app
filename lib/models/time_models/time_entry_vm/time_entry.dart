import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_entry.freezed.dart';
part 'time_entry.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    String? customerName,
    required DateTime date,
    int? duration,
    String? description,
    DateTime? endTime,
    int? id,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? projectID,
    int? serviceID,
    String? serviceTitle,
    required DateTime startTime,
    @Default('f7e8b09a-ac4f-4a30-a7c5-b6f829cff9aa') String userID,
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
