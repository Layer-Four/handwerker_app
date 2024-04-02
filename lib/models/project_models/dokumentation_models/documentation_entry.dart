import 'package:freezed_annotation/freezed_annotation.dart';

part 'documentation_entry.freezed.dart';
part 'documentation_entry.g.dart';

@freezed
class DocumentationEntry with _$DocumentationEntry {
  const factory DocumentationEntry({
    int? id,
    int? projectID,
    String? projectName,
    required DateTime createDate,
    @Default(<String>[]) List<String> imageUrl,
    String? description,
  }) = _DocumentationEntry;
  factory DocumentationEntry.fromJson(Map<String, dynamic> json) =>
      _$DocumentationEntryFromJson(json);
}
