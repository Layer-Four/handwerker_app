import 'package:freezed_annotation/freezed_annotation.dart';
part 'documentation_dm.freezed.dart';
part 'documentation_dm.g.dart';

@freezed
class DocumentationDM with _$DocumentationDM {
  const factory DocumentationDM({
    String? description,
    @Default(<String>[]) List<String> imagesUrl,
  }) = _DocumentationDM;

  const DocumentationDM._();

  factory DocumentationDM.fromJson(Map<String, dynamic> json) => _$DocumentationDMFromJson(json);
}
