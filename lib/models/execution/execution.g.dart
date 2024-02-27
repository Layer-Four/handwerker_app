// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExecutionImpl _$$ExecutionImplFromJson(Map<String, dynamic> json) =>
    _$ExecutionImpl(
      executionID: json['executionID'] as String?,
      project: json['project'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      service: json['service'] as String?,
      consumables: (json['consumables'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      descritpion: json['descritpion'] as String?,
    );

Map<String, dynamic> _$$ExecutionImplToJson(_$ExecutionImpl instance) =>
    <String, dynamic>{
      'executionID': instance.executionID,
      'project': instance.project,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'service': instance.service,
      'consumables': instance.consumables,
      'users': instance.users,
      'descritpion': instance.descritpion,
    };
