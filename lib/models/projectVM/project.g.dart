// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      projectID: json['projectID'] as String?,
      name: json['name'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      dokusPath: (json['dokusPath'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'projectID': instance.projectID,
      'name': instance.name,
      'createDate': instance.createDate.toIso8601String(),
      'dokusPath': instance.dokusPath,
      'description': instance.description,
    };
