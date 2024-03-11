import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required BigInt projectID,
    required BigInt customerID,
    required String customerName,
    String? projectName,
    required DateTime createDate,
    @Default(<String>[]) List<String> imageUrl,
    String? description,
  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
