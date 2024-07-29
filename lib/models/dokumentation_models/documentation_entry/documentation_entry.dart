import 'package:freezed_annotation/freezed_annotation.dart';

part 'documentation_entry.freezed.dart';
part 'documentation_entry.g.dart';

@freezed
class DocumentationEntry with _$DocumentationEntry {
  const factory DocumentationEntry({
    DateTime? createDate,
    String? description,
    // int? id,
    int? projectID,
    // String? projectName,
    String? signature,
    @Default(<String>[]) List<String> imageUrl,
  }) = _DocumentationEntry;
  factory DocumentationEntry.fromJson(Map<String, dynamic> json) =>
      _$DocumentationEntryFromJson(json);
}
