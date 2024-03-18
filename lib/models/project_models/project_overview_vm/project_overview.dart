import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_day.dart';
part 'project_overview.freezed.dart';
part 'project_overview.g.dart';

@freezed
class ProjectOverview with _$ProjectOverview {
  const factory ProjectOverview({
    required String title,
    required DateTime dateOfTermination,
    @Default([]) List projectMaterials,
    @Default(<UserProjectDay>[]) List<UserProjectDay> userProjectDays,
  }) = _ProjectOverView;
  const ProjectOverview._();

  factory ProjectOverview.fromJson(Map<String, dynamic> json) => _$ProjectOverviewFromJson(json);
}
