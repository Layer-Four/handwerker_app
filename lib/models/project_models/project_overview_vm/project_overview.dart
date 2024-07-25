import 'package:freezed_annotation/freezed_annotation.dart';

import '../../consumable_models/material_vm/material_vm.dart';
import 'project_time/project_day.dart';
part 'project_overview.freezed.dart';
part 'project_overview.g.dart';

@freezed
abstract class ProjectOverview with _$ProjectOverview {
  const factory ProjectOverview({
    required int customerID,
    String? customerName,
    @Default(false) bool hasDocumentations,
    @Default(<ConsumeableVM>[]) List<ConsumeableVM> materialViewModels,
    // @Default([]) List materialViewModels,
    required DateTime projectCreated,
    required int projectID,
    // @Default([]) List projectMaterials,
    String? projectName,
    @Default(<ProjectTimeVM>[]) List<ProjectTimeVM> timeViewModels,
  }) = _ProjectOverView;
  const ProjectOverview._();

  factory ProjectOverview.fromJson(Map<String, dynamic> json) => _$ProjectOverviewFromJson(json);
}
