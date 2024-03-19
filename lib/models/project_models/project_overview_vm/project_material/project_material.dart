import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_material.freezed.dart';
part 'project_material.g.dart';

@freezed
class ProjectMaterialVM with _$ProjectMaterialVM {
  const factory ProjectMaterialVM() = _ProjectMaterialVM;

  const ProjectMaterialVM._();
  factory ProjectMaterialVM.fromJson(Map<String, dynamic> json) =>
      _$ProjectMaterialVMFromJson(json);
}
