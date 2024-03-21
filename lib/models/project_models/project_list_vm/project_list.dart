import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_list.freezed.dart';
part 'project_list.g.dart';

@freezed
class ProjectListVM with _$ProjectListVM {
  const factory ProjectListVM({
    required int id,
    required String title,
  }) = _ProjectListVM;

  factory ProjectListVM.fromJson(Map<String, dynamic> json) => _$ProjectListVMFromJson(json);
}
