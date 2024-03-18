// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectOverViewImpl _$$ProjectOverViewImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectOverViewImpl(
      title: json['title'] as String,
      dateOfTermination: DateTime.parse(json['dateOfTermination'] as String),
      projectMaterials: json['projectMaterials'] as List<dynamic>? ?? const [],
      userProjectDays: (json['userProjectDays'] as List<dynamic>?)
              ?.map((e) => UserProjectDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserProjectDay>[],
    );

Map<String, dynamic> _$$ProjectOverViewImplToJson(
        _$ProjectOverViewImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateOfTermination': instance.dateOfTermination.toIso8601String(),
      'projectMaterials': instance.projectMaterials,
      'userProjectDays': instance.userProjectDays,
    };
