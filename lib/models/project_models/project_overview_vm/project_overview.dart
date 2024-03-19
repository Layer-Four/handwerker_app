import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handwerker_app/models/project_models/project_overview_vm/project_time/project_day.dart';
part 'project_overview.freezed.dart';
part 'project_overview.g.dart';

@freezed
abstract class ProjectOverview with _$ProjectOverview {
  const factory ProjectOverview({
    required int customerID,
    String? customerName,
    @Default(false) bool hasDocumentations,
    // @Default(<ProjectMaterialVM>[]) List<ProjectMaterialVM> materialViewModels,
    @Default([]) List materialViewModels,
    required DateTime projectCreated,
    required int projectID,
    @Default([]) List projectMaterials,
    String? projectName,
    @Default(<ProjectTimeVM>[]) List<ProjectTimeVM> timeViewModels,
  }) = _ProjectOverView;
  const ProjectOverview._();

  factory ProjectOverview.fromJson(Map<String, dynamic> json) => _$ProjectOverviewFromJson(json);
}
