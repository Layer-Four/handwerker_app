import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_day.freezed.dart';
part 'project_day.g.dart';

@freezed
class ProjectTimeVM with _$ProjectTimeVM {
  const factory ProjectTimeVM({
    required String durationTotal,
    required DateTime end,
    required BigInt serviceID,
    required String servciceName,
    required DateTime start,
  }) = _ProjectTimeVM;

  const ProjectTimeVM._();
  factory ProjectTimeVM.fromJson(Map<String, dynamic> json) => _$ProjectTimeVMFromJson(json);
}
