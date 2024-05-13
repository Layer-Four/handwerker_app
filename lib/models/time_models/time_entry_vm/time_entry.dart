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
    // TODO:update with own id
    @Default('') String userID,
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
// 0= zeiterfassung
// 1= auftrag