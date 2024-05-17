import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/time_models/time_entry_dm/time_entry.dart';

part 'time_entries_vm.freezed.dart';
part 'time_entries_vm.g.dart';

@freezed
class TimeEntriesVM with _$TimeEntriesVM {
  const factory TimeEntriesVM({
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
    @Default(TimeEntryType.workOrder) TimeEntryType type,
    String? userID,
  }) = _TimeEntriesVM;
  factory TimeEntriesVM.fromJson(Map<String, dynamic> json) => _$TimeEntriesVMFromJson(json);
  const TimeEntriesVM._();
  factory TimeEntriesVM.fromTimeEntryDM(TimeEntry e) => TimeEntriesVM(
        customerName: e.customerName,
        date: e.date,
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
        startTime: e.startTime,
        type: TimeEntryTypeExtention.getType(e.type),
        userID: e.userID,
      );

  String getDurationInHours() {
    if (duration == null) return '';
    final hours = duration! ~/ 60;
    final minutes = duration! % 60;
    if (minutes < 10) return '$hours:0$minutes';
    return '$hours:$minutes';
  }
}

enum TimeEntryType {
  timeEntry,
  workOrder,
}

extension TimeEntryTypeExtention on TimeEntryType {
  int get index => switch (this) {
        TimeEntryType.timeEntry => 0,
        TimeEntryType.workOrder => 1,
      };
  static TimeEntryType getType(int index) => switch (index) {
        1 => TimeEntryType.workOrder,
        _ => TimeEntryType.timeEntry,
      };
}
