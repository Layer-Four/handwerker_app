import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_day.freezed.dart';
part 'project_day.g.dart';

@freezed
abstract class ProjectTimeVM with _$ProjectTimeVM {
  const factory ProjectTimeVM({
    int? durationTotal,
    required DateTime end,
    int? serviceID,
    String? serviceName,
    required DateTime start,
  }) = _ProjectTimeVM;

  const ProjectTimeVM._();
  factory ProjectTimeVM.fromJson(Map<String, dynamic> json) => _$ProjectTimeVMFromJson(json);
}
