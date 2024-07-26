// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documentation_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentationEntryImpl _$$DocumentationEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentationEntryImpl(
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      description: json['description'] as String?,
      projectID: (json['projectID'] as num?)?.toInt(),
      signature: json['signature'] as String?,
      imageUrl: (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$DocumentationEntryImplToJson(
        _$DocumentationEntryImpl instance) =>
    <String, dynamic>{
      'createDate': instance.createDate?.toIso8601String(),
      'description': instance.description,
      'projectID': instance.projectID,
      'signature': instance.signature,
      'imageUrl': instance.imageUrl,
    };
