import 'package:freezed_annotation/freezed_annotation.dart';
part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class ProjectVM with _$ProjectVM {
  const factory ProjectVM({
    required int id,
    required String title,
  }) = _ProjectVM;

  factory ProjectVM.fromJson(Map<String, dynamic> json) => _$ProjectVMFromJson(json);
}
