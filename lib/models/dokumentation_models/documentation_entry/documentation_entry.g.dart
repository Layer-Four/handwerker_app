// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documentation_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentationEntryImpl _$$DocumentationEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentationEntryImpl(
      id: (json['id'] as num?)?.toInt(),
      projectID: (json['projectID'] as num?)?.toInt(),
      projectName: json['projectName'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      imageUrl: (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$DocumentationEntryImplToJson(
        _$DocumentationEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectID': instance.projectID,
      'projectName': instance.projectName,
      'createDate': instance.createDate.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
