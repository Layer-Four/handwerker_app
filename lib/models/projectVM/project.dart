import 'package:freezed_annotation/freezed_annotation.dart';
part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    String? projectID,
    String? name,
    required DateTime createDate,
    @Default(<String>[]) List<String> dokusPath,
    String? description,
  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
