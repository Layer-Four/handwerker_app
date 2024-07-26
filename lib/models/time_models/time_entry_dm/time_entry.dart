import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/time_models/time_entries_vm/time_entries_vm.dart';
part 'time_entry.freezed.dart';
part 'time_entry.g.dart';

@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    @Default('') String customerName,
    required DateTime date,
    String? description,
    int? duration,
    DateTime? endTime,
    int? id,
    DateTime? pauseEnd,
    DateTime? pauseStart,
    int? projectID,
    String? projektTitle,
    int? serviceID,
    String? serviceTitle,
    required DateTime startTime,
    @Default(0) int type,
    String? userID,
  }) = _TimeEntry;

  const TimeEntry._();

  factory TimeEntry.fromTimeEntriesVM(TimeEntriesVM e) => TimeEntry(
        customerName: e.customerName!,
        date: e.date!,
        description: e.description,
        duration: e.duration,
        endTime: e.endTime,
        id: e.id,
        pauseEnd: e.pauseEnd,
        pauseStart: e.pauseStart,
        projectID: e.projectID,
        projektTitle: e.projektTitle,
        serviceID: e.serviceID,
        serviceTitle: e.serviceTitle,
        startTime: e.startTime!,
        type: e.type.index,
        userID: e.userID,
      );

  factory TimeEntry.fromJson(Map<String, dynamic> json) => _$TimeEntryFromJson(json);
}
