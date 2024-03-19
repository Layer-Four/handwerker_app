import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_entry.freezed.dart';
part 'project_entry.g.dart';

@freezed
class ProjectEntry with _$ProjectEntry {
  const factory ProjectEntry({
    int? projectID,
    int? customerID,
    required String customerName,
    String? projectName,
    required DateTime createDate,
    @Default(<String>[]) List<String> imageUrl,
    String? description,
  }) = _ProjecEntryt;
  factory ProjectEntry.fromJson(Map<String, dynamic> json) => _$ProjectEntryFromJson(json);
}
